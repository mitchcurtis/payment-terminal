#include <QDebug>
#include <QFile>
#include <QFont>
#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>

#include "usermodel.h"

int main(int argc, char *argv[])
{
    // Force printf calls to stdout to be printed immediately.
    setbuf(stdout, NULL);

    QGuiApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);

    QFont font("Arial");
    font.setWeight(QFont::Light);
    app.setFont(font);

    // Read configuration arguments from "config.txt" in the same directory as the exectuable.
    QString connectionString;
    QString devId;
    const QString configFilePath = app.applicationDirPath() + QStringLiteral("/config.txt");
    QFile file(configFilePath);
    if (file.open(QIODevice::ReadOnly)) {
        QByteArray contents = file.readAll();
        QList<QByteArray> configArgs = contents.split('\n');
        bool configFormatError = false;
        if (configArgs.size() >= 2) {
            connectionString = configArgs.at(0);
            devId = configArgs.at(1);

            if (connectionString.isEmpty() || devId.isEmpty())
                configFormatError = true;
        } else {
            configFormatError = true;
        }

        if (configFormatError) {
            qWarning() << "Expected <connectionString>\\n<devId> in config.txt, but found:" << contents
                << "\nRunning in offline mode";
        }
    } else {
        qWarning().nospace() << "No config.txt found at " << configFilePath << "; running in offline mode";
    }

    UserModel userModel(connectionString, devId);

    QQmlApplicationEngine engine;
    engine.rootContext()->setContextProperty("userModel", &userModel);
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

    return app.exec();
}
