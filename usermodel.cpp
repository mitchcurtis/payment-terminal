#include "usermodel.h"

#include <QDebug>

#include "azurebackend.h"
#include "offlinebackend.h"

enum Roles
{
    LicensePlateNumber = Qt::UserRole,
    ParkingSpotNumber
};

UserModel::UserModel(bool offlineMode)
{
    if (offlineMode)
        mBackend = new OfflineBackend(this);
    else
        mBackend = new AzureBackend(this);

    connect(mBackend, &AbstractBackend::licensePlateAdded, this, &UserModel::onLicensePlateAdded);
    connect(mBackend, &AbstractBackend::licensePlateRemoved, this, &UserModel::onLicensePlateRemoved);
    connect(mBackend, &AbstractBackend::parkingSpotAssigned, this, &UserModel::onParkingSpotAssigned);
    connect(mBackend, &AbstractBackend::paymentDataAvailable, this, &UserModel::paymentDataAvailable);

    // Now that we've connected to messageReceived, initialise the backend.
    mBackend->initialize();
}

UserModel::~UserModel()
{
}

QVariant UserModel::data(const QModelIndex &index, int role) const
{
    if (!index.isValid())
        return QVariant();

    switch (role) {
    case Qt::DisplayRole:
    case LicensePlateNumber:
        return mUsers.at(index.row()).licensePlateNumber();
    case ParkingSpotNumber:
        return mUsers.at(index.row()).parkingSpotNumber();
    }

    return QVariant();
}

int UserModel::rowCount(const QModelIndex &) const
{
    return mUsers.size();
}

int UserModel::columnCount(const QModelIndex &) const
{
    return 1;
}

QHash<int, QByteArray> UserModel::roleNames() const
{
    QHash<int, QByteArray> names;
    names[LicensePlateNumber] = "licensePlateNumber";
    names[ParkingSpotNumber] = "parkingSpotNumber";
    return names;
}

void UserModel::onLicensePlateAdded(const QString &licensePlateNumber)
{
    if (indexOf(licensePlateNumber) != -1) {
        qWarning() << "License plate number" << licensePlateNumber << "already exists in model";
        return;
    }

    beginInsertRows(QModelIndex(), mUsers.size(), mUsers.size());
    UserData userData;
    userData.setLicensePlateNumber(licensePlateNumber);
    mUsers.append(userData);
    endInsertRows();
}

void UserModel::onLicensePlateRemoved(const QString &licensePlateNumber)
{
    int index = indexOf(licensePlateNumber);
    if (index == -1) {
        qWarning() << "License plate number" << licensePlateNumber << "doesn't exist in model";
        return;
    }

    beginRemoveRows(QModelIndex(), index, index);
    mUsers.remove(index);
    endRemoveRows();
}

void UserModel::onParkingSpotAssigned(const QString &licensePlateNumber, int parkingSpotNumber)
{
    int index = indexOf(licensePlateNumber);
    if (index == -1) {
        qWarning() << "License plate number" << licensePlateNumber << "doesn't exist in model";
        return;
    }

    mUsers[index].setParkingSpotNumber(parkingSpotNumber);

    const QModelIndex modelIndex = createIndex(index, 0);
    QVector<int> rolesAffected;
    rolesAffected << ParkingSpotNumber;
    emit dataChanged(modelIndex, modelIndex, rolesAffected);
}

void UserModel::requestPaymentData(const QString &licensePlateNumber)
{
    mBackend->requestPaymentData(licensePlateNumber);
}

void UserModel::paymentAccepted(const QString &licensePlateNumber)
{
    mBackend->paymentAccepted(licensePlateNumber);
}

int UserModel::indexOf(const QString &licensePlateNumber) const
{
    for (int i = 0; i < mUsers.size(); ++i) {
        if (mUsers.at(i).licensePlateNumber() == licensePlateNumber) {
            return i;
        }
    }

    return -1;
}
