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
        spacing: 0

        ColumnLayout {
            spacing: 25

            ColumnLayout {
                spacing: 0

                Label {
                    text: "Pay for the vehicle:"
                    color: root.mediumTextColor
                    font.pixelSize: 24
                }

                Label {
                    text: customerData.licensePlateNumber
                    font.pixelSize: 48
                    font.weight: Font.Normal
                }
            }

            ColumnLayout {
                spacing: 0

                Label {
                    text: "Parking time"
                    color: root.mediumTextColor
                    font.pixelSize: 24
                }

                Label {
                    text: "15:53 to 17:21 (1h 30m)"
                    font.pixelSize: 24
                    font.weight: Font.Normal
                }
            }

            ColumnLayout {
                spacing: 0

                Label {
                    text: "Amount to pay"
                    color: root.mediumTextColor
                    font.pixelSize: 24
                }

                Label {
                    text: customerData.paymentAmount
                    font.pixelSize: 48
                    font.weight: Font.Normal
                }
            }

            Label {
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
