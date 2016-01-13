import QtQuick 2.4
import QtQuick.Layouts 1.0
import Qt.labs.controls 1.0

Screen  {
    id: root

    TextMetrics {
        id: textMetrics
        font.pixelSize: 36
        text: "e"
    }

    ColumnLayout {
        anchors.fill: parent
        spacing: 0

        Label {
            text: "Payment successful. Thank you!"
            wrapMode: Label.Wrap
            font.pixelSize: 48
            Layout.fillWidth: true
            horizontalAlignment: Text.AlignHCenter
        }

        ColumnLayout {
            anchors.horizontalCenter: parent.horizontalCenter

            Row {
                spacing: textMetrics.width
                anchors.horizontalCenter: parent.horizontalCenter

                Label {
                    text: "Vehicle:"
                    wrapMode: Label.Wrap
                    font.pixelSize: 36
                }

                Label {
                    text: customerData.licensePlateNumber
                    wrapMode: Label.Wrap
                    font.pixelSize: 36
                    font.weight: Font.Normal
                }
            }

            Row {
                spacing: textMetrics.width
                anchors.horizontalCenter: parent.horizontalCenter

                Label {
                    text: "Amount paid:"
                    wrapMode: Label.Wrap
                    font.pixelSize: 36
                }

                Label {
                    text: customerData.paymentAmount
                    wrapMode: Label.Wrap
                    font.pixelSize: 36
                    font.weight: Font.Normal
                }
            }
        }

        ColumnLayout {
            anchors.horizontalCenter: parent.horizontalCenter

            Label {
                text: "You can find your vehicle on:"
                wrapMode: Label.Wrap
                font.pixelSize: 36
            }

            Row {
                spacing: textMetrics.width
                anchors.horizontalCenter: parent.horizontalCenter

                Label {
                    text: "Level:"
                    wrapMode: Label.Wrap
                    font.pixelSize: 36
                }

                Label {
                    text: customerData.lotLevel
                    wrapMode: Label.Wrap
                    font.pixelSize: 36
                    font.weight: Font.Normal
                }
            }

            Row {
                spacing: textMetrics.width
                anchors.horizontalCenter: parent.horizontalCenter

                Label {
                    text: "Level:"
                    wrapMode: Label.Wrap
                    font.pixelSize: 36
                }

                Label {
                    text: customerData.lotRow
                    wrapMode: Label.Wrap
                    font.pixelSize: 36
                    font.weight: Font.Normal
                }
            }
        }
    }
}
