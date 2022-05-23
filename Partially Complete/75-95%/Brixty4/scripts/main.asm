MAIN:{

#import "lookups/zeropage.asm"
BasicUpstart2(Entry)

*=$0810 "Modules"

#import "lookups/labels.asm"
#import "lookups/vic.asm"
#import "lookups/sid.asm"
#import "lookups/registers.asm"
#import "interrupts/irq.asm"


#import "interrupts/input.asm"
#import "setup/macros.asm"
#import "setup/maploader.asm"
#import "interrupts/plot.asm"
#import "interrupts/score.asm"
#import "interrupts/lives.asm"
#import "interrupts/sound.asm"
#import "interrupts/random.asm"
#import "interrupts/block.asm"
#import "interrupts/mouse.asm"


GameOverTimer: .byte 0
GameActive: .byte 0
LifeLostTimer: .byte 0

MachineType: .byte 0



.label GameOverTimeOut = 180
.label LifeLostTimeOut = 30


//exomizer sfx sys -t 64 -x "inc $d020" -o yakf.exo yakf.prg
Entry:
	
	

	jsr IRQ.DisableCIA
	jsr REGISTERS.BankOutKernalAndBasic


	jsr VIC.SetupRegisters
	jsr VIC.SetupColours


	jsr SOUND.Initialise
	jsr MOUSE.Initialise
	
	jsr RANDOM.init

	jsr DetectMachine
	jsr ResetGame
	jsr IRQ.SetupInterrupts

	lda #GameOverTimeOut
	sta GameOverTimer



	Finish:


		
	jmp Loop


DetectMachine: {

	w0:  lda $D012
	w1:  cmp $D012
    beq w1
    bmi w0
    and #$03
    sta MachineType

    cmp #2
    bne PAL

    NTSC:

    lda #60
    sta BLOCK.SecondTimer + 1

    lda #19
    sta BLOCK.FramesPerSection

    lda #216
    sta BLOCK.FreezeTime

    lda #2
    sta MOUSE.MoveSpeed

    PAL:

    rts


}
	

Loop:
	
	
	jmp Loop




CheckLifeLost: {



	lda LifeLostTimer
	beq Finish

	dec LifeLostTimer
	bne Finish

	lda #BLACK
	sta $d020



	Finish:

		rts
}

ResetGame: {


	lda #BLACK
	sta VIC.BORDER_COLOR 

	jsr SCORE.Reset
	jsr LIVES.Reset
	jsr MAPLOADER.DrawMap
	jsr BLOCK.Reset


	lda #ONE
	sta MAIN.GameActive



	rts

}

GameOver: {

	lda #RED
	sta VIC.BORDER_COLOR 

	lda #GameOverTimeOut
	sta GameOverTimer

	lda #ZERO
	sta GameActive



	rts

}





#import "setup/assets.asm"
}