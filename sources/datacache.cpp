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

void DataCache::test()
{
    qDebug() << "TESTEST";
}

void DataCache::getWeatherWithLocation(const QString &location, QVariant jsCallBack)
{
    QVariantMap params;
    params["key"] = kKey;
    params["location"] =  location;
    APIRequest::get(kWeatherURL, jsCallBack, params);
}
