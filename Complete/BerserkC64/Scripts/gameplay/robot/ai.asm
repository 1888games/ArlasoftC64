.namespace ROBOT {

	
	.label ShootGap = 3


	ShootFrame:		.byte 0
	YLookup:		.byte 6, 2


	CheckShoot: {

		lda #255
		sta ShootFrame

		lda BULLET.EnemyBullets
		beq NotDiagonal

		lda PlayerDiffX, x
		cmp #ShootGap
		bcs NotInX

			lda DirectionY, x
			beq ShootUp

			ShootDown:

				lda #2
				sta ShootFrame

				jmp NotInX

			ShootUp:

				lda #6
				sta ShootFrame
				

		NotInX:

			lda PlayerDiffY, x
			cmp #ShootGap
			bcs NotInY

			lda DirectionX, x
			bmi ShootLeft


			ShootRight:

				
				lda #0
				sta ShootFrame

				jmp NotDiagonal

			ShootLeft:

				lda #4
				sta ShootFrame

				jmp NotDiagonal

		NotInY:

			lda PlayerDiffY, x
			sec
			sbc PlayerDiffX, x
			clc
			adc #ShootGap
			cmp #ShootGap * 2
			bcs NotDiagonal

		Diagonal:

			lda DirectionY, x
			tay
			lda YLookup, y
			clc 
			adc DirectionX, x
			sta ShootFrame




		NotDiagonal:

			lda ShootFrame
			bmi Finish

			jsr BULLET.FireRobot
			//clc
			//adc #1
			//sta $d020

		Finish:

		rts
	}


	CalculateXDiff: {


		CheckLSB:

			lda PLAYER.PosX_LSB
			sec
			sbc PosX_LSB, x
			bcc PlayerToLeft

			sta PlayerDiffX, x

			lda #1
			sta DirectionX, x

			jmp Finish

		PlayerToLeft:

			lda PosX_LSB, x
			sec
			sbc PLAYER.PosX_LSB
			sta PlayerDiffX, x

			lda #255
			sta DirectionX, x

		Finish:



		rts
	}

	CalculateYDiff: {


	
			lda PLAYER.PosY
			clc
			adc #2
			sec
			sbc PosY, x
			bcc PlayerAbove

			sta PlayerDiffY, x

			lda #1
			sta DirectionY, x

			jmp Finish

		PlayerAbove:

			lda PosY, x
			sec
			sbc #2
			sec
			sbc PLAYER.PosY
			sta PlayerDiffY, x

			lda #0
			sta DirectionY, x

		Finish:



		rts
	}

	

	GetDistanceToPlayer: {


		jsr CalculateXDiff
		jsr CalculateYDiff

		


		rts
	}


	
	AI: {


		lda #0
		sta ZP.Repeat

		Again:

			lda ZP.Repeat
			cmp #2
			bcs NoWrap

			inc ZP.Repeat

			jsr RANDOM.Get
			and #%00001111
			cmp StartCount
			bcs Again

			tax
			stx ZP.X

			lda State, x
			bmi Again

			cmp #ROBOT_DYING
			beq Again

			lda WaitTimer, x
			bne Again


			lda FireCooldown, x
			bne Again

		ProcessAI:

			jsr CheckShoot
			

		NothingToDo:


		NoWrap:




		rts
	}	



	


}