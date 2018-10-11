import QtQuick 2.0
import QtQuick.Window 2.2
import QtGraphicalEffects 1.0

Window {
    id: root_window
    visible: true
    width: 1024
    height: 600
    minimumWidth: 1024
    title: ""
    property string cityName: "成都"
    property var current: default_weather
    Image{
        source: DataCache.cityImage(cityName)
        anchors.fill: parent
    }
    Sun{
        id: sun
        anchors.fill: parent
        opacity: 0
    }
    Snow{
        id: snow
        anchors.fill: parent
        opacity: 0
    }
    Rain{
        id: rain
        anchors.fill: parent
        opacity: 0
    }
    Item{
        id: default_weather
        opacity: 1
    }

    PropertyAnimation{
        id:show_weather
        property: "opacity"
        from:0
        to:1
        duration: 400
    }
    PropertyAnimation{
        id:hide_weather
        property: "opacity"
        from:1
        to:0
        duration: 400
    }

    function showWeather(next){
        if(root_window.current !== next)
        {
            show_weather.target = next;
            hide_weather.target = root_window.current;
            show_weather.running = true;
            hide_weather.running = true;
            root_window.current  = next;
        }
    }


    WeatherPanel{
        id: weather_panel_item
        height: 160
        anchors.left: parent.left
        anchors.bottom: parent.bottom
        anchors.right: parent.right

        isShowLeftIndexOnState: !index_type_switch_item.on
    }
    SwitchButton{
        id: index_type_switch_item
        anchors.right: weather_panel_item.right
        anchors.rightMargin: 10
        anchors.bottom: weather_panel_item.top
        anchors.bottomMargin: 5
        width: 50
        barHeight: 40
        onTitle: "天气指数"
        offTitle: "生活指数"
    }

}
