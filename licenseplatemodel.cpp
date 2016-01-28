#include "licenseplatemodel.h"

#include <QDebug>

#include "iothubtransporthttp.h"

static IOTHUBMESSAGE_DISPOSITION_RESULT receiveMessageCallback(IOTHUB_MESSAGE_HANDLE message, void* userData)
{
    LicensePlateModel* model = (LicensePlateModel*)userData;
    const char* buffer;
    size_t size;
    if (IoTHubMessage_GetByteArray(message, (const unsigned char**)&buffer, &size) == IOTHUB_MESSAGE_OK)
        qDebug("Received Message with Data: <<<%.*s>>> & Size=%d\r\n", (int)size, buffer, (int)size);

    // TODO: fix string
    QString messageStr(buffer);
    // Ensure that the invokable function is called in a thread-safe manner via QueuedConnection.
    QMetaObject::invokeMethod(model, "onMessageReceived", Qt::QueuedConnection, Q_ARG(QString, messageStr));
    return IOTHUBMESSAGE_ACCEPTED;
}

LicensePlateModel::LicensePlateModel(bool offlineMode) :
    mIotHubClientHandle(0)
{
    if (offlineMode) {
        const char *plates[] = { "B-FB-4067", "A-DL-3227", "THG 495", "AS-46-01", "366 PD 8", "L-HJ-1037", "4927-AE-PA", "K-OL-0742" };
        for (unsigned int i = 0; i < sizeof(plates) / sizeof(plates[0]); ++i)
            mPlates.append(plates[i]);
    } else {
        static const char *connectionString = "HostName=tdxiotdemohub.azure-devices.net;DeviceId=tdxpayservice1;SharedAccessKey=OOK283xfJaebVXUk1hqkyG94znDITRpCbtlceEtt12A=";
        mIotHubClientHandle = IoTHubClient_CreateFromConnectionString(connectionString, HTTP_Protocol);

        int minimumPollingTime = 3;
        if (IoTHubClient_SetOption(mIotHubClientHandle, "MinimumPollingTime", &minimumPollingTime) != IOTHUB_CLIENT_OK) {
            qWarning() << "Failed to set MinimumPollingTime";
            return;
        }

        IoTHubClient_SetMessageCallback(mIotHubClientHandle, receiveMessageCallback, this);
    }
}

LicensePlateModel::~LicensePlateModel()
{
    if (mIotHubClientHandle)
        IoTHubClient_Destroy(mIotHubClientHandle);
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

void LicensePlateModel::onMessageReceived(const QString &message)
{
    beginInsertRows(QModelIndex(), mPlates.size(), mPlates.size());
    mPlates.append(message);
    endInsertRows();
}
