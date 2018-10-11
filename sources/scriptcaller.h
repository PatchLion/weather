#ifndef SCRIPTCALLER_H
#define SCRIPTCALLER_H

#include <QObject>

class scriptcaller : public QObject
{
    Q_OBJECT
public:
    explicit scriptcaller(QObject *parent = nullptr);

signals:

public slots:
};

#endif // SCRIPTCALLER_H