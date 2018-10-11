import QtQuick 2.0

Image{
    id: root_item

    signal clicked();

    width: 10
    height: 18
    //source: "qrc:/images/right.png"
    opacity: 0.3

    MouseArea{
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        onClicked: {
            root_item.clicked();
        }
    }
}
