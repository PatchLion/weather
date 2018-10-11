import QtQuick 2.0

BackGroundPanel {
    id: root_item
    property alias date: date_item.text
    property alias week: week_item.text
    property alias weather: weather_name.text
    property alias weatherIcon: weather_icon.source

    Row{
        anchors.fill: parent
        Column{
            anchors.verticalCenter: parent.verticalCenter
            width: parent.width/2
            Text{
                id: date_item
                color: Qt.rgba(1, 1, 1, 1)
                font.pointSize: 15
                font.family: "微软雅黑"
                horizontalAlignment: Text.AlignHCenter
                width:parent.width
            }
            Text{
                id: week_item
                color: Qt.rgba(1, 1, 1, 1)
                font.pointSize: 20
                font.family: "微软雅黑"
                horizontalAlignment: Text.AlignHCenter
                width:parent.width
            }
        }

        Column{
            anchors.verticalCenter: parent.verticalCenter
            width: parent.width/2
            Item{
                width: parent.width
                height: 80
                Image{
                    id: weather_icon
                    horizontalAlignment: Text.AlignHCenter
                    width:parent.height
                    height: parent.height
                    source: "qrc:/images/icon.png"
                    anchors.centerIn: parent

                }
            }
            Text{
                id: weather_name
                color: Qt.rgba(1, 1, 1, 1)
                font.pointSize: 16
                font.family: "微软雅黑"
                horizontalAlignment: Text.AlignHCenter
                width:parent.width
            }
        }
    }
}
