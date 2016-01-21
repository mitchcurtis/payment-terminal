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
        interval: 5000
        onTriggered: root.StackView.view.pop(null)
    }

    ColumnLayout {
        anchors.fill: parent
        spacing: 0

        Label {
            text: "Payment successful. Thank you!"
            color: "#80c342"
            wrapMode: Label.Wrap
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

                Label {
                    text: "Vehicle:"
                    color: root.mediumTextColor
                    wrapMode: Label.Wrap
                    font.pixelSize: 29
                    font.weight: Font.Normal
                }

                Label {
                    text: customerData.licensePlateNumber
                    wrapMode: Label.Wrap
                    font.pixelSize: 29
                    font.weight: Font.DemiBold
                }
            }

            Row {
                spacing: textMetrics.width
                anchors.horizontalCenter: parent.horizontalCenter

                Label {
                    text: "Amount paid:"
                    color: root.mediumTextColor
                    wrapMode: Label.Wrap
                    font.pixelSize: 29
                    font.weight: Font.Normal
                }

                Label {
                    text: customerData.paymentAmount
                    wrapMode: Label.Wrap
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

            Label {
                text: "You can find your vehicle on:"
                color: root.mediumTextColor
                wrapMode: Label.Wrap
                font.pixelSize: 29
                font.weight: Font.Normal
            }

            Row {
                spacing: textMetrics.width
                anchors.horizontalCenter: parent.horizontalCenter

                Label {
                    text: "Level:"
                    color: root.mediumTextColor
                    wrapMode: Label.Wrap
                    font.pixelSize: 29
                    font.weight: Font.Normal
                }

                Label {
                    text: customerData.lotLevel
                    wrapMode: Label.Wrap
                    font.pixelSize: 29
                    font.weight: Font.DemiBold
                }
            }

            Row {
                spacing: textMetrics.width
                anchors.horizontalCenter: parent.horizontalCenter

                Label {
                    text: "Row number:"
                    color: root.mediumTextColor
                    wrapMode: Label.Wrap
                    font.pixelSize: 29
                    font.weight: Font.Normal
                }

                Label {
                    text: customerData.lotRow
                    wrapMode: Label.Wrap
                    font.pixelSize: 29
                    font.weight: Font.DemiBold
                }
            }
        }
    }
}
