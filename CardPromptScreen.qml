import QtQuick 2.0
import QtQuick.Layouts 1.0
import Qt.labs.controls 1.0

Screen {
    id: root

    ColumnLayout {
        anchors.fill: parent
        spacing: 0

        NavigationBar {
            stackView: root.StackView.view
        }

        ColumnLayout {
            Layout.leftMargin: 120
            Layout.rightMargin: 120
            Layout.bottomMargin: 16
            spacing: 70

            Label {
                text: "Paying " + customerData.paymentAmount
                wrapMode: Label.Wrap
                font.pixelSize: 48
                Layout.fillWidth: true
                horizontalAlignment: Text.AlignHCenter
            }

            Label {
                text: "Please insert your credit card with the chip side up"
                font.pixelSize: 36
                Layout.fillWidth: true
                horizontalAlignment: Text.AlignHCenter
            }

            Rectangle {
                color: "black"
                Layout.preferredWidth: 225
                Layout.preferredHeight: 156
                anchors.horizontalCenter: parent.horizontalCenter

                Text {
                    text: "Illustration of how to insert the card"
                    color: "white"
                    anchors.fill: parent
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    fontSizeMode: Text.Fit
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
