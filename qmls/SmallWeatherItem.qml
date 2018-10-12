import QtQuick 2.0

BackGroundPanel{
    property alias icon: icon_item.source
    property alias title: title_item.text
    property alias value: value_item.text
    property alias valueWidth: value_item.width
    Image{
        id: icon_item
        width: parent.width * 2 / 5
        height: parent.width * 2 / 5
        anchors.centerIn: parent
        anchors.verticalCenterOffset: -25
        source: "qrc:/images/icon.png"
    }

    Text{
        id: title_item
        color: Qt.rgba(1, 1, 1, 1)
        font.pointSize: 14
        font.family: "微软雅黑"
        anchors.top: icon_item.bottom
        anchors.topMargin: 2
        anchors.horizontalCenter: parent.horizontalCenter
    }

    Text{
        id: value_item
        color: Qt.rgba(1, 1, 1, 1)
        font.pointSize: 13
        font.family: "微软雅黑"
        anchors.top: title_item.bottom
        anchors.topMargin: 2
        anchors.horizontalCenter: parent.horizontalCenter
        wrapMode: Text.Wrap
    }
}
