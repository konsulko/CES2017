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

#ifndef PLAYLISTWITHMETADATA_H
#define PLAYLISTWITHMETADATA_H

#include <QtCore/QAbstractListModel>

class PlaylistWithMetadata : public QAbstractListModel
{
    Q_OBJECT
    Q_PROPERTY(QAbstractListModel *source READ source WRITE setSource NOTIFY sourceChanged)
public:
    PlaylistWithMetadata(QObject *parent = nullptr);
    ~PlaylistWithMetadata();

    enum {
        TitleRole = Qt::DisplayRole
        , ArtistRole = Qt::UserRole + 1
        , CoverArtRole
        , SourceRole
        , DurationRole
    };

    int rowCount(const QModelIndex &parent = QModelIndex()) const override;
    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;
    QHash<int, QByteArray> roleNames() const override;

    QAbstractListModel *source() const;

public slots:
    void setSource(QAbstractListModel *source);

signals:
    void sourceChanged(QAbstractListModel *source);

private:
    class Private;
    Private *d;
};

#endif // PLAYLISTWITHMETADATA_H
