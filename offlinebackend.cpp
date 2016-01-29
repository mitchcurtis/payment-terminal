#include "offlinebackend.h"

OfflineBackend::OfflineBackend(QObject *parent) :
    AbstractBackend(parent)
{
}

void OfflineBackend::initialize()
{
    static bool initialized = false;
    if (initialized)
        return;

    const char *plates[] = {
        "B-FB-4067", "A-DL-3227", "THG 495", "AS-46-01",
        "366 PD 8", "L-HJ-1037", "4927-AE-PA", "K-OL-0742"
    };

    for (unsigned int i = 0; i < sizeof(plates) / sizeof(plates[0]); ++i) {
        emit licensePlateAdded(plates[i]);
        emit parkingSpotAssigned(plates[i], i + 1);
    }

    initialized = true;
}

void OfflineBackend::requestPaymentData(const QString &licensePlateNumber)
{
    emit paymentDataAvailable(5.5, 160);
}
