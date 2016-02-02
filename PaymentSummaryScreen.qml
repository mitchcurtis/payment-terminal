import QtQuick 2.0
import QtQuick.Layouts 1.0
import Qt.labs.controls 1.0

Screen {
    id: root

    header: NavigationBar {
        stackView: root.StackView.view

        onBackButtonClicked: function() {
            // Skip RetrievingPaymentDataScreen.
            root.StackView.view.pop();
            root.StackView.view.pop();
        }
    }

    ColumnLayout {
        anchors.fill: parent
        spacing: 0

        ColumnLayout {
            spacing: 25

            ColumnLayout {
                spacing: 0

                Text {
                    text: "Pay for the vehicle:"
                    color: root.mediumTextColor
                    font.pixelSize: 24
                }

                Text {
                    text: customerData.licensePlateNumber
                    font.pixelSize: 48
                    font.weight: Font.Normal
                }
            }

            ColumnLayout {
                spacing: 0

                Text {
                    text: "Parking time"
                    color: root.mediumTextColor
                    font.pixelSize: 24
                }

                Text {
                    text: Math.floor(customerData.minutesParked / 60) + "h " + (customerData.minutesParked % 60).toFixed(0) + "m"
                    font.pixelSize: 24
                    font.weight: Font.Normal
                }
            }

            ColumnLayout {
                spacing: 0

                Text {
                    text: "Amount to pay"
                    color: root.mediumTextColor
                    font.pixelSize: 24
                }

                Text {
                    text: customerData.paymentAmount + " €"
                    font.pixelSize: 48
                    font.weight: Font.Normal
                }
            }

            Text {
                text: "We accept credit card payments only"
                color: "#80c342"
                font.pixelSize: 24
            }
        }
    }

    Button {
        id: payButton

        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.bottomMargin: -26

        onClicked: root.StackView.view.push("qrc:/CardPromptScreen.qml", { customerData: root.customerData })

        label: Text {
            text: "Pay Now"
            font.pixelSize: 28
            font.weight: Font.Normal
            color: "#fff"
            x: payButton.leftPadding
            y: payButton.topPadding
            width: payButton.availableWidth
            height: payButton.availableHeight
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }

        background: Rectangle {
            implicitWidth: 200
            implicitHeight: 100
            radius: 12
            color: "#80c342"
            border.color: Qt.darker(color, 1.1)
            border.width: 2
        }
    }
}
