	DrawObject: {

			L72FE:  sty GenZPAdrs00         //Save scale data.
			L7300:  stx GenByte0D           //Save a copy of the index to the object to draw.

			L7302:  lda ThisObjXUB          //
			L7304:  lsr                     //
			L7305:  ror ThisObjXLB          //
			L7307:  lsr                     //Divide the object's X position by 8.
			L7308:  ror ThisObjXLB          //
			L730A:  lsr                     //
			L730B:  ror ThisObjXLB          //

					lsr                     //
			  		ror ThisObjXLB          //
			  		lsr                     // Divide by 4 for C64 space
			  		ror ThisObjXLB          //
		
			L730D:  sta ThisObjXUB          //



			L730F:  lda ThisObjYUB          //
			L7311:  clc                     //
			L7312:  adc #$04                //
			L7314:  lsr                     //
			L7315:  ror ThisObjYLB          //Add 1024 object's Y position and divide by 8.
			L7317:  lsr                     //
			L7318:  ror ThisObjYLB          //
			L731A:  lsr                     //
			L731B:  ror ThisObjYLB          //

			 		lsr                     //
			  		ror ThisObjYLB          //
			  		lsr                     // Divide by 4 for C64 space
			  		ror ThisObjYLB          //

			L731D:  sta ThisObjYUB          //


			// L731F:  ldx #$04                //Prepare to write 4 bytes to vector RAM.
			// L7321:  jsr SetCURData          //($7C1C)Write CUR instruction in vector RAM.

	

			L7324:  lda #$70                //Set the scale of the object.
			L7326:  sec                     //
			L7327:  sbc GenZPAdrs00                 //
			L7329:  cmp #$A0                //Is the scale 9 or smaller?
			L732B:  bcc DrawSpotKill        //If so, branch.

		DrawMultiSpotKill:

			L732D:  pha                     //Save A on the stack.
			L732E:  lda #$90                //Set scale 9(/1).
			L7330:  jsr SpotKill            //($7CDE)Draw zero vector to prevent spots on the screen.
			L7333:  pla                     //Restore A from the stack.

			L7334:  sec                     //Subtract #$10 from scale value.
			L7335:  sbc #$10                //Is value below #$A0?
			L7337:  cmp #$A0                //If not, branch to run the spot kill routine again.
			L7339:  bcs DrawMultiSpotKill   //

		DrawSpotKill:

			L733B:  jsr SpotKill            //($7CDE)Draw zero vector to prevent spots on the screen.

			L733E:  ldx GenByte0D           //Restore index to object to draw.
			L7340:  lda AstStatus,X         //Is the object exploding?
			L7343:  bpl DrawObjNoExplode    //If not, branch to draw the normal object.

			L7345:  cpx #ShipIndex          //Is it the ship exploding?
			L7347:  beq DrawShipExplode     //If so, branch.

		DrawObjectExplode:

			L7349:  and #$0C                //Get index into shrapnel table.
			L734B:  lsr                     //
			L734C:  tay                     //
			L734D:  lda ShrapPatPtrTbl,Y    //Store jsr data in vector RAM for the Shrapnel graphics.
			L7350:  ldx ShrapPatPtrTbl+1,Y  //
			L7353:  bne SaveObjVecData      //Branch always.

		DrawShipExplode:

			L7355:  jsr DoShipExplsn        //($7465)Draw the ship exploding.
			L7358:  ldx GenByte0D           //Restore index to object being drawn.
			L735A:  rts                     //Exit after drawing ship fragments.

		DrawObjNoExplode:

			L735B:  cpx #ShipIndex          //Is it the ship that needs to be drawn?
			L735D:  beq DoDrawShip          //If so, branch.

			L735F:  cpx #ScrIndex           //Is it the saucer that needs to be drawn?
			L7361:  beq DoDrawSaucer        //If so, branch.

			L7363:  bcs DoDrawBullet        //Is it a bullet that needs to be drawn? If so, branch.

			L7365:  and #$18                //Must be an asteroid.
			L7367:  lsr                     //
			L7368:  lsr                     //Get the asteroid type bits.
			L7369:  tay                     //
			// L736A:  lda AstPtrnPtrTbl,Y     //Get asteroid vector data and write it to vector RAM.
			// L736D:  ldx AstPtrnPtrTbl+1,Y   //

		SaveObjVecData:

			//L7370:  jsr VecWriteWord        //($7D45)Write 2 bytes to vector RAM.
			L7373:  ldx GenByte0D           //Restore index to object.
			L7375:  rts                     //Finished loading object data into vector RAM.

		DoDrawShip:

			L7376:  jsr UpdateShipDraw      //($750B)Update the drawing of the player's ship.
			L7379:  ldx GenByte0D           //Restore index to object.
			L737B:  rts                     //Finished loading ship data into vector RAM.

		DoDrawSaucer:

			//L737C:  lda ScrPtrnPtrTbl       //Get saucer vector data and write it to vector RAM.
		//	L737F:  ldx ScrPtrnPtrTbl+1     //
			L7382:  jmp SaveObjVecData      //Branch always.

		DoDrawBullet:

			L7384:  lda #$70                //Set scale 7(/4).
			L7386:  ldx #$F0                //Prepare to draw a dot at full brightness(bullet).
			L7388:  jsr DrawDot             //($7CE0)Draw a dot on the screen.

			L738B:  ldx GenByte0D           //Restore index to object.
			L738D:  lda FrameTimerLo        //decrement shot timer every 4th frame.
			L738F:  and #$03                //Is it time to decrement the shot timer?
			L7391:  bne DrawObjectDone      //If not, branch.

			L7393:  dec AstStatus,X         //decrement shot timer.

		DrawObjectDone:

			L7396:  rts                     //Done with object vector data.

	}


	SpotKill: 

		L7CDE:  ldx #$00                //Prepare to draw a dot with brightness 0.

	DrawDot: 

		// L7CE0:  ldy #$01                //Store scale in vector RAM.
		// L7CE2:  sta (VecRamPtr),Y       //
		// L7CE4:  dey                     //
		// L7CE5:  tya                     //
		// L7CE6:  sta (VecRamPtr),Y       //Set X and Y delta values to 0.
		// L7CE8:  iny                     //
		// L7CE9:  iny                     //
		// L7CEA:  sta (VecRamPtr),Y       //
		// L7CEC:  iny                     //
		// L7CED:  txa                     //Store dot brightness in vector RAM.
		// L7CEE:  sta (VecRamPtr),Y       //
		// L7CF0:  jmp VecPtrUpdate        //($7C39)Update Vector RAM pointer.

		rts

	
