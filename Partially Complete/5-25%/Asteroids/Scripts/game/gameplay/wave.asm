

	* = * "Wave"


	InitWaveVars: {

			L7168:  ldx #MaxAsteroids       //start at highest asteroid Status slot.
			L716A:  lda ThmpSpeedTmr        //Is wave about to start?
			L716D:  bne ZeroAstStatuses     //If so, branch to skip most of this routine.

			L716F:  lda ScrStatus           //Is a saucer active?
			L7172:  bne EndInitWave         //If so, branch to skip this routine.

			L7174:  sta SaucerXSpeed        //Zero out saucer Speed.
			L7177:  sta SaucerYSpeed        //
			L717A:  inc ScrSpeedup          //increment the min number of asteroids that triggers saucers-->
			L717D:  lda ScrSpeedup          //appearing more frequently.
			L7180:  cmp #$0B                //Max value is 11 asteroids.
			L7182:  bcc InitAstPerWave      //
			L7184:  dec ScrSpeedup          //Make sure value does not exceed 11 asteroids.

		InitAstPerWave:

			L7187:  lda AstPerWave          //increase number of asteroids by 2 every wave.
			L718A:  clc                     //
			L718B:  adc #$02                //
			L718D:  cmp #$0B                //Ensure 11 asteroids max per wave.
			L718F:  bcc SetWaveAst          //

			L7191:  lda #$0B                //Max initial asteroids per wave is 11.

		SetWaveAst:

			L7193:  sta CurAsteroids        //Set the number of asteroids for the current wave.
			L7196:  sta AstPerWave          //

			L7199:  sta GenByte08           //Create a counter for decrementing through all asteroid slots.
			L719B:  ldy #ScrIndex           //Offset to saucer Speed X and Y values.

		InitWaveAsteroids:

			L719D:  jsr GetRandNum          //($77B5)Get a random number.
			L71A0:  and #$18                //Randomly select asteroid type.
			L71A2:  ora #LargeAst           //Make it a large asteroid.
			L71A4:  sta AstStatus,X         //Store the results.

			L71A7:  jsr SetAstVel           //($7203)Set asteroid X and Y velocities.

			L71AA:  jsr GetRandNum          //($77B5)Get a random number.
			L71AD:  lsr                     //Shift right to save LSB in carry.
			L71AE:  and #$1F                //Keep lower 5 bits.
			L71B0:  bcc AstPosScrBot        //Is carry clear? If so, start asteroid at top/bottom of screen.

			L71B2:  cmp #$18                //If value beyond max Y position(6144/8=768)?
			L71B4:  bcc AstPosScrRght       //If not, branch to set Y position.

			L71B6:  and #$17                //Limit Y position to < 768.

		AstPosScrRght:

			L71B8:  sta AstYPosHi,X         //Set asteroid Y position.
			L71BB:  lda #$00                //
			L71BD:  sta AstXPosHi,X         //Set X to 0.  Asteroid originates at left/right of screen.
			L71C0:  sta AstXPosLo,X         //
			L71C3:  beq NextAstPos          //Branch always.

		AstPosScrBot:

			L71C5:  sta AstXPosHi,X         //Set asteroid X position.
			L71C8:  lda #$00                //
			L71CA:  sta AstYPosHi,X         //Set Y to 0.  Asteroid originates at top/bottom of screen.
			L71CD:  sta AstYPosLo,X         //

		NextAstPos:

			L71D0:  dex                     //Move to next asteroid index.
			L71D1:  dec GenByte08           //Are there more asteroid positions to process?
			L71D3:  bne InitWaveAsteroids   //If so, branch to do another one.

			L71D5:  lda #$7F                //
			L71D7:  sta ScrTimer            //Set initial saucer timer and thump SFX values.
			L71DA:  lda #$30                //
			L71DC:  sta ThmpOffReload       //

		ZeroAstStatuses:

			L71DF:  lda #$00                //Zero out the asteroid Statuses.
			L71E1: 	sta AstStatus,X         //
			L71E4:  dex                     //More asteroid Statuses to zero?
			L71E5:  bpl L71E1                   //If so, branch to do another.

		EndInitWave:
		
			L71E7:  rts                     //End init variables function.


	}