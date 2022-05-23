
.label SCREEN_RAM = $0400
.label SPRITE_POINTERS = SCREEN_RAM + $3f8


//* = $300 "Page 2" virtual

* = 4032
 * = * "Chars"
CHARS: .import binary "../../assets/santa - Chars.bin"


* = 3456 "Sprite"
SPRITES: .import binary "../../assets/santa - Sprites.bin"


	

/*
	Control2: {

		sta ZP.Amount

		ldx ZP.SleighTargetY
		cpx SPRITE_0_Y
		bne Finish

		lda ZP.Amount
		beq Left

		cmp #1
		beq Right

		cmp #2
		beq Up

		Down:

			lda ZP.SleighTrack
			cmp #MaxTrack
			beq Finish

			inc ZP.SleighTrack

			lda ZP.SleighTargetY
			clc
			adc #21
			sta ZP.SleighTargetY

			lda #16
			sta ZP.Cooldown

			jmp Finish
		


		Up:		


			lda ZP.SleighTrack
			beq Finish
		
			dec ZP.SleighTrack

			lda ZP.SleighTargetY
			sec
			sbc #21
			sta ZP.SleighTargetY

			lda #16
			sta ZP.Cooldown

			jmp Finish



		Left:



		Right:



		Finish:

			rts



	}

*/


	// lda SPRITE_0_Y
		// cmp ZP.SleighTargetY
		// beq NoMove

		// bcc IncreaseY

		// DecreaseY:

		// 	dec SPRITE_0_Y
		// 	dec SPRITE_1_Y
		// 	lda SPRITE_0_Y
		// 	cmp ZP.SleighTargetY
		// 	beq NoMove

		// 	dec SPRITE_0_Y
		// 	dec SPRITE_1_Y

		// 	jmp NoMove

		// IncreaseY:

		// 	inc SPRITE_0_Y
		// 	inc SPRITE_1_Y
		// 	lda SPRITE_0_Y
		// 	cmp ZP.SleighTargetY
		// 	beq NoMove

		// 	inc SPRITE_0_Y
		// 	inc SPRITE_1_Y


		// NoMove:
