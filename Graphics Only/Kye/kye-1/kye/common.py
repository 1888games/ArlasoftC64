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

"""kye.common - Common utility functions and classes.
Exposed constants:
xsize, ysize - size of the game playing area.
version - version number of this release of the game.
kyepaths - the list of paths that we will try for opening levels given on the command line, and for searching for tilesets."""

import tarfile
from os.path import exists, join

xsize = 30
ysize = 20

version = "1.0"

kyepaths = ("levels", "/usr/local/share/kye", "/usr/share/kye")

def tryopen(filename, paths):
    """Returns a reading file handle for filename, searching through directories in the supplied paths."""
    try:
        f = open(filename)
        return f
    except IOError, e:
        for path in paths:
            try:
                f = open(join(path, filename))
                return f
            except IOError, e:
                pass
    raise IOError, "Unable to find file "+filename

def findfile(filename):
    """Looks for filename, searching a built-in list of directories; returns the path where it finds the file."""
    if exists(filename):
        return filename
    for path in kyepaths:
        x = join(path, filename)
        if exists(x):
            return x

class KyeImageDir:
    """Class for retrieving images from a tileset tar.gz."""
    def __init__(self, filename):
        self.tiles = {}
        tar = tarfile.open(filename, 'r|gz')
        for tarinfo in tar:
            (tilename, ext) = tarinfo.name.split('.', 2)
            self.tiles[tilename] = tar.extractfile(tarinfo).read()
        tar.close()

    def get_tile(self, tilename):
        """Returns the image file data for the requested tile."""
        return self.tiles[tilename]
