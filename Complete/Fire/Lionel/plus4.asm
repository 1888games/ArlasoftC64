	
.label BaseScreenLocation = $FF14
.label CharMemoryLocation = $FF13

.label Channel1_LSB = $ff0e
.label Channel2_LSB = $ff0f
.label Channel1_MSB = $ff12
.label Channel2_MSB = $ff10
.label TED_CONTROL = $ff11

ChannelOn: .byte  %00010000, %00100000
ChannelOff: .byte %11101111, %11011111

ChannelsLSB: .word Channel1_LSB, Channel2_LSB
ChannelsMSB: .word Channel1_MSB, Channel2_MSB




PLUS4: {	
 


	PlayNote: {


		.if(target == "264") {

		
			.label MSBAddress = VECTOR4
			.label MSBValue = TEMP5

			lda TED_CONTROL
			and ChannelOff, x
			sta TED_CONTROL

			txa
			pha

			asl
			tax

			//MSB
			lda ChannelsMSB, x
			sta MSBAddress	
			inx
			lda ChannelsMSB, x
			sta MSBAddress + 1

			//.break

			lda SOUND.NoteValue + 1

			sta MSBValue
		
			ldy #0
			lda (MSBAddress), y
			and #%11111100
			ora MSBValue
			
			sta (MSBAddress), y

			//LSB
			dex
			lda ChannelsLSB, x
			sta Address + 1
			inx
			lda ChannelsLSB, x
			sta Address + 2

			lda <SOUND.NoteValue

			Address:

			sta $BEEF

			pla
			tax

			lda TED_CONTROL
			ora ChannelOn, x
			sta TED_CONTROL
		

		}



		rts
	}

	StopNote: {


		.if(target == "264") {

			lda TED_CONTROL
			and ChannelOff, x
			sta TED_CONTROL

		}

		rts

	}




}


.macro Set264ScreenMemory (location) {

	.if(target == "264") {

		//.break

		lda #<location
		sta SCREEN_RAM
		lda #>location
		sta SCREEN_RAM + 1

		sec
		sbc #4
		sta COLOR_RAM +1
		sta BaseScreenLocation
		
	}
		

}


.macro Set264CharacterMemory(location) {


	.if(target == "264") {

		lda #%11111011		// set to use ram for characters (bit 2)
		sta $ff12

		lda #>location
		sta CharMemoryLocation

	}




}

.macro Set256CharMode264 () {

	lda $ff07	// screen setup
	ora #%10000000		// set 256-char mode
	sta $ff07
}
