#include "azurebackend.h"

#include <QDebug>

#include "iothubtransporthttp.h"

static IOTHUBMESSAGE_DISPOSITION_RESULT receiveMessageCallback(IOTHUB_MESSAGE_HANDLE message, void* userData)
{
    AzureBackend* backend = (AzureBackend*)userData;
    const char* buffer;
    size_t size;
    if (IoTHubMessage_GetByteArray(message, (const unsigned char**)&buffer, &size) == IOTHUB_MESSAGE_OK)
        qDebug("Received Message with Data: <<<%.*s>>> & Size=%d", (int)size, buffer, (int)size);

    QString messageStr(QString::fromUtf8(buffer, size));
    // Ensure that the invokable function is called in a thread-safe manner via QueuedConnection.
    QMetaObject::invokeMethod(backend, "onMessageReceived", Qt::QueuedConnection, Q_ARG(QString, messageStr));
    return IOTHUBMESSAGE_ACCEPTED;
}

AzureBackend::AzureBackend(QObject *parent) :
    AbstractBackend(parent),
    mIotHubClientHandle(0)
{
}

AzureBackend::~AzureBackend()
{
    if (mIotHubClientHandle)
        IoTHubClient_Destroy(mIotHubClientHandle);
}

void AzureBackend::initialize()
{
    static const char *connectionString = "HostName=tdxiotdemohub.azure-devices.net;DeviceId=tdxpayservice1;SharedAccessKey=OOK283xfJaebVXUk1hqkyG94znDITRpCbtlceEtt12A=";
    mIotHubClientHandle = IoTHubClient_CreateFromConnectionString(connectionString, HTTP_Protocol);

    int minimumPollingTime = 3;
    if (IoTHubClient_SetOption(mIotHubClientHandle, "MinimumPollingTime", &minimumPollingTime) != IOTHUB_CLIENT_OK) {
        qWarning() << "Failed to set MinimumPollingTime";
        return;
    }

    IoTHubClient_SetMessageCallback(mIotHubClientHandle, receiveMessageCallback, this);
}

void AzureBackend::onMessageReceived(const QString &message)
{
    emit messageReceived(message);
}
