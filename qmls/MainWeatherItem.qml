import QtQuick 2.0
import QtQml 2.2

BackGroundPanel {
    id: root_item

    property alias weather: weather_name.text
    property int weatherCode: -1
    property alias weatherIcon: weather_icon.source
    property int dayOffset: -1

    property var weekChars: ["天", "一", "二", "三", "四", "五", "六"]

    onDayOffsetChanged: {
        var date = new Date(new Date().getTime() + root_item.dayOffset * 24 * 60 * 60 * 1000)
        date_item.text = date.getFullYear() + "年" + (date.getMonth()+1) + "月" + date.getDate() +"日";
        week_item.text = "星期"+weekChars[date.getDay()];
    }

    Row {
        anchors.fill: parent
        Column {
            anchors.verticalCenter: parent.verticalCenter
            width: parent.width * 3 / 5
            Text {
                id: date_item
                color: Qt.rgba(1, 1, 1, 1)
                font.pointSize: 16
                font.family: "微软雅黑"
                horizontalAlignment: Text.AlignHCenter
                width: parent.width

                //left
                ArrowButton{
                    id: left_arrow
                    source: "qrc:/images/left.png"
                    anchors.left: parent.left
                    anchors.leftMargin: 3
                    anchors.verticalCenter: parent.verticalCenter
                    visible: root_item.dayOffset > 0
                    onClicked: {
                        root_item.dayOffset = root_item.dayOffset-1;
                    }
                }

                //right
                ArrowButton{
                    id: right_arrow
                    source: "qrc:/images/right.png"
                    anchors.right: parent.right
                    anchors.rightMargin: 3
                    anchors.verticalCenter: parent.verticalCenter
                    visible: root_item.dayOffset < 7
                    onClicked: {
                        root_item.dayOffset = root_item.dayOffset+1;
                    }
                }
            }
            Text {
                id: week_item
                color: Qt.rgba(1, 1, 1, 1)
                font.pointSize: 18
                font.family: "微软雅黑"
                horizontalAlignment: Text.AlignHCenter
                width: parent.width
            }
        }

        Column {
            anchors.verticalCenter: parent.verticalCenter
            width: parent.width * 2 / 5
            Item {
                width: parent.width
                height: 80
                Image {
                    id: weather_icon
                    horizontalAlignment: Text.AlignHCenter
                    width: parent.height
                    height: parent.height
                    source: "qrc:/images/icon.png"
                    anchors.centerIn: parent
                }
            }
            Text {
                id: weather_name
                color: Qt.rgba(1, 1, 1, 1)
                font.pointSize: 16
                font.family: "微软雅黑"
                horizontalAlignment: Text.AlignHCenter
                width: parent.width
            }
        }
    }
}
