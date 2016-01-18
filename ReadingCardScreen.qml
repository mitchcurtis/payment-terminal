import QtQuick 2.0
import QtQuick.Layouts 1.0
import Qt.labs.controls 1.0

Screen {
    id: root

    header: LogoBar {}

    Timer {
        running: true
        interval: 500
        onTriggered: {
            progressBar.value = 1;
            nextScreenTimer.start()
        }
    }

    Timer {
        id: nextScreenTimer
        interval: 1500
        onTriggered: root.StackView.view.push("qrc:/ConfirmationScreen.qml", { customerData: root.customerData })
    }

    ColumnLayout {
        anchors.fill: parent
        anchors.bottomMargin: 208
        spacing: 0

        Label {
            text: "Paying " + customerData.paymentAmount
            wrapMode: Label.Wrap
            font.pixelSize: 48
            Layout.fillWidth: true
            horizontalAlignment: Text.AlignHCenter
        }

        Label {
            text: "Reading your card..."
            font.pixelSize: 36
            Layout.fillWidth: true
            horizontalAlignment: Text.AlignHCenter
        }

        ProgressBar {
            id: progressBar
            Layout.preferredWidth: 248
            Layout.preferredHeight: 30
            anchors.horizontalCenter: parent.horizontalCenter

            Behavior on value {
                NumberAnimation {
                    easing.type: Easing.OutInQuad
                    duration: 1000
                }
            }
        }
    }
}
