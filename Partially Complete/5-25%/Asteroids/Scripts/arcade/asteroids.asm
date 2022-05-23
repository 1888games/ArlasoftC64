//A good start of the disassembly is located at:
//http://computerarcheology.com/Arcade/Asteroids/Code.html
//Mad props to Lonnie Howell and Mark McDougall
//This code is fully assemblable using Ophis.
//Last updated 12/8/2018 by Nick Mikstas.

* = $6000 "ROM"

#import "defines.asm"

//-------------------------------[ Vector ROM Forward declarations ]--------------------------------

//----------------------------------------[ start Of Code ]-----------------------------------------

							L6800:  jmp RESET               //($7CF3)Initialize the game after power-up.

							InitGame:
							L6803:  jsr SilenceSFX          //($6EFA)Turn off all SFX.
							L6806:  jsr InitGameVars        //($6ED8)Initialize various game variables.

							InitWaves:
							L6809:  jsr InitWaveVars        //($7168)Initialize variables for the current asteroid wave.

							// GameRunningLoop:
							// L680C:  lda SelfTestSw          //Get self test switch Status.
							// L680F:  bmi L680F                  //Is self test active? If so, spin lock until watchdog reset.

							// L6811:  lsr FrameCounter        //Has a new frame started?
							// L6813:  bcc GameRunningLoop     //If not, no processing to do until next frame. Branch to wait.

							// VectorWaitLoop1:
							// L6815:  lda Halt                //Is the vector state machine busy?
							// L6818:  bmi VectorWaitLoop1     //If so, loop until it is idle.

							// L681A:  lda VectorRam+1         //Swap which half of vector RAM is read and which half is-->
							// L681D:  adc #$02                //written. This is done by alternating the jump instruction-->
							// L681F:  sta VectorRam+1         //at the beginning of the RAM between $4402 and $4002.

							// L6822:  sta DmaGo               //start the vector state machine.
							// L6825:  sta WdClear             //Clear the watchdog timer.

							L6828:  inc FrameTimerLo        //
							L682A:  bne SetVecRamPtr        //increment frame counter.
							L682C:  inc FrameTimerHi        //
		/*
							SetVecRamPtr:
							L682E:  ldx #$40                //Is vector RAM pointer currently pointing at $4400 range?
							L6830:  and #$02                //
							L6832:  bne UpdateVecRamPtr     //If so, branch to switch to $4000.

							L6834:  ldx #$44                //Prepare to switch to $4400.

							UpdateVecRamPtr:
							L6836:  lda #$02                //
							L6838:  sta VecRamPtrLB         //Swap vector RAM pointer.
							L683A:  stx VecRamPtrUB         //*/

							L683C:  jsr ChkPreGameStuff     //($6885)Check if non game play functions need to be run.
							L683F:  bcs InitGame            //Branch if attract mode is starting.

							L6841:  jsr CheckHighScore      //($765C)Check if player just got the high score.
							L6844:  jsr ChkHighScrMsg       //($6D90)Do high score and initial entry message if appropriate.
							L6847:  bpl DoScreenText        //Is game not in progress? If not, branch.

							L6849:  jsr ChkHghScrList       //($73C4)Check if high score list needs to be displayed.
							L684C:  bcs DoScreenText        //Is high scores list being displayed? If so, branch.

							L684E:  lda PlyrDispTimer       //Is player not active?
							L6850:  bne DoAsteroids         //If not, branch.

							L6852:  jsr UpdateShip          //($6CD7)Update ship firing and position.
							L6855:  jsr EnterHyprspc        //($6E74)Check if player entered hyperspace.
							L6858:  jsr ChkExitHprspc       //($703F)Check if coming out of hyperspace.
							L685B:  jsr UpdateScr           //($6B93)Update saucer Status.

							DoAsteroids:
							L685E:  jsr UpdateObjects       //($6F57)Update objects(asteroids, ship, saucer and bullets).
							L6861:  jsr Hitdectection       //($69F0)Do hit detection calculations for all objects.

							DoScreenText:
							L6864:  jsr UpdateScreenText    //($724F)Update in-game screen text and reserve lives.
							L6867:  jsr ChkUpdateSFX        //($7555)Check if SFX needs to be updated.

							L686A:  lda #$7F                //X beam coordinate 4 * $7F = $1D0 = 464.
							L686C:  tax                     //Y beam coordinate 4 * $7F = $1D0 = 464.
							L686D:  jsr MoveBeam            //($7C03)Move the CRT beam to a new location.

							L6870:  jsr GetRandNum          //($77B5)Get a random number.

							L6873:  jsr VecHalt             //($7BC0)Halt the vector state machine.

							L6876:  lda ThmpSpeedTmr        //
							L6879:  beq ChkGameRunning      //Is thump Speed timer running? If so, decrement it.
							L687B:  dec ThmpSpeedTmr        //

							ChkGameRunning:
							L687E:  ora CurAsteroids        //Is the game running?
							L6881:  bne GameRunningLoop     //If so, branch to keep it going.

							L6883:  beq InitWaves           //Game not running, branch to initialize variables.

//---------------------------------------[ Helper Routines ]----------------------------------------

							ChkPreGameStuff:
							L6885:  lda NumPlayers          //Are there players currently playing?
							L6887:  beq ChkCoinsPerCredit   //If not, branch.

							L6889:  lda PlyrDispTimer       //Is the player 1/player 2 message being displayed?
							L688B:  bne decPlyrtimer        //If so, branch to decrement timer.
							L688D:  jmp ChkThmpFaster       //($6960)Jump to check if the Thump SFX should be sped up.

							decPlyrtimer:
							L6890:  dec PlyrDispTimer       //decrement player text display timer.
							L6892:  jsr DrawPlyrNum         //($69E2)Draw player number on the display.

							NoResetReturn1:
							L6895:  clc                     //Return without reinitializing the game.
							L6896:  rts                     //

							DoFreeplay:
							L6897:  lda #$02                //Load 2 credits always for free play.
							L6899:  sta NumCredits          //
							L689B:  bne CheckCredits        //Branch always.

							ChkCoinsPerCredit:
							L689D:  lda DipSwitchBits       //Get the number of coins per credit.
							L689F:  and #$03                //Is free play active?
							L68A1:  beq DoFreeplay          //If so, branch to add 2 credits.

							CheckInputInitials:
							L68A3:  clc                     //
							L68A4:  adc #OneTwoText-1       //Prepare to display the coins per play message on the display.
							L68A6:  tay                     //

							L68A7:  lda Plyr1Rank           //Is this the high score entry part?
							L68A9:  and Plyr2Rank           //If so, branch.
							L68AB:  bpl CheckCredits        //

							L68AD:  jsr WriteText           //($77F6)Write coins per play text to the display.

							CheckCredits:
							L68B0:  ldy NumCredits          //Are credits available?
							L68B2:  beq NoResetReturn1      //If not, return.

							L68B4:  ldx #$01                //Has the player 1 button been pressed?
							L68B6:  lda Player1Sw           //
							L68B9:  bmi Do1player           //If so, branch to start 1 player game.

							L68BB:  cpy #$02                //Are there at least 2 credits available?
							L68BD:  bcc ChkstartText        //If not, branch to skip 2 players check.

							Chk2players:
							L68BF:  lda Player2Sw           //Is the player 2 button being pressed?
							L68C2:  bpl ChkstartText        //If not, branch.

							L68C4:  lda MultiPurpBits       //
							L68C6:  ora #RamSwap            //
							L68C8:  sta MultiPurpBits       //Switch to player 2 RAM.
							L68CA:  sta MultiPurp           //

							L68CD:  jsr InitGameVars        //($6ED8)Initialize various game variables.
							L68D0:  jsr InitWaveVars        //($7168)Initialize variables for the current asteroid wave.
							L68D3:  jsr CenterShip          //($71E8)Center ship on display and zero velocity.

							L68D6:  lda ShipsPerGame        //Initialize the player's lives.
							L68D8:  sta Plyr2Ships          //

							L68DA:  ldx #$02                //Indicate this is a 2 player game.
							L68DC:  dec NumCredits          //decrement credits for player 2.

							Do1player:
							L68DE:  stx NumPlayers          //Store number of players this game(1 or 2).
							L68E0:  dec NumCredits          //decrement credits for player 1.

							L68E2:  lda MultiPurpBits       //Clear player 1 and 2 LEDs and RAM swap bit.
							L68E4:  and #$F8                //
							L68E6:  adc NumPlayers          //Turn on LEDs indicating 1 or 2 player game.
							L68E8:  sta MultiPurpBits       //
							L68EA:  sta MultiPurp           //

							L68ED:  jsr CenterShip          //($71E8)Center ship on display and zero velocity.

							L68F0:  lda #$01                //
							L68F2:  sta ShipSpawnTmr        //Initialize ship spawn timer for both players.
							L68F5:  sta ShipSpawnTmr+$100   //

							L68F8:  lda #$92                //
							L68FA:  sta ScrTmrReload        //
							L68FD:  sta ScrTmrReload+$100   //Initialize saucer timer and reload value.
							L6900:  sta ScrTimer+$100       //
							L6903:  sta ScrTimer            //

							L6906:  lda #$7F                //
							L6908:  sta ThmpSpeedTmr        //Initialize thump Speed timer for both players.
							L690B:  sta ThmpSpeedTmr+$100   //

							L690E:  lda #$05                //
							L6910:  sta ScrSpeedup          //Load initial asteroid count that causes more frequent saucers.
							L6913:  sta ScrSpeedup+$100     //

							L6916:  lda #$FF                //
							L6918:  sta Plyr1Rank           //Zero out both player's rank.
							L691A:  sta Plyr2Rank           //

							L691C:  lda #$80                //Load time for displaying player 1/2.
							L691E:  sta PlyrDispTimer       //

							L6920:  asl                     //
							L6921:  sta CurrentPlyr         //Set current player to 1 and the score index for player 1.
							L6923:  sta ScoreIndex          //

							L6925:  lda ShipsPerGame        //Set player 1 reserve lives.
							L6927:  sta Plyr1Ships          //

							L6929:  lda #$04                //
							L692B:  sta ThisVolFreq         //
							L692D:  sta ThumpOffTime        //Set initial thump SFX values.
							L692F:  lda #$30                //
							L6931:  sta ThmpOffReload       //
							L6934:  sta ThmpOffReload+$100  //

							L6937:  sta NoiseReset          //Reset the noise SFX hardware.
							L693A:  rts                     //

							ChkstartText:
							L693B:  lda Plyr1Rank           //Is this the high score entry part?
							L693D:  and Plyr1Rank           //
							L693F:  bpl CheckUpdateLeds     //If so, branch to move on.

							DostartText:
							L6941:  lda FrameTimerLo        //Is it time to display "PUSH staRT" on the display?
							L6943:  and #$20                //
							L6945:  bne CheckUpdateLeds     //If not, branch.

							L6947:  ldy #PshStrtText        //Display "PUSH staRT".
							L6949:  jsr WriteText           //($77F6)Write text to the display.

							CheckUpdateLeds:
							L694C:  lda FrameTimerLo        //Update LEDs every 16 frames.
							L694E:  and #$0F                //Is this the 16th frame?
							L6950:  bne NoResetReturn2      //If not, branch to return from function.

							SetstartLeds:
							L6952:  lda #$01                //
							L6954:  cmp NumCredits          //
							L6956:  adc #$01                //Turn on player 1/player 2 button LEDs.
							L6958:  adc #$01                //
							L695A:  adc MultiPurpBits       //
							L695C:  sta MultiPurpBits       //

							NoResetReturn2:
							L695E:  clc                     //Return without reinitializing the game.
							L695F:  rts                     //

							ChkThmpFaster:
							L6960:  lda FrameTimerLo        //Is it time to Speed up the thump SFX?
							L6962:  and #$3F                //
							L6964:  bne ChkMoreShips        //If not, branch.

							L6966:  lda ThmpOffReload       //Is the thump SFX at max Speed?
							L6969:  cmp #$08                //
							L696B:  beq ChkMoreShips        //If so, branch.

							L696D:  dec ThmpOffReload       //Speed up thump SFX by decreasing off time.

							ChkMoreShips:
							L6970:  ldx CurrentPlyr         //Does the player have any ship remaining?
							L6972:  lda Plyr1Ships,X        //
							L6974:  bne ChkShipStatus       //If so, branch.

							L6976:  lda ShpShotTimer        //Are there any ship bullets on the display?
							L6979:  ora ShpShotTimer+1      //
							L697C:  ora ShpShotTimer+2      //
							L697F:  ora ShpShotTimer+3      //
							L6982:  bne ChkShipStatus       //If so, branch.

							WriteGameOver:
							L6984:  ldy #GmOvrText          //Write "GAME OVER" to the display.
							L6986:  jsr WriteText           //($77F6)Write text to the display.

							L6989:  lda NumPlayers          //Is this a 2 player game?
							L698B:  cmp #$02                //
							L698D:  bcc ChkShipStatus       //If not, branch.

							L698F:  jsr DrawPlyrNum         //($69E2)Draw player number on the display.

							ChkShipStatus:
							L6992:  lda ShipStatus          //Does a ship still exist on the display?
							L6995:  bne NoResetReturn3      //If so, branch to exit.

							L6997:  lda ShipSpawnTmr        //Is ship about to re-spawn?
							L699A:  cmp #$80                //
							L699C:  bne NoResetReturn3      //If so, branch to exit.

							L699E:  lda #$10                //start ship re-spawn timer.
							L69A0:  sta ShipSpawnTmr        //

							L69A3:  ldx NumPlayers          //Get number of players.

							L69A5:  lda Plyr1Ships          //Are there any ships in player 1 or 2 reserves?
							L69A7:  ora Plyr2Ships          //
							L69A9:  beq NoCurntGame         //If not, branch. A game is not currently being played.

							L69AB:  jsr SaucerReset         //($702D)Reset saucer variables.

							L69AE:  dex                     //Is this a 1 player game?
							L69AF:  beq NoResetReturn3      //If so, branch to exit.

							L69B1:  lda #$80                //Load player display timer for player 2.
							L69B3:  sta PlyrDispTimer       //

							L69B5:  lda CurrentPlyr         //Change to next player.
							L69B7:  adc #$01                //

							L69B9:  tax                     //Does the new player have any lives remaining?
							L69BA:  lda Plyr1Ships,X        //
							L69BC:  beq NoResetReturn3      //If not, branch to exit.

							L69BE:  stx CurrentPlyr         //
							L69C0:  lda #RamSwap            //
							L69C2:  adc MultiPurpBits       //RAM swap to new player RAM.
							L69C4:  sta MultiPurpBits       //
							L69C6:  sta MultiPurp           //

							L69C9:  txa                     //
							L69CA:  asl                     //Get index to new player score.
							L69CB:  sta ScoreIndex          //

							NoResetReturn3:
							L69CD:  clc                     //Return without reinitializing the game.
							L69CE:  rts                     //

							NoCurntGame:
							L69CF:  stx PrevGamePlyrs       //Keep track of any previous players.
							L69D1:  lda #$FF                //Set no current players.
							L69D3:  sta NumPlayers          //
							L69D5:  jsr SilenceSFX          //($6EFA)Turn off all SFX.
							L69D8:  lda MultiPurpBits       //
							L69DA:  and #$F8                //Turn on both player button LEDs.
							L69DC:  ora #PlyrLamps          //
							L69DE:  sta MultiPurpBits       //

							NoResetReturn4:
							L69E0:  clc                     //Return without reinitializing the game.
							L69E1:  rts                     //

							DrawPlyrNum:
							L69E2:  ldy #PlyrText           //Prepare to write "plaYER" on the display.
							L69E4:  jsr WriteText           //($77F6)Write text to the display.

							L69E7:  ldy CurrentPlyr         //Get the current player number.
							L69E9:  iny                     //Set it to the proper index for drawing.
							L69EA:  tya                     //
							L69EB:  jsr DrawDigit           //($7BD1)Draw a single digit on the display.
							L69EE:  rts                     //

//----------------------------------------[ Checksum Byte ]-----------------------------------------

L69EF:  .byte $62               //Checksum byte.

//----------------------------------------[ Hit Detection ]-----------------------------------------

//Need to check hit detection between all the on-screen objects.  Object 1 is either a bullet (from
//either the ship or saucer), the player's ship of the saucer.  Object 2 is either an asteroid, the
//player's ship or the saucer.  Object 1 is the outer loop of the check and each object 1 is checked
//against all of the object 2s.  The hit box value extends in both the positive and negative
//directions in both the X and Y directions.

Hitdectection:
L69F0:  ldx #$07                //Prepare to check hit detection on bullets, ship and saucer.

HitDetObj1Loop:
L69F2:  lda ShipStatus,X        //Is the current object 1 slot active?
L69F5:  beq HitDetNextObj1      //If not, branch to increment to the next object 1.

L69F7:  bpl HitDetObj2          //If MSB clear, this object needs hit detection, branch if so.

HitDetNextObj1:
L69F9:  dex                     //Move to next object to check.
L69FA:  bpl HitDetObj1Loop      //More object to check? if so, branch to do another.

L69FC:  rts                     //Done checking hit detection, exit.

HitDetObj2:
L69FD:  ldy #$1C                //Prepare to check hits against asteroids, ship and saucer.

L69FF:  cpx #$04                //Are we checking hit detection against a ship bullet?
L6A01:  bcs HitDetObj2Loop      //If so, branch to check hit detection.

L6A03:  dey                     //Skip checking object 2 as a saucer, will be checked as object 1.
L6A04:  txa                     //Is object 1 not the player's ship?
L6A05:  bne HitDetObj2Loop      //If not, branch to do hit detection.

HitDetNextObj2:
L6A07:  dey                     //Have we checked all the object 2s?
L6A08:  bmi HitDetNextObj1      //If so, branch to increment to the next object 1.

HitDetObj2Loop:
L6A0A:  lda AstStatus,Y         //Is the current object 2 slot active?
L6A0D:  beq HitDetNextObj2      //If not, branch to increment to the next object 2.

L6A0F:  bmi HitDetNextObj2      //If MSB clear, this object needs hit detection, branch if not.

L6A11:  sta Obj2Status          //Store a copy of object 2's current Status.

L6A13:  lda AstXPosLo,Y         //
L6A16:  sec                     //Subtract objects 1 and 2 lower byte of--> 
L6A17:  sbc ShipXPosLo,X        //their X positions and save the result.
L6A1A:  sta ObjXDiff            //

L6A1C:  lda AstXPosHi,Y         //Subtract objects 1 and 2 upper byte of their X positions.
L6A1F:  sbc shipXPosHi,X        //
L6A22:  lsr                     //Keep bit 8 in the difference. XDiff holds bits 8 to 1.
L6A23:  ror ObjXDiff            //
L6A25:  asl                     //Is the MSB of the positions the same?
L6A26:  beq ClacObjYDiff        //If so, possible hit. Branch to calculate the Y difference.

L6A28:  bpl HitDetNextObj2_     //Distance too great. No chance of a hit. Move to next object.

L6A2A:  adc #$FE                //Negative value calculated. Get ABS.
L6A2C:  bne HitDetNextObj2_     //Is MSB the same? IF not, distance too great. Move to next object.

L6A2E:  lda ObjXDiff            //Need to convert XDiff to ABS since its negative.
L6A30:  adc #$FF                //Perform 1s compliment.  It is now its ABS value-1.
L6A32:  sta ObjXDiff            //

ClacObjYDiff:
L6A34:  lda AstYPosLo,Y         //
L6A37:  sec                     //Subtract objects 1 and 2 lower byte of--> 
L6A38:  sbc ShipYPosLo,X        //their X positions and save the result.
L6A3B:  sta ObjYDiff            //

L6A3D:  lda AstYPosHi,Y         //Subtract objects 1 and 2 upper byte of their Y positions.
L6A40:  sbc ShipYPosHi,X        //
L6A43:  lsr                     //Keep bit 8 in the difference. YDiff holds bits 8 to 1.
L6A44:  ror ObjYDiff            //
L6A46:  asl                     //Is the MSB of the positions the same?
L6A47:  beq HitDetPart2         //If so, possible hit. Branch to calculate further.

L6A49:  bpl HitDetNextObj2_     //Distance too great. No chance of a hit. Move to next object.

L6A4B:  adc #$FE                //Negative value calculated. Get ABS.
L6A4D:  bne HitDetNextObj2_     //Is MSB the same? IF not, distance too great. Move to next object.

L6A4F:  lda ObjYDiff            //Need to convert YDiff to ABS since its negative.
L6A51:  adc #$FF                //Perform 1s compliment.  It is now its ABS value-1.
L6A53:  sta ObjYDiff            //

HitDetPart2:
L6A55:  lda #$2A                //Small asteroid hit box 42 X 42 from center.
L6A57:  lsr Obj2Status          //Is this a small asteroid, ship or saucer?
L6A59:  bcs HitDetShip          //If so, branch.

L6A5B:  lda #$48                //Medium asteroid hit box 72 X 72 from center.
L6A5D:  lsr Obj2Status          //Is this a medium asteroid or a saucer?
L6A5F:  bcs HitDetShip          //If so, branch.

L6A61:  lda #$84                //Large asteroid hit box 132 X 132 from center.

HitDetShip:
L6A63:  cpx #$01                //Is object 1 not the player's ship?
L6A65:  bcs HitDetSaucer        //If not, branch.

L6A67:  adc #$1C                //Ship hit box 42+28 = 70 X 70 from center.

HitDetSaucer:
L6A69:  bne CheckObjHit         //Is object a saucer? If not, branch.

L6A6B:  adc #$12                //Small saucer hit box 42+18 = 60 X 60 from center.
L6A6D:  ldx ScrStatus           //

L6A70:  dex                     //Is the object a small saucer?
L6A71:  beq HitDetFinishScr     //If so, branch.

L6A73:  adc #$12                //Large saucer hit box 42+18+18 = 78 X 78 from center.

HitDetFinishScr:
L6A75:  ldx #$01                //Reload object 1 as a saucer.

CheckObjHit:
L6A77:  cmp ObjXDiff            //Is object 1 X difference smaller than the hit box?
L6A79:  bcc HitDetNextObj2_     //If not, no hit detected. Branch to check next object.

L6A7B:  cmp ObjYDiff            //Is object 1 Y difference smaller than the hit box?
L6A7D:  bcc HitDetNextObj2_     //If not, no hit detected. Branch to check next object.

HitDetPart3:
L6A7F:  sta ObjHitBox           //Store hit box value.
L6A81:  lsr                     ///2.
L6A82:  clc                     //Add two hit box values together.
L6A83:  adc ObjHitBox           //Hit box value is now 1.5 X value set above, about sqrt(2).
L6A85:  sta ObjHitBox           //This has the effect of making the hit box more circular.

L6A87:  lda ObjYDiff            //Add the two difference values together.
L6A89:  adc ObjXDiff            //If it causes a carry, The distance is too great.
L6A8B:  bcs HitDetNextObj2_     //Branch to move to next object.

L6A8D:  cmp ObjHitBox           //Is combined difference values grater than the hit box?
L6A8F:  bcs HitDetNextObj2_     //If so, branch to move to the next object.

L6A91:  jsr DoObjHit            //($6B0F)Update object that got hit.

HitDetNextObj1_:
L6A94:  jmp HitDetNextObj1      //($69F9)Check next object 1 for a hit.

HitDetNextObj2_:
L6A97:  dey                     //Are there more object 2s to check?
L6A98:  bmi HitDetNextObj1_     //If not, branch to move to the next object 1.

L6A9A:  jmp HitDetObj2Loop      //($6A0A)Check next object 2 for a hit.

//-----------------------------------[ Update Asteroid Routine ]------------------------------------

UpdateAsteroid:
L6A9D:  lda AstStatus,Y         //
L6AA0:  and #$07                //Save current asteroid size.
L6AA2:  sta GenByte08           //

L6AA4:  jsr GetRandNum          //($77B5)Get a random number.
L6AA7:  and #$18                //Use it to set the asteroid type.
L6AA9:  ora GenByte08           //

L6AAB:  sta AstStatus,X         //Save asteroid size and type.

L6AAE:  lda AstXPosLo,Y         //
L6AB1:  sta AstXPosLo,X         //Save asteroid X position.
L6AB4:  lda AstXPosHi,Y         //
L6AB7:  sta AstXPosHi,X         //

L6ABA:  lda AstYPosLo,Y         //
L6ABD:  sta AstYPosLo,X         //Save asteroid Y position.
L6AC0:  lda AstYPosHi,Y         //
L6AC3:  sta AstYPosHi,X         //

L6AC6:  lda AstXAstYd,Y         //
L6AC9:  sta AstXSpeed,X         //
L6ACC:  lda AstYSpeed,Y         //Save asteroid velocity.
L6ACF:  sta AstYSpeed,X         //
L6AD2:  rts                     //

//--------------------------------------[ Draw Ship Routines ]--------------------------------------

					DrawShip:
					L6AD3:  sta VecPtrLB_           //Save the pointer to the ship vector data.
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
					L6B0D:  bne NextShipOpCode      //

//--------------------------------------[ Update Hit Object ]---------------------------------------

DoObjHit:
L6B0F:  cpx #$01                //Is object 1 that hit object 2 a saucer?
L6B11:  bne ChkObj1Ship         //If not, branch.

L6B13:  cpy #ShipIndex          //Is object 2 that got hit the ship?
L6B15:  bne ObjExplode          //If not, branch.

L6B17:  ldx #$00                //Set object 1 as the ship. 
L6B19:  ldy #ScrIndex           //Set object 2 as the saucer.

ChkObj1Ship:
L6B1B:  txa                     //Is object 1 the ship?
L6B1C:  bne ClearObjRAM         //If not, branch.

Obj1ShipHit:
L6B1E:  lda #$81                //Indicate the ship is waiting to re-spawn.
L6B20:  sta ShipSpawnTmr        //

L6B23:  ldx CurrentPlyr         //Remove a life from the current player.
L6B25:  dec Plyr1Ships,X        //
L6B27:  ldx #$00                //Indicate ship is object 1.

ObjExplode:
L6B29:  lda #$A0                //Indicate object is exploding.
L6B2B:  sta ShipStatus,X        //

L6B2E:  lda #$00                //
L6B30:  sta ShipXSpeed,X        //Zero out the ship's velocity.
L6B33:  sta ShipYSpeed,X        //

L6B36:  cpy #$1B                //Is object 2 an asteroid?
L6B38:  bcc ObjAsteroid         //If so, branch.

L6B3A:  bcs SaucerHit           //Must have been a saucer hit. Branch always.

ClearObjRAM:
L6B3C:  lda #$00                //Remove the hit object from RAM.
L6B3E:  sta ShipStatus,X        //

L6B41:  cpy #ShipIndex          //Is object 2 the ship?
L6B43:  beq Obj2ShipHit         //If so, branch.

L6B45:  bcs SaucerHit           //Was object 2 a saucer? If so, branch.

ObjAsteroid:
L6B47:  jsr BreakAsteroid       //($75EC)Break down a hit asteroid.

ObjHitSFX:
L6B4A:  lda AstStatus,Y         //Change length of hit SFX based on object size.
L6B4D:  and #$03                //
L6B4F:  adc #$02                //
L6B51:  lsr                     //
L6B52:  ror                     //
L6B53:  ror                     //
L6B54:  ora #$3F                //Set hit SFX minimum time.
L6B56:  sta ExplsnSFXTimer      //Set hit SFX time.

L6B58:  lda #$A0                //Indicate object is exploding.
L6B5A:  sta AstStatus,Y         //

L6B5D:  lda #$00                //
L6B5F:  sta AstXSpeed,Y         //Zero out object velocity.
L6B62:  sta AstYSpeed,Y         //
L6B65:  rts                     //

Obj2ShipHit:
L6B66:  txa                     //Get index to current player's reserve ships.
L6B67:  ldx CurrentPlyr         //
L6B69:  dec Plyr1Ships,X        //Remove a life from the current player.
L6B6B:  tax                     //
L6B6C:  lda #$81                //Indicate the ship is waiting to re-spawn.
L6B6E:  sta ShipSpawnTmr        //
L6B71:  bne ObjHitSFX           //Branch always.

SaucerHit:
L6B73:  lda ScrTmrReload        //Reset the saucer timer.
L6B76:  sta ScrTimer            //

L6B79:  lda NumPlayers          //Is someone playing the game?
L6B7B:  beq ObjHitSFX           //If not, branch to skip updating score.

L6B7D:  stx GenByte0D           //Save object 1 index.
L6B7F:  ldx ScoreIndex          //Get index to current player's score.

L6B81:  lda ScrStatus           //Check to see if a small saucer was hit.
L6B84:  lsr                     //
L6B85:  lda #SmallScrPnts       //Prepare to add small saucer points to score.
L6B87:  bcs AddSaucerPoints     //Was a small saucer hit? If so, branch.

L6B89:  lda #LargeScrPnts       //A large saucer was hit. Load large saucer points.

AddSaucerPoints:
L6B8B:  jsr UpdateScore         //($7397)Add points to the current player's score.
L6B8E:  ldx GenByte0D           //Restore object 1 index.
L6B90:  jmp ObjHitSFX           //($6B4A)Set SFX for object being hit based on object size.

//------------------------------------[ Update Saucer Routines ]------------------------------------

UpdateScr:
L6B93:  lda FrameTimerLo        //Update saucers only every 4th frame.
L6B95:  and #$03                //Is this the 4th frame?
L6B97:  beq ChkScrExplode       //If so, branch to continue processing.

EndUpdateScr:
L6B99:  rts                     //End update saucer routines.

ChkScrExplode:
L6B9A:  lda ScrStatus           //Is the saucer currently exploding?
L6B9D:  bmi EndUpdateScr        //If so, branch to exit.

L6B9F:  beq DoScrTimers         //Is no saucer active? if so, branch to update saucer timers.
L6BA1:  jmp ScrYVelocity        //($6C34)Saucer active. Update saucer Y velocity.

DoScrTimers:
L6BA4:  lda NumPlayers          //Is a game currently being played?
L6BA6:  beq DoScrTmrUpdate      //If not, branch to continue.

L6BA8:  lda ShipStatus          //Is the player's ship exploding or in hyperspace?
L6BAB:  beq EndUpdateScr        //If so, branch to exit saucer update routines.
L6BAD:  bmi EndUpdateScr        //

DoScrTmrUpdate:
L6BAF:  lda AstBreakTimer       //Was an asteroid just hit?
L6BB2:  beq UpdateScrTimer      //If not, branch to update saucer timer.

L6BB4:  dec AstBreakTimer       //decrement asteroid hit timer.

UpdateScrTimer:
L6BB7:  dec ScrTimer            //Is it time to re-spawn a saucer?
L6BBA:  bne EndUpdateScr        //If not, branch to exit.

L6BBC:  lda #$01                //Time to re-spawn a saucer. set timer just above 0-->
L6BBE:  sta ScrTimer            //Just in case another factor keeps it from spawning.

L6BC1:  lda AstBreakTimer       //Was an asteroid just hit?
L6BC4:  beq GenNewSaucer        //If not, branch to spawn a saucer.

L6BC6:  lda CurAsteroids        //If an asteroid was just hit and it was the last asteroid,-->
L6BC9:  beq EndUpdateScr        //Branch to end function. No saucer spawn on an empty screen.

L6BCB:  cmp ScrSpeedup          //Has the asteroid number hit the saucer spawn Speedup threshold?
L6BCE:  bcs EndUpdateScr        //If not, branch to end.

GenNewSaucer:
L6BD0:  lda ScrTmrReload        //
L6BD3:  sec                     //Saucer spawn Speedup threshold hit. decrement saucer timer by 6.
L6BD4:  sbc #$06                //

L6BD6:  cmp #$20                //Is pawn timer below minimum value of 32?
L6BD8:  bcc InitNewSaucer       //If so, branch to initialize the new saucer.

L6BDA:  sta ScrTmrReload        //Maintain a minimum saucer spawn timer.

InitNewSaucer:
L6BDD:  lda #$00                //
L6BDF:  sta ScrXPosLo           //start saucer at left edge of the display.
L6BE2:  sta ScrXPosHi           //

L6BE5:  jsr GetRandNum          //($77B5)Get a random number.
L6BE8:  lsr                     //
L6BE9:  ror ScrYPosLo           //
L6BEC:  lsr                     //Use three of the random bits to set the saucer Y position.
L6BED:  ror ScrYPosLo           //
L6BF0:  lsr                     //
L6BF1:  ror ScrYPosLo           //

L6BF4:  cmp #$18                //Is remaining random bits greater than limit?
L6BF6:  bcc SetScrYPosHi        //If not, branch.

L6BF8:  and #$17                //Limit max Y position high byte.

SetScrYPosHi:
L6BFA:  sta ScrYPosHi           //Set high byte of saucer Y starting position.

L6BFD:  ldx #$10                //Randomly set saucer X movement direction.
L6BFF:  bit RandNumUB           //Is saucer moving from left to right?
L6C01:  bvs ScrXVelocity        //If so, branch.

L6C03:  lda #$1F                //
L6C05:  sta ScrXPosHi           //start saucer at right edge of the display.
L6C08:  lda #$FF                //
L6C0A:  sta ScrXPosLo           //

L6C0D:  ldx #$F0                //Set saucer X velocity for a negative direction(right to left).

ScrXVelocity:
L6C0F:  stx SaucerXSpeed        //Save final saucer X velocity.

L6C12:  ldx #$02                //Prepare to make a large saucer.
L6C14:  lda ScrTmrReload        //Is it still early in the asteroid wave?
L6C17:  bmi SetScrStatus        //If so, branch to create a large saucer.

L6C19:  ldy ScoreIndex          //Is the player's score above 3000?
L6C1B:  lda Plr1ScoreThous_,Y   //If so, branch to create a small saucer.
L6C1E:  cmp #$30                //
L6C20:  bcs SetSmallScr         //

L6C22:  jsr GetRandNum          //($77B5)Get a random number.
L6C25:  sta GenByte08           //
L6C27:  lda ScrTmrReload        //Is the random number smaller than the saucer timer-->
L6C2A:  lsr                     //reload value / 2? If so, create a small saucer.
L6C2B:  cmp GenByte08           //
L6C2D:  bcs SetScrStatus        //Else branch to create a large saucer.

SetSmallScr:
L6C2F:  dex                     //X=1. Create a small saucer.

SetScrStatus:
L6C30:  stx ScrStatus           //Store size of saucer and exit.
L6C33:  rts                     //

//For the routines below, a saucer is already active.  These routines update the active saucer.

ScrYVelocity:
L6C34:  lda FrameTimerLo        //Randomly change saucer Y velocity every 128 frames.
L6C36:  asl                     //Is it time to change the saucer's Y velocity?
L6C37:  bne ChkScrUpdate        //If not, branch.

ChangeScrYVel:
L6C39:  jsr GetRandNum          //($77B5)Get a random number.
L6C3C:  and #$03                //Keep the lower 2 bits for index into table below.
L6C3E:  tax                     //
L6C3F:  lda ScrYSpeedTbl,X      //
L6C42:  sta SaucerYSpeed        //Load new Y velocity value for the saucer.

ChkScrUpdate:
L6C45:  lda NumPlayers          //Is a game being played?
L6C47:  beq ChkScrFire          //If not, branch to check saucer fire timer.

L6C49:  lda ShipSpawnTmr        //Is the player actively playing?
L6C4C:  bne ScrUpdateEnd        //If not, branch to exit.

ChkScrFire:
L6C4E:  dec ScrTimer            //Is it time for the saucer's next action?
L6C51:  beq ScrUpdateAction     //If so, branch to do saucer's next action.

ScrUpdateEnd:
L6C53:  rts                     //Done doing saucer updates.

ScrUpdateAction:
L6C54:  lda #$0A                //Reload saucer timer for next saucer action.
L6C56:  sta ScrTimer            //

L6C59:  lda ScrStatus           //Is this a big of small saucer?
L6C5C:  lsr                     //If its a large saucer, prepare to shoot a random shot. -->
L6C5D:  beq GetScrShpDistance   //If its a small saucer, prepare to shoot an aimed shot.

L6C5F:  jsr GetRandNum          //($77B5)Get a random number.
L6C62:  jmp ScrShoot            //($6CC2)Prepare to generate a saucer bullet.

GetScrShpDistance:
L6C65:  lda SaucerXSpeed        //Get saucer X direction velocity.
L6C68:  cmp #$80                //
L6C6A:  ror                     ///2 with sign extension.
L6C6B:  sta GenByte0C           //Save result.

L6C6D:  lda ShipXPosLo          //
L6C70:  sec                     //Get difference between saucer and ship X position low byte.
L6C71:  sbc ScrXPosLo           //
L6C74:  sta GenByte0B           //Save result.

L6C76:  lda shipXPosHi          //Get difference between saucer and ship X position high byte.
L6C79:  sbc ScrXPosHi           //
L6C7C:  jsr NextScrShipDist     //($77EC)Calculate next frame saucer/ship X distance.

L6C7F:  cmp #$40                //Is the saucer to the left of the ship?
L6C81:  bcc SetSmallScrShotDir  //If so, branch to shoot bullet to the right.

L6C83:  cmp #$C0                //Is saucer to the far right of the ship?
L6C85:  bcs $6C89               //If so, branch to shoot bullet to right so it can screen wrap. 

L6C87:  adc #$FF                //Change sign so bullet can shoot left.

SetSmallScrShotDir:
L6C89:  tax                     //Save X distance data for bullet.

L6C8A:  lda SaucerYSpeed        //Get saucer Y velocity and set carry if traveling
L6C8D:  cmp #$80                //in a negative direction.
L6C8F:  ror                     //Divide Speed by 2 and set MSB based on Y direction.
L6C90:  sta GenByte0C           //

L6C92:  lda ShipYPosLo          //
L6C95:  sec                     //Get difference between saucer and ship X position low byte.
L6C96:  sbc ScrYPosLo           //
L6C99:  sta GenByte0B           //Save result.

L6C9B:  lda ShipYPosHi          //Get difference between saucer and ship X position high byte.
L6C9E:  sbc ScrYPosHi           //
L6CA1:  jsr NextScrShipDist     //($77EC)Calculate next frame saucer/ship Y distance.

L6CA4:  tay                     //Save Y distance data for bullet.

L6CA5:  jsr CalcScrShotDir      //($76F0)Calculate the small saucer's shot direction.
L6CA8:  sta ScrBulletDir        //Saucer shot direction is the same type of data as ship direction.

L6CAA:  jsr GetRandNum          //($77B5)Get a random number.
L6CAD:  ldx ScoreIndex          //
L6CAF:  ldy playerScores+1,X    //Is the player's score less than 35,000?
L6CB1:  cpy #$35                //If so, add inaccuracy to small saucer's bullet.
L6CB3:  ldx #$00                //
L6CB5:  bcc ScrShotAddOffset    //

L6CB7:  inx                     //player's score is high, make saucer shot more accurate.

ScrShotAddOffset:
L6CB8:  and ShotRndAddTbl,X     //Mask random value to randomize saucer bullet.
L6CBB:  bpl RandomizeScrShot    //

L6CBD:  ora ShotRndOrTbl,X      //Is random value negative? If so, adjust bullet velocity.

RandomizeScrShot:
L6CC0:  adc ScrBulletDir        //Add randomized value to small saucer shot.

ScrShoot:
L6CC2:  sta ScrBulletDir        //Prepare to fire a bullet if a slot is available.
L6CC4:  ldy #$03                //start index for saucer bullet slots.
L6CC6:  ldx #$01                //2 bullet slots for the saucer.
L6CC8:  stx NumBulletSlots      //
L6CCA:  jmp FindBulletSlot      //($6CF2)Find an empty saucer bullet slot.

ShotRndAddTbl:
L6CCD:  .byte $8F, $87          //Mask for random value to add to small saucer shot.

ShotRndOrTbl:
L6CCF:  .byte $70, $78          //If negative random, set bits to bring it close to the ship.

//This table sets the saucer Y velocity.  It is randomly  
//set and moves the saucer diagonally across the screen.

ScrYSpeedTbl:
L6CD1:  .byte $F0               //-16 Moving down.
L6CD2:  .byte $00               // 0  No Y velocity.
L6CD3:  .byte $00               // 0  No Y velocity.
L6CD4:  .byte $10               //+16 Moving up.

L6CD5:  .byte $00, $00          //Unused.

//-------------------------------------[ Update Ship Routine ]--------------------------------------

									UpdateShip:
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

//----------------------------------------[ Checksum Byte ]-----------------------------------------

L6D8F:  .byte $D6               //Checksum byte.

//---------------------------------[ High Score Message Routines ]----------------------------------

ChkHighScrMsg:
L6D90:  lda Plyr1Rank           //Did one of the players get a ranking in the top 10?
L6D92:  and Plyr2Rank           //
L6D94:  bpl GetPrevplayers      //If so, branch to keep going.
L6D96:  rts                     //Else exit.

GetPrevplayers:
L6D97:  lda PrevGamePlyrs       //Get the number of players in the game that just ended.
L6D99:  lsr                     //Was last game a single player game?
L6D9A:  beq DoHighScrMsg        //If so, branch.

L6D9C:  ldy #PlyrText           //plaYER.
L6D9E:  jsr WriteText           //($77F6)Write text to the display.

L6DA1:  ldy #$02                //Prepare to indicate player 2 high score.
L6DA3:  ldx Plyr2Rank           //Did player 2 get a high score?
L6DA5:  bpl DoplayerDigit       //If so, branch.

L6DA7:  dey                     //Indicate player 1 got high score.

DoplayerDigit:
L6DA8:  sty CurrentPlyr         //Indicate which player got the high score.
L6DAA:  lda FrameTimerLo        //
L6DAC:  and #$10                //Should the player number be displayed?
L6DAE:  bne DoHighScrMsg        //If not, branch.

L6DB0:  tya                     //Set player's digit(1 or 2).
L6DB1:  jsr DrawDigit           //($7BD1)Draw a single digit on the display.

DoHighScrMsg:
L6DB4:  lsr CurrentPlyr         //Get current player.
L6DB6:  jsr SwapRAM             //($73B2)Set RAM for current player.

L6DB9:  ldy #YrScrText          //YOUR SCORE IS ONE OF THE TEN BEST.
L6DBB:  jsr WriteText           //($77F6)Write text to the display.
L6DBE:  ldy #InitText           //PLEASE ENTER YOUR INITIALS.
L6DC0:  jsr WriteText           //($77F6)Write text to the display.
L6DC3:  ldy #PshRtText          //PUSH ROTATE TO SELECT LETTER.
L6DC5:  jsr WriteText           //($77F6)Write text to the display.
L6DC8:  ldy #PshHypText         //PUSH HYPERSPACE WHEN LETTER IS CORRECT.
L6DCA:  jsr WriteText           //($77F6)Write text to the display.

L6DCD:  lda #$20                //Set global scale=2(*4).
L6DCF:  sta GlobalScale         //

L6DD1:  lda #$64                //X beam coordinate 4 * $64 = $190  = 400.
L6DD3:  ldx #$39                //Y beam coordinate 4 * $39 = $E4  = 228.
L6DD5:  jsr MoveBeam            //($7C03)Move the CRT beam to a new location.

L6DD8:  lda #$70                //Set scale 7(/4).
L6DDA:  jsr SpotKill            //($7CDE)Draw zero vector to prevent spots on the screen.

L6DDD:  ldx CurrentPlyr         //
L6DDF:  ldy Plyr1Rank,X         //Save the offset to the current player's initials.
L6DE1:  sty GenByte0B           //

L6DE3:  tya                     //Save index to player's current initial being changed.
L6DE4:  clc                     //
L6DE5:  adc ThisInitial         //
L6DE7:  sta SelInitial          //
L6DE9:  jsr DrawInitial         //($6F1A)Draw a single initial on the display.

L6dec:  ldy GenByte0B           //Draw second initial.
L6DEE:  iny                     //
L6DEF:  jsr DrawInitial         //($6F1A)Draw a single initial on the display.

L6DF2:  ldy GenByte0B           //Draw third initial.
L6DF4:  iny                     //
L6DF5:  iny                     //
L6DF6:  jsr DrawInitial         //($6F1A)Draw a single initial on the display.

L6DF9:  lda HyprSpcSw           //Get hyperspace button Status.
L6DFC:  rol                     //
L6DFD:  rol InitialDebounce     //roll value into debounce register.
L6DFF:  lda InitialDebounce     //
L6E01:  and #$1F                //Keep only lower 5 bits of debounce register.
L6E03:  cmp #$07                //Hyperspace button must be pressed for 3 frames to register.
L6E05:  bne ChkScoreTimeUp      //Did player select an initial? If not, branch.

L6E07:  inc ThisInitial         //Move to the next initial.
L6E09:  lda ThisInitial         //
L6E0B:  cmp #$03                //Has the last initial been selected?
L6E0D:  bcc NextInitial         //If not, branch.

L6E0F:  ldx CurrentPlyr         //
L6E11:  lda #$FF                //Zero out the current player's rank.
L6E13:  sta Plyr1Rank,X         //

FinishHighScore:
L6E15:  ldx #$00                //
L6E17:  stx CurrentPlyr         //Move to player 1 and zero out initial index.
L6E19:  stx ThisInitial         //

L6E1B:  ldx #$F0                //Reset frame timer.
L6E1D:  stx FrameTimerHi        //
L6E1F:  jmp SwapRAM             //($73B2)Set RAM for current player.

NextInitial:
L6E22:  inc SelInitial          //increment initial index.
L6E24:  ldx SelInitial          //

L6E26:  lda #$F4                //Reset frame timer.
L6E28:  sta FrameTimerHi        //

L6E2A:  lda #$0B                //Set value of new initial to A.
L6E2C:  sta HighScoreIntls,X    //

ChkScoreTimeUp:
L6E2E:  lda FrameTimerHi        //Has initial entry time expired?
L6E30:  bne ScoreTimeRemain     //If not, branch.

L6E32:  lda #$FF                //
L6E34:  sta Plyr1Rank           //Zero out player's ranks and finish.
L6E36:  sta Plyr2Rank           //
L6E38:  bmi FinishHighScore     //

ScoreTimeRemain:
L6E3A:  lda FrameTimerLo        //Only update displayed initial every 8th frame.
L6E3C:  and #$07                //Is this the 8th frame?
L6E3E:  bne HighScoreEnd        //If not, branch.

ChkScoreLftBtn:
L6E40:  lda RotLeftSw           //Has rotate left button been pressed?
L6E43:  bpl ChkScoreRghtBtn     //If not, branch.

L6E45:  lda #$01                //increment initial.
L6E47:  bne ChangeInitial       //Branch always.

ChkScoreRghtBtn:
L6E49:  lda RotRghtSw           //Has rotate right button been pressed?
L6E4C:  bpl HighScoreEnd        //If not, branch to end.

L6E4E:  lda #$FF                //decrement initial.

ChangeInitial:
L6E50:  ldx SelInitial          //Update the selected initial.
L6E52:  clc                     //
L6E53:  adc HighScoreIntls,X    //Does value need to wrap around to Z?
L6E55:  bmi SetInitialMax       //If so, branch.

L6E57:  cmp #$0B                //Is initial less than the index for A?
L6E59:  bcs ChkInitialMax       //If so, branch to force index to SPACE.

L6E5B:  cmp #$01                //Is index for a number?
L6E5D:  beq SetInitialMin       //If so, branch to force index to A.

L6E5F:  lda #$00                //Set initial index to SPACE.
L6E61:  beq SetInitial          //Branch always.

SetInitialMin:
L6E63:  lda #$0B                //Set initial index to A.
L6E65:  bne SetInitial          //Branch always.

SetInitialMax:
L6E67:  lda #$24                //Set selected initial to Z.

ChkInitialMax:
L6E69:  cmp #$25                //Does initial index need to wrap to SPACE?
L6E6B:  bcc SetInitial          //If not, branch.

L6E6D:  lda #$00                //Set initial index to SPACE.

SetInitial:
L6E6F:  sta HighScoreIntls,X    //Store new initial value.

HighScoreEnd:
L6E71:  lda #$00                //Done processing high score for this frame.
L6E73:  rts                     //

//-----------------------------------[ Enter Hyperspace Routine ]-----------------------------------

EnterHyprspc:
L6E74:  lda NumPlayers          //Is a game currently being played?
L6E76:  beq ChkHyprspcEnd       //If not, branch to exit.

L6E78:  lda ShipStatus          //Is the player's ship currently exploding?
L6E7B:  bmi ChkHyprspcEnd       //If so, branch to exit.

L6E7D:  lda ShipSpawnTmr        //Is the ship currently waiting to spawn?
L6E80:  bne ChkHyprspcEnd       //If so, branch to exit.

L6E82:  lda HyprSpcSw           //Has the hyperspace button been pressed?
L6E85:  bpl ChkHyprspcEnd       //If not, branch to exit.

L6E87:  lda #$00                //Indicate the ship has entered hyperspace.
L6E89:  sta ShipStatus          //

L6E8C:  sta ShipXSpeed          //Zero out ship velocity.
L6E8F:  sta ShipYSpeed          //

L6E92:  lda #$30                //Set ship spawn timer.
L6E94:  sta ShipSpawnTmr        //

L6E97:  jsr GetRandNum          //($77B5)Get a random number.
L6E9A:  and #$1F                //Get lower 5 bits for new ship X position.
L6E9C:  cmp #$1D                //Make sure value is capped.
L6E9E:  bcc MinHyprspcXPos      //Is value greater than the maximum allowed? If not, branch.

L6EA0:  lda #$1C                //Set X position to max value.

MinHyprspcXPos:
L6EA2:  cmp #$03                //Is value less than the minimum allowed? If not, branch.
L6EA4:  bcs SetHyprspcXPos      //

L6EA6:  lda #$03                //Set X position to min value.

SetHyprspcXPos:
L6EA8:  sta shipXPosHi          //Set the new X position for the ship.

L6EAB:  ldx #$05                //Prepare to get a random number 5 times.

HyprspceRandLoop:
L6EAD:  jsr GetRandNum          //($77B5)Get a random number.
L6EB0:  dex                     //finished getting random numbers?
L6EB1:  bne HyprspceRandLoop    //If not, branch to get another one.

L6EB3:  and #$1F                //Get lower 5 bits of random number.

L6EB5:  inx                     //Assume a successful hyperspace jump.

L6EB6:  cmp #$18                //Check if random number causes a failed hyperspace jump.
L6EB8:  bcc MaxHyprspcYPos      //Jump failed? If not, branch.

L6EBA:  and #$07                //Take lower 3 bits of random number *2 + 4.
L6EBC:  asl                     //Is the resulting value < current number of asteroids?
L6EBD:  adc #$04                //If so, jump was unsuccessful.
L6EBF:  cmp CurAsteroids        //
L6EC2:  bcc MaxHyprspcYPos      //Was jump successful? If so, branch.

L6EC4:  ldx #$80                //Indicate an unsuccessful hyperspace jump.

MaxHyprspcYPos:
L6EC6:  cmp #$15                //Make sure value is capped.
L6EC8:  bcc MinHyprspcYPos      //Is value greater than the maximum allowed? If not, branch.

L6ECA:  lda #$14                //Set Y position to max value.

MinHyprspcYPos:
L6ECC:  cmp #$03                //Is value less than the minimum allowed? If not, branch.
L6ECE:  bcs SetHyprspcYPos      //

L6ED0:  lda #$03                //Set Y position to min value.

SetHyprspcYPos:
L6ED2:  sta ShipYPosHi          //Set the new Y position for the ship.
L6ED5:  stx HyprSpcFlag         //Set the success or failure of the hyperspace jump.

ChkHyprspcEnd:
L6ED7:  rts                     //End hyperspace entry routine.

//----------------------------------[ Initialize Game Variables ]-----------------------------------

							InitGameVars:
							L6ED8:  lda #$02                //Prepare to start wave 1 with 4 asteroids (+2 later).
							L6EDA:  sta AstPerWave          //

							L6EDD:  ldx #$03                //Is the DIP switches set for 3 ships per game?
							L6EDF:  lsr CentCMShipsSw       //
							L6EE2:  bcs InitShipsPerGame    //If so, branch.

							L6EE4:  inx                     //4 ships per game.

							InitShipsPerGame:
							L6EE5:  stx ShipsPerGame        //Load initial ships to start this game with.

							L6EE7:  lda #$00                //Prepare to zero variables.
							L6EE9:  ldx #$03                //

							VarZeroloop:
							L6EEB:  sta ShipStatus,X        //
							L6EEE:  sta ShpShotTimer,X      //
							L6EF1:  sta playerScores,X      //Zero out ship Status, saucer Status and player scores.
							L6EF3:  dex                     //
							L6EF4:  bpl VarZeroloop         //

							L6EF6:  sta CurAsteroids        //Zero out current number of asteroids.
							L6EF9:  rts                     //

//------------------------------------[ Silence Sound Effects ]-------------------------------------

									SilenceSFX:
									L6EFA:  lda #$00                //
									L6EFC:  sta ExpPitchVol         //
									L6EFF:  sta ThumpFreqVol        //
									L6F02:  sta SaucerSFX           //
									L6F05:  sta SaucerFireSFX       //Zero out SFX control registers.
									L6F08:  sta ShipThrustSFX       //
									L6F0B:  sta ShipFireSFX         //
									L6F0E:  sta LifeSFX             //

									L6F11:  sta ExplsnSFXTimer      //
									L6F13:  sta FireSFXTimer        //
									L6F15:  sta ScrFrSFXTimer       //Zero out SFX timers.
									L6F17:  sta ExLfSFXTimer        //
									L6F19:  rts                     //

//-----------------------------------------[ Draw Initial ]-----------------------------------------

DrawInitial:
L6F1A:  lda HighScoreIntls_,Y   //Get value of currently selected initial.
L6F1D:  asl                     //
L6F1E:  tay                     //Does it have a value?
L6F1F:  bne DrawChar            //If so, branch to draw the initial.

L6F21:  lda Plyr1Rank           //Is one of the players in the top 10?
L6F23:  and Plyr2Rank           //
L6F25:  bmi DrawChar            //If not, branch to write the existing initial.

DrawUnderline:
L6F27:  lda #$72                //SVEC for drawing most of the underline.
L6F29:  ldx #$F8                //
L6F2B:  jsr VecWriteWord        //($7D45)Write 2 bytes to vector RAM.

L6F2E:  lda #$01                //SVEC for drawing the rest of the underline.
L6F30:  ldx #$F8                //
L6F32:  jmp VecWriteWord        //($7D45)Write 2 bytes to vector RAM.

DrawChar:
L6F35:  ldx CharPtrTbl+1,Y      //Draw the initial on the display.
L6F38:  lda CharPtrTbl,Y        //
L6F3B:  jmp VecWriteWord        //($7D45)Write 2 bytes to vector RAM.

//---------------------------------[ Draw Reserve Ship On Display ]---------------------------------

DrawExtraLives:
L6F3E:  beq EndDrawLives        //Does payer have ships in reserve? If not, branch to exit.

L6F40:  sty GenByte08           //Create counter value for number of ships to draw.
L6F42:  ldx #$D5                //Y beam coordinate 4 * $D5 = $354 = 852.
L6F44:  ldy #$E0                //Set global scale=14(/4).
L6F46:  sty GlobalScale         //
L6F48:  jsr MoveBeam            //($7C03)Move the CRT beam to a new location.

DrawLivesLoop:
L6F4B:  ldx #<ExtLivesDat       //Load jsr to reserve ship vector data into vector RAM.
L6F4D:  lda #>ExtLivesDat       //
L6F4F:  jsr VecRomjsr           //($7BFC)Load jsr command in vector RAM to vector ROM.
L6F52:  dec GenByte08           //More ships to draw?
L6F54:  bne DrawLivesLoop       //If so, branch.

EndDrawLives:
L6F56:  rts                     //Done drawing reserve ships.

//------------------------------------[ Update Objects Routine ]------------------------------------

								UpdateObjects:
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

								//-----------------------------------------[ Saucer Reset ]-----------------------------------------

								SaucerReset:
								L702D:  lda ScrTmrReload        //Reset saucer timer.
								L7030:  sta ScrTimer            //

								L7033:  lda #$00                //
								L7035:  sta ScrStatus           //
								L7038:  sta SaucerXSpeed        //Clear other saucer variables.
								L703B:  sta SaucerYSpeed        //
								L703E:  rts                     //

//-------------------------------------[ Ship Status Updates ]--------------------------------------

							ChkExitHprspc:
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
														        //Get ship direction in preparation for thrust calculation.
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

							inc $d020

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

							//--------------------------------[ Safe Hyperspace Return Routine ]--------------------------------

							IsReturnSafe:
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

//----------------------------------------[ Checksum Byte ]-----------------------------------------

L7167:  .byte $90               //Checksum byte.

//------------------------------[ Initialize Asteroid Wave Variables ]------------------------------

							InitWaveVars:
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

//------------------------------------[ Center Ship On Screen ]-------------------------------------

							CenterShip:
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

//-----------------------------------[ Set Asteroid Velocities ]------------------------------------

								SetAstVel:
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

								GetAstVelocity:
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

//--------------------------------------[ Update Screen Text ]--------------------------------------

UpdateScreenText:
L724F:  lda #$10                //Set global scale=1(*2).
L7251:  sta GlobalScale         //

L7253:  lda #>VecCredits        //Draw copyright text at bottom of the display.
L7255:  ldx #<VecCredits        //
L7257:  jsr VecRomjsr           //($7BFC)Load jsr command in vector RAM to vector ROM.

L725A:  lda #$19                //X beam coordinate 4 * $19 = $64  = 100.
L725C:  ldx #$DB                //Y beam coordinate 4 * $DB = $36C = 876.
L725E:  jsr MoveBeam            //($7C03)Move the CRT beam to a new location.

L7261:  lda #$70                //Set scale 7(/4).
L7263:  jsr SpotKill            //($7CDE)Draw zero vector to prevent spots on the screen.

L7266:  ldx #$00                //Indicate number string should be drawn on the display.
L7268:  lda NumPlayers          //Is this a 2 player game?
L726A:  cmp #$02                //
L726C:  bne DrawPlr1Score       //If not, branch to draw just player 1's score without blinking.

L726E:  lda CurrentPlyr         //Is player 2 playing?
L7270:  bne DrawPlr1Score       //If so, branch to draw player 1's score without blinking.

L7272:  ldx #$20                //Override the zero blanking function.
L7274:  lda ShipStatus          //Is player 1's ship in play or in hyperspace?
L7277:  ora HyprSpcFlag         //If so, branch to draw player 1's score without blinking.
L7279:  bne DrawPlr1Score       //

L727B:  lda ShipSpawnTmr        //Is player 1 waiting to respawn?
L727E:  bmi DrawPlr1Score       //If so, branch to draw player 1's score without blinking.

L7280:  lda FrameTimerLo        //Blink player 1's score every 16 frames.  This occurs-->
L7282:  and #$10                //when switching from one player to the next.
L7284:  beq DrawShipLives       //Time to draw the score? If not, branch to turn it off.

DrawPlr1Score:
L7286:  lda #Plr1ScoreBase      //Prepare to draw player 1's score on the display.
L7288:  ldy #$02                //2 bytes for player 1's score.
L728A:  sec                     //Blank leading zeros.
L728B:  jsr DrawNumberString    //($773F)Draw a string of numbers on the display.

L728E:  lda #$00                //Draw a trailing zero.
L7290:  jsr ChkSetDigitPntr     //($778B)Prepare to draw a trailing zero after the score.

DrawShipLives:
L7293:  lda #$28                //X beam coordinate 4 * $28 = $A0 = 160.
L7295:  ldy Plyr1Ships          //Get current number of reserve ships for player 1.
L7297:  jsr DrawExtraLives      //($6F3E)Draw player's reserve ships on the display.

L729A:  lda #$00                //Set global scale to 0(*1).
L729C:  sta GlobalScale         //

L729E:  lda #$78                //X beam coordinate 4 * $78 = $1E0 = 480.
L72A0:  ldx #$DB                //Y beam coordinate 4 * $DB = $36C = 876.
L72A2:  jsr MoveBeam            //($7C03)Move the CRT beam to a new location.

L72A5:  lda #$50                //Set scale 5(/16).
L72A7:  jsr SpotKill            //($7CDE)Draw zero vector to prevent spots on the screen.

L72AA:  lda #HighScores         //Prepare to draw the high score on the display.
L72AC:  ldy #$02                //2 bytes for the high score.
L72AE:  sec                     //Blank leading zeros.
L72AF:  jsr DrawNumberString    //($773F)Draw a string of numbers on the display.

L72B2:  lda #$00                //Draw a trailing zero.
L72B4:  jsr DrawDigit           //($7BD1)Draw a single digit on the display.

L72B7:  lda #$10                //Set global scale=1(*2).
L72B9:  sta GlobalScale         //

L72BB:  lda #$C0                //X beam coordinate 4 * $C0 = $300 = 768.
L72BD:  ldx #$DB                //Y beam coordinate 4 * $DB = $36C = 876.
L72BF:  jsr MoveBeam            //($7C03)Move the CRT beam to a new location.

L72C2:  lda #$50                //Set scale 5(/16).
L72C4:  jsr SpotKill            //($7CDE)Draw zero vector to prevent spots on the screen.

L72C7:  ldx #$00                //Indicate number string should be drawn on the display.
L72C9:  lda NumPlayers          //Is this a 2 player game?
L72CB:  cmp #$01                //
L72CD:  beq EndScreenText       //If not, branch to exit.

L72CF:  bcc DrawPlr2Score       //Is a game active? If not, branch to draw player 2's score.

L72D1:  lda CurrentPlyr         //Is player 1 playing?
L72D3:  beq DrawPlr2Score       //If so, branch to draw player 2's score without blinking.

L72D5:  ldx #$20                //Override the zero blanking function.
L72D7:  lda ShipStatus          //Is player 2's ship in play or in hyperspace?
L72DA:  ora HyprSpcFlag         //If so, branch to draw player 2's score without blinking.
L72DC:  bne DrawPlr2Score       //

L72DE:  lda ShipSpawnTmr        //Is player 2 waiting to respawn?
L72E1:  bmi DrawPlr2Score       //If so, branch to draw player 2's score without blinking.

L72E3:  lda FrameTimerLo        //Blink player 2's score every 16 frames.  This occurs-->
L72E5:  and #$10                //when switching from one player to the next.
L72E7:  beq DrawPlr2Ships       //Time to draw the score? If not, branch to turn it off.

DrawPlr2Score:
L72E9:  lda #Plr2ScoreBase      //Prepare to draw player 2's score on the display.
L72EB:  ldy #$02                //2 bytes for the high score.
L72ED:  sec                     //Blank leading zeros.
L72EE:  jsr DrawNumberString    //($773F)Draw a string of numbers on the display.

L72F1:  lda #$00                //Draw a trailing zero.
L72F3:  jsr ChkSetDigitPntr     //($778B)Prepare to draw a trailing zero after the score.

DrawPlr2Ships:
L72F6:  lda #$CF                //X beam coordinate 4 * $CF = $33C = 828.
L72F8:  ldy Plyr2Ships          //Get current number of reserve ships for player 2.
L72FA:  jmp DrawExtraLives      //($6F3E)Draw player's reserve ships on the display.

EndScreenText:
L72FD:  rts                     //Done drawing screen text.

//-------------------------------------[ Draw Object Routines ]-------------------------------------

							DrawObject:
							L72FE:  sty $00                 //Save scale data.
							L7300:  stx GenByte0D           //Save a copy of the index to the object to draw.

							L7302:  lda ThisObjXUB          //
							L7304:  lsr                     //
							L7305:  ror ThisObjXLB          //
							L7307:  lsr                     //Divide the object's X position by 8.
							L7308:  ror ThisObjXLB          //
							L730A:  lsr                     //
							L730B:  ror ThisObjXLB          //
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
							L731D:  sta ThisObjYUB          //

							L731F:  ldx #$04                //Prepare to write 4 bytes to vector RAM.
							L7321:  jsr SetCURData          //($7C1C)Write CUR instruction in vector RAM.

							L7324:  lda #$70                //Set the scale of the object.
							L7326:  sec                     //
							L7327:  sbc $00                 //
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
							L736A:  lda AstPtrnPtrTbl,Y     //Get asteroid vector data and write it to vector RAM.
							L736D:  ldx AstPtrnPtrTbl+1,Y   //

							SaveObjVecData:
							L7370:  jsr VecWriteWord        //($7D45)Write 2 bytes to vector RAM.
							L7373:  ldx GenByte0D           //Restore index to object.
							L7375:  rts                     //Finished loading object data into vector RAM.

							DoDrawShip:
							L7376:  jsr UpdateShipDraw      //($750B)Update the drawing of the player's ship.
							L7379:  ldx GenByte0D           //Restore index to object.
							L737B:  rts                     //Finished loading ship data into vector RAM.

							DoDrawSaucer:
							L737C:  lda ScrPtrnPtrTbl       //Get saucer vector data and write it to vector RAM.
							L737F:  ldx ScrPtrnPtrTbl+1     //
							L7382:  bne SaveObjVecData      //Branch always.

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

//-----------------------------------------[ Update Score ]-----------------------------------------

UpdateScore:
L7397:  sed                     //Put ALU into decimal mode.

L7398:  adc playerScores,X      //Add value in Accumulator to score.
L739A:  sta playerScores,X      //Does upper byte need to be updated?
L739C:  bcc UpdateScoreExit     //If not, branch to exit.

L739E:  lda playerScores+1,X    //
L73A0:  adc #$00                //increment upper score byte.
L73A2:  sta playerScores+1,X    //

L73A4:  and #$0F                //Check if extra life should be granted.
L73A6:  bne UpdateScoreExit     //Extra life granted at 10,000 points.

L73A8:  lda #$B0                //play extra life SFX.
L73AA:  sta ExLfSFXTimer        //
L73AC:  ldx CurrentPlyr         //increment reserve ships.
L73AE:  inc Plyr1Ships,X        //

UpdateScoreExit:
L73B0:  cld                     //Put ALU back into binary mode.
L73B1:  rts                     //

//-------------------------------------------[ Swap RAM ]-------------------------------------------

SwapRAM:
L73B2:  lda CurrentPlyr         //Get current player (0 or 1 value).
L73B4:  asl                     //
L73B5:  asl                     //
L73B6:  sta GenByte08           //Move the LSB to the third bit position.

L73B8:  lda MultiPurpBits       //
L73BA:  and #$FB                //
L73BC:  ora GenByte08           //Set the player RAM based on the current player.
L73BE:  sta MultiPurpBits       //
L73C0:  sta MultiPurp           //
L73C3:  rts                     //

//------------------------------------[ Draw High Scores List ]-------------------------------------

ChkHghScrList:
L73C4:  lda NumPlayers          //Is a game currently being played?
L73C6:  beq ChkDrawScrList      //If not, branch to see if its time to show the high score list.

SkipScrList:
L73C8:  clc                     //Indicate the high scores list is not being displayed.
L73C9:  rts                     //Exit high score list drawing routines.

ChkDrawScrList:
L73CA:  lda FrameTimerHi        //Is it time to draw the high scores list?
L73CC:  and #$04                //
L73CE:  bne SkipScrList         //If not, branch to exit.

L73D0:  lda HiScoreBcdLo        //Is the high scores list empty?
L73D2:  ora HiScoreBcdHi        //
L73D4:  beq SkipScrList         //If so, branch to exit.

L73D6:  ldy #HghScrText         //Prepare to display HIGH SCORES text.
L73D8:  jsr WriteText           //($77F6)Write text to the display.

L73DB:  ldx #$00                //start at the first high score index.
L73DD:  stx InitialIndex        //start at the first initial index.

L73DF:  lda #$01                //Appears not to be used.
L73E1:  sta GenByte00           //

L73E3:  lda #$A7                //Y beam coordinate = 4 * $A7 = $29C = 668.
L73E5:  sta HiScrBeamYLoc       //Set top row of high score list.

L73E7:  lda #$10                //Set global scale=1(*2).
L73E9:  sta GlobalScale         //

HighScoresLoop:
L73EB:  lda HiScoreBcdLo,X      //Is there a high score at the current location?
L73ED:  ora HiScoreBcdHi,X      //
L73EF:  beq HighScoreExit       //If not, done with high score list. Branch to exit.

L73F1:  stx HiScrIndex          //Store index to the current high score.

L73F3:  lda #$5F                //X beam coordinate 4 * $5F = $17C = 380.
L73F5:  ldx HiScrBeamYLoc       //Set the Y beam coordinate based on current line being written.
L73F7:  jsr MoveBeam            //($7C03)Move the CRT beam to a new location.

L73FA:  lda #$40                //Set scale 4(/32).
L73FC:  jsr SpotKill            //($7CDE)Draw zero vector to prevent spots on the screen.

L73FF:  lda HiScrIndex          //Get index to current high score to draw.
L7401:  lsr                     //

L7402:  sed                     //
L7403:  adc #$01                //increment by 1 (base 10).
L7405:  cld                     //

L7406:  sta HiScrRank           //Get the rank number of the current high score.
L7408:  lda #HiScrRank          //

L740A:  sec                     //Blank leading zeros.
L740B:  ldy #$01                //Single byte for player's rank.
L740D:  ldx #$00                //No override of zero blanking.
L740F:  jsr DrawNumberString    //($773F)Draw a string of numbers on the display.

L7412:  lda #$40                //Set the brightness of the dot.
L7414:  tax                     //
L7415:  jsr DrawDot             //($7CE0)Draw a dot on the screen.

L7418:  ldy #$00                //Draw a SPACE on the display.
L741A:  jsr DrawChar            //($6F35)Draw a single character on the display.

L741D:  lda HiScrIndex          //Move to next high score to draw.
L741F:  clc                     //
L7420:  adc #HighScores         //Prepare to draw next high score on the display.

L7422:  ldy #$02                //2 bytes per high score.
L7424:  sec                     //Blank leading zeros.
L7425:  ldx #$00                //No override of zero blanking.
L7427:  jsr DrawNumberString    //($773F)Draw a string of numbers on the display.

L742A:  lda #$00                //Draw a trailing zero.
L742C:  jsr DrawDigit           //($7BD1)Draw a single digit on the display.

L742F:  ldy #$00                //Draw a SPACE on the display.
L7431:  jsr DrawChar            //($6F35)Draw a single character on the display.

L7434:  ldy InitialIndex        //Draw the first initial of this high score.
L7436:  jsr DrawInitial         //($6F1A)Draw a single initial on the display.

L7439:  inc InitialIndex        //Draw the second initial of this high score.
L743B:  ldy InitialIndex        //
L743D:  jsr DrawInitial         //($6F1A)Draw a single initial on the display.

L7440:  inc InitialIndex        //Draw the third initial of this high score.
L7442:  ldy InitialIndex        //
L7444:  jsr DrawInitial         //($6F1A)Draw a single initial on the display.

L7447:  inc InitialIndex        //Move to the next initial index.

L7449:  lda HiScrBeamYLoc       //
L744B:  sec                     //Move down to the next high score row on the display.
L744C:  sbc #$08                //
L744E:  sta HiScrBeamYLoc       //

L7450:  ldx HiScrIndex          //Move to the next high score slot.
L7452:  inx                     //
L7453:  inx                     //Have all 10 high scores been drawn on the display?
L7454:  cpx #$14                //If not, branch to draw the next one.
L7456:  bcc HighScoresLoop      //

HighScoreExit:
L7458:  sec                     //Indicate the high scores list is being displayed.
L7459:  rts                     //Exit high score list drawing routines.

//----------------------------------[ Find A Free Asteroid Slot ]-----------------------------------

GetFreeAstSlot:
L745A:  ldx #MaxAsteroids       //Prepare to check 27 asteroid slots.

NextAstSlotLoop:
L745C:  lda AstStatus,X         //Is this slot free?
L745F:  beq EndFreeAstSlot      //If so, exit. A free slot is available.

L7461:  dex                     //More slots to test?
L7462:  bpl NextAstSlotLoop     //If so, branch to check the next slot.

EndFreeAstSlot:
L7464:  rts                     //Asteroid slot found or no slot available.

//-----------------------------------[ Ship Explosion Routines ]------------------------------------

						DoShipExplsn:
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

						L74C7:  lda VecRamPtrLB         //
						L74C9:  sta VecPtrLB_           //Save a copy of the vector RAM pointer.
						L74CB:  lda VecRamPtrUB         //
						L74CD:  sta VecPtrUB_           //

						L74CF:  jsr CalcDebrisPos       //($7C49)Calculate the position of the exploded ship pieces.

						L74D2:  ldy ShipDebrisPtr       //Write the ship debris vector data to the vector RAM.
						L74D4:  lda ShipExpPtrTbl,Y     //
						L74D7:  ldx ShipExpPtrTbl+1,Y   //
						L74DA:  jsr VecWriteWord        //($7D45)Write 2 bytes to vector RAM.

						L74DD:  ldy ShipDebrisPtr       //Draw the exact same line from above except backwards.
						L74DF:  lda ShipExpPtrTbl+1,Y   //
						L74E2:  adc #$04                //Backtrack in the Y direction.
						L74E4:  tax                     //
						L74E5:  lda ShipExpPtrTbl,Y     //
						L74E8:  and #$0F                //Set the brightness of the backtracked vector to 0.
						L74EA:  adc #$04                //Backtrack in the X direction.
						L74EC:  jsr VecWriteWord        //($7D45)Write 2 bytes to vector RAM.

						L74EF:  ldy #$FF                //Prepare to write 4 bytes to vector RAM.

						VecBackTrack:
						L74F1:  iny                     //Get position of the data where this function first started-->
						L74F2:  lda (VecPtr_),Y         //writing to vector RAM.
						L74F4:  sta (VecRamPtr),Y       //Copy the data again into the current position in vector RAM-->
						L74F6:  iny                     //Except draw it backwards to backtrack the XY position to-->
						L74F7:  lda (VecPtr_),Y         //the starting point.
						L74F9:  adc #$04                //Draw the exact same line from CalcDebrisPos except backwards.
						L74FB:  sta (VecRamPtr),Y       //This places the pointer back to the middle of the ship's position.
						L74FD:  cpy #$03                //Does the second word of the VEC opcode need to be written?
						L74FF:  bcc VecBackTrack        //If so, branch to write second word.

						L7501:  jsr VecPtrUpdate        //($7C39)Update Vector RAM pointer.

						L7504:  ldx ShipDebrisPtr       //Move to next pair of ship debris data.
						L7506:  dex                     //
						L7507:  dex                     //Is there more ship debris data to process?
						L7508:  bpl ShipDebrisLoop      //If so, branch.

						L750A:  rts                     //End ship debris routine.

//-------------------------------[ Update The player's Ship Drawing ]-------------------------------

						UpdateShipDraw:
						L750B:  ldx #$00                //Used for inverting index into ship direction table.
						L750D:  stx ShipDrawUnused      //Always 0.  Not used for anything.

						L750F:  ldy #$00                //Assume ship is pointing up.
						L7511:  lda ShipDir             //Is ship pointing down?
						L7513:  bpl SaveShipDir         //If not, branch.

						InvertshipY:
						L7515:  ldy #$04                //Set value indicating ship Y direction is inverted.
						L7517:  txa                     //
						L7518:  sec                     //Subtract ship direction from #$00 to invert index into-->
						L7519:  sbc ShipDir             //ShipDirPtrTbl

						SaveShipDir:
						L751B:  sta GenByte08           //Save current index calculations.
						L751D:  bit GenByte08           //Is ship pointing down and left?
						L751F:  bmi InvertshipX         //If so, branch to invert X axis of ship.

						L7521:  bvc SetShipInvAxes      //Is ship pointing up and left? If not, branch.

						InvertshipX:
						L7523:  ldx #$04                //Set value indicating ship X direction is inverted.
						L7525:  lda #$80                //
						L7527:  sec                     //Subtract modified ship direction from #$80 to get-->
						L7528:  sbc GenByte08           //proper index into ShipDirPtrTbl.

						SetShipInvAxes:
						L752A:  stx ShipDrawXInv        //Save the X and Y axis inversion indicators.
						L752C:  sty ShipDrawYInv        //

						L752E:  lsr                     //
						L752F:  and #$FE                //Do final calculations on index for ShipDirPtrTbl.
						L7531:  tay                     //

						L7532:  lda ShipDirPtrTbl,Y     //Get pointer to ship vector data for current direction.
						L7535:  ldx ShipDirPtrTbl+1,Y   //
						L7538:  jsr DrawShip            //($6AD3)Draw the player's ship on the display.

						L753B:  lda ThrustSw            //Is the thrust button being pressed?
						L753E:  bpl EndUpdShpDraw       //If not, branch to exit.

						L7540:  lda FrameTimerLo        //Show thrust animation every 4th frame.
						L7542:  and #$04                //Is this the fourth frame?
						L7544:  beq EndUpdShpDraw       //If not, branch to exit.

						L7546:  iny                     //Prepare to move vector ROM pointer to thrust data.
						L7547:  iny                     //
						L7548:  sec                     //
						L7549:  ldx VecPtrUB_           //increment vector ROM pointer by 2 bytes.
						L754B:  tya                     //
						L754C:  adc VecPtrLB_           //Pointer is now at thrust vector data.
						L754E:  bcc DrawShipThrust      //Draw thrust vectors on the display.

						L7550:  inx                     //increment the upper byte of the vector data pointer.

						DrawShipThrust:
						L7551:  jsr DrawShip            //($6AD3)Draw the player's ship on the display.

						EndUpdShpDraw:
						L7554:  rts                     //Finished updating the ship and thrust graphics.

//-------------------------------------[ SFX Control Routines ]-------------------------------------

ChkUpdateSFX:
L7555:  lda NumPlayers          //Is an active game in progress?
L7557:  bne UpdateSFX           //If so, branch to update SFX.
L7559:  rts                     //

UpdateSFX:
L755A:  ldx #$00                //Prepare to turn off saucer SFX if it is exploding or not present.
L755C:  lda ScrStatus           //Is a saucer currently exploding?
L755F:  bmi UpdateScrSFX        //If so, branch.

L7561:  beq UpdateScrSFX        //Is a saucer present? If not, branch to ensure the SFX is off.

L7563:  ror                     //
L7564:  ror                     //Use saucer size to set proper saucer SFX.
L7565:  ror                     //
L7566:  sta SaucerSFXSel        //

L7569:  ldx #$80                //Turn on saucer SFX.

UpdateScrSFX:
L756B:  stx SaucerSFX           //Enable/disable saucer SFX.

L756E:  ldx #$01                //Select the saucer fire SFX.
L7570:  jsr startsFXTimer       //($75CD)start SFX timer, if applicable.
L7573:  sta SaucerFireSFX       //Store updated Status of the SFX.

L7576:  dex                     //Select the ship fire SFX.
L7577:  jsr startsFXTimer       //($75CD)start SFX timer, if applicable.
L757A:  sta ShipFireSFX         //Store updated Status of the SFX.

L757D:  lda ShipStatus          //Is the ship currently on the screen?
L7580:  cmp #$01                //
L7582:  beq ChkNumAsteroids     //If so, branch.

L7584:  txa                     //Load A with #$00. No ship on the screen.
L7585:  sta ShipThrustSFX       //Turn off the thrust SFX.

ChkNumAsteroids:
L7588:  lda CurAsteroids        //Are there asteroids left in this wave?
L758B:  beq ThumpSFXOff         //If not, branch to reset thump SFX.

L758D:  lda ShipStatus          //Is the ship exploding?
L7590:  bmi ThumpSFXOff         //If so, branch to reset the thump SFX.

L7592:  ora HyprSpcFlag         //Is the ship not active and not in hyperspace?
L7594:  beq ThumpSFXOff         //If so, branch to reset the thump SFX.

L7596:  lda ThmpOnTime          //Is the thump SFX currently playing?
L7598:  beq ChkThumpOffTime     //If not, branch.

L759A:  dec ThmpOnTime          //decrement thump on timer.
L759C:  bne ChkExplTimer        //Is thump on timer still active? if so, branch.

ThumpSFXOff:
L759E:  lda ThisVolFreq         //
L75A0:  and #$0F                //Turn off the thump SFX.
L75A2:  sta ThisVolFreq         //
L75A4:  sta ThumpFreqVol        //

L75A7:  lda ThmpOffReload       //
L75AA:  sta ThumpOffTime        //Set thump off timer to max value.
L75AC:  bpl ChkExplTimer        //

ChkThumpOffTime:
L75AE:  dec ThumpOffTime        //decrement the thump off timer.
L75B0:  bne ChkExplTimer        //Is it time to turn thump SFX back on? If not, branch.

ThumpSFXOn:
L75B2:  lda #$04                //Set the thump on timer.
L75B4:  sta ThmpOnTime          //

L75B6:  lda ThisVolFreq         //
L75B8:  adc #$14                //Toggle the thump volume bit on and set the frequency.
L75BA:  sta ThisVolFreq         //
L75BC:  sta ThumpFreqVol        //

ChkExplTimer:
L75BF:  lda ExplsnSFXTimer      //
L75C1:  tax                     //Is the explosion SFX timer active?
L75C2:  and #$3F                //If not, branch to skip decrementing it.
L75C4:  beq UpdateExplTimer     //

L75C6:  dex                     //decrement explosion SFX timer.

UpdateExplTimer:
L75C7:  stx ExplsnSFXTimer      //
L75C9:  stx ExpPitchVol         //Update explosion timer, pitch and volume.
L75CC:  rts                     //

startsFXTimer:
L75CD:  lda ShipFireSFX_,X      //If the selected SFX active?
L75CF:  bmi ChkSFXTimer         //If so, branch to check SFX timer Status.

L75D1:  lda SFXTimers,X         //Is the selected SFX timer currently active?
L75D3:  bpl TurnOffSFX          //If so, branch to turn it off.

L75D5:  lda #$10                //Initialize the timer for the selected SFX.
L75D7:  sta SFXTimers,X         //

TurnOnSFX:
L75D9:  lda #$80                //Turn on the selected SFX.
L75DB:  bmi UpdateSFXStatus     //Branch always.

ChkSFXTimer:
L75DD:  lda SFXTimers,X         //Get the tier value for the selected SFX.
L75DF:  beq TurnOffSFX          //Is the timer expired? If so, branch to turn off.

L75E1:  bmi TurnOffSFX          //Has the timer gone negative, if so, branch to turn off. 

L75E3:  dec SFXTimers,X         //decrement the selected SFX timer.
L75E5:  bne TurnOnSFX           //Is the timer still active? If so, branch to turn SFX on.

TurnOffSFX:
L75E7:  lda #$00                //Turn off the selected SFX.

UpdateSFXStatus:
L75E9:  sta ShipFireSFX_,X      //Update the SFX Status.
L75EB:  rts                     //

//----------------------------------------[ Split Asteroid ]----------------------------------------

BreakAsteroid:
L75EC:  stx GenByte0D           //Save a copy of the object 1 index.

L75EE:  lda #$50                //Set asteroid break timer to 80 frames.
L75F0:  sta AstBreakTimer       //

L75F3:  lda AstStatus,Y         //
L75F6:  and #$78                //Save the asteroid Status except the size. 
L75F8:  sta GenByte0E           //

L75FA:  lda AstStatus,Y         //Reduce the asteroid size by 1.
L75FD:  and #$07                //
L75FF:  lsr                     //
L7600:  tax                     //Does the asteroid still exist?
L7601:  beq SaveAstStatus       //If not, branch to skip combining size with Status.

L7603:  ora GenByte0E           //Combine the other asteroid properties with the new size.

SaveAstStatus:
L7605:  sta AstStatus,Y         //Save the Status of the new asteroid back into RAM.

L7608:  lda NumPlayers          //Is a game currently being played?
L760A:  beq SplitAsteroid       //If not, branch to skip updating score.

AstScoreUpdate:
L760C:  lda GenByte0D           //Did the ship crash into the asteroid?
L760E:  beq DoAstScore          //If so, branch to add points to score.

L7610:  cmp #$04                //Was it a saucer or saucer bullet that hit the asteroid?
L7612:  bcc SplitAsteroid       //If so, branch to skip updating the score.

DoAstScore:
L7614:  lda AstPointsTbl,X      //Get asteroid points from table based on asteroid size.
L7617:  ldx ScoreIndex          //
L7619:  clc                     //
L761A:  jsr UpdateScore         //($7397)Add points to the current player's score.

SplitAsteroid:
L761D:  ldx AstStatus,Y         //Was the asteroid completely destroyed?
L7620:  beq BreakAstEnd         //If so, branch to end. Asteroid not split.

L7622:  jsr GetFreeAstSlot      //($745A)Find a free asteroid slot.
L7625:  bmi BreakAstEnd         //Was a free slot available? If not, branch to end.

L7627:  inc CurAsteroids        //increment total number of asteroids.
L762A:  jsr UpdateAsteroid      //($6A9D)Update new asteroid.
L762D:  jsr SetAstVel           //($7203)Set asteroid X and Y velocities.

L7630:  lda AstXSpeed,X         //Get lower 5 bits asteroid X velocity and * 2.
L7633:  and #$1F                //
L7635:  asl                     //
L7636:  adc AstXPosLo,X         //Use this value to offset the X position of the new asteroid.
L7639:  sta AstXPosLo,X         //

L763C:  jsr NextAstSlotLoop     //($745C)Find a free asteroid slot.
L763F:  bmi BreakAstEnd         //Was a free slot found? If not, branch to exit.

L7641:  inc CurAsteroids        //increment total number of asteroids.
L7644:  jsr UpdateAsteroid      //($6A9D)Update new asteroid.
L7647:  jsr SetAstVel           //($7203)Set asteroid X and Y velocities.

L764A:  lda AstYSpeed,X         //Get lower 5 bits asteroid Y velocity and * 2.
L764D:  and #$1F                //
L764F:  asl                     //
L7650:  adc AstYPosLo,X         //Use this value to offset the Y position of the new asteroid.
L7653:  sta AstYPosLo,X         //

BreakAstEnd:
L7656:  ldx GenByte0D           //Restore the object 1 index before exiting function.
L7658:  rts                     //

//The following table contains the points awarded for the different asteroid sizes.

AstPointsTbl:
L7659:  .byte SmallAstPnts, MedAstPnts, LargeAstPnts

//------------------------------------[ Check For High Score ]--------------------------------------

CheckHighScore:
L765C:  lda NumPlayers          //Is a game currently being played?
L765E:  bpl ChkHghScrEnd        //If not, branch to end.

L7660:  ldx #$02                //start with player 2's score.

L7662:  sta FrameTimerHi        //
L7664:  sta Plyr1Rank           //Reset the frame timer and player's ranks.
L7666:  sta Plyr2Rank           //

PlyrScoreLoop:
L7668:  ldy #$00                //start at the beginning of the high scores list.

ChkHighScoreLoop:
L766A:  lda HighScores_,Y       //Compare the player's score with each entry in the high-->
L766D:  cmp playerScores,X      //score list.
L766F:  lda HighScores_+1,Y     //
L7672:  sbc playerScores+1,X    //Is the player's score higher than the current score entry?
L7674:  bcc PayerHighScore      //If so, branch to add player to the list.

L7676:  iny                     //Move to next entry in the high score table.
L7677:  iny                     //
L7678:  cpy #$14                //Have all 10 entries been checked(2 bytes per entry)?
L767A:  bcc ChkHighScoreLoop    //If no, branch to check the next entry.

NextplayerScore:
L767C:  dex                     //Move to next player to check their score.
L767D:  dex                     //Is there another player to check?
L767E:  bpl PlyrScoreLoop       //If so, branch.

L7680:  lda Plyr2Rank           //Did player 2 get a high score?
L7682:  bmi FinishHghScore      //If not, branch to wrap up this routine.

L7684:  cmp Plyr1Rank           //Did player 1 get a better score than player 2?
L7686:  bcc FinishHghScore      //If not, branch to wrap up this routine.

L7688:  adc #$02                //Did player 1 make the last ranking?
L768A:  cmp #$1E                //
L768C:  bcc SetPlyrRank         //If not, branch so both players can enter scores.

L768E:  lda #$FF                //player 2's score is scrubbed as it is 11th place.

SetPlyrRank:
L7690:  sta Plyr2Rank           //Set player 2's rank.

FinishHghScore:
L7692:  lda #$00                //
L7694:  sta NumPlayers          //Indicate game is over and prepare to enter high score initials.
L7696:  sta ThisInitial         //

ChkHghScrEnd:
L7698:  rts                     //Done checking for high a score.

PayerHighScore:
L7699:  stx GenByte0B           //Store index to current player being processed.
L769B:  sty GenByte0C           //Store index into high scores table.

L769D:  txa                     //
L769E:  lsr                     //Calculate player's rank(each rank increments by 3).
L769F:  tax                     //

L76A0:  tya                     //
L76A1:  lsr                     //Calculate index into high scores initials table.
L76A2:  adc GenByte0C           //

L76A4:  sta GenByte0D           //Store index into high scores initials.
L76A6:  sta Plyr1Rank,X         //Store player's rank.

L76A8:  ldx #$1B                //start at lowest initials to preserve(rank 9).
L76AA:  ldy #$12                //start at lowest score to preserve(rank 9).

ShiftScoresLoop:
L76AC:  cpx GenByte0D           //Has the the player's slot been reached in the high scores list?
L76AE:  beq ClearInitials       //If so, branch to end shifting ranks.

L76B0:  lda ThisInitial,X       //
L76B2:  sta HighScoreIntls,X    //
L76B4:  lda Plyr1Rank,X         //Get initials in high score table and move them down a rank.
L76B6:  sta HighScoreIntls+1,X  //
L76B8:  lda Plyr2Rank,X         //
L76BA:  sta HighScoreIntls+2,X  //

L76BC:  lda HighScores_-2,Y     //
L76BF:  sta HighScores_,Y       //Get score in high score table and move it down a rank.
L76C2:  lda HighScores_-1,Y     //
L76C5:  sta HighScores_+1,Y     //

L76C8:  dey                     //Move to next score in table.
L76C9:  dey                     //

L76CA:  dex                     //
L76CB:  dex                     //Move to next initials in table.
L76CC:  dex                     //

L76CD:  bne ShiftScoresLoop     //More scores to shift down the ranks? If so, branch.

ClearInitials:
L76CF:  lda #$0B                //Set first initial to A.
L76D1:  sta HighScoreIntls,X    //
L76D3:  lda #$00                //Set second and third initial to SPACE.
L76D5:  sta HighScoreIntls+1,X  //
L76D7:  sta HighScoreIntls+2,X  //

L76D9:  lda #$F0                //Set frame timer for displaying initials.
L76DB:  sta FrameTimerHi        //

L76DD:  ldx GenByte0B           //Load index to current player being processed.
L76DF:  ldy GenByte0C           //Load player's index into high score table.

L76E1:  lda playerScores+1,X    //
L76E3:  sta HiScoreBcdHi_,Y     //Transfer player's score into the high score table.
L76E6:  lda playerScores,X      //
L76E8:  sta HiScoreBcdLo_,Y     //

L76EB:  ldy #$00                //Branch always to check next player's score.
L76ED:  beq NextplayerScore     //

//----------------------------------------[ Checksum Byte ]-----------------------------------------

L76EF:  .byte $6E               //Checksum byte.

//-----------------------------[ Calculate Small Saucer Shot Velocity ]-----------------------------

CalcScrShotDir:
L76F0:  tya                     //Load the Y distance between the saucer and the ship.
L76F1:  bpl ScrShotXDir         //Is Y direction positive? If so, branch to do X direction.

L76F3:  jsr TwosCompliment      //($7708)Calculate the 2's compliment of the Y distance.

L76F6:  jsr ScrShotXDir         //($76FC)Calculate the X direction of the saucer shot.
L76F9:  jmp TwosCompliment      //($7708)Calculate the 2's compliment of the value in A.

ScrShotXDir:
L76FC:  tay                     //Save the modified Y shot distance. 
L76FD:  txa                     //Get the the raw X shot distance.
L76FE:  bpl CalcScrShotAngle    //Is X direction positive? If so, branch to calculate shot angle.

L7700:  jsr TwosCompliment      //($7708)Calculate the 2's compliment of the value in A.
L7703:  jsr CalcScrShotAngle    //($770E)Calculate the small saucer's shot angle.
L7706:  adc #$80                //Set the appropriate quadrant for the bullet.

//----------------------------------------[ 2's Compliment ]----------------------------------------

TwosCompliment:
L7708:  adc #$FF                //
L770A:  clc                     //Calculate the 2's compliment of the value in A.
L770B:  adc #$01                //
L770D:  rts                     //

//------------------------------[ Calculate Small Saucer Shot Angle ]-------------------------------

CalcScrShotAngle:
L770E:  sta ShotXYDistance      //Store shot modified X distance.
L7710:  tya                     //
L7711:  cmp ShotXYDistance      //Is X and Y distance the same?
L7713:  beq ShotAngle45         //If so, angle is 45 degrees.  Branch to set and exit.

L7715:  bcc LookUpAngle         //Is angle in lower 45 degrees of quadrant? if so, branch.

L7717:  ldy ShotXYDistance      //Swap X and Y components as the shot is-->
L7719:  sta ShotXYDistance      //in the upper 45 degrees of the quadrant.
L771B:  tya                     //
L771C:  jsr LookUpAngle         //($7728)Look up angle but return to find proper quadrant.

L771F:  sec                     //Set the appropriate quadrant for the bullet.
L7720:  sbc #$40                //
L7722:  jmp TwosCompliment      //($7708)Calculate the 2's compliment of the value in A.

ShotAngle45:
L7725:  lda #$20                //player's ship is at a 45 degree angle to the saucer.
L7727:  rts                     //

LookUpAngle:
L7728:  jsr FindScrAngleIndex   //($776C)Find the index in the table below for the shot angle.
L772B:  lda ShotAngleTbl,X      //
L772E:  rts                     //Look up the proper angle and exit.

//The following table divides 45 degrees of a circle into 16 pieces.  Its used to calculate
//the direction of a bullet from a small saucer to the player's ship.  The other angles in
//the circle are derived from this table.

ShotAngleTbl:
L772F:  .byte $00, $02, $05, $07, $0A, $0C, $0F, $11, $13, $15, $17, $19, $1A, $1C, $1D, $1F 

//-----------------------------------[ Draw A String Of Numbers ]-----------------------------------

DrawNumberString:
L773F:  php                     //Save carry bit Status.
L7740:  stx ZeroBlankBypass     //Save flag indicating if Zero blank should be overridden.
L7742:  dey                     //Adjust index so it is a zero based index.
L7743:  sty BCDIndex            //
L7745:  clc                     //
L7746:  adc BCDIndex            //Use index to calculate actual address of BCD data byte.
L7748:  sta BCDAddress          //
L774A:  plp                     //Restore carry bit Status.

L774B:  tax                     //Get address to BCD byte to draw.

DrawNumStringLoop:
L774C:  php                     //Save carry bit Status.
L774D:  lda $00,X               //
L774F:  lsr                     //
L7750:  lsr                     //Get upper BCD digit to draw.
L7751:  lsr                     //
L7752:  lsr                     //
L7753:  plp                     //Restore carry bit Status
L7754:  jsr SetDigitVecPtr      //($7785)Set vector RAM pointer to digit jsr.

L7757:  lda BCDIndex            //Is this the lower byte of the digit string?
L7759:  bne DoLowerDigit        //If so, disable zero blank function.

L775B:  clc                     //Draw zeros, if present.

DoLowerDigit:
L775C:  ldx BCDAddress          //Get lower BCD digit to draw.
L775E:  lda $00,X               //
L7760:  jsr SetDigitVecPtr      //($7785)Set vector RAM pointer to digit jsr.

L7763:  dec BCDAddress          //decrement to next BCD data byte.
L7765:  ldx BCDAddress          //

L7767:  dec BCDIndex            //Is there more digits to draw in the number string?
L7769:  bpl DrawNumStringLoop   //If so, branch to get next digit byte.

L776B:  rts                     //Done drawing number string.

//-----------------------------[ Small Saucer Shot Angle Calculation ]------------------------------

FindScrAngleIndex:
L776C:  ldy #$00                //Zero out working variable.
L776E:  sty ShotAngleTemp       //
L7770:  ldy #$04                //Prepare to loop 4 times.

ScrAngleIndexLoop:
L7772:  rol ShotAngleTemp       //roll upper bit of working variable into A
L7774:  rol                     //
L7775:  cmp ShotXYDistance      //Is A now larger than the given distance?
L7777:  bcc UpdateAngleCount    //If not, branch to do next loop.

L7779:  sbc ShotXYDistance      //Subtract Distance from A. to get update proper angle index.

UpdateAngleCount:
L777B:  dey                     //Does another loop need to be run?
L777C:  bne ScrAngleIndexLoop   //If so, branch to do another loop.

L777E:  lda ShotAngleTemp       //Move the final index bit into position.
L7780:  rol                     //
L7781:  and #$0F                //Limit the index to 16 values.
L7783:  tax                     //
L7784:  rts                     //Done finding angle index.

//----------------------------------[ Score Pointer Calculation ]-----------------------------------

//This function can do one of two things:
//1) it can write a command in vector RAM to draw a digit, or
//2) or set a pointer to the next data to process, overriding the zero blanking function.
//This function is used to blink a zero score at the beginning of a 2 player game.
//If $17 is #$00, draw digit. If it is any other value, get a pointer to the draw jsr.

SetDigitVecPtr:
L7785:  bcc ChkSetDigitPntr     //Is zero blanking active? If not, branch.

L7787:  and #$0F                //Is the digit to draw 0?
L7789:  beq DisplayDigit        //If so, branch.

ChkSetDigitPntr:
L778B:  ldx ZeroBlankBypass     //Is the zero blank override flag set?
L778D:  beq DisplayDigit        //If not, branch to draw digit.

SetDigitPntr:
L778F:  and #$0F                //
L7791:  clc                     //Add 1 to digit index to skip the SPACE character.
L7792:  adc #$01                //

L7794:  php                     //Save processor Status.

L7795:  asl                     //Get lower byte of pointer.
L7796:  tay                     //Manually set bits into the proper position.
L7797:  lda CharPtrTbl,Y        //
L779A:  asl                     //Store value in lower byte of vector pointer.
L779B:  sta VecPtrLB_           //
L779D:  lda CharPtrTbl+1,Y      //Get upper byte of pointer.
L77A0:  rol                     //Manually set bits into the proper position.
L77A1:  and #$1F                //Get rid of the opcode bits.
L77A3:  ora #$40                //Set MSB of the address manually.
L77A5:  sta VecPtrUB_           //Store value in upper byte of vector pointer.

L77A7:  lda #$00                //Disable XY axis inversion.
L77A9:  sta ShipDrawXInv        //
L77AB:  sta ShipDrawYInv        //
L77AD:  jsr SetVecRAMData       //($6AD7)Update vector RAM with character data.

L77B0:  plp                     //Restore processor Status and exit.
L77B1:  rts                     //

DisplayDigit:
L77B2:  jmp PrepDrawDigit       //($7BCB)Draw a digit on the display.

//-------------------------------[ Random Number Generator ]-------------------------------

							GetRandNum:
							L77B5:  asl RandNumLB           //
							L77B7:  rol RandNumUB           //Use a shift register to store the random number.
							L77B9:  bpl RandNumbit          //

							L77BB:  inc RandNumLB           //increment lower byte.

							RandNumbit:
							L77BD:  lda RandNumLB           //If the second bit set in the random number?
							L77BF:  bit RandNumbitTbl       //
							L77C2:  beq RandNumORUB         //If not, branch to move on.

							L77C4:  adc #$01                //Invert LSB of random number.
							L77C6:  sta RandNumLB           //

							RandNumORUB:
							L77C8:  ora RandNumUB           //Is new random number = 0?
							L77CA:  bne RandNumDone         //If not, branch to exit.

							L77CC:  inc RandNumLB           //Ensure random number is never 0.

							RandNumDone:
							L77CE:  lda RandNumLB           //Return lower byte or random number.
							L77D0:  rts                     //

							RandNumbitTbl:
							L77D1:  .byte $02               //Used by random number generator above.

//---------------------------------[ Thrust Calculation Routines ]----------------------------------

							CalcXThrust:
							L77D2:  clc                     //Adding #$40 to ship/bullet direction will set MSB if facing left.
							L77D3:  adc #$40                //

							CalcThrustDir:
							L77D5:  bpl GetVelocityVal      //Is ship/saucer bullet facing right/up? If so, branch.

							L77D7:  and #$7F                //Ship/saucer bullet is facing left/down. Clear direction MSB.
							L77D9:  jsr GetVelocityVal      //($77DF)Get ship/saucer bullet velocity for this XY component.
							L77DC:  jmp TwosCompliment      //($7708)Calculate the 2's compliment of the value in A.

							GetVelocityVal:
							L77DF:  cmp #$41                //Is ship/saucer bullet facing right/up?
							L77E1:  bcc LookupThrustVal     //If so, branch.

							L77E3:  adc #$7F                //Ship/saucer bullet is facing left/down. Need to lookup-->
							L77E5:  adc #$00                //table in reverse order.

							LookupThrustVal:
							L77E7:  tax                     //
							L77E8:  lda ThrustTbl,X         //Get velocity value from lookup table.
							L77EB:  rts                     //

//--------------------------------[Next Frame Saucer/Ship Distance ]--------------------------------

NextScrShipDist:
L77EC:  asl GenByte0B           //
L77EE:  rol                     //Get the signed difference between-->
L77EF:  asl GenByte0B           //the ship and saucer upper 4 bits.
L77F1:  rol                     //

L77F2:  sec                     //Predict next location of saucer with respect to the ship-->
L77F3:  sbc GenByte0C           //by subtracting the current saucer XY velocity from the-->
L77F5:  rts                     //from the saucer/ship distance.

//------------------------------------[ Text Writing Routines ]-------------------------------------

						WriteText:
						// L77F6:  lda LanguageSw          //Get the language dip switch settings.
						// L77F9:  and #$03                //
						// L77FB:  asl                     //*2. 2 bytes per entry in the pointer table below.
						// L77FC:  tax                     //Save index into table in X.

						// L77FD:  lda #$10                //Appears to have no effect.
						// L77FF:  sta GenByte00           //

						// L7801:  lda LanguagePtrTbl+1,X  //
						// L7804:  sta VecRomPtrUB         //Get pointer to language data from the table below.
						// L7806:  lda LanguagePtrTbl,X    //
						// L7809:  sta VecRomPtrLB         //

						// L780B:  adc (VecRomPtr),Y       //Add offset to desired text message.
						// L780D:  sta VecRomPtrLB         //
						// L780F:  bcc GetTextPos          //Does upper byte need to be incremented?
						// L7811:  inc VecRomPtrUB         //If not, branch to move on.

						// GetTextPos:
						// L7813:  tya                     //
						// L7814:  asl                     //*2. Each entry in the table below is 2 bytes.
						// L7815:  tay                     //

						L7816:  lda TextPosTbl,Y        //Get the screen position for the desired text.
						L7819:  ldx TextPosTbl+1,Y      //
						//L781C:  jsr MoveBeam            //($7C03)Move the CRT beam to a new location.

						// L781F:  lda #$70                //Set scale 7(/4).
						// L7821:  jsr SpotKill            //($7CDE)Draw zero vector to prevent spots on the screen.

						// L7824:  ldy #$00                //Zero out index values.
						// L7826:  ldx #$00                //

						// TextWriteLoop:
						// L7828:  lda (VecRomPtr,X)       //Get the character byte from ROM.
						// L782A:  sta GenByte0B           //
						// L782C:  lsr                     //Move the upper 5 bits into the proper position.
						// L782D:  lsr                     //
						// L782E:  jsr TextWriteincPtr     //($784D)increment the vector ROM pointer and write to RAM.

						// L7831:  lda (VecRomPtr,X)       //Get the next character byte from ROM.
						// L7833:  rol                     //
						// L7834:  rol GenByte0B           //roll the 2 upper bits into the working variable.
						// L7836:  rol                     //
						// L7837:  lda GenByte0B           //Move the next 5 character bits into the proper position.
						// L7839:  rol                     //
						// L783A:  asl                     //
						// L783B:  jsr CheckNextChar       //($7853)Check if the next character is valid and write to RAM.

						// L783E:  lda (VecRomPtr,X)       //Get the next text character byte.
						// L7840:  sta GenByte0B           //
						// L7842:  jsr TextWriteincPtr     //($784D)increment the vector ROM pointer.

						// L7845:  lsr GenByte0B           //Is the last bit 0?
						// L7847:  bcc TextWriteLoop       //If not, branch to write another character.

						// TextWriteDone:
						// L7849:  dey                     //Last byte was end string character, compensate.
						// L784A:  jmp VecPtrUpdate        //($7C39)Update Vector RAM pointer.

						// TextWriteincPtr:
						// L784D:  inc VecRomPtrLB         //
						// L784F:  bne CheckNextChar       //increment vector ROM pointer.
						// L7851:  inc VecRomPtrUB         //

						// CheckNextChar:
						// L7853:  and #$3E                //Is the data empty? If so, end of string found.
						// L7855:  bne PrepWriteChar       //If not, branch to write character to display.

						// TextEndFound:
						// L7857:  pla                     //Pull last return address from stack and update-->
						// L7858:  pla                     //the vector RAM pointer.
						// L7859:  bne TextWriteDone       //

						// PrepWriteChar:
						// L785B:  cmp #$0A                //Is the character non-indexed?
						// L785D:  bcc VecRamWriteChar     //If so, add offset to get to the indexed characters.
						// L785F:  adc #$0D                //

						// VecRamWriteChar:
						// L7861:  tax                     //
						// L7862:  lda CharPtrTbl-2,X      //
						// L7865:  sta (VecRamPtr),Y       //
						// L7867:  iny                     //
						// L7868:  lda CharPtrTbl-1,X      //Store routine for writing desired character in vector RAM.
						// L786B:  sta (VecRamPtr),Y       //
						// L786D:  iny                     //
						// L786E:  ldx #$00                //
						// L7870:  rts                     //

						TextPosTbl:
						L7871:  .byte $64, $B6          //X=4*$64=$190=400. Y=4*$B6=$2D8=728.
						L7873:  .byte $64, $B6          //X=4*$64=$190=400. Y=4*$B6=$2D8=728.
						L7875:  .byte $0C, $AA          //X=4*$0C=$30 =48.  Y=4*$AA=$2A8=680.
						L7877:  .byte $0C, $A2          //X=4*$0C=$30 =48.  Y=4*$A2=$288=648.
						L7879:  .byte $0C, $9A          //X=4*$0C=$30 =48.  Y=4*$9A=$268=616.
						L787B:  .byte $0C, $92          //X=4*$0C=$30 =48.  Y=4*$92=$248=584.
						L787D:  .byte $64, $C6          //X=4*$64=$190=400. Y=4*$C6=$318=792.
						L787F:  .byte $64, $9D          //X=4*$64=$190=400. Y=4*$9D=$274=628.
						L7881:  .byte $50, $39          //X=4*$50=$140=320. Y=4*$39=$E4 =228.
						L7883:  .byte $50, $39          //X=4*$50=$140=320. Y=4*$39=$E4 =228.
						L7885:  .byte $50, $39          //X=4*$50=$140=320. Y=4*$39=$E4 =228.

LanguagePtrTbl:
L7887:  .word EnglishTextTbl    //
L7889:  .word GermanTextTbl     //Text table pointers.
L788B:  .word FrenchTextTbl     //
L788D:  .word SpanishTextTbl    //

//----------------------------------[ German Message Vector Data ]----------------------------------

//Message offsets
GermanTextTbl:
L788F:  .byte $0B               //HOECHSTERGEBNIS
L7890:  .byte $15               //SPIELER 
L7891:  .byte $1B               //IHR ERGEBNIS IST EINES DER ZEHN BESTEN
L7892:  .byte $35               //bitTE GEBEN SIE IHRE INITIALEN EIN
L7893:  .byte $4D               //ZUR BUCHstaBENWAHL ROTATE DRUECKEN
L7894:  .byte $65               //WENN BUCHstaBE OK HYPERSPACE DRUECKEN
L7895:  .byte $7F               //staRTKNOEPFE DRUECKEN
L7896:  .byte $8D               //SPIELENDE
L7897:  .byte $93               //1 MUENZE 2 SPIELE
L7898:  .byte $9F               //1 MUENZE 1 SPIEL
L7899:  .byte $AB               //2 MUENZEN 1 SPIEL

//---------------------------------------[ HOECHSTERGEBNIS ]----------------------------------------

//               H     O     E        C     H     S        T     E     R        G     E     B      
//             01100_10011_01001_0, 00111_01100_10111_0, 11000_01001_10110_0, 01011_01001_00110_0
L789A:  .byte     $64, $D2,            $3B, $2E,            $C2, $6C,            $5A, $4C
//               N     I     S      
//             10010_01101_10111_1
L78A2:  .byte     $93, $6F

//-------------------------------------------[ SPIELER ]--------------------------------------------

//               S     P     I        E     L     E        R     _    NULL    
//             10111_10100_01101_0, 01001_10000_01001_0, 10110_00001_00000_0
L78A4:  .byte     $BD, $1A,            $4C, $12,            $B0, $40

//----------------------------[ IHR ERGEBNIS IST EINES DER ZEHN BESTEN ]----------------------------

//               I     H     R        _     E     R        G     E     B        N     I     S      
//             01101_01100_10110_0, 00001_01001_10110_0, 01011_01001_00110_0, 10010_01101_10111_0
L78AA:  .byte     $6B, $2C,            $0A, $6C,            $5A, $4C,            $93, $6E
//               _     I     S        T     _     E        I     N     E        S     _     D      
//             00001_01101_10111_0, 11000_00001_01001_0, 01101_10010_01001_0, 10111_00001_01000_0
L78B2:  .byte     $0B, $6E,            $C0, $52,            $6C, $92,            $B8, $50
//               E     R     _        Z     E     H        N     _     B        E     S     T      
//             01001_10110_00001_0, 11110_01001_01100_0, 10010_00001_00110_0, 01001_10111_11000_0
L78BA:  .byte     $4D, $82,            $F2, $58,            $90, $4C,            $4D, $F0
//               E     N    NULL    
//             01001_10010_00000_0
L78C2:  .byte     $4C, $80

//------------------------------[ bitTE GEBEN SIE IHRE INITIALEN EIN ]------------------------------

//               B     I     T        T     E     _        G     E     B        E     N     _      
//             00110_01101_11000_0, 11000_01001_00001_0, 01011_01001_00110_0, 01001_10010_00001_0
L78C4:  .byte     $33, $70,            $C2, $42,            $5A, $4C,            $4C, $82
//               S     I     E        _     I     H        R     E     _        I     N     I      
//             10111_01101_01001_0, 00001_01101_01100_0, 10110_01001_00001_0, 01101_10010_01101_0
L78CC:  .byte     $BB, $52,            $0B, $58,            $B2, $42,            $6C, $9A
//               T     I     A        L     E     N        _     E     I        N    NULL  NULL    
//             11000_01101_00101_0, 10000_01001_10010_0, 00001_01001_01101_0, 10010_00000_00000_0
L78D4:  .byte     $C3, $4A,            $82, $64,            $0A, $5A,            $90, $00

//------------------------------[ ZUR BUCHstaBENWAHL ROTATE DRUECKEN ]------------------------------

//               Z     U     R        _     B     U        C     H     S        T     A     B      
//             11110_11001_10110_0, 00001_00110_11001_0, 00111_01100_10111_0, 11000_00101_00110_0
L78DC:  .byte     $F6, $6C,            $09, $B2,            $3B, $2E,            $C1, $4C
//               E     N     W        A     H     L        _     R     O        T     A     T      
//             01001_10010_11011_0, 00101_01100_10000_0, 00001_10110_10011_0, 11000_00101_11000_0
L78E4:  .byte     $4C, $B6,            $2B, $20,            $0D, $A6,            $C1, $70
//               E     _     D        R     U     E        C     K     E        N    NULL  NULL    
//             01001_00001_01000_0, 10110_11001_01001_0, 00111_01111_01001_0, 10010_00000_00000_0
L78EC:  .byte     $48, $50,            $B6, $52,            $3B, $D2,            $90, $00

//-----------------------------[ WENN BUCHstaBE OK HYPERSPACE DRUECKEN ]----------------------------

//               W     E     N        N     _     B        U     C     H        S     T     A      
//             11011_01001_10010_0, 10010_00001_00110_0, 11001_00111_01100_0, 10111_11000_00101_0
L78F4:  .byte     $DA, $64,            $90, $4C,            $C9, $D8,            $BE, $0A
//               B     E     _        O     K     _        H     Y     P        E     R     S      
//             00110_01001_00001_0, 10011_01111_00001_0, 01100_11101_10100_0, 01001_10110_10111_0
L78FC:  .byte     $32, $42,            $9B, $C2,            $67, $68,            $4D, $AE
//               P     A     C        E     _     D        R     U     E        C     K     E      
//             10100_00101_00111_0, 01001_00001_01000_0, 10110_11001_01001_0, 00111_01111_01001_0
L7904:  .byte     $A1, $4E,            $48, $50,            $B6, $52,            $3B, $D2
//               N    NULL  NULL    
//             10010_00000_00000_0
L790C:  .byte     $90, $00

//------------------------------------[ staRTKNOEPFE DRUECKEN ]-------------------------------------

//               S     T     A        R     T     K        N     O     E        P     F     E      
//             10111_11000_00101_0, 10110_11000_01111_0, 10010_10011_01001_0, 10100_01010_01001_0
L790E:  .byte     $BE, $0A,            $B6, $1E,            $94, $D2,            $A2, $92
//               _     D     R        U     E     C        K     E     N      
//             00001_01000_10110_0, 11001_01001_00111_0, 01111_01001_10010_1
L7916:  .byte     $0A, $2C,            $CA, $4E,            $7A, $65

//------------------------------------------[ SPIELENDE ]-------------------------------------------

//               S     P     I        E     L     E        N     D     E      
//             10111_10100_01101_0, 01001_10000_01001_0, 10010_01000_01001_1
L791C:  .byte     $BD, $1A,            $4C, $12,            $92, $13

//--------------------------------------[ 1 MUENZE 2 SPIELE ]---------------------------------------

//               1     _     M        U     E     N        Z     E     _        2     _     S      
//             00011_00001_10001_0, 11001_01001_10010_0, 11110_01001_00001_0, 00100_00001_10111_0
L7922:  .byte     $18, $62,            $CA, $64,            $F2, $42,            $20, $6E
//               P     I     E        L     E    NULL    
//             10100_01101_01001_0, 10000_01001_00000_0
L792A:  .byte     $A3, $52,            $82, $40

//---------------------------------------[ 1 MUENZE 1 SPIEL ]---------------------------------------

//               1     _     M        U     E     N        Z     E     _        1     _     S      
//             00011_00001_10001_0, 11001_01001_10010_0, 11110_01001_00001_0, 00011_00001_10111_0
L792E:  .byte     $18, $62,            $CA, $64,            $F2, $42,            $18, $6E
//               P     I     E        L    NULL  NULL    
//             10100_01101_01001_0, 10000_00000_00000_0
L7936:  .byte     $A3, $52,            $80, $00

//--------------------------------------[ 2 MUENZEN 1 SPIEL ]---------------------------------------

//               2     _     M        U     E     N        Z     E     N        _     1     _      
//             00100_00001_10001_0, 11001_01001_10010_0, 11110_01001_10010_0, 00001_00011_00001_0
L793A:  .byte     $20, $62,            $CA, $64,            $F2, $64,            $08, $C2
//               S     P     I        E     L    NULL    
//             10111_10100_01101_0, 01001_10000_00000_0
L7942:  .byte     $BD, $1A,            $4C, $00

//----------------------------------[ French Message Vector Data ]----------------------------------

//Message offsets
FrenchTextTbl:
L7946:  .byte $0B               //MEILLEUR SCORE
L7947:  .byte $15               //JOUER 
L7948:  .byte $19               //VOTRE SCORE EST UN DES 10 MEILLEURS
L7949:  .byte $31               //SVP ENTREZ VOS INITIALES
L794A:  .byte $41               //POUSSEZ ROTATE POUR VOS INITIALES
L794B:  .byte $57               //POUSSEZ HYPERSPACE QUand LETTRE CORRECTE
L794C:  .byte $73               //APPUYER SUR staRT
L794D:  .byte $7F               //FIN DE PArtiE
L794E:  .byte $89               //1 PIECE 2 JOUEURS
L794F:  .byte $95               //1 PIECE 1 JOUEUR
L7950:  .byte $A1               //2 PIECES 1 JOUEUR

//----------------------------------------[ MEILLEUR SCORE ]----------------------------------------

//               M     E     I        L     L     E        U     R     _        S     C     O      
//             10001_01001_01101_0, 10000_10000_01001_0, 11001_10110_00001_0, 10111_00111_10011_0
L7951:  .byte     $8A, $5A,            $84, $12,            $CD, $82,            $B9, $E6
//               R     E    NULL    
//             10110_01001_00000_0
L7959:  .byte     $B2, $40

//--------------------------------------------[ JOUER ]---------------------------------------------

//               J     O     U        E     R     _      
//             01110_10011_11001_0, 01001_10110_00001_1
L795B:  .byte     $74, $F2,            $4D, $83

//-------------------------------[ VOTRE SCORE EST UN DES 10 MEILLEURS ]----------------------------

//               V     O     T        R     E     _        S     C     O        R     E     _      
//             11010_10011_11000_0, 10110_01001_00001_0, 10111_00111_10011_0, 10110_01001_00001_0
L795F:  .byte     $D4, $F0,            $B2, $42,            $B9, $E6,            $B2, $42
//               E     S     T        _     U     N        _     D     E        S     _     1      
//             01001_10111_11000_0, 00001_11001_10010_0, 00001_01000_01001_0, 10111_00001_00011_0
L7967:  .byte     $4D, $F0,            $0E, $64,            $0A, $12,            $B8, $46
//               0     _     M        E     I     L        L     E     U        R     S    NULL    
//             00010_00001_10001_0, 01001_01101_10000_0, 10000_01001_11001_0, 10110_10111_00000_0
L796F:  .byte     $10, $62,            $4B, $60,            $82, $72,            $B5, $C0

//-----------------------------------[ SVP ENTREZ VOS INITIALES ]-----------------------------------

//               S     V     P        _     E     N        T     R     E        Z     _     V      
//             10111_11010_10100_0, 00001_01001_10010_0, 11000_10110_01001_0, 11110_00001_11010_0
L7977:  .byte     $BE, $A8,            $0A, $64,            $C5, $92,            $F0, $74
//               O     S     _        I     N     I        T     I     A        L     E     S      
//             10011_10111_00001_0, 01101_10010_01101_0, 11000_01101_00101_0, 10000_01001_10111_1
L797F:  .byte     $9D, $C2,            $6C, $9A,            $C3, $4A,            $82, $6F

//------------------------------[ POUSSEZ ROTATE POUR VOS INITIALES ]-------------------------------

//               P     O     U        S     S     E        Z     _     R        O     T     A      
//             10100_10011_11001_0, 10111_10111_01001_0, 11110_00001_10110_0, 10011_11000_00101_0
L7987:  .byte     $A4, $F2,            $BD, $D2,            $F0, $6C,            $9E, $0A
//               T     E     _        P     O     U        R     _     V        O     S     _      
//             11000_01001_00001_0, 10100_10011_11001_0, 10110_00001_11010_0, 10011_10111_00001_0
L798F:  .byte     $C2, $42,            $A4, $F2,            $B0, $74,            $9D, $C2
//               I     N     I        T     I     A        L     E     S      
//             01101_10010_01101_0, 11000_01101_00101_0, 10000_01001_10111_1
L7997:  .byte     $6C, $9A,            $C3, $4A,            $82, $6F

//---------------------------[ POUSSEZ HYPERSPACE QUand LETTRE CORRECTE ]---------------------------

//               P     O     U        S     S     E        Z     _     H        Y     P     E      
//             10100_10011_11001_0, 10111_10111_01001_0, 11110_00001_01100_0, 11101_10100_01001_0
L799D:  .byte     $A4, $F2,            $BD, $D2,            $F0, $58,            $ED, $12
//               R     S     P        A     C     E        _     Q     U        A     N     D      
//             10110_10111_10100_0, 00101_00111_01001_0, 00001_10101_11001_0, 00101_10010_01000_0
L79A5:  .byte     $B5, $E8,            $29, $D2,            $0D, $72,            $2C, $90
//               _     L     E        T     T     R        E     _     C        O     R     R      
//             00001_10000_01001_0, 11000_11000_10110_0, 01001_00001_00111_0, 10011_10110_10110_0
L79AD:  .byte     $0C, $12,            $C6, $2C,            $48, $4E,            $9D, $AC
//               E     C     T        E    NULL  NULL    
//             01001_00111_11000_0, 01001_00000_00000_0
L79B5:  .byte     $49, $F0,            $48, $00

//--------------------------------------[ APPUYER SUR staRT ]---------------------------------------

//               A     P     P        U     Y     E        R     _     S        U     R     _      
//             00101_10100_10100_0, 11001_11101_01001_0, 10110_00001_10111_0, 11001_10110_00001_0
L79B9:  .byte     $2D, $28,            $CF, $52,            $B0, $6E,            $CD, $82
//               S     T     A        R     T    NULL    
//             10111_11000_00101_0, 10110_11000_00000_0
L79C1:  .byte     $BE, $0A,            $B6, $00

//----------------------------------------[ FIN DE PArtiE ]-----------------------------------------

//               F     I     N        _     D     E        _     P     A        R     T     I      
//             01010_01101_10010_0, 00001_01000_01001_0, 00001_10100_00101_0, 10110_11000_01101_0
L79C5:  .byte     $53, $64,            $0A, $12,            $0D, $0A,            $B6, $1A
//               E    NULL  NULL    
//             01001_00000_00000_0
L79CD:  .byte     $48, $00

//--------------------------------------[ 1 PIECE 2 JOUEURS ]---------------------------------------

//               1     _     P        I     E     C        E     _     2        _     J     O      
//             00011_00001_10100_0, 01101_01001_00111_0, 01001_00001_00100_0, 00001_01110_10011_0
L79CF:  .byte     $18, $68,            $6A, $4E,            $48, $48,            $0B, $A6
//               U     E     U        R     S    NULL    
//             11001_01001_11001_0, 10110_10111_00000_0
L79D7:  .byte     $CA, $72,            $B5, $C0

//---------------------------------------[ 1 PIECE 1 JOUEUR ]---------------------------------------

//               1     _     P        I     E     C        E     _     1        _     J     O      
//             00011_00001_10100_0, 01101_01001_00111_0, 01001_00001_00011_0, 00001_01110_10011_0
L79DB:  .byte     $18, $68,            $6A, $4E,            $48, $46,            $0B, $A6
//               U     E     U        R    NULL  NULL    
//             11001_01001_11001_0, 10110_00000_00000_0
L79E3:  .byte     $CA, $72,            $B0, $00

//--------------------------------------[ 2 PIECES 1 JOUEUR ]---------------------------------------

//               2     _     P        I     E     C        E     S     _        1     _     J      
//             00100_00001_10100_0, 01101_01001_00111_0, 01001_10111_00001_0, 00011_00001_01110_0
L79E7:  .byte     $20, $68,            $6A, $4E,            $4D, $C2,            $18, $5C
//               O     U     E        U     R    NULL    
//             10011_11001_01001_0, 11001_10110_00000_0
L79EF:  .byte     $9E, $52,            $CD, $80

//---------------------------------[ Spanish Message Vector Data ]----------------------------------

//Message offsets
SpanishTextTbl:
L79F3:  .byte $0B               //RECORDS
L79F4:  .byte $11               //JUGADOR
L79F5:  .byte $17               //SU PUNTAJE Esta ENTRE LOS DIEZ MEJORES
L79F6:  .byte $31               //POR FAVOR ENTRE SUS INICIALES
L79F7:  .byte $45               //OPRIMA ROTATE PARA SELECCIONAR LA LETRA
L79F8:  .byte $5F               //OPRIMA HYPERSPACE
L79F9:  .byte $6B               //PULSAR staRT
L79FA:  .byte $73               //JUEGO TERMINADO
L79FB:  .byte $7D               //1 FICHA 2 JUEGOS
L79FC:  .byte $89               //1 FICHA 1 JUEGO
L79FD:  .byte $93               //2 FICHAS 1 JUEGO

//-------------------------------------------[ RECORDS ]--------------------------------------------

//               R     E     C        O     R     D        S    NULL  NULL    
//             10110_01001_00111_0, 10011_10110_01000_0, 10111_00000_00000_0
L79FE:  .byte     $B2, $4E,            $9D, $90,            $B8, $00

//-------------------------------------------[ JUGADOR ]--------------------------------------------

//               J     U     G        A     D     O        R     _    NULL    
//             01110_11001_01011_0, 00101_01000_10011_0, 10110_00001_00000_0
L7A04:  .byte     $76, $56,            $2A, $26,            $B0, $40

//----------------------------[ SU PUNTAJE Esta ENTRE LOS DIEZ MEJORES ]----------------------------

//               S     U     _        P     U     N        T     A     J        E     _     E      
//             10111_11001_00001_0, 10100_11001_10010_0, 11000_00101_01110_0, 01001_00001_01001_0
L7A0A:  .byte     $BE, $42,            $A6, $64,            $C1, $5C,            $48, $52
//               S     T     A        _     E     N        T     R     E        _     L     O      
//             10111_11000_00101_0, 00001_01001_10010_0, 11000_10110_01001_0, 00001_10000_10011_0
L7A12:  .byte     $BE, $0A,            $0A, $64,            $C5, $92,            $0C, $26
//               S     _     D        I     E     Z        _     M     E        J     O     R      
//             10111_00001_01000_0, 01101_01001_11110_0, 00001_10001_01001_0, 01110_10011_10110_0
L7A1A:  .byte     $B8, $50,            $6A, $7C,            $0C, $52,            $74, $EC
//               E     S    NULL    
//             01001_10111_00000_0
L7A22:  .byte     $4D, $C0

//--------------------------------[ POR FAVOR ENTRE SUS INICIALES ]---------------------------------

//               P     O     R        _     F     A        V     O     R        _     E     N      
//             10100_10011_10110_0, 00001_01010_00101_0, 11010_10011_10110_0, 00001_01001_10010_0
L7A24:  .byte     $A4, $EC,            $0A, $8A,            $D4, $EC,            $0A, $64
//               T     R     E        _     S     U        S     _     I        N     I     C      
//             11000_10110_01001_0, 00001_10111_11001_0, 10111_00001_01101_0, 10010_01101_00111_0
L7A2C:  .byte     $C5, $92,            $0D, $F2,            $B8, $5A,            $93, $4E
//               I     A     L        E     S    NULL    
//             01101_00101_10000_0, 01001_10111_00000_0
L7A34:  .byte     $69, $60,            $4D, $C0

//---------------------------[ OPRIMA ROTATE PARA SELECCIONAR LA LETRA ]----------------------------

//               O     P     R        I     M     A        _     R     O        T     A     T      
//             10011_10100_10110_0, 01101_10001_00101_0, 00001_10110_10011_0, 11000_00101_11000_0
L7A38:  .byte     $9D, $2C,            $6C, $4A,            $0D, $A6,            $C1, $70
//               E     _     P        A     R     A        _     S     E        L     E     C      
//             01001_00001_10100_0, 00101_10110_00101_0, 00001_10111_01001_0, 10000_01001_00111_0
L7A40:  .byte     $48, $68,            $2D, $8A,            $0D, $D2,            $82, $4E
//               C     I     O        N     A     R        _     L     A        _     L     E      
//             00111_01101_10011_0, 10010_00101_10110_0, 00001_10000_00101_0, 00001_10000_01001_0
L7A48:  .byte     $3B, $66,            $91, $6C,            $0C, $0A,            $0C, $12
//               T     R     A      
//             11000_10110_00101_1
L7A50:  .byte     $C5, $8B

//--------------------------------------[ OPRIMA HYPERSPACE ]---------------------------------------

//               O     P     R        I     M     A        _     H     Y        P     E     R      
//             10011_10100_10110_0, 01101_10001_00101_0, 00001_01100_11101_0, 10100_01001_10110_0
L7A52:  .byte     $9D, $2C,            $6C, $4A,            $0B, $3A,            $A2, $6C
//               S     P     A        C     E    NULL    
//             10111_10100_00101_0, 00111_01001_00000_0
L7A5A:  .byte     $BD, $0A,            $3A, $40

//-----------------------------------------[ PULSAR staRT ]-----------------------------------------

//               P     U     L        S     A     R        _     S     T        A     R     T      
//             10100_11001_10000_0, 10111_00101_10110_0, 00001_10111_11000_0, 00101_10110_11000_1
L7A5E:  .byte     $A6, $60,            $B9, $6C,            $0D, $F0,            $2D, $B1

//---------------------------------------[ JUEGO TERMINADO ]----------------------------------------

//               J     U     E        G     O     _        T     E     R        M     I     N      
//             01110_11001_01001_0, 01011_10011_00001_0, 11000_01001_10110_0, 10001_01101_10010_0
L7A66:  .byte     $76, $52,            $5C, $C2,            $C2, $6C,            $8B, $64
//               A     D     O      
//             00101_01000_10011_1
L7A6E:  .byte     $2A, $27

//---------------------------------------[ 1 FICHA 2 JUEGOS ]---------------------------------------

//               1     _     F        I     C     H        A     _     2        _     J     U      
//             00011_00001_01010_0, 01101_00111_01100_0, 00101_00001_00100_0, 00001_01110_11001_0
L7A70:  .byte     $18, $54,            $69, $D8,            $28, $48,            $0B, $B2
//               E     G     O        S    NULL  NULL    
//             01001_01011_10011_0, 10111_00000_00000_0
L7A78:  .byte     $4A, $E6,            $B8, $00

//---------------------------------------[ 1 FICHA 1 JUEGO ]----------------------------------------

//               1     _     F        I     C     H        A     _     1        _     J     U      
//             00011_00001_01010_0, 01101_00111_01100_0, 00101_00001_00011_0, 00001_01110_11001_0
L7A7C:  .byte     $18, $54,            $69, $D8,            $28, $46,            $0B, $B2
//               E     G     O      
//             01001_01011_10011_1
L7A84:  .byte     $4A, $E7

//---------------------------------------[ 2 FICHAS 1 JUEGO ]---------------------------------------

//               2     _     F        I     C     H        A     S     _        1     _     J      
//             00100_00001_01010_0, 01101_00111_01100_0, 00101_10111_00001_0, 00011_00001_01110_0
L7A86:  .byte     $20, $54,            $69, $D8,            $2D, $C2,            $18, $5C
//               U     E     G        O    NULL  NULL    
//             11001_01001_01011_0, 10011_00000_00000_0
L7A8E:  .byte     $CA, $56,            $98, $00

//----------------------------------------[ Checksum Byte ]-----------------------------------------

L7A92:  .byte $52               //Checksum byte.

//--------------------------------[ Check Coin Insertion Routines ]---------------------------------

CheckCoinsInserted:
L7A93:  ldx #$02                //Prepare to check all 3 coin mechanisms.

CheckCoinsLoop:
L7A95:  lda LeftCoinSw,X        //Get Status of coin switch and store it in the carry bit.
L7A98:  asl                     //

L7A99:  lda CoinDropTimers,X    //Get coin drop timer value.
L7A9B:  and #$1F                //Was a coin insertion detected?
L7A9D:  bcc CheckDropTimerVal   //If not, branch to check coin drop timer.

L7A9F:  beq CheckSlamSw         //Has coin drop timer run until it hit 0? If so, branch.

L7AA1:  cmp #$1B                //Has timer just started with detected coin insertion?
L7AA3:  bcs decDropTimer        //If so, branch.

L7AA5:  tay                     //Wait 7 NMI periods(28ms). During this time, the coin-->
L7AA6:  lda NmiCounter          //switch should be active, the drop timer should be active-->
L7AA8:  and #$07                //and the slam switch should not be active. If these-->
L7AAA:  cmp #$07                //conditions are true, decrement the coin drop timer.
L7AAC:  tya                     //
L7AAD:  bcc CheckSlamSw         //Check slam switch during first 7 NMIs.

decDropTimer:
L7AAF:  sbc #$01                //Things check out so far, decrement coin drop timer.

CheckSlamSw:
L7AB1:  sta CoinDropTimers,X    //Update the coin drop timer.
L7AB3:  lda SlamSw              //Get the slam switch Status.
L7AB6:  and #$80                //Was a slam detected?
L7AB8:  beq CheckSlamTimer      //If not, branch to move on.

SlamDetected:
L7ABA:  lda #$F0                //Slam detected. Set slam timer.
L7ABC:  sta SlamTimer           //

CheckSlamTimer:
L7ABE:  lda SlamTimer           //Is the slam timer active?
L7AC0:  beq CheckWaitTimer      //If not, branch to move on.

SlamTimeout:
L7AC2:  dec SlamTimer           //
L7AC4:  lda #$00                //decrement the slam timer and hold the other timers-->
L7AC6:  sta CoinDropTimers,X    //in their zero state until the slam timer clears.
L7AC8:  sta WaitCoinTimers,X    //

CheckWaitTimer:
L7ACA:  clc                     //Is this wait timer finished?
L7ACB:  lda WaitCoinTimers,X    //
L7ACD:  beq CheckNextMech       //If so, branch to see if another mechanism needs to be checked.

L7ACF:  dec WaitCoinTimers,X    //Is this timer still active? decrement and branch if done.
L7AD1:  bne CheckNextMech       //

L7AD3:  sec                     //Branch always.
L7AD4:  bcs CheckNextMech       //

CheckDropTimerVal:
L7AD6:  cmp #$1B                //If timer is a high value, the coin switch cleared too-->
L7AD8:  bcs ResetDropTimer      //soon. False flag. Branch to reset the drop timer.

L7ADA:  lda CoinDropTimers,X    //Max value after add is #$3F.
L7adc:  adc #$20                //
L7ADE:  bcc CheckSlamSw         //Branch always.

L7AE0:  beq ResetDropTimer      //This code does not appear to be accessed.
L7AE2:  clc                     //

ResetDropTimer:
L7AE3:  lda #$1F                //Prepare to reset the coin drop timer.
L7AE5:  bcs CheckSlamSw         //If carry is set, something funny happened, check slam switch.

L7AE7:  sta CoinDropTimers,X    //Reset the coin drop timer.
L7AE9:  lda WaitCoinTimers,X    //is this the first transition of the wait timer?
L7AEB:  beq SetWaitTimer        //If so, branch to set timer and move to next coin mech.

L7AED:  sec                     //Timer transition already happened, prepare to do more processing.

SetWaitTimer:
L7AEE:  lda #$78                //Load the wait timer.
L7AF0:  sta WaitCoinTimers,X    //

CheckNextMech:
L7AF2:  bcc DoNextCoinMech      //Branch to check next coin mech if timer transition just happened.

L7AF4:  lda #$00                //Is this the left coin mech?
L7AF6:  cpx #$01                //
L7AF8:  bcc CalcMult            //If so, branch to increment coins. No multipliers this coin mech.

L7AFA:  beq CCoinMechMult       //Is this the center coin mech? If so, branch to calc multiplier.

RCoinMechMult:
L7AFC:  lda DipSwitchBits       //Only option left is the right coin mechanism.
L7AFE:  and #$0C                //
L7B00:  lsr                     //Get the Dip switch values and /4.
L7B01:  lsr                     //
L7B02:  beq CalcMult            //If no multiplier active, branch to increment coins.

L7B04:  adc #$02                //Multiplier active on the right coin mech. Get the shifted-->
L7B06:  bne CalcMult            //DIP switch value and add 2 for a range between 4-6. Branch always.

CCoinMechMult:
L7B08:  lda DipSwitchBits       //Check if there is a multiplier active on the center coin mech.
L7B0A:  and #$10                //
L7B0C:  beq CalcMult            //If not, branch to increment the coins.

L7B0E:  lda #$01                //Multiplier active.  Add an additional coin.

CalcMult:
L7B10:  sec                     //Add at least one coin.
L7B11:  adc CoinMult            //Add the any others from multipliers.
L7B13:  sta CoinMult            //Update the total coins.
L7B15:  inc ValidCoins,X        //Indicate a valid coin. Used for incrementing coin counter.

DoNextCoinMech:
L7B17:  dex                     //Are there coin mechanisms left to check:
L7B18:  bmi CalcCoinsPerplay    //If not, next step is to update coins.

L7B1A:  jmp CheckCoinsLoop      //($7A95)Check next coin mechanism.

CalcCoinsPerplay:
L7B1D:  lda DipSwitchBits       //Get the coins per play value. On = 0, Off = 1.
L7B1F:  and #$03                //
L7B21:  tay                     //Is free play active?
L7B22:  beq UpdateCoinMult      //If so, branch to add 0 coins.

L7B24:  lsr                     //
L7B25:  adc #$00                //Get the number of coins required to get a credit-->
L7B27:  adc #$FF                //and subtract the number of current coins. if more-->
L7B29:  sec                     //coins are needed, branch to finish for this frame.-->
L7B2A:  adc CoinMult            //Else add up to 2 credits this frame.
L7B2C:  bcc CreditUpdateDone    //

L7B2E:  cpy #$02                //Do 2 credits need to be added?
L7B30:  bcs Add1Credit          //If not, branch to add only 1.

Add2Credits:
L7B32:  inc NumCredits          //Add the first of 2 credits.

Add1Credit:
L7B34:  inc NumCredits          //increment the credits.

UpdateCoinMult:
L7B36:  sta CoinMult            //Store updated coin value.

CreditUpdateDone:
L7B38:  lda NmiCounter          //Is this an odd NMI period?
L7B3A:  lsr                     //
L7B3B:  bcs EndCoincheck        //If so, branch to end, if not, keep processing.

L7B3D:  ldy #$00                //Prepare to check all 3 valid coin indicators.
L7B3F:  ldx #$02                //

ValidCoinLoop1:
L7B41:  lda ValidCoins,X        //
L7B43:  beq NextValidCoin1      //
L7B45:  cmp #$10                //This function continues a valid coin timer.-->
L7B47:  bcc NextValidCoin1      //During this time, the coin counters are enabled.-->
L7B49:  adc #$EF                //the counter will last for 16 NMIs when a single-->
L7B4B:  iny                     //coin is inserted. The counter will last longer-->
L7B4C:  sta ValidCoins,X        //if more coins are added.
NextValidCoin1:                 //
L7B4E:  dex                     //
L7B4F:  bpl ValidCoinLoop1      //

L7B51:  tya                     //Is a valid coin counter active from above?
L7B52:  bne EndCoincheck        //

L7B54:  ldx #$02                //Prepare to check all 3 valid coin indicators.

ValidCoinLoop2:
L7B56:  lda ValidCoins,X        //
L7B58:  beq NextValidCoin2      //
L7B5A:  clc                     //
L7B5B:  adc #$EF                //This function will initiate a valid coin-->
L7B5D:  sta ValidCoins,X        //timer.  The coin counters will be enabled-->
L7B5F:  bmi EndCoincheck        //at this time.
NextValidCoin2:                 //
L7B61:  dex                     //
L7B62:  bpl ValidCoinLoop2      //

EndCoincheck:
L7B64:  rts                     //Done checking coin insertion.

//---------------------------------------------[ NMI ]----------------------------------------------

NMI:
L7B65:  pha                     //Push A, Y and X onto the stack.
L7B66:  tya                     //
L7B67:  pha                     //
L7B68:  txa                     //
L7B69:  pha                     //
L7B6A:  cld                     //Set processor to binary mode.

L7B6B:  lda stackBottom         //Has the stack overflowed or underflowed?
L7B6E:  ora stackTop            //If so, spin lock until watchdog reset.
L7B71:	bne L7B71                  //

L7B73:  inc NmiCounter          //Is it time to start a new frame(every 4th NMI)?
L7B75:  lda NmiCounter          //
L7B77:  and #$03                //
L7B79:  bne CheckCoins          //If not, branch to skip frame counter increment.

L7B7B:  inc FrameCounter        //start a new frame. 62.5 frames per second.
L7B7D:  lda FrameCounter        //Have more than 3 frames passed without being acknowledged?
L7B7F:  cmp #$04                //
L7B81:  bcs L7B81                   //If so, something is wrong. Spin lock until watchdog reset.

CheckCoins:
L7B83:  jsr CheckCoinsInserted  //($7A93)Check if player inserted any coins.

L7B86:  lda MultiPurpBits       //Get the multipurpose bits and discard the coin-->
L7B88:  and #$C7                //counter enable bits. They will be set next.

L7B8A:  bit LValidCoin          //Was a valid coin detected in the left coin mech?
L7B8C:  bpl CheckCValidCoin     //If not, branch to check the next coin mech.

L7B8E:  ora #CoinctrLeft        //Activate the left coin counter.

CheckCValidCoin:
L7B90:  bit CValidCoin          //Was a valid coin detected in the center coin mech?
L7B92:  bpl CheckRValidCoin     //If not, branch to check the next coin mech.

L7B94:  ora #CoinctrCntr        //Activate the center coin counter.

CheckRValidCoin:
L7B96:  bit RValidCoin          //Was a valid coin detected in the right coin mech?
L7B98:  bpl UpdateCoincounters  //If not, branch to update the active coin counters.

L7B9A:  ora #CoinctrRght        //Activate the right coin counter.

UpdateCoincounters:
L7B9C:  sta MultiPurpBits       //Update the current states of the coin counters.
L7B9E:  sta MultiPurp           //

L7BA1:  lda SlamTimer           //Is slam timer active?
L7BA3:  beq UpdateSlamSFX       //If not, branch.

L7BA5:  lda #$80                //Slam detected. start the slam SFX.
L7BA7:  bne EnDisSlamSFX        //

UpdateSlamSFX:
L7BA9:  lda ExLfSFXTimer        //Slam has not recently been active. Disable slam SFX.
L7BAB:  beq EnDisSlamSFX        //

L7BAD:  lda FrameTimerLo        //Is this an odd frame?
L7BAF:  ror                     //
L7BB0:  bcc FrameTimerroll3     //If not, branch to skip decrementing SFX timer.

L7BB2:  dec ExLfSFXTimer        //decrement SFX timer every other frame.

FrameTimerroll3:
L7BB4:  ror                     //
L7BB5:  ror                     //rolling the value creates a unique SFX.
L7BB6:  ror                     //

EnDisSlamSFX:
L7BB7:  sta LifeSFX             //Enables or disables slam SFX.

L7BBA:  pla                     //Pull A, Y and X from the stack.
L7BBB:  tax                     //
L7BBC:  pla                     //
L7BBD:  tay                     //
L7BBE:  pla                     //
L7BBF:  rti                     //Return from interrupt.

//-----------------------------------[ Vector Drawing Routines ]------------------------------------

VecHalt:
L7BC0:  lda #HaltOpcode         //Write HALT command to vector RAM.

VecRam2Write:
L7BC2:  ldy #$00                //Write 2 bytes to vector RAM.
L7BC4:  sta (VecRamPtr),Y       //
L7BC6:  iny                     //
L7BC7:  sta (VecRamPtr),Y       //
L7BC9:  bne VecPtrUpdate        //($7C39)Branch always. Update Vector RAM pointer.

PrepDrawDigit:
L7BCB:  bcc DrawDigit           //($7BD1)Draw a single digit on the display.
L7BCD:  and #$0F                //Is a blank space to be drawn?
L7BCF:  beq PrepDigitPointer    //If so, branch.

						DrawDigit:
						L7BD1:  and #$0F                //Save lower nibble and add 1 to it.
						L7BD3:  clc                     //
						L7BD4:  adc #$01                //Adding 1 skips the "space" character.

						PrepDigitPointer:
						L7BD6:  php                     //Save the processor Status on the stack.
						L7BD7:  asl                     //*2. The digit pointers are 2 bytes.
						L7BD8:  ldy #$00                //start at current vector RAM pointer position.
						L7BDA:  tax                     //

						L7BDB:  lda CharPtrTbl,X        //Load the jsr command that draws the appropriate digit.
						L7BDE:  sta (VecRamPtr),Y       //
						L7BE0:  lda CharPtrTbl+1,X      //
						L7BE3:  iny                     //
						L7BE4:  sta (VecRamPtr),Y       //
						L7BE6:  jsr VecPtrUpdate        //($7C39)Update Vector RAM pointer.

						L7BE9:  plp                     //Restore the processor Status from the stack.
						L7BEA:  rts                     //

UnusedFunc00:
L7BEB:  lsr                     //
L7BEC:  and #$0F                //Appears to be an unused function.
L7BEE:  ora #$E0                //

VecRamPtrUpdate:
L7BF0:  ldy #$01                //Load upper byte of jsr word into vector RAM.
L7BF2:  sta (VecRamPtr),Y       //
L7BF4:  dey                     //decrement index to load lower byte.
L7BF5:  txa                     //
L7BF6:  ror                     //Convert byte into proper address format.
L7BF7:  sta (VecRamPtr),Y       //Store lower byte.
L7BF9:  iny                     //increment index for proper jsr return address.
L7BFA:  bne VecPtrUpdate        //($7C39)Update Vector RAM pointer.

VecRomjsr:
L7BFC:  lsr                     //Shift right to preserve jsr upper address bit.
L7BFD:  and #$0F                //Keep upper address nibble.
L7BFF:  ora #jsrOpcode          //Add jsr opcode.
L7C01:  bne VecRamPtrUpdate     //Branch always. Update vector RAM with jsr.

MoveBeam:
L7C03:  ldy #$00                //
L7C05:  sty MovBeamXUB          //Zero out X and Y upper address bytes.
L7C07:  sty MovBeamYUB          //

L7C09:  asl                     //
L7C0A:  rol MovBeamXUB          //
L7C0C:  asl                     //Break X address byte into the proper opcode format.
L7C0D:  rol MovBeamXUB          //
L7C0F:  sta MovBeamXLB          //

L7C11:  txa                     //Move Y address byte into A

L7C12:  asl                     //
L7C13:  rol MovBeamYUB          //
L7C15:  asl                     //Break Y address byte into the proper opcode format.
L7C16:  rol MovBeamYUB          //
L7C18:  sta MovBeamYLB          //

L7C1A:  ldx #$04                //Prepare to load 4 bytes into vector RAM.

SetCURData:
L7C1C:  lda VecRamPtrLB,X       //Get lower byte of upper CUR word.
L7C1E:  ldy #$00                //
L7C20:  sta (VecRamPtr),Y       //Store it in vector RAM.

L7C22:  lda VecRamPtrUB,X       //Get upper byte of upper CUR word.
L7C24:  and #$0F                //
L7C26:  ora #CurOpcode          //Add CUR opcode to the CUR instruction.
L7C28:  iny                     //
L7C29:  sta (VecRamPtr),Y       //Store it in vector RAM.

L7C2B:  lda VecRamPtrLB-2,X     //Get lower byte of lower CUR word.
L7C2D:  iny                     //
L7C2E:  sta (VecRamPtr),Y       //Store it in vector RAM.

L7C30:  lda VecRamPtrUB-2,X     //Get upper byte of lower CUR word.
L7C32:  and #$0F                //
L7C34:  ora GlobalScale         //Add global scale data to the CUR instruction.
L7C36:  iny                     //
L7C37:  sta (VecRamPtr),Y       //Store it in vector RAM.

VecPtrUpdate:
L7C39:  tya                     //Y has the number of bytes to increment vector ROM pointer by.
L7C3A:  sec                     //
L7C3B:  adc VecRamPtrLB         //Update vector ROM pointer.
L7C3D:  sta VecRamPtrLB         //
L7C3F:  bcc L7C43                   //Does upper byte of pointer need to increment? if not, branch.
L7C41:  inc VecRamPtrUB         //increment upper pointer byte.
L7C43:  rts                     //

VecRamrts:
L7C44:  lda #rtsOpcode          //Prepare to write rts opcode to vector RAM.
L7C46:  jmp VecRam2Write        //($7BC2)Write the same byte twice to vector RAM.

//-------------------------------[ Calculate Ship Debris Position ]---------------------------------

					//The purpose of this function is to calculate the proper starting point for the selected piece of
					//ship debris.  It needs to take into account any out of bounds conditions if the ship is close to 
					//any of the 4 edges of the display.  It draws a VEC with zero brightness to the proper starting
					//position.

					CalcDebrisPos:
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

					L7CBB:  ldy #$00                //Write the Y position lower byte to vector RAM.
					L7CBD:  lda ThisDebrisYLB       //
					L7CBF:  sta (VecRamPtr),Y       //
					L7CC1:  lda GenByte08           //
					L7CC3:  and #$F4                //Get the scale and Y direction bits for the VEC opcode.
					L7CC5:  ora ThisDebrisYUB       //Combine the Y position upper byte.
					L7CC7:  iny                     //
					L7CC8:  sta (VecRamPtr),Y       //Write the byte to vector RAM.
					L7CCA:  lda ThisDebrisXLB       //
					L7CCC:  iny                     //
					L7CCD:  sta (VecRamPtr),Y       //Write the X position lower byte to vector RAM.
					L7CCF:  lda GenByte08           //
					L7CD1:  and #$02                //Get the X direction bit.
					L7CD3:  asl                     //
					L7CD4:  ora GenByte01           //Set brightness for this vector(should be 0).
					L7CD6:  ora ThisDebrisXUB       //Combine the X position upper byte.
					L7CD8:  iny                     //
					L7CD9:  sta (VecRamPtr),Y       //Write the byte to vector RAM.
					L7CDB:  jmp VecPtrUpdate        //($7C39)Update Vector RAM pointer.

//------------------------------------------[ Spot Kill ]-------------------------------------------

SpotKill:
L7CDE:  ldx #$00                //Prepare to draw a dot with brightness 0.

					DrawDot:
					L7CE0:  ldy #$01                //Store scale in vector RAM.
					L7CE2:  sta (VecRamPtr),Y       //
					L7CE4:  dey                     //
					L7CE5:  tya                     //
					L7CE6:  sta (VecRamPtr),Y       //Set X and Y delta values to 0.
					L7CE8:  iny                     //
					L7CE9:  iny                     //
					L7CEA:  sta (VecRamPtr),Y       //
					L7CEC:  iny                     //
					L7CED:  txa                     //Store dot brightness in vector RAM.
					L7CEE:  sta (VecRamPtr),Y       //
					L7CF0:  jmp VecPtrUpdate        //($7C39)Update Vector RAM pointer.

//--------------------------------------------[ Reset ]---------------------------------------------

IRQ:

VecWriteWord:
L7D45:  ldy #$00                //Write 2 bytes into vector RAM.
L7D47:  sta (VecRamPtr),Y       //
L7D49:  iny                     //
L7D4A:  txa                     //
L7D4B:  sta (VecRamPtr),Y       //
L7D4D:  jmp VecPtrUpdate        //($7C39)Update Vector RAM pointer.

//--------------------------------------[ Self Test Routines ]--------------------------------------

DoSelfTest:
L7D50:  sta VectorRam,X         //Loop and clear all 2K of vector RAM.
L7D53:  sta VectorRam+$100,X    //
L7D56:  sta VectorRam+$200,X    //
L7D59:  sta VectorRam+$300,X    //
L7D5C:  sta VectorRam+$400,X    //
L7D5F:  sta VectorRam+$500,X    //
L7D62:  sta VectorRam+$600,X    //
L7D65:  sta VectorRam+$700,X    //
L7D68:  inx                     //
L7D69:  bne DoSelfTest          //More RAM to clear? If so, branch.

L7D6B:  sta WdClear             //Clear the watchdog timer.
L7D6E:  ldx #Zero               //Prepare for RAM check test.

RamPage0TestLoop:
L7D70:  lda GenZPAdrs00,X       //RAM address to check should always start out as 0.
L7D72:  bne RamPage0Fail        //
L7D74:  lda #$11                //Four bit RAM. Load a single bit per RAM.

RamPage0ByteTest:
L7D76:  sta GenZPAdrs00,X       //Store the bit pattern in RAM.
L7D78:  tay                     //Read the value back out of RAM.
L7D79:  adc GenZPAdrs00,X       //Compare it with itself.
L7D7B:  bne RamPage0Fail        //Is the value the same? If not, branch to failure.

L7D7D:  tya                     //Rotate the bit pattern in the RAM.
L7D7E:  asl                     //
L7D7F:  bcc RamPage0ByteTest    //More bits to test at this address? If so, branch.

L7D81:  inx                     //Done testing that RAM address.
L7D82:  bne RamPage0TestLoop    //More addresses in Page 0 to test? If so, branch.

L7D84:  sta WdClear             //Clear the watchdog timer.

L7D87:  txa                     //Clear A by transferring the #$00 in X.
L7D88:  sta GenPtr00LB          //Clear address $00.
L7D8A:  rol                     //Get the set carry bit and put in A. A = #$01.

RamTestNextPage:
L7D8B:  sta GenPtr00UB          //Load the next bank upper address.
L7D8D:  ldy #Zero               //start at beginning of the bank.

RamPageNTestLoop:
L7D8F:  ldx #$11                //Four bit RAM. Load a single bit per RAM.
L7D91:  lda (GenPtr00),Y        //Byte read should be equal to 0 at first.
L7D93:  bne RamPageNFail        //If not 0, branch. Bad RAM found.

RamPageNByteTest:
L7D95:  txa                     //Store the bit pattern in RAM.
L7D96:  sta (GenPtr00),Y        //
L7D98:  adc (GenPtr00),Y        //Read the value back out and compare to the original.
L7D9A:  bne RamPageNFail        //Do the values match? If not, branch. Bad RAM.

L7D9C:  txa                     //Shift the bit pattern left by one.
L7D9D:  asl                     //
L7D9E:  tax                     //
L7D9F:  bcc RamPageNByteTest    //Done writing to this address? If not branch.

L7DA1:  iny                     //increment to next address.
L7DA2:  bne RamPageNTestLoop    //Done with this page? If not, branch to write another byte.

L7DA4:  sta WdClear             //Clear the watchdog timer.

L7DA7:  inc GenPtr00UB          //increment to the next page.
L7DA9:  ldx GenPtr00UB          //
L7DAB:  cpx #MpuRamPages        //Have the 4 MPU RAM pages been checked?
L7DAD:  bcc RamPageNTestLoop    //If not, branch to check next page.

L7DAF:  lda #VectorRamUB        //MPU RAM check complete. Move on to vector RAM.
L7DB1:  cpx #VectorRamUB        //More vector RAM to check?
L7DB3:  bcc RamTestNextPage     //If so, branch to check more.

L7DB5:  cpx #VectorRamEndUB     //Have all the vector RAM pages been checked?
L7DB7:  bcc RamPageNTestLoop    //If not, branch to check the next one.
L7DB9:  bcs RomTest             //RAM test passed. Move to the ROM/PROM test.

RamPage0Fail:
L7DBB:  ldy #$00                //Zero page RAM failed, Y = #$00.
L7DBD:  beq MakeRamList         //Branch always.

RamPageNFail:
L7DBF:  ldy #$00                //MPU RAM failed, Y = #$00.
L7DC1:  ldx BadRamPage          //Get RAM page that failed.
L7DC3:  cpx #MpuRamPages        //Was it MPU RAM that failed?.
L7DC5:  bcc MakeRamList         //If so, branch.

L7DC7:  iny                     //Lower vector RAM failed, Y = #$01
L7DC8:  cpx #VectorRamUB+4      //Was it lower vector RAM half that failed?.
L7DCA:  bcc MakeRamList         //If so, branch.

L7DCC:  iny                     //Upper vector RAM failed, Y = #$02.

MakeRamList:
L7DCD:  cmp #$10                //Detected difference stored in A. If difference was in upper-->
L7DCF:  rol                     //nibble, upper RAM is bad and bit is rolled into LSB A.
L7DD0:  and #$1F                //Check for lower nibble difference.
L7DD2:  cmp #$02                //If one exists, a bit will be rolled into LSB A.
L7DD4:  rol                     //
L7DD5:  and #$03                //Keep only two lower bits as they are the failure bits.

ShiftRamPairs:
L7DD7:  dey                     //decrement Y to move to next RAM pairs.
L7DD8:  bmi BadRamToneLoop      //Finished shifting? If so, play RAM tones.

L7DDA:  asl                     //Need to move the bad RAM pairs up in memory-->
L7DDB:  asl                     //to make room for the next RAM pairs.
L7DDC:  bcc ShiftRamPairs       //More Ram pairs to shift? If so, branch.

BadRamToneLoop:
L7DDE:  lsr                     //Move RAM good/bad bit to carry.
L7DDF:  ldx #GoodRamFreq        //Assume RAM is good and prepare to play good RAM tone.
L7DE1:  bcc LoadRamThump        //Is good/bad bit cleared? If so, branch. RAM is good.

L7DE3:  ldx #BadRamFreq         //This is bad RAM. Load bad RAM thump frequency.

LoadRamThump:
L7DE5:  stx ThumpFreqVol        //play RAM tone.
L7DE8:  ldx #$00                //
L7DEA:  ldy #$08                //play tone for 256*8 3KHz periods (.68 seconds).

BadRamplayTone:
L7dec:	bit Clk3Khz             //
L7DEF:  bpl L7DEC                   //Wait for 1 3KHz period (333us).
L7DF1:  bit Clk3Khz             //
L7DF4:  bmi L7DF4                   //

L7DF6:  dex                     //One more 3KHz period has passed.
L7DF7:  sta WdClear             //Clear the watchdog timer.
L7DFA:  bne BadRamplayTone      //Has 256 3KHz periods elapsed? If not, branch to wait more.

L7DFC:  dey                     //Another 256 3KHz periods have passed.
L7DFD:  bne BadRamplayTone      //More time left to play RAM tone? If so, branch.

L7DFF:  stx ThumpFreqVol        //Turn off thump SFX.
L7E02:  ldy #$08                //Prepare to wait another .68 seconds.

BadRamWaitTone:
L7E04:  bit Clk3Khz             //
L7E07:  bpl L7E04                   //Wait for 1 3KHz period (333us).
L7E09:  bit Clk3Khz             //
L7E0C:  bmi L7E09                   //

L7E0E:  dex                     //One more 3KHz period has passed.
L7E0F:  sta WdClear             //Clear the watchdog timer.
L7E12:  bne BadRamWaitTone      //Has 256 3KHz periods elapsed? If not, branch to wait more.

L7E14:  dey                     //Another 256 3KHz periods have passed.
L7E15:  bne BadRamWaitTone      //More time left to play RAM tone? If so, branch.

L7E17:  tax                     //Are there still more RAMs to play tones for?
L7E18:  bne BadRamToneLoop      //If so, branch to do the next RAM chip.

BadRamCheckTest:
L7E1A:  sta WdClear             //Clear the watchdog timer.
L7E1D:  lda SelfTestSw          //Is self test still enabled?
L7E20:  bmi BadRamCheckTest     //If so, loop until it is disabled.

BadRamSpinLock:
L7E22:  bpl BadRamSpinLock      //Self test released. Spin lock until watchdog reset.

RomTest:
L7E24:  lda #VectorRomLB        //
L7E26:  tay                     //
L7E27:  tax                     //Point to the start of the vector ROM.
L7E28:  sta VecRomPtrLB         //
L7E2A:  lda #VectorRomUB        //

RomTestKBLoop:
L7E2C:  sta VecRomPtrUB         //Prepare to test 1Kb of ROM (#$0400 bytes).
L7E2E:  lda #$04                //
L7E30:  sta GenByte0B           //
L7E32:  lda #$FF                //Prepare to invert all the bits.

RomTestBankLoop:
L7E34:  adc (VecRomPtr),Y       //Keep a running checksum on ROM contents.
L7E36:  iny                     //Move to the next address.
L7E37:  bne RomTestBankLoop     //Is this page done? If not, branch to get another byte.

L7E39:  inc VecRomPtrUB         //Move to next ROM page.
L7E3B:  dec GenByte0B           //Is 1 KB of ROM done?
L7E3D:  bne RomTestBankLoop     //If not, branch to start next page.

L7E3F:  sta RomChecksum,X       //Store checksum for this 1Kb of ROM.              
L7E41:  inx                     //Move to next checksum storage byte.

L7E42:  sta WdClear             //Clear the watchdog timer.

L7E45:  lda VecRomPtrUB         //Are we at the end of the vector ROM?
L7E47:  cmp #VectorRomEndUB     //If not, branch to get checksum of another Kb.
L7E49:  bcc RomTestKBLoop       //

L7E4B:  bne RomChecksumDone     //Are checking the program ROM? If so, branch.

L7E4D:  lda #ProgramRomUB       //start checking the program ROM.

RomChecksumDone:
L7E4F:  cmp #ProgramRomEndUB    //Are we done checking the program ROM?
L7E51:  bcc RomTestKBLoop       //If not, branch to do another Kb.

BankSwitchTest:
L7E53:  sta Player2Ram          //Store ProgramRomEndUB(#$80) into RAM location $0300.

L7E56:  ldx #RamSwap            //Swap RAM locations $0200-$02FF with $0300-$03FF.
L7E58:  stx MultiPurp           //

L7E5B:  stx DiagStepstate       //Initialize DiagStepstate with #$04. Draws initial-->
L7E5D:  ldx #$00                //line on screen if DiagStep is active.

CheckPlr1Ram:
L7E5F:  cmp Player1Ram          //The value of A stored in Player2Ram should now be here.
L7E62:  beq CheckPlr2Ram        //Did the RAM swap successfully? If so, branch.

L7E64:  inx                     //There was a RAM swap problem. increment X.

CheckPlr2Ram:
L7E65:  lda Player2Ram          //The final bit pattern written in the RAM test routine-->
L7E68:  cmp #$88                //Should be here.
L7E6A:  beq CheckSwapDone

L7E6C:  inx                     //There was a RAM swap problem. increment X.

CheckSwapDone:
L7E6D:  stx RamSwapResults      //Store the results of the RAM swap test.

L7E6F:  lda #$10                //Written but not read.
L7E71:  sta GenByte00           //

SelfTestMainLoop:
L7E73:  ldx #SelfTestWait       //Wait for 36 3KHz periods(12 ms).

SelfTestWaitLoop:
L7E75:  lda Clk3Khz             //
L7E78:  bpl L7E78                   //Wait for 1 3KHz period (333us).
L7E7A:  lda Clk3Khz             //
L7E7D:  bmi L7E7A                   //

L7E7F:  dex                     //Has 12 ms elapsed?
L7E80:  bpl SelfTestWaitLoop    //If not, branch to wait some more.

VectorWaitLoop2:
L7E82:  bit Halt                //Is the vector state machine busy?
L7E85:  bmi VectorWaitLoop2     //If so, loop until it is idle.

L7E87:  sta WdClear             //Clear the watchdog timer.

L7E8A:  lda #VectorRamLB        //
L7E8C:  sta VecRamPtrLB         //Set vector RAM pointer to start of RAM.
L7E8E:  lda #VectorRamUB        //
L7E90:  sta VecRamPtrUB         //

L7E92:  lda DiagStep            //Is diagnostic step active?
L7E95:  bpl ShowDipStatus       //If not, branch to next test.

L7E97:  ldx DiagStepstate       //Get current diagnostic step state.

L7E99:  lda HyprSpcSw           //Has the hyperspace button been pressed?
L7E9C:  bpl LoadDiagVects       //If so, update diagnostic step.

UpdateDiagStep:
//7E9E:  adc TestSFXInit_        //***incorrect assembly as zero page opcode***
L7E9E:  .byte $4D, $09, $00     //Was hyperspace button just pressed?
L7EA1:  bpl LoadDiagVects       //If not, branch to display current DiagStep lines.

L7EA3:  dex                     //Hyperspace was pressed. Can anymore DiagStep lines be added?
L7EA4:  beq LoadDiagVects       //If not, branch to draw existing DiagStep lines.

L7EA6:  stx DiagStepstate       //Add another DiagStep line to the display.

LoadDiagVects:
L7EA8:  ldy DiagStepIdxTbL-1,X  //Get the current address into the vector RAM.
L7EAB:  lda #$B0                //Add a HALT to the last addresses($B000).
L7EAD:  sta (VecRamPtr),Y       //

L7EAF:  dey                     //Move down to the next word in the vector RAM.
L7EB0:  dey                     //

DiagStepWriteLoop:
L7EB1:  lda DiagStepDatTbl,Y    //Get next byte from the table below and write to vector RAM.
L7EB4:  sta (VecRamPtr),Y       //

L7EB6:  dey                     //Any more bytes to write to vector RAM?
L7EB7:  bpl DiagStepWriteLoop   //If so, branch to get another byte.

L7EB9:  jmp GetTestButtons      //($7F9D)Jump to get user inputs.

//The values in the table are indexes to the data tables below.
//The actual index is the value in the table - 2. Must account
//for $B000 written to the end of each segment. The $B000 is
//overwritten by the next segment allowing drawing continuation.
DiagStepIdxTbL:
L7EBC: .byte $33, $1D, $17, $0D

DiagStepDatTbl:
//Draws the first line. Written to vector RAM at $4000.
L7EC0:  .word $A080, $0000      //CUR  scale=0(/512) x=0     y=128  
L7EC4:  .word $7000, $0000      //VEC  scale=7(/4)   x=0     y=0     b=0
L7EC8:  .word $92FF, $73FF      //VEC  scale=9(/1)   x=1023  y=767   b=7

//Draws the first line. Written to vector RAM at $400C.
L7ECC:  .word $A1D0, $0230      //CUR  scale=0(/512) x=560   y=464  
L7ED0:  .word $7000, $0000      //VEC  scale=7(/4)   x=0     y=0     b=0
L7ED4:  .word $FB7F             //SVEC scale=3(/16)  x=-3    y=3     b=7

//Draws the third line. Written to vector RAM at $4016.
L7ED6:  .word $E00D             //jmp  $401A
L7ED8:  .word $B000             //HALT 
L7EDA:  .word $FA7E             //SVEC scale=3(/16)  x=-2    y=2     b=7

//Draws the last triangle. Written to vector RAM at $401C.
L7EDC:  .word $C011             //jsr  $4022
L7EDE:  .word $FE78             //SVEC scale=3(/16)  x=0     y=-2    b=7
L7EE0:  .word $B000             //HALT 
L7EE2:  .word $C013             //jsr  $4026
L7EE4:  .word $D000             //rts 
L7EE6:  .word $C015             //jsr  $402A
L7EE8:  .word $D000             //rts 
L7EEA:  .word $C017             //jsr  $402E
L7EEC:  .word $D000             //rts 
L7EEE:  .word $F87A             //SVEC scale=3(/16)  x=2     y=0     b=7
L7EF0:  .word $D000             //rts

ShowDipStatus:
L7EF2:  lda #VectorRomUB        //Prepare to load cross-hatch pattern on the screen.
L7EF4:  ldx #VectorRomLB        //
L7EF6:  jsr VecRomjsr           //($7BFC)Load jsr command in vector RAM to vector ROM.

L7EF9:  lda #$69                //X beam coordinate 4 * $69 = $1A4 = 420.
L7EFB:  ldx #$93                //Y beam coordinate 4 * $93 = $24C = 588.
L7EFD:  jsr MoveBeam            //($7C03)Move the CRT beam to a new location.

L7F00:  lda #$30                //Set scale 3(/64).
L7F02:  jsr SpotKill            //($7CDE)Draw zero vector to prevent spots on the screen.

L7F05:  ldx #$03                //Prepare to read the 4 pairs of DIP switches.

DrawDipStatusLoop:
L7F07:  lda DipSw,X             //Get selected DIP switch pair Status.
L7F0A:  and #$01                //Keep only lower DIP switch Status.
L7F0C:  stx GenByte0B           //Save a copy of the DIP pair currently being checked.
L7F0E:  jsr DrawDigit           //($7BD1)Draw a single digit on the display.

L7F11:  ldx $0B                 //Restore a copy of the DIP pair currently being checked.
L7F13:  lda DipSw,X             //Reload the selected DIP switch pair Status.
L7F16:  and #$02                //Keep only upper DIP switch Status.
L7F18:  lsr                     //Move it to the LSB.
L7F19:  jsr DrawDigit           //($7BD1)Draw a single digit on the display.

L7F1C:  ldx GenByte0B           //Reload the selected DIP switch pair Status.
L7F1E:  dex                     //Does another DIP switch pair need to be checked?
L7F1F:  bpl DrawDipStatusLoop   //If so, branch to get the next pair.

L7F21:  lda #$7A                //X beam coordinate 4 * $7A = $1E8 = 488.
L7F23:  ldx #$9D                //Y beam coordinate 4 * $9D = $274 = 628.
L7F25:  jsr MoveBeam            //($7C03)Move the CRT beam to a new location.

L7F28:  lda #$10                //Set scale 1(/256).
L7F2A:  jsr SpotKill            //($7CDE)Draw zero vector to prevent spots on the screen.

L7F2D:  lda CentCMShipsSw       //Get the center coin mechanism switch Status and display it.
L7F30:  and #$02                //
L7F32:  lsr                     //
L7F33:  adc #$01                //
L7F35:  jsr DrawDigit           //($7BD1)Draw a single digit on the display.

L7F38:  lda RghtCoinMechSw      //Get the right coin mechanism switches Status.
L7F3B:  and #$03                //
L7F3D:  tax                     //Use the switches Status to display the coin multiplier value.
L7F3E:  lda CoinMultTbl,X       //
L7F41:  jsr DrawDigit           //($7BD1)Draw a single digit on the display.

L7F44:  lda RamSwapResults      //Was there a RAM swap error?
L7F46:  beq VerifyChecksum      //If not, branch to move to the next test.

L7F48:  ldx #<VecBankErr        //Prepare to write bank error message to the display.
L7F4A:  lda #>VecBankErr
L7F4C:  jsr VecRomjsr           //($7BFC)Load jsr command in vector RAM to vector ROM.

VerifyChecksum:
L7F4F:  ldx #$96                //Y beam coordinate 4 * $96 = $258 = 600.
//7F51:  stx GenByte0C_          //***incorrect assembly as zero page opcode***
L7F51:  .byte $8E, $0C, $00     //Store base value for Y beam coordinate.

L7F54:  ldx #$07                //Prepare to check all 8 checksum values.

ChecksumLoop:
L7F56:  lda RomChecksum,X       //Is this checksum correct?
L7F58:  beq NextChecksum        //If so, branch to get next checksum.

L7F5A:  pha                     //incorrect checksum. Save checksum value on stack.
//7F5B:  stx GenByte0B_          //***incorrect assembly as zero page opcode***
L7F5B:  .byte $8E, $0B, $00     //Save current checksum index.

//7F5E:  ldx GenByte0C_          //***incorrect assembly as zero page opcode***
L7F5E:  .byte $AE, $0C, $00     //Prepare to move the Y beam position to display failure info.

L7F61:  txa                     //Move the Y bean position down by 32.
L7F62:  sec                     //
L7F63:  sbc #$08                //
//7F65:  sta GenByte0C_          //***incorrect assembly as zero page opcode***
L7F65:  .byte $8D, $0C, $00     //Save new beam position.

L7F68:  lda #$20                //X beam coordinate 4 * $20 = $80 = 128.
L7F6A:  jsr MoveBeam            //($7C03)Move the CRT beam to a new location.

L7F6D:  lda #$70                //Set scale 7(/4).
L7F6F:  jsr SpotKill            //($7CDE)Draw zero vector to prevent spots on the screen.

//7F72:  lda GenByte0B_          //***incorrect assembly as zero page opcode***
L7F72:  .byte $AD, $0B, $00     //Write failing checksum index to the display.
L7F75:  jsr DrawDigit           //($7BD1)Draw a single digit on the display.

L7F78:  lda CharPtrTbl          //Point to first entry in character pointer table (space).
L7F7B:  ldx CharPtrTbl+1        //Prepare to write a space to the display.
L7F7E:  jsr VecWriteWord        //($7D45)Write 2 bytes to vector RAM.

L7F81:  pla                     //Get the incorrect checksum value again.
L7F82:  pha                     //Store it right back on the stack.

L7F83:  lsr                     //
L7F84:  lsr                     //Prepare to write the upper nibble to the display.
L7F85:  lsr                     //
L7F86:  lsr                     //

L7F87:  jsr DrawDigit           //($7BD1)Draw a single digit on the display.

L7F8A:  pla                     //Prepare to write the lower nibble to the display.
L7F8B:  jsr DrawDigit           //($7BD1)Draw a single digit on the display.

//7F8E:  ldx GenByte0B_          //***incorrect assembly as zero page opcode***
L7F8E:  .byte $AE, $0B, $00     //Get the next checksum index to check.

NextChecksum:
L7F91:  dex                     //Is there another checksum to check?
L7F92:  bpl ChecksumLoop        //If so, branch.

L7F94:  lda #$7F                //X beam coordinate 4 * $7F = $1FC = 508.
L7F96:  tax                     //Y beam coordinate 4 * $7F = $1FC = 508.
L7F97:  jsr MoveBeam            //($7C03)Move the CRT beam to a new location.
L7F9A:  jsr VecHalt             //($7BC0)Halt the vector state machine.

GetTestButtons:
L7F9D:  lda #$00                //Prepare to get the Statuses of 5 switches.
L7F9F:  ldx #$04                //

GetBtnsLoop1:
L7FA1:  rol HyprSpcSw,X         //Get the Status of: self test, slam, diagnostic step,-->
L7FA4:  ror                     // fire and hyperspace switches.
L7FA5:  dex                     //More switches to get the Status of?
L7FA6:  bpl GetBtnsLoop1        //If so, branch.

L7FA8:  tay                     //Prepare to get the Statuses of 8 switches.
L7FA9:  ldx #$07                //

GetBtnsLoop2:
L7FAB:  rol LeftCoinSw,X        //Get the Status of: rotate left, rotate right, thrust,-->
L7FAE:  rol                     //2 player start, 1 player start, right coin, center coin-->
L7FAF:  dex                     // left coin switches.
L7FB0:  bpl GetBtnsLoop2        //More switches to get the Status of? If so, branch.

L7FB2:  tax                     //
L7FB3:  adc GenByte08           //Store bits indicating button changes.
L7FB5:  stx GenByte08           //

L7FB7:  php                     //Save processor Status.

L7FB8:  lda #RamSwap            //Swap RAM pages.
L7FBA:  sta MultiPurp           //

L7FBD:  rol HyprSpcSw           //
L7FC0:  rol                     //
L7FC1:  rol FireSw              //
L7FC4:  rol                     //
L7FC5:  rol RotLeftSw           //Save the Statuses of the player inputs into X.
L7FC8:  rol                     //
L7FC9:  rol RotRghtSw           //
L7FCC:  rol                     //
L7FCD:  rol ThrustSw            //
L7FD0:  rol                     //
L7FD1:  tax                     //

L7FD2:  plp                     //Restore processor Status.
L7FD3:  bne ButtonChanged       //Were buttons changed? if so, branch.

L7FD5:  adc GenByte0A           //Was a button change detected?
L7FD7:  bne ButtonChanged       //If so, branch to make a sound.

L7FD9:  tya                     //Was a button changed detected?
L7FDA:  adc TestSFXInit         //
L7FDC:  beq DoHardwareWrite     //If not, branch to turn off the SFX.

ButtonChanged:
L7FDE:  lda #Enablebit          //Button change detected, set the MSB,

DoHardwareWrite:
L7FE0:  sta LifeSFX             //play/halt SFX.
L7FE3:  sta MultiPurp           //No effect.
L7FE6:  sta DmaGo               //start/stop the vector state machine.

L7FE9:  stx GenByte0A           //Store current button Statuses.
L7FEB:  sty TestSFXInit         //
L7FED:  lda SelfTestSw          //Is self test switch still on? If so, loop.

SelfTestSpinLock1:
L7FF0:  bpl SelfTestSpinLock1   //self test released. Spin lock until watchdog reset.

L7FF2:  jmp SelfTestMainLoop    //($7E73)stay in self test loop.

//The table below sets the right coin mechanism multiplier
//based on the settings of DIP switches 5 and 6.
CoinMultTbl:
L7FF5:  .byte $01, $04, $05, $06

//----------------------------------------[ Checksum Byte ]-----------------------------------------

L7FF9:  .byte $4E               //Checksum byte.

//--------------------------------------[ Interrupt Vectors ]---------------------------------------

L7FFA:  .word NMI               //($7B65)NMI vector.
L7FFC:  .word RESET             //($7CF3)Reset vector.
L7FFE:  .word IRQ               //($7CF3)IRQ vector.