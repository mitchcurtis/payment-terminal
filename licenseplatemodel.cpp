#include "licenseplatemodel.h"

#include <QDebug>

#include "iothubtransporthttp.h"

static IOTHUBMESSAGE_DISPOSITION_RESULT receiveMessageCallback(IOTHUB_MESSAGE_HANDLE message, void* userData)
{
    LicensePlateModel* model = (LicensePlateModel*)userData;
    const char* buffer;
    size_t size;
    if (IoTHubMessage_GetByteArray(message, (const unsigned char**)&buffer, &size) == IOTHUB_MESSAGE_OK)
    {
        (void)printf("Received Message [%d] with Data: <<<%.*s>>> & Size=%d\r\n", 123, (int)size, buffer, (int)size);
    }

    QString messageStr(buffer);
    // TODO: fix string
    model->onMessageReceived(messageStr);
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
    qDebug() << Q_FUNC_INFO << message;
}
