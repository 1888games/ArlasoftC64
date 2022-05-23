PET:{

	.label SoundOnOff = $E84B
	.label Octave = $E84A
	.label Frequency = $E848



	PlayNote: {


		.if (target == "PET") {

			lda >SOUND.NoteValue
			sta Octave

			lda <SOUND.NoteValue
			sta Frequency

		}

		rts
	}

	StopNote: {


		.if (target == "PET") {
	
			lda #ZERO
			sta Frequency

		}

		rts

	}

}