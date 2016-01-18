import QtQuick 2.0
import QtQuick.Layouts 1.0
import Qt.labs.controls 1.0

Item {
    id: root
    height: 65

    property StackView stackView

    RowLayout {
        id: rowLayout
        anchors.fill: parent
        spacing: 20

        Canvas {
            Layout.fillWidth: true
            Layout.fillHeight: true
            contextType: "2d"
            onPaint: {
                context.beginPath();
                context.moveTo(0, 0);
                context.lineTo(width, 0);
                context.lineTo(width - height, height);
                context.lineTo(0, height);
                context.closePath();

                context.fillStyle = "#015289";
                context.fill();
            }
        }

        Image {
            source: "qrc:/images/CPD-logo.png"
            Layout.alignment: Qt.AlignVCenter
        }

        Image {
            source: "qrc:/images/Qt-logo.png"
        }
    }
}
