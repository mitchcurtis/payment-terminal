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
            Text {
                text: "Paying " + customerData.paymentAmount
                color: root.mediumTextColor
                wrapMode: Text.Wrap
                font.weight: Font.Normal
                font.pixelSize: 60
                Layout.fillWidth: true
                horizontalAlignment: Text.AlignHCenter
            }

            Text {
                text: "Please insert your credit card with the chip side up"
                color: root.mediumTextColor
                font.weight: Font.Normal
                font.pixelSize: 36
                Layout.fillWidth: true
                horizontalAlignment: Text.AlignHCenter
            }

            Item {
                Layout.preferredHeight: 40
            }

            Rectangle {
                color: "black"
                Layout.preferredWidth: 225
                Layout.preferredHeight: 156
                anchors.horizontalCenter: parent.horizontalCenter

                Text {
                    text: "Illustration of how to insert the card (click to continue)"
                    color: "white"
                    anchors.fill: parent
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    fontSizeMode: Text.Fit
                    wrapMode: Text.Wrap
                }

                // TODO: remove
                MouseArea {
                    anchors.fill: parent
                    onClicked: root.StackView.view.push("qrc:/ReadingCardScreen.qml", { customerData: root.customerData })
                }
            }
        }
    }
}
