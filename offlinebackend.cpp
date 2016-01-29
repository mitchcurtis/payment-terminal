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
        "LPA,lp=B-FB-4067", "LPA,lp=A-DL-3227", "LPA,lp=THG 495", "LPA,lp=AS-46-01",
        "LPA,lp=366 PD 8", "LPA,lp=L-HJ-1037", "LPA,lp=4927-AE-PA", "LPA,lp=K-OL-0742"
    };

    for (unsigned int i = 0; i < sizeof(plates) / sizeof(plates[0]); ++i)
        emit messageReceived(plates[i]);

    initialized = true;
}
