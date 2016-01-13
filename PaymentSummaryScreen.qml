import QtQuick 2.0
import QtQuick.Layouts 1.0
import Qt.labs.controls 1.0

Item {
    id: root

    property var customerData

    ColumnLayout {
        anchors.fill: parent
        spacing: 0

        NavigationBar {
            stackView: root.StackView.view
        }

        ColumnLayout {
            Layout.leftMargin: 120
            Layout.topMargin: 65
            Layout.rightMargin: 28
            Layout.bottomMargin: 16
            spacing: 0

            Label {
                text: "Pay for the vehicle"
                font.pixelSize: 24
            }

            Label {
                text: customerData.licensePlateNumber
                font.pixelSize: 48
                font.weight: Font.Normal
            }

            Label {
                text: "Parking time"
                font.pixelSize: 24
                Layout.topMargin: 38
            }

            Label {
                text: "15:53 to 17:21 (1h 30m)"
                font.pixelSize: 24
                font.weight: Font.Normal
            }

            Label {
                text: "Amount to pay"
                font.pixelSize: 24
                Layout.topMargin: 38
            }

            Label {
                text: customerData.paymentAmount
                font.pixelSize: 48
                font.weight: Font.Normal
            }

            RowLayout {
                Layout.topMargin: 10

                Label {
                    text: "We accept credit card payments only"
                    font.pixelSize: 24
                }

                Item {
                    Layout.fillWidth: true
                }

                Button {
                    text: "Pay Now"
                    font.pixelSize: 36
                    Layout.preferredWidth: 200
                    Layout.preferredHeight: 80
                    onClicked: root.StackView.view.push("qrc:/CardPromptScreen.qml", { customerData: root.customerData })
                }
            }
        }
    }
}
