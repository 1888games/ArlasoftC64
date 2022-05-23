#    Kye - classic puzzle game
#    Copyright (C) 2006, 2007, 2010 Colin Phipps <cph@moria.org.uk>
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
"""kye.defaults - contains the KyeDefaults class."""

from os import environ
from os.path import join, basename, expanduser

class KyeDefaults:
    """Class for reading, querying and saving game preferences, including the list of recently-played files and known level names."""
    known_header = "[Known Levels]"
    settings_header = "[Settings]"
    
    def __init__(self):
        # Path to the config file.
        self.__cf = join(expanduser("~"), ".kye.config")
        
        # Initialise.
        self.__count = 0
        self.__known = {}
        self.__orderfiles = {}
        self.__path = {}
        self.settings = {}
        
        # Try reading the config file.
        try:
            s = open(self.__cf)
            while 1:
                # Read header lines until done.
                line = s.readline().strip()
                if line == "":
                    break
                elif line == KyeDefaults.known_header:
                    # Inside the [known levels] block; keep reading until we get to a blank line.
                    while 1:
                        line = s.readline().strip()
                        if line == "":
                            break
                        
                        # Format here is filename<TAB>known_level<TAB>known_level<TAB>...
                        fields = line.split("\t")
                        path = fields.pop(0)
                        filename = basename(path)
                        self.__known[filename] = fields
                        self.__path[filename] = path
                        
                        # Order in the config file is the recently-used order.
                        self.__orderfiles[filename] = self.__count
                        self.__count = self.__count + 1
                        
                elif line == KyeDefaults.settings_header:
                    # Read into settings hash until we get to a blank line.
                    while 1:
                        line = s.readline().strip()
                        if line == "":
                            break
                        key, value = line.split("\t")
                        if key == "Size":
                            self.settings[key] = value
        
        except IOError, e:
            pass

    def get_known_levels(self, path):
        """Get all known level names for the given filename."""
        fname = basename(path)
        if fname in self.__known:
            return self.__known[fname]
        return []

    def add_known(self, path, level_name):
        """For this kye file, we now know this level name."""
        # Index by just the filename
        fname = basename(path)
        self.__path[fname] = path
        
        # Remember that this is the most recently loaded level
        self.__orderfiles[fname] = self.__count
        self.__count = self.__count + 1

        # Add this level to the known list for this file (adding the file to the dictionary if new)
        if fname not in self.__known:
            self.__known[fname] = []
        if level_name not in self.__known[fname]:
            self.__known[fname].append(level_name)

    def get_recent(self):
        """Returns paths to the five most recently loaded .kye files."""
        known_names = self.__known.keys()
        known_names.sort(lambda x, y: cmp(self.__orderfiles[x], self.__orderfiles[y]))
        return [self.__path[name] for name in known_names[-5:]]

    def save(self):
        """Try to save the configuration back to the config file."""
        try:
            s = open(self.__cf, "w")

            # Known levels etc
            s.write(KyeDefaults.known_header+"\n")
            known_names = self.__known.keys()
            known_names.sort(lambda x, y: cmp(self.__orderfiles[x], self.__orderfiles[y]))
            for name in known_names:
                s.write(self.__path[name] + "\t" 
                        + "\t".join(self.__known[name]) + "\n")
            s.write("\n")
        
            # other settings
            s.write(KyeDefaults.settings_header+"\n")
            for setting,value in self.settings.iteritems():
                s.write("%s\t%s\n" % (setting, value))
            s.write("\n")
            
        except IOError, e:
            pass
