import QtQuick 2.0
import QtQuick.Layouts 1.0
import Qt.labs.controls 1.0

Screen {
    id: root

    header: NavigationBar {
        stackView: root.StackView.view
    }

    ColumnLayout {
        anchors.fill: parent

        Label {
            text: "Select your license plate number:"
            color: root.mediumTextColor
            font.pixelSize: 36
            anchors.left: parent.left
            anchors.leftMargin: 33
            Layout.topMargin: 57
        }

        GridLayout {
            columns: 4
            rows: 2
            Layout.topMargin: 100
            Layout.bottomMargin: 100
            Layout.leftMargin: 40
            Layout.rightMargin: 61
            columnSpacing: 29
            rowSpacing: 40

            Repeater {
                model: ["B-FB-4067", "A-DL-3227", "THG 495", "AS-46-01", "366 PD 8", "L-HJ-1037", "4927-AE-PA", "K-OL-0742"]
                delegate: Rectangle {
                    Layout.fillWidth: true
                    Layout.preferredWidth: 200
                    Layout.preferredHeight: 80
                    border.width: 2
                    border.color: root.lightTextColor
                    radius: 12

                    Text {
                        text: modelData
                        font.pixelSize: 36
                        fontSizeMode: Text.Fit
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        anchors.fill: parent
                        anchors.margins: 6
                    }

                    MouseArea {
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
