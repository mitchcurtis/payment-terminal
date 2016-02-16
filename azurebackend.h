#ifndef AZUREBACKEND_H
#define AZUREBACKEND_H

#include "iothub_client.h"

#include "abstractbackend.h"

class AzureBackend : public AbstractBackend
{
    Q_OBJECT

public:
    AzureBackend(QObject *parent, const QString &connectionString, const QString &devId);
    ~AzureBackend();

    void initialize() Q_DECL_OVERRIDE;

    void requestPaymentData(const QString &licensePlateNumber) Q_DECL_OVERRIDE;
    void paymentAccepted(const QString &licensePlateNumber) Q_DECL_OVERRIDE;

    Q_INVOKABLE void onMessageReceived(const QString &message);

private:
    void sendMessage(const QString &message);

    IOTHUB_CLIENT_HANDLE mIotHubClientHandle;
    QString mConnectionString;
    QString mDevId;
};

#endif // AZUREBACKEND_H
