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
"""kye.frame - classes and data for the frame and menus for the Kye game."""

import pygtk
pygtk.require('2.0')
import gtk
from kye.canvas import KCanvas
from kye.input import KMoveInput
from kye.stbar import StatusBar
from kye.dialogs import GotoDialog, KyeHelpDialog, KyeAboutDialog, getopendialog, kyerfilter
import kye.common
from os.path import basename

ui_string = """<ui>
 <menubar name='KyeMenuBar'>
  <menu action='FileMenu'>
   <menuitem action='Open' />
   <menu action='RecentMenu' />
   <menuitem action='Quit' />
  </menu>
  <menu action='LevelMenu'>
   <menuitem action='Restart Level' />
   <menuitem action='Restart &amp; Record' />
   <menuitem action='Goto Level' />
   <menuitem action='Play recording' />
  </menu>
  <menu action='ViewMenu'>
   <menuitem action='Tiny' />
   <menuitem action='Small' />
   <menuitem action='Medium' />
   <menuitem action='Large' />
  </menu>
  <menu action='HelpMenu'>
   <menuitem action='The Game' />
   <menuitem action='About Kye' />
  </menu>
 </menubar>
</ui>"""

class KFrame(gtk.Window):
    """Class implementing the frame surrounging the game area, including the menus and status bar."""

    def delete_event(self, widget, event, data=None):
        """Handle window-close event."""
        # If you return FALSE in the "delete_event" signal handler,
        # GTK will emit the "destroy" signal. Returning TRUE means
        # you don't want the window to be destroyed.
        # This is useful for popping up 'are you sure you want to quit?'
        # type dialogs.
        return False

    def destroy(self, widget, data=None):
        """Handle window destroy by exiting GUI."""
        gtk.main_quit()

    def build_ui(self, tilesize = 16):
        """Build the menus and shortcut keys."""
        action_group = gtk.ActionGroup('WindowActions')

        actions = [
                ("FileMenu", None, "_File"),
                ("Open", gtk.STOCK_OPEN, "_Open…", "<control>O", "Open a set of levels", self.opendialog),
                ("RecentMenu", None, "Recent Files"),
                ("Quit", gtk.STOCK_QUIT, "_Quit", "<control>Q", "Quit the game", self.destroy),
                ("LevelMenu", None, "_Level"),
                ("Restart Level", None, "_Restart Level", "<control>R", "Restart this level", self.restart),
                ("Restart & Record", None, "Restart & Re_cord…", None, "Restart this level & record your play", self.record),
                ("Goto Level", None, "_Goto Level…", "<control>G", "Jump to a named level", self.startgoto),
                ("Play recording", None, "_Play recording…", None, "Play back a previously made recording of a level", self.playdemo),
                ("ViewMenu", None, "_View"),
                ("HelpMenu", None, "_Help"),
                ("The Game", gtk.STOCK_HELP, "_The Game","<control>T", "Help for playing the game", self.helpdialog),
                ("About Kye", gtk.STOCK_ABOUT, "About _Kye", "<control>K", "About Python Kye", self.aboutdialog),
        ]
        radio_actions = [
                ("Tiny", None, "_Tiny", "<control>1", "Set window size", 8),
                ("Small", None, "_Small", "<control>2", "Set window size", 16),
                ("Medium", None, "_Medium", "<control>3", "Set window size", 24),
                ("Large", None, "_Large", "<control>4", "Set window size", 32)
        ]
        action_group.add_actions(actions)
        action_group.add_radio_actions(radio_actions, tilesize, self.settilesize)
        self.ui = gtk.UIManager()
        self.ui.insert_action_group(action_group, 0)
        self.ui.add_ui_from_string(ui_string)
        self.add_accel_group(self.ui.get_accel_group())
        self.ignore_sizing = False

    def __init__(self, app, settings, recentlevels = []):
        if gtk.pygtk_version[0] < 2 or gtk.pygtk_version[1] < 4:
            raise EnvironmentError, "Needs at least pygtk-2.4.0"
        # create a new window
        gtk.Window.__init__(self, gtk.WINDOW_TOPLEVEL)
    
        # When the window is given the "delete_event" signal (this is given
        # by the window manager, usually by the "close" option, or on the
        # titlebar), we ask it to call the delete_event () function
        # as defined above. The data passed to the callback
        # function is NULL and is ignored in the callback function.
        self.connect("delete_event", self.delete_event)
    
        # Here we connect the "destroy" event to a signal handler.  
        # This event occurs when we call gtk_widget_destroy() on the window,
        # or if we return FALSE in the "delete_event" callback.
        self.connect("destroy", self.destroy)
    
        # Sets the border width of the window.
        self.__title = ["Kye", ""]
        self.__set_title()
        self.set_resizable(False)
    
        self.moveinput = KMoveInput()
        # Creates a new canvas
        tilesize = 16
        if "Size" in settings:
            tilesize = int(settings["Size"])
        try:
            self.canvas = KCanvas(self.moveinput, tilesize)
        except (IOError, OSError), e:
            self.error_message("%s" % e)
            raise
    
        # Main vbox
        self.main_vbox = gtk.VBox(False)
        self.main_vbox.set_border_width(1)

        # Build menu
        self.build_ui(tilesize = tilesize)
        self.menubar = self.ui.get_widget('/KyeMenuBar')
        self.main_vbox.pack_start(self.menubar, False, True, 0)
        self.menubar.show()

        # This packs the button into the window (a GTK container).
        self.main_vbox.pack_start(self.canvas, padding=0)
        self.canvas.show()

        # Status bar
        self.stbar = StatusBar(self.canvas.get_image("kye", tilesize=16))
        self.stbar.set_size_request(tilesize * kye.common.xsize, -1)
        self.main_vbox.pack_start(self.stbar, padding=0)
        self.stbar.show()

        # Add and display the vbox
        self.add(self.main_vbox)
        self.main_vbox.show()

        # and the window
        self.set_icon(self.canvas.get_image("kye"))
        self.show()
        self.set_focus(self.canvas)
        self.__app = app
        self.settings = settings
        self.recent_ui_mid = self.recent_ag = None
        self.set_recent(recentlevels)

    def __set_title(self):
        """(Re)set the window title."""
        self.set_title(" — ".join(self.__title))

    def level_title(self, title):
        """Update the title of the level in the window title."""
        self.__title[1] = title
        self.__set_title()

    def extra_title(self, extitle):
        """Set an addition to the window title after the level name."""
        try:
            del self.__title[2]
        except IndexError, e:
            pass
        if extitle != None:
            self.__title.append(extitle)
        self.__set_title()

    def set_recent(self, recentlevels):
        """Set the list of recently-played level sets, for the recent files menu."""
        self.recent_levels = recentlevels
        
        # Remove any existing level list
        if self.recent_ui_mid != None:
            self.ui.remove_ui(self.recent_ui_mid)
        if self.recent_ag != None:
            self.ui.remove_action_group(self.recent_ag)
        self.recent_ui = None

        # Build extra menu items, and their actions, for level selection
        action_group = gtk.ActionGroup("RecentActions")
        actions = []
        uistring = """<ui><menubar name='KyeMenuBar'><menu action='FileMenu'><menu action='RecentMenu'>"""
        for n, filename in enumerate(recentlevels):
            actions.append(("Recent%d" % n, None, basename(filename), None, "Open "+filename, self.open_recent))
            uistring = uistring + "<menuitem action='Recent%d' />" % n
        uistring = uistring + "</menu></menu></menubar></ui>"
        action_group.add_actions(actions)
        self.recent_ag = action_group
        self.ui.insert_action_group(self.recent_ag, 1)
        self.recent_ui_mid = self.ui.add_ui_from_string(uistring)

    def open_recent(self, widget):
        """Called when a recent-file entry from the menu is selected, opens the corresponding file."""
        # Nasty hack - extract the recent list # from the action string (FIXME)
        n = int(widget.get_accel_path()[-1])
        self.doopen(self.recent_levels[n])

    def opendialog(self, w):
        """Let the user select a level set file to play."""
        filesel = getopendialog()
        response = filesel.run()
        if response == gtk.RESPONSE_OK:
            filename = filesel.get_filename()
            filesel.destroy()
            self.doopen(filename)
        else:
            filesel.destroy()

    def playdemo(self, w):
        """Let the user select a recording to play back."""
        filesel = gtk.FileChooserDialog("Choose Kye Recording",
            action=gtk.FILE_CHOOSER_ACTION_OPEN,
            buttons=(gtk.STOCK_OK, gtk.RESPONSE_OK, gtk.STOCK_CANCEL, gtk.RESPONSE_REJECT))
        filesel.add_filter(kyerfilter())
        response = filesel.run()
        if response == gtk.RESPONSE_OK:
            filename = filesel.get_filename()
            filesel.destroy()
            self.__app.restart(demo=filename)
        else:
            filesel.destroy()

    def record(self, w):
        """Restart the current level with recording, after asking the user for a filename."""
        filesel = gtk.FileChooserDialog("Save Kye Recording",
            action=gtk.FILE_CHOOSER_ACTION_SAVE,
            buttons=(gtk.STOCK_OK, gtk.RESPONSE_OK, gtk.STOCK_CANCEL, gtk.RESPONSE_REJECT))
        filesel.add_filter(kyerfilter())
        filesel.set_current_name(".kyr")
        try:
            filesel.set_do_overwrite_confirmation(True)
        except AttributeError, e:
            pass
        response = filesel.run()
        if response == gtk.RESPONSE_OK:
            filename = filesel.get_filename()
            filesel.destroy()
            self.__app.restart(recordto = filename)
        else:
            filesel.destroy()        

    def restart(self, w):
        """Menu requested restart of the current level."""
        self.__app.restart()

    def doopen(self, filename):
        """Tell the game to open the given level set."""
        self.__app.open(filename)

    def startgoto(self, w):
        """Let the user select or type a level to go to, and jump to that level."""
        gd = GotoDialog(parent=self, knownlevs = self.__app.known_levels())
        r = gd.run()
        t = gd.get_level()
        gd.destroy()
        if r == gtk.RESPONSE_ACCEPT:
            self.__app.goto(t)

    def settilesize(self, ra, u):
        """Set the tile size based on the selected menu item, and push that change to relevant GUI elements."""
        if not self.ignore_sizing:
            ts = ra.get_current_value()
            self.canvas.settilesize(ts)
            self.stbar.set_size_request(ts * kye.common.xsize, -1)
            self.settings["Size"] = ts

    def endleveldialog(self, nextlevel, endmsg):
        """Call when the level ends, to give the between-level messages."""
        self.canvas.brelease(1, 0, 0)

        if nextlevel != "":
            end_title = "Level completed."
            nextlevelmsg = "Entering "+nextlevel
        else:
            end_title = "All levels completed."
            nextlevelmsg = "Returning to first level"

        md = gtk.MessageDialog(self, gtk.DIALOG_MODAL, buttons=gtk.BUTTONS_OK, message_format=end_title)
        md.format_secondary_markup(endmsg)
        md.run()
        md.destroy()

        # Now the starting-level dialog.
        md = gtk.MessageDialog(self, gtk.DIALOG_MODAL, buttons=gtk.BUTTONS_OK, message_format=nextlevelmsg)
        md.run()
        md.destroy()

        # And start the new level.
        self.__app.goto(nextlevel)

    def helpdialog(self, a):
        """Show the help dialog box."""
        hd = KyeHelpDialog(getimage=self.canvas.get_image, parent=self)
        hd.show()

    def aboutdialog(self, a):
        """Show the about dialog box."""
        ad = KyeAboutDialog(kimg = self.canvas.get_image("kye"))
        ad.run()
        ad.destroy()

    def error_message(self, message):
        """Show an error message in a dialog box."""
        md = gtk.MessageDialog(parent=self, type=gtk.MESSAGE_ERROR,
            message_format=message, buttons=gtk.BUTTONS_OK)
        md.run()
        md.destroy()

    def main(self):
        """Main GUI loop."""
        # All PyGTK applications must have a gtk.main(). Control ends here
        # and waits for an event to occur (like a key press or mouse event).
        gtk.main()

