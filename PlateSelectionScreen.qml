import QtQuick 2.0
import QtQuick.Layouts 1.0
import Qt.labs.controls 1.0

Screen {
    id: root

    header: NavigationBar {
        id: navigationBar
        stackView: root.StackView.view
    }

    Text {
        id: instructionText
        text: qsTr("Select your license plate number:")
        color: root.mediumTextColor
        font.weight: Font.Bold
        font.pixelSize: 44
        verticalAlignment: Text.AlignVCenter
        anchors.horizontalCenter: parent.horizontalCenter
    }

    Item {
        anchors.top: instructionText.bottom
        anchors.topMargin: 80
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom

        Grid {
            columns: 4
            rows: 2
            columnSpacing: 20
            rowSpacing: 23
            anchors.fill: parent

            Repeater {
                model: 8
                delegate: Rectangle {
                    width: 200
                    height: 100
                    color: "transparent"
                    border.width: 2
                    border.color: navigationBar.lightAccentColor
                    radius: 12
                }
            }
        }

        Grid {
            columns: 4
            rows: 2
            columnSpacing: 20
            rowSpacing: 23
            anchors.fill: parent

            Repeater {
                model: userModel
                delegate: Rectangle {
                    width: 200
                    height: 100
                    color: "transparent"
                    border.width: 2
                    border.color: mouseArea.pressed ? navigationBar.accentColor : "transparent"
                    radius: 12

                    Text {
                        text: model.licensePlateNumber
                        font.weight: Font.Normal
                        font.pixelSize: 30
                        fontSizeMode: Text.Fit
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        anchors.fill: parent
                        anchors.margins: 6
                    }

                    MouseArea {
                        id: mouseArea
                        anchors.fill: parent
                        enabled: model.licensePlateNumber.length > 0
                        onClicked: {
                            var customerData = {
                                licensePlateNumber: model.licensePlateNumber,
                                parkingSpotNumber: model.parkingSpotNumber
                            };

                            root.StackView.view.push("qrc:/RetrievingPaymentDataScreen.qml", { customerData: customerData });
                        }
                    }
                }
            }
        }
    }
}
