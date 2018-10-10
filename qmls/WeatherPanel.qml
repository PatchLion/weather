import QtQuick 2.0

Item {
    id: root_item
    Item{
        id: center_item
        anchors.fill: parent
        anchors.margins: 1
        property int spacing: 1
        property int smallPanelWidth: (parent.width-main_weather_panel.width-6*center_item.spacing)/6

        //主面板
        MainWeatherItem{
            id: main_weather_panel
            anchors.left: parent.left
            anchors.bottom: parent.bottom
            width: 300
            height: parent.height
            date: "2018年10月11日"
            week: "星期二"
            weather: "晴"
        }
        //降水量
        SmallWeatherItem{
            id: jsl_panel
            anchors.left: main_weather_panel.right
            anchors.leftMargin: center_item.spacing
            anchors.verticalCenter: parent.verticalCenter
            width: center_item.smallPanelWidth
            height: parent.height
            title: "降水量"
            value: "300ml"
        }
        //最低温度
        SmallWeatherItem{
            id: zdwd_panel
            anchors.left: jsl_panel.right
            anchors.leftMargin: center_item.spacing
            anchors.verticalCenter: parent.verticalCenter
            width: center_item.smallPanelWidth
            height: parent.height
            title: "最低温度"
            value: "300ml"
        }
        //最高温度
        SmallWeatherItem{
            id: zgwd_panel
            anchors.left: zdwd_panel.right
            anchors.leftMargin: center_item.spacing
            anchors.verticalCenter: parent.verticalCenter
            width: center_item.smallPanelWidth
            height: parent.height
            title: "最高温度"
            value: "300ml"
        }

        //风力
        SmallWeatherItem{
            id: fl_panel
            anchors.left: zgwd_panel.right
            anchors.leftMargin: center_item.spacing
            anchors.verticalCenter: parent.verticalCenter
            width: center_item.smallPanelWidth
            height: parent.height
            title: "风力"
            value: "300ml"
        }


        //空气湿度
        SmallWeatherItem{
            id: kqsd_panel
            anchors.left: fl_panel.right
            anchors.leftMargin: center_item.spacing
            anchors.verticalCenter: parent.verticalCenter
            width: center_item.smallPanelWidth
            height: parent.height
            title: "空气湿度"
            value: "300ml"
        }


        //能见度
        SmallWeatherItem{
            id: njd_panel
            anchors.left: kqsd_panel.right
            anchors.leftMargin: center_item.spacing
            anchors.verticalCenter: parent.verticalCenter
            width: center_item.smallPanelWidth
            height: parent.height
            title: "能见度"
            value: "300ml"
        }
    }
}
