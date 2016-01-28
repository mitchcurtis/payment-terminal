TEMPLATE = app

QT += qml quick
CONFIG += c++11

HEADERS += \
    licenseplatemodel.h

SOURCES += main.cpp \
    licenseplatemodel.cpp

RESOURCES += qml.qrc \
    images.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Default rules for deployment.
include(deployment.pri)

include(3rdparty/azure-iot-sdk.pri)
