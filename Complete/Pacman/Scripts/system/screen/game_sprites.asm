GAME_SPRITES: {



	MultiColourFlag: 	.byte %00001111
	Mode:				.byte 0

	SoundIRQ_Line:		.byte 158, 200

	SpriteIRQ: {

		:StoreState()

		SetDebugBorder(14)

		// lda MAIN.GameMode
		// cmp #GAME_MODE_INTERMISSION
		// bne NotInter

		// lda TITLE.SpritePriority
		// sta VIC.SPRITE_PRIORITY

		NotInter:


		lda TITLE.SpritePriority
		sta VIC.SPRITE_PRIORITY

		jsr CopyData

		ldx Mode
		ldy SoundIRQ_Line, x
		lda #<IRQ.SoundIRQ
		ldx #>IRQ.SoundIRQ
		jsr IRQ.SetNextInterrupt


		asl VIC.INTERRUPT_STATUS

		SetDebugBorder(0)

		:RestoreState()

		rti
	}


	HideAll: {

		ldx #0
		lda #0

		Loop:

			sta SpriteY, x
			inx
			cpx #MAX_SPRITES
			bcc Loop


		rts
	}

	CopyData: {

		lda READY.GameStarted
		bne OkToShow


		lda #255
		sta VIC.SPRITE_5_Y
		sta VIC.SPRITE_6_Y
		sta VIC.SPRITE_7_Y
		sta VIC.SPRITE_0_Y
		sta VIC.SPRITE_1_Y
		sta VIC.SPRITE_2_Y
		sta VIC.SPRITE_3_Y
		sta VIC.SPRITE_4_Y
		
		rts
		


		OkToShow:

		.for(var i=0; i<5; i++) {
			lda SpriteCopyY + (4-i)
			sta VIC.SPRITE_0_Y + (i*2)
		}

		.for(var i=0; i<5; i++) {
			lda SpriteCopyX + (4-i)
			sta VIC.SPRITE_0_X + (i*2)

			lda PointerCopy + (4-i)
			sta SPRITE_POINTERS + i
			sta SPRITE_POINTERS_2 + i

			lda ColourCopy + (4-i)
			sta $d027 + i

				bpl !nomsb+
			!msb:
				lda $d010 
				ora #[pow(2,i)]
				sta $d010
				jmp !msbdone+
			!nomsb:
				lda $d010 
				and #[255 - pow(2,i)]
				sta $d010

			!msbdone:

		}

		
		lda #255
		sta VIC.SPRITE_5_Y
		sta VIC.SPRITE_6_Y
		sta VIC.SPRITE_7_Y

		lda MultiColourFlag
		sta VIC.SPRITE_MULTICOLOR

		lda #WHITE
		sta VIC.SPRITE_MULTICOLOR_1

		lda INTERMISSION.SpriteMulti
		sta VIC.SPRITE_MULTICOLOR_2

		lda MAIN.GameMode
			cmp #GAME_MODE_EATEN
			bne NotEaten

			lda #%00001111
			sta VIC.SPRITE_ENABLE
			jmp NoTurnOff

		NotEaten:

			lda ACTOR.GHOST.DrawSprites
			bne NoTurnOff	

			lda #%00010000
			sta VIC.SPRITE_ENABLE

		NoTurnOff:

			jsr FRUIT.Sprites

		
		

		rts
	}


	




}