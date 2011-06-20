load(qt_module)
load(qt_module_config)
QPRO_PWD = $$PWD

TARGET = QtPublishSubscribe

QT = core

CONFIG += module
MODULE_PRI = ../../modules/qt_publishsubscribe.pri

DEFINES += QT_BUILD_PUBLISHSUBSCRIBE_LIB QT_MAKEDLL

PUBLIC_HEADERS = qvaluespace.h \
                 qvaluespacepublisher.h \
                 qvaluespacesubscriber.h

PRIVATE_HEADERS = qpublishsubscribe_p.h \
                  qvaluespace_p.h \
                  qvaluespacemanager_p.h \
                  qvaluespacesubscriber_p.h

SOURCES = qvaluespace.cpp \
          qvaluespacemanager.cpp \
          qvaluespacepublisher.cpp \
          qvaluespacesubscriber.cpp

unix: {
    PRIVATE_HEADERS += gconfitem_p.h \
                       gconflayer_p.h

    SOURCES += gconflayer.cpp \
               gconfitem.cpp

    CONFIG += link_pkgconfig
    PKGCONFIG += gobject-2.0 gconf-2.0

    contains(QT_CONFIG, dbus): {
        QT += dbus

        contains(contextkit_enabled, yes) {
            PRIVATE_HEADERS += contextkitlayer_p.h
            SOURCES += contextkitlayer.cpp

            CONFIG += link_pkgconfig
            PKGCONFIG += contextsubscriber-1.0 contextprovider-1.0
        } else {
            DEFINES += QT_NO_CONTEXTKIT
        }
    } else {
        DEFINES += QT_NO_CONTEXTKIT
    }
}

win32: {
    PRIVATE_HEADERS += qsystemreadwritelock_p.h \
                       registrylayer_win_p.h
    SOURCES += qsystemreadwritelock_win.cpp \
               registrylayer_win.cpp

    LIBS += -ladvapi32
}

HEADERS = qtpublishsubscribeversion.h $$PUBLIC_HEADERS $$PRIVATE_HEADERS