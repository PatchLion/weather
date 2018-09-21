#ifndef DATACACHE_H_
#define DATACACHE_H_

#include <QtCore>

/*
 * jsCallBack定义:
 *
 * function func(suc, msg, data)
 * {
 *
 * }
 *
 * suc表示请求是否成功
 * msg为失败后的描述小时
 * data为成功后返回的数据
 */
class DataCache : public QObject
{
    Q_OBJECT
private:
    DataCache(QObject *parent=0);

public:
    static DataCache *instance();

public:

    /*
     * 函数名: 热门城市
     * API文档地址: https://www.heweather.com/documents/search/top
     *参数:
     * QVariant jsCallBack: JS回调函数，参考上面 jsCallBack定义
     */
    Q_INVOKABLE void hotCities(QVariant jsCallBack);

    /*
     * 函数名: 搜索城市
     * API文档地址: https://www.heweather.com/documents/search/find
     *参数:
     * const QString& location: 城市关键字， 可参考文档中location参数说明
     * QVariant jsCallBack: JS回调函数，参考上面 jsCallBack定义
     */
    Q_INVOKABLE void searchCity(const QString& keyword, QVariant jsCallBack);

    /*
     * 函数名: 获取城市的天气预报预报
     * API文档地址: https://www.heweather.com/douments/api/s6/weather-forecast
     *参数:
     * const QString& location: 城市名称等， 可参考文档中location参数说明
     * QVariant jsCallBack: JS回调函数，参考上面 jsCallBack定义
     */
    Q_INVOKABLE void getWeatherWithLocation(const QString& location, QVariant jsCallBack);

    /*
     * 函数名: 获取城市的生活指数预报
     * API文档地址: https://www.heweather.com/documnets/api/s6/lifestyle
     *参数:
     * const QString& location: 城市名称等， 可参考文档中location参数说明
     * QVariant jsCallBack: JS回调函数，参考上面 jsCallBack定义
     */
    Q_INVOKABLE void getLifestyleWithLocation(const QString& location, QVariant jsCallBack);

    /*
     * 函数名: 获取城市的空气质量预报(当天)
     * API文档地址: https://www.heweather.com/documents/api/s6/air-now
     *参数:
     * const QString& location: 城市名称等， 可参考文档中location参数说明
     * QVariant jsCallBack: JS回调函数，参考上面 jsCallBack定义
     */
    Q_INVOKABLE void getAirNowWithLocation(const QString& location, QVariant jsCallBack);

    /*
     * 函数名: 获取天气预报(易源数据)
     * API文档地址: https://market.aliyun.com/products/56928004/cmapi014123.html
     *参数:
     * const QString& location: 城市名称等， 可参考文档中location参数说明
     * QVariant jsCallBack: JS回调函数，参考上面 jsCallBack定义
     */
    Q_INVOKABLE void getSAWeather(const QString& location, QVariant jsCallBack);
private:
    //缓存根路径
    static  QString cacheRootDir();

private:
    static DataCache *g_instance;
};

#endif
