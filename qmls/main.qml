import QtQuick 2.9
import QtQuick.Window 2.2

Window {
    visible: true
    width: 640
    height: 480
    title: qsTr("Hello World")
    Component.onCompleted: {
        DataCache.getWeatherWithLocation("德阳", function(suc, msg, data){
            console.log(suc, msg, data);
        });
    }
}
