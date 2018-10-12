.pragma library

var GlobalView //全局顶层View

/*
  创建全局
*/
function createGlobalView(parent){
    var com = Qt.createComponent("PLGlobalView.qml")
    if(com.status === Component.Ready)
    {
        GlobalView = com.createObject(parent, {"parent": parent, "anchors.fill": parent});
    }
    else
    {
        console.log("创建GlobalView失败:", com.status, com.errorString())
    }
}

//窗体处于指定Rect的位置
var Pos_Left = 0
var Pos_Right = 1
var Pos_Bottom = 2
var Pos_Top = 3
var Pos_TopLeft = 4
var Pos_TopRight = 5
var Pos_BottomLeft = 6
var Pos_BottomRight = 7
var Pos_Center = 8
var Pos_GlobalCenter = 9

//模式
var Mode_None = 100
var Mode_Dialog = 101
var Mode_View = 102

//映射item的rect到全局
function itemPosToGlobal(item){
    return item.mapToItem(GlobalView, 0, 0, item.width, item.height);
}

//显示Item
function showComponentInGlobal(component){
    var mode = arguments[1] ? arguments[1] : Mode_View;
    var rect = arguments[2] ? arguments[2] : Qt.rect(0.4, 0.4, 0.2, 0.2);
    var pos = arguments[3] ? arguments[3] : Pos_GlobalCenter;
    return GlobalView.showComponentInGlobal(component, mode, rect, pos);
}

//销毁当前全局Item
function hideCurrentGlobalItem(){
    GlobalView.hideCurrentGlobalItem();
}
