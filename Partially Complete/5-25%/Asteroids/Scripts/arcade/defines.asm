//Most of the information in this file was already mapped out.
//I found a great deal of this information on:
//http://computerarcheology.com/Arcade/Asteroids/RAMUse.html
//Mad props to Lonnie Howell and Mark McDougall
//This code is fully assemblable using Ophis.
//Last updated 7/28/2018 by Nick Mikstas.

//--------------------------------------[ Memory Boundaries ]---------------------------------------

.label ZeroPageRam      =$00     //Through =$00FF.
.label OnePageRam       =$0100   //Through =$01FF. The stack resides here.
.label Player1Ram       =$8000   //Through =$02FF. A total of 1K MCU RAM.
.label Player2Ram       =$8100   //Through =$03FF.
.label VectorRam        =$4000   //Through =$47FF. A total of 2K of vector RAM.
.label VectorRom        =$5000   //Through =$57FF. A total of 2k of vector ROM.

.label VectorRamLB      =$00     //Lower byte of start of vector RAM.
.label VectorRamUB      =$40     //Upper byte of start of vector RAM.
.label VectorRamEndLB   =$00     //Lower byte of end of vector RAM.
.label VectorRamEndUB   =$48     //Upper byte of end of vector RAM.

.label VectorRomLB      =$00     //Lower byte of start of vector ROM.
.label VectorRomUB      =$50     //Upper byte of start of vector ROM.
.label VectorRomEndLB   =$00     //Lower byte of end of vector ROM.
.label VectorRomEndUB   =$58     //Upper byte of end of vector ROM.

.label ProgramRomLB     =$00     //Lower byte of start of program ROM.
.label ProgramRomUB     =$68     //Upper byte of start of program ROM.
.label ProgramRomEndLB  =$00     //Lower byte of end of program ROM.
.label ProgramRomEndUB  =$80     //Upper byte of end of program ROM.

//----------------------------------------------[ RAM ]---------------------------------------------

.label GenZPAdrs00      =$95     //General zero page address.
.label GenZPAdrs01      =$96     //General zero page address.

.label GenByte00        =$95     //General use byte.
.label GenByte01        =$96     //General use byte.

.label GenPtr00         =$95     //General use pointer.
.label GenPtr00LB       =$96     //General use pointer, lower byte.
.label GenPtr00UB       =$96     //General use pointer, upper byte.

.label GenWrd00         =$95     //General use word.
.label GenWrd00LB       =$95     //General use word, lower byte.
.label GenWrd00UB       =$96     //General use word, upper byte.

.label GlobalScale      =$95     //Stores global scale info when building CUR instruction.
.label BadRamPage       =$96     //Contains memory page that failed the RAM test.

.label VecRamPtr        =$02     //Pointer to current vector RAM location.
.label VecRamPtrLB      =$02     //Pointer to current vector RAM location, lower byte.
.label VecRamPtrUB      =$03     //Pointer to current vector RAM location, upper byte.

.label ThisDebrisXLB    =$04     //Current debris piece to draw, X position, lower byte.
.label ThisDebrisXUB    =$05     //Current debris piece to draw, X position, upper byte.
.label ThisDebrisYLB    =$06     //Current debris piece to draw, Y position, lower byte.
.label ThisDebrisYUB    =$07     //Current debris piece to draw, Y position, upper byte.

.label ThisObjXLB       =$04     //Current object to draw, X position, lower byte.
.label ThisObjXUB       =$05     //Current object to draw, X position, upper byte.
.label ThisObjYLB       =$06     //Current object to draw, Y position, lower byte.
.label ThisObjYUB       =$07     //Current object to draw, Y position, upper byte.

.label MovBeamXLB       =$04     //Stores X position, lower byte when building CUR instruction.
.label MovBeamXUB       =$05     //Stores X position, upper byte when building CUR instruction.
.label MovBeamYLB       =$06     //Stores Y position, lower byte when building CUR instruction.
.label MovBeamYUB       =$07     //Stores Y position, upper byte when building CUR instruction.

.label GenByte08        =$08     //General use byte.

.label ObjXDiff         =$08     //Difference in two object's X coordinates.
.label ObjYDiff         =$09     //Difference in two object's Y coordinates.

.label ShipDrawXInv     =$08     //Used to invert X direction of ship while rendering.
.label ShipDrawYInv     =$09     //Used to invert Y direction of ship while rendering.

.label VecRomPtr        =$08     //Pointer to current vector ROM location.
.label VecRomPtrLB      =$08     //Pointer to current vector ROM location, lower byte.
.label VecRomPtrUB      =$09     //Pointer to current vector ROM location, upper byte.

.label TestSFXInit_     =$0009   //Used to start SFX during self test routines.
.label TestSFXInit      =$09     //Used to start SFX during self test routines.

.label ObjectXPosNeg    =$08     //#=$00 if bullet moving right, #=$FF if bullet moving left.
.label ShipDebrisPtr    =$09     //Index to ship debris vector data while ship is exploding.
.label ShotXDir         =$09     //Stores copy of ship/bullet X direction.

.label GenByte0B_       =$000B   //General use byte.
.label GenByte0C_       =$000C   //General use byte.

.label GenByte0A        =$0A     //General use byte.
.label GenByte0B        =$0B     //General use byte.

.label Obj2Status       =$0B     //Copy of object 2 status during hit detection routine.
.label ObjHitBox        =$0B     //Hit box value for the item that got hit.

.label VecPtr_          =$0B     //Vector RAM/ROM pointer.
.label VecPtrLB_        =$0B     //Vector RAM/ROM pointer, lower byte.
.label VecPtrUB_        =$0C     //Vector RAM/ROM pointer, upper byte.

.label GenByte0C        =$0C     //General use byte.
.label GenByte0D        =$0D     //General use byte.
.label GenByte0E        =$0E     //General use byte.

.label ObjectYPosNeg    =$0B     //#=$00 if bullet moving up, #=$FF if bullet moving down.
.label ShotAngleTemp    =$0B     //Working variable for calculating shot angle look up index.
.label ShotYDir         =$0C     //Stores copy of ship/bullet Y direction.
.label ShotXYDistance   =$0C     //Stores XY components of small saucer shot for angle calculation.
.label SelInitial       =$0C     //Current initial selected on high score entry screen(0 to 2).
.label ShipScrShot      =$0D     //Stores index to current bullet type to process (ship or saucer).
.label RomChecksum      =$0D     //Through =$14 Stores result of ROM Kb checksums.
.label NumBulletSlots   =$0E     //Number of bullet slots. #=$01 for saucer, #=$03 for ship.
.label HiScrRank        =$0D     //The current rank of the high score being drawn.
.label HiScrBeamYLoc    =$0E     //Saves of the Y beam location while drawing high score list.
.label HiScrIndex       =$0F     //Saves the current high score while drawing high score list.


* = $1300 "AST - ROM Zeropage"
.fill 256, 0

.label InitialIndex     =$1310     //Current index to initial in high scores being processed.

.label BCDAddress       =$1315     //Stored address of BCD data byte(can only be zero page address).
.label BCDIndex         =$1316     //Index to BCD data byte.
.label ZeroBlankBypass  =$1317     //Fag to determine if zero blanking should be overridden.

.label DiagStepState    =$1315     //Keep track of which lines are drawn during diagnostic step.
.label RamSwapResults   =$1316     //#=$1300=No RAM swap problems. Any other value indicates a problem.
.label ShipDrawUnused   =$1317     //Always #=$1300. Was used for something in ship drawing routines.

.label CurrentPlyr      =$1318     //Current active player. #=$1300=Player 1, #=$1301=Player 2.
.label ScoreIndex       =$1319     //Offset to current player's score registers.
.label PrevGamePlyrs    =$131A     //Number of players in the game that just ended.

.label NumPlayers       =$131C     //Indicates if there is 1 or 2 players.
.label HighScores_      =$131D   //Base address of high scores.
.label HighScores       =$131D     //Through =$1330. Top 10 high scores. 2 bytes each.
.label HiScoreBcdLo     =$131D     //Lower 2 BCD digits of high score.
.label HiScoreBcdHi     =$131E     //Upper 2 BCD digits of high score.
.label HiScoreBcdLo_    =$131D   //Lower 2 BCD digits of high score.
.label HiScoreBcdHi_    =$131E   //Upper 2 BCD digits of high score.
.label ThisInitial      =$1331     //Current initial selected on high score entry screen(0-2).
.label Plyr1Rank        =$1332     //Player 1 rank in top score list*3 (0,3,6,9, etc).
.label Plyr2Rank        =$1333     //Player 2 rank in top score list*3 (0,3,6,9, etc).
.label HighScoreIntls_  =$1334   //Base address of high score initials.
.label HighScoreIntls   =$1334     //Through =$1351. High score initials. 3 bytes each.
.label PlayerScores     =$1352     //Base address of the player's scores.
.label Plr1ScoreBase    =$1352     //Base address of Player 1's score.
.label Plr1ScoreTens    =$1352		//Player 1 Score Tens(In BCD).
.label Plr1ScoreThous   =$1353		//Player 1 Score Thousands(In BCD).
.label Plr1ScoreThous_  =$1353   //Player 1 Score Thousands(In BCD).
.label Plr2ScoreBase    =$1354     //Base address of Player 2's score.
.label Plr2ScoreTens    =$1354		//Player 2 Score Tens(In BCD).
.label Plr2ScoreThous   =$1355		//Player 2 Score Thousands(In BCD).
.label ShipsPerGame     =$1356     //Number of ships a player starts with.
.label Plyr1Ships       =$1357     //Current number of player 1 ships.
.label Plyr2Ships       =$1358     //Current number of player 2 ships.
.label HyprSpcFlag      =$1359     //#=$1300=N0 hyperspace, #=$1301=Jump successful, #=$1380=Jump unsuccessful.
.label PlyrDispTimer    =$135A     //Timer to display Player 1/Player 2 between waves.
.label FrameCounter     =$135B     //Increments every 4 NMIs. If game loop not running, causes reset.
.label FrameTimerLo     =$135C     //16-bit timer increments every frame, lower byte.
.label FrameTimerHi     =$135D     //16-bit timer increments every frame, upper byte.
.label NmiCounter       =$135E     //Increments every NMI period.
.label RandNumLB        =$135F     //Low byte of random number word.
.label RandNumUB        =$1360     //High byte of random number word.
.label ShipDir          =$1361     //Player's ship direction.
.label ScrBulletDir     =$1362     //Saucer bullet direction.
.label InitialDebounce  =$1363     //Debounces hyperspace switch while entering initials.
.label ShipBulletSR     =$1363     //Shift register for limiting ship fire rate.
.label ShipXAccel       =$1364     //Ship acceleration in the X direction.
.label ShipYAccel       =$1365     //Ship acceleration in the Y direction.
.label SFXTimers        =$1366     //Starting address for SFX timers.
.label FireSFXTimer     =$1366     //Time to play fire SFX.
.label ScrFrSFXTimer    =$1367     //Time to play saucer fire SFX.
.label ExLfSFXTimer     =$1368     //Time to play extra life SFX.
.label ExplsnSFXTimer   =$1369     //Time to play explosion SFX.
.label ShipFireSFX_     =$136A     //Controls the ship fire SFX.
.label SaucerFireSFX_   =$136B     //Controls the saucer fire SFX.
.label ThisVolFreq      =$136C     //Current settings for the thump frequency and volume.
.label ThmpOnTime       =$136D     //Time thump SFX stays on.
.label ThumpOffTime     =$136E     //Time thump SFX stays off.
.label MultiPurpBits    =$136F     //Storage for bits to set in the MultiPurp register.
.label NumCredits       =$1370     //Current number of credits.
.label DipSwitchBits    =$1371     //Storage for dip switch values.
.label SlamTimer        =$1372     //Decrements from #=$130F if slam detected during coin insertion.
.label CoinMult         =$1373     //Number of coins after multipliers.
.label ValidCoins       =$1374     //Base address for valid coin registers below.
.label LValidCoin       =$1374     //Indicate left coin mechanism valid coin.
.label CValidCoin       =$1375     //Indicate center coin mechanism valid coin.
.label RValidCoin       =$1376     //Indicate right coin mechanism valid coin.
.label WaitCoinTimers   =$1377     //Base address for timers below.
.label LWaitCoinTimer   =$1377     //Countdown timer before another left coin will be recognized.
.label CWaitCoinTimer   =$1378     //Countdown timer before another center coin will be recognized.
.label RWaitCoinTimer   =$1379     //Countdown timer before another right coin will be recognized.
.label CoinDropTimers   =$137A     //Base address for timers below.
.label LCoinDropTimer   =$137A     //Countdown timer for left coin passing into system.
.label CCoinDropTimer   =$137B     //Countdown timer for center coin passing into system.
.label RCoinDropTimer   =$137C     //Countdown timer for right coin passing into system.
.label ShpDebrisXVelLB  =$137D     //Through =$1388. X velocity of ship debris pieces, lower byte.
.label ShpDebrisXVelUB  =$137E     //Through =$1388. X velocity of ship debris pieces, upper byte.
.label ShpDebrisYVelLB  =$1389     //Through =$1394. Y velocity of ship debris pieces, lower byte.
.label ShpDebrisYVelUB  =$138A     //Through =$1394. Y velocity of ship debris pieces, upper byte.

.label StackTop         =$01D0   //The stack should never grow past this point.
.label StackBottom      =$01FF   //The stack should never shrink to this point.

* = $1200 "AST - Object Data"
.fill 256, 0

.label AstStatus        =$1200   //Through =$121A. 17 asteroids max-their current status:
                                //The bits are arranged as follows: EEETTSSS
                                //EEE - Explosion timer.  If the MSB is set, asteroid exploding.
                                //When the timer reaches F, the explosion disappears.
                                //TT  - Asteroid type. One of the 4 asteroid types.
                                //SSS - Asteroid size. 001=small, 010=medium, 100=large.
.label ShipStatus       =$121B   //0=No Ship Or In Hyperspace, 1=Alive, =$A0-=$FF=Ship Exploding.
.label ScrStatus        =$121C   //0=No Saucer, 1=Small Saucer, 2=Large Saucer, MSB set=Exploding.
.label ScrShotTimer     =$121D   //Through =$121E. Timers for current saucer bullets.
.label ShpShotTimer     =$121F   //Through =$1222. Timers for current ship bullets.
.label AstXSpeed        =$1223   //Through =$123D. Asteroid horiz speed. 255-192=Left, 1-63=Right.
.label ShipXSpeed       =$123E   //Ship horizontal speed.
.label SaucerXSpeed     =$123F   //Saucer horizontal speed.
.label ScrShotXSpeed    =$1240   //Through =$1241. Saucer bullet horizontal speed.
.label ShipShotXSpeed   =$1242   //Through =$1245. Ship bullet horizontal speed.
.label AstYSpeed        =$1246   //Through =$1260. Asteroid vert speed. 255-192=Down, 1-63=Up. 
.label ShipYSpeed       =$1261   //Ship vertical speed.
.label SaucerYSpeed     =$1262   //Saucer vertical speed.
.label ScrShotYSpeed    =$1263   //Through =$1264. Saucer bullet vertical speed.
.label ShipShotYSpeed   =$1265   //Through =$1268. Ship bullet vertical speed.
.label AstXPosHi        =$1269   //Through =$1283. Asteroid horz position, high byte.
.label shipXPosHi       =$1284   //Ship X position, high byte.
.label ScrXPosHi        =$1285   //Saucer X position, high byte.
.label ScrShotXPosHi    =$1286   //Through =$1287. Saucer bullets X position, high byte.
.label ShipShotXPosHi   =$1288   //Through =$12AB. Ship bullets X position, high byte.
.label AstYPosHi        =$128C   //Through =$12A6. Asteroid vert position, high byte.
.label ShipYPosHi       =$12A7   //Ship Y position, high byte.
.label ScrYPosHi        =$12A8   //Saucer Y position, high byte.
.label ScrShotYPosHi    =$12A9   //Through =$12AA. Saucer bullets Y position, high byte.
.label ShipShotYPosHi   =$12AB   //Through =$12AE. Ship bullets Y position, high byte.
.label AstXPosLo        =$12AF   //Through =$12C9. Asteroid horz position, low byte.
.label ShipXPosLo       =$12CA   //Ship X position, low byte.
.label ScrXPosLo        =$12CB   //Saucer X position, low byte.
.label ScrShotXPosLo    =$12CC   //Through =$12CD. Saucer bullets X position, low byte.
.label ShipShotXPosLo   =$12CE   //Through =$12D1. Ship bullets X position, low byte.
.label AstYPosLo        =$12D2   //Through =$12EC. Asteroid vert position, low byte.
.label ShipYPosLo       =$12ED   //Ship Y position, low byte.
.label ScrYPosLo        =$12EE   //Saucer Y position, low byte.
.label ScrShotYPosLo    =$12EF   //Through =$12F0. Saucer bullets Y position, low byte.
.label ShipShotYPosLo   =$12F1   //Through =$12F4. Ship bullets Y position, low byte.
.label AstPerWave       =$12F5   //Asteroids per wave.
.label CurAsteroids     =$12F6   //Current number of asteroids.
.label ScrTimer         =$12F7   //Countdown timer for saucer spawn.
.label ScrTmrReload     =$12F8   //Reload value for saucer timer.
.label AstBreakTimer    =$12F9   //Set after asteroid hit. Prevents saucer spawn after last asteroid.
.label ShipSpawnTmr     =$12FA   //Ship spawn timer. #=$81=waiting to re-spawn.
.label ThmpSpeedTmr     =$12FB   //Timer That controls thump SFX speed.
.label ThmpOffReload    =$12FC   //Reload value for ThumpOffTime register.
.label ScrSpeedup       =$12FD   //Saucer occurrences increase if asteroid count is below this value.

//--------------------------------------[ Hardware Mapped IO ]--------------------------------------

.label Clk3Khz          =$E001   //3KHz clock.
.label Halt             =$E002   //Halt gives the vector state machine status. 1=busy, 0=idle.
.label HyprSpcSw        =$E003   //Hyperspace button status.
.label FireSw           =$E004   //Fire button status.
.label DiagStep         =$E005   //Diagnostic step. Draws diagonal lines on screen.
.label SlamSw           =$E006   //Slam switch status.
.label SelfTestSw       =$E007   //Self test DIP switch status.

.label LeftCoinSw       =$E400   //Left coin switch status.
.label CntrCoinSw       =$E401   //Center coin switch status.
.label RghtCoinSw       =$E402   //Right coin switch status.
.label Player1Sw        =$E403   //Player 1 button status.
.label Player2Sw        =$E404   //Player 2 button status.
.label ThrustSw         =$E405   //Thrust button status.
.label RotRghtSw        =$E406   //Rotation right button status.
.label RotLeftSw        =$E407   //Rotation left button status.

.label DipSw            =$E800   //Base address for the DIP switches.
.label PlayTypeSw       =$E800   //Play type DIP switches (switches 7 and 8)//
.label RghtCoinMechSw   =$E801   //Coin multiplier DIP switches for right coin mechanism.
.label CentCMShipsSw    =$E802   //Coin multiplier center coin mechanism, ships per play DIP switches.
.label LanguageSw       =$E803   //Language selection DIP switches.

.label DmaGo            =$F800   //Writing this address starts the vector state machine.

.label MultiPurp        =$F900   //Multipurpose write register. Below are the bit functions:
                                //%00000001 - Player 2 button lamp control.
                                //%00000010 - Player 1 button lamp control.
                                //%00000100 - RAM select: swap RAM bank 2 and 3.
                                //%00001000 - Enable/disable left coin counter.
                                //%00010000 - Enable/disable center coin counter.
                                //%00100000 - Enable/disable right coin counter.
                                //%01000000 - Not used.
                                //%10000000 - Not used.

.label WdClear          =$FA00   //Clears the watchdog timer.

.label ExpPitchVol      =$FB00   //Controls the explosion SFX pitch and volume.
.label ThumpFreqVol     =$FB01   //Controls the thump frequency and volume.
.label SaucerSFX        =$FC00   //Controls the saucer sound.
.label SaucerFireSFX    =$FC01   //Controls the saucer fire SFX.
.label SaucerSFXSel     =$FC02   //Controls the frequency of the saucer SFX.
.label ShipThrustSFX    =$FC03   //Controls the ship thrust SFX.
.label ShipFireSFX      =$FC04   //Controls the ship fire SFX.
.label LifeSFX          =$FC05   //Controls the life SFX.
.label NoiseReset       =$FE00   //Resets the noise SFX.

//------------------------------------------[ Constants ]-------------------------------------------

.label Zero             =$00     //Constant zero.
.label MpuRamPages      =$04     //four pages = 1k MPU RAM.
.label SelfTestWait     =$24     //36 3Khz clock wait (.144 seconds).
.label BadRamFreq       =$1D     //Thump frequency setting for bad RAM.
.label GoodRamFreq      =$14     //Thump frequency setting for good RAM.
.label EnableBit        =$80     //The MSB is used to check/set hardware enables.
.label MaxAsteroids     =$1A     //Max number of asteroids(26+1 = 27).
.label ShipIndex        =$1B     //Index to ship status.
.label ScrIndex         =$1C     //Index to saucer status.

.label LargeAst         =$04     //Large asteroid.
.label MediumAst        =$02     //Medium asteroid.
.label SmallAst         =$01     //Small asteroid.

.label LargeAstPnts     =$02     //20 points for a Large asteroid hit.
.label MedAstPnts       =$05     //50 points for medium asteroid hit.
.label SmallAstPnts     =$10     //100 points for a small asteroid hit.
.label LargeScrPnts     =$20     //200 points for a large saucer hit.
.label SmallScrPnts     =$99     //990 points for a small saucer hit.

.label HghScrText       =$00     //HIGH SCORES 
.label PlyrText         =$01     //PLAYER
.label YrScrText        =$02     //YOUR SCORE IS ONE OF THE TEN BEST 
.label InitText         =$03     //PLEASE ENTER YOUR INITIALS
.label PshRtText        =$04     //PUSH ROTATE TO SELECT LETTER 
.label PshHypText       =$05     //PUSH HYPERSPACE WHEN LETTER IS CORRECT 
.label PshStrtText      =$06     //PUSH START 
.label GmOvrText        =$07     //GAME OVER
.label OneTwoText       =$08     //1 COIN 2 PLAYS 
.label OneOneText       =$09     //1 COIN 1 PLAY 
.label TwoOneText       =$0A     //2 COINS 1 PLAY 

.label Vec0Opcode       =$00     //VEC vector state machine opcode.
.label Vec1Opcode       =$01     //VEC vector state machine opcode.
.label Vec2Opcode       =$02     //VEC vector state machine opcode.
.label Vec3Opcode       =$03     //VEC vector state machine opcode.
.label Vec4Opcode       =$04     //VEC vector state machine opcode.
.label Vec5Opcode       =$05     //VEC vector state machine opcode.
.label Vec6Opcode       =$06     //VEC vector state machine opcode.
.label Vec7Opcode       =$07     //VEC vector state machine opcode.
.label Vec8Opcode       =$08     //VEC vector state machine opcode.
.label Vec9Opcode       =$09     //VEC vector state machine opcode.
.label CurOpcode        =$A0     //CUR vector state machine opcode.
.label HaltOpcode       =$B0     //HALT vector state machine opcode.
.label JsrOpcode        =$C0     //JSR vector state machine opcode.
.label RtsOpcode        =$D0     //RTS vector state machine opcode.
.label JumpOpcode       =$E0     //JUMP vector state machine opcode.
.label SvecOpcode       =$F0     //SVEC vector state machine opcode.

.label Plyr2Lamp        =$01     //Illuminate player 2 button lamp.
.label Plyr1Lamp        =$02     //Illuminate player 1 button lamp.
.label PlyrLamps        =$03     //Illuminate both player button lamps.
.label RamSwap          =$04     //Swap RAM banks 2 and 3.
.label CoinCtrLeft      =$08     //Enable left coin counter.
.label CoinCtrCntr      =$10     //Enable center coin counter.
.label CoinCtrRght      =$20     //Enable right coin counter.

.label Coin2Play1       =$00     //2 coins for 1 play.
.label Coin1Play1       =$01     //1 coin for 1 play.
.label Coin1Play2       =$02     //1 coin for 2 plays.
.label FreePlay         =$03     //Free play enabled.

.label CoinRX1          =$03     //Right coin mechanism multiplier X 1.
.label CoinRX4          =$02     //Right coin mechanism multiplier X 4.
.label CoinRX5          =$01     //Right coin mechanism multiplier X 5.
.label CoinRX6          =$00     //Right coin mechanism multiplier X 6.

.label CoinLX1          =$01     //Left coin mechanism multiplier X 1.
.label CoinLX2          =$00     //Left coin mechanism multiplier X 2.

.label ShipsX3          =$00     //3 ships per game.
.label ShipsX4          =$01     //4 ships per game.

.label English          =$03     //English language DIP switch settings.
.label German           =$02     //German language DIP switch settings.
.label French           =$01     //French language DIP switch settings.
.label Spanish          =$00     //Spanish language DIP switch settings.

.label ExpPitch         =$C0     //Explosion pitch control bits.
.label ExpVolume        =$3C     //Explosion volume control bits.
.label ThumpFreq        =$0F     //Thump frequency control bits.
.label ThumpVol         =$10     //Thump volume control bit.


.label VecBankErr     =          $5088
.label VecCredits      =        $50A4
.label ShrapPatPtrTbl   =         $50F8
.label ShipExpPtrTbl  =          $50E0
.label ShipExpVelTbl   =          $50EC
.label AstPtrnPtrTbl   =         $51DE
.label ScrPtrnPtrTbl    =        $5250
.label ShipDirPtrTbl    =        $526E
.label ExtLivesDat      =        $54DA
.label CharPtrTbl       =        $56D4
//.label EnglishTextTbl   =        $571E
//.label ThrustTbl        =        $57B9