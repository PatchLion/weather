import QtQuick 2.0
import QtQuick.Window 2.2
import QtGraphicalEffects 1.0
import "GlobalViewConfig.js" as GlobalV

Window {
    id: root_window
    visible: true
    width: 1024
    height: 600
    minimumWidth: 1024
    title: ""
    property alias cityName: weather_panel_item.cityName
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
        dayOffset: 0

        cityName: "成都"
        isShowLeftIndexOnState: !index_type_switch_item.on

        onWeatherCodeChanged: {
            if(weatherCode >=3 && weatherCode <= 12)
            {
                //下雨
                showWeather(rain);
            }
            else if(weatherCode === 0)
            {
                //晴天
                showWeather(sun);
            }
            else if(weatherCode === 2)
            {
                //阴
                showWeather();
            }
            else if(weatherCode >=13 && weatherCode <= 17)
            {
                //下雪
                showWeather(snow);
            }
            else
            {
                //默认
                showWeather(default_weather);
            }
        }
    }
    SwitchButton{
        id: index_type_switch_item
        anchors.right: weather_panel_item.right
        anchors.rightMargin: 10
        anchors.bottom: weather_panel_item.top
        anchors.bottomMargin: 5
        width: 40
        barHeight: 30
        onTitle: "天气指数"
        offTitle: "生活指数"
    }

    BackGroundPanel{
        anchors.left: parent.left
        anchors.leftMargin: 30
        anchors.top: parent.top
        anchors.topMargin: 15
        width: 54
        height: 48

        color:Qt.rgba(1, 1, 1, 0.0)
        Image{
            id: local_icon
            source: "qrc:/images/location_city.png"
            fillMode: Image.PreserveAspectFit


            anchors.fill: parent
            property var temp_obj

            MouseArea{
                id: mouseArea
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor

                onClicked: {
                    local_icon.temp_obj = GlobalV.showComponentInGlobal(city_list_panel_component, GlobalV.Mode_View, GlobalV.itemPosToGlobal(mouseArea), GlobalV.Pos_GlobalCenter);
                }
            }

            Text
            {
                anchors.top: parent.bottom
                anchors.topMargin: 1
                anchors.horizontalCenter: parent.horizontalCenter

                horizontalAlignment: Text.AlignHCenter
                text: root_window.cityName
                color: Qt.rgba(1, 1, 1, 0.7)
                font.pointSize: 17
                font.family: "微软雅黑"
            }


            Component{
                id: city_list_panel_component
                CityListPanel{
                    width: 500
                    height: 400
                    visible: false

                    onCityChanged: {
                        root_window.cityName = name;

                        GlobalV.hideCurrentGlobalItem(local_icon.temp_obj);
                    }
                }
            }
        }
    }

    GlobalView{
        anchors.fill: parent
        Component.onCompleted: {
            GlobalV.GlobalView = this;
        }
    }
}
