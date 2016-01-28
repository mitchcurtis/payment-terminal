import QtQuick 2.0
import QtQuick.Layouts 1.0
import Qt.labs.controls 1.0

Item {
    id: root
    height: 80

    property StackView stackView
    readonly property color color: "#646464"
    readonly property color accentColor: "#e9500e"
    readonly property color lightAccentColor: "#d6d6d6"
    readonly property color separatorColor: "#4c939393"
    property bool backButtonEnabled: true

    Rectangle {
        color: root.color
        anchors.fill: parent
    }

    ColumnLayout {
        id: columnLayout
        anchors.fill: parent

        RowLayout {
            id: rowLayout
            spacing: 0

            Button {
                id: backButton
                Layout.fillHeight: true
                visible: backButtonEnabled
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

            Item {
                Layout.fillWidth: true
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

        Rectangle {
            Layout.fillWidth: true
            Layout.preferredHeight: 8
            color: root.accentColor
        }
    }

    Rectangle {
        x: backButton.width
        width: 2
        height: columnLayout.height
        color: root.separatorColor
    }

    Rectangle {
        x: backButton.mapToItem(null, 0, 0).x - width
        // TODO:
        onXChanged: print(x, backButton.x)
        width: 2
        height: columnLayout.height
        color: root.separatorColor
    }
}
