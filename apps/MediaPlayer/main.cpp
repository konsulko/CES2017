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

#include <QtCore/QDebug>
#include <QtCore/QDir>
#include <QtCore/QStandardPaths>
#include <QtGui/QGuiApplication>
#include <QtQml/QQmlApplicationEngine>
#include <QtQml/QQmlContext>
#include <QtQml/qqml.h>
#include <QtQuickControls2/QQuickStyle>

#ifdef HAVE_LIBHOMESCREEN
#include <libhomescreen.hpp>
#endif

#include "playlistwithmetadata.h"

int main(int argc, char *argv[])
{
#ifdef HAVE_LIBHOMESCREEN
    LibHomeScreen libHomeScreen;

    if (!libHomeScreen.renderAppToAreaAllowed(0, 1)) {
        qWarning() << "renderAppToAreaAllowed is denied";
        return -1;
    }
#endif

    QGuiApplication app(argc, argv);

    QQuickStyle::setStyle("AGL");

    qmlRegisterType<PlaylistWithMetadata>("MediaPlayer", 1, 0, "PlaylistWithMetadata");

    QVariantList mediaFiles;
    for (const auto &music : QStandardPaths::standardLocations(QStandardPaths::MusicLocation)) {
        QDir dir(music);
        for (const auto &file : dir.entryList(QStringList(), QDir::Files, QDir::Name)) {
            mediaFiles.append(QUrl::fromLocalFile(dir.absoluteFilePath(file)));
        }
    }

    QQmlApplicationEngine engine;
    QQmlContext *context = engine.rootContext();
    context->setContextProperty("mediaFiles", mediaFiles);
    engine.load(QUrl(QStringLiteral("qrc:/MediaPlayer.qml")));

    return app.exec();
}

