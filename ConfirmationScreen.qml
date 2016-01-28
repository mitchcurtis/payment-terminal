import QtQuick 2.4
import QtQuick.Layouts 1.0
import Qt.labs.controls 1.0

Screen  {
    id: root

    readonly property int labelSpacing: textMetrics.width * 0.6

    header: NavigationBar {
        backButtonEnabled: false
        stackView: root.StackView.view
    }

    TextMetrics {
        id: textMetrics
        font.pixelSize: 36
        text: "e"
    }

    Timer {
        id: quitTimer
        running: true
        interval: 10000
        onTriggered: root.StackView.view.pop(null)
    }

    ColumnLayout {
        anchors.fill: parent
        spacing: 0

        Text {
            text: "Payment successful. Thank you!"
            color: "#80c342"
            wrapMode: Text.Wrap
            font.pixelSize: 44
            font.weight: Font.Bold
            Layout.fillWidth: true
            horizontalAlignment: Text.AlignHCenter
        }

        ColumnLayout {
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: 20

            Row {
                spacing: labelSpacing
                anchors.horizontalCenter: parent.horizontalCenter

                Text {
                    text: "Vehicle:"
                    color: root.mediumTextColor
                    wrapMode: Text.Wrap
                    font.pixelSize: 30
                    font.weight: Font.Normal
                }

                Text {
                    text: customerData.licensePlateNumber
                    wrapMode: Text.Wrap
                    font.pixelSize: 30
                    font.weight: Font.Bold
                }
            }

            Row {
                spacing: labelSpacing
                anchors.horizontalCenter: parent.horizontalCenter

                Text {
                    text: "Amount paid:"
                    color: root.mediumTextColor
                    wrapMode: Text.Wrap
                    font.pixelSize: 30
                    font.weight: Font.Normal
                }

                Text {
                    text: customerData.paymentAmount
                    wrapMode: Text.Wrap
                    font.pixelSize: 30
                    font.weight: Font.Bold
                }
            }

            Row {
                spacing: labelSpacing
                anchors.horizontalCenter: parent.horizontalCenter

                Text {
                    text: "Parking place:"
                    color: root.mediumTextColor
                    wrapMode: Text.Wrap
                    font.pixelSize: 30
                    font.weight: Font.Normal
                }

                Text {
                    text: customerData.parkingPlace
                    wrapMode: Text.Wrap
                    font.pixelSize: 30
                    font.weight: Font.Bold
                }
            }
        }
    }

    MouseArea {
        anchors.fill: parent
        onClicked: root.StackView.view.pop(null)
    }
}
