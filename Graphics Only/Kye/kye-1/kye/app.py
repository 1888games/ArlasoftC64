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

"""kye.app - the Kye game application. Just contains the KyeApp class.
"""

from os.path import basename
from random import Random
import gobject

from kye.common import tryopen, kyepaths
from kye.game import KGame, KGameFormatError
from kye.input import KyeRecordedInput, KDemoFormatError, KDemoFileMismatch

class KyeApp:
    """This class is a wrapper around the game class, which handles various extra-game actions, such as selecting whether the game is taking input from the user or a recording, loading new levels and changeover between levels."""

    def __init__(self, defaults, playfile="intro.kye", playlevel=""):
        self.__playfile = playfile
        self.__playlevel = playlevel
        self.__gamestate = "starting level"
        
        self.__recto = None
        self.__playback = None
        self.__game = None
        self.__frame = None
        self.__defaults = defaults
        
    def run(self, frame):
        """Run the application. You must supply a 'KFrame' for the UI."""
        self.__frame = frame
        
        # Run first tick - loads the level - immediately
        self.do_tick()
        gobject.timeout_add(100, self.do_tick)

        self.__frame.main()
        
        # End any recording going on at the time of exit.
        self.__frame.moveinput.end_record()

    def do_tick(self):
        """Performs all actions required for one clock tick in the game"""

        # First, we handle any extra-game actions like switching levels.

        # If starting a new level...
        if self.__gamestate == "starting level":
            self.__start_new_level()

        # If we are in a level...
        if self.__gamestate == "playing level":
            # Check if the level has been completed.
            if self.__game.diamonds == 0:
                self.__gamestate = "between levels"
                msg = self.__game.exitmsg
                if self.__frame.moveinput.is_recording():
                    msg = "Recording complete."
                if self.__frame.moveinput != self.__game.ms:
                    msg = "Playback complete."
                self.__frame.endleveldialog(self.__game.nextlevel, msg)
            
            # If we are still playing, run a gametick and update the screen.
            if self.__gamestate == "playing level":
                self.__game.dotick()
                self.__frame.canvas.game_redraw(self.__game, self.__game.invalidate)
                self.__frame.stbar.update(diamonds=self.__game.diamonds)
                if self.__game.thekye != None:
                    self.__frame.stbar.update(kyes=self.__game.thekye.lives)

        # And tell glib knows that we want this timer event to keep occurring.
        return True

    def __start_new_level(self):
        """Performs actions needed when beginning a new level."""
        # Clean up any previous recording/playback title & close existing record
        self.__frame.moveinput.end_record()
        self.__frame.extra_title(None)
        
        # If recording this game, open the file to record to & tell the input system about it
        rng = Random()
        try:
            if self.__recto:
                self.__frame.moveinput.record_to(self.__recto, playfile = self.__playfile, playlevel = self.__playlevel, rng = rng)
        except IOError, e:
            self.__frame.error_message(message="Failed to write to "+self.__recto)
 
        self.__recto = None
        if self.__frame.moveinput.is_recording():
            self.__frame.extra_title("Recording")
 
        # If playing a demo, open it & read the header
        self.__frame.moveinput.clear()
        move_source = self.__frame.moveinput
        if self.__playback != None:
            try:
                move_source = KyeRecordedInput(self.__playfile, self.__playback)
                self.__playlevel = move_source.get_level()
                move_source.set_rng(rng)
                self.__frame.extra_title("Replay")
            except KDemoFileMismatch, e:
                self.__frame.error_message(message="Recording is for "+e.filename+"; you must load this level set first")
            except KDemoFormatError, e:
                self.__frame.error_message(message="This file is not a Kye recording")
            except IOError, e:
                self.__frame.error_message(message="Failed to read "+self.__playback)
            self.__playback = None
        
        # Now try loading the actual level
        try:
            gamefile = tryopen(self.__playfile, kyepaths)
 
            # Create the game state object.
            self.__game = KGame(gamefile, want_level = self.__playlevel,
                                movesource = move_source, rng = rng)
 
            # And remember that we have reached this level.
            self.__defaults.add_known(self.__playfile, self.__game.thislev)
 
            # UI updates - level name in window title, hint in the status bar.
            self.__frame.level_title(self.__game.thislev)
            self.__frame.stbar.update(hint=self.__game.hint, levelnum=self.__game.levelnum)
        except KeyError, e:
            self.__frame.error_message(message="Level "+self.__playlevel+" not known")
        except KGameFormatError, e:
            self.__frame.error_message(message=self.__playfile + "is not a valid Kye level file.")
        except IOError, e:
            self.__frame.error_message(message="Failed to read "+self.__playfile)
        if self.__game != None:
            self.__gamestate = "playing level"
        else:
            self.__gamestate = ""

    def restart(self, recordto = None, demo = None):
        """Restarts the current level, optionally with recording or playing a demo (specified by recordto or demo parameters respectively)."""
        self.__gamestate = "starting level"
        self.__recto = recordto
        self.__playback = demo
        self.__playlevel = self.__game.thislev

    def goto(self, lname):
        """Jump to the named level."""
        self.__gamestate = "starting level"
        self.__playlevel = lname.upper()

    def open(self, fname):
        """Open a new set of levels from the supplied filename."""
        self.__playfile = fname
        self.__playlevel = ""
        self.__gamestate = "starting level"

    def known_levels(self):
        """Returns a list of levels that the player knows about from this level set."""
        return self.__defaults.get_known_levels(basename(self.__playfile))

