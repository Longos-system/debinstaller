/*
 * Copyright (C) 2023 LongOS Team.
 *
 * Author:     chang2005 <389574063@qq.com>
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

import QtQuick 2.0
import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12
import LongUI 1.0 as LongUI
import Long.DebInstaller 1.0

Item {
    Component {
        id: informationPage

        Item {
            ColumnLayout {
                anchors.fill: parent
                anchors.margins: LongUI.Units.largeSpacing

                GridLayout {
                    columns: 2
                    columnSpacing: LongUI.Units.largeSpacing * 2

                    Label {
                        text: qsTr("Maintainer")
                        visible: Installer.maintainer
                    }

                    Label {
                        text: Installer.maintainer
                        visible: text !== ""
                        Layout.fillWidth: true
                        elide: Qt.ElideRight
                    }

                    Label {
                        text: qsTr("Homepage")
                        visible: Installer.homePage
                    }

                    Label {
                        id: homePageLabel
                        text: "<a href=\"%1\">%1</a>".arg(Installer.homePage)
                        linkColor: LongUI.Theme.highlightColor
                        visible: Installer.homePage
                        Layout.fillWidth: true
                        elide: Qt.ElideRight

                        MouseArea {
                            anchors.fill: parent
                            cursorShape: Qt.PointingHandCursor
                            onClicked: Qt.openUrlExternally(Installer.homePage)
                        }
                    }

                    Label {
                        text: qsTr("Installed Size")
                        visible: Installer.installedSize
                    }

                    Label {
                        text: Installer.installedSize
                        visible: text
                    }

                    Label {
                        text: qsTr("Description")
                        visible: Installer.description
                    }

                    Label {
                        text: Installer.description
                        Layout.fillWidth: true
                        elide: Qt.ElideRight
                        visible: text
                        maximumLineCount: 3
                    }
                }

                Item {
                    Layout.fillHeight: true
                }
            }
        }
    }

    ColumnLayout {
        anchors.fill: parent
        anchors.leftMargin: LongUI.Units.largeSpacing
        anchors.rightMargin: LongUI.Units.largeSpacing
        anchors.bottomMargin: LongUI.Units.largeSpacing

        Image {
            width: 64
            height: width
            sourceSize: Qt.size(width, height)
            source: "image://icontheme/application-x-deb"
            Layout.alignment: Qt.AlignTop | Qt.AlignHCenter
        }

        Label {
            id: packageName
            text: Installer.packageName
            font.pointSize: 15
            Layout.alignment: Qt.AlignTop | Qt.AlignHCenter
        }

        Label {
            id: version
            text: qsTr("Version: ") + Installer.version
                  + (Installer.isInstalled && Installer.version === Installer.installedVersion ? " (%1) ".arg(qsTr("Installed")) : "")
                  + (Installer.installedVersion && Installer.version !== Installer.installedVersion ? qsTr(" (Installed Version: %1) ").arg(Installer.installedVersion) : "")
            color: LongUI.Theme.disabledTextColor
            Layout.alignment: Qt.AlignTop | Qt.AlignHCenter
        }

        Label {
            id: status
            text: Installer.preInstallMessage
            color: LongUI.Theme.disabledTextColor
            Layout.alignment: Qt.AlignTop | Qt.AlignHCenter
            visible: text
        }

        Item {
            height: LongUI.Units.smallSpacing
        }

//        TabBar {
//            Layout.fillWidth: true

//            TabButton {
//                text: qsTr("Information")
//            }
//            TabButton {
//                text: qsTr("Included Files")
//            }
//        }

        StackView {
            Layout.fillHeight: true
            Layout.fillWidth: true
            initialItem: informationPage
        }

        RowLayout {
            spacing: LongUI.Units.largeSpacing

            Button {
                Layout.fillWidth: true
                text: qsTr("Cancel")
                onClicked: Qt.quit()
            }
            Button {
                Layout.fillWidth: true
                text: Installer.isInstalled ? qsTr("Reinstall") : qsTr("Install")
                flat: true
                enabled: Installer.canInstall
                onClicked: Installer.install()
            }
        }
    }
}
