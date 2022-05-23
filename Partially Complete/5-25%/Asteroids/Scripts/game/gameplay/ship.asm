	
	

	UpdateShipDraw: {

			L750B:  ldx #$00                //Used for inverting index into ship direction table.
			L750D:  stx ShipDrawUnused      //Always 0.  Not used for anything.

			L750F:  ldy #16                //Assume ship is pointing up.
			L7511:  lda ShipDir             //Is ship pointing down?
			L7513:  bpl SaveShipDir         //If not, branch.

		InvertshipY:

			L7515:  ldy #0               //Set value indicating ship Y direction is inverted.
			L7517:  txa                     //
			L7518:  sec                     //Subtract ship direction from #$00 to invert index into-->
			L7519:  sbc ShipDir             //ShipDirPtrTbl

		SaveShipDir:

			L751B:  sta GenByte08           //Save current index calculations.
			L751D:  bit GenByte08           //Is ship pointing down and left?
			L751F:  bmi InvertshipX         //If so, branch to invert X axis of ship.

			L7521:  bvc SetShipInvAxes      //Is ship pointing up and left? If not, branch.

		InvertshipX:

			L7523:  ldx #8             //Set value indicating ship X direction is inverted.
			L7525:  lda #$80                //
			L7527:  sec                     //Subtract modified ship direction from #$80 to get-->
			L7528:  sbc GenByte08           //proper index into ShipDirPtrTbl.

		SetShipInvAxes:

			L752A:  stx ShipDrawXInv        //Save the X and Y axis inversion indicators.
			L752C:  sty ShipDrawYInv        //

			L752E:  lsr                     //
			L752F:  and #$FE                //Do final calculations on index for ShipDirPtrTbl.


			lsr
			lsr
			sta ZP.Amount
			clc
			adc #17

			
			clc
			adc ShipDrawXInv 
			clc
			adc ShipDrawYInv
			sta ZP.CurrentID

			lda ShipDrawXInv
			clc
			adc #48
			sta SCREEN_RAM

			lda ShipDrawYInv
			clc
			adc #48
			sta SCREEN_RAM + 2

			lda ZP.Amount
			clc
			adc #48
			sta SCREEN_RAM + 4


		
			//L7531:  tay                     //

			beq SkipBreak

			//.break
			//nop


			SkipBreak:

		//	L7532:  lda ShipDirPtrTbl,Y     //Get pointer to ship vector data for current direction.
			//L7535:  ldx ShipDirPtrTbl+1,Y   //
		//	L7538:  jsr DrawShip            //($6AD3)Draw the player's ship on the display.

			L753B:  lda ThrustSw            //Is the thrust button being pressed?
			L753E:  bpl DrawShipThrust       //If not, branch to exit.

			L7540:  lda FrameTimerLo        //Show thrust animation every 4th frame.
			L7542:  and #$04                //Is this the fourth frame?
			L7544:  beq DrawShipThrust      //If not, branch to exit.

					lda ZP.CurrentID
					clc
					adc #33
					sta ZP.CurrentID

			// L7546:  iny                     //Prepare to move vector ROM pointer to thrust data.
			// L7547:  iny                     //
			// L7548:  sec                     //
			// L7549:  ldx VecPtrUB_           //increment vector ROM pointer by 2 bytes.
			// L754B:  tya                     //
			// L754C:  adc VecPtrLB_           //Pointer is now at thrust vector data.
			// L754E:  bcc DrawShipThrust      //Draw thrust vectors on the display.

			// L7550:  inx                     //increment the upper byte of the vector data pointer.

		DrawShipThrust:

			L7551:  jsr DrawShip            //($6AD3)Draw the player's ship on the display.

			EndUpdShpDraw:
			L7554:  rts                     //Finished updating the ship and thrust graphics.

	}



	DrawShip: {

			ldx #ShipIndex
			ldx #0

			lda ZP.CurrentID
			sta SpritePointer, x

			lda ThisObjXLB
			sta SpriteX, x

			lda ThisObjYLB
			sta SpriteY, x

			lda #WHITE
			sta SpriteColor, x

			rts



		/*	L6AD3:  sta VecPtrLB_           //Save the pointer to the ship vector data.
			L6AD5:  stx VecPtrUB_           //

		SetVecRAMData:

			L6AD7:  ldy #$00                //start at beginning of vector data.

		GetShipOpCode:

			L6AD9:  iny                     //Get opcode byte from vector ROM.
			L6ADA:  lda (VecPtr_),Y         //

			L6adc:  adc ShipDrawYInv        //
			L6ADE:  sta (VecRamPtr),Y       //Invert Y axis of VEC data, if necessary.
			L6AE0:  dey                     //

			L6AE1:  cmp #SvecOpcode         //Is this a SVEC vector opcode?
			L6AE3:  bcs DrawShipSVEC        //If so, branch to get the next SVEC byte.

			L6AE5:  cmp #CurOpcode          //Is this a VEC vector opcode?
			L6AE7:  bcs DrawShiprts         //If not, branch because it must be an rts opcode.

		DrawShipVEC:

			L6AE9:  lda (VecPtr_),Y         //Load second byte of VEC data into vector RAM.
			L6AEB:  sta (VecRamPtr),Y       //

			L6AED:  iny                     //
			L6AEE:  iny                     //Move to 3rd byte of VEC data and store in vector RAM.
			L6AEF:  lda (VecPtr_),Y         //
			L6AF1:  sta (VecRamPtr),Y       //

			L6AF3:  iny                     //
			L6AF4:  lda (VecPtr_),Y         //Move to 4th byte of VEC data.
			L6AF6:  adc ShipDrawXInv        //Invert X axis of VEC data, if necessary.
			L6AF8:  adc ShipDrawUnused      //
			L6AFA:  sta (VecRamPtr),Y       //Store 4th byte in vector RAM.

		NextShipOpCode:

			L6AFC:  iny                     //Branch always.
			L6AFD:  bne GetShipOpCode       //

		DrawShiprts:

			L6AFF:  dey                     //Done with this segment of ship vector data.
			L6B00:  jmp VecPtrUpdate        //($7C39)Update Vector RAM pointer.

		DrawShipSVEC:

			L6B03:  lda (VecPtr_),Y         //Load second byte of SVEC data into vector RAM.
			L6B05:  adc ShipDrawXInv        //Invert X axis of SVEC data, if necessary.
			L6B07:  clc                     //
			L6B08:  adc ShipDrawUnused      //
			L6B0A:  sta (VecRamPtr),Y       //

			L6B0C:  iny                     //Branch always.
			L6B0D:  bne NextShipOpCode      //*/

	}

	DoShipExplsn: {

			L7465:  lda ShipStatus          //Is this the first frame of the ship explosion?
			L7468:  cmp #$A2                //If so, load the initial debris data.
			L746A:  bcs GetNumDebris        //If not, branch to skip loading data.

			L746C:  ldx #$0A                //Prepare to load 12 values from ShipExpVelTbl.

		LoadShipExplLoop:

			L746E:  lda ShipExpVelTbl,X     //Get byte of ship debris X velocity.
			L7471:  lsr                     //
			L7472:  lsr                     //
			L7473:  lsr                     //Save only the upper nibble and shift to lower nibble.
			L7474:  lsr                     //
			L7475:  clc                     //
			L7476:  adc #$F8                //Sign extend the nibble to fill the whole byte.
			L7478:  adc #$F8                //
			L747A:  sta ShpDebrisXVelUB,X   //Save signed value into RAM.

			L747C:  lda ShipExpVelTbl+1,X   //Get byte of ship debris Y velocity.
			L747F:  lsr                     //
			L7480:  lsr                     //
			L7481:  lsr                     //Save only the upper nibble and shift to lower nibble.
			L7482:  lsr                     //
			L7483:  clc                     //
			L7484:  adc #$F8                //Sign extend the nibble to fill the whole byte.
			L7486:  adc #$F8                //
			L7488:  sta ShpDebrisYVelUB,X   //Save signed value into RAM.

			L748A:  dex                     //Move to next 2 bytes in the table.
			L748B:  dex                     //Are there more bytes to load from the table?
			L748C:  bpl LoadShipExplLoop    //if so, loop to load 2 more bytes.

		GetNumDebris:

			L748E:  lda ShipStatus          //
			L7491:  adc #$FF                //
			L7493:  and #$70                //Calculate the pointer into the ship debris data based-->
			L7495:  lsr                     //on the ship Status counter.  This has the effect of making-->
			L7496:  lsr                     //the debris disappear one by one over time.
			L7497:  lsr                     //
			L7498:  tax                     //

		ShipDebrisLoop:

			L7499:  stx ShipDebrisPtr       //Update ship debris index.

			L749B:  ldy #$00                //Assume the X velocity for this debris piece is positive.
			L749D:  lda ShipExpVelTbl,X     //Is the debris piece moving in a positive X direction?
			L74A0:  bpl GetDebrisXVel       //If so, branch.

			L74A2:  dey                     //The X velocity for this debris piece is negative.

		GetDebrisXVel:

			L74A3:  clc                     //Update fractional part of debris X position.
			L74A4:  adc ShpDebrisXVelLB,X   //
			L74A6:  sta ShpDebrisXVelLB,X   //
			L74A8:  tya                     //
			L74A9:  adc ShpDebrisXVelUB,X   //Update integer part of debris X position.
			L74AB:  sta ShpDebrisXVelUB,X   //
			L74AD:  sta ThisDebrisXLB       //Save current debris X position.
			L74AF:  sty ThisDebrisXUB       //Save current debris X direction.

			L74B1:  ldy #$00                //Assume the Y velocity for this debris piece is positive.
			L74B3:  lda ShipExpVelTbl+1,X   //Is the debris piece moving in a positive Y direction?
			L74B6:  bpl GetDebrisYVel       //If so, branch.

			L74B8:  dey                     //The Y velocity for this debris piece is negative.

		GetDebrisYVel:

			L74B9:  clc                     //Update fractional part of debris Y position.
			L74BA:  adc ShpDebrisYVelLB,X   //
			L74BC:  sta ShpDebrisYVelLB,X   //
			L74BE:  tya                     //
			L74BF:  adc ShpDebrisYVelUB,X   //Update integer part of debris Y position.
			L74C1:  sta ShpDebrisYVelUB,X   //
			L74C3:  sta ThisDebrisYLB       //Save current debris Y position.
			L74C5:  sty ThisDebrisYUB       //Save current debris Y direction.

			// L74C7:  lda VecRamPtrLB         //
			// L74C9:  sta VecPtrLB_           //Save a copy of the vector RAM pointer.
			// L74CB:  lda VecRamPtrUB         //
			// L74CD:  sta VecPtrUB_           //

			L74CF:  jsr CalcDebrisPos       //($7C49)Calculate the position of the exploded ship pieces.

			// L74D2:  ldy ShipDebrisPtr       //Write the ship debris vector data to the vector RAM.
			// L74D4:  lda ShipExpPtrTbl,Y     //
			// L74D7:  ldx ShipExpPtrTbl+1,Y   //
			// L74DA:  jsr VecWriteWord        //($7D45)Write 2 bytes to vector RAM.

			// L74DD:  ldy ShipDebrisPtr       //Draw the exact same line from above except backwards.
			// L74DF:  lda ShipExpPtrTbl+1,Y   //
			// L74E2:  adc #$04                //Backtrack in the Y direction.
			// L74E4:  tax                     //
			// L74E5:  lda ShipExpPtrTbl,Y     //
			// L74E8:  and #$0F                //Set the brightness of the backtracked vector to 0.
			// L74EA:  adc #$04                //Backtrack in the X direction.
			// L74EC:  jsr VecWriteWord        //($7D45)Write 2 bytes to vector RAM.

			// L74EF:  ldy #$FF                //Prepare to write 4 bytes to vector RAM.

		VecBackTrack:

			// L74F1:  iny                     //Get position of the data where this function first started-->
			// L74F2:  lda (VecPtr_),Y         //writing to vector RAM.
			// L74F4:  sta (VecRamPtr),Y       //Copy the data again into the current position in vector RAM-->
			// L74F6:  iny                     //Except draw it backwards to backtrack the XY position to-->
			// L74F7:  lda (VecPtr_),Y         //the starting point.
			// L74F9:  adc #$04                //Draw the exact same line from CalcDebrisPos except backwards.
			// L74FB:  sta (VecRamPtr),Y       //This places the pointer back to the middle of the ship's position.
			// L74FD:  cpy #$03                //Does the second word of the VEC opcode need to be written?
			// L74FF:  bcc VecBackTrack        //If so, branch to write second word.

			// L7501:  jsr VecPtrUpdate        //($7C39)Update Vector RAM pointer.

			L7504:  ldx ShipDebrisPtr       //Move to next pair of ship debris data.
			L7506:  dex                     //
			L7507:  dex                     //Is there more ship debris data to process?
			L7508:  bpl ShipDebrisLoop      //If so, branch.

			L750A:  rts                     //End ship debris routine.

	}


	//The purpose of this function is to calculate the proper starting point for the selected piece of
					//ship debris.  It needs to take into account any out of bounds conditions if the ship is close to 
					//any of the 4 edges of the display.  It draws a VEC with zero brightness to the proper starting
					//position.

	CalcDebrisPos: {

			L7C49:  lda ThisDebrisXUB       //Is the debris traveling in a negative X direction?
			L7C4B:  cmp #$80                //
			L7C4D:  bcc ChkYDebris          //If not, branch.

			L7C4F:  adc #$FF                //Convert negative direction into a positive-->
			L7C51:  sta ThisDebrisXUB       //number by using two's compliment.
			L7C53:  lda ThisDebrisXLB       //
			L7C55:  adc #$FF                //Lower byte contains debris absolute value position.
			L7C57:  adc #$00                //Upper byte contains debris direction.
			L7C59:  sta ThisDebrisXLB       //
			L7C5B:  bcc L7C5F                  //
			L7C5D:  inc ThisDebrisXUB       //
			L7C5F:  sec                     //Set bit to indicate debris is moving in negative X direction.

		ChkYDebris:

			L7C60:  rol GenByte08           //Save X direction bit.

			L7C62:  lda ThisDebrisYUB       //Is the debris traveling in a negative Y direction?
			L7C64:  cmp #$80                //
			L7C66:  bcc ChkPosXYUB          //If not, branch.

			L7C68:  adc #$FF                //Convert negative direction into a positive-->
			L7C6A:  sta ThisDebrisYUB       //number by using two's compliment.
			L7C6C:  lda ThisDebrisYLB       //
			L7C6E:  adc #$FF                //Lower byte contains debris absolute value position.
			L7C70:  adc #$00                //Upper byte contains debris direction.
			L7C72:  sta ThisDebrisYLB       //
			L7C74:  bcc L7C78                  //
			L7C76:  inc ThisDebrisYUB       //
			L7C78:  sec                     //Set bit to indicate debris is moving in negative Y direction.

		ChkPosXYUB:

			L7C79:  rol GenByte08           //Save Y direction bit.

			L7C7B:  lda ThisDebrisXUB       //Is debris piece close to the lowest X or Y border?
			L7C7D:  ora ThisDebrisYUB       //
			L7C7F:  beq ChkPosXYLB          //If so, branch to check lower byte for edge proximity.

		ChkXYMaxBounds:

			L7C81:  ldx #$00                //Prepare to clip debris if at max XY position.
			L7C83:  cmp #$02                //Is debris at maximum XY edge of screen?
			L7C85:  bcs SetScaleandDirbits  //If so, branch.

			L7C87:  ldy #$01                //Not at edge of screen. Prepare to calculate proper scaling.
			L7C89:  bne PrepXYMult2         //

		ChkPosXYLB:

			L7C8B:  ldy #$02                //Prepare to set scaling if not at screen edge.
			L7C8D:  ldx #$09                //Prepare to clip debris if at min XY position.
			L7C8F:  lda ThisDebrisXLB       //
			L7C91:  ora ThisDebrisYLB       //Is debris at minimum XY edge of screen?
			L7C93:  beq SetScaleandDirbits  //If so, branch.

			L7C95:  bmi PrepXYMult2         //Is proper scaling already set? If so, branch.

		CalcShiftVal:

			L7C97:  iny                     //
			L7C98:  asl                     //Calculate proper scaling value for displacing this debris.
			L7C99:  bpl CalcShiftVal        //

		PrepXYMult2:

			L7C9B:  tya                     //Transfer scaling value to X.
			L7C9C:  tax                     //
			L7C9D:  lda ThisDebrisXUB       //Move debris X direction into A.

		RestoreDebrisPos:

			L7C9F:  asl ThisDebrisXLB       //
			L7CA1:  rol                     //
			L7CA2:  asl ThisDebrisYLB       //Restore the debris position from a single byte back to 2 bytes.
			L7CA4:  rol ThisDebrisYUB       //
			L7CA6:  dey                     //
			L7CA7:  bne RestoreDebrisPos    //

			L7CA9:  sta ThisDebrisXUB       //Save restored upper byte of debris X position.

		SetScaleandDirbits:

			L7CAB:  txa                     //
			L7CAC:  sec                     //
			L7CAD:  sbc #$0A                //Compute scaling bits.
			L7CAF:  adc #$FF                //
			L7CB1:  asl                     //
			L7CB2:  ror GenByte08           //Get Y direction bit.
			L7CB4:  rol                     //
			L7CB5:  ror GenByte08           //
			L7CB7:  rol                     //Get X direction bit.
			L7CB8:  asl                     //
			L7CB9:  sta GenByte08           //Save the completed configuration bits back to RAM.

			// L7CBB:  ldy #$00                //Write the Y position lower byte to vector RAM.
			// L7CBD:  lda ThisDebrisYLB       //
			// L7CBF:  sta (VecRamPtr),Y       //
			// L7CC1:  lda GenByte08           //
			// L7CC3:  and #$F4                //Get the scale and Y direction bits for the VEC opcode.
			// L7CC5:  ora ThisDebrisYUB       //Combine the Y position upper byte.
			// L7CC7:  iny                     //
			// L7CC8:  sta (VecRamPtr),Y       //Write the byte to vector RAM.
			// L7CCA:  lda ThisDebrisXLB       //
			// L7CCC:  iny                     //
			// L7CCD:  sta (VecRamPtr),Y       //Write the X position lower byte to vector RAM.
			// L7CCF:  lda GenByte08           //
			// L7CD1:  and #$02                //Get the X direction bit.
			// L7CD3:  asl                     //
			// L7CD4:  ora GenByte01           //Set brightness for this vector(should be 0).
			// L7CD6:  ora ThisDebrisXUB       //Combine the X position upper byte.
			// L7CD8:  iny                     //
			// L7CD9:  sta (VecRamPtr),Y       //Write the byte to vector RAM.

			rts
			//L7CDB:  jmp VecPtrUpdate        //($7C39)Update Vector RAM pointer.

	}


	CenterShip: {

			L71E8:  lda #$60                //
			L71EA:  sta ShipXPosLo          //Set lower XY ship position bytes for screen center.
			L71ED:  sta ShipYPosLo          //

			L71F0:  lda #$00                //
			L71F2:  sta ShipXSpeed          //Set ship XY Speed to 0.
			L71F5:  sta ShipYSpeed          //

			L71F8:  lda #$10                //
			L71FA:  sta shipXPosHi          //
			L71FD:  lda #$0C                //Set upper XY ship position bytes for screen center.
			L71FF:  sta ShipYPosHi          //
			L7202:  rts                     //


	}



	CheckFire: {

			L6CD7:  lda NumPlayers          //Is a game currently being played?
			L6CD9:  beq EndUpdateShip       //If not, branch to exit.

			L6CDB:  asl FireSw              //Shift current state of fire button into shift register.
			L6CDE:  ror ShipBulletSR        //

			L6CE0:  bit ShipBulletSR        //Is MSB of bullet shift register set?
			L6CE2:  bpl EndUpdateShip       //If not, branch to exit. Limits fire rate.

			L6CE4:  bvs EndUpdateShip       //Is bit 6 set? If so, branch to exit. Prevents auto fire.

			L6CE6:  lda ShipSpawnTmr        //Is ship waiting to spawn?
			L6CE9:  bne EndUpdateShip       //If so, branch to exit.

			L6CEB:  tax                     //Zero out X. Indicates ship is updating in following functions.
			L6CEC:  lda #$03                //Prepare to check 4 bullet slots.
			L6CEE:  sta NumBulletSlots      //
			L6CF0:  ldy #$07                //Set index to ship bullet slots.

			//----------------------------------[ Bullet Generation Routines ]----------------------------------

			//The functions below are used for both ship bullets and saucer bullets.

		FindBulletSlot:

			L6CF2:  lda ShipStatus,Y        //Get ship/saucer bullet Status.
			L6CF5:  beq BulletSlotFound     //Is slot available? If so, branch to continue.

			L6CF7:  dey                     //Move to next bullet slot.
			L6CF8:  cpy NumBulletSlots      //Is there more bullet slots to check?
			L6CFA:  bne FindBulletSlot      //If so, branch check next bullet slot.

		EndUpdateShip:

			L6CFC:  rts                     //Done updating bullets.


		BulletSlotFound:

			L6CFD:  stx ShipScrShot         //Store index to bullet type being processed.
			L6CFF:  lda #$12                //Set bullet to last for 18 frames.
			L6D01:  sta ShipStatus,Y        //

			L6D04:  lda ShipDir,X           //Get ship direction/saucer bullet direction.
			L6D06:  jsr CalcXThrust         //($77D2)Calculate X velocity for the bullet.

			L6D09:  ldx ShipScrShot         //Reload index to ship direction/saucer bullet direction.
			L6D0B:  cmp #$80                //Is ship/bullet facing left? If so, set carry bit.
			L6D0D:  ror                     //Divide direction value by 2 and save carry bit in MSB.
			L6D0E:  sta ShotXDir            //

			L6D10:  clc                     //Add X velocity change to existing velocity.
			L6D11:  adc ShipXSpeed,X        //Is this a right to left traveling object?
			L6D14:  bmi ChkMaxNegXVel       //If so, branch to set a velocity limit.

			L6D16:  cmp #$70                //Must be a left to right moving object.
			L6D18:  bcc SaveObjXVel         //Has max X velocity been reached? if so, branch.

			L6D1A:  lda #$6F                //Set maximum X velocity (111 pixels per frame).
			L6D1C:  bne SaveObjXVel         //Branch always.

		ChkMaxNegXVel:

			L6D1E:  cmp #$91                //Has max X velocity been reached (right to left)?
			L6D20:  bcs SaveObjXVel         //If not, branch.

			L6D22:  lda #$91                //Maximum negative X velocity (-111 pixels per frame).

		SaveObjXVel:

			L6D24:  sta ShipXSpeed,Y        //Save updated X velocity. Done only once for bullets.

			L6D27:  lda ShipDir,X           //Get ship direction/saucer bullet direction.
			L6D29:  jsr CalcThrustDir       //($77D5)Calculate Y velocity for the bullet.

			L6D2C:  ldx ShipScrShot         //Reload index to ship direction/saucer bullet direction.
			L6D2E:  cmp #$80                //Is ship/bullet facing downward? If so, set carry bit.
			L6D30:  ror                     //Divide direction value by 2 and save carry bit in MSB.
			L6D31:  sta ShotYDir            //

			L6D33:  clc                     //Add Y velocity change to existing velocity.
			L6D34:  adc ShipYSpeed,X        //Is this a top to bottom traveling object?
			L6D37:  bmi ChkMaxNegYVel       //If so, branch to set a velocity limit.

			L6D39:  cmp #$70                //Must be a bottom to top moving object.
			L6D3B:  bcc SaveObjYVel         //Has max Y velocity been reached? if so, branch.

			L6D3D:  lda #$6F                //Set maximum Y velocity (111 pixels per frame).
			L6D3F:  bne SaveObjYVel         //Branch always.

		ChkMaxNegYVel:

			L6D41:  cmp #$91                //Has max Y velocity been reached (top to bottom)?
			L6D43:  bcs SaveObjYVel         //If not, branch.

			L6D45:  lda #$91                //Maximum negative Y velocity (-111 pixels per frame).

		SaveObjYVel:

			L6D47:  sta ShipYSpeed,Y        //Save updated Y velocity. Done only once for bullets.

			L6D4A:  ldx #$00                //Assume shot moving left to right.
			L6D4C:  lda ShotXDir            //Is shot moving left to right?
			L6D4E:  bpl SetShotXPos         //If so, branch.

			L6D50:  dex                     //Shot is moving right to left.

		SetShotXPos:

			L6D51:  stx ObjectXPosNeg       //Store value used for properly updating shot X position.

			L6D53:  ldx ShipScrShot         //Reload index to ship direction/saucer bullet direction.
			L6D55:  cmp #$80                //Is ship/bullet facing left? If so, set carry bit.
			L6D57:  ror                     //Divide direction value by 2 and save carry bit in MSB.
			L6D58:  clc                     //Add value to the bullet X direction.
			L6D59:  adc ShotXDir            //

			L6D5B:  clc                     //
			L6D5C:  adc ShipXPosLo,X        //Update lower byte of shot X position.
			L6D5F:  sta ShipXPosLo,Y        //

			L6D62:  lda ObjectXPosNeg       //
			L6D64:  adc shipXPosHi,X        //Update upper byte of shot X position with proper sign.
			L6D67:  sta shipXPosHi,Y        //

			L6D6A:  ldx #$00                //Assume shot moving bottom to top.
			L6D6C:  lda ShotYDir            //Is shot moving bottom to top?
			L6D6E:  bpl SetShotYPos         //If so, branch.

			L6D70:  dex                     //Shot is moving top to bottom.

		SetShotYPos:

			L6D71:  stx ObjectYPosNeg       //Store value used for properly updating shot Y position.

			L6D73:  ldx ShipScrShot         //Reload index to ship direction/saucer bullet direction.
			L6D75:  cmp #$80                //Is ship/bullet facing down? If so, set carry bit.
			L6D77:  ror                     //Divide direction value by 2 and save carry bit in MSB.
			L6D78:  clc                     //Add value to the bullet Y direction.
			L6D79:  adc ShotYDir            //

			L6D7B:  clc                     //
			L6D7C:  adc ShipYPosLo,X        //Update lower byte of shot Y position.
			L6D7F:  sta ShipYPosLo,Y        //

			L6D82:  lda ObjectYPosNeg       //
			L6D84:  adc ShipYPosHi,X        //Update upper byte of shot Y position with proper sign.
			L6D87:  sta ShipYPosHi,Y        //

			L6D8A:  lda #$80                //
			L6D8C:  sta SFXTimers,X         //Turn on SFX for the shot fired.
			L6D8E:  rts                     //

		}

 
	UpdateShip: {

			L703F:  lda NumPlayers          //Is a game being played?
			L7041:  beq ShipStsExit1        //If not, branch to exit.

			L7043:  lda ShipStatus          //Is the player's ship exploding?
			L7046:  bmi ShipStsExit1        //If so, branch to exit.

			L7048:  lda ShipSpawnTmr        //Is the ship currently waiting to respawn?
			L704B:  beq ChkPlyrInput        //If not, branch.

			L704D:  dec ShipSpawnTmr        //decrement the spawn timer. Still waiting to respawn?
			L7050:  bne ShipStsExit1        //If so, branch to exit.

			L7052:  ldy HyprSpcFlag         //Did a hyperspace jump just fail?
			L7054:  bmi HyprspcFailed       //If so, branch.

			L7056:  bne HyprspcSuccess      //Is ship in hyperspace? If so, branch.

			L7058:  jsr IsReturnSafe        //($7139)Check to see if safe for ship to exit hyperspace.
			L705B:  bne ResetHyprspc        //Did safety check succeed? If not, branch.

			L705D:  ldy ScrStatus           //Is a saucer on the screen?
			L7060:  beq HyprspcSuccess      //If not, branch to bring player out of hyperspace.

			L7062:  ldy #$02                //Make sure spawn timer is not 0. -->
			L7064:  sty ShipSpawnTmr        //Not safe to return from hyperspace.
			L7067:  rts                     //

		HyprspcSuccess:

			L7068:  lda #$01                //Indicate ship is no longer in hyperspace.
			L706A:  sta ShipStatus          //
			L706D:  bne ResetHyprspc        //Branch always.

		HyprspcFailed:

			L706F:  lda #$A0                //Indicate the ship is exploding.
			L7071:  sta ShipStatus          //

			L7074:  ldx #$3E                //Set the explosion SFX timer.
			L7076:  stx ExplsnSFXTimer      //

			L7078:  ldx CurrentPlyr         //decrement the player's extra lives.
			L707A:  dec Plyr1Ships,X        //

			L707C:  lda #$81                //Set the ship spawn timer.
			L707E:  sta ShipSpawnTmr        //

		ResetHyprspc:

			L7081:  lda #$00                //Clear the hyperspace Status.
			L7083:  sta HyprSpcFlag         //

		ShipStsExit1:

			L7085:  rts                     //Exit ship Status update routines.

		ChkPlyrInput:

			L7086:  lda RotLeftSw           //Is rotate left being pressed?
			L7089:  bpl ChkRotRght          //If not, branch.

			L708B:  lda #$03                //Prepare to add 3 to ship direction.
			L708D:  bne UpdateShipDir       //Branch always.

		ChkRotRght:

			L708F:  lda RotRghtSw           //Is rotate right being pressed?
			L7092:  bpl ChkThrust           //If not, branch.

			L7094:  lda #$FD                //Prepare to subtract 3 to ship direction.

		UpdateShipDir:

			L7096:  clc                     //
			L7097:  adc ShipDir             //Update ship direction.
			L7099:  sta ShipDir             //

		ChkThrust:

			L709B:  lda FrameTimerLo        //Update ship velocity only every other frame.
			L709D:  lsr                     //Time to update ship velocity?
			L709E:  bcs ShipStsExit1        //If not, branch to exit.

			L70A0:  lda ThrustSw            //Is thrust being pressed?
			L70A3:  bpl Shipdecelerate      //If not, branch.

		ShipAccelerate:

			L70A5:  lda #$80                //Enable the ship thrust SFX.
			L70A7:  sta ShipThrustSFX       //

			L70AA:  ldy #$00                //Assume ship is facing right (positive X direction).
			L70AC:  lda ShipDir             //Get ship direction in preparation for thrust calculation.
			L70AE:  jsr CalcXThrust         //($77D2)Calculate thrust in X direction.
			L70B1:  bpl UpdateShipXVel      //Is ship facing right? If so, branch.

			L70B3:  dey                     //Ship is facing left.  Set X for negative direction.

		UpdateShipXVel:

			L70B4:  asl                     //Multiply thrust value by 2.
			L70B5:  clc                     //
			L70B6:  adc ShipXAccel          //Add thrust to ship's X acceleration.
			L70B8:  tax                     //Save the acceleration in X.
			L70B9:  tya                     //
			L70BA:  adc ShipXSpeed          //Add the acceleration to the ship's X velocity.
			L70BD:  jsr ChkShipMaxVel       //($7125)Ensure ship does not exceed maximum velocity.

			L70C0:  sta ShipXSpeed          //Save current ship X velocity and acceleration.
			L70C3:  stx ShipXAccel          //

			L70C5:  ldy #$00                //Assume ship is facing up (positive Y direction).
			L70C7:  lda ShipDir 
					sta $d020            //Get ship direction in preparation for thrust calculation.
			L70C9:  jsr CalcThrustDir       //($77D5)Calculate thrust in Y direction.
			L70CC:  bpl UpdateShipYVel      //Is ship facing up? If so, branch.

			L70CE:  dey                     //Ship is facing down.  Set Y for negative direction.

		UpdateShipYVel:

			L70CF:  asl                     //Multiply thrust value by 2.
			L70D0:  clc                     //
			L70D1:  adc ShipYAccel          //Add thrust to ship's Y acceleration.
			L70D3:  tax                     //Save the acceleration in X.
			L70D4:  tya                     //
			L70D5:  adc ShipYSpeed          //Add the acceleration to the ship's Y velocity.
			L70D8:  jsr ChkShipMaxVel       //($7125)Ensure ship does not exceed maximum velocity.

			L70DB:  sta ShipYSpeed          //Save current ship Y velocity and acceleration.
			L70DE:  stx ShipYAccel          //
			L70E0:  rts                     //Done calculating ship acceleration.

		Shipdecelerate:

					

			L70E1:  lda #$00                //Turn off ship thrust SFX.
			L70E3:  sta ShipThrustSFX       //

		decelerateX:

			L70E6:  lda ShipXSpeed          //Does ship need to be decelerated in the X direction?
			L70E9:  ora ShipXAccel          //
			L70EB:  beq decelerateY         //If not, branch to check Y deceleration.

			L70ED:  lda ShipXSpeed          //Get ship X velocity and multiply by 2.
			L70F0:  asl                     //

			L70F1:  ldx #$FF                //Assume positive X velocity. X acceleration = -1.
			L70F3:  clc                     //
			L70F4:  adc #$FF                //Is ship traveling in the positive X direction?
			L70F6:  bmi SetXdecelerate      //If so, branch.

			L70F8:  inx                     //Ship traveling in negative X direction.
			L70F9:  sec                     //Set X deceleration to +1.

		SetXdecelerate:

			L70FA:  adc ShipXAccel          //Update ship X acceleration.
			L70FC:  sta ShipXAccel          //

			L70FE:  txa                     //
			L70FF:  adc ShipXSpeed          //Update ship X velocity.
			L7102:  sta ShipXSpeed          //

		decelerateY:

			L7105:  lda ShipYAccel          //Does ship need to be decelerated in the Y direction?
			L7107:  ora ShipYSpeed          //
			L710A:  beq decelerateExit      //If not, branch to exit.

			L710C:  lda ShipYSpeed          //Get ship Y velocity and multiply by 2.
			L710F:  asl                     //

			L7110:  ldx #$FF                //Assume positive Y velocity. Y acceleration = -1.
			L7112:  clc                     //
			L7113:  adc #$FF                //Is ship traveling in the positive Y direction?
			L7115:  bmi SetYdecelerate      //If so, branch.

			L7117:  sec                     //Ship traveling in negative Y direction.
			L7118:  inx                     //Set Y deceleration to +1.

		SetYdecelerate:

			L7119:  adc ShipYAccel          //Update ship Y acceleration.
			L711B:  sta ShipYAccel          //

			L711D:  txa                     //
			L711E:  adc ShipYSpeed          //Update ship Y velocity.
			L7121:  sta ShipYSpeed          //

		decelerateExit:

			L7124:  rts                     //Done decelerating the player's ship.

		ChkShipMaxVel:

			L7125:  bmi ChkMaxNegVel        //Is ship traveling left/down (negative direction)? If so, branch.

		ChkMaxPosVel:

			L7127:  cmp #$40                //Is ship moving less than max velocity in positive direction?
			L7129:  bcc ChkMaxExit          //If so, branch to exit.

			L712B:  ldx #$FF                //Max positive velocity reached. Set acceleration to -1.
			L712D:  lda #$3F                //Set velocity to max positive value.
			L712F:  rts                     //

		ChkMaxNegVel:

			L7130:  cmp #$C0                //Is ship moving less than max velocity in negative direction?
			L7132:  bcs ChkMaxExit          //If so, branch to exit.

			L7134:  ldx #$01                //Max negative velocity reached. Set acceleration to +1.
			L7136:  lda #$C0                //Set velocity to max negative value.

		ChkMaxExit:

			L7138:  rts                     //Done checking maximum ship velocity.

		}

			//--------------------------------[ Safe Hyperspace Return Routine ]--------------------------------



	IsReturnSafe: {

			L7139:  ldx #ScrIndex           //Prepare to check all asteroids and saucer.

		SafeCheckLoop:

			L713B:  lda AstStatus,X         //Is current object slot active?
			L713E:  beq NextSafeCheck       //If not, branch to move to next object.

		SafeCheckX:

			L7140:  lda AstXPosHi,X         //Get object X position and compare to ship X position.
			L7143:  sec                     //
			L7144:  sbc shipXPosHi          //
			L7147:  cmp #$04                //Is object within +4 pixels of ship?
			L7149:  bcc SafeCheckY          //If so, branch to check object's Y position.

			L714B:  cmp #$FC                //Is object within -4 pixels of ship?
			L714D:  bcc NextSafeCheck       //If not, branch to check next object's position.

		SafeCheckY:

			L714F:  lda AstYPosHi,X         //Get object Y position and compare to ship Y position.
			L7152:  sec                     //
			L7153:  sbc ShipYPosHi          //
			L7156:  cmp #$04                //Is object within +4 pixels of ship?
			L7158:  bcc SafeCheckFail       //If so, branch. Not safe to exit hyperspace.

			L715A:  cmp #$FC                //Is object within -4 pixels of ship?
			L715C:  bcs SafeCheckFail       //If so, branch. Not safe to exit hyperspace.

		NextSafeCheck:

			L715E:  dex                     //Is there another object to check?
			L715F:  bpl SafeCheckLoop       //If so, branch to check the object.

		SafeCheckSuccess:

			L7161:  inx                     //Safe to exit hyperspace. Sets X to zero.
			L7162:  rts                     //

		SafeCheckFail:

			L7163:  inc ShipSpawnTmr        //Not safe to exit hyperspace. Ensures spawn timer is not zero.
			L7166:  rts                     //

		}


//Table used for calculating X and Y ship acceleration.
ThrustTbl:
L57B9: .byte $00, $03, $06, $09, $0C, $10, $13, $16, $19, $1C, $1F, $22, $25, $28, $2B, $2E
L57C9: .byte $31, $33, $36, $39, $3C, $3F, $41, $44, $47, $49, $4C, $4E, $51, $53, $55, $58
L57D9: .byte $5A, $5C, $5E, $60, $62, $64, $66, $68, $6A, $6B, $6D, $6F, $70, $71, $73, $74
L57E9: .byte $75, $76, $78, $79, $7A, $7A, $7B, $7C, $7D, $7D, $7E, $7E, $7E, $7F, $7F, $7F
L57F9: .byte $7F 