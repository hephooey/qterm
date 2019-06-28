/*
    Shamelessly copied from the patch for konsole at:
    https://bugs.kde.org/show_bug.cgi?id=198175
    with some obvious modifications for QTerm

    This file is part of Konsole, a terminal emulator for KDE.

    Copyright 2010 Hugo Pereira Da Costa <hugo@oxygen-icons.org>

    This program is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation; either version 2 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program; if not, write to the Free Software
    Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
    02110-1301  USA.
*/

#include "blur.h"

#include <QWidget>

#ifdef Q_OS_LINUX
#include <KWindowEffects>
#endif

namespace QTerm
{

  //_________________________________________________________________________
  void BlurHelper::updateBlurRegion( QWidget* widget, const QRegion& region ) const
  {
#ifdef Q_OS_LINUX
    KWindowEffects::enableBlurBehind(widget->winId(), true);
#endif
  }

}

