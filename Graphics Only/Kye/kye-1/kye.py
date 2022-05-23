#!/usr/bin/env python

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

from kye.frame import KFrame
from kye.defaults import KyeDefaults
from kye.app import KyeApp

from sys import argv

# Load settings file.
defaults = KyeDefaults()

# Load file & level if specified on the command line.
if len(argv)>1:
    if len(argv)>2:
        k = KyeApp(defaults = defaults, playfile = argv[1], playlevel = argv[2])
    else:
        k = KyeApp(defaults = defaults, playfile = argv[1])
else:
    k = KyeApp(defaults = defaults)

# Create GUI and run the app. This doesn't return until the user exits.
f = KFrame(k, recentlevels = defaults.get_recent(), settings = defaults.settings)
k.run(frame = f)

# Save settings before exit
defaults.save()
