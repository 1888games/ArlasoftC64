.namespace MAP_GENERATOR {


	* = * "--Scroll"

	SetupScroll: {


		sta DirectionToScroll

		lda #BLUE
		sta EntranceColour

		jsr BlockEntrance
	

		lda #0
		sta ScrollProgress
		sta ROBOT.Active

		jsr OTTO.Disable

		lda #1
		sta Scrolling

		lda #ScrollTime
		sta ScrollTimer

		jsr BULLET.ClearAll

		lda ROBOT.Count
		sta SPEECH.IsChicken
		beq NoChicken

		ldy #S_CHICKEN
		jsr SPEECH.StartSequence

		NoChicken:

		rts
	}


	ScrollLeft: {

		ldx #0

		Loop:

			.for(var i=0; i<25; i++) {
				
				lda SCREEN_RAM + (i * 40) + 1, x
				sta SCREEN_RAM + (i * 40), x

				lda VIC.COLOR_RAM + (i * 40) + 1, x
				sta VIC.COLOR_RAM + (i * 40), x
			}

			inx
			cpx #32
			bcs Finish

			jmp Loop

		Finish:


		.for(var i=0; i<25; i++) {
				
				lda #0
				//sta SCREEN_RAM + (i * 40) + 1

		}
				
		lda #32
		sta ZP.Amount

		lda PLAYER.PosX_LSB
		sec
		sbc #8
		sta PLAYER.PosX_LSB

		lda PLAYER.PosX_MSB
		sbc #0
		sta PLAYER.PosX_MSB


		jsr CheckScrollProgress
		

		Exit:
	
		rts
	}

	ScrollUp: {

		.for(var i=0; i<24; i++) {

				ldx #0

			Loop:

				lda SCREEN_RAM + ((i + 1) * 40), x
				sta SCREEN_RAM + ((i + 0) * 40), x

				lda VIC.COLOR_RAM + ((i + 1) * 40), x
				sta VIC.COLOR_RAM + ((i + 0) * 40), x

				inx
				cpx #32
				bcc Loop

		}


		ldx #0

		.for(var i=0; i<32; i++) {
				
				lda #0
				sta SCREEN_RAM + (24 * 40) + i

		}

		lda #25
		sta ZP.Amount


		lda PLAYER.PosY
		sec
		sbc #8
		sta PLAYER.PosY

		jsr CheckScrollProgress
		



		Exit:
	
		rts
	}

	ScrollRight: {

		ldx #30

		Loop:

			.for(var i=0; i<25; i++) {
				
				lda SCREEN_RAM + (i * 40), x
				sta SCREEN_RAM + (i * 40) + 1, x

				lda VIC.COLOR_RAM + (i * 40), x
				sta VIC.COLOR_RAM + (i * 40) + 1, x
			}

			dex
			bmi Finish
		
			jmp Loop

		Finish:

		.for(var i=0; i<25; i++) {
				
				lda #0
				sta SCREEN_RAM + (i * 40) 

		}


		lda #32
		sta ZP.Amount


		lda PLAYER.PosX_LSB
		clc
		adc #8
		sta PLAYER.PosX_LSB

		lda PLAYER.PosX_MSB
		adc #0
		sta PLAYER.PosX_MSB



		jsr CheckScrollProgress
		
		Exit:
	
		rts

	}

	SpritesLeft: {

		ldx #0

		Loop:

			lda SpriteY, x
			beq EndLoop

			lda SpriteX, x
			sec
			sbc #8
			sta SpriteX, x

			lda SpriteMSB, x
			sbc #0
			sta SpriteMSB, x

			beq NoMSB

			MSB:
	
				lda #BLUE + 128
				sta SpriteColor, x

				jmp EndLoop

			NoMSB:	

				lda SpriteX, x
				cmp #24
				bcs NoDestroy

				lda #0
				sta SpriteY, x
				sta SpriteCopyY, x
				sta SpriteCopyX, x
				sta SpriteColor, x

				jmp EndLoop

			NoDestroy:
				

				lda #BLUE
				sta SpriteColor, x

			EndLoop:

				inx
				cpx #MAX_SPRITES - 1
				bcc Loop


		rts
	}

	SpritesUp: {

		ldx #0

		Loop:

			lda SpriteY, x
			beq EndLoop

			lda SpriteY, x
			sec
			sbc #8
			sta SpriteY, x

			cmp #45
			bcs NoDestroy

			lda #0
			sta SpriteY, x
			sta SpriteCopyX, x
			sta SpriteColor, x
			sta SpriteCopyY, x

		
			NoDestroy:

			lda SpriteColor, x
			and #%10000000
			ora #BLUE
			sta SpriteColor, x

			EndLoop:

				inx
				cpx #MAX_SPRITES - 1
				bcc Loop


		rts
	}

	SpritesDown: {

		ldx #0

		Loop:

			lda SpriteY, x
			beq EndLoop

			lda SpriteY, x
			clc
			adc #8
			sta SpriteY, x

			cmp #240
			bcc NoDestroy

			lda #0
			sta SpriteY, x
			sta SpriteCopyX, x
			sta SpriteCopyY, x
			sta SpriteColor, x

			jmp EndLoop

		NoDestroy:

			lda SpriteColor, x
			and #%10000000
			ora #BLUE
			sta SpriteColor, x

			EndLoop:

				inx
				cpx #MAX_SPRITES - 1
				bcc Loop


		rts

		rts
	}

	SpritesRight: {

		ldx #0

		Loop:

			lda SpriteY, x
			beq EndLoop

			lda SpriteX, x
			clc
			adc #8
			sta SpriteX, x

			lda SpriteMSB, x
			adc #0
			sta SpriteMSB, x

			beq NoMSB

			MSB:

				lda SpriteX, x
				cmp #12
				bcc NoDestroy

				lda #0
				sta SpriteY, x
				sta SpriteCopyX, x
				sta SpriteCopyY, x
				sta SpriteColor, x

				jmp EndLoop

			NoDestroy:

				lda #BLUE + 128
				sta SpriteColor, x

				jmp EndLoop

			NoMSB:	

				lda #BLUE
				sta SpriteColor, x

			EndLoop:

				inx
				cpx #MAX_SPRITES - 1
				bcc Loop



		rts
	}


	CheckScrollProgress: {

		inc ScrollProgress
		lda ScrollProgress
		cmp ZP.Amount
		bcc Exit	

		lda #0
		sta Scrolling

		lda DirectionToScroll
		sta PLAYER.SpawnSide

		jsr Generate

		Exit:


		rts
	}
	

	ScrollDown: {

		.for(var i=23; i>=0; i--) {

				ldx #0

			Loop:

				lda SCREEN_RAM + ((i + 0) * 40), x
				sta SCREEN_RAM + ((i + 1) * 40), x

				lda VIC.COLOR_RAM + ((i + 0) * 40), x
				sta VIC.COLOR_RAM + ((i + 1) * 40), x

				inx
				cpx #32
				bcc Loop

		}


		ldx #0

		.for(var i=0; i<32; i++) {
				
				lda #0
				sta SCREEN_RAM + (0 * 40) + i

		}
	
		lda #25
		sta ZP.Amount

		lda PLAYER.PosY
		clc
		adc #8
		sta PLAYER.PosY

		jsr CheckScrollProgress
		


		Exit:
	
		rts
	}

	

	HandleScroll: {

		lda ScrollTimer
		beq Ready

		dec ScrollTimer
		beq Sprites

		rts

		Sprites:

			ldx DirectionToScroll
			lda ScrollFunc_LSB + 8, x
			sta ZP.DataAddress

			lda ScrollFunc_MSB + 8, x
			sta ZP.DataAddress + 1

			jmp (ZP.DataAddress)

		Ready:

			ldx DirectionToScroll
			lda ScrollFunc_LSB, x
			sta ZP.DataAddress

			lda ScrollFunc_MSB, x
			sta ZP.DataAddress + 1

			lda #ScrollTime
			sta ScrollTimer


			jmp (ZP.DataAddress)


		
	}
}