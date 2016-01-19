import QtQuick 2.0
import QtQuick.Layouts 1.0
import Qt.labs.controls 1.0

Screen  {
    id: root

    bottomPadding: 57

    header: LogoBar {
        id: logoBar
    }

    ColumnLayout {
        anchors.fill: parent

        Label {
            text: "Pay your parking fee here"
            color: root.mediumTextColor
            font.weight: Font.Normal
            font.pixelSize: 60
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Label {
            text: "Select Language"
            color: root.mediumTextColor
            font.weight: Font.Normal
            font.pixelSize: 36
            anchors.horizontalCenter: parent.horizontalCenter
        }

        RowLayout {
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: 36

            Rectangle {
                Layout.preferredWidth: 156
                Layout.preferredHeight: 164
                border.width: englishMouseArea.pressed ? 2 : 0
                border.color: logoBar.color
                radius: 8

                ColumnLayout {
                    anchors.fill: parent
                    anchors.margins: 14
                    spacing: 18

                    Rectangle {
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        color: "blue"
                    }

                    Label {
                        text: "English"
                        color: root.mediumTextColor
                        font.weight: Font.Normal
                        font.pixelSize: 24
                        Layout.fillWidth: true
                        horizontalAlignment: Text.AlignHCenter
                    }
                }

                MouseArea {
                    id: englishMouseArea
                    anchors.fill: parent
                    onClicked: root.StackView.view.push("qrc:/PlateSelectionScreen.qml")
                }
            }

            Rectangle {
                Layout.preferredWidth: 156
                Layout.preferredHeight: 164
                border.width: deutschMouseArea.pressed ? 2 : 0
                border.color: logoBar.color
                radius: 8

                ColumnLayout {
                    anchors.fill: parent
                    anchors.margins: 14
                    spacing: 18

                    Rectangle {
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        color: "red"
                    }

                    Label {
                        text: "Deutsch"
                        color: root.mediumTextColor
                        font.weight: Font.Normal
                        font.pixelSize: 24
                        Layout.fillWidth: true
                        horizontalAlignment: Text.AlignHCenter
                    }
                }

                MouseArea {
                    id: deutschMouseArea
                    anchors.fill: parent
                    onClicked: root.StackView.view.push("qrc:/PlateSelectionScreen.qml")
                }
            }
        }
    }
}
