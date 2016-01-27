#include "licenseplatemodel.h"

LicensePlateModel::LicensePlateModel()
{
    const char *plates[] = { "B-FB-4067", "A-DL-3227", "THG 495", "AS-46-01", "366 PD 8", "L-HJ-1037", "4927-AE-PA", "K-OL-0742" };
    for (unsigned int i = 0; i < sizeof(plates) / sizeof(plates[0]); ++i)
        mPlates.append(plates[i]);
}

QVariant LicensePlateModel::data(const QModelIndex &index, int role) const
{
    if (!index.isValid())
        return QVariant();

    if (role == Qt::DisplayRole)
        return mPlates.at(index.row());

    return QVariant();
}

int LicensePlateModel::rowCount(const QModelIndex &) const
{
    return mPlates.size();
}

int LicensePlateModel::columnCount(const QModelIndex &) const
{
    return 1;
}
