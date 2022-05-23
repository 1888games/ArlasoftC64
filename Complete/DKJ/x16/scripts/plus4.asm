

MAIN: {

#import "lookups/zeropage.asm"

* = $1200 "Code1"
#import "setup/upstart.asm"
#import "setup/loadModules.asm" 

GameCounter:		.byte 32, 32, 32
SpeedIncreaseCounter: .byte 48, 48
FrameSwitch: .byte 0
TitleCooldown: .byte 30, 30

BASICStub(0,"Entry")

.label MaxSpeed = 13

Entry:	
	
		//exomizer sfx sys -t 64 -x "inc $d020" -o yakf.exo yakf.prg

		sei 

		//jsr VIC.Setup
		//jsr SOUND.Setup

		jmp Loop



Loop:

		
	jmp Loop


TitleScreen: {

		jsr SOUND.StopAll
		
		lda VIC.RAM_CHAR_ADDRESS
		and #%00000011
		ora #%00011000		// character ram page 8   $2000/8192
		sta VIC.RAM_CHAR_ADDRESS

		lda #%01100111
		sta VIC.BACKGROUND_COLOUR   // background colour  light blue

		lda #%10000000
		sta VIC.BORDER_COLOUR  // border colour

		DrawMap:

		jsr TITLELOADER.DrawMap


		lda TitleCooldown + 1
		sta TitleCooldown

		jmp TitleLoop

}




TitleLoop: {

		lda TitleCooldown
		beq GetJoystick

		dec TitleCooldown
		jmp TitleLoop

		.label temp = TEMP1
		.label JOYSTICKSELECT1 = %00000010 

		GetJoystick:

		jsr gatherJoystick1
		sta temp
		jmp gatherJoystick2

		gatherJoystick1:
		lda #$ff
		sta $fd30
		lda #JOYSTICKSELECT1
		sta $ff08
		lda $ff08
	
		rts

		gatherJoystick2:

			jsr gatherJoystick1
			cmp temp
			bne GetJoystick

		and #JOY_FIRE
		bne GetJoystick

		lda #2
		sta TitleCooldown

		Loop:

			lda TitleCooldown
			beq NewGame
			dec TitleCooldown
			ldx #1
			jsr WaitForRasterLine
			jmp Loop


}



NewGame:{

		lda VIC.RAM_CHAR_ADDRESS
		and #%00000011
		ora #%00100000		// character ram page 8   $2000/8192
		sta VIC.RAM_CHAR_ADDRESS

		lda #%01010011
		sta VIC.BACKGROUND_COLOUR   // background colour  light blue

		lda #%10000000
		sta VIC.BORDER_COLOUR  // border colour

		jsr MAPLOADER.DrawMap

		lda GameCounter + 2
		sta GameCounter + 1
		sta GameCounter

		 jsr CHAR_DRAWING.ClearAll
		 jsr MONKEY.Reset
		 jsr SCORE.Reset
		 jsr KEY.Reset
		 jsr LIVES.Reset
		 jsr PINEAPPLE.Reset
		 jsr CAGE.Reset
		 jsr CAGE.LockCage
		 jsr ENEMIES.Reset

		jmp MainLoop

}

TestLoop: {



	jmp TestLoop
}



WaitForRasterLine: {

	.label RasterTarget = TEMP1
	stx RasterTarget

	Loop: 

		lda VIC.RASTER_LINE
		cmp RasterTarget
		bne Loop

		rts

}



CheckWhetherToUpdateScore: {

		lda ZP_COUNTER
		and #3
		bne NoScoreAdd

		jsr SCORE.CheckScoreToAdd

		NoScoreAdd:

		rts
}


CheckSpawn:{



		jsr Random

		adc #128
		cmp #45
		bcc DoZero
		cmp #210
		bcs Finish

		ldy #ONE
		jsr ENEMIES.Spawn
		jmp Finish

		DoZero:
			ldy #ZERO
		 	jsr ENEMIES.Spawn

		Finish:

		rts
}

CheckGameSpeed:{

		dec SpeedIncreaseCounter
		bne NoSpeedIncrease

		lda SpeedIncreaseCounter + 1
		sta SpeedIncreaseCounter

		lda GameCounter + 1
		cmp #MaxSpeed
		bcc NoSpeedIncrease

		dec GameCounter + 1
		dec GameCounter + 1

		NoSpeedIncrease:

			rts
}



GameTick: {

		inc ZP_COUNTER

		lda GameCounter
		cmp #ONE
		bcc PerformTick

		dec GameCounter
		rts

		PerformTick:

			lda FrameSwitch
			beq FlipOn

			lda #ZERO 
			sta FrameSwitch

			jmp RestoreCounter

			FlipOn:

				lda #ONE
				sta FrameSwitch

			RestoreCounter:

			lda GameCounter + 1
			sta GameCounter

			asl 
			sta MONKEY.DropTime

			jsr ENEMIES.Update
			jsr KEY.Update
			jsr KEY.DrawKey
			jsr CAGE.Update
			jsr CAGE.Draw

		
			lda KEY.Active
			beq Finish

			jsr CheckGameSpeed
			jsr CheckSpawn

		Finish:
		
		lda MONKEY.DisableControl
		bne NoSound

		jsr SOUND.PlayTick

		NoSound:
		rts
}


MainLoop: 

		//.break
		
		ldx #1
		jsr WaitForRasterLine
		jmp MonkeyIRQ

 		
MonkeyIRQ: {



	
		jsr MONKEY.Delete
		jsr MONKEY.Control
		jsr MONKEY.Draw
		jsr SOUND.Update
		jsr GameTick
		jsr CheckWhetherToUpdateScore
		jsr PINEAPPLE.Update

		ldx #150
		jsr WaitForRasterLine

		jmp MainLoop

		

}


Random: {

	lda $ff1e


	rts

}
 #import "setup/assets.asm"

}




