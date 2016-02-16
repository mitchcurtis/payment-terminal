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

    QString messageStr(QString::fromUtf16((const unsigned short*)buffer, size / 2 - 1));
    // Ensure that the invokable function is called in a thread-safe manner via QueuedConnection.
    QMetaObject::invokeMethod(backend, "onMessageReceived", Qt::QueuedConnection, Q_ARG(QString, messageStr));
    return IOTHUBMESSAGE_ACCEPTED;
}

AzureBackend::AzureBackend(QObject *parent, const QString &connectionString, const QString &devId) :
    AbstractBackend(parent),
    mIotHubClientHandle(0),
    mConnectionString(connectionString),
    mDevId(devId)
{
}

AzureBackend::~AzureBackend()
{
    if (mIotHubClientHandle)
        IoTHubClient_Destroy(mIotHubClientHandle);
}

void AzureBackend::initialize()
{
    mIotHubClientHandle = IoTHubClient_CreateFromConnectionString(qPrintable(mConnectionString), HTTP_Protocol);

    const int minimumPollingTime = 1;
    if (IoTHubClient_SetOption(mIotHubClientHandle, "MinimumPollingTime", &minimumPollingTime) != IOTHUB_CLIENT_OK) {
        qWarning() << "Failed to set MinimumPollingTime";
        return;
    }

    IoTHubClient_SetMessageCallback(mIotHubClientHandle, receiveMessageCallback, this);

    sendMessage(QString::fromLatin1("ONL,devid=%1").arg(mDevId));
}

void AzureBackend::requestPaymentData(const QString &licensePlateNumber)
{
    sendMessage(QString::fromLatin1("PRQ,devid=%1;lp=%2").arg(mDevId).arg(licensePlateNumber));
}

void AzureBackend::paymentAccepted(const QString &licensePlateNumber)
{
    sendMessage(QString::fromLatin1("PAC,devid=%1;lp=%2").arg(mDevId).arg(licensePlateNumber));
}

enum MessageType
{
    UnknownMessageType,
    LicensePlateAdded,
    LicensePlateRemoved,
    ParkingSpotAssigned,
    PaymentAmount
};

static const QString LPA = QStringLiteral("LPA");
static const QString LPR = QStringLiteral("LPR");
static const QString PSA = QStringLiteral("PSA");
static const QString PAM = QStringLiteral("PAM");

static const QString licensePlateNumberKey = QStringLiteral("licensePlateNumber");
static const QString parkingSpotNumberKey = QStringLiteral("parkingSpotNumber");
static const QString paymentAmountKey = QStringLiteral("paymentAmount");
static const QString minutesParkedKey = QStringLiteral("minutesParked");

bool parseLicensePlateNumber(const QString &message, QString &licensePlateNumber)
{
    const int equalsIndex = message.indexOf(QStringLiteral("lp="));
    if (equalsIndex == -1) {
        qWarning() << "Malformed message; expected \"lp=\" before license plate number:" << message;
        return false;
    }

    const int startIndex = equalsIndex + 3;
    const int endIndex = message.indexOf(QLatin1Char(';'), startIndex);
    // If the index is -1, this was the last parameter, and so it's OK
    // to pass -1 to mid().

    const QString licensePlateStr = message.mid(startIndex, endIndex - startIndex);
    if (licensePlateStr.isEmpty()) {
        qWarning() << "Empty license plate number string";
        return false;
    }

    licensePlateNumber = licensePlateStr;
    return true;
}

bool parseParkingSpotNumber(const QString &message, int &parkingSpotNumber)
{
    const int equalsIndex = message.indexOf(QStringLiteral("psid="));
    if (equalsIndex == -1) {
        qWarning() << "Malformed message; expected \"psid=\" before parking spot number:" << message;
        return false;
    }

    const int startIndex = equalsIndex + 5;
    const int endIndex = message.indexOf(QLatin1Char(';'), startIndex);

    const QString parkingSpotNumberStr = message.mid(startIndex, endIndex - startIndex);
    if (parkingSpotNumberStr.isEmpty()) {
        qWarning() << "Empty parking spot number string";
        return false;
    }

    bool isInt = false;
    int parkingSpotNumberInt = parkingSpotNumberStr.toInt(&isInt);
    if (!isInt) {
        qWarning() << "Parking spot number" << parkingSpotNumberStr << "is not an integer";
        return false;
    }

    parkingSpotNumber = parkingSpotNumberInt;
    return true;
}

bool parsePaymentAmount(const QString &message, qreal &paymentAmount)
{
    const int equalsIndex = message.indexOf(QStringLiteral("price="));
    if (equalsIndex == -1) {
        qWarning() << "Malformed message; expected \"price=\" before payment amount:" << message;
        return false;
    }

    const int startIndex = equalsIndex + 6;
    const int endIndex = message.indexOf(QLatin1Char(';'), startIndex);

    const QString paymentAmountStr = message.mid(startIndex, endIndex - startIndex);
    if (paymentAmountStr.isEmpty()) {
        qWarning() << "Empty payment amount string";
        return false;
    }

    bool isDouble = false;
    qreal paymentAmountReal = paymentAmountStr.toDouble(&isDouble);
    if (!isDouble) {
        qWarning() << "Payment amount" << paymentAmountStr << "is not a double";
        return false;
    }

    paymentAmount = paymentAmountReal;
    return true;
}

bool parseMinutesParked(const QString &message, qreal &minutesParked)
{
    int equalsIndex = message.indexOf(QStringLiteral("time="));
    if (equalsIndex == -1) {
        qWarning() << "Malformed message; expected \"time=\" before minutes parked:" << message;
        return false;
    }

    const int startIndex = equalsIndex + 5;
    const int endIndex = message.indexOf(QLatin1Char(';'), startIndex);

    const QString minutesParkedStr = message.mid(startIndex, endIndex - startIndex);
    if (minutesParkedStr.isEmpty()) {
        qWarning() << "Empty minutes parked string";
        return false;
    }

    bool isDouble = false;
    qreal minutesParkedReal = minutesParkedStr.toDouble(&isDouble);
    if (!isDouble) {
        qWarning() << "Minutes parked" << minutesParkedStr << "is not a double";
        return false;
    }

    minutesParked = minutesParkedReal;
    return true;
}

MessageType parseMessageData(const QString &message, QVariant &data)
{
    static QHash<QString, MessageType> validMessageIdentifiers;
    if (validMessageIdentifiers.isEmpty()) {
        validMessageIdentifiers.insert(LPA, LicensePlateAdded);
        validMessageIdentifiers.insert(LPR, LicensePlateRemoved);
        validMessageIdentifiers.insert(PSA, ParkingSpotAssigned);
        validMessageIdentifiers.insert(PAM, PaymentAmount);
    }

    QString messageIdentifier = message.left(3);
    if (!validMessageIdentifiers.contains(messageIdentifier)) {
        qWarning() << "Unknown message identifier:" << message;
        return UnknownMessageType;
    }

    // Every message contains a license plate number.
    QVariantMap dataMap;
    QString licensePlateNumber;
    if (!parseLicensePlateNumber(message, licensePlateNumber))
        return UnknownMessageType;

    dataMap.insert(licensePlateNumberKey, licensePlateNumber);

    const MessageType messageType = validMessageIdentifiers.value(messageIdentifier);
    if (messageType == LicensePlateAdded || messageType == ParkingSpotAssigned) {
        int parkingSpotNumber = -1;
        if (!parseParkingSpotNumber(message, parkingSpotNumber))
            return UnknownMessageType;

        dataMap.insert(parkingSpotNumberKey, parkingSpotNumber);
    } else if (messageType == PaymentAmount) {
        qreal paymentAmount = 0;
        if (!parsePaymentAmount(message, paymentAmount))
            return UnknownMessageType;

        qreal minutesParked = 0;
        if (!parseMinutesParked(message, minutesParked))
            return UnknownMessageType;

        dataMap.insert(paymentAmountKey, paymentAmount);
        dataMap.insert(minutesParkedKey, minutesParked);
    }

    data = dataMap;

    return messageType;
}

void AzureBackend::onMessageReceived(const QString &message)
{
    QVariant data;

    MessageType messageType = parseMessageData(message, data);

    const QMap<QString, QVariant> dataMap = data.toMap();

    switch (messageType) {
    case LicensePlateAdded:
        emit licensePlateAdded(dataMap.value(licensePlateNumberKey).toString(),
            dataMap.value(parkingSpotNumberKey).toInt());
        break;
    case LicensePlateRemoved:
        emit licensePlateRemoved(dataMap.value(licensePlateNumberKey).toString());
        break;
    case ParkingSpotAssigned:
        emit parkingSpotAssigned(dataMap.value(licensePlateNumberKey).toString(),
            dataMap.value(parkingSpotNumberKey).toInt());
        break;
    case PaymentAmount:
        emit paymentDataAvailable(dataMap.value(paymentAmountKey).toDouble(),
            dataMap.value(minutesParkedKey).toDouble());
        break;
    case UnknownMessageType:
        break;
    }
}

static void sendConfirmationCallback(IOTHUB_CLIENT_CONFIRMATION_RESULT, void* userData)
{
    IOTHUB_MESSAGE_HANDLE messageHandle = (IOTHUB_MESSAGE_HANDLE)userData;
    IoTHubMessage_Destroy(messageHandle);
}

void AzureBackend::sendMessage(const QString &message)
{
    const unsigned char *unsignedMessage = (const unsigned char*)message.utf16();
    // Make sure that we have twice the size to account for the utf16 pairs.
    IOTHUB_MESSAGE_HANDLE messageHandle = IoTHubMessage_CreateFromByteArray(unsignedMessage, message.size() * sizeof(QChar));

    const IOTHUB_CLIENT_RESULT sendResult = IoTHubClient_SendEventAsync(mIotHubClientHandle, messageHandle, sendConfirmationCallback, messageHandle);
    if (sendResult != IOTHUB_CLIENT_OK)
        qWarning().nospace() << "Failed to send message \"" << message << "\": " << sendResult;
}
