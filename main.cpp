#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QFontDatabase>
#include <QQmlContext>

#include "licenseplatemodel.h"

int main(int argc, char *argv[])
{
    // Force printf calls to stdout to be printed immediately.
    setbuf(stdout, NULL);

    QGuiApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);

    QFontDatabase::addApplicationFont(":/fonts/OpenSans-Regular.ttf");

    QFont font("Open Sans");
    font.setWeight(QFont::Light);
    app.setFont(font);

    LicensePlateModel licensePlateModel(app.arguments().contains("-offline"));

    QQmlApplicationEngine engine;
    engine.rootContext()->setContextProperty("licensePlateModel", &licensePlateModel);
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

    return app.exec();
}
