/*
 * Copyright (C) 2016 The Qt Company Ltd.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#include "playlistwithmetadata.h"

#include <QtCore/QDebug>
#include <QtCore/QBuffer>
#include <QtGui/QImage>
#include <QtGui/QImageWriter>
#include <QtMultimedia/QMediaPlayer>
#include <QtMultimedia/QMediaMetaData>

class PlaylistWithMetadata::Private
{
public:
    Private(PlaylistWithMetadata *parent);

    void disconnect();
    void connect();

private:
    void loadMetadata(int row);

private:
    PlaylistWithMetadata *q;

public:
    QAbstractListModel *source;
    QList<QMetaObject::Connection> connections;
    QList<QUrl> urls;
    QHash<QUrl, QString> title;
    QHash<QUrl, QString> artist;
    QHash<QUrl, QUrl> coverArt;
    QHash<QUrl, qint64> duration;
    QHash<QUrl, QMediaPlayer *> players;
};

PlaylistWithMetadata::Private::Private(PlaylistWithMetadata *parent)
    : q(parent)
    , source(nullptr)
{
}

void PlaylistWithMetadata::Private::disconnect()
{
    if (source) {
        for (const auto &connection : connections)
            q->disconnect(connection);
        connections.clear();
    }
}

void PlaylistWithMetadata::Private::connect()
{
    if (source) {
        connections.append(q->connect(source, &QAbstractListModel::rowsAboutToBeInserted, [&](const QModelIndex &parent, int first, int last) {
            Q_UNUSED(parent)
            q->beginInsertRows(QModelIndex(), first, last);
        }));
        connections.append(q->connect(source, &QAbstractListModel::rowsInserted, [&](const QModelIndex &parent, int first, int last) {
            Q_UNUSED(parent)
            for (int i = first; i <= last; i++) {
                loadMetadata(i);
            }
            q->endInsertRows();
        }));

        int count = source->rowCount();
        if (count > 0) {
            q->beginInsertRows(QModelIndex(), 0, count);
            for (int i = 0; i < count; i++) {
                loadMetadata(i);
            }
            q->endInsertRows();
        }
    }
}

void PlaylistWithMetadata::Private::loadMetadata(int row)
{
    QUrl url = source->data(source->index(row), Qt::UserRole + 1).toUrl();
    QMediaPlayer *player = new QMediaPlayer(q);
    urls.append(url);
    players.insert(url, player);
    q->connect(player, &QMediaPlayer::mediaStatusChanged, [this, url](QMediaPlayer::MediaStatus mediaStatus) {
        switch (mediaStatus) {
        case QMediaPlayer::NoMedia:
        case QMediaPlayer::LoadedMedia: {
            QMediaPlayer *player = players.take(url);
            title.insert(url, player->metaData(QMediaMetaData::Title).toString());
            artist.insert(url, player->metaData(QMediaMetaData::ContributingArtist).toString());
            QVariant coverArtImage = player->metaData(QMediaMetaData::CoverArtImage);
            if (coverArtImage.type() == QVariant::Image) {
                QImage image = coverArtImage.value<QImage>();
                QByteArray data;
                QBuffer buffer(&data);
                buffer.open(QBuffer::WriteOnly);
                QImageWriter png(&buffer, "png");
                if (png.write(image)) {
                    buffer.close();
                    coverArt.insert(url, QUrl(QStringLiteral("data:image/png;base64,") + data.toBase64()));
                }
            }
            duration.insert(url, player->duration());
            QModelIndex index = q->index(urls.indexOf(url));
            q->dataChanged(index, index, QVector<int>() << TitleRole << ArtistRole << CoverArtRole << DurationRole);
            player->deleteLater();
            break; }
        default:
            break;
        }

    });
    player->setMedia(url);
}

PlaylistWithMetadata::PlaylistWithMetadata(QObject *parent)
    : QAbstractListModel(parent)
    , d(new Private(this))
{
}

PlaylistWithMetadata::~PlaylistWithMetadata()
{
    delete d;
}

int PlaylistWithMetadata::rowCount(const QModelIndex &parent) const
{
    int ret = 0;
    if (parent.isValid())
        return ret;
    if (d->source)
        ret = d->source->rowCount(QModelIndex());
    return ret;
}

QVariant PlaylistWithMetadata::data(const QModelIndex &index, int role) const
{
    QVariant ret;
    if (!index.isValid())
        return ret;
    int row = index.row();
    if (row < 0 || rowCount() <= row)
        return ret;
    QUrl url = d->urls.at(row);
    switch (role) {
    case TitleRole:
        ret = d->title.value(url);
        break;
    case ArtistRole:
        ret = d->artist.value(url);
        break;
    case CoverArtRole:
        ret = d->coverArt.value(url);
        break;
    case SourceRole:
        ret = url;
        break;
    case DurationRole:
        ret = d->duration.value(url);
        break;
    default:
        qWarning() << role;
    }

    return ret;
}

QHash<int, QByteArray> PlaylistWithMetadata::roleNames() const
{
    return {
        {TitleRole, "title"},
        {ArtistRole, "artist"},
        {CoverArtRole, "coverArt"},
        {SourceRole, "source"},
        {DurationRole, "duration"}
    };
}

QAbstractListModel *PlaylistWithMetadata::source() const
{
    return d->source;
}

void PlaylistWithMetadata::setSource(QAbstractListModel *source)
{
    if (d->source == source) return;
    d->disconnect();
    d->source = source;
    d->connect();
    emit sourceChanged(source);
}
