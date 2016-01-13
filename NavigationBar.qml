import QtQuick 2.0
import QtQuick.Layouts 1.0
import Qt.labs.controls 1.0

RowLayout {
    id: root

    property StackView stackView

    Button {
        text: "Back"
        font.pixelSize: 24
        onClicked: stackView.pop()
    }

    Item {
        Layout.fillWidth: true
    }

    Button {
        text: "Quit"
        font.pixelSize: 24
        onClicked: stackView.pop(null)
    }
}
