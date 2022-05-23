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

"""kye.game - implements the Kye game state and behaviour."""

from kye.objects import *
from kye.common import xsize, ysize

class KGame:
    """This class holds the state of the game, and handles reading in levels from level set files and game mechanics."""

    cell_lookup = {
        'K' : (Kye,),
        '1' : (Wall, 1),
        '2' : (Wall, 2),
        '3' : (Wall, 3),
        '4' : (Wall, 4),
        '5' : (Wall, 5),
        '6' : (Wall, 6),
        '7' : (Wall, 7),
        '8' : (Wall, 8),
        '9' : (Wall, 9),
        'b' : (Block, 0, False),
        'B' : (Block, 0, True),
        'a' : (Block, 1, False),
        'c' : (Block,-1, False),
        'e' : (Edible,),
        '*' : (Diamond,),
        'D' : (Sentry, 0, 1),
        'U' : (Sentry, 0,-1),
        'L' : (Sentry,-1, 0),
        'R' : (Sentry, 1, 0),
        '[' : (Monster, 2),
        'E' : (Monster, 0),
        'T' : (Monster, 1),
        '~' : (Monster, 3),
        'C' : (Monster, 4),
        's' : (Magnet, 0, 1),
        'S' : (Magnet, 1, 0),
        'u' : (Slider, 0,-1,False),
        'd' : (Slider, 0, 1,False),
        'l' : (Slider,-1, 0,False),
        'r' : (Slider, 1, 0,False),
        '^' : (Slider, 0,-1, True),
        'v' : (Slider, 0, 1, True),
        '<' : (Slider,-1, 0, True),
        '>' : (Slider, 1, 0, True),
        'H' : (BlackHole,),
        '}' : (Block, 0, False, 3),
        '|' : (Block, 0, False, 4),
        '{' : (Block, 0, False, 5),
        'z' : (Block, 0, False, 6),
        'y' : (Block, 0, False, 7),
        'x' : (Block, 0, False, 8),
        'w' : (Block, 0, False, 9),
        'h' : (OneWay, 0, 1),
        'i' : (OneWay, 0,-1),
        'f' : (OneWay, 1, 0),
        'g' : (OneWay,-1, 0),
        'A' : (Shooter,False),
        'F' : (Shooter,True),
        }

    def __init__(self, f, want_level, movesource, rng):
        levels = f.readline()
        if levels == "":
            raise KGameFormatError

        levels.strip()

        self.levelnum = 0
        while 1:
            levelname = f.readline() 
            if levelname == "" and self.levelnum == 0:
                raise KGameFormatError
            levelname = levelname.strip().upper()
            self.levelnum = self.levelnum+1
            if levelname == "" or levelname == want_level or "" == want_level:
                break
            # Skip level for this level.
            for i in xrange(22):
                f.readline()

        if (levelname != want_level and want_level != ""):
            raise KeyError, "level "+lev+" not found"

        self.thislev = levelname
        self.hint = f.readline().strip()
        self.exitmsg = f.readline().strip()
        board = []
        self.invalidate = []
        self.magnet_count = []
   
        for i in xrange(xsize*ysize):
            board.append(None)
            self.invalidate.append(1)
            self.magnet_count.append(0)

        self.board = board
        self.loc = {}
        self.thinkers = []
        self.diamonds = 0
        self.thekye = None

        for y in xrange(ysize):
            l = f.readline()
            for x in xrange(xsize):
                edge = (x == 0 or y == 0 or x == xsize-1 or y == ysize-1)
                c = l[x]

                # Blank means empty cell - but override at the edge
                if c == ' ' and edge:
                    c = '5'
                if c == ' ':
                    continue
                try:
                    ctype = KGame.cell_lookup[c]

                    # edge cells must be wall cells
                    if ctype[0] != Wall and edge:
                        ctype = (Wall, 5)
                    
                    # Execute constructor for this object type, and add to the grid
                    cc = apply(ctype[0], ctype[1:])
                    self.add_at(x, y, cc)

                    # Objects where location matters
                    if isinstance(cc, Shooter):
                        cc.setang(x%4)
                    if isinstance(cc, Kye):
                        self.kyestart = (x,y)
                        self.thekye = cc
                    
                except KeyError, e:
                    print "Unable to load %s at (%d,%d)" % (c, x, y)

        # If no Kye in the level, add it at 3,3, as Kye 2.0 does
        if self.thekye == None:
            cc = Kye()
            self.kyestart = (3, 3)
            self.add_at(3, 3, cc)

        self.nextlevel = f.readline().strip()
        if self.nextlevel == "\x1a": self.nextlevel=""
        f.close()

        self.animate_frame = 0
        self.running = 1
        self.tics = 0
        self.random = rng
        self.ms = movesource

    def nextrand(self, n):
        """Return a random number from 0..n-1 from this games random number source."""
        return self.random.randint(0, n-1)

    def get_at(self, i, j):
        """Return the content of tile (i, j). Caller must ensure that (i, j) is inside the game board."""
        return self.board[xsize*j + i]

    def get_atB(self, i, j):
        """Returns the content of tile (i, j), or a Wall if (i, j) is outside of the board."""
        if i < 0 or i >= xsize or j < 0 or j >= ysize: return Wall(5)
        return self.get_at(i,j)

    def get_tile(self, i, j):
        """Return the image to show for the tile at (i, j)."""
        c = self.get_at(i, j)
        if (c == None): return "blank"
        return c.image(self.animate_frame)

    def get_location(self, obj):
        """Return the location in the game of the given game object."""
        return self.loc[obj]

    def magnet_range(self, x, y, d):
        """Update the magnet effect table to allow for the addition (if d=1) or removal (if d=-1) of a magnet at (x, y)."""
        pos = xsize*y + x
        maxp = xsize*ysize
        if pos >= 2: self.magnet_count[pos - 2] = self.magnet_count[pos - 2] + d
        if pos >= 1: self.magnet_count[pos - 1] = self.magnet_count[pos - 1] + d
        if pos + 1 < maxp: self.magnet_count[pos + 1] = self.magnet_count[pos + 1] + d
        if pos + 2 < maxp: self.magnet_count[pos + 2] = self.magnet_count[pos + 2] + d
        if pos >= 2*xsize: self.magnet_count[pos - 2*xsize] = self.magnet_count[pos - 2*xsize] + d
        if pos >= 1*xsize: self.magnet_count[pos - 1*xsize] = self.magnet_count[pos - 1*xsize] + d
        if pos + 2*xsize < maxp: self.magnet_count[pos + 2*xsize] = self.magnet_count[pos + 2*xsize] + d
        if pos + 1*xsize < maxp: self.magnet_count[pos + 1*xsize] = self.magnet_count[pos + 1*xsize] + d

    def add_at(self, x, y, obj):
        """Add the given object to the game at (x, y)."""
        pos = xsize*y + x
        self.board[pos] = obj
        self.invalidate[pos] = 1

        # Add to the location map, add active objects to the thinkers list.
        self.loc[obj] = (x, y)
        f = obj.freq()
        if f > 0: self.thinkers.append((f, obj))

        # Other object-type-specific tracking updates.
        if isinstance(obj, Kye): self.kye = obj
        if isinstance(obj, Diamond): self.diamonds = self.diamonds+1
        if isinstance(obj, Magnet): self.magnet_range(x,y,1)

    def remove_at(self, x, y):
        """Remove the object at (x, y) from the game."""
        # Get the object and remove from the board.
        pos = xsize*y + x
        obj = self.board[pos]
        self.board[pos] = None

        # Cause display update.
        self.invalidate[pos] = 1

        # If this was an active object, remove from the active list.
        # And remove from the object->location map.
        f = obj.freq()
        if f > 0: self.thinkers.remove((f, obj))
        del self.loc[obj]

        # Other object-type-specific tracking updates.
        if isinstance(obj,Kye): self.kye = None
        if isinstance(obj,Diamond): self.diamonds = self.diamonds-1
        if isinstance(obj,Magnet): self.magnet_range(x,y,-1)

    def move_object(self, x, y, tx, ty):
        """Move the object at (x, y) to (tx, ty)."""
        # Get it and move it.
        pos_f = xsize*y + x
        pos_t = xsize*ty + tx
        obj = self.board[pos_f]
        self.board[pos_f] = None
        self.board[pos_t] = obj

        # Cause display updates.
        self.invalidate[pos_f] = 1
        self.invalidate[pos_t] = 1

        # Update object -> location map
        self.loc[obj] = (tx, ty)

        # And other object-type-specific tracing updates.
        if isinstance(obj, Magnet):
            self.magnet_range( x,  y, -1)
            self.magnet_range(tx, ty,  1)

    def invalidate_me(self, o):
        """Tell the game that an object's image has changed."""
        x, y = self.get_location(o)
        self.invalidate[xsize*y + x] = 1

    def push_object(self, x, y, dx, dy):
        """The object at (x, y) is pushed by another object in direction (dx, dy) (which should be +/-1 and not both 0) - work out if it can move and what happens to it."""
        # Get the object, and the square that it would be pushed to.
        tx, ty = x+dx, y+dy
        obj = self.get_at(x, y)

        # Only active objects can be moved.
        if not isinstance(obj, Thinker): return False
        
        # To push diagonally, need the two side squares clear
        if dx != 0 and dy != 0:
            if self.get_atB(x, ty) != None or self.get_atB(tx, y) != None:
                return False

        # If target square is empty, the object moves.
        t = self.get_atB(tx, ty)
        if t == None:
            self.move_object(x, y, tx, ty)
            return True

        # If moving into a black hole, destroy the object and update black hole state. 
        elif isinstance(t,BlackHole):
            if t.swallow(self):
                self.remove_at(x, y)
                return True

        # Otherwise, there's something in the way and we don't move.
        return False

    def dokye(self, k):
        """Do the Kye's move."""
        x, y = self.get_location(k)

        # Get the move for the Kye from the input source (human or recording).
        m = self.ms.get_move()
        if m == None: return

        # If a mouse move to a specific "absolute" location, work out what
        # relative move that is asking for. Otherwise it's a relative move
        # already and just use that.
        if m[0] == 'abs':
            if m[1] < x: dx = -1
            elif m[1] > x: dx = 1
            else: dx = 0
            if m[2] < y: dy = -1
            elif m[2] > y: dy = 1
            else: dy = 0
        else:
            dx,dy = m[1:]

        if dx != 0 and dy != 0:
            # Diagonal move. If either square either side of the diagnoal is
            # occupied, we cannot move diagonally.
            xt, yt = self.get_atB(x+dx, y), self.get_atB(x, y+dy)
            if m[0] == 'abs':
                # Fail if both blocked
                if xt != None and yt != None: return

# But, if this is an absolute move, we could still move into the other square
# beside the diagonal if only one is blocking. Change the relative move that we
# are attempting accordingly.
                if xt != None: dx = 0
                if yt != None: dy = 0
            else:
                # Fail if even one blocked if he definitely wanted diagonal
                if xt != None or yt != None: return

        # Okay, get what is in the way of this move, if anything.
        t = self.get_atB(x+dx, y+dy)

        # Special actions for certain targets.
        if isinstance(t, Edible):
            self.remove_at(x+dx, y+dy)
            t = None
        if isinstance(t, BlackHole):
            if t.swallow(self, animate = False):
                self.kill_kye(k)
        else:
            # If there is a one-way gate in the way but we are passing in the
            # right direction, remove the gate and store it in the Kye. This is
            # the one case where two objects can occupy the same square; we
            # "hide" the one-way object in the Kye object, and replace it on
            # the board when the Kye next moves.
            new_under = None
            if isinstance(t, OneWay) and t.allow_move(dx, dy):
                # Remove the one-way and will store in the Kye.
                self.remove_at(x+dx, y+dy)
                new_under, t = t, None

            # If the target is empty, we move in. If not then we're trying to
            # push the object there; move in if pushing succeeds.
            if t == None or self.push_object(x+dx, y+dy, dx, dy):
                # We can move.
                self.move_object(x, y, x+dx, y+dy)

                # Restore any one-way that was stored in the Kye for the old
                # square, and store any one-way that was at the new square in
                # the Kye.
                if k.under != None:
                    self.add_at(x, y, k.under)
                k.under = new_under

    def find_kye(self):
        """Return the location of the Kye."""
        return self.get_location(self.kye)

    def kill_kye(self, k):
        """Call if Kye dies; start death animation and update lives."""
        x,y=self.get_location(k)
        k.lives = k.lives - 1
        ghost = KyeGhost(k)
        self.remove_at(x, y)
        self.add_at(x, y, ghost)

    def respawn_kye(self, k):
        """When death animation ends, this is called to create the new Kye."""
        # deja vu here - G_CheckSpot clone
        # Find a spot to put the Kye - our original start square could be blocked.
        # I don't know exactly how the "teleporting" in the original Kye
        # worked, hopefully this is close enough.

        # Make attempts with increasing radius each time.
        for r in xrange(40):
            # Make some # of tries proportional to the radius
            for t in xrange(4*r+1):
                if r == 0:
                    x, y = self.kyestart
                else:
                    x = self.kyestart[0] + self.random.randint(-r, r)
                    y = self.kyestart[1] + self.random.randint(-r, r)
                if self.get_atB(x, y) == None:
                    self.add_at(x, y, k)
                    return k

        # Hmm, this shouldn't happen but, if we do fail to find a square...
        raise KyeGameRuntimeError

    def check_monsters(self):
        """Check whether the Kye has touched a monster."""
        x, y = self.get_location(self.kye)
        if isinstance(self.get_atB(x+1,y), Monster) or isinstance(self.get_atB(x-1,y), Monster) or isinstance(self.get_atB(x,y+1), Monster) or isinstance(self.get_atB(x,y-1), Monster):
            self.kill_kye(self.kye)
            return True
        return False

    def dotick(self):
        """Run one game tick - move the Kye and animate/move all active objects in the game."""
        if not self.running: return

        tics = self.tics = self.tics + 1

        # Move Kye first.
        if self.kye != None and not self.check_monsters():
            self.dokye(self.kye)
            if self.kye: self.check_monsters()

        # Shallow copy the thinkers list, because we must iterate over it while modifying it
        current_thinkers = self.thinkers[:]

        # Animate/move active objects in order.
        for f, t in current_thinkers:
            if tics % f == 0:
                try:
                    x, y = self.get_location(t)
                except KeyError, e: # Object was deleted during this tick
                    continue

                # If the object indicates it, request a display update for it.
                if t.think(self, x, y):
                    self.invalidate[x+y*xsize] = 1

        # Update animation counter.
        if self.tics % 3 == 0: self.animate_frame = self.animate_frame + 1

class KyeGameRuntimeError:
    pass

class KGameFormatError(Exception):
    pass
