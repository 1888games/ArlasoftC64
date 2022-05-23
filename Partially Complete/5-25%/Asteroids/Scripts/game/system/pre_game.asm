	ChkPreGameStuff: {

					//lda #1
					//sta NumPlayers
					//sta PlyrDispTimer

			L6885:  lda NumPlayers          //Are there players currently playing?
			L6887:  beq ChkCoinsPerCredit   //If not, branch.

			L6889:  lda PlyrDispTimer       //Is the player 1/player 2 message being displayed?
			L688B:  bne DecPlyrtimer        //If so, branch to decrement timer.
			L688D:  jmp ChkThmpFaster       //($6960)Jump to check if the Thump SFX should be sped up.

		DecPlyrtimer:
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
			L689D:  lda #0      		 //Get the number of coins per credit.
			//L689F:  and #$03                //Is free play active?
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
			L68BD:  bcs Chk2players        //If not, branch to skip 2 players check.

			jmp ChkstartText

		Chk2players:
			L68BF:  lda Player2Sw           //Is the player 2 button being pressed?
			L68C2:  bmi Do2        //If not, branch.

					jmp ChkstartText 
		Do2:

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

			//L69D5:  jsr SilenceSFX          //($6EFA)Turn off all SFX.
			L69D8:  lda MultiPurpBits       //
			L69DA:  and #$F8                //Turn on both player button LEDs.
			L69DC:  ora #PlyrLamps          //
			L69DE:  sta MultiPurpBits       //

		NoResetReturn4:
			L69E0:  clc                     //Return without reinitializing the game.
			L69E1:  rts                     //

		DrawPlyrNum:

					lda #2
					tay

					ldx #12

					lda #10
					jsr UTILITY.DeleteText	

			L69E2:  ldy #PlyrText           //Prepare to write "plaYER" on the display.
			L69E4:  jsr WriteText           //($77F6)Write text to the display.

					inc TextColumn

			L69E7:  ldy CurrentPlyr         //Get the current player number.
			L69E9:  iny                     //Set it to the proper index for drawing.
			L69EA:  tya                     //
			L69EB:  jsr DrawDigit           //($7BD1)Draw a single digit on the display.
			L69EE:  rts                     //


		}