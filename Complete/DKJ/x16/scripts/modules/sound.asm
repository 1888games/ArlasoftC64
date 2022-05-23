SOUND:{

	.label Channel1_LSB = $ff0e
	.label Channel2_LSB = $ff0f
	.label Channel1_MSB = $ff10
	.label Channel2_MSB = $ff12
	.label CONTROL = $ff11

	ChannelOn: .byte  %00010000, %00100000
	ChannelOff: .byte %11101111,%11011111



	Countdown: .byte 0, 0
	Channels: .word Channel1_LSB, Channel1_MSB, Channel2_LSB, Channel2_MSB

	Channel: .byte 0

// 	$ff0e       : This reg is the first sound-source's frq-value's lowmost 8 bit.
//               More 2 bits are in $ff10's 0. and 1. places.
// $ff0f       : 2nd. source, lowmost 8 bits. More 2 bits in $ff12, 0. and 1.
//               places.
//               The soundregister-value can be calculated as
//                 reg=1024-(111860.781/frq[Hz]) (NTSC)
//                 reg=1024-(111840.45 /frq[Hz]) (PAL)
// $ff10       : 1st. sound-source, higmost 2 bits. 2-7 bits are unused.
// $ff11       : Sound control register.
//               Bit 0-3   : Volume. Maximum value is 8.
//               Bit 4     : Sound #1 on/off.
//               Bit 5     : Sound #2 squarewave on/off.
//               Bit 6     : Sound #2 noise on/off. If You set both, the square
//                           will sound.
		


	Setup:{


		lda CONTROL
		ora #%00000011
		sta CONTROL

		rts
		
	}

	MoveMonkey: {



		lda #%11111111
		sta Channel2_LSB

		lda Channel2_MSB
		and #%11111100
		ora #%00000011
		sta Channel2_MSB

		lda #2
		ldx #1
		sta Countdown, x

		lda CONTROL
		ora ChannelOn, x
		sta CONTROL




		rts


	}

	PlayGameOver: {


		lda #%01111111
		sta Channel1_LSB

		lda Channel1_MSB
		and #%11111100
		//ora #%00000011
		sta Channel1_MSB

		lda #60
		ldx #0
		sta Countdown, x

		lda CONTROL
		ora ChannelOn, x
		sta CONTROL


		rts


	}


	DeathSound: {

		
		lda #%11111111
		sta Channel1_LSB

		lda Channel1_MSB
		and #%11111100
		ora #%00000011
		sta Channel1_MSB

		lda #20
		ldx #0
		sta Countdown, x

		lda CONTROL
		ora ChannelOn, x
		sta CONTROL






	}

	ScoreSound: {

		lda #%10011111
		sta Channel2_LSB

		lda Channel2_MSB
		and #%11111100
		ora #%00000011
		sta Channel2_MSB

		lda #1
		ldx #1

		sta Countdown, x

		lda CONTROL
		ora ChannelOn, x
		sta CONTROL

		rts

	}

	PlayTick: {


		lda #%01111111
		sta Channel1_LSB

		lda Channel1_MSB
		and #%11111111
		ora #%00000011
		sta Channel1_MSB

		lda #1
		ldx #0

		sta Countdown, x

		lda CONTROL
		ora ChannelOn, x
		sta CONTROL


		rts


	}

	StopAll: {

		lda CONTROL
		and #%11001111
		sta CONTROL
		
		rts


	}

	Update: {

		ldx #0

		Loop:

			ldy Countdown, x
			beq StopChannel

			dey
			tya
			sta Countdown, x

			jmp EndLoop

			StopChannel: 

				//.break

				//lda #ZERO
				//sta Channel1, x

				//txa
				//pha


				lda CONTROL
				and ChannelOff, x
				sta CONTROL

				//lda #ZERO

				Address:
				
				///sta $BEEF

				//pla
				//tax


			EndLoop:

				cpx #1
				beq Finish
				inx
				jmp Loop

		Finish:

			rts


	}



}