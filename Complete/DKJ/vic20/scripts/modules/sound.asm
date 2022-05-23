SOUND:{

	.label Channel1 = $900A
	.label Channel2 = $900B
	.label Channel3 = $900C
	.label Channel4 = $900D

	Countdown: .byte 0, 0, 0
	Channels: .word Channel1, Channel2, Channel3

	Channel: .byte 0



	PlayTick: {


		lda #%11101111
		sta Channel3

		lda #3
		ldx #2
		sta Countdown, x

		rts


	}

	PlayGameOver: {


		lda #%11101111
		sta Channel2

		lda #2
		ldx #120
		sta Countdown, x

		rts


	}


	DeathSound: {

		lda #%10110111
		sta Channel1

		lda #30
		ldx #0
		sta Countdown, x


	}

	ScoreSound: {

		lda #%11110111
		sta Channel3

		lda #1
		ldx #2
		sta Countdown, x

		rts

	}

	MoveMonkey: {


		lda #%11101111
		sta Channel2

		lda #3
		ldx #1
		sta Countdown, x

		rts


	}

	StopAll: {

		lda #ZERO
		sta Channel1
		sta Channel2
		sta Channel3

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

				txa
				pha


				asl
				tax
				lda Channels, x
				sta Address + 1
				inx
				lda Channels, x
				sta Address + 2

				lda #ZERO

				Address:
				
				sta $BEEF

				pla
				tax


			EndLoop:

				cpx #2
				beq Finish
				inx
				jmp Loop

		Finish:

			rts


	}



}