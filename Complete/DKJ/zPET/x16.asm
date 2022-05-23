
MAIN: {

#import "lookups/zeropage.asm"

* = $1d00 "Code1"
#import "setup/upstart.asm"
#import "setup/loadModules.asm" 

GameCounter:		.byte 32, 32, 32
SpeedIncreaseCounter: .byte 48, 48
FrameSwitch: .byte 0
TitleCooldown: .byte 30, 255

BASICStub(0,"Entry")

.label MaxSpeed = 13

Entry:	
	
		//exomizer sfx sys -t 64 -x "inc $d020" -o yakf.exo yakf.prg

		//sei 

		//jsr VIC.Setup
		//jsr SOUND.Setup

		jmp Loop



Loop:

		
	jmp Loop


}