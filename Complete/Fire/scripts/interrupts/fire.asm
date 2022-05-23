FIRE: {


	SmokePosition: .byte 0


	.label StartFireCharacter = $F008 //CHAR_SET + (192 * 8)
	.label CooldownTime = 8

	.label SmokeObjectId = 29 
	.label MaxSmokePosition = 4
	.label SmokecooldownTime =1


	.label StartFireCharacter264 = $2808

	Cooldown: .byte 8

	SmokeCooldown: .byte 3

	Update: {

			
		lda SmokeCooldown
		beq Shift

		dec SmokeCooldown
		jmp Finish

		Shift:

			lda #SmokecooldownTime
			sta SmokeCooldown

			lda SmokePosition
			clc
			adc #SmokeObjectId

			tax
			ldy #0

			jsr CHAR_DRAWING.ColourObject

			lda SmokePosition
			clc
			adc #01
			cmp #MaxSmokePosition

			bne NoWrap
			
			lda #0 

		NoWrap:

		sta SmokePosition

		clc
		adc #SmokeObjectId
		tax

		ldy #1

		jsr CHAR_DRAWING.ColourObject

		Finish:

			//dec $d020

			rts



	}



	UpdateFire: {

		lda Cooldown
		beq Shift

		dec Cooldown
		jmp Finish


		Shift:

		lda #CooldownTime
		sta Cooldown

		//lda $F008

		ldx #0

		Loop:

			.if(target == "C64") {
				lda StartFireCharacter, x
			}

			.if(target == "264") {
				lda StartFireCharacter264, x
			}







			lsr
			bcc NoAdd
 
			clc
			adc #128

			NoAdd:

			.if(target == "C64") {
				sta StartFireCharacter, x
			}

			.if(target == "264") {
				sta StartFireCharacter264, x
			}


			inx
			cpx #32
			beq Finish
			jmp Loop


		Finish:



		rts


	}

}