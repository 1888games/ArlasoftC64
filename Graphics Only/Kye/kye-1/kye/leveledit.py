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

"""Functions and classes for the level editor."""

from copy import deepcopy
from kye.common import xsize, ysize

def freq(s):
    """Returns a frequency table for entries in the supplied list (as a hash)."""
    h = {}
    for c in s:
        if c not in h:
            h[c] = 0
        h[c] = h[c] + 1
    return h

class KLevelEdit:
    """Class to store levels being edited, handle reading from and writing to file etc."""
    cell_lookup = {
        'K' : ("kye",'K'),
        '1' : ("wall1", ''),
        '2' : ("wall2", ''),
        '3' : ("wall3", ''),
        '4' : ("wall4", ''),
        '5' : ("wall5", '5'),
        '6' : ("wall6", ''),
        '7' : ("wall7", ''),
        '8' : ("wall8", ''),
        '9' : ("wall9", ''),
        'b' : ("block", 'B'),
        'B' : ("blockr", 'b'),
        'e' : ("blocke", 'e'),
        '*' : ("diamond_1",'*'),
        'a' : ("turner_clockwise", 'c'),
        'c' : ("turner_anticlockwise", 'a'),
        'D' : ("sentry_down", 'L'),
        'U' : ("sentry_up", 'R'),
        'L' : ("sentry_left", 'U'),
        'R' : ("sentry_right", 'D'),
        '[' : ("spike_1", 'E'),
        'E' : ("gnasher_1", 'T'),
        'T' : ("twister_1", '~'),
        '~' : ("snake_1", 'C'),
        'C' : ("blob_1", '['),
        's' : ("sticky_vertical", 'S'),
        'S' : ("sticky_horizontal", 's'),
        'u' : ("slider_up", 'r'),
        'd' : ("slider_down", 'l'),
        'l' : ("slider_left", 'u'),
        'r' : ("slider_right", 'd'),
        '^' : ("rocky_up", '>'),
        'v' : ("rocky_down", '<'),
        '<' : ("rocky_left", '^'),
        '>' : ("rocky_right", 'v'),
        'H' : ("black_hole_1", 'H'),
        '}' : ("block_timer_3", '|'), 
        '|' : ("block_timer_4", '{'), 
        '{' : ("block_timer_5", 'z'), 
        'z' : ("block_timer_6", 'y'), 
        'y' : ("block_timer_7", 'x'), 
        'x' : ("block_timer_8", 'w'), 
        'w' : ("block_timer_9", '}'), 
        'h' : ("oneway_down_1", 'g'),
        'i' : ("oneway_up_1", 'f'),
        'f' : ("oneway_right_1", 'h'),
        'g' : ("oneway_left_1", 'i'),
        'A' : ("slider_shooter_up", 'F'),
        'F' : ("rocky_shooter_up", 'A'),
        ' ' : ("blank", '')
        }

    # Helper data for identifying walls and doing auto-rounding.
    wall = {}
    for i in xrange(1, 10):
        wall[str(i)] = 1
    rounded_wall = { '0,1' : 2, '0,2' : 8, '1,0' : 6, '2,0' : 4, '1,1' : 3, '1,2' : 9, '2,1' : 1, '2,2' : 7 }

    def __init__(self, f, disp, newleveltemplate, setlevellist = None, hintmenuitems = None):
        self.levels = []
        self.__disp = disp
        
        # First line is # of levels. We don't need/use this.
        numlevels = f.readline()
        while 1:
            l = f.readline()
            if l == "":
                break
            
            # Each level has NAME<CRLF>Hint<CRLF>Exit message<CRLF>20x(Level data<CRLF>)
            lname = l.strip().upper()
            hint = f.readline().strip()
            if hint == "": break
            exitmsg = f.readline().strip()
            if exitmsg == "": break
            
            # read in the board
            board = []
            for y in range(ysize):
                l = f.readline()
                for x in range(xsize):
                    c = l[x]
                    
                    # Edge tiles must be walls - as in original Kye, force this.
                    if c not in KLevelEdit.wall and (x == 0 or y == 0 or x == xsize-1 or y == ysize-1):
                        c = '5'
                        
                    board.append(c)
            
            # The board, plus the level strings, makes the level. Add to our list of levels.
            newlevel = { 'name': lname, 'hint': hint, 'exitmsg': exitmsg, 'board': board }
            self.levels.append(newlevel)
        
        # All done, close the file.
        f.close()
        
        # Callbacks to the frame
        self.__setlevellist = setlevellist
        self.__hintmenuitems = hintmenuitems
        
        # Undo history & modified/saved state tracking
        self.__undohist = []
        self.__mods = 0
        self.__mods_lastsave = 0
        self.__mods_lastcheckpoint = 0
        self.__lastcheckpoint_level = None

        # Other state here
        self.__newlevel = newleveltemplate
        self.__autoround = True

        # set selected level & update level list
        self.setlevel(0)
        self.updatelevellist()
        self.undohint()

    # Maintain currently edited level and level list, notifying the view accordingly

    def setlevel(self, n):
        """Set the level currently being edited to number n."""
        self.curlevel = n
        self.__disp.game_redraw(self, [1]*(xsize*ysize))

    def updatelevellist(self):
        """This pushes the useful level data in this level set to the frame class."""
        if self.__setlevellist != None:
            self.__setlevellist(self.getlevels(), self.curlevel)
        if self.__hintmenuitems != None:
            self.__hintmenuitems(dlevel = (len(self.levels) > 1))

    # Called from the view, add or delete levels

    def newlevel(self):
        """Add a new level at the end of this level set."""
        # Add it
        self.curlevel = n = len(self.levels)
        self.levels.append(deepcopy(self.__newlevel))
        
        # Add undo entry
        self.add_undo(("newlevel", n))
        self.__mods = self.__mods+1
        
        # Focus this level for editing
        self.setlevel(len(self.levels)-1)
        self.updatelevellist()
        self.undohint()

    def delete_level(self):
        """Delete the current level from this level set."""
        if len(self.levels) == 1:
            raise RuntimeError, 'only 1 level left!'
        rlevel = self.levels.pop(self.curlevel)
        self.add_undo(("droppedlevel", self.curlevel, rlevel))
        self.__mods = self.__mods+1
        # Update current level - we could be left off the end of the list
        self.checkselectedlevel()
        # Force canvas & menu update
        self.setlevel(self.curlevel)
        self.updatelevellist()
        self.undohint()

    def checkselectedlevel(self):
        """Check that we have a valid selected level (e.g. after deleting a level)."""
        if self.curlevel >= len(self.levels):
            self.curlevel = self.curlevel-1

    # Undo/modified history

    def is_modified(self):
        """Have there been changes since the last save?"""
        return self.__mods != self.__mods_lastsave

    def undohint(self):
        """Send a hint to the frame about whether we can Undo at this point."""
        if self.__hintmenuitems != None:
            self.__hintmenuitems(undo = (self.__mods_lastcheckpoint != self.__mods and len(self.__undohist) > 0))

    def add_undo(self, i):
        """underlying storage for undo - maintains a limited stack to store revokable edits"""
        l = list(i)
        l.insert(0, self.__mods)
        self.__undohist.append(l)
        if len(self.__undohist) > 10:
            self.__undohist.pop(0)

    def checkpoint(self):
        """Takes a snapshot of the currently edited level onto the undo stack"""
        self.add_undo(("checkpoint", self.curlevel, deepcopy(self.levels[self.curlevel])))
        self.__mods_lastcheckpoint = self.__mods
        self.__lastcheckpoint_level = self.curlevel

    def newmod(self):
        """Called whenever a level is modified; increments the change #, and calls checkpoint if needed/desired"""
        if self.__lastcheckpoint_level != self.curlevel or self.__mods >= self.__mods_lastcheckpoint + 10:
            self.checkpoint()
        self.__mods = self.__mods + 1
        self.undohint()

    def undo(self):
        """Undo one item from the undo stack"""
        ui = self.__undohist.pop()
        # Pull the mod number of this edit/checkpoint out first
        mods = ui.pop(0)

        # Now undo that change
        if ui[0] == "droppedlevel":
            self.levels.insert(ui[1], ui[2])
        elif ui[0] == "newlevel":
            self.levels.pop(ui[1])
            self.checkselectedlevel()
        elif ui[0] == "checkpoint":
            self.levels.pop(ui[1])
            self.levels.insert(ui[1], ui[2])
        else:
            raise RuntimeError, "bad undo"
        # Update last checkpoint & current # of mods for this revision
        self.__mods_lastcheckpoint = 0
        for u in self.__undohist:
            if u[1] == "checkpoint":
                self.__mods_lastcheckpoint = u[0]
                self.__lastcheckpoint_level = u[2]
        self.__mods = mods
        # Refocus this level, redraw and refresh level list
        self.setlevel(self.curlevel)
        self.updatelevellist()
        self.undohint()

    # Accessor methods

    def set_autoround(self, state):
        """Set autoround flag (true or false)."""
        self.__autoround = state

    def set_messages(self, **h):
        """Set the messages for the current level"""
        self.newmod()
        for t in ('name', 'hint', 'exitmsg'):
            self.levels[self.curlevel][t] = h[t]
        
        # May need to update menu
        self.updatelevellist()
        
    def get_messages(self):
        """Returns the messages for the current level as a hash"""
        return dict((t, self.levels[self.curlevel][t]) for t in ('name','hint','exitmsg'))

    def getlevels(self):
        """Gets a list with the names of the levels in this level set, in order"""
        return [i['name'] for i in self.levels]

    # Get and set tile methods, plus autorounding etc
    def get_tile(self, i, j):
        """Look up the content of a tile in the currently-edited level"""
        return KLevelEdit.cell_lookup[self.levels[self.curlevel]['board'][xsize*j + i]][0]

    def wall_at(self, x, y):
        """Returns 1 if the nominated tile in the currently edited level is a wall (or is out of bounds), 0 otherwise"""
        if x < 0 or y < 0 or y >= ysize or x >= xsize: return 1
        if self.levels[self.curlevel]['board'][xsize*y + x] in KLevelEdit.wall:
            return 1
        else:
            return 0

    def autoround_cell(self, x, y):
        """Look at this cell, and if it is a wall, change it to be automatically rounded based on which neighbouring tiles are walls"""
        if self.wall_at(x, y) == 0: return
        h = self.wall_at(x-1, y) + 2*self.wall_at(x+1, y)
        v = self.wall_at(x, y-1) + 2*self.wall_at(x, y+1)
        try:
            n = KLevelEdit.rounded_wall["%d,%d" % (h, v)]
        except KeyError,e:
            n = 5
        self.set_at_simple(x, y, str(n))

    def autoround_at(self, x, y):
        """Call autoround_cell for all neighbouring tiles to this cell"""
        self.autoround_cell(x, y)
        if x > 0:       self.autoround_cell(x-1, y)
        if x < xsize-1: self.autoround_cell(x+1, y)
        if y > 0:       self.autoround_cell(x, y-1)
        if y < ysize-1: self.autoround_cell(x, y+1)

    def set_at(self, i, j, t):
        """Sets a given tile, plus updated neighbouring cells wall rounding, plus updates modification count and may checkpoint if needed"""
        self.newmod()
        if i == 0 or j == 0 or i == xsize-1 or j == ysize-1:
            if t != '5':
                return
        try:
            self.set_at_simple(i,j,t)
        except IndexError, e:
            return
        if self.__autoround:
            self.autoround_at(i,j)

    def set_at_simple(self, i, j, t):
        """Edits a single cell, and redraws it"""
        if i < 0 or j < 0 or i >= xsize or j >= ysize:
            raise IndexError
        self.levels[self.curlevel]['board'][xsize*j + i] = t
        w = [0]*(xsize*ysize)
        w[xsize*j + i] = 1
        self.__disp.game_redraw(self, w)

    def check(self):
        """Check for errors before saving"""
        errors = {}
        for l in self.levels:
            e = {}
            h = freq(l['board'])
            if 'K' not in h or h['K'] != 1:
                e['kye'] = 'There should be exactly one Kye in the level.'
            if '*' not in h:
                e['diamonds'] = 'The level should contain at least one diamond.'
            if len(e) > 0:
                errors[l['name']] = e.values()
        return errors

    # Saving
    def saved(self):
        """Called when the level has been saved, to clear the modified state"""
        self.__mods_lastsave = self.__mods

    def saveto(self, f):
        """Save the whole level set to a given file stream"""
        f.write("%d\r\n" % len(self.levels))
        for l in self.levels:
            f.write("%s\r\n%s\r\n%s\r\n" % (l['name'], l['hint'], l['exitmsg']))
            i = 0
            for y in xrange(ysize):
                for x in xrange(xsize):
                    f.write(l['board'][i])
                    i = i + 1
                f.write("\r\n")
                f.flush()

