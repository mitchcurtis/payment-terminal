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

        Text {
            text: qsTr("Pay your parking fee here")
            color: root.mediumTextColor
            font.weight: Font.Bold
            font.pixelSize: 44
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Text {
            text: qsTr("Select Language")
            color: root.mediumTextColor
            font.weight: Font.Normal
            font.pixelSize: 30
            anchors.horizontalCenter: parent.horizontalCenter
        }

        RowLayout {
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: 36

            Rectangle {
                Layout.preferredWidth: 156
                Layout.preferredHeight: 164
                border.width: 2
                border.color: englishMouseArea.pressed ? logoBar.accentColor : logoBar.lightAccentColor
                radius: 8

                ColumnLayout {
                    anchors.fill: parent
                    anchors.margins: 14
                    spacing: 18

                    Image {
                        source: "qrc:/images/UK-flag.png"
                    }

                    Text {
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
                    onClicked: {
                        userModel.language = "en_GB";
                        root.StackView.view.push("qrc:/PlateSelectionScreen.qml");
                    }
                }
            }

            Rectangle {
                Layout.preferredWidth: 156
                Layout.preferredHeight: 164
                border.width: 2
                border.color: deutschMouseArea.pressed ? logoBar.accentColor : logoBar.lightAccentColor
                radius: 8

                ColumnLayout {
                    anchors.fill: parent
                    anchors.margins: 14
                    spacing: 18

                    Image {
                        source: "qrc:/images/German-flag.png"
                    }

                    Text {
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
                    onClicked: {
                        userModel.language = "de_DE";
                        root.StackView.view.push("qrc:/PlateSelectionScreen.qml");
                    }
                }
            }
        }
    }
}
