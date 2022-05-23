
SpriteMSB:		.fill MAX_SPRITES, 0

*=* "SpriteType"
SpriteType:		.fill MAX_SPRITES, 255
*=* "LocalSpriteID"
LocalSpriteID:	.fill MAX_SPRITES, 255

SpriteXToChar: 		.fill 256, round((i - 24)/8)
SpriteYToChar: 		.fill 256, round((i - 50)/8)



SPRITE_MANAGER: {

	* = * "SpriteManager"
	

	TotalActive: 		.byte 0
	TotalSprites:		.byte 0
	EnemiesActive:		.byte 0
	HumansActive:		.byte 0
	BulletsActive:		.byte 0
	FirstEnemySprite:	.byte 0
	LastEnemySprite:	.byte 0
	HulksActive:		.byte 0 
	BrainsActive:		.byte 0

	Reset: {

		lda #0
		sta TotalActive
		sta EnemiesActive
		sta HumansActive
		sta BulletsActive
		sta LastEnemySprite
		sta TotalSprites
		sta HulksActive
		sta BrainsActive

		jsr Clear

		rts


	}


	Clear: {

		ldx #0
	
		Loop:

			lda #0
			sta SpriteX, x
			sta SpriteY, x
			sta SpriteMSB, x

			lda #255
			sta SpriteType, x

			lda SpriteColor, x
			and #%01111111
			sta SpriteColor, x

			inx
			cpx #MAX_SPRITES
			bcc Loop


		rts
	}


	GetAvailableEnemySprite: {

		ldx FirstEnemySprite

		Loop:

			lda SpriteType, x
			bpl EndLoop

			rts

			EndLoop:

			inx
			cpx #MAX_SPRITES - 1
			bcc Loop

			ldx #255


		rts
	}

	GetAvailableBulletSprite: {

		ldx #MAX_SPRITES - 2

		Loop:

			lda SpriteType, x
			bpl EndLoop

			rts

			EndLoop:

			dex
			cpx FirstEnemySprite
			bcs Loop

			ldx #255

		rts
	}

	FrameUpdate: {

		clc
		lda EnemiesActive
		sta TotalActive
		bne StillSprites

		ldx GRUNT.NumberRemaining
		bne StillSprites

		jmp COMPLETE.Set

		StillSprites:

		adc HulksActive
		adc HumansActive
		adc BulletsActive
		adc BrainsActive
		sta TotalSprites

		
		rts
	}


}