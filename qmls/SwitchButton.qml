import QtQuick 2.0

Item {
    id: root_item

    property bool on: true
    property string onTitle: "AAAA"
    property string offTitle: "BBBB"
    property alias barHeight: bar_item.height
    height: bar_item.height + title_item.height + bar_item.anchors.topMargin
    Text{
        id: title_item
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        horizontalAlignment: Text.AlignHCenter
        text: on ? onTitle : offTitle
        color: Qt.rgba(1, 1, 1, 1)
        font.pointSize: 10
        font.family: "微软雅黑"
    }
    BackGroundPanel{
        id: bar_item
        radius: 10
        anchors.top: title_item.bottom
        anchors.topMargin: 3
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        height: 40

        Rectangle{
            color: Qt.rgba(1, 1, 1, 1)
            width: parent.height - 5
            height: parent.height - 5
            radius: width/2
            y: parent.height/2 - height/2
            x: on ? 5 : (parent.width - width - 5)
        }
    }

    MouseArea{
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        onClicked: {
            root_item.on = !on;
        }
    }
}
