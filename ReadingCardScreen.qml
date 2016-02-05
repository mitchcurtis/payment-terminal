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
        onTriggered: {
            userModel.paymentAccepted(root.customerData.licensePlateNumber);

            root.StackView.view.push("qrc:/ConfirmationScreen.qml", { customerData: root.customerData });
        }
    }

    ColumnLayout {
        anchors.fill: parent
        spacing: 20

        Text {
            text: "Paying " + customerData.paymentAmount + " €"
            color: root.mediumTextColor
            wrapMode: Text.Wrap
            font.weight: Font.Normal
            font.pixelSize: 48
            Layout.fillWidth: true
            horizontalAlignment: Text.AlignHCenter
        }

        Text {
            text: "Reading your card..."
            color: root.mediumTextColor
            font.weight: Font.Normal
            font.pixelSize: 36
            Layout.fillWidth: true
            horizontalAlignment: Text.AlignHCenter
        }

        ProgressBar {
            id: progressBar
            Layout.preferredWidth: 248
            Layout.preferredHeight: 30
            Layout.fillHeight: true
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
