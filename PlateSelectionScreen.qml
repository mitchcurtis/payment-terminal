import QtQuick 2.0
import QtQuick.Layouts 1.0
import Qt.labs.controls 1.0

Screen {
    id: root

    header: NavigationBar {
        id: navigationBar
        stackView: root.StackView.view
    }

    ColumnLayout {
        anchors.fill: parent
        spacing: 80

        Label {
            text: "Select your license plate number:"
            color: root.mediumTextColor
            font.weight: Font.Normal
            font.pixelSize: 48
            anchors.horizontalCenter: parent.horizontalCenter
        }

        GridLayout {
            columns: 4
            rows: 2
            columnSpacing: 20
            rowSpacing: 23

            Repeater {
                model: ["B-FB-4067", "A-DL-3227", "THG 495", "AS-46-01", "366 PD 8", "L-HJ-1037", "4927-AE-PA", "K-OL-0742"]
                delegate: Rectangle {
                    Layout.fillWidth: true
                    Layout.preferredWidth: 200
                    Layout.preferredHeight: 100
                    border.width: 2
                    border.color: mouseArea.pressed ? navigationBar.color : root.lightTextColor
                    radius: 12

                    Label {
                        text: modelData
                        font.weight: Font.Normal
                        font.pixelSize: 36
                        fontSizeMode: Text.Fit
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        anchors.fill: parent
                        anchors.margins: 6
                    }

                    MouseArea {
                        id: mouseArea
                        anchors.fill: parent
                        onClicked: {
                            var customerData = {
                                licensePlateNumber: modelData,
                                paymentAmount: "5,65 €",
                                lotLevel: "-1",
                                lotRow: "P45"
                            };

                            root.StackView.view.push("qrc:/PaymentSummaryScreen.qml", { customerData: customerData });
                        }
                    }
                }
            }
        }
    }
}
