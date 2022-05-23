MAIN:{

#import "lookups/zeropage.asm"
BasicUpstart2(Entry)

*=$0810 "Modules"

#import "lookups/labels.asm"
#import "lookups/vic.asm"
#import "lookups/registers.asm"
#import "interrupts/irq.asm"
#import "interrupts/snout.asm"
#import "interrupts/sprites.asm"
#import "interrupts/blink.asm"
#import "interrupts/input.asm"
#import "setup/macros.asm"
#import "setup/maploader.asm"
#import "interrupts/plot.asm"
#import "interrupts/clouds.asm"
#import "interrupts/score.asm"
#import "interrupts/sound.asm"


GameOverTimer: .byte 0
GameActive: .byte 0
RandomAdd: .byte 0



.label GameOverTimeOut = 180

//exomizer sfx sys -t 64 -x "inc $d020" -o yakf.exo yakf.prg
Entry:
	


	jsr IRQ.DisableCIA
	jsr REGISTERS.BankOutKernalAndBasic


	jsr VIC.SetupRegisters
	jsr VIC.SetupColours


	jsr MAPLOADER.DrawMap

	jsr SOUND.Initialise
	
	jsr Random.init

	jsr ResetGame
	jsr IRQ.SetupInterrupts

	lda #GameOverTimeOut
	sta GameOverTimer
		
	jmp Loop
	

Loop:
	
	
	jmp Loop



ResetGame: {


	lda #BLACK
	sta VIC.BORDER_COLOR 

	jsr SNOUT.Reset
	jsr BLINK.Reset
	jsr SPRITES.Reset
	jsr SCORE.Reset

	lda #ONE
	sta MAIN.GameActive

	rts

}

GameOver: {

	lda #RED
	sta VIC.BORDER_COLOR 

	lda #ZERO
	sta GameActive

	lda #GameOverTimeOut
	sta GameOverTimer

	rts

}




Random: {

	lda $D41B
	//adc ZP_COUNTER
	adc RandomAdd

	rts

    init:
       

        lda #$FF  // maximum frequency value
		sta $D40E //voice 3 frequency low byte
		sta $D40F //voice 3 frequency high byte
		lda #$80  //noise waveform, gate bit off
		sta $D412 //voice 3 control register
		rts


	}

	#import "setup/assets.asm"



}

