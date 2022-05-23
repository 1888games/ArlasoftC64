LEVEL_DATA: {

	* = * "Level Data"


	Dads:				.byte 01
	Mums:				.byte 01
	Kids:				.byte 00

	Grunts:				.byte 16
	MaxGrunts:			.byte 16
	GruntStartSpeed:	.byte 24
	GruntsPerFrame:		.byte 8
	Mines:				.byte 5
	MineType:			.byte 5

	

	CurrentLevel:			.byte 0


	NewLevel: {

		ldx CurrentLevel

		lda Grunts, x
		sta GRUNT.NumberToGenerate

		lda MaxGrunts, x
		sta GRUNT.MaxGrunts

		lda GruntStartSpeed, x
		sta GRUNT.ProcessTime

		lda GruntsPerFrame, x
		sta GRUNT.PerFrame

		lda Mines, x
		sta MINE.NumberToGenerate

		lda MineType, x
		sta MINE.CurrentType

		jsr HUMANS.SetupLevel


		rts


	}


}