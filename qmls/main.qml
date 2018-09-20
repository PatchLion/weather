import QtQuick 2.9
import QtQuick.Window 2.2

Window {
    visible: true
    width: 640
    height: 480
    title: qsTr("Hello World")

    Cloud{
        anchors.left: parent.left
        anchors.top: parent.top
        width: parent.width/2
        height: parent.height/2
    }

    Rain{
        anchors.right: parent.right
        anchors.top: parent.top
        width: parent.width/2
        height: parent.height/2
    }

    Component.onCompleted: {
        DataCache.getWeatherWithLocation("成都", function(suc, msg, data){
            console.log(suc, msg, data);
            var jdata = JSON.parse(data);
            console.log("DATA:", jdata["HeWeather6"]["update"]["loc"]);
        });
    }

    Sun{
        anchors.left: parent.left
        anchors.bottom: parent.bottom
        width: parent.width/2
        height: parent.height/2
    }

    Snow{
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        width: parent.width/2
        height: parent.height/2
    }
}
