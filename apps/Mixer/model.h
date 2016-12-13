/*
 * Copyright (C) 2016 Konsulko Group
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

#include <pulse/pulseaudio.h>

#ifndef __cplusplus
extern void add_one_control(void *ctx, int, const char *, int, int, int);
#else
extern "C" void add_one_control(void *ctx, int, const char *, int, int, int);

#include <QAbstractListModel>
#include <QStringList>

class PaControlModel;

class PaControl
{
	public:
		PaControl(const quint32 &index, const QString &desc, const quint32 &type, const quint32 &channels, const quint32 &volume);

		quint32 cindex() const;
		QString desc() const;
		quint32 type() const;
		quint32 channels() const;
		quint32 volume() const;
		void setCIndex(const QVariant&);
		void setDesc(const QVariant&);
		void setType(const QVariant&);
		void setChannels(const QVariant&);
		void setVolume(pa_context *, const QVariant&);

	private:
		quint32 m_cindex;
		QString m_desc;
		quint32 m_type;
		quint32 m_channels;
		quint32 m_volume;
};

class PaControlModel : public QAbstractListModel
{
	Q_OBJECT
	public:
		enum PaControlRoles {
			CIndexRole = Qt::UserRole + 1,
			DescRole,
			TypeRole,
			ChannelsRole,
			VolumeRole
		};

		PaControlModel(QObject *parent = 0);

		void addControl(const PaControl &control);

		int rowCount(const QModelIndex &parent = QModelIndex()) const;

		QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const;

		bool setData(const QModelIndex &index, const QVariant &value, int role = Qt::EditRole);

		Qt::ItemFlags flags(const QModelIndex &index) const;

	protected:
		QHash<int, QByteArray> roleNames() const;
	private:
		QList<PaControl> m_controls;
		pa_context *pa_ctx;
};
#endif // __cplusplus
