import QtQuick 2.0

Item{
    //color: "#468fd0"
    Image {
        anchors.fill: parent
        source: "qrc:/images/light.png"
    }
    Image{
        //anchors.centerIn: parent
        width: parent.width
        height: parent.width*paintedHeight/paintedHeight
        source: "qrc:/images/ring.png"
        fillMode: Image.PreserveAspectFit
    }
    opacity: 0.8
}
