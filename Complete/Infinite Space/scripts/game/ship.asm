SHIP:{	






	PosX_MSB:		.byte 0
	PosX_LSB:		.byte 40
	PosY:			.byte 120
	SpriteFrame:	.byte 0
	FrameTimer:		.byte 0



	.label SpritePointer = 16
	.label SpriteFrames = 8
	.label FrameTime = 4

	.label BulletPointer = 44
	.label BulletSpeed = 12
	.label MaxBulletX = 70


	BulletX_LSB:	.byte 0
	BulletX_MSB:	.byte 0
	BulletY:		.byte 0

	IsDying:		.byte 0
	DeathFrame:		.byte 0

	LivesLeft:			.byte 3

	.label NumberOfLives = 3
	.label LivesChar = 71




	Reset: {

		lda #YELLOW
		sta VIC.SPRITE_COLOR_0

		lda #CYAN
		sta VIC.SPRITE_COLOR_1

		lda #255
		sta VIC.SPRITE_ENABLE

		lda #NumberOfLives
		sta LivesLeft

		lda #0
		sta IsDying
		sta DeathFrame


		jsr DrawLives

		rts


	}


	DrawLives: {

		ldx #0
		ldy #0

		Loop:

			cpx LivesLeft
			bcc DrawIt

			Blank:

				lda #0
				sta SCREEN_RAM + 18, y
				jmp EndLoop

			DrawIt:

				lda #LivesChar
				sta SCREEN_RAM + 18, y

				lda #YELLOW
				sta VIC.COLOR_RAM + 18, y

			EndLoop:

				inx
				iny
				iny
				cpx #3
				bcc Loop


		rts
	}



	Destroy: {

		lda #1
		sta IsDying

		lda #0
		sta DeathFrame

		dec LivesLeft
		lda LivesLeft
		bne Finish

		GameOver:

			lda #1
			sta MAIN.GameIsOver

			lda #6
			sta MAIN.GameOverTimer

			lda #0
			sta MAIN.GameActive

		Finish:


		jsr DrawLives

		jsr ENEMIES.DestroyWave


		rts


	}



	CheckHit: {


		lda ENEMIES.BulletX_LSB
		clc
		adc ENEMIES.BulletX_MSB
		beq Finish

		lda IsDying
		bne Finish

		CheckY:

			lda ENEMIES.BulletY
			sec
			sbc #7
			sec
			sbc PosY
			clc
			adc #6
			cmp #12

			bcs Finish

		CheckX:

			sec				// set carry for borrow purpose
			lda ENEMIES.BulletX_LSB
			clc
			adc #7
			sec
			sbc PosX_LSB
			sta Diff_LSB

			lda PosX_MSB			//; do the same for the MSBs, with carry
			sbc ENEMIES.BulletX_MSB	//; set according to the previous result
			sta Diff_MSB

		bne Finish

		lda Diff_LSB
		bmi Finish

		cmp #20
		bcs Finish


		jsr Destroy

		lda #0
		sta ENEMIES.BulletX_LSB
		sta ENEMIES.BulletX_MSB
		
		sfx(SFX_DESTROY)	


		Finish:

			rts

	}


	FrameUpdate: {


		jsr UpdateSpriteData
		jsr UpdateFrame
		jsr UpdateBullet
		jsr UpdateBulletData
		jsr CheckHit
		
		rts
	}



	UpdateBullet: {

		lda BulletX_LSB
		clc
		adc BulletX_MSB
		beq Finish

		MoveBullet:

			lda BulletX_LSB
			clc
			adc #BulletSpeed
			sta BulletX_LSB

			lda BulletX_MSB
			adc #00
			sta BulletX_MSB

			beq Finish

			lda BulletX_LSB
			cmp #MaxBulletX
			bcc Finish

			lda #0
			sta BulletX_LSB
			sta BulletX_MSB





		Finish:

		rts
	}

	UpdateBulletData: {


		lda #BulletPointer
		sta SPRITE_POINTERS + 1

		lda BulletX_LSB
		sta VIC.SPRITE_1_X

		lda BulletY
		sta VIC.SPRITE_1_Y

		lda BulletX_MSB
		beq MSB_Off

		MSB_On:

			lda VIC.SPRITE_MSB
			ora VIC.MSB_On + 1
			sta VIC.SPRITE_MSB
			jmp Done

		MSB_Off:

			lda VIC.SPRITE_MSB
			and VIC.MSB_Off + 1
			sta VIC.SPRITE_MSB

		Done:

			rts




		rts
	}


	UpdateFrame: {

		lda FrameTimer
		beq NextFrame

		dec FrameTimer
		rts

		NextFrame:

			lda #FrameTime
			sta FrameTimer

			lda IsDying
			beq Alive

		Dead:

			inc DeathFrame
			lda DeathFrame
			cmp #6
			bcc Reset

		DeathFinished:

			lda #0
			sta IsDying

		Alive:

			inc SpriteFrame
			lda SpriteFrame
			cmp #SpriteFrames
			bcc Okay

		Reset:

			lda #0
			sta SpriteFrame

		Okay:

			rts

	}




	UpdateSpriteData: {

		lda IsDying
		beq Alive

		Dead:

			ldx DeathFrame
			lda ENEMIES.DeathFrames, x
			sta SPRITE_POINTERS + 0
			jmp Done

		Alive:

			lda #SpritePointer
			clc
			adc SpriteFrame
			sta SPRITE_POINTERS + 0


			lda PosX_LSB
			sta VIC.SPRITE_0_X

			lda PosY
			sta VIC.SPRITE_0_Y

			lda PosX_MSB
			beq MSB_Off

		MSB_On:

			lda VIC.SPRITE_MSB
			ora VIC.MSB_On
			sta VIC.SPRITE_MSB
			jmp Done

		MSB_Off:

			lda VIC.SPRITE_MSB
			and VIC.MSB_Off
			sta VIC.SPRITE_MSB


		Done:

			rts


	}


}