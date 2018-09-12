#include "APIRequest.h"
#include <QThread>
#include "APIRequestPrivate.h"

typedef QMap<QThread*, QNetworkAccessManager*> MapThreadToNetworkAccessManager;

namespace APIRequestNS {
    MapThreadToNetworkAccessManager  g_threadToNetworkManager;
}

QString variantToString(const QVariant& var)
{
    switch(var.type())
    {
    case QVariant::Bool: return QString("%1").arg(var.toBool());
    case QVariant::Int: return QString("%1").arg(var.toInt());
    case QVariant::UInt: return QString("%1").arg(var.toUInt());
    case QVariant::LongLong: return QString("%1").arg(var.toLongLong());
    case QVariant::ULongLong: return QString("%1").arg(var.toULongLong());
    case QVariant::Double: return QString("%1").arg(var.toDouble(), 0, 'f', 2);
    case QVariant::Char: return var.toChar();
    case QVariant::String: return var.toString();
    }



    return "";
}
void APIRequest::get(const QString &url, QVariant jsCallBack, const QVariantMap &params)
{
    //构建
    QString tempUrl = url;
    if(!params.isEmpty())
    {
        tempUrl += "?";
        const QStringList keys = params.keys();
        for(int i = 0; i < keys.size(); i++)
        {
           const QString key = keys[i];

           if(i == 0)
           {
               tempUrl += QString("%1=%2").arg(key).arg(variantToString(params[key]));
           }
           else
           {
               tempUrl += QString("&%1=%2").arg(key).arg(variantToString(params[key]));
           }
        }
    }


    QNetworkRequest request(tempUrl);


    QNetworkReply* reply = APIRequest::network()->get(request);

    APIRequestPrivate* p = new APIRequestPrivate(reply, jsCallBack.value<QJSValue>(), APIRequest::network());
}

QNetworkAccessManager *APIRequest::network()
{
    QThread* thread = QThread::currentThread();
    Q_ASSERT(thread);

    if(!APIRequestNS::g_threadToNetworkManager.contains(thread))
    {
        QNetworkAccessManager* network = new QNetworkAccessManager;
        network->moveToThread(thread);
        APIRequestNS::g_threadToNetworkManager[thread] = network;
    }


    return APIRequestNS::g_threadToNetworkManager[thread];
}
