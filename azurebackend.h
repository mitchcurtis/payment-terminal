#ifndef AZUREBACKEND_H
#define AZUREBACKEND_H

#include "iothub_client.h"

#include "abstractbackend.h"

class AzureBackend : public AbstractBackend
{
    Q_OBJECT

public:
    AzureBackend(QObject *parent = 0);
    ~AzureBackend();

    void initialize() Q_DECL_OVERRIDE;

    void requestPaymentData(const QString &licensePlateNumber) Q_DECL_OVERRIDE;

    Q_INVOKABLE void onMessageReceived(const QString &message);

private:
    IOTHUB_CLIENT_HANDLE mIotHubClientHandle;
};

#endif // AZUREBACKEND_H
