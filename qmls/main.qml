import QtQuick 2.9
import QtQuick.Window 2.2
import "./ApiResultResolve.js" as ApiResolve

Window {
    visible: true
    width: 640
    height: 480
    title: qsTr("Hello World")


    /*
    Cloud{
        anchors.left: parent.left
        anchors.top: parent.top
        width: parent.width/2
        height: parent.height/2
    }
    */
    Rain {
        anchors.right: parent.right
        anchors.top: parent.top
        width: parent.width / 2
        height: parent.height / 2
    }

    Component.onCompleted: {
        DataCache.getSAWeather("成都", function (suc, msg, data) {
            var results = ApiResolve.resolveAPIResponse(suc, msg, data, true)
            console.log(results[0], results[1], results[2]);
        })

        DataCache.hotCities(function (suc, msg, data) {
            var results = ApiResolve.resolveAPIResponse(suc, msg, data, true)
            console.log(results[0], results[1], results[2]);
        })


        DataCache.cities("", function (suc, msg, data) {
            var results = ApiResolve.resolveAPIResponse(suc, msg, data, true)
            console.log(results[0], results[1], results[2]);
        })
    }

    Sun {
        anchors.left: parent.left
        anchors.bottom: parent.bottom
        width: parent.width / 2
        height: parent.height / 2
    }

    Snow {
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        width: parent.width / 2
        height: parent.height / 2
    }
}
