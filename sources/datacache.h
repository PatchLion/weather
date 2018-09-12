#ifndef DATACACHE_H_
#define DATACACHE_H_

#include <QtCore>

class DataCache : public QObject
{
    Q_OBJECT
private:
    DataCache(QObject *parent=0);

public:
    static DataCache *instance();

public:
    Q_INVOKABLE void test();

    //获取城市的天气
    Q_INVOKABLE void getWeatherWithLocation(const QString& location, QVariant jsCallBack);

private:
    static DataCache *g_instance;
};

#endif
