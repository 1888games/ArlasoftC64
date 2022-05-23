

* = * "WaveMovement"





// 5, 13, 18, 18, 13, 128, 128, 128, 128, 128, 128, 128, 128, 128, 128, 128, 128, 128, 128, 128, 128, 128, 128, 128, 128
// Mir_YBee_Bottom_Circle: .byte 15, 11, 4, -4, -11

* = * "XPaths"

					// 0 			1 				2 					3 					4  					5 						6 			7			
X_Paths:	
* = * "YPaths"

Y_Paths:	

* = * "WaveStartPos"
WaveStartPos: 	





AllowDelaySkip:	.fill 12, 1
				.byte 1, 1, 1, 1
				.byte 1, 1, 1, 1
				.byte 0, 0, 1, 1




* = * "StagesIndex"
//StagesIndex0:	.byte 17, 0, 3, 20, 3, 20, 17, 0, 17, 0
//StagesIndex1:	.byte 2, 19, 4, 5, 21, 26, 1, 2, 18, 19
//StagesIndex2:	.byte 17, 0, 3, 3, 20, 20, 0, 0, 17, 17

StagesIndex0:	.byte 1, 0, 6, 7, 6, 7, 1, 0, 1, 0
StagesIndex1:	.byte 4, 5, 8, 10, 9, 11, 2, 4, 3, 5 
StagesIndex2:	.byte 1, 0, 6, 6, 6, 7, 0, 0, 1, 1
//StagesIndex2:	.byte 1, 0, 1, 0, 1, 0, 1, 0, 1, 0

//StagesIndex2:	.byte 6, 6, 6, 6, 6, 6, 6, 6, 6, 6
Challenge1:		.byte 12, 13, 14, 15, 15, 15, 13, 13, 12, 12
Challenge2:		.byte 16, 17, 18, 19, 18, 19, 17, 17, 16, 16
Challenge3:		.byte 21, 20, 22, 23, 22, 23, 21, 20, 21, 20
Challenge4:		.byte 42, 43, 44, 44, 45, 45, 42, 43, 46, 47
Challenge5:		.byte 48, 48, 50, 50, 51, 51, 48, 48, 49, 49
Challenge6:		.byte 52, 52, 54, 55, 54, 55, 53, 53, 52, 52
Challenge7:		.byte 56, 56, 58, 58, 59, 59, 57, 57, 56, 56
Challenge8:		.byte 60, 61, 62, 62, 63, 63, 60, 61, 60, 61
		//48, 48, 50, 50, 48, 48, 48, 48, 48, 48



* = * "StagesIndexLookup"
StageIndexLookup:	.word StagesIndex0, StagesIndex1, StagesIndex2
					.word Challenge1, Challenge2, Challenge3
					.word Challenge4, Challenge5, Challenge6, Challenge7, Challenge8

SpawnKind:		.byte ENEMY_MOTH, ENEMY_HORNET, ENEMY_BOSS, ENEMY_MOTH, ENEMY_MOTH, ENEMY_MOTH, ENEMY_HORNET, ENEMY_HORNET

SpawnKind_1:	.byte ENEMY_HORNET, ENEMY_HORNET, ENEMY_BOSS, ENEMY_HORNET, ENEMY_HORNET, ENEMY_HORNET, ENEMY_HORNET, ENEMY_HORNET, ENEMY_HORNET, ENEMY_HORNET
SpawnKind_2:	.byte ENEMY_MOTH, ENEMY_MOTH, ENEMY_BOSS, ENEMY_MOTH, ENEMY_MOTH, ENEMY_MOTH, ENEMY_MOTH, ENEMY_MOTH, ENEMY_MOTH, ENEMY_MOTH
SpawnKind_3:	.byte ENEMY_DRAGONFLY, ENEMY_DRAGONFLY, ENEMY_BOSS, ENEMY_DRAGONFLY, ENEMY_DRAGONFLY, ENEMY_DRAGONFLY, ENEMY_DRAGONFLY, ENEMY_DRAGONFLY, ENEMY_DRAGONFLY, ENEMY_DRAGONFLY


ChallengeSpawn:	.word Kind_Order_1, Kind_Order_2,Kind_Order_3,Kind_Order_3,Kind_Order_3,Kind_Order_3,Kind_Order_3,Kind_Order_3


SpawnOrder:		.byte 7, 24, 8, 25, 15, 34, 16, 35, 0, 6, 1, 9, 2, 14, 3, 17, 10, 11, 18, 19, 4, 5, 12, 13, 26, 27, 36, 37, 22, 23, 32, 33, 20, 21, 30, 31, 28, 29, 38, 39


KindOrder:	




Kind_Order_1:	


Kind_Order_2:	

Kind_Order_3:	


// ; 0: parameter for set bomb drop enable flags
// ; 1: parameter for setting launch counter, bomber-type 0
// ; 2: parameter for setting launch counter, bomber-type 1
// ; 3: parameter for setting launch counter, bomber-type 2
// ; 4: allowable max_bombers
// ; 5: increases allowable max_bombers after a time
// ; 6: ds_plyr_actv +_b_captr_flag
// ; 7: number of aliens left when continous bombing can start
// ; 8: flag for reload attack-wave flite vector table pointer after stage-8
// ; 9: flag for reload bombing flite vector table pointer after stage-8

// Left Nibbles											Right Nibbles									
// 0	0	2	12	0	0	1	2	12	0		0	0	2	6	0	0	1	3	7	0
// 0	0	0	12	0	1	1	2	9	0		0	0	0	0	0	1	2	3	7	0
// 1	2	2	9	0	2	2	3	9	0		1	3	3	8	0	1	4	3	8	0
// 0	0	0	9	0	2	2	3	9	1		0	0	0	0	0	2	5	3	9	0
// 2	3	3	6	1	1	1	2	9	0		2	6	4	9	0	0	1	3	7	0
// 0	0	0	6	0	3	4	3	6	1		0	0	0	0	0	2	6	4	7	1
// 3	6	4	6	1	3	6	4	6	1		2	7	4	8	1	2	7	5	8	1
// 0	0	0	6	0	4	7	4	6	1		0	0	0	0	0	2	8	5	9	1
// 4	7	4	6	1	1	2	2	9	1		2	8	5	9	1	1	2	3	7	1
// 0	0	0	6	0	5	8	4	3	1		0	0	0	0	0	2	8	6	10	1
// 5	8	5	3	1	5	8	5	3	1		2	8	6	10	1	2	8	6	12	1
// 0	0	0	3	0	6	8	5	3	1		0	0	0	0	0	2	9	7	12	1
// 6	9	5	3	1	6	9	5	3	1		2	9	7	12	1	2	9	7	12	1
// 0	0	0	0	0	0	0	0	0	0		0	0	0	0	0	0	0	0	0	0
// 0	0	1	12	0	0	1	2	12	0		0	0	2	6	0	0	1	2	6	0
// 0	0	0	12	0	1	1	2	9	0		0	0	0	0	0	1	2	3	7	0
// 1	1	2	9	0	0	1	2	12	0		1	2	3	7	0	0	1	3	7	0
// 0	0	0	9	0	2	2	3	9	1		0	0	0	0	0	1	3	3	8	0
// 2	2	3	9	1	2	2	3	9	1		1	4	3	8	0	1	5	4	8	0
// 0	0	0	6	0	2	2	3	6	1		0	0	0	0	0	2	5	4	8	1
// 3	3	4	6	1	1	1	2	6	0		2	6	4	8	1	1	1	3	7	1
// 0	0	0	6	0	3	3	4	6	1		0	0	0	0	0	2	6	5	8	1
// 3	4	4	6	1	3	6	4	6	1		2	6	5	9	1	2	7	5	9	1
// 0	0	0	6	0	4	6	4	3	1		0	0	0	0	0	2	7	6	10	1
// 4	7	5	3	1	5	7	5	3	1		2	8	6	10	1	2	8	6	10	1
// 0	0	0	3	0	5	8	5	3	1		0	0	0	0	0	2	8	6	12	1
// 6	9	5	3	1	6	9	5	3	1		2	9	7	12	1	2	9	7	12	1
// 0	0	0	0	0	0	0	0	0	0		0	0	0	0	0	0	0	0	0	0
// 0	0	2	12	0	1	1	2	9	0		0	0	3	6	0	0	1	3	7	0
// 0	0	0	12	0	1	1	3	9	0		0	0	0	0	0	1	2	3	8	0
// 2	2	3	6	0	2	2	3	6	0		1	3	4	8	0	1	4	4	8	0
// 0	0	0	9	0	3	3	3	6	1		0	0	0	0	0	2	6	4	7	0
// 3	4	4	6	1	1	1	2	9	1		2	6	4	8	0	1	1	3	7	0
// 0	0	0	6	0	4	6	4	6	1		0	0	0	0	0	2	7	5	8	1
// 4	6	4	6	1	4	7	4	6	1		2	7	5	9	1	2	8	6	9	1
// 0	0	0	6	0	5	7	4	3	1		0	0	0	0	0	2	8	6	10	1
// 5	8	5	3	1	5	8	5	3	1		2	8	6	10	1	2	8	6	10	1
// 0	0	0	6	0	6	8	5	3	1		0	0	0	0	0	2	8	6	12	1
// 6	8	5	3	1	6	8	5	3	1		2	9	7	12	1	2	9	7	14	1
// 0	0	0	3	0	7	9	5	3	1		0	0	0	0	0	2	9	7	14	1
// 7	9	6	3	1	7	9	6	3	1		2	9	8	14	1	2	9	8	14	1
// 0	0	0	0	0	0	0	0	0	0		0	0	0	0	0	0	0	0	0	0
// 0	0	2	12	0	1	1	2	9	0		0	0	3	6	0	0	1	3	7	0
// 0	0	0	12	0	1	1	3	9	0		0	0	0	0	0	1	2	4	8	0
// 2	2	3	6	0	2	2	3	6	0		1	3	4	8	0	1	4	4	8	0
// 0	0	0	9	0	3	3	4	6	1		0	0	0	0	0	2	6	5	7	1
// 3	4	4	6	1	3	5	4	6	1		2	6	6	8	1	2	6	6	9	1
// 0	0	0	6	0	4	6	5	6	1		0	0	0	0	0	2	7	6	10	1
// 4	6	5	6	1	4	7	5	6	1		2	7	6	10	1	2	8	7	10	1
// 0	0	0	6	0	5	7	5	3	1		0	0	0	0	0	2	8	7	10	1
// 5	8	5	3	1	5	8	6	3	1		2	8	7	10	1	2	8	8	12	1
// 0	0	0	6	0	6	8	6	3	1		0	0	0	0	0	2	8	8	12	1
// 6	8	6	3	1	6	8	6	3	1		2	9	8	12	1	2	9	8	14	1
// 0	0	0	3	0	7	9	6	3	1		0	0	0	0	0	2	9	8	14	1
// 7	9	6	3	1	7	9	6	3	1		2	9	8	14	1	2	9	8	14	1
// 											0	0	0	0	0	0	0	0	0	0
																				
																				
																				
																				
																				
																				
																				
																				
																				
																				
																				
																				
																				
																				
																				
																				
																				
																				
																				
																				
																				
																				
																				
																				
																				
																				
																				
																				
																				
																				
																				
																				
																				
																				
																				
																				
																				
																				
																				
																				
																				
																				
																				
																				
																				
																				
																				
																				
																				
																				
																				
																				
																				
																				

											
											
											
											
											
											
											
											
											
											
											
											
											
											
