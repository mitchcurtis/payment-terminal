#ifndef LICENSEPLATEMODEL_H
#define LICENSEPLATEMODEL_H

#include <QAbstractListModel>
#include <QString>
#include <QVector>

class AbstractBackend;

class LicensePlateModel : public QAbstractListModel
{
    Q_OBJECT

public:
    LicensePlateModel(bool offlineMode);
    ~LicensePlateModel();

    QVariant data(const QModelIndex &index, int role) const Q_DECL_OVERRIDE;
    int rowCount(const QModelIndex &parent = QModelIndex()) const Q_DECL_OVERRIDE;
    int columnCount(const QModelIndex &parent = QModelIndex()) const Q_DECL_OVERRIDE;

public slots:
    void onMessageReceived(const QString &message);

private:
    QVector<QString> mPlates;
    AbstractBackend *mBackend;
};

#endif // LICENSEPLATEMODEL_H
