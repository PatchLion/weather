import QtQuick 2.0
import "./ApiResultResolve.js" as ApiResolve

Item {
    id: root_item

    property bool isShowLeftIndexOnState: false //展示生活指数
    property alias dayOffset: main_weather_panel.dayOffset
    property string cityName: ""
    property alias weatherCode: main_weather_panel.weatherCode

    function updateWeather(day){

        if(weather_infos.length > day)
        {
            var w = weather_infos[day];
            jsl_panel.value = w.jiangshui;
            zdwd_panel.value = w.night_air_temperature+"℃";
            zgwd_panel.value = w.day_air_temperature+"℃";
            fl_panel.value = w.day_wind_power;
            ywfl_panel.value = w.night_wind_power;

            xczs_panel.value = w.wash_car.title;
            kqzl_panel.value = w.aqi.title;
            cyzs_panel.value = w.clothes.title;
            sszs_panel.value = w.travel.title;
            cxzs_panel.value = w.yh.title;
            main_weather_panel.weather = w.day_weather;
            main_weather_panel.weatherCode = parseInt(w.day_weather_code);
        }
    }

    onCityNameChanged: {
        DataCache.getLocalServerWeather(cityName, function(suc, msg, data){
            var results = ApiResolve.resolveAPIResponse(suc, msg, data, true);
            root_item.weather_infos = results[1].days;
            main_weather_panel.dayOffset = 0;
            updateWeather(main_weather_panel.dayOffset);
        });
    }

    property var weather_infos

    Item{
        id: center_item
        anchors.fill: parent
        anchors.margins: 1
        property int spacing: 1
        property int smallPanelWidth: (parent.width-main_weather_panel.width-6*center_item.spacing)/5


        //主面板
        MainWeatherItem{
            id: main_weather_panel
            anchors.left: parent.left
            anchors.bottom: parent.bottom
            width: 300
            height: parent.height
            weather: "晴"

            onDayOffsetChanged: {
                root_item.updateWeather(dayOffset);
            }

            onWeatherCodeChanged: {
                if(weatherCode >=3 && weatherCode <= 12)
                {
                    //下雨
                    weatherIcon = "qrc:/images/weathers/shower3.png";
                }
                else if(weatherCode === 0)
                {
                    //晴天
                    weatherIcon = "qrc:/images/weathers/sunny.png";
                }
                else if(weatherCode === 2)
                {
                    //阴
                    weatherIcon = "qrc:/images/weathers/mist_night.png";
                }
                else if(weatherCode >=13 && weatherCode <= 17)
                {
                    //下雪
                    weatherIcon = "qrc:/images/weathers/snow5.png";
                }
                else
                {
                    //默认
                    weatherIcon = "qrc:/images/weathers/mist.png";
                }
            }
        }

        //天气指数
        Item{
            visible: !root_item.isShowLeftIndexOnState

            anchors.left: main_weather_panel.right
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            height: main_weather_panel.height

            //降水量
            SmallWeatherItem{
                id: jsl_panel
                anchors.left: parent.left
                anchors.leftMargin: center_item.spacing
                anchors.verticalCenter: parent.verticalCenter
                width: center_item.smallPanelWidth
                height: parent.height
                title: "降雨概率"
                value: ""
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
                value: ""
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
                value: ""
            }

            //白天风力
            SmallWeatherItem{
                id: fl_panel
                anchors.left: zgwd_panel.right
                anchors.leftMargin: center_item.spacing
                anchors.verticalCenter: parent.verticalCenter
                width: center_item.smallPanelWidth
                height: parent.height
                title: "白天风力"
                value: ""
            }


            //夜晚风力
            SmallWeatherItem{
                id: ywfl_panel
                anchors.left: fl_panel.right
                anchors.leftMargin: center_item.spacing
                anchors.verticalCenter: parent.verticalCenter
                width: center_item.smallPanelWidth
                height: parent.height
                title: "夜晚风力"
                value: ""
            }

        }

        //生活指数
        Item{
            visible: root_item.isShowLeftIndexOnState

            anchors.left: main_weather_panel.right
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            height: main_weather_panel.height
            //出行指数
            SmallWeatherItem{
                id: cxzs_panel
                anchors.left: parent.left
                anchors.leftMargin: center_item.spacing
                anchors.verticalCenter: parent.verticalCenter
                width: center_item.smallPanelWidth
                height: parent.height
                title: "出行指数"
                value: ""
            }
            //舒适指数
            SmallWeatherItem{
                id: sszs_panel

                anchors.left: cxzs_panel.right
                anchors.leftMargin: center_item.spacing
                anchors.verticalCenter: parent.verticalCenter
                width: center_item.smallPanelWidth
                height: parent.height
                title: "舒适指数"
                value: ""
            }
            //穿衣指数
            SmallWeatherItem{
                id: cyzs_panel
                anchors.left: sszs_panel.right
                anchors.leftMargin: center_item.spacing
                anchors.verticalCenter: parent.verticalCenter
                width: center_item.smallPanelWidth
                height: parent.height
                title: "穿衣指数"
                value: ""
            }

            //空气质量
            SmallWeatherItem{
                id: kqzl_panel
                anchors.left: cyzs_panel.right
                anchors.leftMargin: center_item.spacing
                anchors.verticalCenter: parent.verticalCenter
                width: center_item.smallPanelWidth
                height: parent.height
                title: "空气质量"
                value: ""
            }

            //洗车指数
            SmallWeatherItem{
                id: xczs_panel

                anchors.left: kqzl_panel.right
                anchors.leftMargin: center_item.spacing
                anchors.verticalCenter: parent.verticalCenter
                width: center_item.smallPanelWidth
                height: parent.height
                title: "空气质量"
                value: ""
            }

        }
    }
}
