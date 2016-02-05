import QtQuick 2.0
import QtQuick.Layouts 1.0
import Qt.labs.controls 1.0

Screen {
    id: root

    header: NavigationBar {
        stackView: root.StackView.view
    }

    TextInput {
        opacity: 0
        onAccepted: root.StackView.view.push("qrc:/ReadingCardScreen.qml", { customerData: customerData })
        Component.onCompleted: forceActiveFocus()
    }

    // Fallback option in case the RFID reader isn't available.
    MouseArea {
        anchors.fill: parent
        onPressAndHold: root.StackView.view.push("qrc:/ReadingCardScreen.qml", { customerData: customerData })
    }

    ColumnLayout {
        anchors.fill: parent
        spacing: 20

        Text {
            text: "Paying " + customerData.paymentAmount + " €"
            color: root.mediumTextColor
            wrapMode: Text.Wrap
            font.weight: Font.Normal
            font.pixelSize: 60
            Layout.fillWidth: true
            horizontalAlignment: Text.AlignHCenter
        }

        Text {
            text: "Please place your card on the card reader"
            color: root.mediumTextColor
            font.weight: Font.Normal
            font.pixelSize: 36
            Layout.fillWidth: true
            horizontalAlignment: Text.AlignHCenter
        }

        Item {
            Layout.preferredHeight: 40
            Layout.fillHeight: true
        }

        Image {
            source: "qrc:/images/PayCard.png"
            anchors.horizontalCenter: parent.horizontalCenter
        }
    }
}
