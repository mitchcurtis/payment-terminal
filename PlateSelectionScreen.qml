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

        Text {
            text: "Select your license plate number:"
            color: root.mediumTextColor
            font.weight: Font.Bold
            font.pixelSize: 44
            anchors.horizontalCenter: parent.horizontalCenter
        }

        GridLayout {
            columns: 4
            rows: 2
            columnSpacing: 20
            rowSpacing: 23

            Repeater {
                model: userModel
                delegate: Rectangle {
                    Layout.fillWidth: true
                    Layout.preferredWidth: 200
                    Layout.preferredHeight: 100
                    border.width: 2
                    border.color: mouseArea.pressed ? navigationBar.accentColor : navigationBar.lightAccentColor
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
                        onClicked: {
                            var onPaymentDataAvailable = function(paymentAmount, minutesParked) {
                                if (root.StackView.view.currentItem !== root)
                                    return;

                                var customerData = {
                                    licensePlateNumber: model.licensePlateNumber,
                                    parkingSpotNumber: model.parkingSpotNumber,
                                    paymentAmount: paymentAmount,
                                    minutesParked: minutesParked
                                };

                                userModel.paymentDataAvailable.disconnect(onPaymentDataAvailable);

                                root.StackView.view.push("qrc:/PaymentSummaryScreen.qml", { customerData: customerData });
                            }

                            userModel.paymentDataAvailable.connect(onPaymentDataAvailable);
                            userModel.requestPaymentData(model.licensePlateNumber);
                        }
                    }
                }
            }
        }
    }
}
