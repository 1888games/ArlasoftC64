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

"""kye.dialogs - classes for dialog boxes used by the interface."""

import pygtk
pygtk.require('2.0')
import gtk
from os.path import exists
from kye.common import kyepaths, version

class GotoDialog(gtk.Dialog):
    """A dialog box for the player to select or type a level name to go to."""
    def __init__(self, parent=None, knownlevs = ()):
        gtk.Dialog.__init__(self, title="Go to level", parent = parent,flags = gtk.DIALOG_MODAL, buttons=(gtk.STOCK_OK, gtk.RESPONSE_ACCEPT, gtk.STOCK_CANCEL, gtk.RESPONSE_REJECT))
        self.set_default_response(gtk.RESPONSE_ACCEPT)
        
        # Add prompt.
        self.label = llabel("Select, or type, the name of the level to go to.")
        self.label.show()
        self.vbox.pack_start(self.label, True, True, 0)
        
        # Add combobox to select known level or enter level name.
        self.cb = gtk.combo_box_entry_new_text()
        for level in knownlevs:
            self.cb.append_text(level)
        self.cb.child.set_activates_default(True)
        self.vbox.pack_start(self.cb, True, True, 0)

        self.cb.show()

    def get_level(self):
        """Returns the selected level name."""
        return self.cb.child.get_text()

def pbimage(img):
    """Make a gtk.Image from a pixbuf."""
    i = gtk.Image()
    i.set_from_pixbuf(img)
    return i

def llabel(txt):
    """Return a centered, line-wrapped label."""
    l = gtk.Label(txt)
    l.set_alignment(0, 0.5)
    l.set_line_wrap(True)
    return l

class KyeHelpDialog(gtk.Dialog):
    """Help dialog box."""
        
    def __init__(self, parent=None, after=None, message=None, getimage=None):
        gtk.Dialog.__init__(self, title="Help", parent=parent,
                            flags=gtk.DIALOG_DESTROY_WITH_PARENT)
        self.add_button(gtk.STOCK_OK, 0)
        self.connect("response", self.response)
        table = gtk.Table(15, 2)
        self.vbox.pack_start(table, True, True, 0)
        table.attach(pbimage(getimage("kye")),0,1,0,1)
        table.attach(llabel("You are Kye. Move by point-and-click with the mouse, or the arrow keys or numeric keypad on the keyboard (note that you can move diagonally, even using the keyboard)."),1,2,0,1)
        table.attach(pbimage(getimage("diamond_1")),0,1,1,2)
        table.attach(llabel("The object of the game is to collect all the diamonds."),1,2,1,2)
        table.attach(pbimage(getimage("wall5")),0,1,2,3)
        table.attach(llabel("These are solid walls."),1,2,2,3)
        table.attach(pbimage(getimage("block")),0,1,3,4)
        table.attach(llabel("These are blocks, which you can push."),1,2,3,4)
        table.attach(pbimage(getimage("slider_right")),0,1,4,5)
        table.attach(llabel("Sliders move in the direction of the arrow until they hit an obstacle."),1,2,4,5)
        table.attach(pbimage(getimage("rocky_right")),0,1,5,6)
        table.attach(llabel("Rockies move like sliders, but they roll around round objects, like rounded walls and other rockies."),1,2,5,6)
        table.attach(pbimage(getimage("blocke")),0,1,6,7)
        table.attach(llabel("Soft blocks you can destroy by moving into them."),1,2,6,7)
        mh = gtk.HBox()
        mh.pack_start(pbimage(getimage("blob_1")),True,True,0)
        mh.pack_start(pbimage(getimage("gnasher_1")),True,True,0)
        mh.pack_start(pbimage(getimage("spike_1")),True,True,0)
        mh.pack_start(pbimage(getimage("twister_1")),True,True,0)
        mh.pack_start(pbimage(getimage("snake_1")),True,True,0)
        table.attach(mh,0,1,7,8)
        table.attach(llabel("Monsters kill you if they touch you. You do have 3 lives, though."),1,2,7,8)
        table.attach(pbimage(getimage("sentry_right")),0,1,8,9)
        table.attach(llabel("Sentries pace back and forward, and push other objects."),1,2,8,9)
        table.attach(pbimage(getimage("black_hole_1")),0,1,9,10)
        table.attach(llabel("Objects entering a black hole are destroyed."),1,2,9,10)
        table.attach(pbimage(getimage("slider_shooter_right")),0,1,10,11)
        table.attach(llabel("Shooters create new sliders or rockies."),1,2,10,11)
        table.attach(pbimage(getimage("block_timer_5")),0,1,11,12)
        table.attach(llabel("Timer blocks disappear when their time runs out."),1,2,11,12)
        table.attach(pbimage(getimage("turner_clockwise")),0,1,12,13)
        table.attach(llabel("Turning blocks change the direction of sliders and rockies."),1,2,12,13)
        table.attach(pbimage(getimage("sticky_horizontal")),0,1,13,14)
        table.attach(llabel("Magnets (also called sticky blocks) allow you to pull objects."),1,2,13,14)
        table.attach(pbimage(getimage("oneway_right_1")),0,1,14,15)
        table.attach(llabel("One-way doors only allow Kye though, and only in one direction."),1,2,14,15)
        foottext = llabel("If you make a mistake, or get stuck in a level, go to the Level menu and select Restart Level. To skip to a particular level (if you've played a set of levels before and already know the level name you want to get to), go to the Level menu and select Goto Level. You can load a new set of levels by specifying the .kye file on the command line, or by opening it via the File menu.")
        foottext.set_justify(gtk.JUSTIFY_LEFT)
        foottext.set_line_wrap(True)
        self.vbox.pack_start(foottext, True, True, 0)
        foottext.show()
        table.set_row_spacings(4)
        table.set_col_spacings(2)
        table.show_all()

    def response(self, a, rid):
        self.destroy()

def kyeffilter():
    """Constructs a gtk.FileFilter for .kye files"""
    kfilter = gtk.FileFilter()
    kfilter.set_name("Kye Levels")
    kfilter.add_pattern("*.kye")
    return kfilter

def kyerfilter():
    """Constructs a gtk.FileFilter for .kyr files"""
    kfilter = gtk.FileFilter()
    kfilter.set_name("Kye Recordings")
    kfilter.add_pattern("*.kyr")
    return kfilter

def getopendialog():
    """Build a gtk.FileChooserDialog suitable for Kye levels"""
    filesel = gtk.FileChooserDialog("Open Kye Levels",
        buttons=(gtk.STOCK_OK, gtk.RESPONSE_OK, gtk.STOCK_CANCEL, gtk.RESPONSE_REJECT))
    filesel.add_filter(kyeffilter())
    for path in kyepaths:
        if path[0] == "/" and exists(path):
            filesel.add_shortcut_folder(path)
    return filesel

def KyeAboutDialog(kimg):
    """Returns a gtk.AboutDialog with all the names/details/versions for Kye entered.
    
    Used to be a subclass of AboutDialog, hence the name.
    """
    try:
        d = gtk.AboutDialog()
        d.set_name("Kye")
        d.set_version(version)
        d.set_website("http://games.moria.org.uk/kye/pygtk")
        d.set_authors(("Colin Phipps <cph@moria.org.uk>",))
        d.set_copyright("Copyright (C) 2004-2007, 2010 Colin Phipps <cph@moria.org.uk>")
        d.set_comments("Based on the original Kye for Windows, by Colin Garbutt")
        d.set_license("Distributed under the GNU General Public License")
        d.set_logo(kimg)
        return d
    except AttributeError, e:
        # Old pygtk versions do not have an AboutDialog, so fall back on a MessageDialog.
        d = gtk.MessageDialog(type=gtk.MESSAGE_INFO, message_format = "Kye "+version+" - by Colin Phipps <cph@moria.org.uk>", buttons=gtk.BUTTONS_OK)
        return d
