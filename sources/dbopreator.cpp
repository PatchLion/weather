#include "dbopreator.h"
#include <QDebug>
#include <QSqlError>
#include <QSqlQuery>

DBOpreator::DBOpreator(QObject *parent)
    : QObject(parent)
{

}

DBOpreator::~DBOpreator()
{
}

QString DBOpreator::cities(const QString &keyword)
{
    QSqlDatabase database = QSqlDatabase::addDatabase("QSQLITE");
    database.setDatabaseName("/Users/patchlion/projects/weather/weathers.db");

    if (!database.open())
    {
        qWarning() << "Error: Failed to connect database." << database.lastError();
        return "{}";
    }
    QSqlQuery sql_query;
    QString select_sql = "SELECT * FROM Area";
    if(!keyword.isEmpty())
    {
        select_sql += " WHERE NAMECN LIKE '%" + keyword + "%'";
    }
    //sql_query.prepare(select_sql);

    if(!sql_query.exec(select_sql))
    {
        qDebug()<<sql_query.lastError();
    }
    else
    {
        while(sql_query.next())
        {
            QString id = sql_query.value(0).toString();
            QString name = sql_query.value(1).toString();
            qDebug()<<id << " " << name;
        }
    }

}
