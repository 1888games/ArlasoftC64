.var sid = LoadSid("assets/blank.sid")

MAIN: {

	#import "/scripts/lookups/zeropage.asm"

	* = $0800 "Upstart"

	PerformFrameCodeFlag:	.byte 0

	BasicUpstart2(Entry)
	* = $080d "End Of Basic"


	#import "/scripts/common/macros.asm"
	#import "/scripts/common/sfx.asm"
	#import "/scripts/lookups/labels.asm"
	#import "/scripts/lookups/vic.asm"
	#import "/scripts/game/irq.asm"
	#import "/scripts/game/draw.asm"
	#import "/scripts/common/input.asm"

	#import "/scripts/common/rnd.asm"
	

	* = $a000
	
	#import "/scripts/game/text.asm"
	

	* = $6900 "RoundOver"

	#import "/scripts/game/gypsy.asm"
	

	* = $9d00 "Disk"
		//#import "/scripts/game/disk.asm"
		//#import "/scripts/game/disk2.asm"



	* = $3e00
	* = * "Main"

	GameActive: 			.byte 0
	GameMode:				.byte 0
	MachineType:			.byte 0
	FramesPerSecond:		.byte 50
	


	//exomizer sfx sys -t 64 -x "inc $d020 lda #$7B sta $d011" -o oyup.prg main.prg
	Entry: {

		jsr IRQ.DisableCIAInterrupts
		jsr BankOutKernalandBasic
		jsr set_sfx_routine
		jsr IRQ.Setup
		jsr DetectMachine

		jsr SetupVIC
		

		jmp GYPSY.Show
		
	}
   
	DetectMachine: {

		w0:  lda $D012
		w1:  cmp $D012
	    beq w1
	    bmi w0
	    and #$03
	    sta MAIN.MachineType

	    cmp #2
	    bne PAL

	    NTSC:

	    lda #60
	    sta FramesPerSecond

	    jmp Finish
	  
	    PAL:


	    Finish:

	    rts

	}






	SetupVIC: {  

		//Set VIC BANK 3, last two bits = 00
		lda VIC.BANK_SELECT
		
		and #%11111100
		sta VIC.BANK_SELECT

		// multicolour mode on
		lda VIC.SCREEN_CONTROL_2
		and #%01101111
		ora #%00010000
		sta VIC.SCREEN_CONTROL_2

		lda #%00001100
		sta VIC.MEMORY_SETUP	

		rts


	}


	Loop: {

		lda PerformFrameCodeFlag
		beq Loop

		dec PerformFrameCodeFlag

		jmp Loop
	}





	BankOutKernalandBasic:{

		lda PROCESSOR_PORT
		and #%11111000
		ora #%00000101
		sta PROCESSOR_PORT
		rts
	}



	BankInKernal: {

		lda PROCESSOR_PORT
		and #%11111000
		ora #%00000110
		sta PROCESSOR_PORT
		rts

	}

	#import "/scripts/game/assets.asm"




}  