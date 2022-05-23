
	* = $5400 "8-bit sample data"

	
.align $100
	SMP_Fire:			.import binary "../assets/samples/FirePlayer.smp"
	SMP_Explode:		.import binary "../assets/samples/Explode1.smp"
	SMP_Destroy:		.import binary "../assets/samples/Destroy.smp"
	SMP_The:			.import binary "../assets/samples/The.smp"	
	SMP_Intruder:		.import binary "../assets/samples/Intruder.smp"
	SMP_Fight:			.import binary "../assets/samples/Fight.smp"
	SMP_Like:			.import binary "../assets/samples/Like.smp"
	SMP_A:				.import binary "../assets/samples/A.smp"
	SMP_Robot:			.import binary "../assets/samples/Robot.smp"
	SMP_Alert:			.import binary "../assets/samples/Alert.smp"
	SMP_Must:			.import binary "../assets/samples/Must.smp"
	SMP_Not:			.import binary "../assets/samples/Not.smp"
	SMP_Escape:			.import binary "../assets/samples/Escape.smp"
	SMP_Humanoid:		.import binary "../assets/samples/Humanoid.smp"
	SMP_It:				.import binary "../assets/samples/It.smp"
	SMP_Attack:			.import binary "../assets/samples/Attack.smp"
	SMP_Charge:			.import binary "../assets/samples/Charge.smp"
	SMP_Chicken:		.import binary "../assets/samples/Chicken.smp"
	SMP_Got:			.import binary "../assets/samples/Got.smp"
	SMP_Kill:			.import binary "../assets/samples/Kill.smp"
	SMP_In:				.import binary "../assets/samples/In.smp"
	SMP_Coins:			.import binary "../assets/samples/Coins.smp"
	SMP_Pocket:			.import binary "../assets/samples/Pocket.smp"

	SMP_Done1:

* = $c400 "Die"
	.align $100
	SMP_Die:			.import binary "../assets/samples/Die.smp"
	SMP_Done2:

* = $e000 "More Samples"
.align $100
	SMP_Detected:			.import binary "../assets/samples/Detected.smp"
	SMP_FireRobot:		.import binary "../assets/samples/FireRobot.smp"
	SMP_Shoot:			.import binary "../assets/samples/Yes.smp"
	SMP_Life:			.import binary "../assets/samples/Life.smp"

	SMP_Done:



	// 


.label W_FIRE = 0
.label W_EXPLODE = 1
.label W_DESTROY = 2
.label W_THE = 3
.label W_INTRUDER = 4

.label W_FIGHT = 5
.label W_LIKE = 6
.label W_A = 7
.label W_ROBOT = 8
.label W_ALERT = 9
.label W_MUST = 10
.label W_NOT = 11
.label W_ESCAPE = 12
.label W_HUMANOID = 13
.label W_IT = 14
.label W_ATTACK = 15
.label W_CHARGE = 16
.label W_CHICKEN = 17
.label W_GOT = 18
.label W_KILL = 19
.label W_DETECTED = 20
.label W_SHOOT = 21
.label W_FIRE_ROBOT = 22
.label W_DIE = 25
.label W_COINS = 23
.label W_POCKET = 24
.label W_IN = 26
.label W_LIFE = 27

.label S_FIRE = 0
.label S_EXPLODE = 1
.label S_DESTROY_INTRUDER = 2
.label S_FIGHT_ROBOT = 3
.label S_FIRE_ROBOT = 36
.label S_GOT_PLAYER = 37
.label S_LIFE = 41
.label S_CHICKEN = 42
.label S_DIE = 43

SPEECH: {

	Cooldown:				.byte 0
	SequencePosition:		.byte 255
	SequenceLength:			.byte 3
	IsChicken:				.byte 0
	Died:					.byte 0


	* = $519 "Speech Code" 


	Begin_LSB:		.byte <SMP_Fire, <SMP_Explode, <SMP_Destroy, <SMP_The, <SMP_Intruder, <SMP_Fight, <SMP_Like, <SMP_A, <SMP_Robot, <SMP_Alert
					.byte <SMP_Must, <SMP_Not, <SMP_Escape, <SMP_Humanoid, <SMP_It, <SMP_Attack, <SMP_Charge, <SMP_Chicken, <SMP_Got, <SMP_Kill, <SMP_Detected, <SMP_Shoot, <SMP_FireRobot
					.byte <SMP_Coins, <SMP_Pocket, <SMP_Die, <SMP_In, <SMP_Life

	Begin_MSB:		.byte >SMP_Fire, >SMP_Explode, >SMP_Destroy, >SMP_The, >SMP_Intruder, >SMP_Fight, >SMP_Like, >SMP_A, >SMP_Robot, >SMP_Alert
					.byte >SMP_Must, >SMP_Not, >SMP_Escape, >SMP_Humanoid, >SMP_It, >SMP_Attack, >SMP_Charge, >SMP_Chicken, >SMP_Got, >SMP_Kill, >SMP_Detected, >SMP_Shoot, >SMP_FireRobot
					.byte >SMP_Coins, >SMP_Pocket, >SMP_Die, >SMP_In, >SMP_Life

	End_MSB:		.byte >SMP_Explode, >SMP_Destroy, >SMP_The, >SMP_Intruder, >SMP_Fight, >SMP_Like, >SMP_A, >SMP_Robot, >SMP_Alert, >SMP_Must
					.byte >SMP_Not, >SMP_Escape, >SMP_Humanoid, >SMP_It, >SMP_Attack, >SMP_Charge, >SMP_Chicken, >SMP_Got, >SMP_Kill, >SMP_In, >SMP_FireRobot, >SMP_Life,>SMP_Shoot
					.byte >SMP_Pocket, >SMP_Done1, >SMP_Done2, >SMP_Coins, >SMP_Done



	SampleSequence:		.fill 8, 0


	// 0-2
	SEQ_FIRE:					.byte W_FIRE
	SEQ_EXPLODE:				.byte W_EXPLODE													
	SEQ_DESTROY_THE_INTRUDER:	.byte W_DESTROY, W_THE, W_INTRUDER						

	// 3-5
	SEQ_FIGHT_LIKE_A_ROBOT:		.byte W_FIGHT, W_LIKE, W_A, W_ROBOT
	SEQ_INTRUDER_ALERT:			.byte W_INTRUDER, W_ALERT, W_INTRUDER, W_ALERT
	//SEQ_INTRUDER_ALERT:			.byte W_INTRUDER, W_ALERT

	// 6-9
	SEQ_INTRUDER_DETECTED:		.byte W_INTRUDER, W_DETECTED
	SEQ_HUMANOID_DETECTED:		.byte W_HUMANOID, W_DETECTED
	SEQ_KILL_THE_HUMANOID:		.byte W_KILL, W_THE, W_HUMANOID
	SEQ_KILL_IT:				.byte W_KILL, W_IT

	// 10-13
	SEQ_KILL_THE_CHICKEN:		.byte W_KILL, W_THE, W_CHICKEN
	SEQ_KILL_THE_INTRUDER:		.byte W_KILL, W_THE, W_INTRUDER
	SEQ_THE_HUMANOID_MUST:		.byte W_THE, W_HUMANOID, W_MUST, W_NOT, W_ESCAPE
	SEQ_IT_MUST:				.byte W_IT, W_MUST, W_NOT, W_ESCAPE

	// 14-17
	SEQ_ATCK_THE_HUMANOID:		.byte W_ATTACK, W_THE, W_HUMANOID
	SEQ_ATCK_IT:				.byte W_ATTACK, W_IT
	SEQ_ATCK_THE_CHICKEN:		.byte W_ATTACK, W_THE, W_CHICKEN
	SEQ_ATCK_THE_INTRUDER:		.byte W_ATTACK, W_THE, W_INTRUDER

	// 18-20
	SEQ_DEST_THE_HUMANOID:		.byte W_DESTROY, W_THE, W_HUMANOID
	SEQ_DEST_IT:				.byte W_DESTROY, W_IT
	SEQ_DEST_THE_CHICKEN:		.byte W_DESTROY, W_THE, W_CHICKEN

	// 21-24
	SEQ_CHGR_THE_HUMANOID:		.byte W_CHARGE, W_THE, W_HUMANOID
	SEQ_CHGR_IT:				.byte W_CHARGE, W_IT
	SEQ_CHGR_THE_CHICKEN:		.byte W_CHARGE, W_THE, W_CHICKEN
	SEQ_CHGR_THE_INTRUDER:		.byte W_CHARGE, W_THE, W_INTRUDER

	// 25-28
	SEQ_CHIC_ESCAPE:			.byte W_THE, W_CHICKEN, W_MUST, W_NOT, W_ESCAPE
	SEQ_INTR_ESCAPE:			.byte W_THE, W_INTRUDER, W_MUST, W_NOT, W_ESCAPE
	SEQ_FIGHT_THE_HUMAN:		.byte W_FIGHT, W_THE, W_HUMANOID
	SEQ_FIGHT_THE_INTRUDER:		.byte W_FIGHT, W_THE, W_INTRUDER

	// 29-31
	SEQ_HUMAN_ATTACK:			.byte W_HUMANOID, W_ATTACK, W_ROBOT
	SEQ_INTRU_ATTACK:			.byte W_INTRUDER, W_ATTACK, W_ROBOT
	SEQ_ROBOT_ATTACK:			.byte W_THE, W_HUMANOID, W_MUST,W_NOT,W_DESTROY,W_THE,W_ROBOT


	// 32-34
	SEQ_SHOT_THE_HUMANOID:		.byte W_SHOOT, W_THE, W_HUMANOID
	SEQ_SHOT_THE_CHICKEN:		.byte W_SHOOT, W_THE, W_CHICKEN
	SEQ_SHOT_THE_INTRUDER:		.byte W_SHOOT, W_THE, W_INTRUDER


	SEQ_COINS_POCKET:			.byte W_COINS, W_DETECTED, W_IN, W_POCKET

	SEQ_ROBOT_FIRE:				.byte W_FIRE_ROBOT


	SEQ_GOT_THE_HUMANOID:		.byte W_GOT, W_THE, W_HUMANOID
	SEQ_GOT_THE_CHICKEN:		.byte W_GOT, W_THE, W_CHICKEN
	SEQ_GOT_THE_INTRUDER:		.byte W_GOT, W_THE, W_INTRUDER
	SEQ_GOT_IT:					.byte W_GOT, W_IT
	SEQ_LIFE:					.byte W_LIFE

	SEQ_CHICKEN_ROBOT:			.byte W_CHICKEN, W_FIGHT, W_LIKE, W_A, W_ROBOT

	SEQ_DIE:					.byte W_DIE


	Sequences_LSB:		.byte <SEQ_FIRE, <SEQ_EXPLODE, <SEQ_DESTROY_THE_INTRUDER
						.byte <SEQ_FIGHT_LIKE_A_ROBOT, <SEQ_INTRUDER_ALERT, <SEQ_INTRUDER_ALERT
						.byte <SEQ_INTRUDER_DETECTED, <SEQ_HUMANOID_DETECTED, <SEQ_KILL_THE_HUMANOID, <SEQ_KILL_IT
						.byte <SEQ_KILL_THE_CHICKEN, <SEQ_KILL_THE_INTRUDER, <SEQ_THE_HUMANOID_MUST, <SEQ_IT_MUST
						.byte <SEQ_ATCK_THE_HUMANOID, <SEQ_ATCK_IT, <SEQ_ATCK_THE_CHICKEN, <SEQ_ATCK_THE_INTRUDER
						.byte <SEQ_DEST_THE_HUMANOID, <SEQ_DEST_IT, <SEQ_DEST_THE_CHICKEN
						.byte <SEQ_CHGR_THE_HUMANOID, <SEQ_CHGR_IT, <SEQ_CHGR_THE_CHICKEN, <SEQ_CHGR_THE_INTRUDER
						.byte <SEQ_CHIC_ESCAPE, <SEQ_INTR_ESCAPE, <SEQ_FIGHT_THE_HUMAN, <SEQ_FIGHT_THE_INTRUDER
						.byte <SEQ_HUMAN_ATTACK, <SEQ_INTRU_ATTACK, <SEQ_ROBOT_ATTACK
						.byte <SEQ_SHOT_THE_HUMANOID, <SEQ_SHOT_THE_CHICKEN, <SEQ_SHOT_THE_INTRUDER
						.byte <SEQ_COINS_POCKET, <SEQ_ROBOT_FIRE
						.byte <SEQ_GOT_THE_HUMANOID, <SEQ_GOT_THE_CHICKEN, <SEQ_GOT_THE_INTRUDER, <SEQ_GOT_IT
						.byte <SEQ_LIFE, <SEQ_CHICKEN_ROBOT, <SEQ_DIE
	


	Sequences_MSB:		.byte >SEQ_FIRE, >SEQ_EXPLODE, >SEQ_DESTROY_THE_INTRUDER
						.byte >SEQ_FIGHT_LIKE_A_ROBOT, >SEQ_INTRUDER_ALERT, >SEQ_INTRUDER_ALERT
						.byte >SEQ_INTRUDER_DETECTED,  >SEQ_HUMANOID_DETECTED, >SEQ_KILL_THE_HUMANOID, >SEQ_KILL_IT
						.byte >SEQ_KILL_THE_CHICKEN, >SEQ_KILL_THE_INTRUDER, >SEQ_THE_HUMANOID_MUST, >SEQ_IT_MUST
						.byte >SEQ_ATCK_THE_HUMANOID, >SEQ_ATCK_IT, >SEQ_ATCK_THE_CHICKEN, >SEQ_ATCK_THE_INTRUDER
						.byte >SEQ_DEST_THE_HUMANOID, >SEQ_DEST_IT, >SEQ_DEST_THE_CHICKEN
						.byte >SEQ_CHGR_THE_HUMANOID, >SEQ_CHGR_IT, >SEQ_CHGR_THE_CHICKEN, >SEQ_CHGR_THE_INTRUDER
						.byte >SEQ_CHIC_ESCAPE, >SEQ_INTR_ESCAPE, >SEQ_FIGHT_THE_HUMAN, >SEQ_FIGHT_THE_INTRUDER
						.byte >SEQ_HUMAN_ATTACK, >SEQ_INTRU_ATTACK, >SEQ_ROBOT_ATTACK
						.byte >SEQ_SHOT_THE_HUMANOID, >SEQ_SHOT_THE_CHICKEN, >SEQ_SHOT_THE_INTRUDER
						.byte >SEQ_COINS_POCKET, >SEQ_ROBOT_FIRE
						.byte >SEQ_GOT_THE_HUMANOID, >SEQ_GOT_THE_CHICKEN, >SEQ_GOT_THE_INTRUDER, >SEQ_GOT_IT
						.byte >SEQ_LIFE, >SEQ_CHICKEN_ROBOT, >SEQ_DIE

						
						//.   0. 1  2. 3. 4. 5. 6. 7. 8  9. 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43
	Sequences_Length:	.byte 1, 1, 3, 4, 4, 2, 2, 2, 3, 2, 3, 3, 5, 4, 3, 2, 3, 3, 3, 2, 3, 3, 2, 3, 3, 5, 5, 3, 3, 3, 3, 7, 3, 3, 3, 4, 1, 3, 3, 3, 2, 1, 5, 1

	CanOverride:		.byte 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1
	VariableFreq:		.byte 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 1, 1, 1, 1, 1, 1, 1
	OnlyWhenChicken:	.byte 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0


	.label MAX_SPEECH = 34



	FrameUpdate: {

		jsr CheckReduce

		lda SAMPLER.SampleComplete
		bmi ReadyToPlay

		beq Finish

		inc SequencePosition
		lda SequencePosition
		cmp SequenceLength
		bcc ReadyToPlay


		lda #255
		sta SequencePosition
		sta SAMPLER.SampleComplete
		sta ZP.CurrentSample

		lda ZP.Died
		beq NotDead

		jmp RobotBrag

	NotDead:


	ReadyToPlay:

		ldx SequencePosition
		bpl CarryOn

		jmp RandomSpeech

		CarryOn:

			lda SampleSequence, x
			tax

			sei
			lda Begin_LSB, x
			sta SAMPLER.nmi.offset + 1
			lda Begin_MSB, x
			sta SAMPLER.nmi.offset + 2
			lda End_MSB, x
			sta SAMPLER.nmi.endOffset + 1
			jsr SAMPLER.Init



		Finish:

		rts
	}

	RobotBrag: {

		dec ZP.Died

		jsr RANDOM.Get
		and #%00000011
		clc
		adc #S_GOT_PLAYER
		tay

		jsr StartSequence

		rts
	}

	GotPlayer: {

		ldy #S_DIE

		jsr StartSequence

		inc ZP.Died
	
		rts
	}


	RandomSpeech: {

		lda MAIN.GameMode
		cmp #GAME_MODE_PLAY
		bne NoSpeech

		lda Cooldown
		beq Ready

		dec Cooldown
		rts

		Ready:

		jsr RANDOM.Get
		cmp #3
		bcs NoSpeech

		Again:

		jsr RANDOM.Get
		and #%00011111
		clc
		adc #2
		cmp #MAX_SPEECH
		bcs Again
		tay

		

		lda OnlyWhenChicken, y
		beq NoChickenCheck

		lda IsChicken
		beq Again

		NoChickenCheck:

		
		jsr StartSequence

		lda #60
		sta Cooldown




		NoSpeech:


		rts
	}

	StartSequence: {

		lda SequencePosition
		bmi Okay

		lda CanOverride, y
		beq Finish


		Okay:	

		sty ZP.CurrentSample

		cpy #S_DIE
		bne NotDead

		lda #1
		sta ZP.Frequency + 1

		lda #250
		sta ZP.Frequency

		jmp SkipFreq


	NotDead:
		cpy #35
		bne NotTitle

		lda #1
		sta ZP.Frequency + 1

		lda #50
		sta ZP.Frequency

		jmp SkipFreq

		NotTitle:

		lda #1
		sta ZP.Frequency + 1

		lda #100
		sta ZP.Frequency

		lda VariableFreq, y
		beq SkipFreq

		jsr RANDOM.Get
		and #%01111111
		sta ZP.Frequency

		SkipFreq:


		lda Sequences_Length, y
		sta SequenceLength

		lda Sequences_LSB, y
		sta ZP.DataAddress

		lda Sequences_MSB, y
		sta ZP.DataAddress + 1


		ldy #0

		Loop:

			lda (ZP.DataAddress), y
			sta SampleSequence, y

			iny
			cpy SequenceLength
			bcc Loop

		lda #0
		sta SequencePosition

		lda #255
		sta SAMPLER.SampleComplete

		Finish:

		rts
	}
}