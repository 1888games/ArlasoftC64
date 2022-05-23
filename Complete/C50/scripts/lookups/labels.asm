
.label ZERO= 0
.label ALL_ON = 255
.label ONE=1

.label JOY_UP = %00001
.label JOY_DOWN = %00010
.label JOY_LEFT = %00100
.label JOY_RIGHT = %01000
.label JOY_FIRE = %10000
.label ZeroInCharSet = 48

.label CELL_TYPE_BLANK = 0
.label CELL_TYPE_CENTRE = 1
.label CELL_TYPE_WARNING = 2
.label CELL_TYPE_STRAWBERRY= 3
.label CELL_TYPE_LEMON = 4
.label CELL_TYPE_PEAR = 5
.label CELL_TYPE_GRAPES = 6


.label LEFT = 0
.label RIGHT = 1
.label UP = 2
.label DOWN = 3
.label FIRE = 4

.label PROCESSOR_PORT = $01
.label RASTER_INTERRUPT_VECTOR = $fffe
.label JOY_PORT_2 = $dc00
.label IRQControlRegister1 = $dc0d
.label IRQControlRegister2 = $dd0d

.label GETIN  =  $FFE4
.label SCNKEY =  $FF9F

.label MODE_OPTIONS = 0
.label MODE_SELECT_1 = 1
.label MODE_SELECT_2 = 2
.label MODE_RECRUIT = 3 
.label MODE_PLAY = 4

.label EMPTY = 0
.label TREE = 1
.label TENT = 2
.label WILL_BE_TENT = 3

.label GAME_MODE_PLAY = 0
.label GAME_MODE_COMPLETE = 1

.label PRESENT_LAYOUT_FLAT = 0
.label PRESENT_LAYOUT_DIAG = 1
.label PRESENT_LAYOUT_CURVE = 2

.label SPRITE_0_X = $d000
.label SPRITE_0_Y = $d001

.label SPRITE_1_X = $d002
.label SPRITE_1_Y = $d003

.label SPRITE_2_X = $d004
.label SPRITE_2_Y = $d005

.label SPRITE_3_X = $d006
.label SPRITE_3_Y = $d007

.label SPRITE_4_X = $d008
.label SPRITE_4_Y = $d009

.label SPRITE_5_X = $d00a
.label SPRITE_5_Y = $d00b

.label SPRITE_6_X = $d00c
.label SPRITE_6_Y = $d00d

.label SPRITE_7_X = $d00e
.label SPRITE_7_Y = $d00f

.label SPRITE_MSB = $d010

.label RASTER_Y = $d012 

.label SPRITE_ENABLE = $d015
.label SCREEN_CONTROL_2 = $d016

.label VIC_BANK_SELECT = $dd00

.label SCREEN_CONTROL = $d011
.label MEMORY_SETUP = $d018

.label INTERRUPT_CONTROL = $d01a
.label INTERRUPT_STATUS = $d019

.label SPRITE_MULTICOLOR = $d01c

.label BORDER_COLOR = $d020
.label BACKGROUND_COLOR = $d021
.label EXTENDED_BG_COLOR_1 = $d022
.label EXTENDED_BG_COLOR_2 = $d023

.label SPRITE_MULTICOLOR_1 = $d025
.label SPRITE_MULTICOLOR_2 = $d026

.label SPRITE_COLOR_0 = $d027
.label SPRITE_COLOR_1 = $d028
.label SPRITE_COLOR_2 = $d029
.label SPRITE_COLOR_3 = $d02a
.label SPRITE_COLOR_4 = $d02b
.label SPRITE_COLOR_5 = $d02c
.label SPRITE_COLOR_6 = $d02d
.label SPRITE_COLOR_7 = $d02e

.label SPRITE_PRIORITY = $d01b
.label SPRITE_BG_COLLISION = $d01f

.label COLOR_RAM = $d800




.label SLEIGH_MODE_FLYING = 0
.label SLEIGH_MODE_DODGING = 2


.label PLAYER_MODE_FREE = 0
.label PLAYER_MODE_FIRE = 1
.label PLAYER_MODE_MOVE = 2
.label PLAYER_MODE_RETURN = 3


.label BALL_MODE_PLACING = 0
.label BALL_MODE_AWAIT_FIRE = 1
.label BALL_MODE_POWERING = 2
.label BALL_MODE_IN_PLAY = 3
.label BALL_MODE_BLOCKED= 4
.label BALL_MODE_STOPPED = 5


.label UTOPIA_FORT = 1
.label UTOPIA_FACTORY = 2
.label UTOPIA_CROP = 3
.label UTOPIA_SCHOOL = 4
.label UTOPIA_HOSPITAL = 5
.label UTOPIA_HOUSE = 6
.label UTOPIA_REBEL = 7
.label UTOPIA_PT_BOAT = 8
.label UTOPIA_FISHING_BOAT= 9



.label UTOPIA_MODE_CHOOSE = 0
