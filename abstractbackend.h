#ifndef ABSTRACTBACKEND_H
#define ABSTRACTBACKEND_H

#include <QObject>

class AbstractBackend : public QObject
{
    Q_OBJECT

public:
    explicit AbstractBackend(QObject *parent = 0);

    virtual void initialize() = 0;

signals:
    void messageReceived(const QString &message);
};

#endif // ABSTRACTBACKEND_H
