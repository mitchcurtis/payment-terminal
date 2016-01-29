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
    void licensePlateAdded(const QString &licensePlateNumber);
    void licensePlateRemoved(const QString &licensePlateNumber);
    void parkingSpotAssigned(const QString &licensePlateNumber, int parkingSpotNumber);
};

#endif // ABSTRACTBACKEND_H
