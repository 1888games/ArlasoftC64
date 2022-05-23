CONTROL: {



	CurrentBlockPosition:	.byte 2


	BlockTableLookup:	.byte 0, 8, 16, 24, 32	

	AnyMovement:	.byte 0



	Reset: {


		lda #2
		sta CurrentBlockPosition

		rts
	}



	Update: {	

		lda BLOCK.MergeBlocks
		beq Okay

		jmp Finish

		Okay:

		lda BLOCK.CheckMergeChain
		bne Finish

		lda BLOCK.IsBlockBeingFired
		bne Finish

		lda #0
		sta AnyMovement

		ldy #1

		CheckUp:
	
			lda INPUT.JOY_UP_NOW, y
			beq CheckDown

			lda INPUT.JOY_UP_LAST, y
			bne CheckDown

			lda CurrentBlockPosition
			beq CheckFire

			ldx CurrentBlockPosition
			lda BlockTableLookup, x
			tax
			lda BLOCK.Values, x

			pha

			lda #0
			sta BLOCK.Values, x

			dec CurrentBlockPosition

			ldx CurrentBlockPosition
			lda BlockTableLookup, x
			tax
			
			pla
			sta BLOCK.Values, x
			jmp Finish


		CheckDown:

			lda INPUT.JOY_DOWN_NOW, y
			beq CheckFire


			lda INPUT.JOY_DOWN_LAST, y
			bne CheckFire


			lda CurrentBlockPosition
			cmp #4
			beq CheckFire

			ldx CurrentBlockPosition
			lda BlockTableLookup, x
			tax
			lda BLOCK.Values, x

			pha

			lda #0
			sta BLOCK.Values, x

			inc CurrentBlockPosition

			ldx CurrentBlockPosition
			lda BlockTableLookup, x
			tax
			
			pla
			sta BLOCK.Values, x
			jmp Finish
	
		CheckFire:

		
			lda INPUT.JOY_FIRE_NOW, y
			beq NoFire

			lda INPUT.JOY_FIRE_LAST, y
			bne NoFire

			jsr Fire
			jmp Finish

			
		NoFire:

		
		Finish:
	
	//	dec $d020

	SetDebugBorder(0)

		rts




	}




	Fire: {

		lda BLOCK.IsBlockBeingFired
		bne Finish

		ldx CurrentBlockPosition
		stx BLOCK.FireBlockRow

		lda #1
		sta BLOCK.IsBlockBeingFired
		//jsr BULL	ET.PlayerFire

		


		Finish:

		rts
	}



}