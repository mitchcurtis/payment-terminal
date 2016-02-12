TEMPLATE = app

QT += qml quick
CONFIG += c++11

HEADERS += \
    azurebackend.h \
    offlinebackend.h \
    abstractbackend.h \
    userdata.h \
    usermodel.h

SOURCES += main.cpp \
    azurebackend.cpp \
    offlinebackend.cpp \
    abstractbackend.cpp \
    userdata.cpp \
    usermodel.cpp

RESOURCES += qml.qrc \
    images.qrc \
    translations.qrc

lupdate_only {
    SOURCES = *.qml
}

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Default rules for deployment.
include(deployment.pri)

include(3rdparty/azure-iot-sdk.pri)
