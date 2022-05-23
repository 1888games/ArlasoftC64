SOUND:{

	.label VOICE_1_FREQUENCY = $d400		// & $d401
	.label VOICE_1_PULSE_WIDTH = $d402	// & $d403
	.label VOICE_1_CONTROL = $d404		// Noise, Rect, Saw, Tri, Reset, Ring, Sync, On/off
	.label VOICE_1_ATTDEC = $d405		// Attack 4-bits Decay 4-bits
	.label VOICE_1_SUSTAIN = $d406 	// Volume 4-bits Release 4-bits
	.label VOLUME_FILTER = $d418

	.label VOICE_2_FREQUENCY = $d407		// & $d401
	.label VOICE_2_PULSE_WIDTH = $d409	// & $d403
	.label VOICE_2_CONTROL = $d40b		// Noise, Rect, Saw, Tri, Reset, Ring, Sync, On/off
	.label VOICE_2_ATTDEC = $d40c		// Attack 4-bits Decay 4-bits
	.label VOICE_2_SUSTAIN = $d40d 	// Volume 4-bits Release 4-bits

	// .label VOICE_3_FREQUENCY = $d40e		// & $d401
	// .label VOICE_3_PULSE_WIDTH = $d410	// & $d403
	// .label VOICE_3_CONTROL = $d412		// Noise, Rect, Saw, Tri, Reset, Ring, Sync, On/off
	// .label VOICE_3_ATTDEC = $d413		// Attack 4-bits Decay 4-bits
	// .label VOICE_3_SUSTAIN = $d414 	// Volume 4-bits Release 4-bits


	Initialise:{

		ldx #$00
		lda #$00
		clearsidloop:
		// SID registers start at $d400
		sta $d400
		inc clearsidloop+1 
		inx
		cpx #$29 // and there are 29 of them
		bne clearsidloop

		// set master volume and turn filter off


		lda #%00001111 
		sta VOLUME_FILTER


		lda #%00000111
		sta VOICE_1_FREQUENCY
		lda #%00111111
		sta VOICE_1_FREQUENCY + 1

		lda #%11111111
		sta VOICE_2_FREQUENCY
		lda #%11111111
		sta VOICE_2_FREQUENCY + 1

		// lda #%00000111
		// sta VOICE_3_FREQUENCY
		// lda #%00001111
		// sta VOICE_3_FREQUENCY + 1
		
	}

	ScoreSound:{

		lda #%00000111
		sta VOICE_1_FREQUENCY
		lda #%11111111
		sta VOICE_1_FREQUENCY + 1

		jsr PlayChannel_1

		rts


	}

	SniffSound:{


		lda #%10000001
		sta VOICE_2_CONTROL

		lda #%10000100
		sta VOICE_2_ATTDEC

		lda #%00001000
		sta VOICE_2_SUSTAIN

		lda #%10000000
		sta VOICE_2_CONTROL

		rts
	}


	HitSound:{


		lda #%10000001
		sta VOICE_2_CONTROL

		lda #%01000100
		sta VOICE_2_ATTDEC

		lda #%00001001
		sta VOICE_2_SUSTAIN

		lda #%10000000
		sta VOICE_2_CONTROL

		rts
	}



	PlayChannel_1:{

		lda #%00100001
		sta VOICE_1_CONTROL

		lda #%00000000
		sta VOICE_1_ATTDEC

		lda #%00000100
		sta VOICE_1_SUSTAIN

		lda #%00001111
		sta VOLUME_FILTER


		lda #%00100000
		sta VOICE_1_CONTROL

		rts

	}

	SuccessfulSniff:{

		lda #%00010001
		sta VOICE_1_CONTROL

		lda #%01000100
		sta VOICE_1_ATTDEC

		lda #%00001001
		sta VOICE_1_SUSTAIN

		lda #%00010000
		sta VOICE_1_CONTROL

	

		rts

	}




}