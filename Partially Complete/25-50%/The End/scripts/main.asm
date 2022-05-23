
.var sid = LoadSid("../assets/sfx/blank.sid")

MAIN:{

#import "lookups/zeropage.asm"
BasicUpstart2(Entry)
 


#import "game/locals.asm"

*= $080d "Modules"
#import "lookups/labels.asm"
#import "lookups/vic.asm"
#import "lookups/registers.asm"
#import "game/irq.asm"
#import "common/input.asm"
#import "common/macros.asm"
#import "common/maploader.asm"
#import "common/plot.asm"
#import "game/score.asm"
#import "common/random.asm"
#import "common/sfx.asm"
#import "game/control.asm"
#import "game/draw.asm"
#import "common/text.asm"
#import "game/lives.asm"
#import "game/title.asm"
#import "game/stars.asm"
#import "game/mothership.asm"
#import "game/player.asm"
#import "game/enemies.asm"
#import "game/enemy_draw.asm"
#import "game/blocks.asm"


GameOverTimer: 			.byte 0
GameActive: 			.byte 0
PerformFrameCodeFlag:	.byte 0
GameIsOver:	.byte 0
Credits:	.byte 0
Players:	.byte 17
Timeout:	.byte 15

 
.label GameOverTimeOut = 120

.label LifeLostTimeOut = 30


//exomizer sfx sys -t 64 -x "inc $d020" -o yakf.exo yakf.prg
Entry: {
	
	jsr IRQ.DisableCIA 
	jsr REGISTERS.BankOutKernalAndBasic

	jsr VIC.SetupRegisters
	jsr RANDOM.init

	jsr IRQ.SetupInterrupts
	
	jsr set_sfx_routine

	Finish:
		
	//jmp TitleScreen
	jmp StartGame

}




TitleLoop: {	


	WaitForRaster:

		lda VIC.RASTER_Y
		cmp #250
		bne WaitForRaster

	Okay:

		jsr TITLE.FrameUpdate

		ldy #1

		lda Timeout
		beq Ready

		dec Timeout
		jmp NoCredits

		Ready:

		lda Credits
		cmp #9
		bcs NoCredits

		lda INPUT.JOY_UP_NOW, y
		beq NoCredits

		lda INPUT.JOY_UP_LAST, y
		bne NoCredits

	IncreaseCredits:

		inc Credits

		lda #15
		sta Timeout
		lda Credits
		cmp #3
		bcs NoChange

		cmp #2
		bcc NotUpdate

		jsr TITLE.DrawPlayerPrompt
		jmp NoChange

		NotUpdate: 

		jsr TITLE.CoinMode

		NoChange:

		jsr DRAW.DrawCredits
		jmp NoFire

	NoCredits:

		lda Credits
		beq NoFire
		
		lda INPUT.FIRE_UP_THIS_FRAME, y
		beq NoFire

		jmp StartGame

	NoFire:

	jmp TitleLoop
}


TitleScreen: {


	lda #%00001011
	sta VIC.MEMORY_SETUP




	lda #0
	sta GameActive

	sta VIC.SPRITE_ENABLE
 

	lda #LIGHT_BLUE
	sta VIC.EXTENDED_BG_COLOR_1
	lda #RED
	sta VIC.EXTENDED_BG_COLOR_2

	lda #BLACK
	sta VIC.BACKGROUND_COLOR

	lda #DARK_GRAY
	sta VIC.BORDER_COLOR

	jsr DRAW.ClearScreen
	jsr MAPLOADER.DrawMap

	jsr DRAW.SetColourRam
	jsr DRAW.ClearCentre

	jsr TITLE.Reset
	jsr DRAW.DrawCredits


	lda #%00001100
	sta VIC.MEMORY_SETUP



	jmp TitleLoop



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

	lda GameActive
	beq GamePaused

	NotPaused:

		jsr CONTROL.Update
		jsr SCORE.CheckScoreToAdd

		jsr ENEMIES.FrameUpdate
		jsr STARS.FrameUpdate
		jsr PLAYER.FrameUpdate

		
		jsr MOTHERSHIP.FrameUpdate

		SetDebugBorder(0)
		
		//jsr SHIP.FrameUpdate
		//jsr ENEMIES.FrameUpdate
		//jsr BOMBS.FrameUpdate

		
		jmp Loop

	GamePaused:

		lda GameIsOver
		beq Loop

		lda GameOverTimer
		beq GameOver

		dec GameOverTimer
		jmp Loop

		GameOver:

		jmp TitleScreen

}	
 
	

StartGame: {

	jsr GameScreen
	jmp Loop

}


GameScreen:{


	jsr ResetGame
	rts	
}



ResetGame: {

	

	lda #%00001011
	sta VIC.MEMORY_SETUP


	lda #BLACK
	sta VIC.BACKGROUND_COLOR

	lda #DARK_GRAY
	sta VIC.BORDER_COLOR
	
	lda #ZERO
	sta MAIN.GameIsOver

	jsr DRAW.ClearScreen
	jsr MAPLOADER.DrawMap
	jsr CONTROL.Reset
	jsr MOTHERSHIP.Reset
	//jsr ENEMIES.Reset

	//jsr ENEMIES.Reset
	//jsr BOMBS.Reset
	//jsr BASE.CopyBase
	jsr SCORE.Reset


	WaitForRaster:

		lda VIC.RASTER_Y
		cmp #250
		bne WaitForRaster

	lda #%00001100
	sta VIC.MEMORY_SETUP


	lda #ONE
	sta MAIN.GameActive




	rts

}







#import "common/assets.asm"

* = $c000 "Screen Ram"

.fill 1024, 0

* = $ffff "End Of Memory"
}