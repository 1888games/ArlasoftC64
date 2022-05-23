.var sid = LoadSid("assets/blank.sid")

MAIN: {
	
	#import "/scripts/lookups/zeropage.asm"

	* = $0800 "Upstart"

	PerformFrameCodeFlag:	.byte 0

	BasicUpstart2(Entry)
	* = $080d "End Of Basic"

#import "/scripts/common/macros.asm"
	#import "/scripts/common/sfxTest.asm"
		#import "/scripts/lookups/labels.asm"
	#import "/scripts/lookups/vic.asm"
	


	SoundTimer:	.byte 200
	Sound:	.byte 0


	Entry: {



		jsr DisableCIAInterrupts
		jsr BankOutKernalandBasic
		jsr set_sfx_routine


		jmp Loop
	}
	

	Loop: {

		lda $d012
		cmp #150
		bne Loop

		jsr sid.play

		lda SoundTimer

		beq Ready
		dec SoundTimer
		
		ldx #0

		Loop2:

			nop
			nop
			inx
			cpx #250
			bcc Loop2

		jmp Loop

		Ready:

		lda #200
		sta SoundTimer

		ldx Sound
		stx $0400
		sfxFromX()



		inc Sound




		jmp Loop
	}

	DisableCIAInterrupts: {

		lda #<NMI
		sta $fffa
		lda #>NMI
		sta $fffb

		// prevent CIA interrupts now the kernal is banked out
		lda #$7f
		sta VIC.IRQ_CONTROL_1
		sta VIC.IRQ_CONTROL_2

		lda VIC.IRQ_CONTROL_1
		lda VIC.IRQ_CONTROL_2

		rts

	}

	NMI: {

		rts
	}

		BankOutKernalandBasic:{

		lda PROCESSOR_PORT
		and #%11111000
		ora #%00000101
		sta PROCESSOR_PORT
		rts
	}


.pc = sid.location "sid"
.fill sid.size, sid.getData(i)

	
}