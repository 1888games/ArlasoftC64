.namespace FIGHTER {


	Idle_Head_Out: 			.byte 038, 000, 032, 000
	Idle_Torso_Out:			.byte 044, 000, 041, 000
	Idle_Left_Hand_Out:		.byte 030, 000, 000, 000
	Idle_Right_Hand_Out:	.byte 078, 000, 085, 000
	Idle_Left_Foot_Out:		.byte 000, 000, 000, 000
	Idle_Right_Foot_Out:	.byte 035, 000, 000, 000

	
	Punch_Head_StartX: 			.byte 000, 000
	Punch_Torso_StartX:			.byte 000, 000
	Punch_Left_Hand_StartX:		.byte 000, 000
	Punch_Right_Hand_StartX:	.byte 000, -6
	Punch_Left_Foot_StartX:		.byte 000, 000
	Punch_Right_Foot_StartX:	.byte 000, 000
	
	Punch_Head_Out: 		.byte 000, 000, 000, 000
	Punch_Torso_Out:		.byte 000, 000, 000, 000
	Punch_Left_Hand_Out:	.byte 150, 150, 000, 000
	Punch_Right_Hand_Out:	.byte 010, 006, 000, 000
	Punch_Left_Foot_Out:	.byte 000, 000, 000, 000
	Punch_Right_Foot_Out:	.byte 150, 000, 000, 000

							 	// XF  XP   YF   YP
	Kick_Head_Out: 			.byte 100, 150, 080, 000
	Kick_Torso_Out:			.byte 090, 150, 070, 000
	Kick_Left_Hand_Out:		.byte 150, 150, 000, 000
	Kick_Right_Hand_Out:	.byte 090, 150, 080, 150
	Kick_Left_Foot_Out:		.byte 060, 000, 000, 000
	Kick_Right_Foot_Out:	.byte 000, 003, 000, -04



	Animations_LSB:			.byte <Idle_Head_Out, <Idle_Head_Out, <Punch_Head_StartX, <Punch_Head_Out, <Punch_Head_Out
							

							.byte <Kick_Head_Out, <Kick_Head_Out

	Animations_MSB:			.byte >Idle_Head_Out, >Idle_Head_Out, >Punch_Head_StartX, >Punch_Head_Out, >Punch_Head_Out
							
							.byte >Kick_Head_Out, >Kick_Head_Out


	AnimationComplete:		.byte 1, 0, 3, 4, 0, 6, 0
	AnimationFrames:		.byte 14, 14, 0, 4, 4, 6, 6
	AnimationReverse:		.byte 0, 1, 255, 0, 1, 0, 1
	AnimationReset:			.byte 1, 0, 1, 0, 0, 1, 0




}