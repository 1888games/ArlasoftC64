TITLE: {


	* = * "Title"

	Chars:	.byte 46, 47, 48, 49, 50, 51, 52, 53
			.byte 57, 58, 59, 60, 61, 62, 63, 64


	Addresses:	.fillword 16, $f000 + (46 * 8) + (i * 8)

	.label CharStart = $f000 + (46 * 8)
	.label CharStart2 = $f000 + (57 * 8)
	.label CharStart3 = $f000 + (65 * 8)



	Colours:	.byte DARK_GRAY, BLUE, LIGHT_BLUE
				.byte LIGHT_BLUE, CYAN
				.byte CYAN, CYAN, CYAN
				.byte CYAN, LIGHT_BLUE, LIGHT_BLUE, BLUE, DARK_GRAY
				.byte RED, RED, GREEN


	ValidColours:	.byte GREEN, BLACK, RED, BLUE, PURPLE, LIGHT_BLUE, ORANGE, LIGHT_RED

	.label StartRow = 114

	CurrentID:	.byte 0
	CurrentRow:	.byte 118
	ScrollTimer:	.byte 6

	ColourTimer:	.byte 150

	BackgroundColour:	.byte RED
	BottomColour:		.byte GREEN

	.label ScrollTime = 6
	.label ColourTime = 150

	TitleIRQ: {

		:StoreState()

		//inc $d020

		ldx ZP.CurrentID

		nop
		nop

		Loop:

			lda Colours, x
			cmp #RED
			beq UseBackground

			cmp #GREEN
			beq UseBottom

		 	sta VIC.BACKGROUND_COLOR
		 	jmp Next

		 	UseBackground:

		 	lda BackgroundColour
		 	sta VIC.BACKGROUND_COLOR
		 	jmp Next

		 	UseBottom:

		 	lda BottomColour
		 	sta VIC.BACKGROUND_COLOR

		 	Next:

		 	inx
		 	cpx #16
		 	beq Exit

		 	ldy #9

		 	Loop2:

		 		dey
		 		bpl Loop2


		 	jmp Loop


		inc ZP.CurrentRow
		inc ZP.CurrentRow
	///	inc ZP.CurrentRow
		
		inc ZP.CurrentID

		lda ZP.CurrentID
		cmp #8
		bcc Okay


	Exit:

		ldy #IRQ.MainIRQLine
		lda #<IRQ.MainIRQ
		ldx #>IRQ.MainIRQ
		sta INTERRUPT_VECTOR
		stx INTERRUPT_VECTOR + 1
		sty VIC.RASTER_Y
		lda VIC.SCREEN_CONTROL
		and #%01111111		// don't use 255+
		sta VIC.SCREEN_CONTROL

		jmp NoIRQs

		Okay:

		//SetDebugBorder(3)
		
			ldy ZP.CurrentRow
			lda #<TitleIRQ
			ldx #>TitleIRQ
			//jsr IRQ.SetNextInterrupt

			sta INTERRUPT_VECTOR
			stx INTERRUPT_VECTOR + 1
			sty VIC.RASTER_Y
			lda VIC.SCREEN_CONTROL
			and #%01111111		// don't use 255+
			sta VIC.SCREEN_CONTROL



		NoIRQs:

		asl VIC.INTERRUPT_STATUS

		//SetDebugBorder(0)

		//dec $d020

		:RestoreState()


		rti

	}


	Scroll: {

		.for(var i=0; i<8; i++) {


			lda CharStart + 0 + (i * 8)
			sta ZP.Temp3

			lda CharStart + 1 + (i * 8)
			sta CharStart + 0 + (i * 8)

			lda CharStart + 2 + (i * 8)
			sta CharStart + 1 + (i * 8)

			lda CharStart + 3 + (i * 8)
			sta CharStart + 2 + (i * 8)

			lda CharStart + 4 + (i * 8)
			sta CharStart + 3 + (i * 8)

			lda CharStart + 5 + (i * 8)
			sta CharStart + 4 + (i * 8)

			lda CharStart + 6 + (i * 8)
			sta CharStart + 5 + (i * 8)

			lda CharStart + 7 + (i * 8)
			sta CharStart + 6 + (i * 8)

			lda CharStart2 + 0 + (i * 8)
			sta CharStart + 7 + (i * 8)

			lda CharStart2 + 1 + (i * 8)
			sta CharStart2 + 0 + (i * 8)

			lda CharStart2 + 2 + (i * 8)
			sta CharStart2 + 1 + (i * 8)

			lda CharStart2 + 3 + (i * 8)
			sta CharStart2 + 2 + (i * 8)

			lda CharStart2 + 4 + (i * 8)
			sta CharStart2 + 3 + (i * 8)

			lda CharStart2 + 5 + (i * 8)
			sta CharStart2 + 4 + (i * 8)

			lda CharStart2 + 6 + (i * 8)
			sta CharStart2 + 5 + (i * 8)


			lda CharStart2 + 7 + (i * 8)
			sta CharStart2 + 6 + (i * 8)

			lda CharStart3 + 0 + (i * 8)
			sta CharStart2 + 7 + (i * 8)	

			lda CharStart3 + 1 + (i * 8)
			sta CharStart3 + 0 + (i * 8)

			lda ZP.Temp3
			sta CharStart3 + 1 + (i * 8)	



			
		}
		






		rts
	}


	FrameUpdate: {	

		lda ColourTimer
		beq ReadyColour

		dec ColourTimer
		jmp ScrollIt

		ReadyColour:

			jsr RANDOM.Get
			and #%00000111
			tax
			lda ValidColours, x
			sta BackgroundColour

			sta VIC.EXTENDED_BG_COLOR_1

			Again:

			jsr RANDOM.Get
			and #%00000111
			tax
			lda ValidColours, x
			cmp BackgroundColour
			beq Again

			sta BottomColour



			lda #ColourTime
			sta ColourTimer



		ScrollIt:

		lda ScrollTimer
		beq Ready


		dec ScrollTimer
		rts

		Ready:

		lda #ScrollTime
		sta ScrollTimer

		jsr Scroll






		rts
	}
}