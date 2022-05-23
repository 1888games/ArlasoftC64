SOUND:{

	.label VOICE_1_FREQUENCY = $d400		// & $d401
	.label VOICE_1_PULSE_WIDTH = $d402	// & $d403
	.label VOICE_1_CONTROL = $d404		// Noise, Rect, Saw, Tri, Reset, Ring, Sync, On/off
	.label VOICE_1_ATTDEC = $d405		// Attack 4-bits Decay 4-bits
	.label VOICE_1_SUSTAIN = $d406 	// Volume 4-bits Release 4-bits
	.label SID_VOLUME_FILTER = $d418

	.label VOICE_2_FREQUENCY = $d407		// & $d401
	.label VOICE_2_PULSE_WIDTH = $d409	// & $d403
	.label VOICE_2_CONTROL = $d40b		// Noise, Rect, Saw, Tri, Reset, Ring, Sync, On/off
	.label VOICE_2_ATTDEC = $d40c		// Attack 4-bits Decay 4-bits
	.label VOICE_2_SUSTAIN = $d40d 	// Volume 4-bits Release 4-bits

	.label VOICE_3_FREQUENCY = $d40e		// & $d401
	.label VOICE_3_PULSE_WIDTH = $d410	// & $d403
	.label VOICE_3_CONTROL = $d412		// Noise, Rect, Saw, Tri, Reset, Ring, Sync, On/off
	.label VOICE_3_ATTDEC = $d413		// Attack 4-bits Decay 4-bits
	.label VOICE_3_SUSTAIN = $d414 	// Volume 4-bits Release 4-bits


	MaxChannels: .byte 3
	NoteRemaining: .byte 0, 0, 0
	EndNoteID: .byte 0, 0, 0
	CurrentNoteID: .byte 0, 0, 0
	CurrentNoteValue: .byte 0, 0, 0
	SongIDs: .byte 99, 99, 99	
	Cooldown: .byte 0


	.label ObjectID = TEMP1
	.label StartAddress = VECTOR1
	.label BytesToRead = TEMP2
	.label ByteID = TEMP5
	.label NoteValue = VECTOR2
	.label CurrentChannel = TEMP3
	

	NoteValues:

	.if(target == "C64") {
		.word $0735, $07A3, $0817, $0893, $0915, $099F, $0A32, $0ACD, $0B72, $0C20, $0CD8, $0D9C, $0E6B, $0F46, $102F, $1125, $122A, $133F, $1464, $159A, $16000, $183F, $1981, $1B38, $1CD6, $1E80, $205E, $224B, $2455, $267E, $28C8, $2B34, $2DC6, $307F, $3361, $366F, $39AC, $3D1A
	}

	.if(target == "264") {
		.word $000F, $0048, $007D, $00B0, $00DF, $010C, $0137, $015E, $0184, $01A8, $01C9, $01E9, $0207, $0223, $023E, $0258, $026F, $0286, $029B, $02AF, $02C1, $02D3, $02E4, $02F4, $0303, $0311, $031F, $032B, $0337, $0342, $034D, $0357, $0360, $0369, $0372, $037A, $0381, $0388
	}

	.if(target == "VIC") {
		.word $00A3, $00A7, $00AF, $00B3, $00B7, $00BB, $00BF, $00C3, $00C7, $00C9, $00CB, $00CF, $00D1, $00D4, $00D7, $00D9, $00DB, $00DD, $00DF, $00E1, $00E3, $00E4, $00E5, $00E7, $00E8, $00E9, $00EB, $00EC, $00ED, $00EE, $00EF, $00F0, $00F1, $00F2, $00F8, $00FB, $00FD, $00FE
	}

	.if(target == "PET") {
	.word $5541, $5541, $0FFB, $0FEE, $0FE0, $0FD2, $0FC7, $0FBC, $0FB1, $0FA8, $0F9E, $0F95, $0F8C, $0F85, $0F7D, $0F76, $0F6E, $0F68, $0F63, $0F5D, $0F58, $0F53, $0F4E, $0F4A, $0F45, $0F41, $337D, $3376, $336E, $3368, $3363, $335D, $3358, $3353, $334E, $334A, $3345, $3341

	}

	Initialise: {

		.if (target == "C64") {
			jsr SetupSID

			//ldy #1
			//jsr StartSong


		}

		.if(target == "PET") {


			lda #ONE
			sta MaxChannels

			lda #16
			sta PET.SoundOnOff

		
		}

		.if(target == "264") {
			lda #2
			sta MaxChannels

			lda TED_CONTROL
			ora #%00000011
			sta TED_CONTROL  // set volumne

			ldy #1
			jsr StartSong

		}


		.if(target == "VIC") {

			
		}

		rts

	}



	StartSong: {

		lda Cooldown
		beq OkayToPlay

		jmp Finish

		OkayToPlay:

		lda #1
		sta Cooldown

		:StoreState()

		lda SOUND_DATA.SongLength, y
		cmp #4
		bcc DontOverride

		ldx #0
		jmp UseThisChannel

		DontOverride:

		sty ObjectID

		ldx #0

		// Find a channel to use
		Loop:

			lda SongIDs, x
			cmp #99
			beq UseThisChannel

			inx
			cpx MaxChannels
			beq Finish

			jmp Loop


		UseThisChannel:

		tya 
		sta SongIDs, x

		lda SOUND_DATA.SongLength, y
		sta EndNoteID, x

		lda #ZERO
		sta CurrentNoteID, x

		
		jsr GetNextNote
		jsr PlayNote

		Restore:

			:RestoreState()


		Finish:

			
			rts


	}


	Update: {

		//.break


		:StoreState()

		lda #0
		sta Cooldown
	
		.label CurrentNote = TEMP12

		ldx #0

		Loop:

			lda SongIDs, x
			cmp #99
			beq EndLoop

			CheckNoteStatus:

			//	.break

				lda NoteRemaining, x
				sec
				sbc #01
				sta NoteRemaining, x
				cmp #ONE
				bcs EndLoop


			StoppingNote:


				jsr StopNote
				lda CurrentNoteID, x
				sta CurrentNote
				
				lda EndNoteID, x
				cmp CurrentNote
				bne MoreNotes


				LastNote:



					lda #99
					sta SongIDs, x
					jmp EndLoop

				MoreNotes:

					lda CurrentNoteID, x
					clc
					adc #01
					sta CurrentNoteID, x
					jsr GetNextNote
					jsr PlayNote


			EndLoop:

				inx
				cpx MaxChannels
				beq Finish
				jmp Loop



		Finish:

			:RestoreState()


		rts
	}


	StopNote: {



		.if(target == "C64") {

			jsr C64.StopNote
		}
 
		.if(target == "VIC") {

			jsr VIC20.StopNote
		}

		.if(target == "264") {

			jsr PLUS4.StopNote
		}

		.if(target == "PET") {

			jsr PET.StopNote
		}

		rts

	}


	PlayNote: {

		.if(target == "C64") {

			jsr C64.PlayNote
		}
 
		.if(target == "VIC") {

			jsr VIC20.PlayNote
		}

		.if(target == "264") {

			jsr PLUS4.PlayNote
		}

		.if(target == "PET") {

			jsr PET.PlayNote
		}

		rts

	}



	GetNextNote: {

		
		// x = channel
		// y = objectID

		stx CurrentChannel

		lda SongIDs, x
		asl 
		tay
		
		lda SOUND_DATA.DataStart, y
		sta StartAddress
		iny
		lda SOUND_DATA.DataStart, y
		sta StartAddress + 1

		

		lda CurrentNoteID, x
		asl
		tay	


	

		lda (StartAddress), y
		sta CurrentNoteValue, x

		iny
		lda (StartAddress), y
		sta NoteRemaining, x

		
		//.break

		lda CurrentNoteValue, x

		asl
		tax
		lda NoteValues, x
		sta NoteValue
		inx
		lda NoteValues, x
		sta NoteValue + 1

		//.break

		ldx CurrentChannel

		rts
	}





	SetupSID: {

		lda #%00001111 
		sta SID_VOLUME_FILTER



		rts
	}

}