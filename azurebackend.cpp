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

enum MessageType
{
    UnknownMessageType,
    LicensePlateAdded,
    LicensePlateRemoved,
    ParkingSpotAssigned
};

static QString LPA = QStringLiteral("LPA");
static QString LPR = QStringLiteral("LPR");
static QString PSA = QStringLiteral("PSA");

MessageType parseMessageData(const QString &message, QVariant &data)
{
    static QHash<QString, MessageType> validMessageIdentifiers;
    if (validMessageIdentifiers.isEmpty()) {
        validMessageIdentifiers.insert(LPA, LicensePlateAdded);
        validMessageIdentifiers.insert(LPR, LicensePlateRemoved);
        validMessageIdentifiers.insert(PSA, ParkingSpotAssigned);
    }

    QString messageIdentifier = message.left(3);
    if (!validMessageIdentifiers.contains(messageIdentifier)) {
        qWarning() << "Unknown message identifier:" << message;
        return UnknownMessageType;
    }

    int equalsIndex = message.indexOf(QLatin1Char('='));
    if (equalsIndex == -1) {
        qWarning() << "Malformed message; expected '=' before license plate number:" << message;
        return UnknownMessageType;
    }

    QString licensePlateStr = message.mid(equalsIndex + 1);
    if (licensePlateStr.isEmpty()) {
        qWarning() << "Empty license plate number";
        return UnknownMessageType;
    }

    data = licensePlateStr;
    return validMessageIdentifiers.value(messageIdentifier);
}

void AzureBackend::onMessageReceived(const QString &message)
{
    QVariant data;

    MessageType messageType = parseMessageData(message, data);

    const QMap<QString, QVariant> dataMap = data.toMap();

    switch (messageType) {
    case LicensePlateAdded:
        emit licensePlateAdded(data.toString());
        break;
    case LicensePlateRemoved:
        emit licensePlateRemoved(data.toString());
        break;
    case ParkingSpotAssigned:
        emit parkingSpotAssigned(dataMap.value("licensePlateNumber").toString(),
            dataMap.value("parkingSpotNumber").toInt());
        break;
    case UnknownMessageType:
        break;
    }
}
