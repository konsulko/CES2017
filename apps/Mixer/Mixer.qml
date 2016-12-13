/*
 * Copyright 2016 Konsulko Group
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

import QtQuick 2.6
import QtQuick.Layouts 1.1
import QtQuick.Controls 2.0
import AGL.Demo.Controls 1.0

ApplicationWindow {
	id: root
	Label { 
		id: title
		font.pixelSize: 48
		text: "AGL Mixer"
		anchors.horizontalCenter: parent.horizontalCenter
	}
	ListView {
		id: listView
		anchors.left: parent.left
		anchors.top: title.bottom
		anchors.margins: 80
		anchors.fill: parent
		model: PaControlsModel
		delegate: ColumnLayout {
			width: parent.width
			spacing: 20
			Image {
				source: './images/GreenLine.svg'
				Layout.fillWidth: true
			}
			Label {
				font.pixelSize: 32
				text: controlDesc
			}
			RowLayout {
				Label {
					font.pixelSize: 32
					text: "0 %"
				}
				Slider {
					id: controlIndex
					value: 50
					to: 100
					Layout.fillWidth: true
				}
				Label {
					font.pixelSize: 32
					text: "100 %"
				}
			}
		}
	}
}
