.namespace CHARGER {

	* = * "Flight"


	FlightJumpTable: 	.word 0, PacksBags, FliesInArc, ReadyToAttack, AttackingPlayer
						.word NearBottomOfScreen, ReachedBottomOfScreen, ReturningToSwarm
						.word ContinuingAttackFromTop, FullSpeedCharge, AttackingAggressively, LoopTheLoop
						.word CompleteLoop, Unknown_1091


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


	PacksBags: {

		jsr StartDive

		lda #0
		sta ENEMY.SortieCount, x
		sta ENEMY.Targeting, x
		sta ENEMY.IsEscort, x

		cpx #2
		bcc GetSpeed

		cpx #4
		bcs GetSpeed

		inc ENEMY.IsEscort, x
	
		GetSpeed:

			lda ENEMY.Slot, x
			tay
			
			lda FORMATION.Relative_Row, y
			tay


			lda SpeedLookup, y
			sta ENEMY.Speed, x

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

			lda FORMATION.TypeToColour, y
			sec
			sbc #8
			sta SpriteColor, x

		Pointer:

			lda EnemyTypeFrameStart, y
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
		
			lda ENEMY.ArcClockwise, x
			beq GoingLeft


		GoingRight:

			lda #0
			sta ENEMY.Angle, x
			
			jmp CheckEscorts

		GoingLeft:

			lda #16
			sta ENEMY.Angle, x


		CheckEscorts:



			// COUNT ESCORTS HERE? CAN'T WE DO IT ELSEWHERE?


		rts
	}

	GetEnemyStartPosition: {

		lda ENEMY.Slot, x
		tay

		lda FORMATION.FormationSpriteX, y
		sec
		sbc #4
		sta SpriteX, x

		lda FORMATION.SpriteRow, y
		sec
		sbc #6
		sta SpriteY, x

		rts
	}


	FliesInArc: {

			lda #0
			sta ZP.Amount

		Repeat:

			lda ENEMY.ArcTableLSB, x
			tay

			lda AlienArcTable, y
			sta ENEMY.MoveY

			iny
			lda AlienArcTable, y
			sta ENEMY.MoveX

		
			lda SpriteY, x
			adc #0
			clc
			adc ENEMY.MoveY
			sta SpriteY, x

			lda ENEMY.ArcClockwise, x
			bne FacingRight

		FacingLeft:

			lda SpriteX, x
			sec
			sbc ENEMY.MoveX
			sta SpriteX, x

			cmp #2
			bcs UpdateAngleLeft

			lda #ReturningToSwarm
			sta ENEMY.Plan, x
			rts

		UpdateAngleLeft:

			dec ENEMY.TempCounter1, x
			bne CheckProgress

			lda #5
			sta ENEMY.TempCounter1, x

			dec ENEMY.Angle, x
			lda ENEMY.BasePointer, x
			clc
			adc ENEMY.Angle, x
			sta SpritePointer, x

			lda ENEMY.Angle, x
			cmp #8
			beq ReadyToAttack

			jmp CheckProgress

		FacingRight:

			lda SpriteX_LSB, x
			clc
			adc ENEMY.FractionSpeedX, x
			sta SpriteX_LSB, x

			lda SpriteX, x
			adc #0
			clc
			adc ENEMY.MoveX
			sta SpriteX, x

			cmp #14
			bcs UpdateAngleRight

			lda #ReturningToSwarm
			sta ENEMY.Plan, x
			rts

		UpdateAngleRight:

			dec ENEMY.TempCounter1, x
			bne CheckProgress

			lda #5
			sta ENEMY.TempCounter1, x

			inc ENEMY.Angle, x
			lda ENEMY.BasePointer, x
			clc
			adc ENEMY.Angle, x
			sta SpritePointer, x

			lda ENEMY.Angle, x
			cmp #8
			beq ReadyToAttack

			dec ENEMY.TempCounter2

		CheckProgress:

			lda ENEMY.ArcTableLSB, x
			clc
			adc #2
			sta ENEMY.ArcTableLSB, x

			cmp #88
			bcc Finish

		ReadyToAttack:


			lda #READY_TO_ATTACK
			sta ENEMY.Plan, x
			rts


		Finish:

			lda IRQ.Frame
			sec
			sbc MAIN.MachineType
			adc ZP.Amount
			bpl DontRepeat

			inc ZP.Amount

			//jmp Repeat

		DontRepeat:
				

		rts
	}


	ReadyToAttack: {


		CheckIfRed:

			lda ENEMY.Type, x
			cmp #ALIEN_RED
			beq RedAlien

		NotRed:	

			ldy ENEMY.Targeting, x

			lda SpriteX, x
			sec
			sbc SHIP.PosX_MSB, y
			bcc AlienToLeft

		AlienToRight:

			lsr
			clc
			adc #12
			cmp #40
			bcs GreaterEqual48

			lda #40

		GreaterEqual48:

			cmp #100
			bcc LessThan112

			lda #100

		LessThan112:

		/// SWAP THEM ROUND, THEIR X CO-ORDS GO 224 - 0

		SetPivotValues:

			sta ENEMY.PivotXValueAdd, x
			sec
			sbc SpriteX, x
			eor #%11111111
		 	clc
		 	adc #1
		 	sta ENEMY.PivotXValue, x

		 	lda #0
		 	sta ENEMY.Inflight_S1A
		 	sta ENEMY.Inflight_S1B
		 	sta ENEMY.Inflight_S1C

		 	inc ENEMY.Plan, x
		 	rts

		AlienToLeft:

			lsr
			ora #%10000000
			sec
			sbc #12
			cmp #215
			bcc LessThan208

			lda #-40

		LessThan208:

			cmp #156
			bcs GreaterEqual144

			lda #-100

		GreaterEqual144:

			jmp SetPivotValues


		RedAlien:

		CheckIfFlagshipAttacking:

			lda ENEMY.Plan + 1
			beq NotRed

			lda SpriteX, x
			sec
			sbc SpriteX + 1
			sta ENEMY.XOffset, x

			lda ENEMY.PivotXValueAdd + 1
			jmp SetPivotValues	

		rts
	}



	AttackingPlayer: {

		lda #0
		sta ZP.Amount

		Repeat:

			inc SpriteY, x

			lda ENEMY.IsEscort, x
			beq NotEscort

		IsEscort:

			lda ENEMY.Plan + 1
			beq PretendFlagship

			cmp #PLAN_EXPLODE
			beq PretendFlagship

			jmp UseFlagship

		PretendFlagship:

			ldx #1
			jsr Attack_Y_Add	

			lda ENEMY.PivotXValue, x
			clc
			adc ENEMY.PivotXValueAdd, x
			sta SpriteX, x

			ldx ZP.EnemyID

			jmp SkipYCheck

		UseFlagship:

			lda SpriteY, x
			sec
			sbc SpriteY + 1
			cmp #24
			bcc SkipYCheck

			lda SpriteX, x
			jmp CheckOff

		SkipYCheck:

			lda SpriteX + 1
			clc
			adc ENEMY.XOffset, x
			sta SpriteX, x

			jmp CheckOff

		NotEscort:

			jsr Attack_Y_Add

			lda ENEMY.PivotXValue, x
			clc
			adc ENEMY.PivotXValueAdd, x
			sta SpriteX, x

		CheckOff:

			cmp #9
			bcc NotOffScreen

			cmp #11
			bcs NotOffScreen

		Off:

			lda #REACHED_BOTTOM_OF_SCREEN
			sta ENEMY.Plan, x
			rts

		NotOffScreen:

			lda SpriteY, x
			clc
			adc #64
			bcc CheckLookAt

		NearBottomOfScreen:

			lda #NEAR_BOTTOM_OF_SCREEN

			//jmp FullSpeedCharge.Loop

			sta ENEMY.Plan, x
			rts
			

		CheckLookAt:

			lda SHIP.Active
			beq Shooting

			jsr CalculateLookAtFrame

		Shooting:	

			lda CHARGER.FlagshipHit
			bne NoShoot

		CanShoot:

			ldy CHARGER.InflightAlienShootRangeMult

			lda SpriteY, x

		RangeLoop:
	
			cmp CHARGER.InflightAlienShootExactY
			beq TrySpawn

			clc
			adc #25
			dey
			bne RangeLoop

			rts


		TrySpawn:

			jsr BOMBS.Fire


		NoShoot:

		rts
	}

	CalculateLookAtFrame: {

		ldy ENEMY.Targeting, x

		lda SHIP.PosX_MSB, y
		sec
		sbc SpriteX, x
		bcs ShipToRight

		ShipToLeft:

			cmp #225
			bcs NoAngle

			cmp #128
			bcs Okay

			lda #128
			jmp Okay

		ShipToRight:

			cmp #30
			bcc NoAngle

			cmp #128
			bcc Okay

			lda #127

		Okay:

			sta ENEMY.MoveX
			jmp CalcY


		NoAngle:

			lda #8
			clc
			adc ENEMY.BasePointer, x
			sta SpritePointer, x

			rts

		CalcY:

		lda #SHIP.SHIP_Y
		sec
		sbc SpriteY, x
		bcs ShipBelow

		ShipAbove:

			cmp #128
			bcs Okay2

			lda #128
			jmp Okay2

		ShipBelow:

			cmp #128
			bcc Okay2

			lda #127


		Okay2:


		sta ENEMY.MoveY

		jsr ENEMY.CalculateRequiredSpeed

		rts
	}

	Attack_Y_Add: {

		lda ENEMY.Speed, x // ld a, (ix+$18)
		and #%00000011 // and $03
		clc
		adc #1 // inc a
		tay  // ld b, a

		lda ENEMY.PivotXValueAdd, x // ld h, (ix + $19)
		sta ZP.H  

		lda ENEMY.Inflight_S1A, x // ld l, (ix + $1c)
		sta ZP.L

		lda ENEMY.Inflight_S1B, x // ld d, (ix + $1b)
		sta ZP.D
		               
		lda ENEMY.Inflight_S1C, x  // ld e, (ix + $1a)
		sta ZP.E

		SpeedLoop: // $117E

			lda ZP.H     // ld c, h
			sta ZP.C

			lda ZP.L  // ld a, l
			asl      	// add a, a
			bcc NoDecH  // jr nc $1184 (NoDecH)

			dec ZP.H 	// dec h

		NoDecH:  // $1184

			bcc NoCarry			

		NoCarry:

			clc
			adc ZP.D     // add a, d
			sta ZP.D     // ld d, a

			lda ZP.H    // ld a, $00   PLUS
			adc #0       // adc a, h
			sta ZP.Temp1

			cmp #$80       // cp $80
			bne NoForce   // jr nz, $118E (NoForce)

			lda ZP.C      // ld a, c

		NoForce:        // $118E

			sta ZP.H      // ld h, a
			sta ZP.Temp1

			lda ZP.L     // ld c, l
			sta ZP.C


			lda ZP.Temp1     // restore A 
			eor #%11111111
			clc
			adc #1         // neg
			asl           // add a, a
			bcc NoDecL    // jr nc, $1196 (NoDecL)

			dec ZP.L      // dec l 

		NoDecL:   // $1196

			clc       
			adc ZP.E     // add a, e
			sta ZP.E      // ld e, a

			lda ZP.L      // ld a, $00   PLUS
			adc #0       // adc a, l
			cmp #$80       // cp $80
			bne NoForce2   // jr nz, $11A0

			lda ZP.C     // ld a, c

		NoForce2:      // $11A0

			sta ZP.L   // ld l,a 

			dey           
			bne SpeedLoop // djnz $117E (SpeedLoop)



		lda ZP.H   
		sta ENEMY.PivotXValueAdd, x // ld (ix+$19), h
		
		lda ZP.L
		sta ENEMY.Inflight_S1A, x // ld (ix+$1a), l

		lda ZP.D
		sta ENEMY.Inflight_S1B, x // ld (ix+$1b), d

		lda ZP.E
		sta ENEMY.Inflight_S1C, x // ld (ix+$1c), e



		rts
	}

	NearBottomOfScreen: {

		lda ZP.Counter
		and #%00000001
		clc
		adc #1

		clc
		adc SpriteY, x
		sta SpriteY, x

		bcc NoFlyOut

		FlyOut:

			lda #REACHED_BOTTOM_OF_SCREEN
			sta ENEMY.Plan, x
			rts

		NoFlyOut:

			lda ENEMY.IsEscort, x
			beq NotEscort

		IsEscort:

			lda ENEMY.Plan + 1
			beq PretendFlagship

			cmp #PLAN_EXPLODE
			beq PretendFlagship

			jmp UseFlagship

		PretendFlagship:

			ldx #1
			jsr Attack_Y_Add	

			lda ENEMY.PivotXValue, x
			clc
			adc ENEMY.PivotXValueAdd, x
			sta SpriteX, x

			ldx ZP.EnemyID

			jmp SkipYCheck

		UseFlagship:

			lda SpriteY, x
			sec
			sbc SpriteY + 1
			cmp #36
			bcc SkipYCheck

			lda SpriteX, x
			jmp CheckOff

		SkipYCheck:

			lda SpriteX + 1
			clc
			adc ENEMY.XOffset, x
			sta SpriteX, x

			jmp CheckOff

		NotEscort:

			jsr Attack_Y_Add

			lda ENEMY.PivotXValue, x
			clc
			adc ENEMY.PivotXValueAdd, x
			sta SpriteX, x

		CheckOff:
			
			cmp #9
			bcc NotOffScreen

			cmp #11
			bcs NotOffScreen

		Off:

			lda #REACHED_BOTTOM_OF_SCREEN
			sta ENEMY.Plan, x
			rts

		
		NotOffScreen:
	
			rts
	}


	ReachedBottomOfScreen: {

		lda #25
		sta SpriteY, x

		inc ENEMY.SortieCount, x

		lda #8
		clc
		adc ENEMY.BasePointer, x
		sta SpritePointer, x

		CheckIfFlagship:

			lda ENEMY.Type, x
			bne NotFlagship

		IsFlagship:

			jmp FlagshipReachedBottom

		NotFlagship:

			lda SHIP.Active
			beq ReturnToSwarm

		PlayerAlive:

			lda CHARGER.HaveAggressiveAliens
			bne KeepAttacking

			lda CHARGER.HaveBluePurpleAliens
			beq KeepAttacking


		ReturnToSwarm:

			lda #RETURNING_TO_SWARM
			sta ENEMY.Plan, x
			rts


		KeepAttacking:

			clc
			lda SpriteX, x
			lsr
			sta ZP.C

			jsr RANDOM.Get
			and #%00011111
			clc
			adc ZP.C
			clc
			adc #32
			sta SpriteX, x

			lda #40
			sta ENEMY.TempCounter1, x

			lda dive_mode
			bpl DontRestart

			sfx(SFX_DIVE_3)

			lda #0
			sta dive_time
			lda #1
			sta dive_mode

			DontRestart:

			lda #CONTINUING_ATTACK
			sta ENEMY.Plan, x

			lda #0
			sta ENEMY.IsEscort, x

		rts
	}


	FlagshipReachedBottom: {

		lda CHARGER.FlagshipEscortCount
		beq NoEscorts

		lda #0
		sta CHARGER.FlagshipEscortCount

		CheckEscort1:

			lda ENEMY.Plan + 2
			beq FirstDead

			cmp #PLAN_EXPLODE
			beq FirstDead

			inc CHARGER.FlagshipEscortCount

		FirstDead:

			lda ENEMY.Plan + 3
			beq SecondDead
			cmp #PLAN_EXPLODE
			beq SecondDead

			inc CHARGER.FlagshipEscortCount

		SecondDead:

			lda #RETURNING_TO_SWARM
			sta ENEMY.Plan, x
			rts

		NoEscorts:

			lda CHARGER.FlagshipSurvivorCount
			cmp #2
			bcs Finish

			inc CHARGER.FlagshipSurvivorCount

		Finish:

			lda #PLAN_INACTIVE
			sta ENEMY.Plan + 1

			lda ENEMY.Slot + 1
			tay

			lda #0
			sta FORMATION.Alive, y

		rts
	}

	ReturningToSwarm: { 


		lda SpriteY, x
		sta ZP.B
		inc ZP.B

		jsr GetEnemyStartPosition

		lda SpriteY, x
		sec
		sbc ZP.B
		beq BackInSwarm
		bcc BackInSwarm

		ldy ZP.B
		sty SpriteY, x

	NotThereYet:

		cmp #4
		bcc Flat

		cmp #36
		bcs Exit

		and #%00000011
		bne Exit

		lda ENEMY.ArcClockwise, x
		beq GoingLeft

	GoingRight:

			inc ENEMY.Angle, x

			lda ENEMY.Angle, x
			cmp #16
			bcc Okay1

	Flat:

			lda #0
			sta ENEMY.Angle, x

		Okay1:

			lda ENEMY.BasePointer, x
			clc
			adc ENEMY.Angle, x
			sta SpritePointer, x
			rts

	GoingLeft:

			dec ENEMY.Angle, x

			lda ENEMY.Angle, x
			bpl Okay2
		
			lda #0
			sta ENEMY.Angle, x

		Okay2:

			lda ENEMY.BasePointer, x
			clc
			adc ENEMY.Angle, x
			sta SpritePointer, x
			rts

	BackInSwarm:

		lda ENEMY.Slot, x
		tay

		lda #1
		sta FORMATION.Occupied, y

		lda FORMATION.Drawn, y
		beq Exit

		lda #PLAN_INACTIVE
		sta ENEMY.Plan, x

		lda #10
		sta SpriteY, x

		jsr KillDive

	Exit:

		rts
	}





	ContinuingAttackFromTop: {

		//inc $d020

		inc SpriteY, x

		ldy ENEMY.Targeting, x

		lda SHIP.PosX_MSB, y
		sec
		sbc SpriteX, x

		asl
		sta ZP.E

		lda #0
		sbc #0
		sta ZP.D

		rol ZP.E
		rol ZP.D

		lda SpriteX, x
		sec
		sbc ZP.D
		sta SpriteX, x

		lda ENEMY.PivotXValue, x
		sbc #0
		sec
		sbc ZP.E
		sta ENEMY.PivotXValue,x 

		dec ENEMY.TempCounter1, x
		bne Finish

		lda #FULL_SPEED_CHARGE
		sta ENEMY.Plan, x

		Finish:

		//dec $d020

		rts
		
	}


	FullSpeedCharge: {

		//lda #4
		//sta $d020

		inc SpriteY, x

		lda SpriteY, x
		sec
		sbc #$60
		cmp #$40
		bcc Veer


		CheckLoop:

			lda SpriteX, x
			sec
			sbc #96
			cmp #80
			bcs Veer

		Loop:

			lda #LOOP_THE_LOOP
			sta ENEMY.Plan, x

			lda #3
			sta ENEMY.TempCounter1, x

			lda #8
			sta ENEMY.TempCounter2, x

			lda #0
			sta ENEMY.ArcTableLSB, x


			lda #8
			sta ENEMY.Angle, x

			ldy ENEMY.Targeting, x

			lda SHIP.PosX_MSB, y
			sec
			sbc SpriteX, x
			bcc Left


		Right:

			lda #1
			sta ENEMY.ArcClockwise, x

			rts


		Left:

			lda #0
			sta ENEMY.ArcClockwise, x

			rts

		Veer:

			jsr ReadyToAttack.NotRed

			lda #3
			sta ENEMY.Speed, x

			lda #100
			sta ENEMY.TempCounter1, x

			//dec $d020



		rts
	}

	AttackingAggressively: {

		lda #0
		sta ZP.Amount


		Repeat:

			inc SpriteY, x

			jsr Attack_Y_Add

			lda ENEMY.SortieCount, x
			cmp #4
			beq MaybeTowards

			cmp #5
			beq Towards

			jmp DoX

		MaybeTowards:

			lda ZP.Counter
			and #%00000001
			beq DoX

		Towards:

			ldy ENEMY.Targeting, x

			lda SHIP.PosX_MSB, y
			sec
			sbc ENEMY.PivotXValue, x
			bcc ShipToLeft

		ShipToLeft:

			dec ENEMY.PivotXValue, x
			jmp DoX


		ShipToRight:

			inc ENEMY.PivotXValue, x

		DoX:

			lda ENEMY.PivotXValue, x
			clc
			adc ENEMY.PivotXValueAdd, x
			sta SpriteX, x

		CheckOff:

			cmp #9
			bcc NotOffScreen

			cmp #11
			bcs NotOffScreen

		Off:

			lda #REACHED_BOTTOM_OF_SCREEN
			sta ENEMY.Plan, x
			rts

		NotOffScreen:

			lda SpriteY, x
			clc
			adc #64
			bcc CheckLookAt

		NearBottomOfScreen:

			lda #NEAR_BOTTOM_OF_SCREEN
			sta ENEMY.Plan, x
			rts
			

		CheckLookAt:

			lda SHIP.Active
			beq Shooting

			jsr CalculateLookAtFrame

		Shooting:	

			lda CHARGER.FlagshipHit
			bne NoShoot

		CanShoot:

			ldy CHARGER.InflightAlienShootRangeMult

			lda SpriteY, x

		RangeLoop:
	
			cmp CHARGER.InflightAlienShootExactY
			beq TrySpawn

			clc
			adc #25
			dey
			bne RangeLoop

			rts


		TrySpawn:

			jsr BOMBS.Fire


		NoShoot:

		rts



	
	}

	LoopTheLoop: {

			lda #0
			sta ZP.Amount

		Repeat:

			lda ENEMY.ArcTableLSB, x
			tay

			lda AlienArcTable, y
			sta ENEMY.MoveY

			iny
			lda AlienArcTable, y
			sta ENEMY.MoveX

		
			lda SpriteY, x
			sec
			sbc ENEMY.MoveY
			sta SpriteY, x

			lda ENEMY.ArcClockwise, x
			bne FacingRight

		FacingLeft:

			lda SpriteX, x
			clc
			adc ENEMY.MoveX
			sta SpriteX, x

		UpdateAngleLeft:

			dec ENEMY.TempCounter1, x
			bne CheckProgress

			lda #5
			sta ENEMY.TempCounter1, x

			dec ENEMY.Angle, x

			lda ENEMY.Angle, x
			bpl Okay3

			lda #16
			sta ENEMY.Angle, x

			jmp ReadyToAttack

		Okay3:

			lda ENEMY.BasePointer, x
			clc
			adc ENEMY.Angle, x
			sta SpritePointer, x

			jmp CheckProgress

		FacingRight:

			lda SpriteX_LSB, x
			sec
			sbc ENEMY.FractionSpeedX, x
			sta SpriteX_LSB, x

			lda SpriteX, x
			sbc #0
			sec
			sbc ENEMY.MoveX
			sta SpriteX, x


			dec ENEMY.TempCounter1, x
			bne CheckProgress

			lda #5
			sta ENEMY.TempCounter1, x

			inc ENEMY.Angle, x

			lda ENEMY.Angle, x
			cmp #16
			bcc Okay2

			lda #0
			sta ENEMY.Angle, x

		Okay2:

			lda ENEMY.BasePointer, x
			clc
			adc ENEMY.Angle, x
			sta SpritePointer, x

			lda ENEMY.Angle, x
			beq ReadyToAttack

			dec ENEMY.TempCounter2

		CheckProgress:

			lda ENEMY.ArcTableLSB, x
			clc
			adc #2
			sta ENEMY.ArcTableLSB, x

			rts

			//cmp #88
			//bcc Finish

		ReadyToAttack:

			lda #0
			sta ENEMY.ArcTableLSB, x

			lda #3
			sta ENEMY.TempCounter1, x

			lda #8
			sta ENEMY.TempCounter2, x
		

			lda #FLIES_IN_ARC
			sta ENEMY.Plan, x
			rts


		Finish:

		

		DontRepeat:
				


		rts
	}

	CompleteLoop: {


		rts
	}

	Unknown_1091: {


		rts
	}


}