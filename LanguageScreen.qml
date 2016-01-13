import QtQuick 2.0
import QtQuick.Layouts 1.0
import Qt.labs.controls 1.0

Item {
    id: root

    ColumnLayout {
        anchors.fill: parent

        Label {
            text: "Pay your parking fee here"
            font.pixelSize: 60
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Label {
            text: "Select Language"
            font.pixelSize: 48
            anchors.horizontalCenter: parent.horizontalCenter
        }

        RowLayout {
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: 178

            Item {
                implicitWidth: englishRowLayout.implicitWidth
                implicitHeight: englishRowLayout.implicitHeight

                RowLayout {
                    id: englishRowLayout
                    spacing: 18

                    Rectangle {
                        width: 100
                        height: 75
                        color: "blue"
                    }

                    Rectangle {
                        Layout.preferredWidth: 120
                        Layout.preferredHeight: 50
                        border.width: 1

                        Label {
                            text: "English"
                            font.pixelSize: 24
                            anchors.centerIn: parent
                        }
                    }
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: root.StackView.view.push("qrc:/PlateSelectionScreen.qml")
                }
            }


            Item {
                implicitWidth: englishRowLayout.implicitWidth
                implicitHeight: englishRowLayout.implicitHeight

                RowLayout {
                    spacing: 18

                    Rectangle {
                        width: 100
                        height: 75
                        color: "black"
                    }

                    Rectangle {
                        Layout.preferredWidth: 120
                        Layout.preferredHeight: 50
                        border.width: 1

                        Label {
                            text: "Deutsch"
                            font.pixelSize: 24
                            anchors.centerIn: parent
                        }
                    }
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: root.StackView.view.push("qrc:/PlateSelectionScreen.qml")
                }
            }
        }
    }
}
