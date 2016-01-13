#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QFontDatabase>

int main(int argc, char *argv[])
{
    QGuiApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);

    QFontDatabase::addApplicationFont(":/fonts/OpenSans-Light.ttf");
    QFontDatabase::addApplicationFont(":/fonts/OpenSans-Regular.ttf");
    QFontDatabase::addApplicationFont(":/fonts/OpenSans-Semibold.ttf");

    QFont font("Open Sans");
    font.setWeight(QFont::Light);
    app.setFont(font);

    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

    return app.exec();
}
