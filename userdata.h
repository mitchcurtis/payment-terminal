#ifndef USERDATA_H
#define USERDATA_H

#include <QString>

class UserData
{
public:
    UserData();

    QString licensePlateNumber() const;
    void setLicensePlateNumber(const QString &licensePlateNumber);

    int parkingSpotNumber() const;
    void setParkingSpotNumber(int parkingSpotNumber);

private:
    QString mLicensePlateNumber;
    int mParkingSpotNumber;
};

#endif // USERDATA_H
