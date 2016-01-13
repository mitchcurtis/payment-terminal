import QtQuick 2.0
import Qt.labs.controls 1.0

Item {
    default property alias content: child.data
    property var customerData

    Item {
        id: child
        anchors.fill: parent
        anchors.leftMargin: 33
        anchors.rightMargin: 33
        anchors.topMargin: 20
        anchors.bottomMargin: 20
    }
}
