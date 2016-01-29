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
        spacing: 0

        RowLayout {
            id: rowLayout
            spacing: 0

            Button {
                id: backButton
                Layout.fillHeight: true
                visible: backButtonEnabled
                onClicked: stackView.pop()

                background: Item {
                    implicitWidth: 198
                }

                label: Text {
                    x: backButton.leftPadding
                    y: backButton.topPadding
                    width: backButton.availableWidth
                    height: backButton.availableHeight
                    text: "Back"
                    font.pixelSize: 30
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
                rightPadding: 15

                background: Item {
                    implicitWidth: 198
                }

                label: RowLayout {
                    x: quitButton.leftPadding
                    y: quitButton.topPadding
                    width: quitButton.availableWidth
                    height: quitButton.availableHeight

                    Text {
                        text: "Quit"
                        font.pixelSize: 30
                        color: "#ffffff"
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        elide: Text.ElideRight
                        Layout.fillWidth: true
                    }

                    Image {
                        source: "qrc:/images/Close-btn.png"
                    }
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
        visible: backButtonEnabled
    }

    Rectangle {
        x: parent.width - quitButton.width - width
        width: 2
        height: columnLayout.height
        color: root.separatorColor
    }
}
