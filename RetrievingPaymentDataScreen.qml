import QtQuick 2.4
import QtQuick.Layouts 1.0
import Qt.labs.controls 1.0

Screen  {
    id: root

    header: NavigationBar {
        stackView: root.StackView.view
    }

    Timer {
        id: displayDelayTimer
        interval: 1000

        property bool finished: false

        onTriggered: {
            finished = true;

            // We might be quicker than the payment data retrieval.
            if (root.receivedPaymentData) {
                nextScreen();
            }
        }
    }

    Component.onCompleted: {
        userModel.paymentDataAvailable.connect(onPaymentDataAvailable);
        userModel.requestPaymentData(root.customerData.licensePlateNumber);
    }

    function onPaymentDataAvailable(paymentAmount, minutesParked) {
        root.customerData.paymentAmount = paymentAmount;
        root.customerData.minutesParked = minutesParked;

        userModel.paymentDataAvailable.disconnect(onPaymentDataAvailable);

        root.receivedPaymentData = true;

        // We request the data as soon as possible, but try to ensure that
        // the information is visible long enough to not be *too* quick, hence the timer.
        if (displayDelayTimer.finished) {
            nextScreen();
        }
    }

    function nextScreen() {
        root.StackView.view.push("qrc:/PaymentSummaryScreen.qml", { customerData: root.customerData });
    }

    property bool receivedPaymentData: false

    readonly property int stackViewStatus: root.StackView.status

    onStackViewStatusChanged: {
        if (stackViewStatus == StackView.Active) {
            displayDelayTimer.start();
        }
    }

    ColumnLayout {
        anchors.fill: parent
        spacing: 0

        ColumnLayout {
            spacing: 20

            Text {
                text: customerData.licensePlateNumber
                color: "#80c342"
                wrapMode: Text.Wrap
                font.pixelSize: 44
                font.weight: Font.Bold
                Layout.fillWidth: true
                horizontalAlignment: Text.AlignHCenter
            }

            BusyIndicator {
                running: true
                anchors.horizontalCenter: parent.horizontalCenter
            }
        }
    }
}
