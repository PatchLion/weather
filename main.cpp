#include <QGuiApplication>
#include <QtGui>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "datacache.h"

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);
    app.setWindowIcon(QIcon(":/images/icon.png"));


    QQmlApplicationEngine engine;
    engine.rootContext()->setContextProperty("DataCache", DataCache::instance());
    engine.load(QUrl(QStringLiteral("qrc:/qmls/MainWindows.qml")));

    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
