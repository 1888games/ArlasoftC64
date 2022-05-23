# -*- coding: utf-8 -*-
#    Kye - classic puzzle game
#    Copyright (C) 2005, 2006, 2007, 2010 Colin Phipps <cph@moria.org.uk>
#
#    This program is free software; you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation; either version 2 of the License, or
#    (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with this program; if not, write to the Free Software
#    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
#

"""Classes for the status bar for the Kye game GUI."""

import pygtk
pygtk.require('2.0')
import gtk

class StatusBarKyes(gtk.DrawingArea):
    """Small gtk DrawingArea-derived widget for the bottom-left of the game display, showing lives left."""
    def __init__(self, kyeimg):
        gtk.DrawingArea.__init__(self)
        self.set_size_request(20*3+4, 20)
        self.__kyeimg = kyeimg
        self.connect("expose-event", self.expose)
        self.__kyes = None
        
    def expose(self, window,event):
        """Handle redraws."""
        gc = self.window.new_gc()
        gc.set_fill(gtk.gdk.SOLID)
        gc.set_function(gtk.gdk.COPY)
        self.window.draw_rectangle(self.style.bg_gc[gtk.STATE_NORMAL], True, 0, 0, 20*3+4, 20)
        if self.__kyes != None:
            for n in range(self.__kyes):
                self.window.draw_pixbuf(gc, self.__kyeimg, 0, 0, 20*n+2, 2,
                    self.__kyeimg.get_width(), self.__kyeimg.get_height())

    def update(self, num_kyes):
        """Set the number of kye lives to show; schedules a redraw if needed."""
        if num_kyes != self.__kyes:
            self.__kyes = num_kyes
            self.queue_draw_area(0, 0, 20*3+4, 20)
        
class StatusBar(gtk.HBox):
    """Gtk widget for the Kye status bar."""
    string_map = {
        "diamonds"  :   "Diamonds left", 
        "levelnum"  :   "Level",
        "hint"      :   "Hint"
    }

    def __init__(self, kyeimg):
        gtk.HBox.__init__(self)
        self.hint = None
        self.levelnum = None
        self.diamonds = None

        self.__kyes_widget = StatusBarKyes(kyeimg)
        self.pack_start(self.__kyes_widget, False, False, 2)

        for k in ("diamonds", "levelnum", "hint"):
            this_label = self.__dict__[k] = gtk.Label("")
            this_label.set_alignment(0.5, 0.5)
            if k == "hint":
                # Need an eventbox around the hint label, so we can add a tooltip later.
                add_widget = self.__hint_eventbox = gtk.EventBox()
                add_widget.add(this_label)
            else:
                add_widget = this_label
            self.pack_start(add_widget, False, False, 3)
        self.show_all()

    def update(self, **keywords):
        """Update data displayed in the status bar."""
        for k, value in keywords.iteritems():
            # hint text should also be added to the tooltip.
            if k == "hint":
                self.__hint_eventbox.set_tooltip_text(value)
            
            # The string labels we update; the kye count, we pass to the special kyes widget.
            if k in StatusBar.string_map:
                self.__dict__[k].set_text("%s: %s" % (StatusBar.string_map[k], str(value)))
            elif k == "kyes":
                self.__kyes_widget.update(value)
