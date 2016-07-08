/* Copyright (C) 2015, Jaguar Land Rover. All Rights Reserved.
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/. */

import QtQuick 2.0
import system 1.0
import execScript 1.0

Item {
    id: root

    height: 120

    ShaderEffect {
        anchors.fill: parent
        property color color: "#777"
        property real radius: 40
        opacity: 0.24

        fragmentShader: "
uniform lowp float radius;
uniform lowp float height;
uniform lowp float width;
uniform lowp float qt_Opacity;
uniform lowp vec4 color;
varying highp vec2 qt_TexCoord0;

void main(void) {
    lowp vec2 dist = min(qt_TexCoord0, vec2(1.0) - qt_TexCoord0);
    lowp float xval = smoothstep(0.0, radius, dist.x * width);
    lowp float yval = smoothstep(0.0, radius, dist.y * height);
    gl_FragColor = mix(color, vec4(1.0), sqrt(yval * xval)) * qt_Opacity;
}
        "
    }

    property int currentIndex: 0
    property AppIcon currentItem

    Row {
        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset: 5
        anchors.horizontalCenter: parent.horizontalCenter
        spacing: 30

        AppIcon {
            id: homeScreen
            active: currentIndex === 0
            onActiveChanged: if (active) root.currentItem = homeScreen
            property var mainScreen: root.parent
            property bool home: System.activeApp === "home"
            source: home ? "images/agl_icon.png" : "images/homescreen_icon.png"

            onClicked: {
                if (currentIndex === 1) {
                    execscript.execute("./switch_off_navi.sh")
                }
                currentIndex = 0
                System.activeApp = "home"
            }
        }

        AppIcon {
            id: googleMaps
            active: currentIndex === 1
            onActiveChanged: if (active) root.currentItem = googleMaps
            source: "images/googlemaps_app_icon.png"

            onClicked: {
                currentIndex = 1
                System.activeApp = "googlemaps"
                execscript.execute("./switch_on_navi.sh")
            }
        }

        Repeater {
            model: ListModel {
                id: applicationModel
                ListElement { name: "browser" }
                ListElement { name: "dashboard" }
                ListElement { name: "hvac" }
                ListElement { name: "weather" }
                ListElement { name: "fmradio" }
                ListElement { name: "media_player" }
            }

            delegate: AppIcon {
                id: app
                active: currentIndex === model.index + 2
                onActiveChanged: if (active) root.currentItem = app
                source: "images/%1_app_icon.png".arg(model.name)
                onClicked: {
                    if (currentIndex === 1) {
                        execscript.execute("./switch_off_navi.sh")
                    }
                    System.activeApp = model.name
                    currentIndex = model.index + 2
                }

                Rectangle {
                    x: -15.5
                    y: -15
                    height: 123
                    width: 1
                    color: "black"
                }
            }
        }

        AppIcon {
            id: launcher
            active: currentIndex === applicationModel.count + 2
            onActiveChanged: if (active) root.currentItem = launcher
            source: "images/application_grid.png"
            onClicked: {
                if (currentIndex === 1) {
                    execscript.execute("./switch_off_navi.sh")
                }
                System.activeApp = "appgrid"
                currentIndex = applicationModel.count + 2
            }
        }
    }

    property int __appCount: applicationModel.count + 3

    function left() {
        root.currentIndex = (root.currentIndex + root.__appCount - 1) % root.__appCount
    }

    function right() {
        root.currentIndex = (root.currentIndex + 1) % root.__appCount
    }

    function click() {
        currentItem.click()
    }

    function home() {
        homeScreen.click()
    }

    ExecScript { id: execscript }
}
