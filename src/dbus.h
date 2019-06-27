//
// C++ Interface: DBus
//
// Description:
//
//
// Author: hooey <hephooey@gmail.com>, (C) 2008
//
// Copyright: See COPYING file that comes with this distribution
//
//
#ifndef DBUS_H
#define DBUS_H

#include "qtermparam.h"

#include <QMutex>
#include <QString>
#include <QMap>
#include <QObject>
#include <QImage>


namespace QTerm
{
class DBus: public QObject
{
    Q_OBJECT
public:
    enum Action {
        Show_QTerm
    };
    static DBus * instance();
    bool notificationAvailable() const;
    bool sendNotification(const QString & summary, const QString & body, const QImage & image=QImage(), QList<DBus::Action> actions = QList<DBus::Action>() );
signals:
    void showQTerm();
private slots:
    void slotServiceOwnerChanged(const QString & serviceName, const QString & oldOwner, const QString & newOwner);
    void slotNotificationActionInvoked(uint id, const QString action);
    void slotNotificationClosed(uint id, uint reason);
private:
    DBus();
    void createConnection();
    void closeNotification(uint id);
    void checkCapabilities();
    static DBus * m_instance;
    bool m_notificationAvailable;
    QList<uint> m_idList;
    QStringList m_serverCapabilities;
};

}
#endif // DBUS_H
