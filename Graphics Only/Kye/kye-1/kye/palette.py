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

"""kye.palette - the object selection palette for the editor."""

import pygtk
pygtk.require('2.0')
import gtk
from kye.common import xsize, ysize

class KPalette(gtk.DrawingArea):
    """Provides  object selection palette widget for the editor."""
    def __init__(self, palsource):
        # Misc initial state
        self.mousedown = None
        self.mousebuttondown = None
        self.game = None
        
        # Set up the drawing area
        gtk.DrawingArea.__init__(self)
        self.set_events(gtk.gdk.EXPOSURE_MASK | gtk.gdk.BUTTON_PRESS_MASK)
        self.connect("button_press_event", self.palette_click_event)
        self.connect("expose-event", self.expose)
        
        # Build up the palette. The list of tools contains a number of circularly linked lists
        # of similar tools; we want just one tool from each list in our palette, and the user will
        # cycle through the similar tools by clicking on them. The code below just puts one 
        # item from each list into palitems, and ignores the others.
        self.__palsource = palsource
        palitems = {}
        already = {}
        for f, tool_data in palsource.iteritems():
            x = tool_data[1]
            if f not in already and x != '':
                palitems[f] = 1
                already[f] = 1
                while x != f:
                    already[x] = 1
                    x = palsource[x][1]
        
        # So make the initial palette from palitems.
        self.palitems = palitems.keys()
        
        # Start with the wall tool.
        self.selected = '5'

    def setup(self, getimage):
        self.__getimage = getimage

    def settilesize(self, tilesize):
        """Set the tile size for the display."""
        self.__tilesize = tilesize
        self.set_size_request(self.__tilesize*xsize, self.__tilesize+8)

    def set_target(self, g):
        """Sets the game object towards which editing events will be directed."""
        self.game = g
        self.mousedown = None
        self.mousebuttondown = None

    def set_at(self, x, y, mousebuttondown):
        """Applies mouse button click or drag at x,y."""
        if self.selected:
            if mousebuttondown == 1:
                self.game.set_at(x, y, self.selected)
            elif mousebuttondown == 3:
                self.game.set_at(x, y, ' ')

    def click_item(self, i):
        """Acts on a click on a specific palette item, given by i."""
        # Rotate tool if already selected
        if self.palitems[i] == self.selected:
            self.palitems[i] = self.__palsource[self.selected][1]
        
        # Set selected tool & redraw palette (so new item shown as selected)
        self.selected = self.palitems[i]
        self.queue_draw_area(0, 4, self.__tilesize*xsize, self.__tilesize+4)

    # Events in the palette

    def palette_click_event(self, window, event):
        """Acts on a click on the palette."""
        if event.type != gtk.gdk.BUTTON_PRESS: return
        x, y, mods = event.window.get_pointer()
        y = y - 4
        if y < 0: return
        x = x / (self.__tilesize+4)
        if x < len(self.palitems):
            self.click_item(x)

    def expose(self,window,event):
        """Handle redraws."""
        gc = self.window.new_gc()
        gc.set_fill(gtk.gdk.SOLID)
        gc.set_function(gtk.gdk.COPY)
        self.window.draw_rectangle(self.style.black_gc, True, 0, 0, self.__tilesize*xsize, 4)
        self.window.draw_rectangle(self.style.white_gc, True, 0, 4, self.__tilesize*xsize, self.__tilesize+4)
        x = 0
        for i in self.palitems:
            if i == self.selected:
                self.window.draw_rectangle(self.style.bg_gc[gtk.STATE_SELECTED],True, x, 4,self.__tilesize+4,self.__tilesize+4)
            self.window.draw_pixbuf(gc, self.__getimage(self.__palsource[i][0]), 0, 0, 2+x, 6, self.__tilesize, self.__tilesize, gtk.gdk.RGB_DITHER_NORMAL, 0, 0)
            x = x + 4 + self.__tilesize

    # These are events passed from the canvas
    def button_press_event(self, button, x, y):
        """Handle mouse press event."""
        if self.mousedown == None:
            self.mousebuttondown = button
            self.mousedown = (x, y)
            self.set_at(x, y, self.mousebuttondown)

    def button_release_event(self, button, x, y):
        """Handle mouse release event."""
        self.mousedown = None
        self.mousebuttondown = None

    def mouse_motion_event(self, x, y):
        """Handle mouse motion event."""
        if x > xsize or y > ysize or x < 0 or y < 0: return
        if self.mousedown != None:
            if x != self.mousedown[0] or y != self.mousedown[1]:
                self.set_at(x, y, self.mousebuttondown)
                self.mousedown = (x, y)
