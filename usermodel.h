#ifndef USERMODEL_H
#define USERMODEL_H

#include <QAbstractListModel>
#include <QString>
#include <QVector>

#include "userdata.h"

class AbstractBackend;

class UserModel : public QAbstractListModel
{
    Q_OBJECT

public:
    UserModel(bool offlineMode);
    ~UserModel();

    QVariant data(const QModelIndex &index, int role) const Q_DECL_OVERRIDE;
    int rowCount(const QModelIndex &parent = QModelIndex()) const Q_DECL_OVERRIDE;
    int columnCount(const QModelIndex &parent = QModelIndex()) const Q_DECL_OVERRIDE;
    virtual QHash<int, QByteArray> roleNames() const Q_DECL_OVERRIDE;

public slots:
    void onLicensePlateAdded(const QString &licensePlateNumber, int parkingSpotNumber);
    void onLicensePlateRemoved(const QString &licensePlateNumber);
    void onParkingSpotAssigned(const QString &licensePlateNumber, int parkingSpotNumber);

    void requestPaymentData(const QString &licensePlateNumber);
    void paymentAccepted(const QString &licensePlateNumber);

signals:
    void paymentDataAvailable(qreal paymentAmount, int minutesParked);

private:
    int indexOf(const QString &licensePlateNumber) const;
    void addUser(const QString &licensePlateNumber, int parkingSpotNumber);

    QVector<UserData> mUsers;
    AbstractBackend *mBackend;
};

#endif // USERMODEL_H
