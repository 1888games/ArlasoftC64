	

.label Memory_Setup_Register = $d018

C64: {
	
	.label IRQControlRegister1 = $dc0d
	.label IRQControlRegister2 = $dd0d
	.label Processor_Port = $01
	.label Serial_Bus_Port_A = $dd00

	Frequency: .word $d400, $d407, $d40e
	FrequencyMSB: .word $d401, $d408, $d40f
	Pulse_Width: .word $d402, $d409, $d410
	AttDec: .word $d405, $d40c, $d413
	Sustain: .word $d406, $d40d, $d414
	Control: .word $d404, $d40b, $d412

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

	.label VOICE_3_FREQUENCY = $d40e		// & $d401
	.label VOICE_3_PULSE_WIDTH = $d410	// & $d403
	.label VOICE_3_CONTROL = $d412		// Noise, Rect, Saw, Tri, Reset, Ring, Sync, On/off
	.label VOICE_3_ATTDEC = $d413		// Attack 4-bits Decay 4-bits
	.label VOICE_3_SUSTAIN = $d414 	// Volume 4-bits Release 4-bits





	PlayNote: {

		.if(target == "C64") {

		
			txa
			asl
			tax


			//MSB
			lda Control, x
			sta SetControl + 1

			lda AttDec, x
			sta SetAttDec + 1

			lda Sustain, x
			sta SetSustain + 1

			lda Frequency, x
			sta SetFrequency + 1

			
			lda FrequencyMSB, x
			sta SetFrequencyMSB + 1

			inx
			lda Control, x
			sta SetControl + 2

			lda AttDec, x
			sta SetAttDec + 2

			lda Sustain, x
			sta SetSustain + 2

			lda Frequency, x
			sta SetFrequency + 2

			lda FrequencyMSB, x
			sta SetFrequencyMSB + 2

			ldy #0

			lda #%00100001

			SetControl:

				sta $BEEF

			lda #%00000101

			SetAttDec: 

				sta $BEEF

			lda #%11110011

			SetSustain:

				sta $BEEF

			lda SOUND.NoteValue

			SetFrequency:

				sta $BEEF

			lda SOUND.NoteValue + 1

			SetFrequencyMSB:

				sta $BEEF

			dex
			txa
			lsr
			tax

			Finish:



		}

		rts
	}


	StopNote: {


		.if(target == "C64") {

		
			txa
			asl
			tax


			//MSB
			lda Control, x
			sta SetControl + 1

			inx
			lda Control, x
			sta SetControl + 2

			lda Sustain, x
			sta SetSustain + 2

			lda #%00100000

			SetControl:

				sta $BEEF

			lda #%00000000

			SetSustain:

				sta $BEEF


			dex
			txa
			lsr
			tax

			Finish:

		}

		rts
	}

	DisableCIA: {

		.if(target == "C64") {

		// prevent CIA interrupts now the kernal is banked out
			lda #$7f
			sta IRQControlRegister1
			sta IRQControlRegister2
		}

		rts

	}


	BankOutKernalAndBasic:{

		.if(target == "C64") {

			lda Processor_Port
			and #%11111000
			ora #%00000101
			sta Processor_Port

		}

		rts
	}


	SetC64VICBank: {

		.if(target == "C64") {


			.label ValueToSave = TEMP1

			sta ValueToSave

			lda C64.Serial_Bus_Port_A
			and #%11111100
			ora ValueToSave
			sta C64.Serial_Bus_Port_A

		}

		rts

	}




}



 

.macro SetC64VICBank(value) {

		.if (target == "C64") {

			Lookup: .byte 3, 2, 1, 0
			.label ValueToSave = TEMP1

			ldx #value
			lda Lookup, x
			sta ValueToSave

			lda ValueToSave

			lda C64.Serial_Bus_Port_A
			and #%11111100
			ora ValueToSave
			sta C64.Serial_Bus_Port_A

			lda #0
			sta C64.Serial_Bus_Port_A


		}


}


.macro SetC64ScreenMemory (location) {

	.if(target == "C64") {

		lda #<location
		sta SCREEN_RAM
		lda #>location
		sta SCREEN_RAM + 1

		.label ShiftedPointer = TEMP1
		lda #C64ScreenRamLocations.get(location)
		asl
		asl
		asl
		asl
		sta ShiftedPointer

		lda Memory_Setup_Register
		and #%00001111
		ora ShiftedPointer
		sta Memory_Setup_Register

		lda #C64ScreenRamBanks.get(location)

		jsr C64.SetC64VICBank

	}

	
}


.macro SetC64CharacterMemory (location) {

	.if(target == "C64") {

		.label ShiftedPointer = TEMP1
		lda #C64CharRamLocations.get(location)
		asl
		sta ShiftedPointer

		lda Memory_Setup_Register
		and #%11110001
		ora ShiftedPointer
		sta Memory_Setup_Register

	}

	
}

	.var C64ScreenRamLocations = Hashtable()
	.var C64ScreenRamBanks = Hashtable()
	.var C64CharRamLocations = Hashtable()
	.var NoteValuesC64 = Hashtable()

	.var currentAddress = $0000
	.var currentBank = 0

	.if(target == "C64") {

	.eval C64ScreenRamLocations.put($0000, 0)
	.eval C64ScreenRamLocations.put($0400, 1)
	.eval C64ScreenRamLocations.put($0800, 2)
	.eval C64ScreenRamLocations.put($0C00, 3)
	.eval C64ScreenRamLocations.put($1000, 4)
	.eval C64ScreenRamLocations.put($1400, 5)
	.eval C64ScreenRamLocations.put($1800, 6)
	.eval C64ScreenRamLocations.put($1C00, 7)
	.eval C64ScreenRamLocations.put($2000, 8)
	.eval C64ScreenRamLocations.put($2400, 9)
	.eval C64ScreenRamLocations.put($2800, 10)
	.eval C64ScreenRamLocations.put($2C00, 11)
	.eval C64ScreenRamLocations.put($3000, 12)
	.eval C64ScreenRamLocations.put($3400, 13)
	.eval C64ScreenRamLocations.put($3000, 14)
	.eval C64ScreenRamLocations.put($3400, 15)
	.eval C64ScreenRamLocations.put($3800, 14)
	.eval C64ScreenRamLocations.put($3C00, 15)

	.eval C64ScreenRamLocations.put($0000 + $4000, 0)
	.eval C64ScreenRamLocations.put($0400 + $4000, 1)
	.eval C64ScreenRamLocations.put($0800 + $4000, 2)
	.eval C64ScreenRamLocations.put($0C00 + $4000, 3)
	.eval C64ScreenRamLocations.put($1000 + $4000, 4)
	.eval C64ScreenRamLocations.put($1400 + $4000, 5)
	.eval C64ScreenRamLocations.put($1800 + $4000, 6)
	.eval C64ScreenRamLocations.put($1C00 + $4000, 7)
	.eval C64ScreenRamLocations.put($2000 + $4000, 8)
	.eval C64ScreenRamLocations.put($2400 + $4000, 9)
	.eval C64ScreenRamLocations.put($2800 + $4000, 10)
	.eval C64ScreenRamLocations.put($2C00 + $4000, 11)
	.eval C64ScreenRamLocations.put($3000 + $4000, 12)
	.eval C64ScreenRamLocations.put($3400 + $4000, 13)
	.eval C64ScreenRamLocations.put($3800 + $4000, 14)
	.eval C64ScreenRamLocations.put($3C00 + $4000, 15)

	.eval C64ScreenRamLocations.put($0000 + $8000, 0)
	.eval C64ScreenRamLocations.put($0400 + $8000, 1)
	.eval C64ScreenRamLocations.put($0800 + $8000, 2)
	.eval C64ScreenRamLocations.put($0C00 + $8000, 3)
	.eval C64ScreenRamLocations.put($1000 + $8000, 4)
	.eval C64ScreenRamLocations.put($1400 + $8000, 5)
	.eval C64ScreenRamLocations.put($1800 + $8000, 6)
	.eval C64ScreenRamLocations.put($1C00 + $8000, 7)
	.eval C64ScreenRamLocations.put($2000 + $8000, 8)
	.eval C64ScreenRamLocations.put($2400 + $8000, 9)
	.eval C64ScreenRamLocations.put($2800 + $8000, 10)
	.eval C64ScreenRamLocations.put($2C00 + $8000, 11)
	.eval C64ScreenRamLocations.put($3000 + $8000, 12)
	.eval C64ScreenRamLocations.put($3400 + $8000, 13)
	.eval C64ScreenRamLocations.put($3800 + $8000, 14)
	.eval C64ScreenRamLocations.put($3C00 + $8000, 15)

	.eval C64ScreenRamLocations.put($0000 + $C000, 0)
	.eval C64ScreenRamLocations.put($0400 + $C000, 1)
	.eval C64ScreenRamLocations.put($0800 + $C000, 2)
	.eval C64ScreenRamLocations.put($0C00 + $C000, 3)
	.eval C64ScreenRamLocations.put($1000 + $C000, 4)
	.eval C64ScreenRamLocations.put($1400 + $C000, 5)
	.eval C64ScreenRamLocations.put($1800 + $C000, 6)
	.eval C64ScreenRamLocations.put($1C00 + $C000, 7)
	.eval C64ScreenRamLocations.put($2000 + $C000, 8)
	.eval C64ScreenRamLocations.put($2400 + $C000, 9)
	.eval C64ScreenRamLocations.put($2800 + $C000, 10)
	.eval C64ScreenRamLocations.put($2C00 + $C000, 11)
	.eval C64ScreenRamLocations.put($3000 + $C000, 12)
	.eval C64ScreenRamLocations.put($3400 + $C000, 13)
	.eval C64ScreenRamLocations.put($3800 + $C000, 14)
	.eval C64ScreenRamLocations.put($3C00 + $C000, 15)

	.eval C64ScreenRamBanks.put($0000, 3)
	.eval C64ScreenRamBanks.put($0400, 3)
	.eval C64ScreenRamBanks.put($0800, 3)
	.eval C64ScreenRamBanks.put($0C00, 3)
	.eval C64ScreenRamBanks.put($1000, 3)
	.eval C64ScreenRamBanks.put($1400, 3)
	.eval C64ScreenRamBanks.put($1800, 3)
	.eval C64ScreenRamBanks.put($1C00, 3)
	.eval C64ScreenRamBanks.put($2000, 3)
	.eval C64ScreenRamBanks.put($2400, 3)
	.eval C64ScreenRamBanks.put($2800, 3)
	.eval C64ScreenRamBanks.put($2C00, 3)
	.eval C64ScreenRamBanks.put($3000, 3)
	.eval C64ScreenRamBanks.put($3400, 3)
	.eval C64ScreenRamBanks.put($3000, 3)
	.eval C64ScreenRamBanks.put($3400, 3)
	.eval C64ScreenRamBanks.put($3800, 3)
	.eval C64ScreenRamBanks.put($3C00, 3)

	.eval C64ScreenRamBanks.put($0000 + $4000, 2)
	.eval C64ScreenRamBanks.put($0400 + $4000, 2)
	.eval C64ScreenRamBanks.put($0800 + $4000, 2)
	.eval C64ScreenRamBanks.put($0C00 + $4000, 2)
	.eval C64ScreenRamBanks.put($1000 + $4000, 2)
	.eval C64ScreenRamBanks.put($1400 + $4000, 2)
	.eval C64ScreenRamBanks.put($1800 + $4000, 2)
	.eval C64ScreenRamBanks.put($1C00 + $4000, 2)
	.eval C64ScreenRamBanks.put($2000 + $4000, 2)
	.eval C64ScreenRamBanks.put($2400 + $4000, 2)
	.eval C64ScreenRamBanks.put($2800 + $4000, 2)
	.eval C64ScreenRamBanks.put($2C00 + $4000, 2)
	.eval C64ScreenRamBanks.put($3000 + $4000, 2)
	.eval C64ScreenRamBanks.put($3400 + $4000, 2)
	.eval C64ScreenRamBanks.put($3800 + $4000, 2)
	.eval C64ScreenRamBanks.put($3C00 + $4000, 2)

	.eval C64ScreenRamBanks.put($0000 + $8000, 1)
	.eval C64ScreenRamBanks.put($0400 + $8000, 1)
	.eval C64ScreenRamBanks.put($0800 + $8000, 1)
	.eval C64ScreenRamBanks.put($0C00 + $8000, 1)
	.eval C64ScreenRamBanks.put($1000 + $8000, 1)
	.eval C64ScreenRamBanks.put($1400 + $8000, 1)
	.eval C64ScreenRamBanks.put($1800 + $8000, 1)
	.eval C64ScreenRamBanks.put($1C00 + $8000, 1)
	.eval C64ScreenRamBanks.put($2000 + $8000, 1)
	.eval C64ScreenRamBanks.put($2400 + $8000, 1)
	.eval C64ScreenRamBanks.put($2800 + $8000, 1)
	.eval C64ScreenRamBanks.put($2C00 + $8000, 1)
	.eval C64ScreenRamBanks.put($3000 + $8000, 1)
	.eval C64ScreenRamBanks.put($3400 + $8000, 1)
	.eval C64ScreenRamBanks.put($3800 + $8000, 1)
	.eval C64ScreenRamBanks.put($3C00 + $8000, 1)

	.eval C64ScreenRamBanks.put($0000 + $C000, 0)
	.eval C64ScreenRamBanks.put($0400 + $C000, 0)
	.eval C64ScreenRamBanks.put($0800 + $C000, 0)
	.eval C64ScreenRamBanks.put($0C00 + $C000, 0)
	.eval C64ScreenRamBanks.put($1000 + $C000, 0)
	.eval C64ScreenRamBanks.put($1400 + $C000, 0)
	.eval C64ScreenRamBanks.put($1800 + $C000, 0)
	.eval C64ScreenRamBanks.put($1C00 + $C000, 0)
	.eval C64ScreenRamBanks.put($2000 + $C000, 0)
	.eval C64ScreenRamBanks.put($2400 + $C000, 0)
	.eval C64ScreenRamBanks.put($2800 + $C000, 0)
	.eval C64ScreenRamBanks.put($2C00 + $C000, 0)
	.eval C64ScreenRamBanks.put($3000 + $C000, 0)
	.eval C64ScreenRamBanks.put($3400 + $C000, 0)
	.eval C64ScreenRamBanks.put($3800 + $C000, 0)
	.eval C64ScreenRamBanks.put($3C00 + $C000, 0)

	.eval C64CharRamLocations.put($0000, 0)
	.eval C64CharRamLocations.put($0800, 1)
	.eval C64CharRamLocations.put($1000, 2)
	.eval C64CharRamLocations.put($1800, 3)
	.eval C64CharRamLocations.put($2000, 4)
	.eval C64CharRamLocations.put($2800, 5)
	.eval C64CharRamLocations.put($3000, 6)
	.eval C64CharRamLocations.put($3800, 7)

	.eval C64CharRamLocations.put($0000 + $4000, 0)
	.eval C64CharRamLocations.put($0800 + $4000, 1)
	.eval C64CharRamLocations.put($1000 + $4000, 2)
	.eval C64CharRamLocations.put($1800 + $4000, 3)
	.eval C64CharRamLocations.put($2000 + $4000, 4)
	.eval C64CharRamLocations.put($2800 + $4000, 5)
	.eval C64CharRamLocations.put($3000 + $4000, 6)
	.eval C64CharRamLocations.put($3800 + $4000, 7)

	.eval C64CharRamLocations.put($0000 + $8000, 0)
	.eval C64CharRamLocations.put($0800 + $8000, 1)
	.eval C64CharRamLocations.put($1000 + $8000, 2)
	.eval C64CharRamLocations.put($1800 + $8000, 3)
	.eval C64CharRamLocations.put($2000 + $8000, 4)
	.eval C64CharRamLocations.put($2800 + $8000, 5)
	.eval C64CharRamLocations.put($3000 + $8000, 6)
	.eval C64CharRamLocations.put($3800 + $8000, 7)

	.eval C64CharRamLocations.put($0000 + $C000, 0)
	.eval C64CharRamLocations.put($0800 + $C000, 1)
	.eval C64CharRamLocations.put($1000 + $C000, 2)
	.eval C64CharRamLocations.put($1800 + $C000, 3)
	.eval C64CharRamLocations.put($2000 + $C000, 4)
	.eval C64CharRamLocations.put($2800 + $C000, 5)
	.eval C64CharRamLocations.put($3000 + $C000, 6)
	.eval C64CharRamLocations.put($3800 + $C000, 7)

}




