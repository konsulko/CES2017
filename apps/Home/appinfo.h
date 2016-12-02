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

#ifndef APPINFO_H
#define APPINFO_H

#include <QtCore/QSharedDataPointer>
#include <QtDBus/QDBusArgument>

class AppInfo
{
    Q_GADGET
    Q_PROPERTY(QString id READ id)
    Q_PROPERTY(QString version READ version)
    Q_PROPERTY(int width READ width)
    Q_PROPERTY(int height READ height)
    Q_PROPERTY(QString name READ name)
    Q_PROPERTY(QString description READ description)
    Q_PROPERTY(QString shortname READ shortname)
    Q_PROPERTY(QString author READ author)
    Q_PROPERTY(QString iconPath READ iconPath)
public:
    AppInfo();
    AppInfo(const QString &icon, const QString &name);
    AppInfo(const AppInfo &other);
    virtual ~AppInfo();
    AppInfo &operator =(const AppInfo &other);
    void swap(AppInfo &other) { qSwap(d, other.d); }

    QString id() const;
    QString version() const;
    int width() const;
    int height() const;
    QString name() const;
    QString description() const;
    QString shortname() const;
    QString author() const;
    QString iconPath() const;

    void read(const QJsonObject &json);

    friend QDBusArgument &operator <<(QDBusArgument &argument, const AppInfo &appInfo);
    friend const QDBusArgument &operator >>(const QDBusArgument &argument, AppInfo &appInfo);

private:
    class Private;
    QSharedDataPointer<Private> d;
};

Q_DECLARE_SHARED(AppInfo)
Q_DECLARE_METATYPE(AppInfo)
Q_DECLARE_METATYPE(QList<AppInfo>)

#endif // APPINFO_H
