#include "datacache.h"
#include "apirequest.h"
#include "dbopreator.h"

static const QString kKey = "a1b8e04847844e99bfed52a308fab08f";
static const QString kWeatherURL = "https://free-api.heweather.com/s6/weather/forecast"; //天气预报
static const QString kAirNowURL = "https://free-api.heweather.com/s6/air/now"; //空气质量预报(当天)
static const QString kLifeStyleURL = "https://free-api.heweather.com/s6/weather/lifestyle"; //生活指数预报
static const QString kSearchURL = "https://search.heweather.com/find"; //城市搜索
static const QString kHotCitiesURL = "https://search.heweather.com/top"; //热门城市

//易源数据-天气预报
static const QString kSAWeatherURL = "http://saweather.market.alicloudapi.com/area-to-weather";

DataCache::DataCache(QObject *parent)
    : QObject(parent)
    , m_db(0)
{
    m_db = new DBOpreator(this);
}

DataCache *DataCache::instance()
{
    static DataCache cache;
    return &cache;
}

void DataCache::cities(const QString &keyword, QVariant jsCallBack)
{

    const QString res = m_db->cities(QString::fromLocal8Bit("成都"));

    QList<QJSValue> listValue;
    listValue << QJSValue(true);
    listValue << QJSValue("");
    listValue << QJSValue(res);


    if(jsCallBack.value<QJSValue>().isCallable()){
        jsCallBack.value<QJSValue>().call(listValue);
    }
}

void DataCache::hotCities(QVariant jsCallBack)
{
    QVariantMap params;
    params["key"] = kKey;
    params["group"] = "cn";
    params["number"] = 50;
    APIRequest::get(kHotCitiesURL, jsCallBack, params);
}

void DataCache::searchCity(const QString &keyword, QVariant jsCallBack)
{
    QVariantMap params;
    params["key"] = kKey;
    params["location"] = keyword;
    params["group"] = "cn";
    APIRequest::get(kSearchURL, jsCallBack, params);
}

void DataCache::getWeatherWithLocation(const QString &location, QVariant jsCallBack)
{
    /*
    QList<QJSValue> listValue;

    QFile file(":/test.json");
    file.open(QIODevice::ReadOnly);
    listValue << QJSValue(true);
    listValue << QJSValue("");
    listValue << QJSValue(QString::fromUtf8(file.readAll()));

    //listValue << QJSValue(false);
    //listValue << QJSValue(QString("Network error %1 with information: %2").arg(error).arg(data.data()));
    //listValue << QJSValue("");

    if(jsCallBack.value<QJSValue>().isCallable()){
        jsCallBack.value<QJSValue>().call(listValue);
    }

    return;
    */
    QVariantMap params;
    params["key"] = kKey;
    params["location"] = location;
    APIRequest::get(kWeatherURL, jsCallBack, params);
}

void DataCache::getLifestyleWithLocation(const QString &location, QVariant jsCallBack)
{
    QVariantMap params;
    params["key"] = kKey;
    params["location"] = location;
    APIRequest::get(kLifeStyleURL, jsCallBack, params);
}

void DataCache::getAirNowWithLocation(const QString &location, QVariant jsCallBack)
{
    QVariantMap params;
    params["key"] = kKey;
    params["location"] = location;
    APIRequest::get(kAirNowURL, jsCallBack, params);
}

void DataCache::getSAWeather(const QString &location, QVariant jsCallBack)
{
    QVariantMap params;
    params["area"] = location;

    QVariantMap headers;
    headers["Authorization"] = "APPCODE 377ab35f6c624993b54e8c75345d23ba";
    headers["Content-Type"] = "application/json; charset=utf-8";
    APIRequest::get(kSAWeatherURL, jsCallBack, params, headers);
}
