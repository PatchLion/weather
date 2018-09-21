//Api请求封装基类
#ifndef APIREQUESTEX_H
#define APIREQUESTEX_H

#include <QtCore>
#include <QtNetwork>
#include <QJSValue>

class APIRequest : public QObject
{
    Q_OBJECT

public:
    /*
    *发送get请求
    * const QString& url: api的url
    * const QVariantMap& params: 参数
    *QVariant jsCallBack: 回调的JS函数
    */
    static void get(const QString& url, QVariant jsCallBack, const QVariantMap& params = QVariantMap(), const QVariantMap& headers = QVariantMap());

private:
    static QNetworkAccessManager *network();

private:
    static QNetworkAccessManager *g_network; //网络对象
};

#endif // APIREQUESTEX_H
