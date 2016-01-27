#ifndef LICENSEPLATEMODEL_H
#define LICENSEPLATEMODEL_H

#include <QAbstractListModel>
#include <QString>
#include <QVector>

#include "iothub_client.h"

class LicensePlateModel : public QAbstractListModel
{
public:
    LicensePlateModel(bool offlineMode);
    ~LicensePlateModel();

    QVariant data(const QModelIndex &index, int role) const Q_DECL_OVERRIDE;
    int rowCount(const QModelIndex &parent = QModelIndex()) const Q_DECL_OVERRIDE;
    int columnCount(const QModelIndex &parent = QModelIndex()) const Q_DECL_OVERRIDE;

    void onMessageReceived(const QString &message);

private:
    IOTHUB_CLIENT_HANDLE mIotHubClientHandle;
    QVector<QString> mPlates;
};

#endif // LICENSEPLATEMODEL_H
