import QtQuick 2.4
import QtQuick.Layouts 1.0
import Qt.labs.controls 1.0

Screen  {
    id: root

    header: NavigationBar {
        stackView: root.StackView.view
    }

    readonly property int stackViewStatus: root.StackView.status
    onStackViewStatusChanged: {
        if (stackViewStatus == StackView.Active) {
            var onPaymentDataAvailable = function(paymentAmount, minutesParked) {
                root.customerData.paymentAmount = paymentAmount;
                root.customerData.minutesParked = minutesParked;

                userModel.paymentDataAvailable.disconnect(onPaymentDataAvailable);

                root.StackView.view.push("qrc:/PaymentSummaryScreen.qml", { customerData: root.customerData });
            }

            userModel.paymentDataAvailable.connect(onPaymentDataAvailable);
            userModel.requestPaymentData(root.customerData.licensePlateNumber);
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
