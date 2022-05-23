# -*- coding: UTF-8 -*-
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
"""kye.editor - classes and data for the level editor."""

import pygtk
pygtk.require('2.0')
import gtk

from tempfile import mkstemp
from os import unlink, fdopen

from kye.common import kyepaths, tryopen
from kye.canvas import KCanvas
from kye.palette import KPalette
from kye.dialogs import KyeHelpDialog, KyeAboutDialog, llabel, getopendialog, kyeffilter
from kye.leveledit import KLevelEdit

ui_string = """<ui>
 <menubar name='KyeEditMenuBar'>
  <menu action='FileMenu'>
   <menuitem action='Open' />
   <menuitem action='Save' />
   <menuitem action='SaveAs' />
   <separator />
   <menuitem action='Quit' />
  </menu>
  <menu action='EditMenu'>
   <menuitem action='Undo' />
   <separator />
   <menuitem action='Auto-round walls' />
  </menu>
  <menu action='LevelMenu'>
   <menuitem action='New Level' />
   <menuitem action='Edit Level Text' />
   <menuitem action='Delete Level' />
   <separator />
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

class KEditor(gtk.Window):
    """Class implementing the level editor GUI."""

    def delete_event(self, widget, event, data=None):
        """Handle the user closing the editor window."""
        # If you return FALSE in the "delete_event" signal handler,
        # GTK will emit the "destroy" signal. Returning TRUE means
        # you don't want the window to be destroyed.
        # This is useful for popping up 'are you sure you want to quit?'
        # type dialogs.
        if self.g.is_modified():
            md = gtk.MessageDialog(self, type=gtk.MESSAGE_QUESTION,
                        buttons=gtk.BUTTONS_YES_NO,
                        message_format="Quit without saving?")
            r = md.run()
            md.destroy()
            if r == gtk.RESPONSE_NO:
                return True
        self.__lose_ok = True
        return False

    # Another callback
    def destroy(self, widget, data=None):
        """Handle a sudden exit."""
        if not self.__lose_ok and self.g.is_modified():
            self.dosave("/var/tmp/abort.kye")
        gtk.main_quit()

    def build_ui(self):
        """Construct UIManager and ActionGroup with bindings to functions here to handle menu actions"""
        action_group = gtk.ActionGroup('WindowActions')

        actions = [
            ("FileMenu", None, "_File"),
            ("Open", gtk.STOCK_OPEN, "_Open…", "<control>O", "Open a set of levels", self.opendialog),
            ("Save", gtk.STOCK_SAVE, "_Save","<control>S", "Save these levels", self.menusave),
            ("SaveAs", gtk.STOCK_SAVE_AS, "Save _As…","<control>A", "Save these levels to a new filename", self.menusaveas),
            ("Quit", gtk.STOCK_QUIT, "_Quit", "<control>Q", "Quit the game", self.quit),
            ("EditMenu", None, "_Edit"),
            ("Undo", gtk.STOCK_UNDO, "_Undo","<control>Z", "Undo last edit", self.undo),
            ("LevelMenu", None, "_Level"),
            ("New Level", None, "_New Level", "<control>N", "Add a new level to this set of levels", self.newlevel),
            ("Edit Level Text", None, "_Edit Level Text…", "<control>E", "Edit the level name, hint and exit message for this level", self.textdialog),
            ("Delete Level", None, "_Delete Level", "<control>D", "Delete this level from this level set", self.delete_level),
            ("ViewMenu", None, "_View"),
            ("HelpMenu", None, "_Help"),
            ("The Game", gtk.STOCK_HELP, "_The Game","<control>T", "Help for playing the game", self.helpdialog),
            ("About Kye", gtk.STOCK_ABOUT, "About _Kye", "<control>K", "About Python Kye", self.aboutdialog),
        ]
        action_group.add_actions(actions)

        toggle_actions = [
            ("Auto-round walls", None, "Auto-_round walls", "<control>R", "Toggle whether wall corners are rounded off automatically by the editor", self.autoroundclick, True)
        ]
        action_group.add_toggle_actions(toggle_actions)

        # View menu is a series of radio options
        radio_actions = [
            ("Tiny", None, "_Tiny", "<control>1", "Set window size", 8),
            ("Small", None, "_Small", "<control>2", "Set window size", 16),
            ("Medium", None, "_Medium", "<control>3", "Set window size", 24),
            ("Large", None, "_Large", "<control>4", "Set window size", 32)
        ]
        action_group.add_radio_actions(radio_actions, 16, self.settilesize)

        # And now create the UI object and add accel group to the window
        self.ui = gtk.UIManager()
        self.ui.insert_action_group(action_group, 0)
        self.ui.add_ui_from_string(ui_string)
        self.add_accel_group(self.ui.get_accel_group())

    def __init__(self):
        if gtk.pygtk_version[0] < 2 or gtk.pygtk_version[1] < 2:
            raise EnvironmentError, "Needs at least pygtk-2.2.0"
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
        self.set_title("Kye Level Editor")
        self.set_resizable(False)
    
        # Create edit tool
        self.palette = KPalette(KLevelEdit.cell_lookup)
        self.palette.settilesize(16)
      
        # Creates a new canvas, directing mouse events to the palette
        try:
            self.canvas = KCanvas(self.palette)
        except (IOError, OSError), e:
            self.error_message("%s" % e)
            raise

        # Now palette can set up
        self.palette.setup(self.canvas.get_image)
        
        # Main vbox
        self.main_vbox = gtk.VBox(False)
        self.main_vbox.set_border_width(1)

        # Build menu
        self.levels_ui_mid = self.levels_ag = None
        self.build_ui()
        self.menubar = self.ui.get_widget('/KyeEditMenuBar')
        self.main_vbox.pack_start(self.menubar, False, True, 0)
        self.menubar.show()

        # This packs the button into the window (a GTK container).
        self.main_vbox.pack_start(self.canvas, padding=0)
        self.canvas.show()

        # And the palette
        self.main_vbox.pack_start(self.palette, padding=0)
        self.palette.show()

        # Add and display the vbox
        self.add(self.main_vbox)
        self.main_vbox.show()

        # and the window
        self.set_icon(self.canvas.get_image("kye"))
        self.show()
        self.set_focus(self.canvas)
        self.set_menuitem_sensitive("/KyeEditMenuBar/FileMenu/Save", False)

        # More internal state setup
        self.__lose_ok = False
        self.__fn = None
        self.g = None
        self.__newlevel = None
        self.__tf = None

    # UI maintenance - dynamic menus and changing menu item sensitivity

    def setfname(self, filename):
        """Set filename for the currently edited file - used for Save, and in the menu bar"""
        self.__fn = filename
        self.set_menuitem_sensitive("/KyeEditMenuBar/FileMenu/Save", True)
        self.set_title("Kye Level Editor - %s" % filename)

    def set_menuitem_sensitive(self, menu_item, is_sensitive):
        """Simple wrapper to set sensitivity of a menu item by path."""
        self.ui.get_widget(menu_item).set_sensitive(is_sensitive)

    def hintmenuitems(self, **h):
        """Callback from the editing code, which sets the sensitivity of certain menu items.
        
        Call with:
        dlevel -- true or false, sets sensitivity of the Delete Level menu item.
        undo -- true or false, sets sensitivity of the Undo menu item.
        """
        if 'dlevel' in h:
            self.set_menuitem_sensitive('/KyeEditMenuBar/LevelMenu/Delete Level', h['dlevel'])
        if 'undo' in h:
            self.set_menuitem_sensitive('/KyeEditMenuBar/EditMenu/Undo', h['undo'])

    def setlevels(self, l, cur):
        """Sets the list of levels in the menu."""
        # Remove any existing level list
        if self.levels_ui_mid != None:
            self.ui.remove_ui(self.levels_ui_mid)
        if self.levels_ag != None:
            self.ui.remove_action_group(self.levels_ag)
        self.levels_ui_mid = self.levels_ag = None

        # Build extra menu items, and their actions, for level selection
        action_group = gtk.ActionGroup("LevelActions")
        radio_actions = []
        uistring = """<ui><menubar name='KyeEditMenuBar'><menu action='LevelMenu'>"""
        for n, name in enumerate(l):
            radio_actions.append(("Level%d" % n, None, name, None, "Edit level "+name, n))
            uistring = uistring + "<menuitem action='Level%d' />" % n
        uistring = uistring + "</menu></menubar></ui>"
        action_group.add_radio_actions(radio_actions, cur, self.levelselect)
        self.levels_ag = action_group
        self.ui.insert_action_group(action_group, 1)
        self.levels_ui_mid = self.ui.add_ui_from_string(uistring)

    # Menu item handling (except file actions & dialogs)

    def levelselect(self, menu_item, u):
        """Change selected level"""
        self.g.setlevel(n=menu_item.get_current_value())

    def undo(self, a):
        """Undo handler"""
        try:
            self.g.undo()
        except IndexError, e:
            self.error_message("No undo available")

    def newlevel(self, a):
        """New Level handler."""
        self.g.newlevel()

    def delete_level(self, a):
        """Delete Level handler."""
        self.g.delete_level()

    def autoroundclick(self, a):
        """Handle clicking on the auto-round menu checkbox"""
        self.g.set_autoround(s = a.get_active())

    def settilesize(self, ra, u):
        """Respond to view menu selections"""
        a = ra.get_current_value()
        self.canvas.settilesize(a)
        self.palette.settilesize(a)

    def quit(self, a):
        """Handler for Quit menu item."""
        if self.delete_event(None, a):
            return
        gtk.main_quit()

    # Now file actions

    def dochecks(self):
        """Returns True unless there are errors and the user cancels the save."""
        errs = self.g.check()
        if len(errs) == 0: return True
        errmsg = 'Errors were found in some of your levels:'
        for level, level_errors in errs.iteritems():
            errmsg = errmsg + '\n' + level + ':' + '\n'.join(level_errors)
        md = gtk.MessageDialog(parent=self, type=gtk.MESSAGE_WARNING,
                    buttons=gtk.BUTTONS_OK_CANCEL, message_format=errmsg)
        response = md.run()
        md.destroy()
        return response == gtk.RESPONSE_OK

    def opendialog(self, a):
        """Prompt for a .kye file to open, and then pass to opencall"""
        filesel = getopendialog()
        response = filesel.run()
        if response == gtk.RESPONSE_OK:
            filename = filesel.get_filename()
            filesel.destroy()
            self.do_open(filename)
        else:
            filesel.destroy()

    def do_open(self, fname, template = 0):
        """Open a new level set to edit."""
        try:
            gamefile = tryopen(fname, kyepaths)
            self.g = KLevelEdit(gamefile, disp = self.canvas, newleveltemplate=self.__newlevel, setlevellist = self.setlevels, hintmenuitems = self.hintmenuitems)
            self.palette.set_target(self.g)
            if template == 0:
                self.setfname(fname)
        except IOError, e:
            self.error_message(message="Failed to read "+fname)
            return False
        try:
            self.__tf.seek(0)
            self.__tf.truncate()
            self.g.saveto(self.__tf)
        except IOError, e:
            self.error_message(message="Failed to write backup copy %s" % self.__tf.name)        
        return True

    def menusaveas(self, a):
        """Ask where to save and then save the levels there"""
        if not self.dochecks():
            return
        filesel = gtk.FileChooserDialog("Save Kye Levels", action=gtk.FILE_CHOOSER_ACTION_SAVE, buttons=(gtk.STOCK_OK, gtk.RESPONSE_OK, gtk.STOCK_CANCEL, gtk.RESPONSE_REJECT))
        filesel.add_filter(kyeffilter())
        try:
            filesel.set_do_overwrite_confirmation(True)
        except AttributeError, e:
            pass        
        response = filesel.run()
        if response == gtk.RESPONSE_OK:
            filename = filesel.get_filename()
            filesel.destroy()
            if self.dosave(filename):
                self.setfname(filename)
        else:
            filesel.destroy()

    def menusave(self, a):
        """Save from the menu - check we do know the filename, and do checks, and finally pass through to the actual save function"""
        if self.__fn == None:
            # Should be impossible, menu item ought to be deselected
            self.error_message("No filename given - use Save As")
        else:
            if self.dochecks():
                self.dosave(self.__fn)

    def dosave(self, filename):
        """Do an actual save to filename."""
        try:
            f = open(filename, 'wb')
            self.g.saveto(f)
            f.close()
            self.g.saved()
            return True
        except IOError, e:
            self.error_message("Unable to save '%s': %s" % (filename, e))
            return False

    # Finally, other menu items leading to dialogs

    def helpdialog(self, a):
        """Help handler."""
        hd = KyeHelpDialog(getimage=self.canvas.get_image, parent=self)
        hd.show()

    def textdialog(self, a):
        """Edit Level Text handler."""
        # Create dialog.
        lt_dialog = gtk.Dialog(title='Set level text', parent=self,
                flags=gtk.DIALOG_MODAL, buttons=(gtk.STOCK_OK, gtk.RESPONSE_ACCEPT, gtk.STOCK_CANCEL, gtk.RESPONSE_REJECT))
        lt_dialog.set_default_response(gtk.RESPONSE_ACCEPT)
        table = gtk.Table(3,2)
        table.attach(llabel("Level name"),0,1,0,1)
        table.attach(llabel("Hint text"),0,1,1,2)
        table.attach(llabel("End of level text"),0,1,2,3)
        
        # Get the current data to edit, create the edit fields & fill in.
        h = self.g.get_messages()
        e = {}
        f = { 'name' : 20, 'hint' : 35, 'exitmsg' : 50 }
        for field, width in f.iteritems():
            e[field] = gtk.Entry(max=width)
            e[field].set_width_chars(width)
            e[field].set_text(h[field])
            e[field].set_activates_default(True)
        table.attach(e['name'],1,2,0,1)
        table.attach(e['hint'],1,2,1,2)
        table.attach(e['exitmsg'],1,2,2,3)
        
        # Add and show the table
        table.show_all()
        lt_dialog.vbox.pack_start(table, True, True,0)
        
        # If accepted, read data out of the dialog and save it.
        result = lt_dialog.run()
        if result == gtk.RESPONSE_ACCEPT:
            for field, control in e.iteritems():
                h[field] = control.get_text()
            self.g.set_messages(**h)
        lt_dialog.destroy()

    def aboutdialog(self, a):
        """About handler."""
        ad = KyeAboutDialog(kimg = self.canvas.get_image("kye"))
        ad.run()
        ad.destroy()

    def error_message(self, message):
        """Print error message dialog."""
        md = gtk.MessageDialog(parent=self, type=gtk.MESSAGE_ERROR,
                message_format=message, buttons=gtk.BUTTONS_OK)
        md.run()
        md.destroy()

    def get_template_board(self):
        """Return an empty level, read from template.kye, as a start for designing a new level."""
        fname = "template.kye"
        try:
            gamefile = tryopen(fname, kyepaths)
            g = KLevelEdit(gamefile, disp = self.canvas, newleveltemplate = None)
        except (IOError, OSError), e:
            self.error_message("%s" % e)
            raise
        return g.levels[0]

    def main(self, *argv):
        """Main program for the editor - loads the first file and runs the editor GUI."""
        self.__newlevel = self.get_template_board()
        
        # Create temp file; we save every level here immediately after loading it.
        (tf, tfname) = mkstemp(suffix='.kye')
        self.__tf = fdopen(tf, 'w')

        # Load specified level, or the template
        if len(argv)>1:
            playfile = argv[0]
            template = 0
        else:
            playfile = "template.kye"
            template = 1
        
        self.do_open(playfile, template=template)

        # All PyGTK applications must have a gtk.main(). Control ends here
        # and waits for an event to occur (like a key press or mouse event).
        gtk.main()

        # If out without errors, remove the backup copy
        self.__tf.close()
        unlink(tfname)

