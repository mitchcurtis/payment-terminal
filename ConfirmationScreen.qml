import QtQuick 2.4
import QtQuick.Layouts 1.0
import Qt.labs.controls 1.0

Screen  {
    id: root

    header: LogoBar {}

    TextMetrics {
        id: textMetrics
        font.pixelSize: 36
        text: "e"
    }

    Timer {
        id: quitTimer
        running: true
        interval: 8000
        onTriggered: root.StackView.view.pop(null)
    }

    ColumnLayout {
        anchors.fill: parent
        spacing: 0

        Text {
            text: "Payment successful. Thank you!"
            color: "#80c342"
            wrapMode: Text.Wrap
            font.pixelSize: 48
            font.weight: Font.Normal
            Layout.fillWidth: true
            horizontalAlignment: Text.AlignHCenter
        }

        Item {
            Layout.fillHeight: true
        }

        ColumnLayout {
            anchors.horizontalCenter: parent.horizontalCenter

            Row {
                spacing: textMetrics.width
                anchors.horizontalCenter: parent.horizontalCenter

                Text {
                    text: "Vehicle:"
                    color: root.mediumTextColor
                    wrapMode: Text.Wrap
                    font.pixelSize: 29
                    font.weight: Font.Normal
                }

                Text {
                    text: customerData.licensePlateNumber
                    wrapMode: Text.Wrap
                    font.pixelSize: 29
                    font.weight: Font.DemiBold
                }
            }

            Row {
                spacing: textMetrics.width
                anchors.horizontalCenter: parent.horizontalCenter

                Text {
                    text: "Amount paid:"
                    color: root.mediumTextColor
                    wrapMode: Text.Wrap
                    font.pixelSize: 29
                    font.weight: Font.Normal
                }

                Text {
                    text: customerData.paymentAmount
                    wrapMode: Text.Wrap
                    font.pixelSize: 29
                    font.weight: Font.DemiBold
                }
            }
        }

        Item {
            Layout.fillHeight: true
        }

        ColumnLayout {
            anchors.horizontalCenter: parent.horizontalCenter

            Text {
                text: "You can find your vehicle on:"
                color: root.mediumTextColor
                wrapMode: Text.Wrap
                font.pixelSize: 29
                font.weight: Font.Normal
            }

            Row {
                spacing: textMetrics.width
                anchors.horizontalCenter: parent.horizontalCenter

                Text {
                    text: "Level:"
                    color: root.mediumTextColor
                    wrapMode: Text.Wrap
                    font.pixelSize: 29
                    font.weight: Font.Normal
                }

                Text {
                    text: customerData.lotLevel
                    wrapMode: Text.Wrap
                    font.pixelSize: 29
                    font.weight: Font.DemiBold
                }
            }

            Row {
                spacing: textMetrics.width
                anchors.horizontalCenter: parent.horizontalCenter

                Text {
                    text: "Row number:"
                    color: root.mediumTextColor
                    wrapMode: Text.Wrap
                    font.pixelSize: 29
                    font.weight: Font.Normal
                }

                Text {
                    text: customerData.lotRow
                    wrapMode: Text.Wrap
                    font.pixelSize: 29
                    font.weight: Font.DemiBold
                }
            }
        }
    }

    MouseArea {
        anchors.fill: parent
        onClicked: root.StackView.view.pop(null)
    }
}
