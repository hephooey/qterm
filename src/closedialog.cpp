//
// C++ Implementation: CloseDialog
//
// Description:
//
//
// Author: hooey <hephooey@gmail.com>, (C) 2009
//
// Copyright: See COPYING file that comes with this distribution
//
//

#include "closedialog.h"
#include "qtermglobal.h"
#include <QTimer>

namespace QTerm
{

CloseDialog::CloseDialog(QWidget * parent, Qt::WindowFlags fl)
    : QDialog(parent, fl),m_count(30)
{
    ui.setupUi(this);
    m_timer = new QTimer(this);
    connect(m_timer, SIGNAL(timeout()), this, SLOT(changeTitle()));
    changeTitle();
    m_timer->start(1000);
    restoreGeometry(Global::instance()->loadGeometry("Close"));
}

CloseDialog::~CloseDialog()
{
    Global::instance()->saveGeometry("Close",saveGeometry());
}

void CloseDialog::changeTitle()
{
    m_count--;
    if (m_count == 0) {
        accept();
        m_timer->stop();
        return;
    }
    setWindowTitle(tr("QTerm will quit in %1 seconds").arg(m_count));
}

void CloseDialog::setSiteList(const QStringList & list)
{
    ui.siteListWidget->addItems(list);
}

} // namespace QTerm

#include <moc_closedialog.cpp>
