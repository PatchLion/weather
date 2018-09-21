.pragma library

//函数运行计时
function runFuncWithUseTime(func, funcname){
    var start = new Date().getTime();//起始时间
    var pars = [];
    for (var i = 0; i<arguments.length; i++){
        pars.push(arguments[i]);
    }
    pars.splice(0, 2);
    var result = func.apply(this, pars);
    var end = new Date().getTime();//结束时间

    console.log("===> Run", "<"+funcname+">", "use time(s):", (end-start)/1000,"(", start/1000, ",", end/1000, ")");
    return result;
}

/*
  解析生成API回调后结果
  返回值[true, 数据]或[false, 错误消息]
*/
function resolveAPIResponse(suc, msg, data){
    var isPrintDebug = arguments[3] ? arguments[3] : false;//默认值为false 不打印Debug信息
    if(suc){
        return resolveStandardData(data, isPrintDebug);
    }
    else{
        return [false, msg];
    }
}

/*
  解析api标准格式数据
  返回值[true, 数据]或[false, 错误消息]
*/
function resolveStandardData(ori_data){
    var result = [false, "不能解析数据格式"];
    var isPrintDebug = arguments[1] ? arguments[1] : false;//默认值为false 不打印Debug信息
    if(isPrintDebug){
        console.log("接收到API返回数据:" + ori_data);
    }
    if(ori_data){
        var obj = runFuncWithUseTime(JSON.parse, "JSON.parse", ori_data);

        console.log("=================>", obj["HeWeather6"], obj["HeWeather6"]["status"]);
        var msg = obj.HeWeather6.status;
        var data = obj.HeWeather6;

        if(msg){
            result = [false, msg];
        }
        else{
            result = [true, data];
        }
    }

    if(isPrintDebug){
        console.log("解析结果:", result[0], (!result[0] ? result[1] : "<data>"));
    }
    return result;
}
