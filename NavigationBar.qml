import QtQuick 2.0
import QtQuick.Layouts 1.0
import Qt.labs.controls 1.0

Item {
    id: root
    height: 65

    property StackView stackView
    readonly property color color: "#015289"

    Rectangle {
        color: root.color
        anchors.fill: parent
    }

    RowLayout {
        id: rowLayout
        anchors.fill: parent
        spacing: 0

        Button {
            id: backButton
            Layout.fillHeight: true
            onClicked: stackView.pop()

            background: Item {
                implicitWidth: 160
            }

            label: Text {
                x: backButton.leftPadding
                y: backButton.topPadding
                width: backButton.availableWidth
                height: backButton.availableHeight
                text: "Back"
                font.pixelSize: 24
                color: "#ffffff"
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                elide: Text.ElideRight
            }
        }

        Rectangle {
            width: 1
            Layout.fillHeight: true
            color: "#4982aa"
        }

        Item {
            Layout.fillWidth: true
        }

        Rectangle {
            width: 1
            Layout.fillHeight: true
            color: "#4982aa"
        }

        Button {
            id: quitButton
            Layout.fillHeight: true
            onClicked: stackView.pop(null)

            background: Item {
                implicitWidth: 160
            }

            label: Text {
                x: quitButton.leftPadding
                y: quitButton.topPadding
                width: quitButton.availableWidth
                height: quitButton.availableHeight
                text: "Quit"
                font.pixelSize: 24
                color: "#ffffff"
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                elide: Text.ElideRight
            }
        }
    }
}
