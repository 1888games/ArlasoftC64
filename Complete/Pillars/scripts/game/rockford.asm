ROCKFORD: {


	PosX_LSB:		.byte 0, 0
	PosX_MSB:		.byte 0, 0
	TargetY:		.byte 0
	PosY:			.byte 0

	Frame:			.byte 0
	WaitTimer:		.byte 0
	StartTimer:		.byte 0



	StartPointers:	.byte 53, 59







	Start: {
	
		sta PosY

		lda TargetY
		bne Finish

		sty TargetY

		stx VIC.SPRITE_2_X
		stx VIC.SPRITE_4_X
		stx VIC.SPRITE_6_X
		stx PosX_LSB

		txa
		clc
		adc #24
		sta PosX_LSB + 1
		sta VIC.SPRITE_3_X
		sta VIC.SPRITE_5_X
		sta VIC.SPRITE_7_X

		lda #0
		adc #0
		sta PosX_MSB + 1
		beq NoMSB


		MSB:

			lda VIC.SPRITE_MSB
			ora #%10101000
			sta VIC.SPRITE_MSB

			jmp DoneMSB

		NoMSB:

			lda VIC.SPRITE_MSB
			and #%01010111
			sta VIC.SPRITE_MSB

		DoneMSB:


		lda VIC.SPRITE_ENABLE
		ora #%11111000
		sta VIC.SPRITE_ENABLE



		lda #RED
		sta VIC.SPRITE_MULTICOLOR_1

		lda #LIGHT_RED
		sta VIC.SPRITE_MULTICOLOR_2

		lda #WHITE
		sta VIC.SPRITE_COLOR_2
		sta VIC.SPRITE_COLOR_3
		sta VIC.SPRITE_COLOR_4
		sta VIC.SPRITE_COLOR_5
		sta VIC.SPRITE_COLOR_6
		sta VIC.SPRITE_COLOR_7

		lda #0
		sta VIC.SPRITE_DOUBLE_X
		sta VIC.SPRITE_DOUBLE_Y


		jsr UpdateY
		jsr UpdateFrame

		Finish:

		rts
	}

	UpdateY: {

		lda PosY
		sta VIC.SPRITE_2_Y
		sta VIC.SPRITE_3_Y

		clc
		adc #21
		bcc Okay

		lda #0

		Okay:

		sta VIC.SPRITE_4_Y
		sta VIC.SPRITE_5_Y

		clc
		adc #21
		bcc Okay2

		lda #0

		Okay2:

		sta VIC.SPRITE_6_Y
		sta VIC.SPRITE_7_Y





		rts
	}

	UpdateFrame: {

		ldx Frame
		lda StartPointers, x
		tay

		ldx #2

		Loop:

			tya
			sta SPRITE_POINTERS, x
			iny
			inx
			cpx #8
			bcc Loop




		rts
	}


	FrameUpdate: {
		
			lda WaitTimer
			beq Ready

			dec WaitTimer
			rts

		Ready:

			lda TargetY
			beq Finish

			lda #0
			sta Frame

			jsr UpdateFrame

			lda TargetY
			cmp PosY
			bcc GoingUp

		GoingDown:

			inc PosY
			lda PosY
			cmp TargetY
			bne NotYetUp

			lda #0
			sta TargetY
			sta VIC.SPRITE_2_Y
			sta VIC.SPRITE_3_Y
			sta VIC.SPRITE_4_Y
			sta VIC.SPRITE_5_Y
			sta VIC.SPRITE_6_Y
			sta VIC.SPRITE_7_Y
			rts

		GoingUp:

			dec PosY
			lda PosY
			cmp TargetY
			bne NotYetUp

			inc Frame
			jsr UpdateFrame

			lda #40
			sta WaitTimer

			lda #251
			sta TargetY

		NotYetUp:

			jsr UpdateY


		Finish:



		rts
	}



}