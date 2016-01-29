#include "userdata.h"

UserData::UserData() :
    mParkingSpotNumber(-1)
{
}

QString UserData::licensePlateNumber() const
{
    return mLicensePlateNumber;
}

void UserData::setLicensePlateNumber(const QString &licensePlateNumber)
{
    mLicensePlateNumber = licensePlateNumber;
}

int UserData::parkingSpotNumber() const
{
    return mParkingSpotNumber;
}

void UserData::setParkingSpotNumber(int parkingSpotNumber)
{
    mParkingSpotNumber = parkingSpotNumber;
}
