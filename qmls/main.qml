import QtQuick 2.9
import QtQuick.Window 2.2

Window {
    visible: true
    width: 640
    height: 480
    title: qsTr("Hello World")

    RainCanvas{
        anchors.fill: parent
    }

    Component.onCompleted: {
        DataCache.getWeatherWithLocation("成都", function(suc, msg, data){
            console.log(suc, msg, data);
            var jdata = JSON.parse(data);
            console.log("DATA:", jdata["HeWeather6"]["update"]["loc"]);
        });
    }
}
