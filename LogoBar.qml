import QtQuick 2.0
import QtQuick.Layouts 1.0
import Qt.labs.controls 1.0

Item {
    id: root
    height: 80

    property StackView stackView
    readonly property color color: "#015289"

    RowLayout {
        id: rowLayout
        anchors.fill: parent
        anchors.rightMargin: 28
        spacing: 28

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

                context.fillStyle = root.color;
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
