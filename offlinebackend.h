#ifndef OFFLINEBACKEND_H
#define OFFLINEBACKEND_H

#include "abstractbackend.h"

class OfflineBackend : public AbstractBackend
{
    Q_OBJECT
public:
    explicit OfflineBackend(QObject *parent = 0);

    void initialize() Q_DECL_OVERRIDE;
};

#endif // OFFLINEBACKEND_H
