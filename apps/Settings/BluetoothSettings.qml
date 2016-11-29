/* Copyright (C) 2015, Jaguar Land Rover. All Rights Reserved.
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/. */

import QtQuick 2.0
import system 1.0
import components 1.0
import utils 1.0
import QtQuick.Layouts 1.1
import QtQuick.Controls 1.0
import QtQuick.Controls.Styles 1.0


SettingsView {
    id:bluetoothSettingsView
    name: "bluetooth"
    showTechnologyToggle: true
    property string protocol: 'http://'
    property string ipAddress: '127.0.0.1'
    property string portNumber: '1234'
    property string btAPI: '/api/Bluetooth-manager/'

    property string btAPIpath: protocol + ipAddress + ':' + portNumber + btAPI
    property var jsonObjectBT
    property string currentState: 'idle'

    function showRequestInfo(text) {
        log.text = log.text + "\n" + text
        console.log(text)
    }

    Text {
        id: log
        anchors.fill: parent
        anchors.margins: 10
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        //text: "log"
    }

    onTechnologyEnabledChanged: {
        console.log("Bluetooth set to", technologyEnabled)

            if (technologyEnabled == true) {
            request(btAPIpath + 'power?value=1', function (o) {
                console.log(o.responseText)
            })

                request(btAPIpath + 'start_discovery', function (o) {
                console.log(o.responseText)
            })
            currentState = 'discovering'
            //search_device()
            periodicRefresh.start()
            scanButton.text = "Cancel"


        } else {

            //console.log(networkPath)
            btDeviceList.clear()

                        periodicRefresh.stop()
                        request(btAPIpath + 'stop_discovery', function (o) {

                // log the json response
                //showRequestInfo(o.responseText)
                console.log(o.responseText)
            })

                        request(btAPIpath + 'power?value=0', function (o) {

                // log the json response
                //showRequestInfo(o.responseText)
                console.log(o.responseText)
            })
            currentState = 'idle'
        }
    }

        ListModel {
        id: btDeviceList
    }

    Rectangle {
        id: buttonScan
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        color: "#222"
        border.color: "blue"

        Button{
            id: scanButton
            anchors.margins: 80
            width: 50
            height: 30
            text: "Search"

            MouseArea {
                //id: mouseArea
                anchors.fill: parent

                onClicked: {
                    if (scanButton.text == "Search"){
                        request(btAPIpath + 'start_discovery', function (o) {

                            // log the json response
                            //showRequestInfo(o.responseText)
                            console.log(o.responseText)
                        })
                        scanButton.text = "Cancel"
                        currentState = 'discovering'
                        periodicRefresh.start()
                    }else{
                        request(btAPIpath + 'stop_discovery', function (o) {

                            // log the json response
                            //showRequestInfo(o.responseText)
                            console.log(o.responseText)
                        })
                        scanButton.text = "Search"
                        currentState = 'idle'
                        //periodicRefresh.stop()  //in order to update the content from bluez
                    }
                }
            }
        }
    }

        function request(url, callback) {
        var xhr = new XMLHttpRequest()
        xhr.onreadystatechange = (function (myxhr) {

            return function () {
                if (xhr.readyState == 4 && xhr.status == 200){
                    callback(myxhr)
                }
            }
        })(xhr)
        xhr.open('GET', url, false)
        xhr.send('')
    }

    Component {
        id:blueToothDevice

        Rectangle {
            height: 150
            width: parent.width
            color: "#222"

            Column {
                Text {
                    id: btName
                    text: deviceName
                    font.pointSize: 36
                    color: "#ffffff"
                }

                Text {
                    id: btAddr
                    text: deviceAddress
                    font.pointSize: 18
                    color: "#ffffff"
                }
                Text {
                    id: btPairable
                    text: devicePairable
                    font.pointSize: 18
                    color: "#ffffff"
                }
            }

            Button {
                id: connectButton
                anchors.top:parent.top
                anchors.right: parent.right
                anchors.rightMargin: 40

                text:(btPairable.text == "True")? "Remove":"Pair"

                MouseArea {
                    anchors.fill: parent

                    onClicked: {
                        if (currentState == 'discovering'){
                            request(btAPIpath + 'stop_discovery', function (o) {
                                currentState = "idle"
                                console.log(o.responseText)
                            })
                        }

                        if (connectButton.text == "Pair"){
                            connectButton.text = "Remove"
                            request(btAPIpath + 'pair?value=' + btAddr.text, function (o) {
                                btPairable.text = "True"
                                console.log(o.responseText)
                           })
                        }
                        else if (connectButton.text == "Connect"){
                            connectButton.text = "Remove"
                            request(btAPIpath + 'connect?value=' + btAddr.text, function (o) {
                                console.log(o.responseText)
                            })
                        }
                        else if (connectButton.text == "Remove"){
                            request(btAPIpath + 'remove_device?value=' + btAddr.text, function (o) {
                            console.log(o.responseText)
                            })
                            connectButton.text = "Pair"
                            btDeviceList.remove(findDevice(btAddr.text))
                        }
                    }
                }
            }
        }
    }

    ListView {
        width: parent.width
        anchors.top: parent.top
        anchors.topMargin: 200
        anchors.bottom: parent.bottom
        model: btDeviceList
        delegate: blueToothDevice
        clip: true
    }

    function findDevice(address){
        for (var i = 0; i < jsonObjectBT.length; i++) {
            if (address === jsonObjectBT[i].Address){
                return i
            }
        }
    }
    function search_device(){
        btDeviceList.clear()
        request(btAPIpath + 'discovery_result', function (o) {

            // log the json response
            console.log(o.responseText)

            // translate response into object
            var jsonObject = eval('(' + o.responseText + ')')

            jsonObjectBT = eval('(' + JSON.stringify(
                                              jsonObject.response) + ')')

            console.log("BT list refreshed")

            //console.log(jsonObject.response)
            for (var i = 0; i < jsonObjectBT.length; i++) {
            btDeviceList.append({
                                    deviceAddress: jsonObjectBT[i].Address,
                                    deviceName: jsonObjectBT[i].Name,
                                    devicePairable:jsonObjectBT[i].Paired
                                })
             }
        })
    }


    //Timer for periodic refresh; this is BAD solution, need to figure out how to subscribe for events
    Timer {
        id: periodicRefresh
        interval: (currentState == "idle")? 10000:5000 // 5seconds
        onTriggered: {

            btDeviceList.clear()

            request(btAPIpath + 'discovery_result', function (o) {

                // log the json response
                console.log(o.responseText)

                // translate response into object
                var jsonObject = eval('(' + o.responseText + ')')

                jsonObjectBT = eval('(' + JSON.stringify(
                                                  jsonObject.response) + ')')

                console.log("BT list refreshed")

                //console.log(jsonObject.response)
                for (var i = 0; i < jsonObjectBT.length; i++) {
                btDeviceList.append({
                                        deviceAddress: jsonObjectBT[i].Address,
                                        deviceName: jsonObjectBT[i].Name,
                                        devicePairable:jsonObjectBT[i].Paired
                                    })
               }
            })

            start()
        }
    }
}

