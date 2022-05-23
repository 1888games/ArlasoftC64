

#import "lookups/zeropage.asm"

MAIN: {

BasicStub(8, "Donkey Kong Junior - VIC20", "Entry")

#import "setup/loadModules.asm"

Entry:	
	
		lda $900f
		and #%11110010
		ora #%00000000
		sta $900f

		//lda $38
		//sta $900f

		lda #98
		sta $1000

		lda #7
		sta COLOR_RAM

		lda $9005
		ora #%00001111
		sta $9005

		ldx #ZERO

		lda $9003
		ora #%00000001
		//sta $9003

		lda #255
		//sta $9005

		lda #0
		sta $00C7 

		Loop:

			txa
			sta SCREEN_RAM, x


			lda CHAR_COLORS, x
			lda #ZERO
			sta COLOR_RAM, x



			EndLoop:

				cpx #255
				beq Finish
				inx
				jmp Loop

		Finish:


		
		jmp MainLoop


MainLoop:



 		jmp MainLoop

}


* = $1C00 "Charset"
	CHAR_SET:
		.import binary "../assets/char.bin"   //roll 12!

		* = $2400 "Charset"
	CHAR_SET2:
		.import binary "../assets/char.bin"   //roll 12!




	* = $8500 "Screen data"

	CHAR_COLORS:
		.import binary "../assets/colours.bin"