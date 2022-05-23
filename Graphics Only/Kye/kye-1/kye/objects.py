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

"""Classes for individual objects in the game, implementing their behaviour and animations."""

from random import Random

dirmap = ("up", "left", "right", "down")
def direction(dx, dy):
    return dirmap[dy+1+(dx+dy+1)/2]

class Base:
    """This is the virtual base-class for all in-game objects."""

    def __init__(self):
        pass

    def roundness(self):
        """Returns the 'roundness' of this object.
        
        A roundness of 0 means that an object is not round (so, a rounder
        that hits it comes to a stop). 5 means that it is completely round.
        1-4,6-9 mean that only certain corners are round: see the layout of the
        numeric keypad, e.g 1 is bottom-left, so 1 means the bottom-left is
        rounded; 8 is top-center so the top-left and top-right are rounded."""

        # default - not round
        return 0

    def freq(self):
        """Returns how often this object may change state.

        If this returns 0, the object never changes. Otherwise, this object
        should 'think', and may change its graphic, every freq/10 seconds."""
        return 0

class Kye(Base):
    """The Kye itself."""
    def __init__(self):
        Base.__init__(self)
        self.lives = 3
        self.under = None

    def image(self, af):
        return "kye"

class Wall(Base):
    """There are 9 types of wall, indicated by 1..9.

    5 indicates totally square. 1..4, 6..9 indicate the roundness."""

    def __init__(self, t):
        """t -- the type (roundness) of the wall."""
        Base.__init__(self)
        self.t = t

    def roundness(self):
        if self.t == 5: return 0
        return self.t

    def image(self , af):
        return "wall"+str(self.t)

class Edible(Base):
    """Edible block object."""
    def image(self, af):
        return "blocke"

class Diamond(Edible):
    """Object representing a diamond."""
    r = Random()        # Used purely for animation.
    
    def __init__(self):
        Edible.__init__(self)
        self.state = Diamond.r.randint(1, 2)

    def image(self, af): return "diamond_"+str(self.state)

    def freq(self): return 20

    def think(self, game, x, y):
        if Diamond.r.randint(1, 10) == 1:
            self.state = self.state ^ 3
            return True
        return False

class Thinker(Base):
    """Virtual base class for all in-game animate objects."""

    def __init__(self):
        Base.__init__(self)
        self.autoanim = False

    def freq(self):
        """Default is for animate objects to 'think' every game tick."""
        return 1

    def think(self, game, x, y):
        """This gives the object its chance to perform any actions.
        
        By default this calls self.pulltomagnet first, to allow the action of
        any magnet on the object to take effect. Only if it is not under the
        effect of a magnet, then self.act is called to allow the object to
        act."""
        if game.magnet_count[30*y + x] > 0:
            if self.pulltomagnet(game, x, y): return self.autoanim
        return self.act(game, x , y)

    def act(self, game, x, y):
        return self.autoanim

    def pulltomagnet(self, game, x, y):
        """Performs the effect of any nearby magnet on this object."""

        # state[0] is set to true if we are stuck on a magnet
        # stare[1,2] is the location we are to be pulled to by a magnet
        state = [False, x, y]
        checkmagnet(game, x, y,-1, 0, state)
        checkmagnet(game, x, y, 1, 0, state)
        checkmagnet(game, x, y, 0,-1, state)
        checkmagnet(game, x, y, 0, 1, state)
        
        # If we are being pulled, move & return 1 as we have moved.
        # Else, just return whether we are stuck on a magnet.
        if x != state[1] or y != state[2]:
            game.move_object(x, y, state[1], state[2])
            return True
        else:
            return state[0]

class KyeGhost(Thinker):
    """This is the ghost of a dead kye. It lasts just a few frames and them removes itself."""
    frames = ("kye", "kye_fading", "kye_faint")

    def __init__(self, k):
        Thinker.__init__(self)
        self.frame = 0
        self.kye = k

    def image(self, af):
        return KyeGhost.frames[self.frame]

    def think(self, game, x, y):
        self.frame = self.frame+1
        if self.frame > 2:
            if self.kye.lives >= 0:
                game.respawn_kye(self.kye)
            game.remove_at(x, y)
        return True

class Block(Thinker):
    """Square or round moveable block. Also turning blocks and timer blocks."""

    def __init__(self, t, round, timer=0):
        """3 parameters:
        
        t -- normally 0. -1 for an anticlockwise turner, 1 for a clockwise turner.
        round -- true if this is a round block, false otherwise.
        timer -- normally omitted, but if positive then it makes a timer block with the number indicating how long until it expires.
        """
        Thinker.__init__(self)
        self.timer = 0
        if timer: self.timer = timer*30 + 25
        self.round = round
        self.__turn = t

    def roundness(self):
        if self.round: return 5
        return 0

    def turn(self):
        """Returns -1 or 1 if sliders/rounders hitting this block should be turned left or right; 0 for an ordinary block."""
        return self.__turn

    def image(self, af):
        if self.timer > 0: return "block_timer_"+str(self.timer//30)
        if self.round: return "blockr"
        if self.__turn == -1: return "turner_anticlockwise"
        if self.__turn == 1: return "turner_clockwise"
        return "block"

    def think(self, game, x, y):
        """Count down timer blocks and flag the caller when the image changes."""
        if self.timer > 0:
            self.timer = self.timer - 1
            if self.timer == 0:
                game.remove_at(x, y)
        if game.magnet_count[30*y + x] > 0:
            self.pulltomagnet(game, x, y)
        if self.timer == 0: return False
        return (self.timer % 30) == 29

class Sentry(Thinker):
    """This represents a sentry, or 'bouncer' as the original Kye termed them."""
    def __init__(self, idx, idy):
        Thinker.__init__(self)
        self.dx = idx
        self.dy = idy

    def image(self, af):
        return "sentry_"+direction(self.dx, self.dy)

    def freq(self): return 5

    def act(self, game, x, y):
        # Look at what we are walking into
        dx, dy = self.dx, self.dy
        t = game.get_atB(x + dx, y + dy)

        # If it's a blackhole, we are destroyed in it if it is ready to eat.
        if isinstance(t, BlackHole):
            if t.swallow(game):
                game.remove_at(x, y)
                return
            # else drop through - we can push a full blackhole.

        # If there is nothing ahead, move ahead
        if t == None:
            game.move_object(x, y, x+dx, y+dy)
            return False
        else:
            # else we push the object ahead and turn around.
            game.push_object(x+dx, y+dy, dx, dy)
            self.dx, self.dy = -dx, -dy
            return True

class Monster(Thinker):
    """All the monster types are represented by this class."""
    r = Random()
    names = ("gnasher", "twister", "spike", "snake", "blob")

    def __init__(self,type):
        """Creating a monster, one parameter: an int, 0..4, giving the type."""
        Thinker.__init__(self)
        self.type = type
        self.frames = 2
        if type == 4: self.frames=4
        self.frame = Monster.r.randint(1,self.frames)
        self.autoanim = True

    def image(self, af):
        return Monster.names[self.type]+"_"+str(1 + ((self.frame + af) % self.frames))

    def freq(self):
        return 3

    def act(self, game, x, y):
        # Monsters move randomely half the time. The rest of the time we move
        # towards Kye. The object of both halves of this 'if' is to get a
        # (tx,ty) target square to move into.

        if game.nextrand(2) == 0:
            # I wander lonely as a cloud...
            d = game.nextrand(5)
            if d == 0:
                tx,ty = x-1, y
            elif d == 1:
                tx,ty = x+1, y
            elif d == 2:
                tx,ty = x, y-1
            elif d == 3:
                tx,ty = x, y+1
            elif d == 4:
                return True # Don't move at all
            wandering = True
        else:
            # Advance towards kye
            try:
                kx,ky = game.find_kye()
            except KeyError, e:
                return True # No Kye available
            wandering = False
            dx = kx - x
            dy = ky - y

            # Step towards Kye. Really missing the ternary operator here...
            # Always step dy (up/down) in preference, as the orignial game does
            if dy == 0:
                if dx > 0:
                    tx,ty = x+1, y
                else:
                    tx,ty = x-1, y
            else:
                if dy > 0:
                    tx,ty = x, y+1
                else:
                    tx,ty = x, y-1

            # See if we can move that way.
            if game.get_at(tx,ty) != None:
                # Try the other direction
                if tx == x and dx != 0:
                    if dx > 0:
                        tx,ty = x+1, y
                    else:
                        tx,ty = x-1, y
                elif ty == y and dy != 0:
                    if dy > 0:
                        tx,ty = x, y+1
                    else:
                        tx,ty = x, y-1

        # Now try to move to (tx,ty). We only fall into black holes if moving randomely.
        t = game.get_at(tx,ty)
        if t == None:
            game.move_object(x, y,tx,ty)
        elif wandering and isinstance(t,BlackHole) and t.swallow(game):
            game.remove_at(x, y)
        return True

def checkmagnet(game, x, y, dx, dy, state):
    """Checks whether (x,y) is affected by a magnet in a given direction.
    
    Checks for a magnet at (x+dx,y+dy) and (x+2*dx, y+2*dy) (if the latter
    is not obstructed). Updates the 'state' array with the result.
    """
    a = game.get_atB(x+dx, y+dy)
    if a == None:
        b = game.get_atB(x+2*dx, y+2*dy)
        if isinstance(b,Magnet):
            if (b.dx != 0 and dx != 0) or (b.dy != 0 and dy != 0):
                state[1:2] = x+dx, y+dy
    elif isinstance(a,Magnet):
        if (a.dx != 0 and dx != 0) or (a.dy != 0 and dy != 0):
            state[0] = True;

class Magnet(Thinker):
    """Represents a magnet (sticky block, in the original Kye)."""
    def __init__(self, idx, idy):
        Thinker.__init__(self)
        self.dx = idx
        self.dy = idy

    def image(self, af):
        if self.dx == 0: return "sticky_vertical"
        return "sticky_horizontal"

    def think(self, game, x, y):
        return self.act(game, x, y)

    def act(self, game, x, y):
        dx,dy = self.dx,self.dy
        if isinstance(game.get_atB(x-2*dx, y-2*dy),Kye) and game.get_atB(x-dx, y-dy) == None:
            game.move_object(x, y, x-dx, y-dy)
        elif isinstance(game.get_atB(x+2*dx, y+2*dy),Kye) and game.get_atB(x+dx, y+dy) == None:
            game.move_object(x, y, x+dx, y+dy)
        else:
            self.pulltomagnet(game, x, y)
        return False

    def pulltomagnet(self, game, x, y):
        """This handles the special case of magnets pulling magnets."""
        state=[False, x, y]

        if self.dx == 0:
            checkmagnet(game, x, y,-1, 0, state)
            checkmagnet(game, x, y, 1, 0, state)
        else:
            checkmagnet(game, x, y, 0,-1, state)
            checkmagnet(game, x, y, 0, 1, state)

        if state[1] != x or state[2] != y:
            game.move_object(x, y, state[1], state[2])

class Slider(Thinker):
    """Represents a square or round slider."""

    def __init__(self, idx, idy, ir):
        Thinker.__init__(self)
        self.dx = idx
        self.dy = idy
        self.round = ir

    def roundness(self):
        if self.round: return 5
        return 0

    def image(self, af):
        i = "slider_"
        if self.round: i="rocky_"
        i = i + direction(self.dx, self.dy)
        return i

    def act(self, game, x, y):
        dx,dy = self.dx,self.dy

        # Try moving forward. Move into space, fall into black holes.
        t = game.get_atB(x+dx, y+dy)
        if t == None:
            game.move_object(x, y, x+dx, y+dy)
        elif isinstance(t, BlackHole):
            if t.swallow(game):
                game.remove_at(x, y)
        else:
            # Obstacle - if a block, check to see if we should turn.
            if isinstance(t, Block):
                tn = t.turn()
                if tn != 0:
                    self.dx = -(tn*dy)
                    self.dy = tn*dx
                    return True

            # Round sliders can roll round rounded obstacles.
            if self.round:
                tr = t.roundness()
                if tr == 0: return False

                # Rocky hitting a rounded surface - which ways can it deflect
                plus,minus = False,False
                if dx != 0:
                    if tr % 3 == 2 or (tr+dx) % 3 == 2:
                        minus = tr > 3
                        plus = tr < 7
                else: # dy != 0
                    if tr < 4 or tr > 6:
                        tr -= 3*dy
                    if   tr == 4: plus,minus = False,True
                    elif tr == 5: plus,minus = True,True
                    elif tr == 6: plus,minus = True,False

                # Obstacle is not rounded on either corner facing us - we are stuck
                if not plus and not minus: return False

                if dx != 0:
                    if plus and (game.get_atB(x,y+1) != None or game.get_atB(x+dx,y+1) != None): plus = False
                    if minus and (game.get_atB(x,y-1) != None or game.get_atB(x+dx,y-1) != None): minus = False
                else: # dy != 0
                    if plus and (game.get_atB(x+1,y) != None or game.get_atB(x+1,y+dy) != None): plus = False
                    if minus and (game.get_atB(x-1,y) != None or game.get_atB(x-1,y+dy) != None): minus = False

                # No way forward due to target square(s) being occupied - stuck
                if not plus and not minus: return False

                # If both ways forwand are possible, choose randomely
                if plus and minus:
                    if game.nextrand(2) == 0:
                        plus = False
                    else:
                        minus = False

                # Work out which square that corresponds to
                tdx, tdy = dx,dy
                if plus:
                    if tdx != 0: tdy = dy+1
                    else: tdx = dx+1
                else:
                    if tdx != 0: tdy = dy-1
                    else: tdx = dx-1

                # And move into it.
                game.move_object(x, y, x+tdx, y+tdy)

        return False

class Shooter(Thinker):
    """Slider shooter."""
    def __init__(self,round):
        """One parameter, boolean - does this shoot round sliders (false -> square)."""
        Thinker.__init__(self)
        self.__round = round
        self.__waiting = 0

    def setang(self, ang):
        """Set the initial angle of this shooter."""
        self.__dx = 0
        self.__dy = 0

        if   ang == 0: self.__dy =-1
        elif ang == 1: self.__dx =-1
        elif ang == 2: self.__dy = 1
        elif ang == 3: self.__dx = 1

    def image(self, af):
        if self.__round: return "rocky_shooter_"+direction(self.__dx, self.__dy)
        else: return "slider_shooter_"+direction(self.__dx, self.__dy)

    def think(self, game, x, y):
        dy = -self.__dx
        dx = self.__dy

        self.__dx = dx
        self.__dy = dy
        self.__waiting = self.__waiting+1

        b = game.get_atB(x+dx, y+dy)
        if self.__waiting > y and b == None:
            game.add_at(x+dx, y+dy, Slider(dx, dy, self.__round))
            self.__waiting = 0
        self.pulltomagnet(game, x, y)
        return True

    def freq(self): return 7

class BlackHole(Thinker):
    """Represents a black hole."""
    delayframes = 4

    def __init__(self):
        Thinker.__init__(self)
        self.delay = 0
        self.frame = 0

    def freq(self):
        return 5

    def think(self, game, x, y):
        self.frame = self.frame + 1
        if self.frame == 4: self.frame = 0
        if self.delay > 0: self.delay = self.delay - 1
        return True

    def swallow(self, g, animate = True):
        """Called whenever something might fall in. Returns true if we swallow it, false if we cannot.
        
        Two parameters: the game object, and a bool (default true) which
        indicates that the black hole should do its normal reaction cycle
        (animate and be full (unable to eat) for a few cycles).
        """
        if self.delay > 1: return False
        if animate:
            self.delay = BlackHole.delayframes + 1
            g.invalidate_me(self)
        return True

    def image(self, af):
        if self.delay > 0:
            df = BlackHole.delayframes + 1 - self.delay
            if df <= 0: df = 1
            return "black_hole_swallow_"+str(df)
        return "black_hole_"+str(self.frame+1)

class OneWay(Base):
    """Represents a one-way door."""
    def __init__(self, dx, dy):
        """Parameters to create a black hole: dx, dy, which define its allowed direction."""
        self.dx = dx
        self.dy = dy

    def image(self, af):
        return "oneway_"+direction(self.dx, self.dy)+"_"+str(1+(af%2))

    def allow_move(self, dx, dy):
        """This checks a possible move onto the black hole and returns true if it matches the door's allowed direction."""
        return dx == self.dx and dy == self.dy

    def freq(self):
        return 1

    def think(self, g, x, y):
        return True
