		* = * "Asteroid"

	SetAstVel: {

			L7203:  jsr GetRandNum          //($77B5)Get a random number.
			L7206:  and #$8F                //Keep the sign bit and lower nibble.
			L7208:  bpl SetAstXVel          //Is this a negative number?
			L720A:  ora #$F0                //If so, sign extend the byte.

		SetAstXVel:

			L720C:  clc                     //Add the new X velocity to the old velocity.
			L720D:  adc AstXSpeed,Y         //

			L7210:  jsr GetAstVelocity      //($7233)Get an X velocity to assign to the asteroid.
			L7213:  sta AstXSpeed,X         //

			L7216:  jsr GetRandNum          //($77B5)Get a random number.
			L7219:  jsr GetRandNum          //($77B5)Get a random number.
			L721C:  jsr GetRandNum          //($77B5)Get a random number.
			L721F:  jsr GetRandNum          //($77B5)Get a random number.

			L7222:  and #$8F                //Keep the sign bit and lower nibble.
			L7224:  bpl SetAstYVel          //Is this a negative number?
			L7226:  ora #$F0                //If so, sign extend the byte.

		SetAstYVel:

			L7228:  clc                     //Add the new Y velocity to the old velocity.
			L7229:  adc AstYSpeed,Y         //

			L722C:  jsr GetAstVelocity      //
			L722F:  sta AstYSpeed,X         //($7233)Get a Y velocity to assign to the asteroid.
			L7232:  rts                     //

	}

	GetAstVelocity: {

			L7233:  bpl SetPosVel           //Is Speed faster than max Speed of -31?
			L7235:  cmp #$E1                //If so, branch to check min negative Speed.
			L7237:  bcs ChkNegTooSlow       //

			L7239:  lda #$E1                //Set max negative Speed to -31.

		ChkNegTooSlow:

			L723B:  cmp #$FB                //Is value faster than -6?
			L723D:  bcc AstVelExit          //If so, branch to exit.
			L723F:  lda #$FA                //Set minimum negative Speed to -6.
			L7241:  rts                     //

		SetPosVel:

			L7242:  cmp #$06                //Is Speed above min Speed of +6?
			L7244:  bcs ChkPosTooFast       //If so, branch to check max Speed.

			L7246:  lda #$06                //Set min positive Speed to +6.

		ChkPosTooFast:

			L7248:  cmp #$20                //Is value greater than +31?
			L724A:  bcc AstVelExit          //If not, branch to exit.
			L724C:  lda #$1F                //Set max positive Speed to +31.

		AstVelExit:
		
			L724E:  rts                     //Return the velocity in A.	

	}

	