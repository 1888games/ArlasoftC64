		
.if (target == "C64") {
	* = $f000 "Charset"
}

.if (target == "264") {
	* = $2800 "Charset"
}

.if (target == "VIC") {
	* = $1C00 "Charset"
}


CHAR_SET:

	.if(target == "C64" || target == "264") {
		.import binary "../assets/x64/char.bin" 
	}

	.if(target == "VIC") {
		.import binary "../assets/vic/char.bin"
	}
	
.if (target == "C64") {
	* = $f800 "Title Charset"
}

.if (target == "264") {
	* = $2000 "Title Charset"
}

.if (target == "VIC") {
	* = $1400 "Title Charset"
}


TITLE_CHAR_SET:

	.if(target == "C64" || target == "264") {
		.import binary "../assets/title/x64/title_char.bin" 
	}

	.if(target == "VIC") {
		.import binary "../assets/title/vic/char.bin"
	}
	



.if (target == "C64") {
	* = $8500 "Level Data"
}

.if (target == "264") {
	* = $7000 "Screen data 2"
}

.if (target == "VIC") {
	* = $2f00 "Screen data"
}


MAP_TILES:
	.if(target == "C64" || target == "264") {
		.import binary "../assets/x64/tiles.bin"
	}

	.if(target == "VIC") {
		.import binary "../assets/vic/tiles.bin"
	}

TITLE_TILES:
	.if(target == "C64") {
		.import binary "../assets/title/x64/title_tiles.bin"
	}

	.if(target == "264") {
		.import binary "../assets/title/x64/title_tiles.bin"
	}

	.if(target == "VIC") {
		.import binary "../assets/title/vic/tiles.bin"
	}



CHAR_COLORS:

	.if(target == "C64" || target == "264") {
		.import binary "../assets/x64/colours.bin"
	}

	.if(target == "VIC") {
		.import binary "../assets/vic/colours.bin"
	}

TITLE_CHAR_COLORS:

	.if(target == "C64" || target == "264") {
		.import binary "../assets/title/x64/title_colours.bin"
	}

	.if(target == "VIC") {
		.import binary "../assets/title/vic/colours.bin"
	}



MAP:

	.if(target == "C64" || target == "264") {
		.import binary "../assets/x64/map.bin"
	}

	.if(target == "VIC") {
		.import binary "../assets/vic/map.bin"
	}

TITLE_MAP:

	.if(target == "C64") {
		.import binary "../assets/title/x64/title_map.bin"
	}

	.if(target == "264") {
		.import binary "../assets/title/x64/title_map.bin"
	}

	.if(target == "VIC") {
		.import binary "../assets/title/vic/map.bin"
	}



