#include "usermodel.h"

#include <QCoreApplication>
#include <QDebug>

#include "azurebackend.h"
#include "offlinebackend.h"

enum Roles
{
    LicensePlateNumber = Qt::UserRole,
    ParkingSpotNumber
};

UserModel::UserModel(const QString &connectionString, const QString &devId) :
    mTranslator(0)
{
    if (connectionString.isEmpty() || devId.isEmpty())
        mBackend = new OfflineBackend(this);
    else
        mBackend = new AzureBackend(this, connectionString, devId);

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

void UserModel::addUser(const QString &licensePlateNumber, int parkingSpotNumber)
{
    beginInsertRows(QModelIndex(), mUsers.size(), mUsers.size());
    UserData userData;
    userData.setLicensePlateNumber(licensePlateNumber);
    userData.setParkingSpotNumber(parkingSpotNumber);
    mUsers.append(userData);
    endInsertRows();
}

QString UserModel::language() const
{
    return mLanguage;
}

void UserModel::setLanguage(const QString &language)
{
    if (language == mLanguage)
        return;

    if (language != QLatin1String("en_GB") && language != QLatin1String("de_DE")) {
        qWarning() << "Only en_GB and de_DE are supported locales";
        return;
    }

    QLocale locale(language);

    if (mTranslator)
        QCoreApplication::removeTranslator(mTranslator);
    else
        mTranslator = new QTranslator(this);

    // If the language is English, it's enough just to remove any existing translator.
    if (language != QLatin1String("en_GB")) {
        if (!mTranslator->load(locale, QStringLiteral("payment-terminal"), QStringLiteral("_"), QStringLiteral(":/translations"))) {
            qWarning() << "Failed to load translation for language" << language;
            return;
        }

        if (!QCoreApplication::installTranslator(mTranslator)) {
            qWarning() << "Failed to install translator for language" << language;
            return;
        }
    }

    mLanguage = language;

    QLocale::setDefault(locale);

    emit languageChanged();
}

void UserModel::onLicensePlateAdded(const QString &licensePlateNumber, int parkingSpotNumber)
{
    qInfo() << Q_FUNC_INFO << "licensePlateNumber" << licensePlateNumber << "parkingSpotNumber" << parkingSpotNumber;

    if (indexOf(licensePlateNumber) != -1) {
        qWarning() << "License plate number" << licensePlateNumber << "already exists in model";
        return;
    }

    addUser(licensePlateNumber, parkingSpotNumber);
}

void UserModel::onLicensePlateRemoved(const QString &licensePlateNumber)
{
    qInfo() << Q_FUNC_INFO << "licensePlateNumber" << licensePlateNumber;

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
    qInfo() << Q_FUNC_INFO << "licensePlateNumber" << licensePlateNumber << "parkingSpotNumber" << parkingSpotNumber;

    int index = indexOf(licensePlateNumber);
    if (index == -1) {
        addUser(licensePlateNumber, parkingSpotNumber);
        index = mUsers.size() - 1;
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
