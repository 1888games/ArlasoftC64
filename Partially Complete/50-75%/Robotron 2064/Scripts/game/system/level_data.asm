LEVEL_DATA: {

	* = * "Level Data"


	Mums:				.byte $01, $01, $02, $02, $0F, $03
						.byte $04, $03, $03, $00, $03, $03, $03, $05, $00
						.byte $03, $03, $03, $03, $08, $03, $03, $03, $03, $19, $03, $03, $03, $03, $00, $03
						.byte $03, $03, $03, $00, $03, $03, $03, $03, $0A

	Dads:

						.byte $01, $01, $02, $02, $00, $03
						.byte $04, $03, $03, $16, $03, $03, $03, $05, $00
						.byte $03, $03, $03, $03, $08, $03, $03, $03, $03, $00, $03, $03, $03, $03, $19, $03
						.byte $03, $03, $03, $00, $03, $03, $03, $03, $0A



	Kids:				.byte $00, $01, $02, $02, $01, $03
						.byte $04, $03, $03, $00, $03, $03, $03, $05, $16
						.byte $03, $03, $03, $03, $08, $03, $03, $03, $03, $01, $03, $03, $03, $03, $00, $03
						.byte $03, $03, $03, $19, $03, $03, $03, $03, $0A


// // Grunt counts
// 	2E24: 0F 11 16 22 14 20 00 23 3C 19 23 00 23 1B 19 
// 2E33: 23 00 23 46 19 23 00 23 00 19 23 00 23 4B 19 23 
// 2E43: 00 23 1E 1B 23 00 23 50 1E 

						/// change 1s to 0s
	Grunts:				.byte $0F, $11, $16, $22, $14, $20, $01, $23, $23, $19, $23, $00, $23, $1B, $19
						.byte $23, $00, $23, $46, $19, $23, $00, $23, $00, $19, $23, $00, $23, $4B, $19, $23
						.byte $00, $23, $1E, $1B, $23, $00, $23, $50, $1E


// Hulks
// 2EEC: 00 05 06 07 00 07 0C 08 04 00 08 0D 08 14 02 
// 2EFB: 03 0E 08 03 02 08 0F 08 
// 2F03: 0D 01 08 10 08 04 01 08 10 08 19 02 08 10 08 06 
// 2F13: 02 


	Hulks:				.byte $00, $05, $06, $07, $00, $07, $0C, $08, $04, $00, $08, $0D, $08, $14, $02
						.byte $03, $0E, $08, $03, $02, $08, $0F, $08
						.byte $0D, $01, $08, $10, $08, $04, $01, $08, $10, $08, $19, $02, $08, $10, $08, $06
						.byte $02

// // Brains 
// 2F14: 00 00 00 00 0F 00 00 00 00 14 00 00 00 00 14 
// 2F23: 00 00 00 
// 2F26: 00 14 00 00 00 00 15 00 00 00 00 16 00 
// 2F33: 00 00 00 17 00 00 00 00 19 


	Brains:				.byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $14, $00, $00, $00, $00, $14
						.byte $00, $00, $00
						.byte $00, $14, $00, $00, $00, $00, $00, $15, $00, $00, $00, $00, $16, $00
						.byte $00, $00, $00, $17, $00, $00, $00, $00, $19

// 	// Electrode counts
// 2E4C: 05 0F 19 19 14 19 00 
// 2E53: 19 00 14 19 00 19 05 14 19 00 19 00 14 19 00 19 
// 2E63: 00 14 19 00 19 00 14 19 00 19 00 0F 19 00 19 00 
// 2E73: 0F 



	Mines:				.byte $05, $0F, $19, $19, $14, $19, $00
						.byte $19, $00, $14, $19, $00, $19, $05, $14, $19, $00, $19, $00, $14, $19, $00, $19
						.byte $00, $14, $19, $00, $19, $00, $14, $19, $00, $19, $00, $0F, $19, $00, $19, $00

// // Spheroids
// 2F3C: 00 01 03 04 01 04 00 
// 2F43: 05 05 01 05 00 05 02 01 05 00 05 05 02 05 
// 2F51: 00 05 
// 2F53: 06 01 05 00 05 05 01 05 00 05 02 01 05 00 05 05 
// 2F63: 01 



	Spheroids:			.byte $00, $01, $03, $04, $06, $04, $00
						.byte $05, $05, $01, $05, $00, $05, $02, $01, $05, $00, $05, $05, $02, $05
						.byte $00, $05
						.byte $06, $01, $05, $00, $05, $05, $01, $05, $00, $05, $02, $01, $05, $00, $05, $05
						.byte $01

		// Quarks
// 2F64: 00 00 00 00 00 00 0A 00 00 00 00 0C 00 00 00 
// 2F73: 00 0C 00 00 00 00 0C 00 07 
// 2F7C: 00 00 0C 01 01 01 01 0D 01 02 02 02 0E 02 01 01 

	Quarks:				.byte $00, $00, $00, $00, $00, $00, $0A, $00, $00, $00, $00, $0C, $00, $00, $00
						.byte $00, $0C, $00, $00, $00, $00, $0C, $00, $07
						.byte $00, $00, $0C, $01, $01, $01, $01, $0D, $01, $02, $02, $02, $0E, $02, $01, $01




	GruntStartSpeed:	.byte 12
	GruntsPerFrame:		.byte 8



	MineType:			.byte 31, 32, 33, 34, 35, 36, 37, 38, 31, 32, 33, 34, 35, 36, 37, 38
						.byte 31, 32, 33, 34, 35, 36, 37, 38, 31, 32, 33, 34, 35, 36, 37, 38
						.byte 31, 32, 33, 34, 35, 36, 37, 38, 31, 32, 33, 34, 35, 36, 37, 38

							//    1.   2.   3.   4.   5.   6.   7.   8.   9.   10.  11.  12.  13.  14  

	// 60 fps - moving 4 pixels per frame.  Mult by 2, divide by 6 times by 5

	GruntMoveProbability://	.byte $14, $14, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0E, $0E, $0E
						//	.byte $0E, $0E, $0D, $0D, $0D, $0D, $0D, $0E, $0E, $0E, $0E, $0E, $0E, $0D, $0D, $0D
						//	.byte $0D, $0D, $0D, $0C, $0C, $0C, $0C, $0C, $0C, $0F, $03

							.byte 033, 033, 027, 025, 025, 025, 025, 025, 025, 025, 025, 023, 023, 023
							.byte 023, 023, 022, 022, 022, 022, 022, 023, 023, 023, 023, 023, 023, 022, 022, 022
							.byte 022, 022, 022, 020, 020, 020, 020, 020, 020, 025, 005 

	GruntMoveLimit:		//	.byte $0A, $09, $07, $06, $05, $05, $05, $05, $04, $04, $04, $04, $04, $04
						//	.byte $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $03, $03, $04
						//	.byte $03, $03, $03, $03, $03, $03, $03, $03, $03, $04, $03


							.byte 017, 016, 011, 010, 008, 008, 008, 008, 007, 007, 007, 007, 007, 007
							.byte 007, 007, 007, 007, 007, 007, 007, 007, 007, 007, 007, 007, 007, 005, 005, 007
							.byte 005, 005, 005, 005, 005, 005, 005, 005, 005, 007, 005




	EnforcerDropControl:	.byte $0C, $0A, $0A, $0A, $0A, $0A, $0A, $0A, $0A, $0A, $0A, $0A, $0A, $0A
							.byte $0A, $0A, $0A, $0A, $0A, $0A, $0A, $0B, $0B, $0B, $0B, $0B, $0B, $0B, $0B, $0B
							.byte $0B, $0B, $0B, $0B, $0B, $0B, $0B, $0B, $0B, $0B, $0B


	EnforcerFireControl:	.byte $28, $1E, $1C, $1A, $18, $16, $14, $12, $12, $10, $0E, $0E, $0E, $0E
							.byte $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F
							.byte $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E


	EnforcerSpawnControl:	.byte $28, $1E, $1C, $1A, $18, $1E, $14, $12, $10, $12, $19, $0C, $0C, $0C
							.byte $19, $19, $0C, $0C, $0C, $12, $14, $0E, $0E, $0E, $0E, $0E, $19, $0E, $0E, $12
							.byte $19, $0C, $0C, $0C, $0C, $19, $0C, $0C, $0C, $12, $14


	HulkSpeed:				.byte $09, $08, $08, $07, $07, $07, $07, $07, $06, $06, $06, $06, $05, $05
							.byte $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05 
							.byte $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05


	BrainFireControl:		.byte $50, $40, $40, $40, $40, $40, $28, $28, $26, $26, $26, $26, $26, $26
							.byte $26, $26, $26, $24, $24, $24, $24, $20, $20, $20, $20, $20, $20, $20, $1E, $1E
							.byte $1E, $1E, $1E, $19, $19, $19, $19, $19, $19, $19, $19


	BrainSpeedControl:		.byte $0A, $08, $08, $08, $08, $08, $07, $07, $07, $07, $07, $07, $07, $07
							.byte $07, $07, $06, $06, $06, $06, $06, $06, $06, $06, $06, $06, $06, $06, $06, $06
							.byte $06, $06, $06, $06, $06, $06, $06, $06, $06, $06, $06


	TankShellControl:		.byte $28, $20, $20, $20, $20, $20, $20, $20, $1E
							.byte $1E, $1E, $1E, $1E, $1E, $1C, $1C, $1C, $1C, $1C, $1C, $1C, $1E, $1E, $1E, $1E
							.byte $1E, $1E, $1C, $1C, $1C, $1C, $1C, $1A, $1A, $1A, $1A, $1A, $18, $18, $18, $18


	TankSpawnControl:		.byte $30, $10, $10
							.byte $10, $10, $10, $10, $10, $10, $10, $10, $10, $10, $10, $10, $0F, $0F, $0F, $0F
							.byte $0F, $0F, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E
							.byte $0E, $0E, $0E, $0E, $0E, $0E



	CurrentLevel:			.byte 0
	CurrentWave:			.byte 1
	TotalSprites:			.byte 0


	NewLevel: {


		ldx CurrentLevel

		GruntData:

			lda Grunts, x
			sta GRUNT.NumberToGenerate
			sta GRUNT.NumberRemaining

			lda GruntMoveProbability, x
			lsr
			sta GRUNT.MoveProbability

			lda GruntMoveLimit, x
			//lsr
			sta GRUNT.MoveLimit

			lda GruntStartSpeed, x
			lsr
			sta GRUNT.ProcessTime

			lda GruntsPerFrame, x
			sta GRUNT.PerFrame

		EnforcerSpheroidData:

			lda EnforcerDropControl, x
			sta SPHEROID.MaxEnforcerCount

			lda EnforcerFireControl, x
			lsr
			sta ENFORCER.MaxFireTime

			lda EnforcerSpawnControl, x
			lsr
			sta SPHEROID.MaxEnforcerTime
			lsr 
			sta SPHEROID.FollowEnforcerTime

			lda Spheroids, x
			sta SPHEROID.NumberToGenerate
			sta SPHEROID.NumberRemaining

		Brain_Data:

			lda BrainFireControl, x
			lsr
			sta BRAIN.MaxFireTime
			
			lda Brains, x
			sta BRAIN.NumberToGenerate

		Mine_Data:

			lda Mines, x
			sta MINE.NumberToGenerate

			lda MineType, x
			sta MINE.CurrentType

		Hulk_Data:

			lda Hulks, x
			sta HULK.NumberToGenerate

			lda HulkSpeed, x
			sec
			sbc #1
			lsr
			sta HULK.Speed

		
		jsr SHARED.SetupData
		jsr HUMANS.SetupLevel


		rts


	}

	RandomLevel: {

		jsr RANDOM.Get
		and #%00001111
		clc
		adc #10
		sta GRUNT.NumberRemaining
		sta GRUNT.NumberToGenerate

		jsr RANDOM.Get
		and #%00001111
		sta MINE.NumberToGenerate

		jsr RANDOM.Get
		and #%00001111
		sta HULK.NumberToGenerate
		sta TotalSprites

		jsr RANDOM.Get
		and #%00000011
		clc
		adc #1
		sta SPHEROID.NumberRemaining
		sta SPHEROID.NumberToGenerate
		adc TotalSprites
		sta TotalSprites

		lda #1
		sta Dads
		sta Kids
		sta Mums

		lda #27
		sec
		sbc TotalSprites
		tax
		bmi EndLoop

		Loop:

			jsr RANDOM.Get
			cmp #86
			bcc DoDad

			cmp #172
			bcc DoMum

			inc Kids
			jmp EndLoop

		DoMum:

			inc Mums
			jmp EndLoop


		DoDad:

			inc Dads

		EndLoop:

			dex
			bpl Loop



		rts
	}

	NextLevel: {	

		//jsr TASK.ClearFunctions
		jsr GRUNT.NextLevel
		jsr SPHEROID.NextLevel

		//inc CurrentWave

		inc CurrentLevel
		lda CurrentLevel
		cmp #7
		bcc Okay

		lda #0
		sta CurrentLevel

		Okay:



		rts
	}

}

