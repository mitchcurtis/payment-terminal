#include "licenseplatemodel.h"

#include <QDebug>

#include "azurebackend.h"
#include "offlinebackend.h"

LicensePlateModel::LicensePlateModel(bool offlineMode)
{
    if (offlineMode)
        mBackend = new OfflineBackend(this);
    else
        mBackend = new AzureBackend(this);

    connect(mBackend, &AbstractBackend::messageReceived, this, &LicensePlateModel::onMessageReceived);

    // Now that we've connected to messageReceived, initialise the backend.
    mBackend->initialize();
}

LicensePlateModel::~LicensePlateModel()
{
}

QVariant LicensePlateModel::data(const QModelIndex &index, int role) const
{
    if (!index.isValid())
        return QVariant();

    if (role == Qt::DisplayRole)
        return mPlates.at(index.row());

    return QVariant();
}

int LicensePlateModel::rowCount(const QModelIndex &) const
{
    return mPlates.size();
}

int LicensePlateModel::columnCount(const QModelIndex &) const
{
    return 1;
}

enum LicensePlateAction
{
    UnknownAction,
    LicensePlateAdded,
    LicensePlateRemoved,
};

bool parseLicensePLateNumber(const QString &message, QString &licensePlateNumber)
{
    int equalsIndex = message.indexOf(QLatin1Char('='));
    if (equalsIndex == -1) {
        qWarning() << "Malformed message; expected '=' before license plate number:" << message;
        return false;
    }

    QString licensePlateStr = message.mid(equalsIndex + 1);
    if (licensePlateStr.isEmpty()) {
        qWarning() << "Empty license plate number";
        return false;
    }

    licensePlateNumber = licensePlateStr;
    return true;
}

LicensePlateAction extractLicenseData(const QString &message, QString &licensePlateNumber)
{
    if (message.startsWith(QStringLiteral("LPA")) && parseLicensePLateNumber(message, licensePlateNumber)) {
        return LicensePlateAdded;
    } else if (message.startsWith(QStringLiteral("LPR")) && parseLicensePLateNumber(message, licensePlateNumber)) {
        return LicensePlateRemoved;
    }

    qWarning() << "Unknown license plate action:" << message;
    return UnknownAction;
}

void LicensePlateModel::onMessageReceived(const QString &message)
{
    QString licensePlateNumber;
    LicensePlateAction action = extractLicenseData(message, licensePlateNumber);
    if (action == UnknownAction)
        return;

    if (action == LicensePlateAdded) {
        if (mPlates.contains(licensePlateNumber)) {
            qWarning() << "License plate number" << licensePlateNumber << "already exists in model";
            return;
        }

        beginInsertRows(QModelIndex(), mPlates.size(), mPlates.size());
        mPlates.append(licensePlateNumber);
        endInsertRows();
    } else if (action == LicensePlateRemoved) {
        int index = mPlates.indexOf(licensePlateNumber);
        if (index == -1) {
            qWarning() << "License plate number" << licensePlateNumber << "doesn't exist in model";
            return;
        }

        beginRemoveRows(QModelIndex(), index, index);
        mPlates.remove(index);
        endRemoveRows();
    }
}
