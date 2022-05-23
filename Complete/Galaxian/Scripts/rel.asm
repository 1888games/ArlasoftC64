


SOUND_VOL                           EQU $41C0         // Bit 0 and 1 are written to !SOUND Vol of F1 and !SOUND Vol of F2 respectively. See $1712
PITCH_SOUND_FX_BASE_FREQ            EQU $41C1         // used to write to !pitch  Sound Fx base frequency. See $171F
ENABLE_ALIEN_ATTACK_SOUND           EQU $41C2         // When set to 1, turns on alien attack noise, see $17D0
UNKNOWN_SOUND_41C3                  EQU $41C3          
UNKNOWN_SOUND_41C4                  EQU $41C4         // Seems to affect the pitch of the alien attack noise. 

PLAY_EXTRA_LIFE_SOUND               EQU $41C7         // when set to 1, play the sound of an extra life being awarded. See $184F
EXTRA_LIFE_SOUND_COUNTER            EQU $41C8            
PLAY_PLAYER_CREDIT_SOUND            EQU $41C9         // when set to 1, play the sound of player credits being added. See $1876
PLAYER_CREDIT_SOUND_COUNTER         EQU $41CA         // The higher the value, the longer the player credit sound plays.
                                    EQU $41CB          
PLAY_PLAYER_SHOOT_SOUND             EQU $41CC         // When set to 1, play the sound of the player's bullet. See $1723
IS_COMPLEX_SOUND_PLAYING            EQU $41CD         // When set to 1, a sequence of sounds, or a melody, is playing. 
PLAYER_SHOOT_SOUND_COUNTER          EQU $41CE         // The higher the value, the longer the player spaceship bullet sound plays.
                                    EQU $41CF 
RESET_SWARM_SOUND_TEMPO             EQU $41D0         // When set to 1, resets the tempo of the "swarm" sound to slow again. See $1898
PLAY_GAME_START_MELODY              EQU $41D1         // When set to 1, plays the game start tune. 
                                    EQU $41D2         // sound related
COMPLEX_SOUND_POINTER               EQU $41D3         // If music or complex sound effect is playing, this points to the current sound/musical note being played. See $1782
                                    EQU $41D5         // Used to set !Pitch Sound FX base frequency
DELAY_BEFORE_NEXT_SOUND             EQU $41D6         // counter. When counts to zero the next sound/musical note is played. See $177B
ALIEN_DEATH_SOUND                   EQU $41DF         // Tentative name. When set to $06: plays alien death sound. When set to $16, plays flagship death sound. See @$1819
                                    EQU $41E8

// HAVE_ALIENS_IN_ROW_FLAGS is an array of 6 bytes. Each byte contains a bit flag specifying if there are any aliens on a given row.
HAVE_ALIENS_IN_ROW_FLAGS            EQU $41E8
NEVER_USED_ROW_1                    EQU $41E8
NEVER_USED_ROW_2                    EQU $41E9

HAVE_ALIENS_IN_6TH_ROW              EQU $41EA         // flag set to 1 if there are any aliens in the bottom row (blue aliens)
HAVE_ALIENS_IN_5TH_ROW              EQU $41EB         // flag set to 1 if there are any aliens in the 5th row (blue aliens)
HAVE_ALIENS_IN_4TH_ROW              EQU $41EC         // flag set to 1 if there are any aliens in the 4th row (blue aliens)
HAVE_ALIENS_IN_3RD_ROW              EQU $41ED         // flag set to 1 if there are any aliens in the 3rd row (purple aliens)
HAVE_ALIENS_IN_2ND_ROW              EQU $41EE         // flag set to 1 if there are any aliens in the 2nd row (red aliens)
HAVE_ALIENS_IN_TOP_ROW              EQU $41EF         // flag set to 1 if there are any aliens in the top row (flagships)

                                           
ALIEN_IN_COLUMN_FLAGS               EQU $41F0          
ALIEN_IN_COLUMN_FLAGS_END           EQU $41FF     


// INFLIGHT_ALIEN_SHOOT_EXACT_X and MINFLIGHT_ALIEN_SHOOT_RANGE_MUL are used to determine if an alien can shoot a bullet. See $0E54 for information.
INFLIGHT_ALIEN_SHOOT_RANGE_MUL      EQU $4213         // Range multiplier.   
INFLIGHT_ALIEN_SHOOT_EXACT_X        EQU $4214         // Exact X coordinate that calculated value must match for alien to shoot.

ALIENS_ATTACK_FROM_RIGHT_FLANK      EQU $4215         // Flag used to determine what side of swarm aliens break off from. (0=break from left, 1=break from right). See $136f and $1426 
                                    EQU $4217         // 

// These 2 counters are used to gradually increase the DIFFICULTY_EXTRA_VALUE over time. See $14F3 for algorithm details.
DIFFICULTY_COUNTER_1                EQU $4218         // Counts down to zero. 
DIFFICULTY_COUNTER_2                EQU $4219         // Counts down to zero. When it reaches zero, DIFFICULTY_EXTRA_VALUE is incremented.

// These values determine how often aliens attack (see $1524 and $1583), and how many can attack at one time (see $1352). 
DIFFICULTY_EXTRA_VALUE              EQU $421A         // DIFFICULTY_EXTRA_VALUE is incremented during the level. Maximum value of 7. See $1509.  
DIFFICULTY_BASE_VALUE               EQU $421B         // DIFFICULTY_BASE_VALUE is incremented when you complete a level. Maximum value of 7. See $1656.

PLAYER_LEVEL                        EQU $421C         // Current player's level. Starts from 0. Add 1 to get true value. See $252C.
PLAYER_LIVES                        EQU $421D         // current player's lives
FLAGSHIP_SURVIVOR_COUNT             EQU $421E         // When starting a new level, how many surviving flagships can we bring over from the previous level? Maximum value 2.  See $166C
LFO_FREQ_BITS                       EQU $421F         // Value used to set !DRIVER Background lfo frequency ports (0-3) for the "swarm" noise

CURRENT_PLAYER_STATE_END            EQU $421F                

HAVE_NO_ALIENS_IN_SWARM             EQU $4220         // Set to 1 when $4100 - $417F are set to 0. Aliens are either all dead, or are in flight and out of the swarm. See $0A0F
HAVE_NO_BLUE_OR_PURPLE_ALIENS       EQU $4221         // When set to 1, all the blue and purple aliens have died, or are in flight. See $09FA and $1571  
LEVEL_COMPLETE                      EQU $4222         // When set to 1, the level is treated as complete. See @$1621, $1637
NEXT_LEVEL_DELAY_COUNTER            EQU $4223         // After all aliens have fled or been killed, this counts down to give the player breathing space. When it hits 0, the next wave starts. See $1637
HAVE_AGGRESSIVE_ALIENS              EQU $4224         // when set to 1, inflight aliens will not return to swarm and keep attacking player until they die - or you die. See $16B8
HAVE_NO_INFLIGHT_OR_DYING_ALIENS    EQU $4225         // When set to 1, there are no aliens inflight, or dying. See $06BC
HAVE_NO_INFLIGHT_ALIENS             EQU $4226         // When set to 1, no aliens have broken off from the swarm to attack the player.
CAN_ALIEN_ATTACK                    EQU $4228         // When set to 1, a single alien should break off from the swarm to attack the player. See $1344.
CAN_FLAGSHIP_OR_RED_ALIENS_ATTACK   EQU $4229         // When set to 1, a flagship should attack the player, with an escort if possible. If no flagships alive, send red aliens.  See $140C.
FLAGSHIP_ESCORT_COUNT               EQU $422A         // Number of red aliens escorting the flagship. Max value of 2. See $0D58.

// When you shoot an enemy flagship in flight that this puts the aliens into a state of "shock" where they are afraid to leave the swarm for a while.
// No aliens will leave the swarm while $422B is set to 1 and $422C is non-zero. 
IS_FLAGSHIP_HIT                     EQU $422B         // Set to 1 when you've shot a flagship in flight. See $127C  
ALIENS_IN_SHOCK_COUNTER             EQU $422C         // When $422B is set to 1, this counter decrements. When it hits 0, $422B will be set to 0, meaning aliens can leave the swarm again.  
FLAGSHIP_SCORE_FACTOR               EQU $422D         // When you shoot a flagship, this is used to compute your score. Couldn't think of a better name! See $127C

ENABLE_FLAGSHIP_ATTACK_SECONDARY_COUNTER      EQU $422E         // when set to 1, FLAGSHIP_ATTACK_SECONDARY_COUNTER is allowed to decrement.             
FLAGSHIP_ATTACK_SECONDARY_COUNTER   EQU $422F         // Counts down to 0. When reaches zero, CAN_FLAGSHIP_OR_RED_ALIENS_ATTACK will be set to 1.

DISABLE_SWARM_ANIMATION             EQU $4238         // When set to 1, alien swarm won't animate. See $2067 for docs. 

// These 2 counters are used to determine when a flagship is permitted to attack.  See $156A.
FLAGSHIP_ATTACK_MASTER_COUNTER_1    EQU $4245          
FLAGSHIP_ATTACK_MASTER_COUNTER_2    EQU $4246          

// ALIEN_ATTACK_COUNTERS is an array of BYTE counters that control when aliens (but not flagships) break off from the swarm to attack. 
// ALIEN_ATTACK_MASTER_COUNTER at $424A is the first element of the array. The secondary counters are stored in $424B to $425A. 
// The ALIEN_ATTACK_MASTER_COUNTER acts as a gateway to the secondary counters// only when the master counter reaches zero will the secondary counters in the array be decremented.
// If any of the secondary counters reach zero, an alien will attack the player. See $1532 for more info.
ALIEN_ATTACK_COUNTERS               EQU $424A  
ALIEN_ATTACK_MASTER_COUNTER         EQU $424A
ALIEN_ATTACK_SECONDARY_COUNTERS     EQU $425B         
ALIEN_ATTACK_SECONDARY_COUNTERS_END EQU $425A     


TIMING_VARIABLE                     EQU $425F         // Perpetually decremented by the NMI handler. Routines use this variable to determine when to execute.
                                                         

// ENEMY_BULLETS is an array of type ENEMY_BULLET. 
//
// The array occupies memory locations $4260 - $42A5// It is thus 70 bytes in size. 
// As an ENEMY_BULLET record only requires 5 bytes, this means that there's room for 14 enemy bullets in the array.
//

struct ENEMY_BULLET
{
    BYTE IsActive//
    BYTE X//
    BYTE YL//                                       // low byte of the Y coordinate. Used to represent "fractional part" of Y coordinate
    BYTE YH//                                       // high byte of the Y coordinate.  
    BYTE YDelta//                                   // packed delta to add to YH *and* YL. Bit 7 = sign bit. Bits 0-6 = delta. See @$0AA1.                                  
} - sizeof(ENEMY_BULLET) is 5 bytes

ENEMY_BULLETS                       EQU $4260
ENEMY_BULLETS_START                 EQU $4260                                                                        
ENEMY_BULLETS_END                   EQU $42A5



// INFLIGHT_ALIENS is an array of type INFLIGHT_ALIEN. 
// An "Inflight alien" is my term for an alien that has broken off from the main swarm body to attack the player. 
//
// The array occupies memory locations $42B0 - $43AF// It is thus 256 bytes in size. 
// As the INFLIGHT_ALIEN type is 32 bytes in size, this means that there's room for 8 entries in the array. 
//
// Slot 0 in the array is actually reserved for misc use, such as when you shoot an alien in the swarm body and an 
// explosion animation needs a free sprite to play. (See: $0B52 for an example of this)
//
// Slot  1 is reserved for the flagship. 
// Slots 2 and 3 are reserved for the flagship's escorts.
// Slots 4,5,6,7 are reserved for individual attacking aliens.
//
// This means there can be 7 aliens in flight maximum. 
//
//  

//
// struct INFLIGHT_ALIEN
{
  0    BYTE IsActive//                        // Set to 1 when the alien is to be processed. 
  1    BYTE IsDying//                         // Set to 1 when the alien is in the process of exploding.
  2    BYTE StageOfLife                      // See $0CD6 for details. 
  3    BYTE X//                               // X coordinate
  4    BYTE Y//                               // Y coordinate. 
  5    BYTE AnimationFrame// 
  6    BYTE ArcClockwise                     // Set to 1 if the alien will rotate clockwise as it leaves the swarm or loops the loop. See $0D71 and $101F
  7    BYTE IndexInSwarm                     // index of alien within ALIEN_SWARM_FLAGS array
  8    BYTE ???                              // Unused
  9    BYTE PivotYValue                      // When alien is attacking, this value + $19 produces INFLIGHT_ALIEN.Y coordinate. See $0DF6
  A    BYTE ???                              // Unused
  B    BYTE ???                              // Unused
  C    BYTE ???                              // Unused 
  D    BYTE ???                              // Unused
  E    BYTE ???                              // Unused
  F    BYTE AnimFrameStartCode               // Base animation frame number to which a number is added to compute sprite "code"
  10   BYTE TempCounter1                     // Counter used for various timing purposes
  11   BYTE TempCounter2                     // Secondary counter for various timing purposes
  12   BYTE DeathAnimCode                    // when IsDying is set to 1, specifies the animation frame to display. See @$0C9F
  13   BYTE ArcTableLsb                      // LSB of pointer into INFLIGHT_ALIEN_ARC_TABLE @$1E00. See docs @$0D71 and $1E00.
  14   BYTE ???                              // Unused  
  15   BYTE ???                              // Unused
  16   BYTE Colour
  17   BYTE SortieCount                      // Number of times the alien has reached the bottom of the screen then resumed attack on the player. Reset to 0 when rejoins swarm. See $0E9D.
  18   BYTE Speed                            // Value from 0..3. The higher the number the faster the alien moves. See $116B. 
  19   BYTE PivotYValueAdd                   // Signed number which is added to INFLIGHT_ALIEN.PivotYValue to produce INFLIGHT_ALIEN.Y. See $0DF6
  1A   BYTE ???                              
  1B   BYTE ???                                
  1C   BYTE ???
  1D   BYTE ???
  1E   BYTE ???                                
  1F   BYTE ???                              
}  - sizeof(INFLIGHT_ALIEN) is 32 bytes


INFLIGHT_ALIENS                     EQU $42B0
INFLIGHT_ALIENS_END                 EQU $43AF


                //
                // Used by the aliens to determine what way to face when flying down, and what delta enemy bullets take
                //
                // Expects:
                // A = distance
                // D = X coordinate
                //

                CALCULATE_TANGENT:
                0048: 0E 00         ld   c,$00
                004A: 06 08         ld   b,$08
                004C: BA            cp   d
                004D: 38 01         jr   c,$0050
                004F: 92            sub  d
                0050: 3F            ccf
                0051: CB 11         rl   c
                0053: CB 1A         rr   d
                0055: 10 F5         djnz $004C
                0057: C9            ret

                0058: FF            rst  $38
                0059: FF            rst  $38
                005A: FF            rst  $38
                005B: FF            rst  $38
                005C: FF            rst  $38
                005D: FF            rst  $38
                005E: FF            rst  $38
                005F: FF            rst  $38
                0060: FF            rst  $38
                0061: FF            rst  $38
                0062: FF            rst  $38
                0063: FF            rst  $38
                0064: FF            rst  $38
                0065: 8D            adc  a,l




HANDLE_MAIN_GAME_LOGIC:

                066A: CD C3 0C      call $0CC3               // call HANDLE_INFLIGHT_ALIENS
                066D: CD BE 0B      call $0BBE               // call HANDLE_INFLIGHT_ALIEN_SPRITE_UPDATE
                0682: CD 0C 14      call $140C               // call HANDLE_FLAGSHIP_ATTACK
                0685: CD 44 13      call $1344               // call HANDLE_SINGLE_ALIEN_ATTACK
                0688: CD E1 13      call $13E1               // call SET_ALIEN_ATTACK_FLANK
                068B: CD F3 14      call $14F3               // call HANDLE_LEVEL_DIFFICULTY

                0697: CD 15 15      call $1515               // call CHECK_IF_ALIEN_CAN_ATTACK
                069A: CD 55 15      call $1555               // call UPDATE_ATTACK_COUNTERS
                069D: CD C3 15      call $15C3               // call CHECK_IF_FLAGSHIP_CAN_ATTACK
                06A0: CD F4 15      call $15F4               // call HANDLE_CALC_INFLIGHT_ALIEN_SHOOTING_DISTANCE
                06A6: CD 37 16      call $1637               // call HANDLE_LEVEL_COMPLETE
                06A9: CD B8 16      call $16B8               // call HANDLE_ALIEN_AGGRESSIVENESS
                06AC: CD 88 16      call $1688               // call HANDLE_SHOCKED_SWARM



                    //
                    // This routine sets the following flags:  
                    //
                    // ALIEN_IN_COLUMN_FLAGS
                    // HAVE_ALIENS_IN_6TH_ROW
                    // HAVE_ALIENS_IN_5TH_ROW
                    // HAVE_ALIENS_IN_4TH_ROW
                    // HAVE_ALIENS_IN_3RD_ROW
                    // HAVE_ALIENS_IN_2ND_ROW
                    // HAVE_ALIENS_IN_TOP_ROW
                    // HAVE_NO_BLUE_OR_PURPLE_ALIENS
                    // HAVE_NO_ALIENS_IN_SWARM 
                    // HAVE_NO_INFLIGHT_ALIENS
                    // HAVE_NO_INFLIGHT_OR_DYING_ALIENS
                    // 
                    // It also sets the values for SWARM_SCROLL_MAX_EXTENTS. 

                    SET_ALIEN_PRESENCE_FLAGS:     // TENTATIVE NAME - If anyone can think of anything better, give me a shout
                    098E: AF            xor  a
                    098F: 11 E8 41      ld   de,$41E8     
                    0992: 12            ld   (de),a              // clear $41E8
                    0993: 1C            inc  e                    
                    0994: 12            ld   (de),a              // clear $41E9
                    0995: 1C            inc  e                   // DE now = $41EA (address of HAVE_ALIENS_IN_IN_ROW_FLAGS)

                    // This part of the code determines if there are any aliens on a given row.
                    // It will set the corresponding flag in the HAVE_ALIENS_IN_ROW_FLAGS array.
                    // it works from the bottom row of aliens to the top.
                    0996: 0E 06         ld   c,$06               // there are 6 rows of aliens. Used as a row counter.
                    0998: 21 23 41      ld   hl,$4123            // pointer to bottom right alien in ALIEN_SWARM_FLAGS

                    099B: 06 0A         ld   b,$0A               // There's $0A (10 decimal) aliens max per row
                    099D: AF            xor  a                   // clear A. 
                    099E: B6            or   (hl)                // If an alien is present, A will now be set to 1.
                    099F: 2C            inc  l                   // move to next flag
                    09A0: 10 FC         djnz $099E               // repeat tests until B == 0.

                    09A2: 12            ld   (de),a              // store alien presence flag in HAVE_ALIENS_IN_[]_ROW flag
                    09A3: 1C            inc  e                   // bump DE to point to next HAVE_ALIENS_IN_[]_ROW flag
                    09A4: 7D            ld   a,l          
                    09A5: C6 06         add  a,$06
                    09A7: 6F            ld   l,a                 // Add 6 to HL. Now HL points to flags for row of aliens above previous    
                    09A8: 0D            dec  c                   // decrement row counter
                    09A9: C2 9B 09      jp   nz,$099B            // if not all rows of aliens have been processed, goto $099B

                    // when we get here, DE points to $41F0, which is the start of the ALIEN_IN_COLUMN_FLAGS array.
                    09AC: AF            xor  a
                    09AD: 12            ld   (de),a              // clear first entry of ALIEN_IN_COLUMN_FLAGS. 
                    09AE: 1C            inc  e
                    09AF: 12            ld   (de),a              // clear second entry of ALIEN_IN_COLUMN_FLAGS.
                    09B0: 1C            inc  e
                    09B1: 12            ld   (de),a              // clear second entry of ALIEN_IN_COLUMN_FLAGS.
                    09B2: 1C            inc  e

                    09B3: 21 23 41      ld   hl,$4123            // pointer to bottom right alien in ALIEN_SWARM_FLAGS 
                    09B6: 0E 0A         ld   c,$0A               // There's $0A (10 decimal) columns of aliens 

                    // Working from the rightmost column of aliens to the left, check each column for presence of aliens and
                    // set/clear respective flag in ALIEN_IN_COLUMN_FLAGS array accordingly. 
                    09B8: D5            push de
                    09B9: 11 10 00      ld   de,$0010            // offset to add to HL to point to alien in row above, same column.
                    09BC: 06 06         ld   b,$06               // 6 rows of aliens. Used as a row counter.
                    09BE: AF            xor  a
                    09BF: B6            or   (hl)                // If an alien is present, A will now be set to 1.
                    09C0: 19            add  hl,de               // Point HL to alien in row above, same column.
                    09C1: 10 FC         djnz $09BF               // Repeat until all 6 rows of aliens have been scanned
                    09C3: D1            pop  de
                    09C4: 12            ld   (de),a              // set/clear flag in ALIEN_IN_COLUMN_FLAGS
                    09C5: 1C            inc  e                   // bump DE to point to next entry in ALIEN_IN_COLUMN_FLAGS

                    // we've scanned all the aliens in a column. 
                    // We now want to scan the next column of aliens to the immediate *left* of the column we just scanned. 
                    09C6: 7D            ld   a,l
                    09C7: D6 5F         sub  $5F
                    09C9: 6F            ld   l,a                 // now HL points to bottom alien in next column of aliens to check  
                    09CA: 0D            dec  c                   // decrement counter for number of columns left to process            
                    09CB: C2 B8 09      jp   nz,$09B8            // if we've not done all the columns, goto $09B8

                    // the following code works out how far to the left the swarm can move. Or should I say, how far the swarm can be scrolled down.
                    // TODO: I'll come back to this code later, but at the moment there's bigger fish to fry with this game, so I'll just leave bare bones here.
                    09CE: 21 FC 41      ld   hl,$41FC            // load HL with a pointer to flag for the leftmost column of aliens in ALIEN_IN_COLUMN_FLAGS
                    09D1: 06 0A         ld   b,$0A               // There's $0A (10 decimal) columns of aliens 
                    09D3: 1E 22         ld   e,$22
                    09D5: CB 46         bit  0,(hl)              // Test the flag. Is there an alien in the column?
                    09D7: 20 09         jr   nz,$09E2            // yes, goto $09E2
                    09D9: 2D            dec  l                   // bump HL to point to flag for column to left
                    09DA: 7B            ld   a,e
                    09DB: C6 10         add  a,$10
                    09DD: 5F            ld   e,a
                    09DE: 10 F5         djnz $09D5

                    // now work out how far to the right the swarm can move. 
                    09E0: 1E 22         ld   e,$22
                    09E2: 21 F3 41      ld   hl,$41F3            // load HL with a pointer to flag for the rightmost column of aliens in ALIEN_IN_COLUMN_FLAGS
                    09E5: 06 0A         ld   b,$0A               // There's $0A (10 decimal) columns of aliens
                    09E7: 16 E0         ld   d,$E0
                    09E9: CB 46         bit  0,(hl)              // Test the flag. Is there an alien in the column?
                    09EB: 20 09         jr   nz,$09F6            // yes, goto $09F6
                    09ED: 2C            inc  l
                    09EE: 7A            ld   a,d
                    09EF: D6 10         sub  $10
                    09F1: 57            ld   d,a
                    09F2: 10 F5         djnz $09E9
                    09F4: 16 E0         ld   d,$E0
                    09F6: ED 53 10 42   ld   ($4210),de          // set SWARM_SCROLL_MAX_EXTENTS

                    // Check if any of the bottom 4 rows of aliens (blue & purple) have any aliens in them. *Aliens from those rows that are in flight don't count*
                    09FA: 21 EA 41      ld   hl,$41EA            // load HL with pointer to HAVE_ALIENS_IN_6TH_ROW
                    09FD: 0E 01         ld   c,$01
                    09FF: 06 04         ld   b,$04               // we want to do 4 rows of aliens
                    0A01: AF            xor  a
                    0A02: B6            or   (hl)                // test if there's an alien present on the row
                    0A03: 2C            inc  l                   // bump HL to point to flag for row above 
                    0A04: 10 FC         djnz $0A02               // repeat until b==0
                    0A06: A9            xor  c                   // 
                    0A07: 32 21 42      ld   ($4221),a           // set HAVE_NO_BLUE_OR_PURPLE_ALIENS flag

                    // HL = pointer to HAVE_ALIENS_IN_2ND_ROW
                    0A0A: A9            xor  c                   // if A was 1, set it to 0, and vice versa
                    0A0B: B6            or   (hl)                // if any aliens in red row set A to 1  *Red aliens in flight don't count*
                    0A0C: 2C            inc  l                   // bump HL to point to HAVE_ALIENS_IN_TOP_ROW
                    0A0D: B6            or   (hl)                // if any aliens in flagship row set A to 1   *Flagships that are in flight don't count*
                    0A0E: A9            xor  c                   // if A was 1, set it to 0, and vice versa
                    0A0F: 32 20 42      ld   ($4220),a           // set/reset HAVE_NO_ALIENS_IN_SWARM flag.

                    // Check if we have any aliens "in-flight" attacking the player.
                    // We skip the first entry in the INFLIGHT_ALIENS array because the first entry is reserved for misc use (see docs above INFLIGHT_ALIEN struct)
                    // and should not be treated as a "real" flying alien.
                    0A12: 21 D0 42      ld   hl,$42D0            // pointer to INFLIGHT_ALIENS_START+sizeof(INFLIGHT_ALIEN). Effectively skipping first INFLIGHT_ALIEN. 
                    0A15: 11 20 00      ld   de,$0020            // sizeof(INFLIGHT_ALIEN)
                    0A18: 06 07         ld   b,$07               // 7 aliens to process in the list
                    0A1A: AF            xor  a                   // clear A
                    0A1B: B6            or   (hl)                // Set A to 1 if alien is active
                    0A1C: 19            add  hl,de               // bump HL to point to next INFLIGHT_ALIEN structure in the array
                    0A1D: 10 FC         djnz $0A1B               // repeat until B==0
                    0A1F: A9            xor  c                   // if no aliens are in flight, A will be set to 1.  Else A is set 0. 
                    0A20: 32 26 42      ld   ($4226),a           // set/reset HAVE_NO_INFLIGHT_ALIENS flag 

                    // Check if we have any aliens "in-flight" or dying 
                    0A23: A9            xor  c                   // 
                    0A24: 21 B1 42      ld   hl,$42B1            // pointer to first IsDying flag of INFLIGHT_ALIENS array.
                    0A27: 06 08         ld   b,$08               // test all 8 slots
                    0A29: B6            or   (hl)                // if INFLIGHT_ALIEN.IsDying is set to 1, set A to 1.
                    0A2A: 19            add  hl,de               // bump HL to point to next INFLIGHT_ALIEN structure in the array
                    0A2B: 10 FC         djnz $0A29               // repeat until B==0
                    0A2D: A9            xor  c                   // 
                    0A2E: 32 25 42      ld   ($4225),a           // set/reset HAVE_NO_INFLIGHT_OR_DYING_ALIENS
                    0A31: C9            ret


                  //
                  // Move enemy bullets and position enemy bullet sprites
                  //
                  //
                  //

                  HANDLE_ENEMY_BULLETS:
                  0A74: DD 21 60 42   ld   ix,$4260            // load IX with address of ENEMY_BULLETS_START
                  0A78: 3A 5F 42      ld   a,($425F)           // read TIMING_VARIABLE
                  0A7B: 0F            rrca                     // move bit 0 into carry
                  0A7C: 38 0B         jr   c,$0A89             // if TIMING_VARIABLE is an odd number, goto $0A89
                  0A7E: DD 34 01      inc  (ix+$01)            // Increment ENEMY_BULLET.X by 2.. 
                  0A81: DD 34 01      inc  (ix+$01)            // 

                  0A84: 11 05 00      ld   de,$0005            // sizeof(ENEMY_BULLET)
                  0A87: DD 19         add  ix,de
                  0A89: FD 21 81 40   ld   iy,$4081            // pointer to OBJRAM_BACK_BUF_BULLETS
                  0A8D: 06 07         ld   b,$07               // number of bullets

                  // main bullet loop
                  0A8F: DD CB 00 46   bit  0,(ix+$00)          // test ENEMY_BULLET.IsActive flag
                  0A93: 28 27         jr   z,$0ABC             // if enemy bullet is not active, goto $0ABC
                  0A95: DD 7E 01      ld   a,(ix+$01)          // read ENEMY_BULLET.X 
                  0A98: C6 02         add  a,$02               // bullet will move 2 pixels
                  0A9A: DD 77 01      ld   (ix+$01),a          // update ENEMY_BULLET.X
                  0A9D: C6 04         add  a,$04               // tentatively add 4 to the X coordinate. If a carry occurs, enemy bullet is at bottom of screen 
                  0A9F: 38 1B         jr   c,$0ABC             // enemy bullet is at bottom of screen so needs to be deactivated, goto $0ABC

                  // split ENEMY_BULLET.YDelta into its sign and delta, then add to YH and YL respectively. 
                  0AA1: DD 6E 02      ld   l,(ix+$02)          // read ENEMY_BULLET.YL
                  0AA4: DD 66 03      ld   h,(ix+$03)          // read ENEMY_BULLET.YH
                  0AA7: DD 5E 04      ld   e,(ix+$04)          // read ENEMY_BULLET.YDelta 
                  0AAA: CB 13         rl   e                   // move bit 7 of E (sign bit) into carry. Shift YDelta bits left into bits 1..7.                  
                  0AAC: 9F            sbc  a,a                 // A = 0 - carry
                  0AAD: 57            ld   d,a                 // if bit 7 of E was set, D will be $FF, else 0.
                  0AAE: 19            add  hl,de               
                  0AAF: DD 75 02      ld   (ix+$02),l          // set ENEMY_BULLET.YL
                  0AB2: DD 74 03      ld   (ix+$03),h          // set ENEMY_BULLET.YH
                  0AB5: 7C            ld   a,h                 // get ENEMY_BULLET.YH coordinate into A
                  0AB6: C6 10         add  a,$10               // add #$10 (16 decimal) . 
                  0AB8: FE 20         cp   $20                 // compare to $20 (32 decimal)
                  0ABA: 30 0A         jr   nc,$0AC6            // if >= 32 decimal, bullet is still onscrene, goto $0AC6

                  // bullet is offscreen, deactivate it
                  0ABC: AF            xor  a
                  0ABD: DD 77 00      ld   (ix+$00),a          // set ENEMY_BULLET.IsActive flag (disables bullet)
                  0AC0: DD 77 01      ld   (ix+$01),a          // set ENEMY_BULLET.X to 0 
                  0AC3: DD 77 03      ld   (ix+$03),a          // set ENEMY_BULLET.YH to 0

                  // we now need to position the actual enemy bullet sprites.
                  0AC6: 3A 18 40      ld   a,($4018)           // read DISPLAY_IS_COCKTAIL_P2
                  0AC9: 0F            rrca                     // move flag into carry
                  0ACA: 38 29         jr   c,$0AF5             // if carry is set, it's a cocktail setup and player 2's turn, goto $0AF5

                  0ACC: DD 7E 01      ld   a,(ix+$01)          // read ENEMY_BULLET.X 
                  0ACF: 2F            cpl                      // A = (255 - A) 
                  0AD0: 3D            dec  a                   // A = A-1
                  0AD1: FD 77 02      ld   (iy+$02),a          // write to OBJRAM_BACK_BUF_BULLETS sprite state

                  // looks to me like there's a hardware "feature" where the Y coordinate of alien bullets 5-7 needs adjusted by 1 so the sprite is positioned correctly.
                  // if anyone can tell me why, drop me a line. Thanks!
                  0AD4: DD 7E 03      ld   a,(ix+$03)          // read ENEMY_BULLET.YH 
                  0AD7: 2F            cpl                      // A = (255 - A) 
                  0AD8: 4F            ld   c,a
                  0AD9: 78            ld   a,b                 // get index of enemy bullet we are processing into A
                  0ADA: FE 05         cp   $05                 // are we processing bullet #5 or more?
                  0ADC: 38 01         jr   c,$0ADF             // no, goto $0ADF
                  0ADE: 0C            inc  c                   // adjust Y coordinate
                  0ADF: FD 71 00      ld   (iy+$00),c          // write to OBJRAM_BACK_BUF_BULLETS sprite Y coordinate

                  0AE2: 11 05 00      ld   de,$0005            // sizeof(ENEMY_BULLET)
                  0AE5: DD 19         add  ix,de               // bump IX to point to next ENEMY_BULLET in ENEMY_BULLETS array
                  0AE7: DD 34 01      inc  (ix+$01)            // increment ENEMY_BULLET.X
                  0AEA: DD 34 01      inc  (ix+$01)            // twice, to make it move 2 pixels

                  0AED: DD 19         add  ix,de               // bump IX to point to next ENEMY_BULLET in ENEMY_BULLETS array
                  0AEF: 1D            dec  e                   // DE is now 4  
                  0AF0: FD 19         add  iy,de               // bump IY to point to state of next sprite in OBJRAM_BACK_BUF_BULLETS
                  0AF2: 10 9B         djnz $0A8F               // repeat until B ==0
                  0AF4: C9            ret

                  // called if we have a cocktail display and it's player 2's turn. 
                  0AF5: DD 7E 01      ld   a,(ix+$01)
                  0AF8: D6 04         sub  $04
                  0AFA: FD 77 02      ld   (iy+$02),a
                  0AFD: DD 7E 03      ld   a,(ix+$03)
                  0B00: 2F            cpl
                  0B01: 4F            ld   c,a
                  0B02: 78            ld   a,b
                  0B03: FE 05         cp   $05
                  0B05: 38 D8         jr   c,$0ADF
                  0B07: 0D            dec  c
                  0B08: C3 DF 0A      jp   $0ADF




          //
          // This routine is responsible for processing all 8 elements in the INFLIGHT_ALIENS array. 
          //

          HANDLE_INFLIGHT_ALIENS:
          0CC3: DD 21 B0 42   ld   ix,$42B0            // load IX with address of INFLIGHT_ALIENS
          0CC7: 11 20 00      ld   de,$0020            // sizeof(INFLIGHT_ALIEN)
          0CCA: 06 08         ld   b,$08               // 1 misc + 7 attacking aliens to process
          0CCC: D9            exx
          0CCD: CD D6 0C      call $0CD6               // call HANDLE_INFLIGHT_ALIEN_STAGE_OF_LIFE
          0CD0: D9            exx
          0CD1: DD 19         add  ix,de               // bump IX to point to next INFLIGHT_ALIEN structure
          0CD3: 10 F7         djnz $0CCC               // do while b!=0
          0CD5: C9            ret




//
// Like humans, inflight aliens go through stages of life. They leave home, attack humans, maybe do a loop the loop,
// then (maybe) return home. Just like we do!
// 
// This routine is used to invoke actions appropriate for the alien's stage of life.
//
// Expects:
// IX = pointer to INFLIGHT_ALIEN structure.
//

          HANDLE_INFLIGHT_ALIEN_STAGE_OF_LIFE:
          0CD6: DD CB 01 46   bit  0,(ix+$01)          // test INFLIGHT_ALIEN.IsDying flag
          0CDA: C2 E4 10      jp   nz,$10E4            // if alien is dying, goto HANDLE_INFLIGHT_ALIEN_DYING
          0CDD: DD CB 00 46   bit  0,(ix+$00)          // test INFLIGHT_ALIEN.IsActive flag 
          0CE1: C8            ret  z                   // exit if not active

        // We need to determine what stage of life the inflight alien is at, then call the appropriate function to
        // tell it how to behave. 

        0CE2: DD 7E 02      ld   a,(ix+$02)          // read INFLIGHT_ALIEN.StageOfLife 
        0CE5: EF            rst  $28                 // jump to code @ $0CE6 + (A*2)
        0CE6: 
              06 0D         // $0D06                  // INFLIGHT_ALIEN_PACKS_BAGS
              71 0D         // $0D71                  // INFLIGHT_ALIEN_FLIES_IN_ARC
              D1 0D         // $0DD1                  // INFLIGHT_ALIEN_READY_TO_ATTACK
              2B 0E         // $0E2B                  // INFLIGHT_ALIEN_ATTACKING_PLAYER
              6B 0E         // $0E6B                  // INFLIGHT_ALIEN_NEAR_BOTTOM_OF_SCREEN
              99 0E         // $0E99                  // INFLIGHT_ALIEN_REACHED_BOTTOM_OF_SCREEN
              07 0F         // $0F07                  // INFLIGHT_ALIEN_RETURNING_TO_SWARM
              3C 0F         // $0F3C                  // INFLIGHT_ALIEN_CONTINUING_ATTACK_RUN_FROM_TOP_OF_SCREEN 
              66 0F         // $0F66                  // INFLIGHT_ALIEN_FULL_SPEED_CHARGE 
              AF 0F         // $0FAF                  // INFLIGHT_ALIEN_ATTACKING_PLAYER_AGGRESSIVELY
              1F 10         // $101F                  // INFLIGHT_ALIEN_LOOP_THE_LOOP
              8E 10         // $108E                  // INFLIGHT_ALIEN_COMPLETE_LOOP
              91 10         // $1091                  // INFLIGHT_ALIEN_UNKNOWN_1091
              9B 10         // $109B                  // INFLIGHT_ALIEN_CONVOY_CHARGER_SET_COLOUR_POS_ANIM
              C2 10         // $10C2                  // INFLIGHT_ALIEN_CONVOY_CHARGER_START_SCROLL  
              D8 10         // $10D8                  // INFLIGHT_ALIEN_CONVOY_CHARGER_DO_SCROLL



                    //
              // An alien's just about to break away from the swarm. It's leaving home! 
              // Before it can do so, we need to set up an INFLIGHT_ALIEN structure with defaults. 
              //
              // Expects:
              // IX = pointer to INFLIGHT_ALIEN structure
              //



              // Referenced by code @ $0595
              COLOUR_ATTRIBUTE_TABLE_1:
              1D71:  00 05 00 00 01 01 02 03 03 04 04 04 04 00 00 00  
              1D81:  00 00 00 05 05 05 05 05 00 00 06 06 06 06 06 06          

              // Referenced by code @ $0408
              COLOUR_ATTRIBUTE_TABLE_2:
              1D91:  00 05 00 00 01 01 02 03 03 04 04 04 04 00 00 00  ................
              1DA1:  06 06 06 06 06 06 05 06 06 06 06 06 06 06 06 06  ................

              // Referenced by code @ $0212
              COLOUR_ATTRIBUTE_TABLE_3:
              1DB1:  00 05 00 00 01 01 02 03 05 04 05 04 04 00 00 00  ................
              1DC1:  00 06 06 06 06 06 06 06 06 06 00 00 07 07 06 06  ................

              // Referenced by code @ $0D1D
              1DD1:  00 00 00 00 04 01 04 02 04 01 03 03 02 02 01 02  ................


              01110000   00001110.  14         14 flagship
              01100000   00001100.  12         12.  red
              01010000.  00001010.  10. flagship 10 purple
              01000000.  00001000.  8.  red.        blue
              00110000.  00000110.  6.  purple.     blue
              00100000.  00000100.  4   blue.       blue
              00010000.  00000010.  2   blue
              00000000.  00000000.  0   blue

                  INFLIGHT_ALIEN_PACKS_BAGS:
                  0D06: DD 36 17 00   ld   (ix+$17),$00        // clear INFLIGHT_ALIEN.SortieCount 
                  0D0A: 3E 01         ld   a,$01
                  0D0C: 32 C2 41      ld   ($41C2),a           // set ENABLE_ALIEN_ATTACK_SOUND to 1.
                  0D0F: CD 47 11      call $1147               // call SET_INFLIGHT_ALIEN_START_POSITION
                  0D12: DD 5E 07      ld   e,(ix+$07)          // set command parameter to INFLIGHT_ALIEN.IndexInSwarm
                  0D15: 16 01         ld   d,$01               // command: DELETE_ALIEN_COMMAND
                  0D17: CD F2 08      call $08F2               // call QUEUE_COMMAND
                  0D1A: 7B            ld   a,e                 // load A with INFLIGHT_ALIEN.IndexInSwarm
                  0D1B: E6 70         and  $70                 // keep the row start, remove the column number
                  0D1D: 21 D1 1D      ld   hl,$1DD1
                  0D20: 0F            rrca                     // divide the row offset...
                  0D21: 0F            rrca
                  0D22: 0F            rrca                     // .. by 8.
                  0D23: 5F            ld   e,a
                  0D24: 16 00         ld   d,$00               // Extend A into DE
                  0D26: 19            add  hl,de               // HL = $1DD1 + (row number of alien /8)
                  0D27: 7E            ld   a,(hl)
                  0D28: DD 77 16      ld   (ix+$16),a          // set INFLIGHT_ALIEN.Colour

                  0D2B: 23            inc  hl
                  0D2C: 7E            ld   a,(hl)
                  0D2D: DD 77 18      ld   (ix+$18),a          // set INFLIGHT_ALIEN.Speed

                  0D30: 7B            ld   a,e
                  0D31: FE 0E         cp   $0E                 // flagship?
                  0D33: 28 23         jr   z,$0D58             // yes, goto $0D58

                  0D35: DD 36 0F 00   ld   (ix+$0f),$00        // set INFLIGHT_ALIEN.AnimFrameStartCode
                  0D39: DD 36 10 03   ld   (ix+$10),$03        // set INFLIGHT_ALIEN.TempCounter1 to speed of animation (higher number = slower)
                  0D3D: DD 36 11 0C   ld   (ix+$11),$0C        // set INFLIGHT_ALIEN.TempCounter2 to total number of animation frames 
                  0D41: DD 36 13 00   ld   (ix+$13),$00        // set INFLIGHT_ALIEN.ArcTableLsb
                  0D45: DD 34 02      inc  (ix+$02)            // set INFLIGHT_ALIEN.StageOfLife to INFLIGHT_ALIEN_FLIES_IN_ARC

                  0D48: DD CB 06 46   bit  0,(ix+$06)          // test INFLIGHT_ALIEN.ArcClockwise
                  0D4C: 20 05         jr   nz,$0D53            // if alien will be facing right when it breaks away from swarm, goto $0D53
                  0D4E: DD 36 05 0C   ld   (ix+$05),$0C        // set INFLIGHT_ALIEN.AnimationFrame
                  0D52: C9            ret

                  0D53: DD 36 05 F4   ld   (ix+$05),$F4        // set INFLIGHT_ALIEN.AnimationFrame
                  0D57: C9            ret

                  // This code is called for flagships. We need to count how many escorts we have.
                  0D58: DD 36 0F 18   ld   (ix+$0f),$18        // set INFLIGHT_ALIEN.AnimFrameStartCode
                  0D5C: AF            xor  a
                  0D5D: DD CB 20 46   bit  0,(ix+$20)          // test if we have an escort
                  0D61: 28 01         jr   z,$0D64             // no, goto $0D64
                  0D63: 3C            inc  a                   // increment escort count 
                  0D64: DD CB 40 46   bit  0,(ix+$40)          // test if we have an escort
                  0D68: 28 01         jr   z,$0D6B             // no, goto $0D6B
                  0D6A: 3C            inc  a                   // increment escort count
                  0D6B: 32 2A 42      ld   ($422A),a           // set FLAGSHIP_ESCORT_COUNT
                  0D6E: C3 39 0D      jp   $0D39               // finalise setting up flagship



            //
            // This function is used to animate an inflight alien flying in a 90 degree arc. 
            // It is called when an alien is breaking off from the swarm to attack the player, 
            // or when it is completing the last 90 degrees of a 360 degree loop the loop. 
            // As soon as the arc is complete, the alien's stage of life is set to
            // INFLIGHT_ALIEN_READY_TO_ATTACK.
            //
            // Expects:
            // IX = pointer to INFLIGHT_ALIEN that is breaking away from swarm.
            //

                    INFLIGHT_ALIEN_FLIES_IN_ARC:
                    0D71: DD 6E 13      ld   l,(ix+$13)          // read INFLIGHT_ALIEN.ArcTableLsb
                    0D74: 26 1E         ld   h,$1E               // Now HL points to an entry in INFLIGHT_ALIEN_ARC_TABLE at $1E00. 
                    0D76: DD 7E 03      ld   a,(ix+$03)          // read INFLIGHT_ALIEN.X 
                    0D79: 86            add  a,(hl)              // add in X delta from table
                    0D7A: DD 77 03      ld   (ix+$03),a          // update INFLIGHT_ALIEN.X
                    0D7D: 2C            inc  l                   // bump HL to Y coordinate in table 
                    0D7E: DD CB 06 46   bit  0,(ix+$06)          // test INFLIGHT_ALIEN.ArcClockwise
                    0D82: 20 24         jr   nz,$0DA8            // if alien is facing right, goto $0DA8

                    // alien that is leaving swarm to attack player will arc up and left.
                    // HL = pointer to table defining arc (see $1E00 for table layout)
                    0D84: DD 7E 04      ld   a,(ix+$04)          // load A with INFLIGHT_ALIEN.Y 
                    0D87: 86            add  a,(hl)              // add in Y delta from table                       
                    0D88: DD 77 04      ld   (ix+$04),a          // update INFLIGHT_ALIEN.Y 
                    0D8B: C6 07         add  a,$07
                    0D8D: FE 0E         cp   $0E                 // is the alien off-screen?
                    0D8F: 38 3B         jr   c,$0DCC             // if A< #$0E, its gone off screen, so make alien return to swarm from top of screen.
                    0D91: 2C            inc  l                   // bump HL to point to next X,Y coordinate pair in table
                    0D92: DD 75 13      ld   (ix+$13),l          // and update INFLIGHT_ALIEN.ArcTableLsb
                    // Tempcounter1 = delay before changing animation frame
                    // Tempcounter2 = number of animation frames left to do 
                    0D95: DD 35 10      dec  (ix+$10)            // decrement INFLIGHT_ALIEN.TempCounter1
                    0D98: C0            ret  nz
                    0D99: DD 36 10 04   ld   (ix+$10),$04        // reset INFLIGHT_ALIEN.TempCounter1
                    0D9D: DD 35 05      dec  (ix+$05)            // update INFLIGHT_ALIEN.AnimationFrame to rotate the alien left
                    0DA0: DD 35 11      dec  (ix+$11)            // decrement INFLIGHT_ALIEN.TempCounter2 
                    0DA3: C0            ret  nz                  // if we've not done all of the animation frames, exit

                    // OK, we've done all of the animation frames. The alien's ready to attack the player.
                    0DA4: DD 34 02      inc  (ix+$02)            // set stage of alien's life to INFLIGHT_ALIEN_READY_TO_ATTACK
                    0DA7: C9            ret

                    // alien that is leaving swarm to attack player is arcing up and right
                    // HL = pointer to table defining arc
                    // IX = pointer to INFLIGHT_ALIEN structure
                    0DA8: DD 7E 04      ld   a,(ix+$04)          // read INFLIGHT_ALIEN.Y 
                    0DAB: 96            sub  (hl)                // read Y delta from table and subtract from INFLIGHT_ALIEN.Y 
                    0DAC: DD 77 04      ld   (ix+$04),a          // update INFLIGHT_ALIEN.Y 
                    0DAF: C6 07         add  a,$07
                    0DB1: FE 0E         cp   $0E                 // is the alien off-screen?
                    0DB3: 38 17         jr   c,$0DCC             // if A < #$0E, its gone off screen, so make alien return to swarm from top of screen. 
                    0DB5: 2C            inc  l                   // bump HL to point to next X,Y coordinate pair in table
                    0DB6: DD 75 13      ld   (ix+$13),l          // and update INFLIGHT_ALIEN.ArcTableLsb
                    // Tempcounter1 = delay before changing animation frame
                    // Tempcounter2 = number of animation frames left to do 
                    0DB9: DD 35 10      dec  (ix+$10)            // decrement INFLIGHT_ALIEN.TempCounter1
                    0DBC: C0            ret  nz
                    0DBD: DD 36 10 04   ld   (ix+$10),$04        // reset INFLIGHT_ALIEN.TempCounter1
                    0DC1: DD 34 05      inc  (ix+$05)            // update INFLIGHT_ALIEN.AnimationFrame to rotate the alien right
                    0DC4: DD 35 11      dec  (ix+$11)            // decrement INFLIGHT_ALIEN.TempCounter2
                    0DC7: C0            ret  nz                  // if we've not done all of the animation frames, exit

                    // OK, we've done all of the animation frames. The alien's ready to attack the player.
                    0DC8: DD 34 02      inc  (ix+$02)            // move to next stage of alien's life
                    0DCB: C9            ret                 

                    // if we get here, an alien leaving the swarm has gone offscreen. It will return to the swarm from the top of the screen.
                    0DCC: DD 36 02 05   ld   (ix+$02),$05        // set INFLIGHT_ALIEN.StageOfLife 
                    0DD0: C9            ret



                    //
                    // An alien that has just completed an arc animation (see docs @ $0D71 and $101F) is now ready to attack the player. 
                    //
                    // Expects:
                    // IX = pointer to INFLIGHT_ALIEN that will attack
                    //

                    INFLIGHT_ALIEN_READY_TO_ATTACK:
                    0DD1: DD 34 03      inc  (ix+$03)            // increment INFLIGHT_ALIEN.X
                    0DD4: DD 7E 07      ld   a,(ix+$07)          // read INFLIGHT_ALIEN.IndexInSwarm
                    0DD7: E6 70         and  $70                 // keep the row, remove the column
                    0DD9: FE 60         cp   $60                 // is this a red alien?
                    0DDB: 28 43         jr   z,$0E20             // yes, goto $0E20

                    INFLIGHT_ALIEN_DEFINE_FLIGHTPATH:
                    0DDD: 3A 02 42      ld   a,($4202)           // read PLAYER_Y 
                    0DE0: 47            ld   b,a
                    0DE1: DD 7E 04      ld   a,(ix+$04)          // read INFLIGHT_ALIEN.Y 
                    0DE4: 90            sub  b                   // A = INFLIGHT_ALIEN.Y  - PLAYER_Y
                    0DE5: 38 28         jr   c,$0E0F             // if alien is to right of player, goto $0E0F

                    // alien is to left of player
                    // A = signed number representing distance in pixels between alien Y and player Y. 
                    0DE7: 1F            rra                      // divide distance by 2     
                    0DE8: C6 10         add  a,$10               // add $10 (16 decimal) to product
                    // clamp A between $30 and $70
                    0DEA: FE 30         cp   $30                 // compare to 48 (decimal)
                    0DEC: 30 02         jr   nc,$0DF0            // if A>=48 goto $0DF0
                    0DEE: 3E 30         ld   a,$30
                    0DF0: FE 70         cp   $70                 // compare to 112 (decimal)  NB: 112 is half the screen height in pixels
                    0DF2: 38 02         jr   c,$0DF6
                    0DF4: 3E 70         ld   a,$70

                    // PivotYValue is a Y coordinate to pivot around. You could think of it like the "origin" Y coordinate. 
                    // PivotYValueAdd is a delta (offset) to add to PivotYValue to produce the correct Y coordinate of the alien.
                    //
                    // PivotYValueAdd will increment if the player is to the left of the alien when it leaves the swarm,
                    // or decrement if the player is to the right. 

                    0DF6: DD 77 19      ld   (ix+$19),a          // set INFLIGHT_ALIEN.PivotYValueAdd
                    0DF9: DD 96 04      sub  (ix+$04)            // subtract INFLIGHT_ALIEN.Y 
                    0DFC: ED 44         neg
                    0DFE: DD 77 09      ld   (ix+$09),a          // set INFLIGHT_ALIEN.PivotYValue. Now PivotYValue + PivotYValueAdd = INFLIGHT_ALIEN.Y
                    0E01: AF            xor  a
                    0E02: DD 77 1A      ld   (ix+$1a),a
                    0E05: DD 77 1B      ld   (ix+$1b),a
                    0E08: DD 77 1C      ld   (ix+$1c),a

                    0E0B: DD 34 02      inc  (ix+$02)             // set stage of life to INFLIGHT_ALIEN_ATTACKING_PLAYER or INFLIGHT_ALIEN_ATTACKING_PLAYER_AGGRESSIVELY
                    0E0E: C9            ret

                    // alien is to right of player
                    // A = signed number representing distance in pixels between alien and player. 
                    0E0F: 1F            rra                       // perform a shift right, with sign bit preserved
                    0E10: D6 10         sub  $10
                    // clamp A between -48 and -112 decimal
                    0E12: FE D0         cp   $D0                  // compare to -48 (decimal)
                    0E14: 38 02         jr   c,$0E18
                    0E16: 3E D0         ld   a,$D0             
                    0E18: FE 90         cp   $90                  // compare to -112 (decimal)  NB: 112 is half the screen height in pixels
                    0E1A: 30 DA         jr   nc,$0DF6
                    0E1C: 3E 90         ld   a,$90
                    0E1E: 18 D6         jr   $0DF6


                    0E20: 3A D0 42      ld   a,($42D0)           // address of INFLIGHT_ALIENS[1].IsActive
                    0E23: 0F            rrca                     // move flag into carry
                    0E24: 30 B7         jr   nc,$0DDD            // if not set then we are not part of a convoy, goto INFLIGHT_ALIEN_DEFINE_FLIGHTPATH

                    // make the alien accompany the flagship as part of a convoy. The PivotYValueAdd of the alien is the same as the flagship,
                    // so it will fly the same path.
                    0E26: 3A E9 42      ld   a,($42E9)           // read flagship INFLIGHT_ALIENS[1].PivotYValueAdd  
                    0E29: 18 CB         jr   $0DF6


//
// This is probably the most important routine for the INFLIGHT_ALIEN. 
//
// It is responsible for making an INFLIGHT_ALIEN fly down the screen, dropping bombs when it can.
//
// Expects:
// IX = pointer to INFLIGHT_ALIEN structure
//

                  INFLIGHT_ALIEN_ATTACKING_PLAYER:
                  0E2B: DD 34 03      inc  (ix+$03)            // increment INFLIGHT_ALIEN.X 
                  0E2E: CD 6B 11      call $116B               // call UPDATE_INFLIGHT_ALIEN_YADD
                  0E31: DD 7E 09      ld   a,(ix+$09)          // load A with INFLIGHT_ALIEN.PivotYValue
                  0E34: DD 86 19      add  a,(ix+$19)          // add in INFLIGHT_ALIEN.PivotYValueAdd to produce a Y coordinate                                                   
                  0E37: DD 77 04      ld   (ix+$04),a          // write to INFLIGHT_ALIEN.Y 
                  0E3A: C6 07         add  a,$07
                  0E3C: FE 0E         cp   $0E
                0E3E: 38 24         jr   c,$0E64             // if the alien has gone off the side of the screen, return to swarm
                0E40: DD 7E 03      ld   a,(ix+$03)          // load A with INFLIGHT_ALIEN.X
                0E43: C6 48         add  a,$48
                0E45: 38 20         jr   c,$0E67             // if the alien is nearing the bottom of the screen, speed it up!
                0E47: 3A 00 42      ld   a,($4200)           // read HAS_PLAYER_SPAWNED
                0E4A: 0F            rrca                     // move flag into carry
                0E4B: D0            ret  nc                  // return if player has not spawned
                0E4C: CD B0 11      call $11B0               // call CALCULATE_INFLIGHT_ALIEN_LOOKAT_ANIM_FRAME

                  // alien won't shoot at you if a flagship has been hit
                  0E4F: 3A 2B 42      ld   a,($422B)           // read IS_FLAGSHIP_HIT
                  0E52: 0F            rrca                     // move flag into carry
                  0E53: D8            ret  c                   // return if flagship was hit

  // Can this alien start shooting at you?
  //
// code from $0E54-0E63 is akin to:
//
// byte yToCheck = INFLIGHT_ALIEN.X//
// for (byte l=0// l<INFLIGHT_ALIEN_SHOOT_RANGE_MUL//l++)
// {
//     if (yToCheck == INFLIGHT_ALIEN_SHOOT_EXACT_X)
//        goto TRY SPAWN_ENEMY_BULLET//
//     else
//        yToCheck+=0x19//
// }
//

            0E54: 2A 13 42      ld   hl,($4213)          // get INFLIGHT_ALIEN_SHOOT_EXACT_X into H and INFLIGHT_ALIEN_SHOOT_RANGE_MUL into L
            0E57: DD 7E 03      ld   a,(ix+$03)          // read INFLIGHT_ALIEN.X

            0E5A: BC            cp   h                   // compare A to INFLIGHT_ALIEN_SHOOT_EXACT_X 
            0E5B: CA E0 11      jp   z,$11E0             // if equal, jump to TRY_SPAWN_ENEMY_BULLET
            0E5E: C6 19         add  a,$19               // add $19 (25 decimal) to A
            0E60: 2D            dec  l                   // and try again...
            0E61: 20 F7         jr   nz,$0E5A            // until L is 0.
            0E63: C9            ret


            // If only one of these INCs are called (see $0E45), INFLIGHT_ALIEN.StageOfLife will be set to INFLIGHT_ALIEN_NEAR_BOTTOM_OF_SCREEN.
            // If both these INCs are called (see $0E3E), set INFLIGHT_ALIEN.StageOfLife to INFLIGHT_ALIEN_REACHED_BOTTOM_OF_SCREEN. 
            0E64: DD 34 02      inc  (ix+$02)      
            0E67: DD 34 02      inc  (ix+$02)
            0E6A: C9            ret


              //
              // When an alien is close to the horizontal plane where the player resides, it speeds up to zoom by (or into) the player.
              //
              // Expects:
              // IX = pointer to INFLIGHT_ALIEN structure
              //

              INFLIGHT_ALIEN_NEAR_BOTTOM_OF_SCREEN:
              0E6B: 3A 5F 42      ld   a,($425F)           // read TIMING_VARIABLE
              0E6E: E6 01         and  $01                 // ..now A is either 0 or 1.
              0E70: 3C            inc  a                   // ..now A is either 1 or 2. 
              0E71: DD 86 03      add  a,(ix+$03)          // Add either 1 or 2 pixels to INFLIGHT_ALIEN.X
              0E74: DD 77 03      ld   (ix+$03),a          // and update INFLIGHT_ALIEN.X
              0E77: D6 06         sub  $06
              0E79: FE 03         cp   $03                 // has alien gone off the bottom of the screen?
              0E7B: 38 18         jr   c,$0E95             // yes, goto $0E95

              0E7D: CD 6B 11      call $116B               // call UPDATE_INFLIGHT_ALIEN_YADD 
              0E80: DD 7E 19      ld   a,(ix+$19)          // read INFLIGHT_ALIEN.PivotYValueAdd        
              0E83: A7            and  a                   // set flags - we are interested if its a minus value
              0E84: FA 90 0E      jp   m,$0E90             // if the PivotYValueAdd is a negative value, goto $0E90

              0E87: DD 86 09      add  a,(ix+$09)          // add INFLIGHT_ALIEN.PivotYValue 
              0E8A: 38 09         jr   c,$0E95             // carry flag set if alien has gone off side of screen,  goto $0E95

              0E8C: DD 77 04      ld   (ix+$04),a          // set INFLIGHT_ALIEN.Y 
              0E8F: C9            ret

              0E90: DD 86 09      add  a,(ix+$09)          // add INFLIGHT_ALIEN.PivotYValue
              0E93: 38 F7         jr   c,$0E8C

              // alien's went off the bottom or the side of the screen. 
              0E95: DD 34 02      inc  (ix+$02)            // now call INFLIGHT_ALIEN_REACHED_BOTTOM_OF_SCREEN stage of life.
              0E98: C9            ret


//
// An inflight alien has flown past the player and left the bottom of the visible screen. 
// 
//
// If the alien is not a flagship, it will always return to the top of the screen.
// Then, its behaviour is determined by flag state:
// 
//    If the HAS_PLAYER_SPAWNED flag is clear, the alien will rejoin the swarm. 
//
//    If both of the HAVE_AGGRESSIVE_ALIENS and HAVE_NO_BLUE_OR_PURPLE_ALIENS flags are clear, 
//    the alien will rejoin the swarm.
//
//    Otherwise, if the criteria above is not satisfied, the alien will keep attacking the player.  
//    
//        
// If the alien is a flagship, then the rules described @ $0EDA (INFLIGHT_ALIEN_FLAGSHIP_REACHED_BOTTOM_OF_SCREEN) apply. 
//
// Expects:
// IX = pointer to INFLIGHT_ALIEN structure
//

              INFLIGHT_ALIEN_REACHED_BOTTOM_OF_SCREEN:
              0E99: DD 36 03 08   ld   (ix+$03),$08        // set INFLIGHT_ALIEN.X to position at very top of screen
              0E9D: DD 34 17      inc  (ix+$17)            // increment INFLIGHT_ALIEN.SortieCount
              0EA0: DD 36 05 00   ld   (ix+$05),$00        // clear INFLIGHT_ALIEN.AnimationFrame

              // what type of alien are we dealing with?
              0EA4: DD 7E 07      ld   a,(ix+$07)          // read INFLIGHT_ALIEN.IndexInSwarm  
              0EA7: E6 70         and  $70                 // remove the column number from the index, keep the row
              0EA9: FE 70         cp   $70                 // is this alien a flagship?
              0EAB: 28 2D         jr   z,$0EDA             // yes, goto INFLIGHT_ALIEN_FLAGSHIP_REACHED_BOTTOM_OF_SCREEN

              //if the player has not spawned, the alien will return to the swarm.
              0EAD: 3A 00 42      ld   a,($4200)           // read HAS_PLAYER_SPAWNED
              0EB0: 0F            rrca                     // move flag into carry
              0EB1: 30 23         jr   nc,$0ED6            // if player has not spawned yet, goto $0ED6 - aliens return to swarm

              //  if HAVE_AGGRESSIVE_ALIENS OR HAVE_NO_BLUE_OR_PURPLE_ALIENS flags are set, the alien will keep attacking (see $0EBF).
              //  otherwise the alien returns to the swarm (see $0ED3 and $0F07)
              0EB3: 3A 24 42      ld   a,($4224)           // read HAVE_AGGRESSIVE_ALIENS flag
              0EB6: A7            and  a                   // test flag
              0EB7: 20 06         jr   nz,$0EBF            // if aliens are aggressive, make alien reappear at top of screen, keep attacking 
              0EB9: 3A 21 42      ld   a,($4221)           // read HAVE_NO_BLUE_OR_PURPLE_ALIENS
              0EBC: A7            and  a                   // test flag             
              0EBD: 28 17         jr   z,$0ED6             // if we do have any blue or purple aliens, goto $0ED6 - aliens return to swarm

              // alien reappears at top of screen and will keep attacking - it will not return to swarm. 
              // add some unpredictability to where it reappears, so that player can't wait for it and shoot it easily
              0EBF: DD 7E 04      ld   a,(ix+$04)          // read INFLIGHT_ALIEN.Y 
              0EC2: 1F            rra                      // divide by 2 (don't worry about carry, it was cleared by AND above)
              0EC3: 4F            ld   c,a                 // preserve in C              
              0EC4: CD 3C 00      call $003C               // call GENERATE_RANDOM_NUMBER
              0EC7: E6 1F         and  $1F                 // ensure random number is between 0..31 decimal
              0EC9: 81            add  a,c                 
              0ECA: C6 20         add  a,$20               
              0ECC: DD 77 04      ld   (ix+$04),a          // set INFLIGHT_ALIEN.Y   
              0ECF: DD 36 10 28   ld   (ix+$10),$28        // set INFLIGHT_ALIEN.TempCounter1 for INFLIGHT_ALIEN_UNKNOWN_OF3C to use.

              // if both of these incs are called, the stage of life will be set to INFLIGHT_ALIEN_CONTINUING_ATTACK_RUN_FROM_TOP_OF_SCREEN. 
              // if only the inc @ $0ED6 is invoked (see $0EB1), then the stage of life will be set to INFLIGHT_ALIEN_RETURNING_TO_SWARM.
              0ED3: DD 34 02      inc  (ix+$02)            // increment INFLIGHT_ALIEN.StageOfLife
              0ED6: DD 34 02      inc  (ix+$02)            // increment INFLIGHT_ALIEN.StageOfLife
              0ED9: C9            ret


                    //
                    // A flagship has gone off screen.
                    //
                    // If the flagship had an escort, it will return to the top of the screen to fight again.
                    // If the flagship had no escort, it will flee the level. 
                    // A maximum of 2 fleeing flagships can be carried over to the next level.
                    //
                    // Expects:
                    // IX = pointer to INFLIGHT_ALIEN structure
                    //

                    INFLIGHT_ALIEN_FLAGSHIP_REACHED_BOTTOM_OF_SCREEN:
                    0EDA: 3A 2A 42      ld   a,($422A)           // read FLAGSHIP_ESCORT_COUNT
                    0EDD: A7            and  a                   // test if flagship actually had any escort!
                    0EDE: 20 12         jr   nz,$0EF2            // if flagship has escort, goto INFLIGHT_ALIEN_COUNT_FLAGSHIP_ESCORTS

                    // This flagship has no escort. It has escaped the level. 
                    // Deactivate the INFLIGHT_ALIEN record, and check if this flagship can be carried over to the next wave.
                    0EE0: DD 36 00 00   ld   (ix+$00),$00        // reset INFLIGHT_ALIEN.IsActive
                    0EE4: 3A 1E 42      ld   a,($421E)           // read FLAGSHIP_SURVIVOR_COUNT
                    0EE7: 3C            inc  a                   // add another one to the survivor count!
                    0EE8: FE 03         cp   $03                 // have we got 3 surviving flagships?
                    0EEA: 38 02         jr   c,$0EEE             // if we have less than 3, that's OK, goto $0EEE

                    // We seem to have 3 flagships but only 2 flagships are allowed to be carried over...
                    0EEC: 3E 02         ld   a,$02               // clamp surviving flagship count to 2.

                    0EEE: 32 1E 42      ld   ($421E),a           // set FLAGSHIP_SURVIVOR_COUNT
                    0EF1: C9            ret

                    // count how many aliens were escorting the flagship. 
                    INFLIGHT_ALIEN_COUNT_FLAGSHIP_ESCORTS:
                    0EF2: AF            xor  a
                    0EF3: DD CB 20 46   bit  0,(ix+$20)          // test IsActive flag of first escort  
                    0EF7: 28 01         jr   z,$0EFA             // 
                    0EF9: 3C            inc  a                   // increment escort count
                    0EFA: DD CB 40 46   bit  0,(ix+$40)          // test IsActive flag of second escort
                    0EFE: 28 01         jr   z,$0F01
                    0F00: 3C            inc  a                   // increment escort count
                    0F01: 32 2A 42      ld   ($422A),a           // set FLAGSHIP_ESCORT_COUNT
                    0F04: C3 AD 0E      jp   $0EAD               // make flagship reappear at top of screen



              //
              // An alien has either flown off the side or the bottom of the screen, and is returning to the swarm.
              // 
              // Expects:
              // IX = pointer to INFLIGHT_ALIEN structure           
              //

              INFLIGHT_ALIEN_RETURNING_TO_SWARM:
              0F07: DD 46 03      ld   b,(ix+$03)          // keep copy of INFLIGHT_ALIEN.X in B as SET_INFLIGHT_ALIEN_START_POSITION changes it 
              0F0A: 04            inc  b                   
              0F0B: CD 47 11      call $1147               // call SET_INFLIGHT_ALIEN_START_POSITION to determine where alien needs to go  

              // INFLIGHT_ALIEN.Y  and INFLIGHT_ALIEN.X have been changed by SET_INFLIGHT_ALIEN_START_POSITION
              0F0E: DD 7E 03      ld   a,(ix+$03)          // A = destination INFLIGHT_ALIEN.X
              0F11: DD 70 03      ld   (ix+$03),b          // restore INFLIGHT_ALIEN.X back to what it was before
              0F14: 90            sub  b                   // OK, how far away is this alien from where it wants to be?
              0F15: 28 14         jr   z,$0F2B             // distance is zero, it's got where it wants to be, goto INFLIGHT_ALIEN_BACK_IN_SWARM
              0F17: FE 19         cp   $19                 // 25 pixels away?
              0F19: D0            ret  nc                  // if distance is more than $19 (25 decimal), not near enough to destination, so exit
              0F1A: E6 01         and  $01                 // is distance an odd number?
              0F1C: C0            ret  nz                  // yes, so exit

              // Alien is less than 25 pixels away from its destination back in the swarm.
              // We now need to determine what way to rotate the sprite so that it returns to the swarm upside-down, bat-style. 
              0F1D: DD CB 06 46   bit  0,(ix+$06)          // read INFLIGHT_ALIEN.ArcClockwise
              0F21: 20 04         jr   nz,$0F27             

              0F23: DD 34 05      inc  (ix+$05)            // update INFLIGHT_ALIEN.AnimationFrame to rotate the alien right
              0F26: C9            ret

              0F27: DD 35 05      dec  (ix+$05)            // update INFLIGHT_ALIEN.AnimationFrame to rotate the alien left
              0F2A: C9            ret

              // alien has returned to swarm. Remove sprite and substitute sprite with characters.
              INFLIGHT_ALIEN_BACK_IN_SWARM:
              0F2B: DD 36 00 00   ld   (ix+$00),$00        // set INFLIGHT_ALIEN.IsActive to 0 - will hide sprite (see $0C98)
              0F2F: 26 41         ld   h,$41               // MSB of ALIEN_SWARM_FLAGS address 
              0F31: DD 6E 07      ld   l,(ix+$07)          // Now HL = pointer to address in ALIEN_SWARM_FLAGS where alien belongs
              0F34: 16 00         ld   d,$00               // command: DRAW_ALIEN_COMMAND
              0F36: 36 01         ld   (hl),$01            // mark flag in ALIEN_SWARM_FLAGS as "occupied". Our alien's back in the swarm!
              0F38: 5D            ld   e,l                 // E = index of alien in swarm
              0F39: C3 F2 08      jp   $08F2               // jump to QUEUE COMMAND. Alien will be drawn in its place in the swarm.


              //
            // Called when aliens are aggressive and refuse to return to the swarm.
            //
            // This routine makes the alien fly from the top of the screen for [TempCounter1] pixels vertically.
            // During this time it won't shoot, but it will gravitate towards the player's horizontal position (as the player sees it).
            // 
            // The trigger for this stage of life is when:
            //     HAVE_AGGRESSIVE_ALIENS is set OR 
            //     HAVE_NO_BLUE_OR_PURPLE_ALIENS flag is set 
            // 
            //

            INFLIGHT_ALIEN_CONTINUING_ATTACK_RUN_FROM_TOP_OF_SCREEN:
            0F3C: DD 34 03      inc  (ix+$03)            // increment INFLIGHT_ALIEN.X

            // 
            0F3F: 3A 02 42      ld   a,($4202)           // read PLAYER_Y      
            0F42: DD 96 04      sub  (ix+$04)            // subtract INFLIGHT_ALIEN.Y 

            0F45: ED 44         neg                      
            0F47: 17            rla                      // A = A * 2
            0F48: 5F            ld   e,a
            0F49: 9F            sbc  a,a                 // A= 0 - Carry flag
            0F4A: 57            ld   d,a
            0F4B: CB 13         rl   e
            0F4D: CB 12         rl   d                   // DE = DE * 2
            0F4F: DD 66 04      ld   h,(ix+$04)
            0F52: DD 6E 09      ld   l,(ix+$09)          // INFLIGHT_ALIEN.PivotYValue
            0F55: A7            and  a                   // Clear carry flag because..
            0F56: ED 52         sbc  hl,de               // ..there's no sub hl,de instruction in Z80 and we dont want a carry
            0F58: DD 74 04      ld   (ix+$04),h          // update INFLIGHT_ALIEN.Y 
            0F5B: DD 75 09      ld   (ix+$09),l          // update INFLIGHT_ALIEN.PivotYValue
            0F5E: DD 35 10      dec  (ix+$10)            // counter was set @ $0ECF
            0F61: C0            ret  nz

            0F62: DD 34 02      inc  (ix+$02)            // set INFLIGHT_ALIEN.StageOfLife to INFLIGHT_ALIEN_FULL_SPEED_CHARGE
            0F65: C9            ret



//
// The inflight alien is now going to fly at full speed and zigzag to make it harder to shoot. 
// It won't drop bombs, but it will gravitate towards the player.
//
// When the alien gets to the vertical (as the player sees it) centre of the screen, the alien will loop
// the loop if there's enough space to do so. 
//
// After the loop is complete, the alien will start shooting.
//

                INFLIGHT_ALIEN_FULL_SPEED_CHARGE:
                0F66: DD 34 03      inc  (ix+$03)            // increment INFLIGHT_ALIEN.X

                // first check the X coordinate to see if the alien is in the centre 
                0F69: DD 7E 03      ld   a,(ix+$03)          // read INFLIGHT_ALIEN.X 
                0F6C: D6 60         sub  $60                                         
                0F6E: FE 40         cp   $40
                0F70: 30 09         jr   nc,$0F7B            // if INFLIGHT_ALIEN.X-$60 >= $40, we're not centre horizontally   

                // next thing we need to do is check if we have enough space for a loop.
                0F72: DD 7E 04      ld   a,(ix+$04)          // read INFLIGHT_ALIEN.Y 
                0F75: D6 60         sub  $60
                0F77: FE 40         cp   $40
                0F79: 38 0C         jr   c,$0F87             // yes, we have space, make alien loop the loop

                // otherwise, make the alien veer erratically. 
                0F7B: CD DD 0D      call $0DDD               // call INFLIGHT_ALIEN_DEFINE_FLIGHTPATH
                0F7E: DD 36 18 03   ld   (ix+$18),$03        // set INFLIGHT_ALIEN.Speed to maximum!
                0F82: DD 36 10 64   ld   (ix+$10),$64        // set INFLIGHT_ALIEN.TempCounter1
                0F86: C9            ret
                                     
                 
                0F87: DD 34 02      inc  (ix+$02)
                0F8A: DD 34 02      inc  (ix+$02)            // set INFLIGHT_ALIEN.StageOfLife to INFLIGHT_ALIEN_LOOP_THE_LOOP 
                0F8D: DD 36 10 03   ld   (ix+$10),$03        // set INFLIGHT_ALIEN.TempCounter1 to delay before changing animation frame
                0F91: DD 36 11 0C   ld   (ix+$11),$0C        // set INFLIGHT_ALIEN.TempCounter2 to number of animation frames in total
                0F95: DD 36 05 00   ld   (ix+$05),$00        // set INFLIGHT_ALIEN.AnimationFrame
                0F99: DD 36 13 00   ld   (ix+$13),$00        // set INFLIGHT_ALIEN.ArcTableLsb 
                0F9D: 3A 02 42      ld   a,($4202)           // read PLAYER_Y 
                0FA0: DD 96 04      sub  (ix+$04)            // subtract INFLIGHT_ALIEN.Y 
                0FA3: 38 05         jr   c,$0FAA             // if player to right of alien, make alien loop the loop clockwise

                // alien will perform an anti-clockwise loop
                0FA5: DD 36 06 00   ld   (ix+$06),$00        // reset INFLIGHT_ALIEN.ArcClockwise
                0FA9: C9            ret

                0FAA: DD 36 06 01   ld   (ix+$06),$01        // set INFLIGHT_ALIEN.ArcClockwise 
                0FAE: C9            ret



              //
              // You've killed a lot of the alien's friends. It's going to keep coming after you until one of you dies.
              //
              //
              //

              INFLIGHT_ALIEN_ATTACKING_PLAYER_AGGRESSIVELY:
              0FAF: DD 34 03      inc  (ix+$03)            // increment INFLIGHT_ALIEN.X
              0FB2: CD 6B 11      call $116B               // call UPDATE_INFLIGHT_ALIEN_YADD
              0FB5: DD 7E 17      ld   a,(ix+$17)          // read INFLIGHT_ALIEN.SortieCount           
              0FB8: FE 04         cp   $04                 // has the alien made it past the player 4 times?
              0FBA: 28 48         jr   z,$1004             // yes, exactly 4 times, *maybe* make alien closer to player                                                                 
              0FBC: 30 4D         jr   nc,$100B            // more than 4 times, make aliens hug player closer 

              0FBE: DD 7E 09      ld   a,(ix+$09)          // INFLIGHT_ALIEN.PivotYValue
              0FC1: DD 86 19      add  a,(ix+$19)          // Add INFLIGHT_ALIEN.PivotYValueAdd 
              0FC4: DD 77 04      ld   (ix+$04),a          // set INFLIGHT_ALIEN.Y 

              // has alien wandered off left or right side of screen as player sees it?
              0FC7: C6 07         add  a,$07
              0FC9: FE 0E         cp   $0E
              0FCB: 38 29         jr   c,$0FF6             // alien has gone off side of screen, goto $0FF6

              // is alien near bottom of the screen?
              0FCD: DD 7E 03      ld   a,(ix+$03)          // read INFLIGHT_ALIEN.X
              0FD0: C6 40         add  a,$40               // 
              0FD2: 38 27         jr   c,$0FFB             // if adding $40 pixels to X gives a result >255, then alien is near bottom of screen, goto $0FFB
              0FD4: DD 35 10      dec  (ix+$10)
              0FD7: 28 27         jr   z,$1000
              0FD9: 3A 00 42      ld   a,($4200)           // read HAS_PLAYER_SPAWNED
              0FDC: 0F            rrca                     // move flag into carry
              0FDD: D0            ret  nc                  // return if player has not spawned
              0FDE: CD B0 11      call $11B0               // call CALCULATE_INFLIGHT_ALIEN_LOOKAT_ANIM_FRAME
              0FE1: 3A 2B 42      ld   a,($422B)           // read IS_FLAGSHIP_HIT
              0FE4: 0F            rrca                     // move flag into carry
              0FE5: D8            ret  c                   // return if flagship has been hit

              // OK, can this alien start firing at you? Exact duplicate of code @$0E54, look there for docs on how algorithm works. 
              0FE6: 2A 13 42      ld   hl,($4213)          // get INFLIGHT_ALIEN_SHOOT_EXACT_X into H and INFLIGHT_ALIEN_SHOOT_RANGE_MUL into L
              0FE9: DD 7E 03      ld   a,(ix+$03)          
              0FEC: BC            cp   h
              0FED: CA E0 11      jp   z,$11E0             // jump to TRY_SPAWN_ENEMY_BULLET
              0FF0: C6 19         add  a,$19
              0FF2: 2D            dec  l                   
              0FF3: 20 F7         jr   nz,$0FEC
              0FF5: C9            ret

              0FF6: DD 36 02 05   ld   (ix+$02),$05        // set INFLIGHT_ALIEN.StageOfLife to INFLIGHT_ALIEN_REACHED_BOTTOM_OF_SCREEN
              0FFA: C9            ret

              0FFB: DD 36 02 04   ld   (ix+$02),$04        // set INFLIGHT_ALIEN.StageOfLife to INFLIGHT_ALIEN_NEAR_BOTTOM_OF_SCREEN
              0FFF: C9            ret

              1000: DD 35 02      dec  (ix+$02)
              1003: C9            ret


              // If we get here, the alien has survived exactly 4 continuous sorties.     
              1004: 3A 5F 42      ld   a,($425F)           // read TIMING_VARIABLE
              1007: E6 01         and  $01                 // is the number odd?
              1009: 28 B3         jr   z,$0FBE             // no, the number's even, it's business as usual, goto $0FBE

              // If we get here, the alien is going to "hug" the player a little bit closer than he might like.
              // Note: This routine is *always* called if the alien survives 5 continuous sorties or more. 
              100B: 3A 02 42      ld   a,($4202)           // read PLAYER_Y 
              100E: DD 96 09      sub  (ix+$09)            // subtract INFLIGHT_ALIEN.PivotYValue
              1011: 38 06         jr   c,$1019             if a carry occurred, alien is, as player sees it, to left of player ship

              // Make the alien's pivot Y coordinate a bit closer to the player...
              1013: DD 34 09      inc  (ix+$09)            // Update INFLIGHT_ALIEN.PivotYValue
              1016: C3 BE 0F      jp   $0FBE

              1019: DD 35 09      dec  (ix+$09)            // Update INFLIGHT_ALIEN.PivotYValue
              101C: C3 BE 0F      jp   $0FBE



//
// Aggressive aliens sometimes do a 360 degree loop to taunt the player.
//
// This routine rotates the alien 270 degrees. The remaining 90 degrees is done by the INFLIGHT_ALIEN_FLIES_IN_ARC routine. 
//
// Expects:  
// IX = pointer to INFLIGHT_ALIEN structure
//

INFLIGHT_ALIEN_LOOP_THE_LOOP:
101F: DD 6E 13      ld   l,(ix+$13)          // load L with INFLIGHT_ALIEN.ArcTableLsb
1022: 26 1E         ld   h,$1E               // MSB of INFLIGHT_ALIEN_ARC_TABLE                 

// Now HL is a pointer to an entry in the INFLIGHT_ALIEN_ARC_TABLE (see docs @ $1E00)
1024: DD 7E 03      ld   a,(ix+$03)          // load INFLIGHT_ALIEN.X          
1027: 96            sub  (hl)                // subtract X component from table  
1028: DD 77 03      ld   (ix+$03),a

102B: 2C            inc  l

102C: DD CB 06 46   bit  0,(ix+$06)          // is this alien going to do a clockwise loop?
1030: 20 2E         jr   nz,$1060            // yes, goto INFLIGHT_ALIEN_LOOPING_CLOCKWISE

// Alien is performing a counter-clockwise loop-the-loop maneuvre
1032: DD 7E 04      ld   a,(ix+$04)          // read INFLIGHT_ALIEN.Y
1035: 96            sub  (hl)                // subtract Y component from INFLIGHT_ALIEN_ARC_TABLE
1036: DD 77 04      ld   (ix+$04),a          // set INFLIGHT_ALIEN.Y 
1039: 2C            inc  l                   // bump HL to point to next X,Y pair in INFLIGHT_ALIEN_ARC_TABLE
103A: DD 75 13      ld   (ix+$13),l          // set INFLIGHT_ALIEN.ArcTableLsb
103D: DD 35 10      dec  (ix+$10)            // decrement INFLIGHT_ALIEN.TempCounter1 
1040: C0            ret  nz

// When INFLIGHT_ALIEN.TempCounter1 counts down to zero, its time to change the animation frame
1041: DD 36 10 04   ld   (ix+$10),$04        // reset INFLIGHT_ALIEN.TempCounter1 
1045: DD 35 05      dec  (ix+$05)            // change sprite frame to appear to rotate LEFT

// INFLIGHT_ALIEN.TempCounter2 is used to count down number of animation frames left
1048: DD 35 11      dec  (ix+$11)            // decrement INFLIGHT_ALIEN.TempCounter2
104B: C0            ret  nz                  // return if we haven't done 

// we've done 270 degrees rotation, hand off the remaining 90 to the INFLIGHT_ALIEN_FLIES_IN_ARC 
104C: DD 34 02      inc  (ix+$02)            // bump INFLIGHT_ALIEN.StageOfLife to INFLIGHT_ALIEN_COMPLETE_LOOP
104F: DD 36 10 03   ld   (ix+$10),$03        // set INFLIGHT_ALIEN.TempCounter1 to delay before changing animation frame
1053: DD 36 11 0C   ld   (ix+$11),$0C        // set INFLIGHT_ALIEN.TempCounter2 to number of animation frames
1057: DD 36 05 0C   ld   (ix+$05),$0C        // set INFLIGHT_ALIEN.AnimationFrame
105B: DD 36 13 00   ld   (ix+$13),$00        // set INFLIGHT_ALIEN.ArcTableLsb
105F: C9            ret


// Alien is performing a clockwise loop-the-loop maneuvre
INFLIGHT_ALIEN_LOOPING_CLOCKWISE:
1060: DD 7E 04      ld   a,(ix+$04)          // read INFLIGHT_ALIEN.Y
1063: 86            add  a,(hl)              // add Y component from INFLIGHT_ALIEN_ARC_TABLE
1064: DD 77 04      ld   (ix+$04),a          // set INFLIGHT_ALIEN.Y
1067: 2C            inc  l                   // bump HL to point to next X,Y pair in INFLIGHT_ALIEN_ARC_TABLE
1068: DD 75 13      ld   (ix+$13),l          // set INFLIGHT_ALIEN.ArcTableLsb
106B: DD 35 10      dec  (ix+$10)
106E: C0            ret  nz

// When INFLIGHT_ALIEN.TempCounter1 counts down to zero, its time to change the animation frame
106F: DD 36 10 04   ld   (ix+$10),$04        reset INFLIGHT_ALIEN.TempCounter1 
1073: DD 34 05      inc  (ix+$05)            // change sprite frame to appear to rotate RIGHT
1076: DD 35 11      dec  (ix+$11)
1079: C0            ret  nz

// we've done 270 degrees rotation, hand off the remaining 90 to the INFLIGHT_ALIEN_FLIES_IN_ARC
107A: DD 34 02      inc  (ix+$02)            // bump INFLIGHT_ALIEN.StageOfLife to INFLIGHT_ALIEN_COMPLETE_LOOP
107D: DD 36 10 03   ld   (ix+$10),$03        // set INFLIGHT_ALIEN.TempCounter1 to delay before changing animation frame
1081: DD 36 11 0C   ld   (ix+$11),$0C        // set INFLIGHT_ALIEN.TempCounter2 to number of animation frames
1085: DD 36 05 F4   ld   (ix+$05),$F4        // set INFLIGHT_ALIEN.AnimationFrame
1089: DD 36 13 00   ld   (ix+$13),$00        // set INFLIGHT_ALIEN.ArcTableLsb
108D: C9            ret


INFLIGHT_ALIEN_COMPLETE_LOOP:
108E: C3 71 0D      jp   $0D71               // jump to INFLIGHT_ALIEN_FLIES_IN_ARC


INFLIGHT_ALIEN_UNKNOWN_1091:
1091: DD 34 03      inc  (ix+$03)            // update INFLIGHT_ALIEN.X
1094: DD 36 02 08   ld   (ix+$02),$08        // set INFLIGHT_ALIEN.StageOfLife to INFLIGHT_ALIEN_FULL_SPEED_CHARGE
1098: C3 7B 0F      jp   $0F7B               




                  //
                  // This routine helps move an attacking INFLIGHT_ALIEN.
                  //
                  // I'll be honest, I don't know exactly how it works. I've had the guys from my work (Lambo & Phil) look at this with me,
                  // and some of the guys from the https://www.facebook.com/groups/z80asm/ as well. When I figure it out, I'll document it.
                  //
                  // The key is in the mutation of IX+$19, INFLIGHT_ALIEN.PivotYValueAdd 
                  // 
                  // Expects:
                  // IX = pointer to INFLIGHT_ALIEN structure
                  // 

                  UPDATE_INFLIGHT_ALIEN_YADD:
                  116B: DD 7E 18      ld   a,(ix+$18)          // read INFLIGHT_ALIEN.Speed
                  116E: E6 03         and  $03                 
                  1170: 3C            inc  a                   // now A is between 1 and 4.
                  1171: 47            ld   b,a

                  1172: DD 66 19      ld   h,(ix+$19)          // read INFLIGHT_ALIEN.PivotYValueAdd
                  1175: DD 6E 1A      ld   l,(ix+$1a)
                  1178: DD 56 1B      ld   d,(ix+$1b)
                  117B: DD 5E 1C      ld   e,(ix+$1c)

                  117E: 7D            ld   a,l

                  // Part 1 - do H
                  117F: 4C            ld   c,h                 // preserve H in C
                  1180: 87            add  a,a           
                  1181: 30 01         jr   nc,$1184

                  1183: 25            dec  h
                  1184: 82            add  a,d
                  1185: 57            ld   d,a
                  1186: 3E 00         ld   a,$00
                  1188: 8C            adc  a,h

                  // I *think* this is to ensure that the signed byte in H never loses its sign.
                  // If it's positive it'll stay positive. If it's negative, it'll stay negative.
                  1189: FE 80         cp   $80                 
                  118B: 20 01         jr   nz,$118E

                  118D: 79            ld   a,c
                  118E: 67            ld   h,a

                  // Part 2 - now do L
                  118F: 4D            ld   c,l                 // preserve L in C  
                  1190: ED 44         neg
                  1192: 87            add  a,a
                  1193: 30 01         jr   nc,$1196

                  1195: 2D            dec  l

                  1196: 83            add  a,e
                  1197: 5F            ld   e,a
                  1198: 3E 00         ld   a,$00
                  119A: 8D            adc  a,l
                  119B: FE 80         cp   $80
                  119D: 20 01         jr   nz,$11A0

                  119F: 79            ld   a,c

                  11A0: 6F            ld   l,a                 // restore L from C

                  11A1: 10 DB         djnz $117E

                  11A3: DD 74 19      ld   (ix+$19),h
                  11A6: DD 75 1A      ld   (ix+$1a),l
                  11A9: DD 72 1B      ld   (ix+$1b),d
                  11AC: DD 73 1C      ld   (ix+$1c),e
                  11AF: C9            ret



                                    //
                  // Calculate the animation frame that makes an attacking alien "look" directly at the player. 
                  // 
                  // Expects:
                  // IX = pointer to INFLIGHT_ALIEN structure with valid X and Y fields.
                  //
                  // Returns:
                  //  INFLIGHT_ALIEN.AnimationFrame is updated
                  //

                  CALCULATE_INFLIGHT_ALIEN_LOOKAT_ANIM_FRAME:
                  11B0: 3E F0         ld   a,$F0               //  
                  11B2: DD 96 03      sub  (ix+$03)            // subtract from INFLIGHT_ALIEN.X
                  11B5: 57            ld   d,a
                  11B6: 3A 02 42      ld   a,($4202)           // read PLAYER_Y 
                  11B9: DD 96 04      sub  (ix+$04)            // subtract from INFLIGHT_ALIEN.Y 
                  11BC: 38 07         jr   c,$11C5             
                  11BE: CD D0 11      call $11D0
                  11C1: DD 77 05      ld   (ix+$05),a          // set INFLIGHT_ALIEN.AnimationFrame          
                  11C4: C9            ret

                  11C5: ED 44         neg
                  11C7: CD D0 11      call $11D0
                  11CA: ED 44         neg
                  11CC: DD 77 05      ld   (ix+$05),a          // set INFLIGHT_ALIEN.AnimationFrame
                  11CF: C9            ret


                  11D0: CD 48 00      call $0048               // call CALCULATE_TANGENT
                  11D3: 79            ld   a,c
                  11D4: A7            and  a
                  11D5: F2 DA 11      jp   p,$11DA
                  11D8: 3E 80         ld   a,$80
                  11DA: 07            rlca
                  11DB: 07            rlca
                  11DC: 07            rlca
                  11DD: E6 07         and  $07
                  11DF: C9            ret


                  //
                  // Try to spawn an enemy bullet. 
                  //
                  // Expects:
                  // IX = pointer to INFLIGHT_ALIEN struct
                  //
                  // Cheat:
                  // If you want to stop the aliens from firing, type the following into the MAME debugger:
                  // maincpu.mb@11E0 = C9 

                  TRY_SPAWN_ENEMY_BULLET:
                  11E0: 11 05 00      ld   de,$0005            // sizeof(ENEMY_BULLET)
                  11E3: 21 60 42      ld   hl,$4260            // load HL with address of ENEMY_BULLETS_START
                  11E6: 06 0E         ld   b,$0E               // there are 14 elements in the ENEMY_BULLETS_START array
                  11E8: CB 46         bit  0,(hl)              // test if bullet is active
                  11EA: 28 04         jr   z,$11F0             // if its not active, then we can use this slot to spawn an enemy bullet, goto $11F0
                  11EC: 19            add  hl,de               // otherwise bump HL to point to next enemy bullet in the array
                  11ED: 10 F9         djnz $11E8               // repeat until B==0
                  11EF: C9            ret


                //
                // Spawn an enemy bullet.
                //
                // Expects:
                // IX = pointer to INFLIGHT_ALIEN structure. Identifies the alien firing the bullet.
                // HL = pointer to ENEMY_BULLET structure. Contains info about the spawned bullet. 
                //

                SPAWN_ENEMY_BULLET:
                11F0: 36 01         ld   (hl),$01            // set ENEMY_BULLET.IsActive to 1 (true)
                11F2: 23            inc  hl                  // bump HL to point to ENEMY_BULLET.X
                11F3: DD 7E 03      ld   a,(ix+$03)          // read INFLIGHT_ALIEN.X coordinate
                11F6: 77            ld   (hl),a              // set X coordinate of bullet to be same as alien
                11F7: 3E F0         ld   a,$F0               // load A with -16 (decimal)
                11F9: 96            sub  (hl)                // A = X coordinate of bullet + 16 
                11FA: 57            ld   d,a
                11FB: 23            inc  hl
                11FC: 23            inc  hl                  // bump HL to point to ENEMY_BULLET.YH
                11FD: DD 7E 04      ld   a,(ix+$04)          // read INFLIGHT_ALIEN.Y  coordinate
                1200: 77            ld   (hl),a              // set Y coordinate of bullet to be same as alien


              1201: 23            inc  hl                  // bump HL to point to ENEMY_BULLET.YDelta
              1202: 3A 02 42      ld   a,($4202)           // read PLAYER_Y   
              1205: DD 96 04      sub  (ix+$04)            // subtract from INFLIGHT_ALIEN.Y  coordinate       
              1208: 38 05         jr   c,$120F             // 
              120A: CD 18 12      call $1218               // call COMPUTE_ENEMY_BULLET_DELTA
              120D: 77            ld   (hl),a              // set ENEMY_BULLET.YDelta 
              120E: C9            ret


              120F: ED 44         neg                      // A = Math.Abs(A)
              1211: CD 18 12      call $1218               // call COMPUTE_ENEMY_BULLET_DELTA
              1214: ED 44         neg                      // make bullet fly to right 
              1216: 77            ld   (hl),a              // set ENEMY_BULLET.YDelta 
              1217: C9            ret


              //
              // Unlike the player's bullet, enemy bullets don't always fly in a straight line. 
              //

              COMPUTE_ENEMY_BULLET_DELTA:
              1218: CD 48 00      call $0048               // call CALCULATE_TANGENT
              121B: CD 3C 00      call $003C               // call GENERATE_RANDOM_NUMBER
              121E: E6 1F         and  $1F                 // clamp number to 0..31 decimal
              1220: 81            add  a,c
              1221: C6 06         add  a,$06
              1223: F0            ret  p
              1224: 3E 7F         ld   a,$7F
              1226: C9            ret



                //
                // Try to send a single alien to attack the player.
                //
                // If we have flagships in the swarm, then only purple and blue aliens can be sent to attack by this routine.
                // If we have no flagships in the swarm, then red aliens can also be sent to attack. (See $13BD)
                //
                // Flagships and escorts are handled by HANDLE_FLAGSHIP_ATTACK.
                //
                //
                // Cheat (of a sort):
                // if you want to make this game very difficult, type the following into the MAME debugger: 
                // maincpu.mb@1359 = 8
                // maincpu.pb@421A = 7
                // maincpu.pb@421B = 7
                //

              HANDLE_SINGLE_ALIEN_ATTACK:
              1344: 3A 28 42      ld   a,($4228)           // read CAN_ALIEN_ATTACK flag
              1347: 0F            rrca                     // move flag into carry
              1348: D0            ret  nc                  // return if flag is not set
              1349: AF            xor  a
              134A: 32 28 42      ld   ($4228),a           // reset flag
              134D: 3A 20 42      ld   a,($4220)           // read HAVE_NO_ALIENS_IN_SWARM flag.
              1350: 0F            rrca                     // move flag into carry
              1351: D8            ret  c                   // return if no aliens are in the swarm.

            // The difficulty level specifies how many aliens can be attacking the player at one time.
            1352: 2A 1A 42      ld   hl,($421A)          // load H with DIFFICULTY_BASE_VALUE and L with DIFFICULTY_EXTRA_VALUE
            1355: 7C            ld   a,h                 // 
            1356: 85            add  a,l                 // add DIFFICULTY_EXTRA_VALUE to DIFFICULTY_BASE_VALUE 
            1357: 1F            rra                      // divide by 2.
            1358: FE 04         cp   $04                 // is result < 4?
            135A: 38 02         jr   c,$135E             // yes, goto $135E.
            135C: 3E 03         ld   a,$03               // Clamp maximum number of INFLIGHT_ALIEN slots to scan to 3.
            135E: 3C            inc  a                   // ensure that slots to scan is in range of 1..4

            // Scan a specified number of slots (up to 4) in the INFLIGHT_ALIENS array, starting from the *last* slot and working back.
            // Take the first slot that has clear IsActive and IsDying flags.
            // A = number of slots to scan
            135F: 47            ld   b,a                  // save number of slots to scan in B
            1360: 21 91 43      ld   hl,$4391             // point HL to last INFLIGHT_ALIEN.IsDying flag in INFLIGHT_ALIENS array
            1363: 11 E1 FF      ld   de,$FFE1             // load DE with -31, which is sizeof(INFLIGHT_ALIEN)-1
            1366: 7E            ld   a,(hl)               // read INFLIGHT_ALIEN.IsDying flag
            1367: 2B            dec  hl                   // bump HL to point to INFLIGHT_ALIEN.IsActive flag  
            1368: B6            or   (hl)                 // combine flags. We want A to be 0, to indicate INFLIGHT_ALIEN slot is not in use. 
            1369: 28 04         jr   z,$136F              // OK, we have an unused slot, goto $136F
            136B: 19            add  hl,de
            136C: 10 F8         djnz $1366                // repeat until we've scanned all the slots we're allowed to
            136E: C9            ret

          // If we get here, HL points to an unused INFLIGHT_ALIEN record that will be repurposed for our soon-to-be attacking alien. 
          // HL = pointer to unused INFLIGHT_ALIEN structure
          136F: E5            push hl
          1370: DD E1         pop  ix                   // IX = HL
          1372: 3A 15 42      ld   a,($4215)            // read ALIENS_ATTACK_FROM_RIGHT_FLANK flag
          1375: DD 77 06      ld   (ix+$06),a           // update INFLIGHT_ALIEN.ArcClockwise flag
          1378: A7            and  a                    // test if flag is set  
          1379: 20 30         jr   nz,$13AB             // if flag is set, goto FIND_FIRST_OCCUPIED_SWARM_COLUMN_START_FROM_RIGHT

          // If we get here, we want an alien to break off from the left flank of the swarm.
          // We now need to find an alien in the swarm able to attack the player. 
          // Find first occupied column of aliens starting from the leftmost column.
          FIND_FIRST_OCCUPIED_SWARM_COLUMN_START_FROM_LEFT:
          137B: 21 FC 41      ld   hl,$41FC             // address of flag for leftmost alien in ALIEN_IN_COLUMN_FLAGS 
          137E: 01 0A 00      ld   bc,$000A             // 10 aliens maximum on a row         
          1381: 3E 01         ld   a,$01                // we are scanning for a value of 1, meaning "column occupied"
          1383: ED B9         cpdr                      // scan $41FC down to $41F3 for value #$01. 
          1385: C0            ret  nz                   // if we have no aliens in the swarm (all flags are 0) - return
          1386: E0            ret  po                   // if BC has overflowed, return

          1387: 1E 3F         ld   e,$3F
          1389: 2C            inc  l                    // adjust L because CPDR will have decremented it one time too many 

          // HL now points to an entry in ALIEN_IN_COLUMN_FLAGS where we have an alien present.
          // If we have flagships in the swarm, then only purple and blue aliens can be sent to attack by this routine.
          // If we have no flagships in the swarm, then any remaining red aliens are also considered. (See $13BD)
          TRY_FIND_ALIEN_TO_ATTACK:
          138A: 3A EF 41      ld   a,($41EF)            // load a with HAVE_ALIENS_IN_TOP_ROW flag
          138D: 0F            rrca                      // move flag into carry
          138E: 30 2D         jr   nc,$13BD             // if no flagships in swarm, goto INIT_SCAN_FROM_RED_ALIEN_ROW

          // we have flagships, so send a purple or blue alien.
          INIT_SCAN_FROM_PURPLE_ALIEN_ROW:
          1390: 16 04         ld   d,$04                // number of rows to scan (1 purple + 3 blue)
          1392: 26 41         ld   h,$41                // MSB of ALIEN_SWARM_FLAGS address 
          1394: 7D            ld   a,l                  
          1395: E6 0F         and  $0F                  // A = index of column containing alien 
          1397: C6 50         add  a,$50                // effectively: HL = $4150 + (L & 0x0f)       
          1399: 6F            ld   l,a                  // HL now points to slot for purple alien in ALIEN_SWARM_FLAGS

        // HL now points to a slot in ALIEN_SWARM_FLAGS. D is a row counter.
        // If the slot is occupied, the occupying alien will be sent to attack the player.
        // If the slot is unoccupied, we'll scan the same column in the rows beneath until we find an occupied slot or we've done D rows.  
        // If we find an alien, we'll send it to attack the player.
        SCAN_SPECIFIC_COLUMN_FOR_D_ROWS:
        139A: 42            ld   b,d                  // set B to number of rows to scan
        139B: CB 46         bit  0,(hl)               // test for presence of alien in ALIEN_SWARM_FLAGS              
        139D: 20 2F         jr   nz,$13CE             // if there's an alien present, its "volunteered" to attack, goto $13CE 
        139F: 7D            ld   a,l                  
        13A0: D6 10         sub  $10                  // sizeof(row in ALIEN_SWARM_FLAGS)
        13A2: 6F            ld   l,a                  // bump HL to point to alien in row beneath
        13A3: 10 F6         djnz $139B                // repeat until B==0

        // OK, We've scanned the entire column and not found an alien. This means that ALIEN_IN_COLUMN_FLAGS isn't truthful,
        // and we need to resort to desperate measures. 
        // 
        // ** I've not seen this block of code called, and I think it might be legacy or debug **  
        //
        // Bump HL to point to the purple alien in the column to the right of the one we just scanned. We'll scan that column.  
        13A5: 83            add  a,e                  // add $3F to A.  
        13A6: 6F            ld   l,a                  // Now HL points to purple alien slot
        13A7: 0D            dec  c                    // decrement count of columns remaining that we *can* scan
        13A8: 20 F0         jr   nz,$139A             // if non-zero, repeat the column scan
        13AA: C9            ret


            // If we get here, we want an alien to break off from the right flank of the swarm.
            // We now need to find an alien in the swarm willing to attack the player. 
            // Find first occupied column of aliens starting from the rightmost column.
            FIND_FIRST_OCCUPIED_SWARM_COLUMN_START_FROM_RIGHT:
            13AB: 21 F3 41      ld   hl,$41F3            // address of flag for rightmost column of aliens 
            13AE: 01 0A 00      ld   bc,$000A            // 10 aliens maximum on a row  
            13B1: 3E 01         ld   a,$01               // we are scanning for a value of 1, meaning "column occupied"
            13B3: ED B1         cpir                     // scan $41F3 up to $41F3 for value #$01. 
            13B5: C0            ret  nz                  // if we have no aliens in the swarm - return
            13B6: E0            ret  po                  // if BC has overflowed, return

            // we've found an occupied column
            13B7: 1E 41         ld   e,$41
            13B9: 2D            dec  l
            13BA: C3 8A 13      jp   $138A               // jump to TRY_FIND_ALIEN_TO_ATTACK:


            // Called when no flagships present in flagship row. This means we can send any alien, including red, into the attack.
            INIT_SCAN_FROM_RED_ALIEN_ROW:
            13BD: 16 05         ld   d,$05                // number of rows of aliens to scan 
            13BF: 26 41         ld   h,$41                // MSB of ALIEN_SWARM_FLAGS address 
            13C1: 7D            ld   a,l
            13C2: E6 0F         and  $0F                  // A = index of column   
            13C4: C6 60         add  a,$60                // effectively: HL = $4150 + (L & 0x0f)
            13C6: 6F            ld   l,a                  // HL now points to slot for red alien in ALIEN_SWARM_FLAGS
            13C7: 7B            ld   a,e
            13C8: C6 10         add  a,$10
            13CA: 5F            ld   e,a
            13CB: C3 9A 13      jp   $139A                // jump to SCAN_SPECIFIC_COLUMN_FOR_D_ROWS


              //
              // Expects:
              // HL = pointer to occupied entry in ALIEN_SWARM_FLAGS
              // IX = pointer to vacant INFLIGHT_ALIEN structure
              //

              13CE: 36 00         ld   (hl),$00
              13D0: DD 75 07      ld   (ix+$07),l          // set INFLIGHT_ALIEN.IndexInSwarm
              13D3: DD 36 00 01   ld   (ix+$00),$01        // set INFLIGHT_ALIEN.IsActive 
              13D7: DD 36 02 00   ld   (ix+$02),$00        // set INFLIGHT_ALIEN.StageOfLife
              13DB: 16 01         ld   d,$01               // command: DELETE_ALIEN_COMMAND
              13DD: 5D            ld   e,l                 // parameter: index of alien in swarm
              13DE: C3 F2 08      jp   $08F2               // jump to QUEUE COMMAND



              //
              // Sets the flank that aliens, including flagships, will attack from.
              // 
              // If you replace $13F3-13F5, $13FF-1401, $1408-140A with zero (NOP), you can then tinker with the flag in $4215 and control 
              // what side the aliens attack from.
              //

              SET_ALIEN_ATTACK_FLANK:
              13E1: 2A 0E 42      ld   hl,($420E)          // read SWARM_SCROLL_VALUE
              13E4: ED 5B 10 42   ld   de,($4210)          // read SWARM_SCROLL_MAX_EXTENTS
              13E8: CB 7C         bit  7,h                 
              13EA: 28 0B         jr   z,$13F7

              13EC: 7D            ld   a,l
              13ED: 92            sub  d
              13EE: FE 1C         cp   $1C
              13F0: 30 11         jr   nc,$1403            // if A>$1C, attack from a random flank
              13F2: AF            xor  a
              13F3: 32 15 42      ld   ($4215),a           // reset ALIENS_ATTACK_FROM_RIGHT_FLANK flag. Aliens will now attack from left side of swarm.
              13F6: C9            ret

              13F7: 7B            ld   a,e
              13F8: 95            sub  l
              13F9: FE 1C         cp   $1C
              13FB: 30 06         jr   nc,$1403            // if A>$1C, attack from a random flank
              13FD: 3E 01         ld   a,$01
              13FF: 32 15 42      ld   ($4215),a           // set ALIENS_ATTACK_FROM_RIGHT_FLANK flag. Aliens will now attack from right side of swarm.
              1402: C9            ret

              // Attack from left or right flank, chosen at random
              1403: CD 3C 00      call $003C               // call GENERATE_RANDOM_NUMBER
              1406: E6 01         and  $01                 // mask in bit 0, so A is either 0 or 1
              1408: 32 15 42      ld   ($4215),a           // set/reset ALIENS_ATTACK_FROM_RIGHT_FLANK flag. 
              140B: C9            ret




            //
            // This routine checks if a flagship and escort can break from a given flank to attack the player.
            // 
            // The flank is determined by the ALIENS_ATTACK_FROM_RIGHT_FLANK flag ($4215).
            //
            // If a flagship exists on the specified flank, send the flagship to attack.  
            // If there's red aliens in *close proximity* to the flagship, send a maximum of 2 as an escort.
            //
            // If there are no flagships on the specified flank, try to send a single red alien from the flank instead.
            //
            // Notes:
            // A flagship can attack when:
            //     HAVE_NO_ALIENS_IN_SWARM is set to 0 AND
            //     HAS_PLAYER_SPAWNED is set to 1 AND
            //     The CAN_FLAGSHIP_OR_RED_ALIENS_ATTACK is set to 1 AND
            //     INFLIGHT_ALIENS[1] is available for use
            //
            //
            // Cheat:
            // If you type into the MAME debugger: 
            // maincpu.mb@140C=C9
            //
            // The flagships stop attacking you completely.
//

            HANDLE_FLAGSHIP_ATTACK:
              140C: 3A 20 42      ld   a,($4220)           // read HAVE_NO_ALIENS_IN_SWARM flag           
              140F: 0F            rrca                     // move flag into carry
              1410: D8            ret  c                   // return if no aliens in the swarm.
              1411: 3A 00 42      ld   a,($4200)           // read HAS_PLAYER_SPAWNED
              1414: 0F            rrca                     // move flag into carry
              1415: D0            ret  nc                  // return if player has not spawned.
              1416: 3A 29 42      ld   a,($4229)           // read CAN_FLAGSHIP_OR_RED_ALIENS_ATTACK
              1419: 0F            rrca                     // move flag into carry
              141A: D0            ret  nc                  // return if flag is not set
              141B: AF            xor  a
              141C: 32 29 42      ld   ($4229),a           // reset CAN_FLAGSHIP_OR_RED_ALIENS_ATTACK flag

              // Test if the slot in INFLIGHT_ALIENS reserved for the flagship is in use. If so - do nothing.
              141F: 2A D0 42      ld   hl,($42D0)          // read from INFLIGHT_ALIENS[1] which is the 2nd array element
              1422: 7C            ld   a,h                 // Load A with INFLIGHT_ALIEN.IsDying flag
              1423: B5            or   l                   // OR with INFLIGHT_ALIEN.IsActive flag
              1424: 0F            rrca                     // if alien is active or dying, carry will be set
              1425: D8            ret  c                   // return if alien is active or dying - the slot for the flagship is in use.

            // from what side should the flagship/red aliens attack from?
            1426: 3A 15 42      ld   a,($4215)           // read ALIENS_ATTACK_FROM_RIGHT_FLANK flag
            1429: 4F            ld   c,a                 // C is used to set INFLIGHT_ALIEN.ArcClockwise flag @ $1466
            142A: 0F            rrca                     // move flag into carry
            142B: DA BE 14      jp   c,$14BE             // if attacking from right flank, jump to TRY_FIND_FLAGSHIP_OR_RED_ALIEN_TO_ATTACK_FROM_RIGHT_FLANK


                  TRY_FIND_FLAGSHIP_OR_RED_ALIEN_TO_ATTACK_FROM_LEFT_FLANK:
                  142E: 21 79 41      ld   hl,$4179            // load HL with pointer to leftmost flagship in ALIEN_SWARM_FLAGS
                  1431: 06 04         ld   b,$04               // scan 4 slots max in the ALIEN_SWARM_FLAGS array to find a flagship
                  1433: CB 46         bit  0,(hl)              // test if a flagship is present
                  1435: 20 3B         jr   nz,$1472            // if we have found a flagship, goto INIT_FLAGSHIP_ATTACK_FROM_LEFT_FLANK
                  1437: 2D            dec  l                   // move to next potential flagship
                  1438: 10 F9         djnz $1433               // repeat until B==0

                  // If we can't get a flagship, then we scan the red alien row from left to right to find a red alien to attack.
                  143A: 2E 6A         ld   l,$6A               // load HL with pointer to leftmost red alien in ALIEN_SWARM_FLAGS
                  143C: 06 04         ld   b,$04               // scan first 4 red aliens 
                  143E: CB 46         bit  0,(hl)              // test if an alien is present
                  1440: 20 04         jr   nz,$1446            // if we have found a red alien, goto TRY_INIT_INFLIGHT_ALIEN
                  1442: 2D            dec  l                   // bump HL to point to slot of sibling alien
                  1443: 10 F9         djnz $143E               // repeat until B==0
                  1445: C9            ret

                      // 
                      // Scan the last 4 entries in the INFLIGHT_ALIENS array for an unused slot. 
                      // If all 4 slots at the end of the array are already in use, exit.
                      // Otherwise re-use the lastmost free slot for an attacking alien.
                      //
                      // Expects:
                      // HL = pointer to a bit flag in ALIEN_IN_SWARM_FLAGS
                      //

                      TRY_INIT_INFLIGHT_ALIEN:
                      1446: DD 21 90 43   ld   ix,$4390            // address of very last INFLIGHT_ALIEN record in INFLIGHT_ALIENS array 
                      144A: 11 E0 FF      ld   de,$FFE0            // -32 decimal, which is -sizeof(INFLIGHT_ALIEN)
                      144D: 06 04         ld   b,$04               
                      144F: DD 7E 00      ld   a,(ix+$00)          // load A with INFLIGHT_ALIEN.IsActive flag
                      1452: DD B6 01      or   (ix+$01)            // OR A with INFLIGHT_ALIEN.IsDying flag
                      1455: 28 05         jr   z,$145C             // if the slot is not used for an active or dying alien, goto INIT_INFLIGHT_ALIEN
                      1457: DD 19         add  ix,de               // subtract sizeof(INFLIGHT_ALIEN) from IX, to bump IX to previous INFLIGHT_ALIEN record
                      1459: 10 F4         djnz $144F
                      145B: C9            ret

                      //
                      // Remove an alien from the swarm, and create an inflight alien in its place.
                      // 
                      // Expects:
                      // C = direction alien will break away from swarm. 0 = left, 1 = right
                      // HL = pointer to entry in ALIEN_SWARM_FLAGS 
                      // IX = pointer to INFLIGHT_ALIEN struct of alien 
                      //

                      INIT_INFLIGHT_ALIEN:
                      145C: 36 00         ld   (hl),$00            // clear flag in ALIEN_SWARM_FLAGS - effectively removing it from swarm            
                      145E: DD 36 00 01   ld   (ix+$00),$01        // set INFLIGHT_ALIEN.IsActive
                      1462: DD 36 02 00   ld   (ix+$02),$00        // reset INFLIGHT_ALIEN.StageOfLife
                      1466: DD 71 06      ld   (ix+$06),c          // set INFLIGHT_ALIEN.ArcClockwise
                      1469: DD 75 07      ld   (ix+$07),l          // set INFLIGHT_ALIEN.IndexInSwarm
                      146C: 16 01         ld   d,$01               // command: DELETE_ALIEN_COMMAND
                      146E: 5D            ld   e,l                 // parameter: index of alien to delete from the swarm 
                      146F: C3 F2 08      jp   $08F2               // jump to QUEUE_COMMAND


//
// Given a pointer to a flagship entry in the ALIEN_SWARM_FLAGS array, 
// scan for red aliens in close proximity to the flagship that can be used as an escort.
// Initialise INFLIGHT_ALIEN records for the flagship and any escort as well. 
//
// Expects:
// HL = pointer to entry in flagship row of ALIEN_SWARM_FLAGS
//

                  INIT_FLAGSHIP_ATTACK_FROM_LEFT_FLANK:
                  1472: DD 21 D0 42   ld   ix,$42D0            // pointer to INFLIGHT_ALIENS_START+sizeof(INFLIGHT_ALIEN)
                  1476: CD 5C 14      call $145C               // call INIT_INFLIGHT_ALIEN to make flagship take flight and leave the swarm 
                  1479: 7D            ld   a,l
                  147A: D6 0F         sub  $0F     
                  147C: 6F            ld   l,a                 // bump HL to point at red alien directly below and to right of flagship
                  147D: FD 21 F0 42   ld   iy,$42F0            // pointer to INFLIGHT_ALIENS_START+(sizeof(INFLIGHT_ALIEN) * 2)
                  1481: 06 03         ld   b,$03               // we're scanning 3 entries in red aliens row max             
                  1483: 0E 02         ld   c,$02               // But we only want 2 red aliens as an escort.  
                  1485: CB 46         bit  0,(hl)              // test for presence of red alien
                  1487: C4 8E 14      call nz,$148E            // if we have a red alien, try to create an inflight alien  
                  148A: 2D            dec  l                   // bump HL to point to slot of sibling alien 
                  148B: 10 F8         djnz $1485               // repeat until B==0
                  148D: C9            ret

                  // HL = pointer to entry in ALIEN_SWARM_FLAGS
                  148E: CD 9B 14      call $149B               // call TRY_INIT_ESCORT_INFLIGHT_ALIEN
                  1491: 11 20 00      ld   de,$0020            // sizeof(INFLIGHT_ALIEN)
                  1494: FD 19         add  iy,de               // bump IY to point to next member of INFLIGHT_ALIENS array
                  1496: 0D            dec  c                   // reduce count of red aliens left to check for use as escort
                  1497: C0            ret  nz                  // return if we have all the escort we need
                  1498: 06 01         ld   b,$01
                  149A: C9            ret


//
              // Try to create an escort for a flagship. 
              //
              // Expects:
              // HL = pointer to red alien in ALIEN_SWARM_FLAGS that could be escort
              // IX = pointer to INFLIGHT_ALIEN structure (used for flagship)
              // IY = pointer to INFLIGHT_ALIEN structure (will be used for escort) 
              //
              // If the INFLIGHT_ALIEN pointed to by IY is not occupied by an active or dying alien, then
              // the record is re-used and marked as active. 
              // Otherwise this routine exits.

              TRY_INIT_ESCORT_INFLIGHT_ALIEN:
              149B: FD CB 00 46   bit  0,(iy+$00)          // test INFLIGHT_ALIEN.IsActive
              149F: C0            ret  nz                  // return if flag is set
              14A0: FD CB 01 46   bit  0,(iy+$01)          // test INFLIGHT_ALIEN.IsDying
              14A4: C0            ret  nz                  // return if flag is set

                  // OK, we can use the INFLIGHT_ALIEN slot at IY. Let's remove the alien from the swarm
                  // and create 
                  14A5: 36 00         ld   (hl),$00            // clear flag in ALIEN_SWARM_FLAGS
                  14A7: FD 36 00 01   ld   (iy+$00),$01        // set INFLIGHT_ALIEN.IsActive
                  14AB: FD 36 02 00   ld   (iy+$02),$00        // reset INFLIGHT_ALIEN.StageOfLife
                  14AF: DD 7E 06      ld   a,(ix+$06)          // read flagship's INFLIGHT_ALIEN.ArcClockwise
                  14B2: FD 77 06      ld   (iy+$06),a          // set escort INFLIGHT_ALIEN.ArcClockwise so it breaks away in formation.
                  14B5: FD 75 07      ld   (iy+$07),l          // set escort INFLIGHT_ALIEN.IndexInSwarm
                  14B8: 16 01         ld   d,$01               // command: DELETE_ALIEN_COMMAND
                  14BA: 5D            ld   e,l                 // parameter: index of alien to delete from the swarm
                  14BB: C3 F2 08      jp   $08F2               // jump to QUEUE_COMMAND


                      TRY_FIND_FLAGSHIP_OR_RED_ALIEN_TO_ATTACK_FROM_RIGHT_FLANK:
                      14BE: 21 76 41      ld   hl,$4176            // load HL with pointer to rightmost flagship in ALIEN_SWARM_FLAGS
                      14C1: 06 04         ld   b,$04               // scan max of 4 flagships in array
                      14C3: CB 46         bit  0,(hl)              // test if a flagship is present
                      14C5: 20 10         jr   nz,$14D7            // if we have found a flagship, goto INIT_FLAGSHIP_ATTACK_FROM_RIGHT_FLANK
                      14C7: 2C            inc  l                   // otherwise try looking for a flagship to immediate left
                      14C8: 10 F9         djnz $14C3               // repeat until B==0

                      // If we can't find a single flagship, then we try the red alien row. 
                      14CA: 2E 65         ld   l,$65               // load HL with pointer to rightmost red alien in ALIEN_SWARM_FLAGS array
                      14CC: 06 04         ld   b,$04               // scan max of 4 slots in array 
                      14CE: CB 46         bit  0,(hl)              // test if red alien is present
                      14D0: C2 46 14      jp   nz,$1446            // if we have found a red alien, goto $1446
                      14D3: 2C            inc  l                   // bump HL to point to slot of sibling alien
                      14D4: 10 F8         djnz $14CE               // repeat until B==0
                      14D6: C9            ret


                      // Near duplicate of INIT_FLAGSHIP_ATTACK_FROM_LEFT_FLANK @$1472, except for the right flank. 
                      //
                      // Given a pointer to a flagship entry in the ALIEN_SWARM_FLAGS array, 
                      // scan for red aliens in close proximity to the flagship that can be used as an escort.
                      // Initialise INFLIGHT_ALIEN records for the flagship and any escort as well. 
                      //
                      // Expects:
                      // HL = pointer to flag in ALIEN_SWARM_FLAGS representing flagship
                      //

                      INIT_FLAGSHIP_ATTACK_FROM_RIGHT_FLANK:
                      14D7: DD 21 D0 42   ld   ix,$42D0            // pointer to INFLIGHT_ALIENS_START+sizeof(INFLIGHT_ALIEN) 
                      14DB: CD 5C 14      call $145C               // Remove an alien from the swarm, and create an inflight alien in its place.
                      14DE: 7D            ld   a,l
                      14DF: D6 11         sub  $11                 // bump HL to point at red alien directly below and to right of flagship
                      14E1: 6F            ld   l,a                 
                      14E2: FD 21 F0 42   ld   iy,$42F0            // pointer to INFLIGHT_ALIENS_START+(sizeof(INFLIGHT_ALIEN) * 2)
                      14E6: 06 03         ld   b,$03
                      14E8: 0E 02         ld   c,$02
                      14EA: CB 46         bit  0,(hl)              // do we have a red alien?
                      14EC: C4 8E 14      call nz,$148E
                      14EF: 2C            inc  l
                      14F0: 10 F8         djnz $14EA
                      14F2: C9            ret



              //
              // Increase game difficulty as the level goes on.
              //

              HANDLE_LEVEL_DIFFICULTY:
              14F3: 3A 00 42      ld   a,($4200)           // read HAS_PLAYER_SPAWNED
              14F6: 0F            rrca                     // move flag into carry
              14F7: D0            ret  nc                  // return if player has not spawned
              14F8: 3A 2B 42      ld   a,($422B)           // read IS_FLAGSHIP_HIT
              14FB: 0F            rrca                     // move flag into carry
              14FC: D8            ret  c                   // return if flagship has been hit

              // wait until DIFFICULTY_COUNTER_1 counts down to zero.
              14FD: 21 18 42      ld   hl,$4218            // load HL with address of DIFFICULTY_COUNTER_1
              1500: 35            dec  (hl)                // decrement counter
              1501: C0            ret  nz
              1502: 36 3C         ld   (hl),$3C            // reset counter

              // DIFFICULTY_COUNTER_1 has reached zero and reset. Decrement DIFFICULTY_COUNTER_2.
              1504: 23            inc  hl                  // bump HL to DIFFICULTY_COUNTER_2
              1505: 35            dec  (hl)                // decrement counter
              1506: C0            ret  nz
              1507: 36 14         ld   (hl),$14            // reset counter 

              // DIFFICULTY_COUNTER_2 has reached zero. Now up the difficulty level, if we can.
              1509: 23            inc  hl                  // bump HL to $421A (DIFFICULTY_EXTRA_VALUE)
              150A: 7E            ld   a,(hl)              // read DIFFICULTY_EXTRA_VALUE
              150B: FE 07         cp   $07                 // has it reached its maximum value of 7?
              150D: C8            ret  z                   // return if so
              150E: 30 02         jr   nc,$1512            // if A >= 7 , goto $1512

              1510: 34            inc  (hl)                // increment DIFFICULTY_EXTRA_VALUE  
              1511: C9            ret

              1512: 36 07         ld   (hl),$07            // clamp DIFFICULTY_EXTRA_VALUE to 7
              1514: C9            ret


    //
    // Check if an alien can attack the player.
    // For flagships, see $15C3 
          //

          CHECK_IF_ALIEN_CAN_ATTACK:
          1515: 3A 00 42      ld   a,($4200)           // read HAS_PLAYER_SPAWNED
          1518: 0F            rrca                     // move flag into carry
          1519: D0            ret  nc                  // return if player has not spawned
          151A: 3A 20 42      ld   a,($4220)           // read HAVE_NO_ALIENS_IN_SWARM flag
          151D: 0F            rrca                     // move flag into carry
          151E: D8            ret  c                   // return if we don't have any aliens in the swarm
          151F: 3A 2B 42      ld   a,($422B)           // read IS_FLAGSHIP_HIT
          1522: 0F            rrca                     // move flag into carry
          1523: D8            ret  c                   // return if the flagship has been hit

          // Use DIFFICULTY_EXTRA_VALUE and DIFFICULTY_BASE_VALUE to calculate how many secondary counters in the ALIEN_ATTACK_COUNTERS array
          // we can decrement. The more counters = the higher probability one of them will count down to zero = higher probability an alien attacks.
          1524: 2A 1A 42      ld   hl,($421A)          // load H with DIFFICULTY_BASE_VALUE and L with DIFFICULTY_EXTRA_VALUE
          1527: 7C            ld   a,h                 // A = DIFFICULTY_BASE_VALUE value
          1528: FE 02         cp   $02
          152A: 30 01         jr   nc,$152D            // if DIFFICULTY_BASE_VALUE >=2, goto $152D
          152C: AF            xor  a
          152D: 85            add  a,l                 // Add DIFFICULTY_EXTRA_VALUE to DIFFICULTY_BASE_VALUE 
          152E: E6 0F         and  $0F                 // Ensure value is between 0 and 15
          1530: 3C            inc  a                   // Add 1 to ensure it's between 1..16 
          1531: 47            ld   b,a                 // B now contains number of counters to decrement

          // Decrement ALIEN_ATTACK_MASTER_COUNTER. When it hits zero, we can decrement secondary counters in the ALIEN_ATTACK_MASTER_COUNTERS array.
          1532: 21 4A 42      ld   hl,$424A            // load HL with address of ALIEN_ATTACK_MASTER_COUNTER
          1535: 11 E3 15      ld   de,$15E3            // load DE with address of ALIEN_ATTACK_COUNTER_DEFAULT_VALUES
          1538: 35            dec  (hl)                // decrement ALIEN_ATTACK_MASTER_COUNTER 
          1539: 28 05         jr   z,$1540             // if its hit zero, goto $1540 to decrement [B] counters 
          153B: AF            xor  a
          153C: 32 28 42      ld   ($4228),a           // reset CAN_ALIEN_ATTACK flag. No alien will attack.
          153F: C9            ret

          // When we get here, ALIEN_ATTACK_MASTER_COUNTER is zero. 
          // B specifies how many secondary counters in the ALIEN_ATTACK_COUNTERS array we can decrement. (Max value of 16)
          // DE points to a default value to reset the ALIEN_ATTACK_MASTER_COUNTER back to. 
          1540: 0E 00         ld   c,$00
          1542: 1A            ld   a,(de)              // read default value from table @ $15E3      
          1543: 77            ld   (hl),a              // Reset ALIEN_ATTACK_MASTER_COUNTER to its default value

          // Decrement B counters in the ALIEN_ATTACK_COUNTERS array. 
          // If any of the counters hit zero, reset the counter to its default value and set the CAN_ALIEN_ATTACK flag to 1.
          1544: 23            inc  hl                  // bump HL to next secondary counter 
          1545: 13            inc  de                  // bump DE to address containing default value to reset secondary counter to when zero 
          1546: 35            dec  (hl)                // decrement secondary counter  
          1547: CC DF 15      call z,$15DF             // if the secondary counter reaches zero, reset the counter and increment C. Alien will attack!
          154A: 10 F8         djnz $1544               // repeat until B==0

          // if C is set to a nonzero value then that means that a secondary counter has reached zero. Its time for an alien to attack. 
          154C: 79            ld   a,c
          154D: A7            and  a                   // test if A is zero 
          154E: C8            ret  z                   // exit if so
          154F: 3E 01         ld   a,$01 
          1551: 32 28 42      ld   ($4228),a           // set CAN_ALIEN_ATTACK flag. Alien will break off from the swarm
          1554: C9            ret



          // A= *DE//
          // *HL = A//
          // C++
          15DF: 1A            ld   a,(de)
          15E0: 77            ld   (hl),a
          15E1: 0C            inc  c
          15E2: C9            ret


          // Default values for the corresponding entries in the ALIEN_ATTACK_COUNTERS array.
          // e.g. $424A's default value is 5, $424B's default value is $2F, $424C's default is $43...
          // When any counter hits zero, it is reset to its default value.
          ALIEN_ATTACK_COUNTER_DEFAULT_VALUES: 
          15E3:  05 2F 43 77 71 6D 67 65 4F 49 43 3D 3B 35 2B 29


//
// This routine is responsible for determining when flagships can attack.
//
//

          UPDATE_ATTACK_COUNTERS:
          1555: 3A 00 42      ld   a,($4200)           // read HAS_PLAYER_SPAWNED
          1558: 0F            rrca                     // move flag into carry
          1559: D0            ret  nc                  // return if player has not spawned
          155A: 3A EF 41      ld   a,($41EF)           // read HAVE_ALIENS_IN_TOP_ROW 
          155D: 0F            rrca                     // move flag into carry
          155E: D0            ret  nc                  // return if we have no flagships
          155F: 3A 2B 42      ld   a,($422B)           // read IS_FLAGSHIP_HIT 
          1562: 0F            rrca                     // move flag into carry
          1563: D8            ret  c                   // return if a flagship has been hit
          1564: 3A 06 40      ld   a,($4006)           // read IS_GAME_IN_PLAY
          1567: 0F            rrca                     // move flag into carry
          1568: 30 3D         jr   nc,$15A7            // if game is not in play, goto $15A7      

          // wait until FLAGSHIP_ATTACK_MASTER_COUNTER_1 counts down to zero.
          156A: 21 45 42      ld   hl,$4245            // load HL with address of FLAGSHIP_ATTACK_MASTER_COUNTER_1
          156D: 35            dec  (hl)                // decrement counter
          156E: C0            ret  nz                  // exit if counter is not zero
          156F: 36 3C         ld   (hl),$3C            // reset counter

          // if we have no blue or purple aliens, we don't need to bother with the FLAGSHIP_ATTACK_MASTER_COUNTER_2 countdown. 
          1571: 3A 21 42      ld   a,($4221)           // read HAVE_NO_BLUE_OR_PURPLE_ALIENS 
          1574: 0F            rrca                     // move flag into carry
          1575: 38 2C         jr   c,$15A3             // if there's no blue or purple aliens left, goto $15A3

          ///
          15A3: 3E 02         ld   a,$02
          15A5: 18 ED         jr   $1594
          ///

          // otherwise, wait until FLAGSHIP_ATTACK_MASTER_COUNTER_2 counts down to 0.
          1577: 23            inc  hl                  // bump HL to FLAGSHIP_ATTACK_MASTER_COUNTER_2
          1578: 35            dec  (hl)                // decrement counter
          1579: C0            ret  nz                  // return if its not counteed down to zero.
          157A: 34            inc  (hl)                // set FLAGSHIP_ATTACK_MASTER_COUNTER_2 to 1

        // count how many "extra" flagships we have carried over from previous waves (maximum of 2)
        157B: 2A 77 41      ld   hl,($4177)          // point to usually empty flagship entry in ALIEN_SWARM_FLAGS. 
        157E: 7C            ld   a,h                 
        157F: 85            add  a,l                 // A now = number of *extra* flagships we have                 
        1580: E6 03         and  $03                 // ensure that number is between 0..3. (it should be between 0..2 anyway)
        1582: 4F            ld   c,a                 // save count of extra flagships in C

        // use difficulty settings and count of extra flagships to compute countdown before flagship attack
        1583: 2A 1A 42      ld   hl,($421A)          // load H with DIFFICULTY_BASE_VALUE and L with DIFFICULTY_EXTRA_VALUE
        1586: 7C            ld   a,h
        1587: 85            add  a,l                 // Add DIFFICULTY_BASE_VALUE to DIFFICULTY_EXTRA_VALUE
        1588: C8            ret  z                   // exit if both DIFFICULTY_BASE_VALUE and DIFFICULTY_EXTRA_VALUE are 0

        1589: 0F            rrca                     // divide A..                     
        158A: 0F            rrca                     // by 4
        158B: E6 03         and  $03                 // clamp A to 3 maximum.
        158D: 2F            cpl                      // A = 255-A.
        158E: C6 0A         add  a,$0A               // ensure that A is between $06 and $09
        1590: 91            sub  c                   // subtract count of extra flagships
        1591: 32 46 42      ld   ($4246),a           // set FLAGSHIP_ATTACK_MASTER_COUNTER_2

        // set timer for when flagship will definitely attack.
        1594: 07            rlca
        1595: 07            rlca
        1596: 32 2F 42      ld   ($422F),a           // set FLAGSHIP_ATTACK_SECONDARY_COUNTER

        1599: 07            rlca
        159A: 32 4A 42      ld   ($424A),a           // set ALIEN_ATTACK_MASTER_COUNTER

        // enable timer for flagship to attack.
        159D: 3E 01         ld   a,$01
        159F: 32 2E 42      ld   ($422E),a           // set ENABLE_FLAGSHIP_ATTACK_SECONDARY_COUNTER
        15A2: C9            ret




        // Called when game is not in play. // do we need this?
        15A7: 21 45 42      ld   hl,$4245            // load HL with address of FLAGSHIP_ATTACK_MASTER_COUNTER_1
        15AA: 35            dec  (hl)               
        15AB: C0            ret  nz
        15AC: 36 3C         ld   (hl),$3C 
        15AE: 23            inc  hl                  // load HL with address of FLAGSHIP_ATTACK_MASTER_COUNTER_2
        15AF: 35            dec  (hl)
        15B0: C0            ret  nz
        15B1: 36 05         ld   (hl),$05

        15B3: 3E 5A         ld   a,$5A
        15B5: 32 2F 42      ld   ($422F),a           // set FLAGSHIP_ATTACK_SECONDARY_COUNTER

        15B8: 3E 2D         ld   a,$2D
        15BA: 32 4A 42      ld   ($424A),a           // set ALIEN_ATTACK_MASTER_COUNTER

        15BD: 3E 01         ld   a,$01
        15BF: 32 2E 42      ld   ($422E),a           // set ENABLE_FLAGSHIP_ATTACK_SECONDARY_COUNTER
        15C2: C9            ret


//
// Determines if a flagship can be permitted to attack.
//
// If so, CAN_FLAGSHIP_OR_RED_ALIENS_ATTACK is set to 1.
//


            CHECK_IF_FLAGSHIP_CAN_ATTACK:
            15C3: 21 2E 42      ld   hl,$422E            // read ENABLE_FLAGSHIP_ATTACK_SECONDARY_COUNTER
            15C6: CB 46         bit  0,(hl)              // test flag
            15C8: C8            ret  z                   // return if not allowed to count down

            // wait until FLAGSHIP_ATTACK_SECONDARY_COUNTER counts down to zero.
            15C9: 23            inc  hl                  // bump HL to FLAGSHIP_ATTACK_SECONDARY_COUNTER
            15CA: 35            dec  (hl)                // decrement counter
            15CB: C0            ret  nz                  // return if counter hasn't reached zero

            15CC: 2B            dec  hl                  // bump HL to ENABLE_FLAGSHIP_ATTACK_SECONDARY_COUNTER flag 
            15CD: 36 00         ld   (hl),$00            // reset flag
            15CF: 3A 00 42      ld   a,($4200)           // read HAS_PLAYER_SPAWNED
            15D2: 0F            rrca                     // move flag into carry
            15D3: D0            ret  nc                  // return if player has not spawned

            // check if we have any flagship
            15D4: 3A EF 41      ld   a,($41EF)           // read HAVE_ALIENS_IN_TOP_ROW flag
            15D7: 0F            rrca                     // move flag bit into carry
            15D8: D0            ret  nc                  // return if no flagships

            // yes, we have flagships, set CAN_FLAGSHIP_OR_RED_ALIENS_ATTACK flag
            15D9: 3E 01         ld   a,$01
            15DB: 32 29 42      ld   ($4229),a           // set CAN_FLAGSHIP_OR_RED_ALIENS_ATTACK
            15DE: C9            ret





            //
            // This routine calculates how far away from the player inflight aliens can be before they can start shooting at you.
            // 
            // The minimum shooting distance increases as more aliens are killed, making the aliens shoot more often.
            //  
            // See also: $0E54

            HANDLE_CALC_INFLIGHT_ALIEN_SHOOTING_DISTANCE:
            15F4: 21 E8 41      ld   hl,$41E8            // load HL with address of HAVE_ALIENS_IN_ROW_FLAGS
            15F7: 06 04         ld   b,$04               // we're testing potentially 4 pairs of rows.
            15F9: 3A 1B 42      ld   a,($421B)           // read DIFFICULTY_BASE_VALUE
            15FC: A7            and  a                   // test if zero
            15FD: 20 16         jr   nz,$1615            // if non-zero, which it always is, goto $1615

            // These two lines of code appear never to be called. This must be for an EASY difficulty level we've not seen.
            15FF: 1E 01         ld   e,$01               // multiplier = 1
            1601: 16 84         ld   d,$84               // exact X coordinate  

            1603: CB 46         bit  0,(hl)              // test for alien presence
            1605: 20 09         jr   nz,$1610            // if alien is present, goto $1610

            1607: 23            inc  hl                  // bump HL to flag for next row 
            1608: CB 46         bit  0,(hl)              // test flag 
            160A: 20 04         jr   nz,$1610            // if flag is set, goto $1610

            160C: 23            inc  hl                  // bump to next entry in HAVE_ALIENS_IN_ROW_FLAGS
            160D: 1C            inc  e                   // increment multiplier (see $0E54 for clarification on how its used)
            160E: 10 F3         djnz $1603

            1610: ED 53 13 42   ld   ($4213),de          // set INFLIGHT_ALIEN_SHOOT_EXACT_X to D, INFLIGHT_ALIEN_SHOOT_RANGE_MUL to E
            1614: C9            ret

            1615: 1E 02         ld   e,$02               // multiplier = 2
            1617: 16 9D         ld   d,$9D               // exact X coordinate 
            1619: 18 E8         jr   $1603

            // TODO: I can't find anything calling this. Is this debug code left over?
            161B: 1E 03         ld   e,$03
            161D: 16 B6         ld   d,$B6
            161F: 18 E2         jr   $1603



                HANDLE_LEVEL_COMPLETE:
                1637: 21 22 42      ld   hl,$4222            // load HL with address of LEVEL_COMPLETE
                163A: CB 46         bit  0,(hl)              // test flag 
                163C: C8            ret  z                   // return if level is not complete

                // OK, level is complete. Wait until NEXT_LEVEL_DELAY_COUNTER to reach 0. 
                163D: 23            inc  hl                  // bump HL to point to NEXT_LEVEL_DELAY_COUNTER
                163E: 35            dec  (hl)                // decrement count
                163F: C0            ret  nz                  // return if count is !=0

                1640: 2B            dec  hl                  // bump HL to point to LEVEL_COMPLETE again.
                1641: 36 00         ld   (hl),$00            // clear LEVEL_COMPLETE flag.

                1643: 11 1B 05      ld   de,$051B            // load DE with address of PACKED_DEFAULT_SWARM_DEFINITION
                1646: CD 46 06      call $0646               // call UNPACK_ALIEN_SWARM 
                1649: AF            xor  a
                164A: 32 1A 42      ld   ($421A),a           // reset DIFFICULTY_EXTRA_VALUE
                164D: 32 5F 42      ld   ($425F),a           // reset TIMING_VARIABLE
                1650: 21 01 00      ld   hl,$0001
                1653: 22 0E 42      ld   ($420E),hl          // set SWARM_SCROLL_VALUE

                // increase game difficulty level, if we can.
                1656: 2A 1B 42      ld   hl,($421B)          // load H with PLAYER_LEVEL and L with DIFFICULTY_BASE_VALUE
                1659: 24            inc  h                   // increment player level 
                165A: 7D            ld   a,l                 // load A with DIFFICULTY_BASE_VALUE
                165B: FE 07         cp   $07                 // are we at max difficulty?
                165D: 28 03         jr   z,$1662             // yes, goto $1662
                165F: 30 22         jr   nc,$1683            // edge case: we're above max difficulty! So clamp difficulty level to 7.
                1661: 3C            inc  a                   // otherwise, increment DIFFICULTY_BASE_VALUE
                1662: 6F            ld   l,a
                1663: 22 1B 42      ld   ($421B),hl          // update PLAYER_LEVEL and DIFFICULTY_BASE_VALUE

                1666: 11 00 07      ld   de,$0700            // command: BOTTOM_OF_SCREEN_INFO_COMMAND, parameter: 0 (DISPLAY_LEVEL_FLAGS)
                1669: CD F2 08      call $08F2               // call QUEUE_COMMAND. 

                // How many flagships survived from the last round? If so, they need to be added into the swarm before the level starts.
                166C: 3A 1E 42      ld   a,($421E)           // get value of FLAGSHIP_SURVIVOR_COUNT into A
                166F: A7            and  a                   // Did any flagships survive from the last round?
                1670: C8            ret  z                   // Return if no flagships survived.
                1671: 21 77 41      ld   hl,$4177            // load HL with address of free slot in flagship row of ALIEN_SWARM_FLAGS
                1674: 36 01         ld   (hl),$01            // create a flagship!
                1676: 3D            dec  a                   //   
                1677: 32 1E 42      ld   ($421E),a           // set value of FLAGSHIP_SURVIVOR_COUNT
                167A: C8            ret  z                   // return if zero. 
                167B: 23            inc  hl                  // bump HL to address of next free slot in flagship row 
                167C: 36 01         ld   (hl),$01            // create a flagship!
                167E: AF            xor  a                
                167F: 32 1E 42      ld   ($421E),a           // clear value of FLAGSHIP_SURVIVOR_COUNT
                1682: C9            ret



                CLAMP_DIFFICULTY_LEVEL:
                1683: 3E 07         ld   a,$07               // maximum value for DIFFICULTY_BASE_VALUE
                1685: C3 62 16      jp   $1662               // set DIFFICULTY_BASE_VALUE 


//
// When you shoot a flagship, the swarm goes into shock for a short period of time. No aliens will break off to attack you.
//

              HANDLE_SHOCKED_SWARM:
              1688: 21 2B 42      ld   hl,$422B            // load HL with address of IS_FLAGSHIP_HIT flag     
              168B: CB 46         bit  0,(hl)              // test flag
              168D: C8            ret  z                   // return if flagship has not been hit
              168E: 3A 24 42      ld   a,($4224)           // read HAVE_AGGRESSIVE_ALIENS flag
              1691: A7            and  a                   // test flag
              1692: 20 0B         jr   nz,$169F            // if flag is set, goto $169F 
              1694: 3A 21 42      ld   a,($4221)           // read HAVE_NO_BLUE_OR_PURPLE_ALIENS
              1697: A7            and  a                   // test flag
              1698: 20 05         jr   nz,$169F            // if flag is set, goto $169F
              169A: 3A 26 42      ld   a,($4226)           // read HAVE_NO_INFLIGHT_ALIENS
              169D: 0F            rrca                     // move flag into carry
              169E: D0            ret  nc                  // return if some aliens are inflight
              169F: 23            inc  hl                  // bump HL to address of ALIENS_IN_SHOCK_COUNTER
              16A0: 35            dec  (hl)                // decrement counter. When it hits zero, aliens will snap out of it!
              16A1: C0            ret  nz                  // exit routine if counter non-zero
              16A2: 2B            dec  hl                  // bump HL to address of IS_FLAGSHIP_HIT
              16A3: 36 00         ld   (hl),$00            // clear flag. Aliens can break off from the swarm to attack again.
              16A5: C9            ret



                            //
              // You may have noticed that when you're close to obliterating the swarm, that the background swarm noises
              // get fewer and fewer, until there's no background noise, just the sound of attacking aliens and your bullets.
              // This is the routine that handles the background noises. But this isn't the most important thing the routine does. 
              // 
              // Tucked away here is more important code, which affects the aliens aggressiveness. If you have 3 aliens or less
              // in the swarm (inflight aliens don't count), the aliens are enraged and will be far more aggressive.
              // Any aliens that take flight to attack you (inflight aliens) will never return to the swarm and keep attacking
              // until either you or they are dead.
              //
              // If you wish to artificially enforce aggressiveness, pause the game and input the following into the MAME debugger:
              //
              // maincpu.mb@16e3=c9
              // maincpu.mb@16e7=c9
              // maincpu.pb@4224=1       // note the .pb, not .mb
              //
              // This will make the aliens attack you constantly - even when you start a new level.

                HANDLE_ALIEN_AGGRESSIVENESS:
                16B8: 3A 07 40      ld   a,($4007)           // read IS_GAME_OVER flag
                16BB: 0F            rrca                     // move flag into carry
                16BC: D8            ret  c                   // return if GAME OVER   
                16BD: 21 23 41      ld   hl,$4123            // load HL with address of very first alien in ALIEN_SWARM_FLAGS
                16C0: 11 06 00      ld   de,$0006            // DE is an offset to add to HL after processing a row of aliens
                16C3: 4B            ld   c,e                 // Conveniently, E is also number of rows of aliens in swarm! (6) 
                16C4: 3E 01         ld   a,$01               // A is going to be used to total the number of aliens in the swarm 
                16C6: 06 0A         ld   b,$0A               // 10 aliens maximum per row
                16C8: 86            add  a,(hl)              
                16C9: 2C            inc  l                   // bump HL to point to next alien in ALIEN_SWARM_FLAGS
                16CA: 10 FC         djnz $16C8               // repeat until all aliens in the row have been done
                16CC: 19            add  hl,de               // make HL point to first alien in row above 
                16CD: 0D            dec  c                   // do rows until C==0
                16CE: C2 C6 16      jp   nz,$16C6

                // When we get here, A = total number of aliens left alive in the swarm + 1
                16D1: 21 00 68      ld   hl,$6800            // load HL with address of !SOUND  reset background F1 port
                16D4: 06 03         ld   b,$03               // number of ports to write to maximum 
                16D6: 3D            dec  a                   // decrement total by 1 
                16D7: 28 14         jr   z,$16ED             // if total is zero, goto $16ED 

                // This piece of code writes 1 to !SOUND  reset background F1 to F3 
                16D9: 36 01         ld   (hl),$01            // 
                16DB: 2C            inc  l
                16DC: 10 F8         djnz $16D6

                16DE: FE 02         cp   $02                 //                  
                16E0: 38 05         jr   c,$16E7             // 
                16E2: AF            xor  a
                16E3: 32 24 42      ld   ($4224),a           // clear HAVE_AGGRESSIVE_ALIENS flag
                16E6: C9            ret

                // This piece of code is only called when there are 3 aliens or less in the swarm.
                // It makes the aliens extremely aggressive!
                16E7: 3E 01         ld   a,$01
                16E9: 32 24 42      ld   ($4224),a           // set HAVE_AGGRESSIVE_ALIENS flag
                16EC: C9            ret

                // This piece of code writes 0 to !SOUND  reset background F1 to F3
                16ED: 36 00         ld   (hl),$00
                16EF: 2C            inc  l
                16F0: 10 FB         djnz $16ED
                16F2: C3 DE 16      jp   $16DE





                  //
                  // Defines the arc to perform a loop the loop maneuvre. 
                  // Referenced by code @$0D71 and $101F.
                  //
                  // The table comprises byte pairs:
                  //   byte 0: signed offset to add to INFLIGHT_ALIEN.X
                  //   byte 1: unsigned offset to add to *or* subtract from (depends on which way alien is facing when it breaks off from swarm) INFLIGHT_ALIEN.Y 
                  //
                  INFLIGHT_ALIEN_ARC_TABLE:
                  1E00:  FF 00 FF 00 FF 00 FF 01 FF 00 FF 00 FF 01 FF 00  
                  1E10:  FF 01 FF 00 00 01 FF 00 FF 01 00 01 FF 00 00 01  
                  1E20:  FF 01 00 01 FF 01 00 01 00 01 FF 01 00 01 00 01  
                  1E30:  00 01 00 01 00 01 00 01 01 01 00 01 00 01 01 01  
                  1E40:  00 01 01 01 00 01 01 00 00 01 01 01 01 00 00 01  
                  1E50:  01 00 01 01 01 00 01 01 01 00 01 00 01 01 01 00  
                  1E60:  01 00 01 00 01 00 01                           

                  //
                  // GAME START tune. Referenced by $1756
                  //

                  1E68:  11 10 0F 0E 0D 0C 0B 0A 09 08 07 41 42 41 42 45  
                  1E78:  42 45 47 45 47 6A 60 41 42 41 42 45 42 45 47 45  
                  1E88:  47 6A 60 45 23 24 23 24 23 24 23 24 23 24 23 24  
                  1E98:  23 24 23 24 02 03 05 06 07 08 09 0A 02 03 05 06  
                  1EA8:  07 08 09 0A 02 03 05 06 07 08 09 0A 02 03 05 06  
                  1EB8:  07 08 09 0A E0 

                  //
                  // ALIEN DEATH sound effect. Referenced by $1833
                  //

                  1EBD:  08 07 06 05 03 02 08 07 06 05 03 02 02 03 05 06  
                  1ECD:  07 08 09 0A 0B 0C 0D 0E 0F 10 0F 0E 0D 0C 0B 0C  
                  1EDD:  0D E0 


                  //
                  // FLAGSHIP DEATH sound effect. Referenced by $1848
                  //

                  1EDF:  02 17 16 01 16 02 03 05 06 07 18 20 07 06 05 03  
                  1EEF:  02 03 06 07 08 09 0A 19 20 0A 09 08 07 08 0A 0B  
                  1EFF:  0C 0D 0E 1A 20 0E 0D 0C 0B 0A 0B 0D 0E 0F 10 11  
                  1F0F:  1B 3C E0 


                // Score values for aliens here....  see $21B1

                ALIEN_SCORE_TABLE:
                22D0: 
                30 00 00            // 30 PTS
                40 00 00            // 40 PTS
                50 00 00            // 50 PTS
                60 00 00            // 60 PTS
                70 00 00            // 70 PTS
                80 00 00            // 80 PTS
                00 01 00            // 100 PTS
                50 01 00            // 150 PTS
                00 02 00            // 200 PTS
                00 03 00            // 300 PTS
                00 08 00            // 800 PTS





