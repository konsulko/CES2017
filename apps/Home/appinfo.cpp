/*
 * Copyright (C) 2016 Mentor Graphics Development (Deutschland) GmbH
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

#include "appinfo.h"

#include <QtCore/QJsonObject>

class AppInfo::Private : public QSharedData
{
public:
    Private();
    Private(const Private &other);

    QString id;
    QString version;
    int width;
    int height;
    QString name;
    QString description;
    QString shortname;
    QString author;
    QString iconPath;
};

AppInfo::Private::Private()
    : width(-1)
    , height(-1)
{
}

AppInfo::Private::Private(const Private &other)
    : QSharedData(other)
    , id(other.id)
    , version(other.version)
    , width(other.width)
    , height(other.height)
    , name(other.name)
    , description(other.description)
    , shortname(other.shortname)
    , author(other.author)
    , iconPath(other.iconPath)
{
}

AppInfo::AppInfo()
    : d(new Private)
{
}

AppInfo::AppInfo(const QString &icon, const QString &name)
    : d(new Private)
{
    d->iconPath = icon;
    d->name = name;
}

AppInfo::AppInfo(const AppInfo &other)
    : d(other.d)
{
}

AppInfo::~AppInfo()
{
}

AppInfo &AppInfo::operator =(const AppInfo &other)
{
    d = other.d;
    return *this;
}

QString AppInfo::id() const
{
    return d->id;
}

QString AppInfo::version() const
{
    return d->version;
}

int AppInfo::width() const
{
    return d->width;
}

int AppInfo::height() const
{
    return d->height;
}

QString AppInfo::name() const
{
    return d->name;
}

QString AppInfo::description() const
{
    return d->description;
}

QString AppInfo::shortname() const
{
    return d->shortname;
}

QString AppInfo::author() const
{
    return d->author;
}

QString AppInfo::iconPath() const
{
    return d->iconPath;
}

void AppInfo::read(const QJsonObject &json)
{
    d->id = json["id"].toString();
    d->version = json["version"].toString();
    d->width = json["width"].toInt();
    d->height = json["height"].toInt();
    d->name = json["name"].toString();
    d->description = json["description"].toString();
    d->shortname = json["shortname"].toString();
    d->author = json["author"].toString();
    d->iconPath = json["iconPath"].toString();
}

QDBusArgument &operator <<(QDBusArgument &argument, const AppInfo &appInfo)
{
    argument.beginStructure();
    argument << appInfo.d->id;
    argument << appInfo.d->version;
    argument << appInfo.d->width;
    argument << appInfo.d->height;
    argument << appInfo.d->name;
    argument << appInfo.d->description;
    argument << appInfo.d->shortname;
    argument << appInfo.d->author;
    argument << appInfo.d->iconPath;
    argument.endStructure();

    return argument;
}

const QDBusArgument &operator >>(const QDBusArgument &argument, AppInfo &appInfo)
{
    argument.beginStructure();
    argument >> appInfo.d->id;
    argument >> appInfo.d->version;
    argument >> appInfo.d->width;
    argument >> appInfo.d->height;
    argument >> appInfo.d->name;
    argument >> appInfo.d->description;
    argument >> appInfo.d->shortname;
    argument >> appInfo.d->author;
    argument >> appInfo.d->iconPath;
    argument.endStructure();
    return argument;
}
