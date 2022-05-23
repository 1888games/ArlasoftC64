.namespace ENEMY {

	* = * "Enemy Variables"

	Angle:					.fill MAX_ENEMIES, 0

	FractionSpeedX:			.fill MAX_ENEMIES, 0
	FractionSpeedY:			.fill MAX_ENEMIES, 0

	ExplosionTimer:			.fill MAX_ENEMIES, 0
	ExplosionProgress:		.fill MAX_ENEMIES, 0
	BasePointer:			.fill MAX_ENEMIES, 0

	* = * "Plan"
	
	Plan:					.fill MAX_ENEMIES, 0
	Slot:					.fill MAX_ENEMIES, 0

	* = * "Extra"


	ArcClockwise:			.fill MAX_ENEMIES, 0
	SortieCount:			.fill MAX_ENEMIES, 0
	Speed:					.fill MAX_ENEMIES, 0
	Type:					.fill MAX_ENEMIES, 0
	AnimFrameStartCode:		.fill MAX_ENEMIES, 0
	TempCounter1:			.fill MAX_ENEMIES, 0
	TempCounter2:			.fill MAX_ENEMIES, 0
	ArcTableLSB:			.fill MAX_ENEMIES, 0
	PivotXValueAdd:			.fill MAX_ENEMIES, 0
	PivotXValue:			.fill MAX_ENEMIES, 0
	Inflight_S19:			.fill MAX_ENEMIES, 0
	Inflight_S1A:			.fill MAX_ENEMIES, 0
	Inflight_S1B:			.fill MAX_ENEMIES, 0
	Inflight_S1C:			.fill MAX_ENEMIES, 0
	ShootExactY:			.fill MAX_ENEMIES, 0
	ShootRangeMult:			.fill MAX_ENEMIES, 0
	XOffset:				.fill MAX_ENEMIES, 0
	Targeting:				.fill MAX_ENEMIES, 0


	Quadrant:			.byte 0
	Repeated:				.byte 0

	* = * "Enemies In Wave"


	MoveX:				.byte 0
	MoveY:				.byte 0

	* = * "Enemy Ship ID"

	NextSpawnValue:		.byte 0

	EnemyTypeSFX:		.byte 0, 0, 1, 2, 1, 10

	


}