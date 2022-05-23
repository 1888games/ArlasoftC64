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

"""Input handling code - mouse input and recorded input."""

import pygtk
pygtk.require('2.0')
from gtk.gdk import keyval_from_name, SHIFT_MASK
import pickle
from gzip import GzipFile
from os.path import basename

from kye.common import version

class KMoveInput:
    """Gets movement input, and converts it into game actions."""
    def __init__(self):
        self.__recordto = None
        self.clear()

    def clear(self):
        """Clears the current state of mouse buttons/keyboard keys held."""
        self.heldkeys = []
        self.keyqueue = []
        self.mousemoving = None
        self.currentmouse = None

    keymap = {
        keyval_from_name('Left')        : ("rel",-1, 0),
        keyval_from_name('Right')        : ("rel", 1, 0),
        keyval_from_name('Up')        : ("rel", 0,-1),
        keyval_from_name('Down')        : ("rel", 0, 1),
        keyval_from_name('KP_4') : ("rel",-1, 0),
        keyval_from_name('KP_6') : ("rel", 1, 0),
        keyval_from_name('KP_2') : ("rel", 0, 1),
        keyval_from_name('KP_8') : ("rel", 0,-1),
        keyval_from_name('KP_1') : ("rel",-1, 1),
        keyval_from_name('KP_3') : ("rel", 1, 1),
        keyval_from_name('KP_7') : ("rel",-1,-1),
        keyval_from_name('KP_9') : ("rel", 1,-1),
        keyval_from_name('KP_Left')        : ("rel",-1, 0),
        keyval_from_name('KP_Right')        : ("rel", 1, 0),
        keyval_from_name('KP_Down')        : ("rel", 0, 1),
        keyval_from_name('KP_Up')        : ("rel", 0,-1),
        keyval_from_name('KP_End')        : ("rel",-1, 1),
        keyval_from_name('KP_Page_Down') : ("rel", 1, 1),
        keyval_from_name('KP_Home')        : ("rel",-1,-1),
        keyval_from_name('KP_Page_Up')        : ("rel", 1,-1),
    }

    def key_press_event(self, widget, event):
        """Handle a keypress event."""
        try:
            pressedkey =  KMoveInput.keymap[event.keyval]
            # If this key is not already pressed, then it's a new press and so we want to move at least one square
            #  and remember that it is held down.
            if pressedkey not in self.heldkeys:
                self.keyqueue.append(pressedkey)

                # There is no way at this point to know if this is a key press or a key hold. So we'll have a 'delay' which causes us to wait a few ticks before considering the key held and reacting to it again.
                # But have SHIFT as a way for the user to tell us that it's a hold.
                if event.state & SHIFT_MASK == 0:
                    self.__delay = 1 # wait 1 tic
                self.heldkeys.append(pressedkey)
        except KeyError, e:
            return

    def key_release_event(self, widget, event):
        """Handle a key release event."""
        try:
            self.heldkeys.remove(KMoveInput.keymap[event.keyval])
        except KeyError, e:
            return
        except ValueError, e:
            return

    def mouse_motion_event(self, x, y):
        """Update mouse position after a mouse move."""
        self.currentmouse = ("abs", x, y)

    def button_press_event(self, button, x, y):
        """Mouse button press event."""
        if button == 1:
            self.mousemoving = True

    def button_release_event(self, button, x, y):
        """Mouse button release event."""
        if button == 1:
            self.mousemoving = False

    def __get_move(self):
        """Gets the move from the current keys/mouse state."""
        # If there are key presses in the queue, use them first
        if len(self.keyqueue) > 0:
            k = self.keyqueue[0]
            self.keyqueue = self.keyqueue[1:]
            return k
            
        # Then, if the mouse is pressed, do it
        if self.mousemoving and self.currentmouse:
            return self.currentmouse
            
        # Finally, if any keys are held, use the most recently pressed
        if len(self.heldkeys) > 0:
            if self.__delay <= 0:
                return self.heldkeys[-1]
            self.__delay = self.__delay - 1
            
        # No action
        return None

    def end_record(self):
        """End any previous recording."""
        if self.__recordto != None:
            try:
                self.__recordto.close()
            except IOError, e:
                print "error closing recording"

        self.__recordto = None

    def record_to(self, recfile, playfile, playlevel, rng):
        """Set this input to be recorded to the supplied stream."""
        # Open the stream
        stream = GzipFile(recfile, "w")
        self.__recordto = stream
        
        # Write header
        stream.write("Kye %s recording:\n" % version)
        stream.write(basename(playfile) + "\n")
        stream.write(playlevel + "\n")
        pickle.dump(rng.getstate(), stream)

    def is_recording(self):
        """Return true iff we are recording at the moment."""
        return self.__recordto != None

    def get_move(self):
        """Gets the move from the current keys/mouse state (and records the move if required)."""
        m = self.__get_move()
        if self.__recordto != None:
            if m != None:
                self.__recordto.write("\t".join([str(i) for i in m]))
            self.__recordto.write("\n")
        return m

class KDemoError(Exception):
    pass
    
class KDemoFormatError(KDemoError):
    pass
    
class KDemoFileMismatch(KDemoError):
    def __init__(self, filename):
        KDemoError.__init__()
        self.filename = filename

class KyeRecordedInput:
    """An input source which is a recording in a file of a previous game."""
    def __init__(self, playfile, playback):
        instream = GzipFile(playback)
        header = instream.readline().rstrip()
        if header[0:4] != "Kye " or header[-12:-1] == " recording:":
            raise KDemoFormatError()
        
        # Check filename in the demo is what we have loaded.
        fn = instream.readline().rstrip()
        if fn != basename(playfile):
            raise KDemoFileMismatch(fn)
            
        # Okay
        self.__level = instream.readline().rstrip()
        self.__rng = pickle.load(instream)
        self.__s = instream

    def get_level(self):
        """Return the level name for this recording."""
        return self.__level

    def set_rng(self, rng):
        """Set the supplied RNG to the state needed for this recording."""
        rng.setstate(self.__rng)

    def get_move(self):
        """Get a move from the recording."""
        l = self.__s.readline()
        l = l.rstrip()
        if len(l) == 0:
            return None
        s = l.split("\t")
        return [s[0], int(s[1]), int(s[2])]
