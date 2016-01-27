#ifndef LICENSEPLATEMODEL_H
#define LICENSEPLATEMODEL_H

#include <QAbstractListModel>
#include <QString>
#include <QVector>

class LicensePlateModel : public QAbstractListModel
{
public:
    LicensePlateModel();

    QVariant data(const QModelIndex &index, int role) const Q_DECL_OVERRIDE;
    int rowCount(const QModelIndex &parent = QModelIndex()) const Q_DECL_OVERRIDE;
    int columnCount(const QModelIndex &parent = QModelIndex()) const Q_DECL_OVERRIDE;

private:
    QVector<QString> mPlates;
};

#endif // LICENSEPLATEMODEL_H
