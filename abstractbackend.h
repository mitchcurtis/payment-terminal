#ifndef ABSTRACTBACKEND_H
#define ABSTRACTBACKEND_H

#include <QObject>

class AbstractBackend : public QObject
{
    Q_OBJECT

public:
    explicit AbstractBackend(QObject *parent = 0);

    virtual void initialize() = 0;

public slots:
    virtual void requestPaymentData(const QString &licensePlateNumber) = 0;

signals:
    // A car entered the lot.
    void licensePlateAdded(const QString &licensePlateNumber, int licensePlateAdded);
    // A car exited the lot.
    void licensePlateRemoved(const QString &licensePlateNumber);
    // A car chose a parking spot.
    void parkingSpotAssigned(const QString &licensePlateNumber, int parkingSpotNumber);

    // Emitted in response to requestPaymentData().
    void paymentDataAvailable(qreal paymentAmount, int minutesParked);
};

#endif // ABSTRACTBACKEND_H
