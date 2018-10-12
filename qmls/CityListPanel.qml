import QtQuick 2.0

BackGroundPanel {
    id: root_item
    border.color: Qt.rgba(0, 0, 0, 0.3)
    color: Qt.rgba(1, 1, 1, 0.9)
    radius: 6

    signal cityChanged(string name);

    Component.onCompleted: {
        var cities = DataCache.allCity();
        console.log("cities=", cities);
        var cities_json = [];
        for(var i = 0; i < cities.length; i++){
            cities_json.push({"name":cities[i]});
            //console.log("cities=", cities[i]);
        }
        data_model.clear();
        data_model.append(cities_json);
    }

    GridView{
        id: cities_item
        anchors.fill: parent

        cellWidth: parent.width / 4
        cellHeight: parent.height / 8

        model: ListModel{
            id: data_model
        }

        clip: true

        delegate: Item{
            width: cities_item.cellWidth
            height: cities_item.cellHeight
            Text{
                anchors.centerIn: parent
                horizontalAlignment: Text.AlignHCenter
                text: name
                color: Qt.rgba(0, 0, 0, 1)
                font.bold: true
                font.pointSize: 14
                font.family: "微软雅黑"
            }

            MouseArea{
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                onClicked: {
                    root_item.cityChanged(name);
                }
            }
        }
    }
}
