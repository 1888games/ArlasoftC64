SOUND:{

	
	.label SoundOnOff = $E84B
	.label CONTROL = $ff11
	.label Octave = $E84A
	.label Frequency = $E848

	Countdown: .byte 0


	Setup:{

		lda #16
		sta SoundOnOff

		rts
		
	}

	MoveMonkey: {

		lda #15
		sta Octave

		lda #150
		sta Frequency

		lda #3
		sta Countdown

		rts


	}

	PlayGameOver: {



		lda #51
		sta Octave

		lda #155
		sta Frequency

		lda #255
		sta Countdown



		rts


	}


	DeathSound: {


		lda #15
		sta Octave

		lda #20
		sta Frequency

		lda #30
		sta Countdown

		rts
	
	}

	ScoreSound: {

		lda #85
		sta Octave

		lda #200
		sta Frequency

		lda #1
		sta Countdown



		rts
	}

	PlayTick: {


		lda #85
		sta Octave

		lda #65
		sta Frequency

		lda #1
		sta Countdown

		rts
		
	}

	StopAll: {

		lda #0
		sta Frequency

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

				lda #0
				sta Frequency
				
			EndLoop:

				cpx #0
				beq Finish
				inx
				jmp Loop

		Finish:

			rts


	}



}