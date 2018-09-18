#include "datacache.h"
#include "apirequest.h"

static const QString kKey = "a1b8e04847844e99bfed52a308fab08f";
static const QString kWeatherURL = "https://free-api.heweather.com/s6/weather/forecast";

DataCache::DataCache(QObject *parent)
    : QObject(parent)
{

}

DataCache *DataCache::instance()
{
    static DataCache cache;
    return &cache;
}

void DataCache::getWeatherWithLocation(const QString &location, QVariant jsCallBack)
{
    QList<QJSValue> listValue;

    QFile file(":/test.json");
    file.open(QIODevice::ReadOnly);
    listValue << QJSValue(true);
    listValue << QJSValue("");
    listValue << QJSValue(QString::fromUtf8(file.readAll()));

    /*
    listValue << QJSValue(false);
    listValue << QJSValue(QString("Network error %1 with information: %2").arg(error).arg(data.data()));
    listValue << QJSValue("");
    */


    if(jsCallBack.value<QJSValue>().isCallable()){
        jsCallBack.value<QJSValue>().call(listValue);
    }

    return;
    QVariantMap params;
    params["key"] = kKey;
    params["location"] = location;
    APIRequest::get(kWeatherURL, jsCallBack, params);
}
