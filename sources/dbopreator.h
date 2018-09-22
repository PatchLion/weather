#ifndef DBOPREATOR_H
#define DBOPREATOR_H

#include <QObject>

class DBOpreator : public QObject
{
    Q_OBJECT
public:
    explicit DBOpreator(QObject *parent = nullptr);
    ~DBOpreator();

public:
    QString cities(const QString& keyword = "");
};

#endif // DBOPREATOR_H
