import QtQuick 2.3
import QtQuick.Window 2.2
import QtQuick.Layouts 1.1
import Qt.labs.controls 1.0

ApplicationWindow {
    // TODO: remove
    x: 400
    y: 400
    width: 1024
    height: 600
    visible: true

    StackView {
        anchors.fill: parent
        initialItem: LanguageScreen {}
    }
}
