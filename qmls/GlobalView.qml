import QtQuick 2.0
import "./GlobalViewConfig.js" as Global

Rectangle {
    id: global_view

    color: Qt.rgba(0, 0, 0, 0)

    property var currentItem //当前Item
    property int currentItemMode : Global.Mode_None //当前Item模式



    MouseArea{
        anchors.fill: parent

        visible: currentItemMode !== Global.Mode_None

        onPressed: {
            console.log("global_view pressed：", mouseX, mouseY)
            if(currentItemMode === Global.Mode_View){
                hideCurrentGlobalItem();
            }
        }
    }

    //显示View位置
    function showComponentInGlobal(component, mode, rect, pos){
        var obj = component.createObject(global_view);

        //Global Center
        var posX = global_view.width/2 - obj.width/2
        var posY = global_view.height/2 - obj.height/2

        var SPACING = 5

        if(Global.Pos_Left === pos){
            posX = rect.x - obj.width - SPACING
            posY = rect.y - rect.height / 2
        }
        else if(Global.Pos_Right === pos){
            posX = rect.x + rect.width + SPACING
            posY = rect.y + rect.height/2 - obj.height / 2
        }
        else if(Global.Pos_Bottom === pos){
            posX = rect.x + rect.width/2 - obj.width/2
            posY = rect.y + rect.height + SPACING
        }
        else if(Global.Pos_Top === pos){
            posX = rect.x - obj.width / 2
            posY = rect.y - obj.height - SPACING
        }
        else if(Global.Pos_TopLeft === pos){
            posX = rect.x - obj.width - SPACING
            posY = rect.y - obj.height - SPACING
        }
        else if(Global.Pos_TopRight === pos){
            posX = rect.x + rect.width + SPACING
            posY = rect.y - obj.height - SPACING
        }
        else if(Global.Pos_BottomLeft === pos){
            posX = rect.x - obj.width - SPACING
            posY = rect.y + rect.height + SPACING
        }
        else if(Global.Pos_BottomRight === pos){
            posX = rect.x + rect.width + SPACING
            posY = rect.y + rect.height + SPACING
        }
        else if(Global.Pos_Center === pos){
            posX = rect.x - obj.width / 2
            posY = rect.y - obj.height / 2
        }

        obj.x = posX;
        obj.y = posY;

        global_view.currentItemMode = mode;
        obj.visible = true;
        global_view.currentItem = obj;
        return obj;
    }

    function hideCurrentGlobalItem(){
        if(global_view.currentItem){
            global_view.currentItem.visible = false;
            global_view.currentItem.destroy();
        }
        global_view.currentItemMode = Global.Mode_None;
    }
}
