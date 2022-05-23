
.var sid = LoadSid("../assets/sfx/blank.sid")


MAIN:{

#import "lookups/zeropage.asm"
BasicUpstart2(Entry)

*=$1000 "Modules"

#import "lookups/labels.asm"
#import "lookups/vic.asm"
#import "lookups/registers.asm"
#import "interrupts/irq.asm"


#import "interrupts/input.asm"
#import "setup/macros.asm"
#import "setup/maploader.asm"
#import "interrupts/plot.asm"
#import "interrupts/score.asm"
#import "interrupts/random.asm"
#import "interrupts/sfx.asm"
#import "interrupts/ship.asm"
#import "interrupts/bullet.asm"
#import "interrupts/energy.asm"

*= $5000
#import "interrupts/lives.asm"
#import "interrupts/enemies.asm"
#import "interrupts/reset.asm"
#import "interrupts/logo.asm"


GameOverTimer: .byte 0
GameActive: .byte 0
LifeLostTimer: .byte 0
PerformFrameCodeFlag:	.byte 0
GameIsOver:	.byte 0
InitialCooldown: .byte 30, 30

MachineType: .byte 0
 
 
.label GameOverTimeOut = 120
.label LifeLostTimeOut = 307

ScreenColour:	.byte 0

Difficulty:	.byte 0	// 0 = Bullet 
Players:	.byte 1
BulletSpeed:  .byte 0
AutoFire: .byte 1

GameOverSequenceID: .byte 0
GameOverSequences:	.byte 2

Yes:	.byte 28, 8, 22
No:		.byte 176, 177
One:	.byte 18, 17, 8
Two:	.byte 182, 185, 177

//exomizer sfx sys -t 64 -x "inc $d020" -o yakf.exo yakf.prg
Entry:
	
	lda #0
	jsr sid.init

	jsr set_sfx_routine

	jsr IRQ.DisableCIA
	jsr REGISTERS.BankOutKernalAndBasic

	jsr VIC.SetupRegisters
	jsr VIC.SetupColours
	jsr RANDOM.init
  
	jsr DetectMachine
	
	jsr IRQ.SetupInterrupts


	Finish:


	//jmp Instructions
		
	//jmp StartGame
	jmp TitleScreen

 
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

     jmp Finish
  
    PAL:


    Finish:

    rts


}
	
 
Loop: {

		lda PerformFrameCodeFlag
		beq Loop

		jmp FrameCode

}




FrameCode: {

	lda #0
	sta PerformFrameCodeFlag

	//jsr SCORE.CheckScoreToAdd

	lda GameActive
	beq GamePaused

	jmp Loop

	GamePaused:

		lda GameIsOver
		beq Loop

		lda GameOverTimer
		bne Loop

		lda #GameOverTimeOut
		sta GameOverTimer

		jmp GameOverLoop


}	
 





StartGame: {

	jsr GameScreen
	jmp Loop


}


GameScreen:{

	lda #ALL_ON
	sta VIC.SPRITE_ENABLE

	lda #%00001100
	sta VIC.MEMORY_SETUP

 	lda VIC.SCREEN_CONTROL_2
 	and #%11101111
 	ora #%00010000
 	sta VIC.SCREEN_CONTROL_2

	lda #BLACK
	sta VIC.BACKGROUND_COLOR
	lda #BLACK
	sta VIC.BORDER_COLOR

 	lda #0
 	sta MAPLOADER.CurrentMapID

	 
	lda #YELLOW
	sta VIC.EXTENDED_BG_COLOR_1
 	lda #LIGHT_GREY
 	sta VIC.EXTENDED_BG_COLOR_2

	jsr MAPLOADER.DrawMap

    ldx #0
	lda #0

	Loop:
		sta SCREEN_RAM, x
		inx
		cpx #40
		beq Done
		jmp Loop

	Done:


	jsr LOGO.GrabCharacters

	lda #1
	sta LOGO.Active


	jsr ResetGame

	rts	

}



TitleScreen: {



	lda InitialCooldown + 1
	sta InitialCooldown

	lda #1
	sta MAPLOADER.CurrentMapID

	lda #0
	sta GameActive
	sta VIC.SPRITE_ENABLE
	sta LOGO.Active

	lda #%00001110
	sta VIC.MEMORY_SETUP

	lda #BLACK
	sta VIC.BACKGROUND_COLOR
	lda #BLACK
	sta VIC.BORDER_COLOR

	lda #RED
	sta VIC.EXTENDED_BG_COLOR_1
	lda #YELLOW
	sta VIC.EXTENDED_BG_COLOR_2

//multicolour mode on7
	lda VIC.SCREEN_CONTROL_2
	and #%11101111
 	ora #%00010000
 	sta VIC.SCREEN_CONTROL_2

 	sfx(4)


	jsr MAPLOADER.DrawMap	

	lda SCREEN_RAM
	tay

	lda VIC.COLOR_RAM

	//.break

 	ldx #0
	lda #0

	Loop:

		lda #0
		sta SCREEN_RAM, x

		lda #$5E
		sta VIC.COLOR_RAM, x


		inx
		cpx #40
		beq Done
		jmp Loop

	Done:



	jmp TitleLoop
}



Instructions:{

	sfx(6)

	lda InitialCooldown + 1
	sta InitialCooldown

	lda VIC.SCREEN_CONTROL
	and #%11101111
	sta VIC.SCREEN_CONTROL

	lda #%00001010
	sta VIC.MEMORY_SETUP


	//ldx #
	//jsr VIC.ColourLastRow

	lda #BLACK
	sta VIC.BORDER_COLOR

	lda #RED
	sta VIC.EXTENDED_BG_COLOR_1
	lda #YELLOW
	sta VIC.EXTENDED_BG_COLOR_2


	lda #2
	sta MAPLOADER.CurrentMapID

	lda VIC.SCREEN_CONTROL_2
	and #%11101111
 	ora #%00010000
 	sta VIC.SCREEN_CONTROL_2


	jsr MAPLOADER.DrawMap	

	ldx #0
	lda #0

	Loop:
		sta SCREEN_RAM + 960, x
		inx
		cpx #40
		beq Done
		jmp Loop

	Done:

	//jsr VIC.ColourTextRow

	WaitForRaster:
		lda $d012
		cmp #1
		beq ShowScreen
		jmp WaitForRaster

	ShowScreen:

		lda VIC.SCREEN_CONTROL
		ora #%00010001
		sta VIC.SCREEN_CONTROL


	jmp InstructionsLoop

}



InstructionsLoop:{

	jsr sid.play

	lda InitialCooldown
	beq Okay

	dec InitialCooldown
	jmp WaitForRaster

	Okay:

	lda REGISTERS.JOY_PORT_2
	and #JOY_FIRE
	bne NotFire

	jmp StartGame

	NotFire:


	lda REGISTERS.JOY_PORT_2
	and #JOY_LEFT
	bne NotMissiles

	jmp Missiles

	NotMissiles:

	lda REGISTERS.JOY_PORT_2
	and #JOY_RIGHT
	bne NotCurve

	jmp Curve

	NotCurve:

	lda REGISTERS.JOY_PORT_2
	and #JOY_UP
	beq DoAutoFire


	lda REGISTERS.JOY_PORT_2
	and #JOY_DOWN
	beq NumPlayers

	jmp WaitForRaster



	NumPlayers:

		lda Players
		cmp #1
		beq Set2Player

		Set1Player:

			lda #5
			sta VIC.COLOR_RAM + 782
			sta VIC.COLOR_RAM + 783
			sta VIC.COLOR_RAM + 784

			lda One
			sta SCREEN_RAM + 782

			lda One + 1
			sta SCREEN_RAM + 783

			lda One + 2
			sta SCREEN_RAM + 784

			lda #1
			sta Players
		
			jmp Delay

		Set2Player:


			lda #7
			sta VIC.COLOR_RAM + 782
			sta VIC.COLOR_RAM + 783
			sta VIC.COLOR_RAM + 784

			lda Two
			sta SCREEN_RAM + 782

			lda Two + 1
			sta SCREEN_RAM + 783

			lda Two + 2
			sta SCREEN_RAM + 784

			lda #2
			sta Players

			jmp Delay



	DoAutoFire:

		lda AutoFire
		bne SetAutoNo

		SetAutoYes:

			lda #5
			sta VIC.COLOR_RAM + 622
			sta VIC.COLOR_RAM + 623
			sta VIC.COLOR_RAM + 624

			lda Yes
			sta SCREEN_RAM + 622

			lda Yes + 1
			sta SCREEN_RAM + 623

			lda Yes + 2
			sta SCREEN_RAM + 624

			lda #1
			sta AutoFire
		
			jmp Delay

		SetAutoNo:


			lda #2
			sta VIC.COLOR_RAM + 622
			sta VIC.COLOR_RAM + 623
			sta VIC.COLOR_RAM + 624

			lda No
			sta SCREEN_RAM + 622

			lda No + 1
			sta SCREEN_RAM + 623

			lda #0
			sta SCREEN_RAM + 624
			sta AutoFire

			jmp Delay



	Curve:

		
		lda Difficulty
		beq SetCurveNo

		SetCurveYes:

			lda #5
			sta VIC.COLOR_RAM + 462
			sta VIC.COLOR_RAM + 463
			sta VIC.COLOR_RAM + 464

			lda Yes
			sta SCREEN_RAM + 462

			lda Yes + 1
			sta SCREEN_RAM + 463

			lda Yes + 2
			sta SCREEN_RAM + 464

			lda #0
			sta Difficulty
		
			jmp Delay

		SetCurveNo:


			lda #2
			sta VIC.COLOR_RAM + 462
			sta VIC.COLOR_RAM + 463
			sta VIC.COLOR_RAM + 464

			lda No
			sta SCREEN_RAM + 462

			lda No + 1
			sta SCREEN_RAM + 463

			lda #0
			sta SCREEN_RAM + 464

			lda #1
			sta Difficulty

			jmp Delay


	Missiles:

		lda BulletSpeed
		beq SetBulletNo

		SetBulletYes:

			lda #5
			sta VIC.COLOR_RAM + 302
			sta VIC.COLOR_RAM + 303
			sta VIC.COLOR_RAM + 304

			lda Yes
			sta SCREEN_RAM + 302

			lda Yes + 1
			sta SCREEN_RAM + 303

			lda Yes + 2
			sta SCREEN_RAM + 304

			lda #0
			sta BulletSpeed
		
			jmp Delay

		SetBulletNo:

			lda #2
			sta VIC.COLOR_RAM + 302
			sta VIC.COLOR_RAM + 303
			sta VIC.COLOR_RAM + 304

			lda No
			sta SCREEN_RAM + 302

			lda No + 1
			sta SCREEN_RAM + 303

			lda #0
			sta SCREEN_RAM + 304

			lda #1
			sta BulletSpeed


			jmp Delay

		//sta //GameMode
		jmp StartGame


	Delay:

	lda #25
	sta InitialCooldown

	WaitForRaster:
		lda $d012
		cmp #100
		bne WaitForRaster
		jmp InstructionsLoop



}



TitleLoop: {

	jsr sid.play

	lda InitialCooldown
	beq Okay

	dec InitialCooldown
	jmp WaitForRaster

	Okay:

	lda REGISTERS.JOY_PORT_2
	and #JOY_FIRE
	bne WaitForRaster

	jmp Instructions

	WaitForRaster:
		lda $d012
		cmp #100
		beq TitleLoop

		jmp WaitForRaster

}




ResetGame: {



	lda ScreenColour
	sta VIC.BORDER_COLOR 

	lda ScreenColour
	sta VIC.BACKGROUND_COLOR


	jsr SHIP.NewGame
	jsr ENERGY.NewGame
	jsr BULLET.Reset
	jsr ENERGY.Reset
	jsr LIVES.Reset
	jsr ENEMIES.Reset
	jsr SCORE.DisplayBest


	lda #ONE
	sta MAIN.GameActive

	lda #ZERO
	sta MAIN.GameIsOver
	sta SCORE.ScoreInitialised





	rts

}

GameOver: {

	
	lda #15
	sta GameOverTimer

	lda #ZERO
	sta GameActive
	sta VIC.SPRITE_ENABLE
	sta GameOverSequenceID
	sta ENEMIES.EnemiesReady


	ldx #0	// reset sprite positions so that unused sprites won't be seen
	stx VIC.SPRITE_0_X + 2
	stx VIC.SPRITE_0_X + 4			
	stx VIC.SPRITE_0_X + 6
	stx VIC.SPRITE_0_X + 8
	stx VIC.SPRITE_0_X + 10
	stx VIC.SPRITE_0_X + 12
	stx VIC.SPRITE_0_X + 14

	lda VIC.SPRITE_MSB
	and #%00000001		// reset MSB positions
	sta VIC.SPRITE_MSB

	lda #ONE
	sta GameIsOver
	sta SHIP.Paused
	sta LOGO.Active

	lda Players
	sta GameOverSequences
	inc GameOverSequences



	rts

}



GameOverLoop: {

	jsr sid.play

	lda GameOverTimer
	beq UpdateGameOver

	dec GameOverTimer
	jmp Okay

	UpdateGameOver:

		lda #GameOverTimeOut
		sta GameOverTimer


		lda GameOverSequenceID
		beq DisplayBest

		cmp #01
		beq DisplayPlayer1

		DisplayPlayer2:

			lda #1
			sta SHIP.CurrentPlayer
			jsr ENERGY.UpdateColours
			jsr SCORE.CopyScoreIn
			jmp IncreaseID

		DisplayPlayer1:

			lda #0
			sta SHIP.CurrentPlayer
			jsr ENERGY.UpdateColours
			jsr SCORE.CopyScoreIn
			jmp IncreaseID

		DisplayBest:

			jsr SCORE.DisplayBest

	IncreaseID:

		inc GameOverSequenceID
		lda GameOverSequenceID
		cmp GameOverSequences
		bne Okay

		lda #0
		sta GameOverSequenceID

	Okay:


	lda REGISTERS.JOY_PORT_2
	and #JOY_FIRE
	bne WaitForRaster

	jmp TitleScreen

	WaitForRaster:
		lda $d012
		cmp #100
		beq GameOverLoop

		jmp WaitForRaster

}



#import "setup/assets.asm"
}