
	* = * "Startup"

	RESET: {

		L7CF3:  ldx #$FE                //Set stack pointer to #$FE
		L7CF5:  txs                     //

		L7CF6:  cld                     //Set processor to binary mode.

		L7CF7:  lda #2               //Prepare to clear the RAM.
		L7CF9:  tax                     //

		RamClearLoop:
		L7CFA:  dex                     //Loop until all RAM is zeroed.
		L7CFB:  sta Player2Ram,X        //
		L7CFE:  sta Player1Ram,X        //
		//L7D01:  sta OnePageRam,X        //
		L7D04:  sta ZeroPageRam + 2,X       //
		L7D06:  bne RamClearLoop        //More bytes to clear? If so, loop to write more.

		//L7D08:  ldy SelfTestSw          //Is the self test switch set for test mode?
		//L7D0B:  bmi DoSelfTest          //If so, branch to do self test routine.

		sta Player1Ram
		sta Player1Ram + 1
		sta Player2Ram
		sta Player2Ram + 1

		//L7D0D:  inx                     //Write JUMP to RAM address $4402 opcode to vector RAM.-->
		//L7D0E:  stx VectorRam           //The vector RAM is divided in half and one half is written to-->
		//L7D11:  lda #JumpOpcode+2       //while the other half is read. The read/write halves are-->
		//L7D13:  sta VectorRam+1         //swapped every frame.
		L7D16:  lda #HaltOpcode         //
	//	L7D18:  sta VectorRam+3         //Write HALT opcode to vector RAM address $4002

		L7D1B:  sta Plyr1Rank           //Write some initial data to player's rank.
		L7D1D:  sta Plyr2Rank           //

		L7D1F:  lda #PlyrLamps          //
		L7D21:  sta MultiPurpBits       //Turn on the player 1 and 2 LEDs.
		L7D23:  sta MultiPurp           //

		L7D26:  and PlayTypeSw          //Get how many coins to play a game
		L7D29:  sta DipSwitchBits       //

		L7D2B:  lda RghtCoinMechSw      //
		L7D2E:  and #$03                //
		L7D30:  asl                     //Get the coin multiplier for the Right coin mech.
		L7D31:  asl                     //
		L7D32:  ora DipSwitchBits       //
		L7D34:  sta DipSwitchBits       //

		L7D36:  lda CentCMShipsSw       //
		L7D39:  and #$02                //
		L7D3B:  asl                     //
		L7D3C:  asl                     //Get the coin multiplier for the center coin mech.
		L7D3D:  asl                     //
		L7D3E:  ora DipSwitchBits       //
		L7D40:  sta DipSwitchBits       //


		L7D42:  jmp MAIN.InitGame            //($6803)Initialize the game after reset.

	}




	SilenceSFX: {

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


	}