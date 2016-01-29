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

public slots:
    void onLicensePlateAdded(const QString &licensePlateNumber);
    void onLicensePlateRemoved(const QString &licensePlateNumber);
    void onParkingSpotAssigned(const QString &licensePlateNumber, int parkingSpotNumber);

protected:
    virtual QHash<int, QByteArray> roleNames() const Q_DECL_OVERRIDE;

private:
    int indexOf(const QString &licensePlateNumber) const;

    QVector<UserData> mUsers;
    AbstractBackend *mBackend;
};

#endif // USERMODEL_H
