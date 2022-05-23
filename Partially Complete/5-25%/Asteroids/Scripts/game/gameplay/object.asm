
	UpdateObjects: {

			L6F57:  ldx #$22                //Prepare to check every object.

		UpdateObjLoop:

			L6F59:  lda AstStatus,X         //Is the current object active?
			L6F5C:  bne UpdateCurObject     //If so, branch to update it.

		NextObjUpdate:

			L6F5E:  dex                     //Move to next object.
			L6F5F:  bpl UpdateObjLoop       //Done checking objects? If not, branch to do the next one.

			L6F61:  rts                     //Done updating objects.

		UpdateCurObject:

			L6F62:  bpl UpdateObjPos        //Is current object exploding? If not, branch.

		DoExplodeObj:
			L6F64:  jsr TwosCompliment      //($7708)Calculate the 2's compliment of the value in A.
			L6F67:  lsr                     //
			L6F68:  lsr                     //Move upper nibble to lower nibble.
			L6F69:  lsr                     //
			L6F6A:  lsr                     //

			L6F6B:  cpx #ShipIndex          //If it the ship that is exploding? If not, branch.
			L6F6D:  bne incExplosion        //

			L6F6F:  lda FrameTimerLo        //Update ship explosion once every other frame.
			L6F71:  and #$01                //Ship explosion is twice as slow as other objects.
			L6F73:  lsr                     //Time to update ship explosion?
			L6F74:  beq SaveincExplosion    //If not, branch.

		incExplosion:

			L6F76:  sec                     //Prepare to increment to next explosion state.

		SaveincExplosion:

			L6F77:  adc AstStatus,X         //Save updated explosion timer.
			L6F7A:  bmi ObjectExploding     //Is object still exploding? If so, branch.

			L6F7C:  cpx #ShipIndex          //Did the ship just finish exploding?
			L6F7E:  beq ResetShip           //If so, branch.

			L6F80:  bcs ResetSaucer         //Did the saucer just finish exploding? If so, branch.

			L6F82:  dec CurAsteroids        //Must have been an asteroid that finished exploding.
			L6F85:  bne ClearObjSlot        //decrement number of asteroids. Any left? If so, branch.

			L6F87:  ldy #$7F                //No more asteroids this wave.
			L6F89:  sty ThmpSpeedTmr        //Reset thump Speed to slowest Speed.

		ClearObjSlot:

			L6F8C:  lda #$00                //Free up asteroid slot.
			L6F8E:  sta AstStatus,X         //
			L6F91:  beq NextObjUpdate       //Branch always to move to the next object slot.

		ResetShip:

			L6F93:  jsr CenterShip          //($71E8)Center ship on display and zero velocity.
			L6F96:  jmp ClearObjSlot        //($6F8C)Set ship Status to 0.

		ResetSaucer:

			L6F99:  lda ScrTmrReload        //Reset saucer timer.
			L6F9C:  sta ScrTimer            //
			L6F9F:  bne ClearObjSlot        //Branch always.

		ObjectExploding:

			L6FA1:  sta AstStatus,X         //Save updated exploding timer.
			L6FA4:  and #$F0                //
			L6FA6:  clc                     //Get scale to use for exploding object.
			L6FA7:  adc #$10                //

			L6FA9:  cpx #ShipIndex          //Special case. Is ship exploding?
			L6FAB:  bne SetObjExplodeScale  //If not, branch to save exploding scale.

			L6FAD:  lda #$00                //Prepare to set ship explode scale to 7(/4)//

		SetObjExplodeScale:

			L6FAF:  tay                     //Save scale to use for object debris.

			L6FB0:  lda AstXPosLo,X         //
			L6FB3:  sta ThisObjXLB          //
			L6FB5:  lda AstXPosHi,X         //
			L6FB8:  sta ThisObjXUB          //Make a copy of the object position in preparation for drawing.
			L6FBA:  lda AstYPosLo,X         //
			L6FBD:  sta ThisObjYLB          //
			L6FBF:  lda AstYPosHi,X         //
			L6FC2:  sta ThisObjYUB          //

			L6FC4:  jmp DoDrawObject        //($7027)Prepare to draw current object on the display.

		UpdateObjPos:

			L6FC7:  clc                     //Assume object is moving from left to right.
			L6FC8:  ldy #$00                //
			L6FCA:  lda AstXSpeed,X         //Is object moving from left to right?
			L6FCD:  bpl UpdateObjXPos       //If so, branch.

			L6FCF:  dey                     //Indicate object moving from right to left.

		UpdateObjXPos:

			L6FD0:  adc AstXPosLo,X         //Add X velocity to current X position.
			L6FD3:  sta AstXPosLo,X         //
			L6FD6:  sta ThisObjXLB          //Make a copy of location for drawing the object.

			L6FD8:  tya                     //Update the signed upper byte of the object X position.
			L6FD9:  adc AstXPosHi,X         //

			L6FDC:  cmp #$20                //Is the object off the X edge of the display?
			L6FDE:  bcc SaveObjXPos         //If not, branch.

			L6FE0:  and #$1F                //Wrap object to the other X edge of the display.
			L6FE2:  cpx #ScrIndex           //Is the object a saucer?
			L6FE4:  bne SaveObjXPos         //If not, branch.

			L6FE6:  jsr SaucerReset         //($702D)Reset saucer variables.
			L6FE9:  jmp NextObjUpdate       //($6F5E)Check next object slot.

		SaveObjXPos:

			L6FEC:  sta AstXPosHi,X         //Save the updated object X position.
			L6FEF:  sta ThisObjXUB          //

			L6FF1:  clc                     //Assume object is moving from top to bottom.
			L6FF2:  ldy #$00                //
			L6FF4:  lda AstYSpeed,X         //Is object moving from top to bottom?
			L6FF7:  bpl UpdateObjYPos       //If so, branch.

			L6FF9:  ldy #$FF                //Indicate object moving from top to bottom.

		UpdateObjYPos:

			L6FFB:  adc AstYPosLo,X         //Add Y velocity to current Y position.
			L6FFE:  sta AstYPosLo,X         //
			L7001:  sta ThisObjYLB          //Make a copy of location for drawing the object.

			L7003:  tya                     //Update the signed upper byte of the object Y position.
			L7004:  adc AstYPosHi,X         //

			L7007:  cmp #$18                //Is the object off the Y edge of the display?
			L7009:  bcc SaveObjYPos         //If not, branch.

			L700B:  beq WrapObjYPos         //Is object on Y edge border? If so, branch to wrap object.

			L700D:  lda #$17                //place object at the upper edge of the display.
			L700F:  bne SaveObjYPos         //Branch always.

		WrapObjYPos:

			L7011:  lda #$00                //Put object at the bottom edge of the display.

		SaveObjYPos:

			L7013:  sta AstYPosHi,X         //Save the updated object Y position.
			L7016:  sta ThisObjYUB          //

			L7018:  lda AstStatus,X         //Reload the object Status for further processing.

			L701B:  ldy #$E0                //Prepare to set scale to 9(/1).
			L701D:  lsr                     //Does object exist?
			L701E:  bcs DoDrawObject        //If so, branch to prepare to draw current object on the display.

			L7020:  ldy #$F0                //Prepare to set scale to 8(/2).
			L7022:  lsr                     //Does object exist?
			L7023:  bcs DoDrawObject        //If so, branch to prepare to draw current object on the display.

			L7025:  ldy #$00                //Prepare to set scale to 7(/4).

		DoDrawObject:
		
			L7027:  jsr DrawObject          //($72FE)Draw asteroid, ship, saucer.
			L702A:  jmp NextObjUpdate       //($6F5E)Check next object slot.

		}