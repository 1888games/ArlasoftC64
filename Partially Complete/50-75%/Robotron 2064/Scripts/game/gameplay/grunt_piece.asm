GRUNT_PIECE: {

	* = * "Grunt Piece"

	.label MAX_EXPLODE = 2

	CharX:		.fill MAX_EXPLODE, 255
	CharY:		.fill MAX_EXPLODE, 255
	SpawnProgress: .fill MAX_EXPLODE, 255
	

	CurrentID:	.byte 0

	GetRowAndColumn: {

		lda CharX, x
		sta ZP.Column

		ldy #0
		lda (ZP.OffsetAddress), y
		clc
		adc CharY, x
		sta ZP.Row

		rts
	}


	Add: {

		ldy #0

		Loop:

			lda CharX, y
			bmi Found

			iny
			cpy #MAX_EXPLODE
			bcc Loop



			rts


		Found:	


			lda #0
			sta SpawnProgress, y

			sty ZP.Temp4

			lda ZP.Row
			sta CharY, y

			lda ZP.Column
			sta CharX, y
			

		rts
	}




	AnimateDespawn: {

		lda SpawnProgress, x
		bmi Exit

		DeleteOld:

			asl
			tay

			lda GRUNT.Offsets, y
			sta ZP.OffsetAddress

			lda GRUNT.Offsets + 1, y
			sta ZP.OffsetAddress + 1

			lda GRUNT.Stages, y
			sta ZP.StageAddress

			lda GRUNT.Stages + 1, y
			sta ZP.StageAddress + 1

		jsr GetRowAndColumn
		jsr GRUNT.DeleteSpawn

		ldx CurrentID

		NextStage:

		inc SpawnProgress, x
		lda SpawnProgress, x
		cmp #6
		bcs Done
		
		asl
		tay

		lda GRUNT.Offsets, y
		sta ZP.OffsetAddress

		lda GRUNT.Offsets + 1, y
		sta ZP.OffsetAddress + 1

		lda GRUNT.Stages, y
		sta ZP.StageAddress

		lda GRUNT.Stages + 1, y
		sta ZP.StageAddress + 1

		jsr GetRowAndColumn
		jsr GRUNT.DrawSpawn

		rts

		Done:

		lda #255
		sta CharX, x

		Exit:


		rts
	}


	FrameUpdate: {

		//lda $d012
		//cmp #200
		//bcs Finish

		jmp ProcessDespawn

		Finish:

		rts
	}



	ProcessDespawn: {

		SetDebugBorder(LIGHT_RED)

		lda #0
		sta ZP.Temp3

		lda CurrentID
		clc
		adc #1
		sta ZP.EndID

		Loop:

			inc ZP.Temp3

			ldx CurrentID

			lda CharX, x
			bmi EndLoop

			jsr AnimateDespawn

			EndLoop:

				inc CurrentID
				lda CurrentID
				cmp #MAX_EXPLODE
				bcc Okay

				lda #0
				sta CurrentID

				SetDebugBorder(DARK_GRAY)
				rts

		Okay:


			lda ZP.Temp3
			cmp #2
			bcc Loop


		SetDebugBorder(DARK_GRAY)

		rts
	}



}