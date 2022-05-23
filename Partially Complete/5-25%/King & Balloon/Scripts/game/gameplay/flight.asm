.namespace CHARGER {

	* = * "Flight"


	FlightJumpTable: 	.word 0, PacksBags, FliesInArc


	SpeedLookup:		.byte 2, 2, 3, 1, 2, 1			


	AlienArcTable:		

	.byte $ff, $00, $ff, $00, $ff, $00, $ff, $01, $ff, $00, $ff, $00, $ff, $01, $ff, $00
	.byte $ff, $01, $ff, $00, $00, $01, $ff, $00, $ff, $01, $00, $01, $ff, $00, $00, $01
	.byte $ff, $01, $00, $01, $ff, $01, $00, $01, $00, $01, $ff, $01, $00, $01, $00, $01
	.byte $00, $01, $00, $01, $00, $01, $00, $01, $01, $01, $00, $01, $00, $01, $01, $01
	.byte $00, $01, $01, $01, $00, $01, $01, $00, $00, $01, $01, $01, $01, $00, $00, $01
	.byte $01, $00, $01, $01, $01, $00, $01, $01, $01, $00, $01, $00, $01, $01, $01, $00
	.byte $01, $00, $01, $00, $01, $00, $01 


	ShipX:		.byte 0
	FlagshipX:	.byte 0

	TypeToColour: .byte RED, YELLOW, YELLOW, RED

	PacksBags: {

		jsr StartDive

		lda #0
		sta ENEMY.SortieCount, x
		sta ENEMY.Targeting, x
	
		GetSpeed:

			lda ENEMY.Slot, x
			tay

			lda SHIP.TwoPlayer
			beq NoTarget

			lda ZP.Counter	
			and #%00000001
			sta ENEMY.Targeting, x

		NoTarget:

		Position:

			jsr GetEnemyStartPosition

		GetColour:

			lda FORMATION.Type, y
			sta ENEMY.Type, x
			tay

			lda TypeToColour, y
			sta SpriteColor, x

		Pointer:

			tya
			clc
			adc #17
			sta ENEMY.BasePointer, x
			sta SpritePointer, x

			lda #FLIES_IN_ARC
			sta ENEMY.Plan, x

			lda #0
			sta ENEMY.AnimFrameStartCode, x
			sta ENEMY.ArcTableLSB, x

			lda #3
			sta ENEMY.TempCounter1, x

			lda #8
			sta ENEMY.TempCounter2, x

			jsr RANDOM.Get
			and #%00000001
			sta ENEMY.ArcClockwise, x

			lda #0
			sta ENEMY.Angle, x

		rts
	}

	GetEnemyStartPosition: {

		.break

		lda ENEMY.Slot, x
		tay

		lda FORMATION.FormationSpriteX, y
		sec
		sbc #6
		sta SpriteX, x

		lda FORMATION.SpriteRow, y
		sec
		sbc #4
		sta SpriteY, x

		rts
	}


	FliesInArc: {




		rts
	}

}