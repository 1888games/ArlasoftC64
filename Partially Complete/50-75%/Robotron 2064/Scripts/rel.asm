//
// Reverse engineering of Robotron 2084 Solid Blue Label by Scott Tunstall (Paisley, Scotland.)
//
// All questions, comments, corrections - please send to scott.tunstall@ntlworld.com
//
//


//
// Convention: where the term METADATA is used, that means "information about data". For example, the term "Animation Frame Metadata" means "information held about an animation frame", which is
// the animation frame's width, height, and pixel buffer pointer.
//

num_players_d EQU $0040
credits_d EQU $0051
JMP_PRINT_STRING_LARGE_FONT EQU $5F99
PRINT_STRING_LARGE_FONT EQU $6147
TEXT_FUNCTIONS EQU $61A2                     // changed from subs to functions 
TEXT_PTRS EQU $6291
COPY_NIB_XYB1 EQU $6F0C
def_wel_msg_ptr EQU $6F0F
COPY_NIB_XYB EQU $6F11
CLEAR_CMOS EQU $6F21
LOAD_CMOS_DEFS1 EQU $6F2C
LOAD_CMOS_DEFS2 EQU $6F3B
def_wel_msg EQU $6F65

ram_palette_start EQU $9800                  // read by the interrupt routine and used to set palette entries
ram_palette_end EQU $980F

???? EQU $9810 

object_metadata_list_pointer EQU $9811       // linked list of object metadata. see $D196
object_metadata_list_2_pointer EQU $9813     // second list of object metadata, used by enforcer, quark, spark and shell: begins at $A9E0. See $D6F0.
task_list_pointer EQU $9815                  // maintains a forward only linked list of tasks - see $D1E3

spheroids_enforcers_quarks_sparks_shells EQU $9817     // pointer to linked list of spheroids, enforcers, quarks, sparks and tankshells. 
???? EQU $9819
free_object_list_pointer EQU $981B                     // pointer to a linked list of object entries free to use.  
third_object_metadata_list_pointer EQU $981D           // pointer to a linked list of object metadata, used by progs and cruise missiles. Begins at $B0E8. See code at $D705
family_list_pointer EQU $981F                          // pointer to linked list of all family members
grunts_hulks_brains_progs_cruise_tanks EQU $9821       // pointer to linked list of grunts, hulks, brains, progs, cruise missiles and tanks 
electrode_list_pointer EQU $9823                       // pointer to linked list of all electrodes
???? EQU $9827

$982B and $982C are scratch variables, used for different purposes.

current_player EQU $983F                       // 1 = currently player one playing, 2 = currently player two playing
num_players EQU $9840                          // 1 = one player game, 2 = two player game
beam_counter EQU $9841                         // used to keep track of the vertical beam counter. 
???? EQU $9842
???? EQU $9844
rom_control_flag EQU $9845                     // used to keep track of rom_enable_scr_ctrl value.
extra_man_every EQU $9846                      // 16 bit BCD number. The table of preset values are below.  
                                               // Value in $9846      Value in $9847       Maps to "Game Adjustment |Bonus Life Every" setting 
                                               // ===================================================================================================
                                               // 00                  00                   No extra men 
                                               // 02                  00                   20000 Liberal
                                               // 02                  50                   25000 Recommended
                                               // 03                  00                   30000 Conservative
                                               // 05                  00                   50000 Extra Conservative  
                                               
player_collision_detection EQU $9848           // When set to 1, it means player collision detection routine is checking for 
collisions.

family_member_lookup_list EQU $9849            // not same as $981F. This field is a pointer to an entry in a quick lookup list used by hulks and brains to find family members to target.
                                               // the list starts at #$B354 and ends at #$B3A4 (50 bytes, 2 bytes per family member pointer, meaning can hold 25 family members max) 
bonus_credit_counter  EQU $984F                // used to keep track of coins inserted for "units required for bonus credit" setting in game adjustment screen
units_required_for_credit_counter EQU $9850    // used to keep track of coins inserted for "units required for credit" setting in game adjustment screen 
total_credits EQU $9851                        // number of credits in total. Includes unused credits from previous game sessions saved in CMOS.
???? EQU $9859                                 // This contains bit flags that appear to control rendering and disabling some game logic.
                                               // Bit 0 set:
                                               // Bit 1 set: 
                                               // Bit 2 set:
                                               // Bit 3 set: Do not re-draw spheroids, enforcers, sparks, tank shells (see $DCE7)
                                               // Bit 4 set: Do not re-draw player (see $DD3E)
                                               // Bit 5 set:
                                               // Bit 6 set:
                                               // Bit 7 set: Do not accept coins (see $2704)


player_object_start EQU $985A                  // start of player object in memory. 
player_animation_frame_metadata_pointer EQU $985C
player_blitter_destination $985E

player_x EQU $09864                            // X coordinate of player. #$4A = middle of screen, #$07 = as far as can go left, #$8C = as far as can go right of screen 
player_y EQU $09866                            // Y coordinate of player. #$7C = middle of screen, #$18 = as far as can go up, #$DF = as far as can go down
animation_index EQU $9870                      // index into current player animation (0-based) 

lasers_fired_by_player EQU $9887               // number of lasers fired by the player.  
laser_horizontal_direction EQU $9888           // used in collision detection routines. horizontal axis of the player's laser ($FF = left, 0 = none, $1 = right)
laser_vertical_direction EQU $9889             // used in collision detection routines. vertical axis of the player's laser ($FF = up, 0 = none, 1=down)
number_of_sparks_on_screen EQU $988A           // current number of enforcer missiles (sparks) on screen
grunt_list EQU $988B                           // linked list of grunts

number_of_family_members_saved EQU $988D       // number of family members saved this wave
number_of_cruise_missiles_on screen EQU $988E  // number of cruise missiles (missiles fired by brain) on screen
current_wall_colour EQU $988F                  // colour of the wall at edge of playfield
current_electrode_colour EQU $9890             // colour to draw electrodes in 
flattened_laser_colour EQU $9891               //     
number_of_electrodes EQU $9892                 // number of electrodes to draw (see $354B)
current_electrode_animation_frame_metadata EQU $9893     // pointer to animation metadata for electrode type 
brain_progging_flag EQU $9895                  // when non-zero it means brain is progging a human 

TODO: unknown_explosion_list EQU $9896         // see $5B6C
TODO: unknown_explosion_list EQU $9898         // see $5B84

explosion_list_pointer EQU $98A9               // pointer to a forward-only linked list of explosions
explosion_list_entry_pointer EQU $98AD         // pointer to first free explosion  


???_list_pointer EQU $98C0
text_colour EQU $98CF                          // colour to render text characters in. From Sean's site: colours are BB GGG RRR format.
odd_pixel_flag EQU $98D0                       // when rendering text characters, this flag is 1 when rendering needs to begin from on an odd numbered pixel. 0 otherwise. 
??? EQU $98D1                                  // TODO: font related
font_size EQU $98D2                            // 5 = small font. 7 = large font.
??? EQU $98D5                                  // TODO: font related
??? EQU $98D7                                  // TODO: font related
temp_enforcer_count EQU $98ED                  // number of enforcers currently on the screen
minute_timer EQU $98EE                         // This counter is used to determine when a minute elapses during the game. After every minute, the Play Time In Minutes bookkeeping item is updated in CMOS
tank_movement_delay EQU $98EF
EQU $98F0                                      // appears to be incremented each time the player score is updated (see $DB9E)
tank_shell_count EQU $98F1                     // number of tank shells currently on screen                     

??? EQU $98F4

// $B3A4 - $B3E3 reserved for use by electrodes

 

// $BDE4 is the start of the game state for player 1
p1_score EQU $BDE4                             // score is 4 bytes, stored as BCD. E.g. a score of 1,234,567 is stored as: 01 23 45 67
p1_next_free_man EQU $BDE8                     // score required to get a bonus life. Stored as same format as p1_score
p1_men EQU $BDEC
p1_wave EQU $BDED
 

// $BDEE - $BE71 is a snapshot of player 1's current wave state, e.g. how many grunts are on screen, how many spheroids, how many hulks etc. 
// This information is used to re-create the wave when the player dies or, if in a 2 player game, it's Player 1's turn. 
// When starting a new wave, this state is initialised by code @ $2B7C
//

p1_grunt_delay EQU $BDEE                
p1_grunt_delay_throttle EQU $BDEF                           // minimum value that grunt movement delay can be

// These variables are initialised by the code @ $2B0B
p1_grunts EQU $BDFA
p1_electrodes EQU $BDFB
p1_mommies EQU $BDFC
p1_daddies EQU $BDFD
p1_mikeys EQU $BDFE
p1_hulks EQU $BDFF
p1_brains EQU $BE00
p1_sphereoids EQU $BE01
p1_quarks EQU $BE02
p1_tanks EQU $BE03


// $BE20 is the start of the game state for player 2

p2_score EQU $BE20                           // score is 4 bytes, stored as BCD. E.g. a score of 1,234,567 is stored as: 01 23 45 67
p2_next_free_man EQU $BE24                   // score required to get a bonus life. Stored as same format as p2_score
p2_men EQU $BE28
p2_wave EQU $BE29
p2_grunts EQU $BE36
p2_electrodes EQU $BE37
p2_mommies EQU $BE38
p2_daddies EQU $BE39
p2_mikeys EQU $BE3A
p2_hulks EQU $BE3B
p2_brains EQU $BE3C
p2_sphereoids EQU $BE3D
p2_quarks EQU $BE3E
p2_tanks EQU $BE3F

// I've not applied labels to these guys because I'm not sure what to call them!
$BE5C - used by grunt AI to determine how often grunts move. See $39E6 . The lower the number the faster the grunts will go. This field is updated when grunts are killed, to make game faster - see $3A96.
$BE5D - used by grunt AI to throttle the delay of the grunts. This represents the lowest value that can go into $BE5C - see $3A9A. 
$BE5E - used by spheroid and quark initialisation routines when determining how many enforcers and tanks respectively to drop. See $1193 and $4B66
$BE5F - used by enforcer. This value is used to determine when an enforcer fires a spark. See $136D
$BE60 - used by sphereoid to determine delay before spawning enforcer. See $118B and $11F2 
$BE61 - used by hulk. This value is used to determine how fast a hulk moves (ie: how often its update routine is called) - the lower the faster - see $0098
$BE62 - used by brain. This value is used to determine how often to fire a cruise missile at the player. - the lower the more often - See $1B46
$BE63 - used by brain. This value is used to determine how fast a brain moves (ie: how often its update routine is called) - the lower the faster - see $1C9C
$BE64 - used by tank. This value is used to determine how often a tank can fire a shell. - the lower the more often - See $4D55
$BE65 - used by tank shell creation routine. From the logic I think this is an "accuracy" setting
$BE66 - used by quark logic. Maximum delay before a quark can spawn a tank. See $4B5E
$BE67 - used by quark logic for computing movement deltas. See $4B82

cur_grunts EQU $BE68
cur_electrodes EQU $BE69
cur_mommies EQU $BE6A
cur_daddies EQU $BE6B
cur_mikeys EQU $BE6C
cur_hulks EQU $BE6D
cur_brains EQU $BE6E                        
cur_sphereoids EQU $BE6F
cur_quarks EQU $BE70
cur_tanks EQU $BE71





ORG $0000

*** Robotron Blue Label
0000: 7E 01 6D    JMP   $016D           // initialise all hulks

0003: 7E 02 B2    JMP   $02B2           // initialise all family members

0006: 7E 00 9E    JMP   $009E           // ensure object stays in bounds

0009: 7E 03 51    JMP   $0351


// pointer to "1000" animation frame metadata - this is read by $1329 when drawing a spheroid's points value after its shot
000C: 04 85 

// pointer to animation frame metadata of mommy standing still, facing left
000E: 05 2F 

// pointer to animation frame metadata of daddy standing still, facing left
0010: 07 FF 

// pointer to animation frame metadata of mikey standing still, facing left
0012: 0B 3B 

// pointer to animation frame metadata of HULK standing still, facing left
0014: 0C F9 

0016: 01 CC 03 CF 04 37 
001C: D0 01 10 06 00 D0 03 04 17 00 E0 01 20 0D 00 E0 
002C: 01 18 

002E: 1A 00       ORCC  #$00



//
// Looks like this routine waits until some flags are cleared, and when they are the hulk can go stomping!
//
//

                            0030: 96 59       LDA   $59
                            0032: 85 7F       BITA  #$7F
                            0034: 27 08       BEQ   $003E               // if bits 0..6 are clear then go to the animate hulk routines
                            0036: 86 08       LDA   #$08                // delay before calling routine below
                            0038: 8E 00 30    LDX   #$0030              // address of routine to call
                            003B: 7E D0 66    JMP   $D066               // JMP $D1E3 - allocate task


                            ANIMATE_HULK:

                            003E: AE 47       LDX   $0007,U             // get pointer to hulk object

                            COMPUTE_HULK_ANIMATION_FRAME:
                            0040: 10 AE 4D    LDY   $000D,U             // get hulk animation table pointer (see $01CC for description of how it's laid out)
                            0043: A6 4B       LDA   $000B,U             // get animation index into A
                            0045: 31 A6       LEAY  A,Y                 // Y+= A. Now Y points to correct animation table entry.
                            0047: E6 A4       LDB   ,Y                  // get byte at Y into B. Now B is an offset to be added to $0CF9 (see $0054)
                            0049: 2A 04       BPL   $004F               // if bit 7 of the byte is not set, then we're not at the end of the animation sequence, goto $004F
                            004B: 6F 4B       CLR   $000B,U             // bit 7 is set, so at end of animation. Set index to 0, to start the animation off again
                            004D: 20 F1       BRA   $0040

                            004F: 8B 03       ADDA  #$03                // add 3 to bump to next entry in animation table.
                            0051: A7 4B       STA   $000B,U             // set animation index to A
                            0053: 4F          CLRA                      // clear A as we don't want it affecting calculation below
                            0054: C3 0C F9    ADDD  #$0CF9              // #$0CF9 + B to give pointer to the animation frame metadata for correct hulk animation frame
                            0057: ED 02       STD   $0002,X             // store D in animation frame metadata pointer.
                            0059: A6 21       LDA   $0001,Y             // read X delta of animation table entry
                            005B: 5F          CLRB  
                            005C: 47          ASRA                      // move bit 0 of A into carry, while preserving bit 7 (thus retaining sign bit)  
                            005D: 56          RORB                      // and move carry into most significant bit of B. Now A = whole part of delta, B = fractional part
                            005E: E3 0A       ADDD  $000A,X             // add to hulk's X coordinate
                            0060: 34 06       PSHS  B,A                 // save D (computed new X coordinate) on stack
                            0062: E6 22       LDB   $0002,Y             // read Y delta of animation table entry
                            0064: EB 0C       ADDB  $000C,X             // add to hulk's Y coordinate
                            0066: 8D 36       BSR   $009E               // ensure computed X and Y coordinates are in bounds
                            0068: 27 04       BEQ   $006E               // if components are in bounds, update actual X and Y coordinates 
                            006A: 32 62       LEAS  $0002,S             // discard B and A pushed on the stack @ $0060
                            006C: 20 22       BRA   $0090

                            006E: E7 0C       STB   $000C,X             // update Y coordinate of hulk
                            0070: 35 06       PULS  A,B                 // restore computed new X coordinate from stack (see $0060)
                            0072: ED 0A       STD   $000A,X             // and store in X coordinate of hulk
                            0074: E6 0C       LDB   $000C,X             // B = Y coordinate of hulk
                            0076: EE 02       LDU   $0002,X             // get animation frame metadata pointer into U
                            0078: 8E 98 23    LDX   #$9823              // pointer to linked list of electrodes (hulks stomp electrodes)
                            007B: 34 46       PSHS  U,B,A
                            007D: BD D0 27    JSR   $D027               // JMP $D7C9 - collision detection function
                            0080: 35 46       PULS  A,B,U
                            0082: 8E 98 1F    LDX   #$981F              // pointer to linked list of family members (hulks kill family members)
                            0085: BD D0 27    JSR   $D027               // JMP $D7C9 - collision detection function
                            0088: DE 15       LDU   $15
                            008A: AE 47       LDX   $0007,U             // get pointer to hulk object into X
                            008C: 6A 4C       DEC   $000C,U             // decrement hulk move counter
                            008E: 26 02       BNE   $0092               // if hulk move counter !=0 goto $0092
                            0090: 8D 74       BSR   $0106               // change direction
                            0092: BD D0 8D    JSR   $D08D               // JMP $DB2F - erase then re-blit object 
                            0095: 8E 00 3E    LDX   #$003E              // address of function to call
                            0098: B6 BE 61    LDA   $BE61               // get counter to say how long it will be before this routine is called again (to speed up hulk movement as wave progresses.)
                            009B: 7E D0 66    JMP   $D066               // JMP $D1E3 - allocate task


                            // Ensure an object is within bounds of the playfield
                            //
                            // A = X coordinate of where object would *like* to move to
                            // B = Y coordinate of where object would *like* to move to
                            // X = object pointer
                            //
                            // Returns:
                            // Zero flag set if object coordinates in A & B are valid
                            //

                            ENSURE_OBJECT_IN_BOUNDS:
                            009E: 34 06       PSHS  B,A
                            00A0: 81 07       CMPA  #$07                // X < 7?
                            00A2: 25 10       BCS   $00B4               // yes, goto $00B4             
                            00A4: C1 18       CMPB  #$18                // Y < #$18?
                            00A6: 25 0C       BCS   $00B4               // yes, goto $00B4 
                            00A8: E3 98 02    ADDD  [$02,X]             // add in width in bytes and height in pixels of the object
                            00AB: 81 8F       CMPA  #$8F                // X+width in bytes > #$8F ?
                            00AD: 22 05       BHI   $00B4               // yes, so leave routine
                            00AF: C1 EA       CMPB  #$EA                // Y+height in pixels > $#EA ?
                            00B1: 22 01       BHI   $00B4               // yes, so leave routine
                            00B3: 4F          CLRA                      // otherwise set zero flag (A is restored by next instruction)
                            00B4: 35 86       PULS  A,B,PC //(PUL? PC=RTS)   


                            //
                            // Make the hulk react to being hit by player bullets
                            //

                            HULK_BULLET_COLLISION_HANDLER:
                            00B6: 96 48       LDA   $48                 // player collision detection? 
                            00B8: 26 49       BNE   $0103               // yes
                            00BA: 96 88       LDA   $88                 // A = bullet X delta
                            00BC: 5F          CLRB  
                            00BD: 0D 84       TST   $84                 // read random number variable
                            00BF: 2B 01       BMI   $00C2               // if bit 7 set, go to $00C2
                            00C1: 48          ASLA                      // A *= 2 (double the impact of the bullet on the X axis)
                            00C2: E3 0A       ADDD  $000A,X             // D+= hulk X coordinate
                            00C4: 34 06       PSHS  B,A                 // save D (computed new X coordinate) on the stack for later (see 00DD)
                            00C6: D6 89       LDB   $89                 // B = bullet Y delta
                            00C8: 96 86       LDA   $86                 // read random number variable
                            00CA: 81 C0       CMPA  #$C0                // if > #$C0
                            00CC: 24 01       BCC   $00CF               // jump to $CF
                            00CE: 58          ASLB                      // else double the impact of the bullet on the Y axis
                            00CF: EB 0C       ADDB  $000C,X             // B+= hulk Y coordinate
                            00D1: A6 E4       LDA   ,S                  // A = hulk computed new X coordinate from stack
                            00D3: 8D C9       BSR   $009E               // ensure hulk X and Y are within boundaries 
                            00D5: 27 04       BEQ   $00DB               // if in boundaries, go to $00DB
                            00D7: 32 62       LEAS  $0002,S             // adjust stack pointer to discard X and Y coordinates pushed earlier 
                            00D9: 20 21       BRA   $00FC               // and finish processing hulk

                            // hulk's new position has been validated, so update object's X and Y coordinates
                            00DB: E7 0C       STB   $000C,X             // hulk Y coordinate = B
                            00DD: 35 06       PULS  A,B                 // restore D
                            00DF: ED 0A       STD   $000A,X             // hulk X coordinate = D
                            00E1: E6 0C       LDB   $000C,X             // get hulk Y coordinate into B
                            00E3: EE 02       LDU   $0002,X             // get current animation frame metadata pointer
                            00E5: 34 10       PSHS  X
                            00E7: 8E 98 23    LDX   #$9823              // start of linked list for electrodes
                            00EA: 34 46       PSHS  U,B,A
                            00EC: BD D0 27    JSR   $D027               // JMP $D7C9 - collision detection function
                            00EF: 35 46       PULS  A,B,U
                            00F1: 8E 98 1F    LDX   #$981F              // start of linked list for family members
                            00F4: BD D0 27    JSR   $D027               // JMP $D7C9 - collision detection function
                            00F7: 35 10       PULS  X
                            00F9: BD D0 8D    JSR   $D08D               //  - draw object
                            00FC: CC 00 1C    LDD   #$001C
                            00FF: BD D0 4B    JSR   $D04B               // JMP $D3C7 - play sound with priority
                            0102: 39          RTS   

                            0103: 7E D0 18    JMP   $D018               // JMP $DAF2 - blit object




                    //
                    // if the hulk is moving horizontally, make it move vertically, and vice versa.
                    // hulk gravitates towards its "target" but sometimes its target doesn't actually exist as an on-screen object.
                    //
                    //
                    // X = pointer to hulk object
                    // U = pointer to hulk metadata 
                    //

                    HULK_CHANGE_DIRECTION:
                    0106: 96 86       LDA   $86                 // get a random number
                    0108: 84 1F       ANDA  #$1F                // mask with #$1F (so that number lays in 0..31 decimal)
                    010A: 4C          INCA                      // add 1 to it (to ensure its nonzero)
                    010B: A7 4C       STA   $000C,U             // set in "move count" variable

                    // LDY [$09,U] gets a pointer to the target object in the object metadata linked list.  
                    // An interesting bug: this instruction is supposed to return an active object but there are times when a hulk is created and there's nothing 
                    // else on screen yet. As a result *(U + 9) computes to WORD 0 (which I call NULL) and the contents of memory addresses $0000 and $0001 are read into Y. 
                    // You get Y=7E 01. Go look at ORG $0000 and see for yourself...
                    //
                    // Now, $7E01 certainly does not point to any real object, so the hulk ends up going on a wild goose chase, chasing an object that does not exist. 
                    // This probably explains why hulks wander off doing their own thing and getting stuck in the corner at times.
                    //

                    010D: 10 AE D8 09 LDY   [$09,U]              // get pointer to target object to stalk            
                    0111: 26 04       BNE   $0117                // if not NULL goto $117
                    0113: 10 8E 98 5A LDY   #$985A               // player_object_start. Looks like we're wanting to make the hulk stalk the player
                    0117: EC 4D       LDD   $000D,U              // get hulk animation table pointer (see $01CC for description of how it's laid out)
                    0119: 10 83 01 CC CMPD  #$01CC               // is the hulk moving left? 
                    011D: 27 26       BEQ   $0145                // yes, so this time we want to make the hulk move vertically
                    011F: 10 83 01 D9 CMPD  #$01D9               // is the hulk moving right?
                    0123: 27 20       BEQ   $0145                // yes, so this time we want to make the hulk move vertically

                    //
                    // Compute an X coordinate to move to, which in this case is (target X coordinate -15) .. (target X coordinate +15)
                    // where target can be player or family member, or even invalid object (see comments at $10D above) causing unpredictable hulk behaviour.
                    //

                    HULK_MOVE_HORIZONTALLY:
                    0125: 96 84       LDA   $84                  // get a random number
                    0127: 84 1F       ANDA  #$1F                 // mask in lower 5 bits (to give a number between 0..31 decimal)
                    0129: 8B F0       ADDA  #$F0                 // add #$F0 (-15 decimal) - this should give a number between -15 and 16
                    012B: AB 24       ADDA  $0004,Y              // add to most significant byte of target objects blitter destination (which in this case is the X component of address) 
                    012D: 81 8F       CMPA  #$8F                 // far right position of playfield area                 
                    012F: 23 06       BLS   $0137
                    0131: 81 CF       CMPA  #$CF                 // No idea why this is here, this is an invalid coordinate.
                    0133: 23 02       BLS   $0137
                    0135: 86 07       LDA   #$07                 // left-most of position playfield area
                    0137: A1 04       CMPA  $0004,X              // if 7 is <= the most significant byte of the hulk's blitter destination, the hulk will move left   
                    0139: 23 05       BLS   $0140
                    013B: CC 01 D9    LDD   #$01D9               // pointer to animation table to make hulk move right
                    013E: 20 1F       BRA   $015F                // set hulk animation table pointer

                    0140: CC 01 CC    LDD   #$01CC               // pointer to animation table to make hulk move left
                    0143: 20 1A       BRA   $015F                // set hulk animation table pointer


                    //
                    // Compute a Y coordinate to move to, which in this case is (target Y coordinate -15) .. (target Y coordinate +15)
                    // where target can be player or family member, or even invalid object (see comments at $10D above) causing unpredictable hulk behaviour.
                    //

                    MAKE_HULK_MOVE_VERTICALLY:
                    0145: 96 85       LDA   $85                  // get another random number
                    0147: 84 1F       ANDA  #$1F                 // mask in lower 5 bits (to give a number between 0..31 decimal)
                    0149: 8B F0       ADDA  #$F0                 // add #$F0 (-15 decimal) - this should give a number between -15 and 16
                    014B: AB 25       ADDA  $0005,Y              // add to least significant byte of target objects blitter destination (the Y component) 
                    014D: 81 06       CMPA  #$06                 // far left edge of playfield
                    014F: 24 02       BCC   $0153                // if A>6 goto $0153
                    0151: 86 EA       LDA   #$EA                 // far right edge of playfield
                    0153: A1 05       CMPA  $0005,X              // if A is <= the least significant byte of the hulk's blitter destination (the Y component), the hulk will move up
                    0155: 23 05       BLS   $015C
                    0157: CC 01 E6    LDD   #$01E6               // pointer to animation table to make hulk move down
                    015A: 20 03       BRA   $015F

                    015C: CC 01 F3    LDD   #$01F3               // pointer to animation table to make hulk move up
                    015F: ED 4D       STD   $000D,U              // set animation table pointer to U
                    0161: 4F          CLRA  
                    0162: A7 4B       STA   $000B,U              // set index into animation table to 0 - first frame
                    0164: E6 D8 0D    LDB   [$0D,U]              // read offset from animation table (remember, each entry in the table has 3 bytes, first byte is offset to add to animation frame metadata list start )
                    0167: C3 0C F9    ADDD  #$0CF9               // add offset to animation frame metadata list start for hulk, giving you a pointer in D to the animation frame metadata ...
                    016A: ED 02       STD   $0002,X              // store to animation frame metadata pointer
                    016C: 39          RTS   


                    INITIALISE_ALL_HULKS:
                    016D: B6 BE 6D    LDA   cur_hulks            // get count of hulks into A
                    0170: 34 02       PSHS  A                    // save count on stack for use in loop
                    0172: 27 06       BEQ   $017A                // if 0, exit
                    0174: 8D 06       BSR   $017C                // create and initialise a hulk
                    0176: 6A E4       DEC   ,S                   // decrement hulk count on stack
                    0178: 26 FA       BNE   $0174                // if we've not set up all hulks, go back to $0174 
                    017A: 35 82       PULS  A,PC //(PUL? PC=RTS)




//
// This function initialises a hulk object.
//
//

                    HULK_INITIALISE:
                    017C: BD D0 54    JSR   $D054                // JMP $D281 - reserve object metadata entry and call function
                    017F: 00 30       // address of function to call         
                    // at this point, X=  newly created object metadata for hulk
                    0181: 33 84       LEAU  ,X                   // U = X = pointer to object metadata
                    0183: BD D0 7B    JSR   $D07B                // JMP $D2DA - reserve entry in list used by grunts, hulks, brains, progs, cruise missiles and tanks (starts at $9821)
                    0186: CC 0C F9    LDD   #$0CF9               // pointer to animation frame metadata (first 2 bytes at 0CF9 are 07 10 width & height , next 2 bytes 0D 1D pointer to image)
                    0189: ED 02       STD   $0002,X              // store current animation frame metadata pointer
                    018B: ED 88 14    STD   $14,X                // store previous animation frame metadata pointer (previous = current)
                    018E: EF 06       STU   $0006,X              // set pointer to object metadata in this object
                    0190: AF 47       STX   $0007,U              // store address of this object to U + 7
                    0192: CC 00 B6    LDD   #$00B6               // address of function to call when hulk is hit
                    0195: ED 08       STD   $0008,X
                    0197: BD 38 8E    JSR   $388E                // JMP $38FE -compute safe rectangle for player

                    // find a start position for the hulk
                    019A: BD 26 C3    JSR   $26C3                // JMP $3199 - get random position on playfield for object (returns: A = X coordinate, B = Y coordinate)

                    // this block of code is here to ensure the hulk X and Y coordinates are valid
                    // and that the hulk's not too near to the player
                    019D: D1 2B       CMPB  $2B                  // 
                    019F: 23 0C       BLS   $01AD
                    01A1: D1 2C       CMPB  $2C
                    01A3: 24 08       BCC   $01AD                // >
                    01A5: 91 2D       CMPA  $2D
                    01A7: 23 04       BLS   $01AD                // <=
                    01A9: 91 2E       CMPA  $2E
                    01AB: 23 ED       BLS   $019A                // if the coordinate is invalid, then go get another one

                    // if we get here, hulk X and Y coordinates are valid
                    01AD: ED 04       STD   $0004,X              // set "last" blitter destination
                    01AF: A7 0A       STA   $000A,X              // set current hulk X coordinate (whole part)
                    01B1: E7 0C       STB   $000C,X              // set current hulk Y coordinate
                    01B3: 96 84       LDA   $84                  // get a random number
                    01B5: 81 C0       CMPA  #$C0                 
                    01B7: 23 05       BLS   $01BE                // if number <= #$C0 (192 decimal) make the hulk stalk a family member
                    01B9: CC B3 A2    LDD   #$B3A2               // set target pointer to very last entry in family member list - which might not have anything in it
                    01BC: 20 02       BRA   $01C0

                    // get a family member for the hulk to stalk
                    01BE: 8D 77       BSR   $0237                // get a family member from the family member list into D
                    01C0: ED 49       STD   $0009,U              // store into target
                    01C2: BD 01 06    JSR   $0106                // pick a direction for hulk
                    01C5: BD 38 8B    JSR   $388B                // JMP $393C - blit hulk in solid colour invisible to player
                    01C8: 6F 88 13    CLR   $13,X
                    01CB: 39          RTS   





                        // Clear the family member list. zero from $B354 to B3A3.
                        //
                        // Hulks and brains use this list to find family members to target.
                        // 
                        //

                        CLEAR_FAMILY_MEMBER_LIST:
                        0200: 8E B3 54    LDX   #$B354                  // start of family member list
                        0203: 9F 49       STX   $49
                        0205: 6F 80       CLR   ,X+
                        0207: 8C B3 A4    CMPX  #$B3A4                
                        020A: 26 F9       BNE   $0205
                        020C: 39          RTS   


                                                        // Add a family member object to the family member list.
                                //
                                // X =  pointer to family member object to add to list
                                //
                                ADD_ENTRY_TO_FAMILY_MEMBER_LIST:
                                020D: 34 16       PSHS  X,B,A
                                020F: 8E B3 54    LDX   #$B354
                                0212: EC 81       LDD   ,X++                   // read entry at X and add 2 to X
                                0214: 26 FC       BNE   $0212                  // if entry is not null, its occupied, so go read next entry
                                0216: EC 62       LDD   $0002,S                // D = X from stack, which is pointer to family member object to add
                                0218: ED 1E       STD   -2,X                   // write family member object into list
                                021A: 35 96       PULS  A,B,X,PC //(PUL? PC=RTS)



                            // This routine removes a family member from the family member list.
                            // The family member is either dead or has been saved by the player.
                            // Brains and Hulks will no longer consider this object in their AI. 
                            //
                            // X = pointer to family member object to remove from list.
                            //
                            //

                                REMOVE_FAMILY_LIST_ENTRY:
                                021C: 34 16       PSHS  X,B,A
                                021E: 8E B3 54    LDX   #$B354               // start of object list
                                0221: EC 62       LDD   $0002,S              // D = X from stack
                                0223: 10 A3 81    CMPD  ,X++                 // compare D to *X, and add 2 to X                 
                                0226: 27 09       BEQ   $0231                // if a match, goto $0231
                                0228: 8C B3 A4    CMPX  #$B3A4               // have we hit end of list? 
                                022B: 26 F6       BNE   $0223                // no, goto $0223

                                // if we get here, the family member can't be found. So therefore something's went wrong, and this forces the game to hang.
                                022D: 1A 10       ORCC  #$10                 // Disable interrupts                 
                                022F: 20 FE       BRA   $022F                // infinite loop, force watchdog to reset

                                // otherwise, we've found the family member in the list, so time to remove it
                                0231: 4F          CLRA                       // clear A & B (which both form D) - this will zero out (nullify) the object pointer in the list
                                0232: 5F          CLRB                       // effectively saying "this object does not exist any more"
                                0233: ED 1E       STD   -2,X                 // overwrite the object pointer in the list (remember X++ increments X by 2 after the CMPD instruction, moving us past the entry list we want)                
                                0235: 35 96       PULS  A,B,X,PC //(PUL? PC=RTS)
                                 


                                //
                                // Get next family member from the list of family members.
                                // 
                                // Returns: D = family member
                                //

                                GET_FAMILY_MEMBER_FROM_LIST:
                                0237: 34 10       PSHS  X  
                                0239: 9E 49       LDX   $49                  // get pointer to current entry in family member list 
                                023B: 8C B3 A4    CMPX  #$B3A4               // are we past the end of the list?
                                023E: 25 09       BCS   $0249                // no, goto $0249
                                0240: 8E B3 54    LDX   #$B354               // yes, so reset pointer to point to start of family member list
                                0243: 20 04       BRA   $0249

                                0245: 9C 49       CPX   $49                  // if X == pointer to current entry then that means the entire list has been scanned. No family members left.
                                0247: 27 14       BEQ   $025D                // if no family members left (all dead or rescued) then goto $025D, (RTS)
                                0249: EC 81       LDD   ,X++                 // read family member pointer entry and add 2 to X to bump X to next entry
                                024B: 26 0A       BNE   $0257                // if pointer not NULL goto $0257
                                024D: 8C B3 A4    CMPX  #$B3A4               // is X past the end of the list?
                                0250: 25 F3       BCS   $0245                // no, goto $0245
                                0252: 8E B3 54    LDX   #$B354               // yes, so start at beginning of list 
                                0255: 20 EE       BRA   $0245

                                0257: 9F 49       STX   $49                  // save pointer to NEXT family member object pointer slot in $49 - it might be null
                                0259: 30 1E       LEAX  $-2,X                // X= X -2. This is because the X++ in $0249 has added 2 to X which we need to undo
                                025B: 1F 10       TFR   X,D                  // D = X, which is family member pointer
                                025D: 35 90       PULS  X,PC //(PUL? PC=RTS)



                ANIMATE_FAMILY_MEMBER:
                025F: AE 47       LDX   $0007,U              // get pointer to family member object
                0261: 10 AE 4D    LDY   $000D,U              // get pointer to animation tables (see $03CF)             
                0264: A6 4B       LDA   $000B,U              // get index into tables (a multiple of 3)                               
                0266: 31 A6       LEAY  A,Y                  // Y+= A
                0268: E6 A4       LDB   ,Y                   // B is now offset to add to animation frame metadata start pointer (see $0275)
                026A: 2A 04       BPL   $0270                
                026C: 6F 4B       CLR   $000B,U              // reset index to 0 
                026E: 20 F1       BRA   $0261

                0270: 8B 03       ADDA  #$03                 // bump index to next entry in tables 
                0272: A7 4B       STA   $000B,U              // update index
                0274: 4F          CLRA                       // set a to 0, so only B is used in the ADDD below.
                0275: E3 49       ADDD  $0009,U              // add in animation frame metadata start pointer in B.  D now points to animation frame metadata.
                0277: ED 02       STD   $0002,X              // set current animation frame metadata pointer 
                0279: A6 21       LDA   $0001,Y              // get X delta
                027B: 5F          CLRB  
                027C: 47          ASRA                       // shift A right 1 bit, preserving sign bit                     
                027D: 56          RORB                       // now bit 0 of A is into bit 7 of B. A now holds whole part of X delta, and B holds fractional part 
                027E: E3 0A       ADDD  $000A,X              // D += object X coordinate
                0280: 34 06       PSHS  B,A
                0282: E6 22       LDB   $0002,Y              // get Y delta                 
                0284: EB 0C       ADDB  $000C,X              // B += object Y coordinate
                0286: 34 40       PSHS  U
                0288: CE 98 23    LDU   #$9823               // start of electrode linked list            
                028B: BD 26 C6    JSR   $26C6                // JMP $3085 - rectangle intersection function
                028E: 35 40       PULS  U
                0290: 26 05       BNE   $0297                // if family member has walked into an electrode then goto $0297, to make family member change direction
                0292: BD 00 06    JSR   $0006                // JMP $009E: ensure object stays in bounds
                0295: 27 04       BEQ   $029B                // yes, object has new position, update coords

                // if we get here, then the family member has tried to move to an invalid position 
                // such as off playfield OR into an electrode. 
                0297: 32 62       LEAS  $0002,S              // discard A & B pushed on stack (see $0286 above)
                0299: 20 0A       BRA   $02A5                // make the family member change direction, then draw the family member, and we're done'

                029B: E7 0C       STB   $000C,X              // set object Y coordinate
                029D: 35 06       PULS  A,B
                029F: ED 0A       STD   $000A,X              // set object X coordinate
                02A1: 6A 4C       DEC   $000C,U              // decrement walk countdown
                02A3: 26 02       BNE   $02A7                // if 0, make family member change direction

                02A5: 8D 6B       BSR   $0312                // call change direction routine            
                02A7: BD D0 8D    JSR   $D08D                // JMP $DB2F - erase then re-blit object 
                02AA: 86 08       LDA   #$08                 // delay before calling function
                02AC: 8E 02 5F    LDX   #$025F               // address of routine to call (animate family member)
                02AF: 7E D0 66    JMP   $D066                // JMP $D1E3 - allocate task


                INITIALISE_FAMILY_MEMBERS:
                02B2: BD 02 00    JSR   $0200                // clear (zero) family list from $B354 to $B3A3
                02B5: 8E 0B 3B    LDX   #$0B3B               // load X with pointer to animation frame metadata for first mikey (memory at this $0B3B: 03,0B = width, height// 0B 6B = pointer to first mikey image)
                02B8: CE 03 30    LDU   #$0330               // Load U with address of routine that handles mikey death/rescue/progging
                02BB: B6 BE 6C    LDA   cur_mikeys
                02BE: 8D 14       BSR   $02D4                // call function that creates A number of family member (in this case, Mikey) with parameters X and U
                02C0: 8E 05 2F    LDX   #$052F               // load X with pointer to animation frame metadata for first mommy (memory at $052F: O4,OE = width, height// 05 5F = pointer to first mummy image)
                02C3: CE 03 35    LDU   #$0335               // Load U with address of routine that handles mommy death/rescue/progging
                02C6: B6 BE 6A    LDA   cur_mommies
                02C9: 8D 09       BSR   $02D4                // call function that creates A number of family member (in this case, Mommy) with parameters X and U
                02CB: 8E 07 FF    LDX   #$07FF               // load X with pointer to animation frame metadata for first daddy (memory at $07FF: O5,OD = width, height// 08 2F = pointer to first mummy image)
                02CE: CE 03 3A    LDU   #$033A               // load U with address of routine that handles daddy death/rescue/progging
                02D1: B6 BE 6B    LDA   cur_daddies
                //
                // U = routine to call to remove family member from game (ie: when family member killed or rescued)
                // X = pointer to animation frame metadata for family member
                // A = number of particular family member 
                //
                02D4: 34 52       PSHS  U,X,A
                02D6: 4D          TSTA                       // number of family type == 0?
                02D7: 27 37       BEQ   $0310                // Yes, so just exit
                02D9: BD D0 54    JSR   $D054                // JMP $D281 - reserve object metadata entry and call function
                02DC: 02 5F        // pointer to function (which looks like address of the animation routine) 

                02DE: 33 84       LEAU  ,X                   // U += X
                02E0: BD D0 87    JSR   $D087                // JMP $D2F2    - reserve object [for family member]
                // X = freshly reserved object
                02E3: EC 61       LDD   $0001,S              // load D with pointer to animation frame metadata, from stack
                02E5: ED 02       STD   $0002,X              // set current animation frame metadata pointer 
                02E7: ED 88 14    STD   $14,X                // set previous animation frame metadata pointer (previous = current)
                02EA: ED 49       STD   $0009,U              // set animation frame metadata list start pointer
                02EC: EF 06       STU   $0006,X              // save pointer to object metadata in family member object               
                02EE: AF 47       STX   $0007,U              // set pointer to this object in U + 7
                02F0: EC 63       LDD   $0003,S              // D = routine to kill family member
                02F2: ED 08       STD   $0008,X              // store routine 
                02F4: BD 26 C3    JSR   $26C3                // JMP $3199 - get random position on playfield for object (returns: A = X coordinate, B = Y coordinate)
                02F7: ED 04       STD   $0004,X              // "last" blitter destination = D
                02F9: A7 0A       STA   $000A,X              // set current family member X coordinate (whole part)
                02FB: E7 0C       STB   $000C,X              // set current family member Y coordinate
                02FD: 96 84       LDA   $84                  // get a random number                  
                02FF: 84 07       ANDA  #$07                 // make number in range of 0..7   
                0301: 4C          INCA                       // add 1, to ensure number is nonzero
                0302: A7 44       STA   $0004,U
                0304: 8D 0C       BSR   $0312                // set up the initial animation for the family member
                0306: BD D0 18    JSR   $D018                // JMP $DAF2 - blit object
                0309: BD 02 0D    JSR   $020D                // reserve an entry for this family member object in list in $B354 onwards... hulks use the list to get targets!  
                030C: 6A E4       DEC   ,S                   // decrement temporary count of family member type to process
                030E: 26 C9       BNE   $02D9                // if !=0, more family members to process
                0310: 35 D2       PULS  A,X,U,PC //(PUL? PC=RTS)


                CHANGE_FAMILY_MEMBER_DIRECTION:
                0312: 96 86       LDA   $86                  // get a random number
                0314: 84 7F       ANDA  #$7F                 // mask with #$7F (127 decimal) to give number between 0 and 127                
                0316: 4C          INCA                       // add 1, to ensure A is nonzero
                0317: A7 4C       STA   $000C,U              // make A count of how many cycles to walk in particular direction
                0319: 96 84       LDA   $84                  // get a random number
                031B: 84 07       ANDA  #$07                 // we have 7 animations for each family member and...
                031D: C6 0D       LDB   #$0D                 // ... each animation sequence occupies 0D (13 decimal) bytes exactly
                031F: 3D          MUL                        // multiply A by B to give offset into animation tables 
                0320: C3 03 CF    ADDD  #$03CF               // compute where in animation tables (see 03CF for description) to start from
                0323: ED 4D       STD   $000D,U              // store result
                0325: 4F          CLRA  
                0326: A7 4B       STA   $000B,U              // reset index into animation tables (see $0261)
                0328: E6 D8 0D    LDB   [$0D,U]              // read first byte from animation tables- this byte is the offset part (see $03CF for description)  
                032B: E3 49       ADDD  $0009,U              // add offset to animation frame metadata list start (see $02EA) 
                032D: ED 02       STD   $0002,X              // set animation frame metadata pointer
                032F: 39          RTS   

                0330: 7A BE 6C    DEC   cur_mikeys
                0333: 20 08       BRA   $033D

                0335: 7A BE 6A    DEC   cur_mommies
                0338: 20 03       BRA   $033D

                033A: 7A BE 6B    DEC   cur_daddies



//
// This routine is called when a family member is saved by the player, killed by a hulk, or about to be prog'd.
//
//

FAMILY_MEMBER_SAVED_KILLED_OR_PROGGED:
033D: BD 02 1C    JSR   $021C                // remove family member from list in $B354
0340: BD D0 8A    JSR   $D08A                // JMP $D2D2 - deallocate family member object 
0343: BD D0 15    JSR   $D015                // JMP $DB03 - erase object from screen
0346: EC 04       LDD   $0004,X              // get blitter destination
0348: AE 06       LDX   $0006,X              // get pointer to object metadata into X
034A: BD D0 5D    JSR   $D05D                // JMP $D218 - deallocate object metadata entry
034D: 0D 95       TST   $95                  // is the family member being prog'd? (see $1CFF)
034F: 26 51       BNE   $03A2                // if yes, goto $03A2 (just an RTS)
0351: BD D0 6C    JSR   $D06C                // JMP $D32B - create entity with params and add to linked list at $9817
0354: 03 A3       // parameters to pass to $D06C - function to call on next game cycle
0356: 04 7D       // parameters to pass to $D06C - animation frame metadata pointer (which is a 2x2 black square!)
0358: 03 90       // parameters to pass to $D06C - function to call when this object has a collision
// X = pointer to new object
035A: 81 89       CMPA  #$89                 // 
035C: 25 02       BCS   $0360
035E: 86 89       LDA   #$89
0360: ED 04       STD   $0004,X
0362: 0D 95       TST   $95                  // is this family member being progged?
0364: 26 2D       BNE   $0393                // yes, so draw the "death" image
0366: 0D 48       TST   $48                  // was it the player who saved this family member?
0368: 27 29       BEQ   $0393                // no, so draw the "death" image
036A: 86 3C       LDA   #$3C                 // how long to show the point score for rescuing family member
036C: A7 49       STA   $0009,U
036E: 0C 8D       INC   $8D                  // increment number of family members saved                 
0370: 96 8D       LDA   $8D
0372: 81 05       CMPA  #$05                 // have we saved 5 members?
0374: 23 02       BLS   $0378                // if lower or same as 5, goto $0378
0376: 86 05       LDA   #$05                 // otherwise, cap at 5
0378: 48          ASLA                       // A *= 2// 
0379: 48          ASLA                       // A *= 2// 
037A: CE 04 81    LDU   #$0481               // animation metadata start for bonus. compute whether to show 1000,2000,3000,4000,5000
037D: 33 C6       LEAU  A,U                  // U = U + A
037F: EF 02       STU   $0002,X              // set animation metadata pointer for object
0381: CE 03 C3    LDU   #$03C3               // Start of points value table. Real entries begin at $03C5   
0384: 44          LSRA                       // divide A by 2. A is now an offset into points value table.  
0385: EC C6       LDD   A,U                  // D = *(U+A). D now holds score parameter to pass to $DB9C. 
                                             // If A==0, score value is 1000 points, A==2, score value 2000 points etc.
0387: BD D0 0C    JSR   $D00C                // JMP $DB9C - update player score
038A: CC 00 26    LDD   #$0026
038D: BD D0 4B    JSR   $D04B                // JMP $D3C7 - play sound with priority
0390: 4F          CLRA   
0391: 35 86       PULS  A,B,PC //(PUL? PC=RTS)

0393: 86 5A       LDA   #$5A                // countdown before image disappears
0395: A7 49       STA   $0009,U
0397: CC 04 37    LDD   #$0437              // pointer to "family death" image
039A: ED 02       STD   $0002,X             // set animation frame metadata pointer
039C: CC 00 2B    LDD   #$002B
039F: BD D0 4B    JSR   $D04B               // JMP $D3C7 - play sound with priority
03A2: 39          RTS   


//
                    // Draw the points value for rescuing the family member
                    //
                    DRAW_POINTS_FOR_RESCUING_FAMILY_MEMBER:
                    03A3: AE 47       LDX   $0007,U             // load X with pointer to object
                    03A5: EC 04       LDD   $0004,X             // blitter destination
                    03A7: 10 AE 02    LDY   $0002,X             // pointer to image struct
                    03AA: BD D0 21    JSR   $D021               // JMP $DA82 - do blit without transparency
                    03AD: 6A 49       DEC   $0009,U
                    03AF: 27 08       BEQ   $03B9
                    03B1: 86 01       LDA   #$01                // delay before calling function
                    03B3: 8E 03 A3    LDX   #$03A3              // address of function to call
                    03B6: 7E D0 66    JMP   $D066               // JMP $D1E3 - allocate task

                    03B9: BD D0 1E    JSR   $D01E               // JMP $DABF: clear image rectangle
                    03BC: DC 1B       LDD   $1B                  
                    03BE: ED 84       STD   ,X
                    03C0: 9F 1B       STX   $1B
                    03C2: 7E D0 63    JMP   $D063               // JMP $D1F3 - free object metadata and process next task


                    // points added to score when you rescue a family member
                    RESCUE_FAMILY_POINTS_TABLE:
                    03C5: 02 10                                 // 1000 points
                    03C7: 02 20                                 // 2000 points
                    03C9: 02 30                                 // 3000 points
                    03CB: 02 40                                 // 4000 points
                    03CD: 02 50                                 // 5000 points




                    INITIALISE_ALL_SPHEROIDS:
                    1168: B6 BE 6F    LDA   cur_sphereoids       // get number of sphereoids into A
                    116B: 34 02       PSHS  A                    // save spheroid count on stack
                    116D: 27 3E       BEQ   $11AD                // if spheroid count ==0, goto $11AD (= RTS)
                    117D: 86 09       LDA   #$09                 // set X coordinate of spheroid to be #$09 - tentatively// depends on next 2 lines of code
                    117F: 0D 84       TST   $84                  // read a random number
                    1181: 2B 02       BMI   $1185                // if bit 7 set, goto $1185
                    1183: 86 87       LDA   #$87                 // set X coordinate of spheroid to be #$87
                    1185: ED 04       STD   $0004,X              // set sphereoid current blit destination
                    1187: A7 0A       STA   $000A,X              // set sphereoid X coordinate         
                    1189: E7 0C       STB   $000C,X              // set sphereoid Y coordinate
                    118B: B6 BE 60    LDA   $BE60                // read enforcer drop countdown setting
                    118E: BD D0 3F    JSR   $D03F                // JMP $D6B6 - get a random number lower than or equal to A
                    1191: A7 49       STA   $0009,U              // set countdown before creating first enforcer 
                    1193: B6 BE 5E    LDA   $BE5E                // read enforcer drop count variable
                    1196: BD D0 3F    JSR   $D03F                // JMP $D6B6 - get a random number lower than or equal to A
                    1199: 44          LSRA                       // divide number by 2, move bit 0 into carry
                    119A: 89 00       ADCA  #$00                 // ensure that A is non zero
                    119C: A7 4A       STA   $000A,U              // set count of enforcers to drop
                    119E: BD 12 5F    JSR   $125F                // pick initial direction
                    11A1: CC 15 02    LDD   #$1502               // pointer to collision detection animation frame metadata for spheroid (see $D7F4) 
                    11A4: ED 88 16    STD   $16,X
                    11A7: 9F 17       STX   $17                  // store pointer to spheroid object in linked list
                    11A9: 6A E4       DEC   ,S                   // decrement spheroid count on stack 
                    11AB: 26 C2       BNE   $116F
                    11AD: 35 82       PULS  A,PC //(PUL? PC=RTS)


                    ANIMATE_SPHEROID:
                    11AF: AE 47       LDX   $0007,U              // get pointer to object 
                    11B1: EC 02       LDD   $0002,X              // get current animation frame metadata pointer
                    11B3: C3 00 04    ADDD  #$0004               // bump to next image's metadata pointer
                    11B6: 10 83 15 02 CMPD  #$1502               // end of animation frame metadata list?
                    11BA: 23 0B       BLS   $11C7           
                    11BC: CC 14 F2    LDD   #$14F2               // back to first spheroid image
                    11BF: 0D 59       TST   $59
                    11C1: 26 04       BNE   $11C7
                    11C3: 6A 49       DEC   $0009,U              // decrement enforcer drop countdown
                    11C5: 27 14       BEQ   $11DB                // if countdown == 0, then time to drop an enforcer, goto $11DB 
                    11C7: ED 02       STD   $0002,X              // set current animation frame metadata pointer
                    11C9: 6A 4E       DEC   $000E,U              // decrement move countdown before enforcer decides where to move to next
                    11CB: 26 03       BNE   $11D0                // if countdown !=0, enforcer continues on its current path, goto $11D0
                    // sphereoid wants to go somewhere else
                    11CD: BD 12 5F    JSR   $125F                // set spheroid movement curvature factors and move countdown
                    11D0: BD 12 79    JSR   $1279                // update spheroid X and Y movement deltas
                    11D3: 86 02       LDA   #$02                 // delay before calling function
                    11D5: 8E 11 AF    LDX   #$11AF               // address of routine to jump to next time for this object
                    11D8: 7E D0 66    JMP   $D066                // JMP $D1E3 - allocate task


                DROP_ENFORCER:
                    11DB: B6 BE 60    LDA   $BE60                // read enforcer drop delay setting
                    11DE: 44          LSRA                       // this time, divide it by 4 - potentially making this spheroid drop its next enforcer much faster than it did first time
                    11DF: 44          LSRA  
                    11E0: BD D0 3F    JSR   $D03F                // JMP $D6B6 - get a random number lower than or equal to A
                    11E3: A7 49       STA   $0009,U              // set countdown before dropping enforcer
                    11E5: AE 47       LDX   $0007,U              // load X with pointer to spheroid object
                    11E7: EC 02       LDD   $0002,X              // load D with pointer to animation frame metadata
                    11E9: C3 00 04    ADDD  #$0004               // bump to next animation frame metadata
                    11EC: 10 83 15 0E CMPD  #$150E               // at end of spheroid animation (last animation frame in list)?
                    11F0: 23 1C       BLS   $120E                // no
                    11F2: 6A 49       DEC   $0009,U              // decrement countdown before dropping enforcer
                    11F4: 26 15       BNE   $120B                // countdown !=0, not time to drop enforcer, so goto $120B

                    // at this point, the spheroid wants to drop an enforcer. But there can only be 8 enforcers maximum on
                    // screen at once.
                    11F6: 96 ED       LDA   temp_enforcer_count
                    11F8: 81 08       CMPA  #$08                 // 8 enforcers at the moment?
                    11FA: 24 DF       BCC   $11DB                // if >= 8, goto $11DB, compute delay before trying to drop enforcer again
                    11FC: 96 42       LDA   $42
                    11FE: 81 11       CMPA  #$11
                    1200: 24 D9       BCC   $11DB
                    1202: BD 13 54    JSR   $1354                // create an enforcer
                    1205: 6A 4A       DEC   $000A,U              // decrement enforcers dropped counter               
                    1207: 27 19       BEQ   $1222                // if counter == 0 goto $1222. Time for the spheroid to disappear!!!
                    1209: 20 D0       BRA   $11DB

                    120B: CC 14 F2    LDD   #$14F2               // start of spheroid animation frame metadata

                    120E: ED 02       STD   $0002,X              // save pointer to current animation frame metadata
                    1210: 6A 4E       DEC   $000E,U              // decrement spheroid "countdown before I change direction" counter. 
                    1212: 26 03       BNE   $1217                // if counter!=0, it's not time to change direction, goto $1217. 
                    1214: BD 12 5F    JSR   $125F                // change spheroid direction and set countdown before changing direction.
                    1217: BD 12 79    JSR   $1279                // update spheroid movement deltas
                    121A: 86 02       LDA   #$02                 // delay before calling function
                    121C: 8E 11 E5    LDX   #$11E5               // address of function to call
                    121F: 7E D0 66    JMP   $D066                // JMP $D1E3 - allocate task


//
// The spheroid has dropped all of its enforcers and needs to go.
//
TIME_FOR_SPHEROID_TO_EXIT_PRONTO:
1222: CC 00 00    LDD   #$0000               // set Y delta (do not move vertically)
1225: ED 88 10    STD   $10,X                // store Y delta
1228: CC 01 00    LDD   #$0100               // this value will make the spheroid move right - but might be changed at $122F depending on a random number's value
122B: 0D 84       TST   $84                  // is bit 7 of the random number variable set?
122D: 2A 01       BPL   $1230                // if bit 7 not set, goto $1230
122F: 40          NEGA                       // flip X delta to move left
1230: ED 0E       STD   $000E,X              // set X delta
1232: AE 47       LDX   $0007,U              // load X with pointer to object
1234: EC 02       LDD   $0002,X              // load D with pointer to animation frame metadata
1236: C3 00 04    ADDD  #$0004               // bump to next animation frame metadata
1239: 10 83 15 02 CMPD  #$1502               // have we hit the end of the animation frame metadata list?              
123D: 23 0D       BLS   $124C                // no, set pointer to current animation frame metadata 
123F: A6 0A       LDA   $000A,X              // get X coordinate (whole part)
1241: 81 0A       CMPA  #$0A                 // compare to #$0A (10 decimal)
1243: 23 11       BLS   $1256                // <= , spheroid is at leftmost edge of screen and needs to be removed from the playfield 
1245: 81 85       CMPA  #$85                 // compare to #$85 (133 decimal)
1247: 24 0D       BCC   $1256                // >=, spheroid is at rightmost edge of screen and needs to be removed from the playfield
1249: CC 14 F2    LDD   #$14F2               // start of spheroid animation frame metadata list (to begin animation from start)
124C: ED 02       STD   $0002,X              // set current animation frame metadata pointer 
124E: 86 02       LDA   #$02                 // delay before calling function
1250: 8E 12 32    LDX   #$1232               // address of function to call for this object next
1253: 7E D0 66    JMP   $D066                // JMP $D1E3 - allocate task

1256: BD D0 75    JSR   $D075                // JMP $D31B - deallocate object and erase object from screen              
1259: 7A BE 6F    DEC   cur_sphereoids       // reduce spheroid count
125C: 7E D0 63    JMP   $D063                // JMP $D1F3 - free object metadata and process next task


            // OK, I realise its a long label, but you gotta be descriptive //)
            // See $DCFF for details on how the spheroid glides so smoothly
            SET_SPHEROID_CURVATURE_FACTORS_AND_COUNTDOWN_BEFORE_CHANGING_DIRECTION:
            125F: 96 85       LDA   $85                  // get a random number into A
            1261: 84 1F       ANDA  #$1F                 // mask in bits 0..5                
            1263: 8B F0       ADDA  #$F0                 // add #$F0  (-15 decimal)
            1265: A7 4C       STA   $000C,U              // set X curvature factor 
            1267: 96 86       LDA   $86                  // get another random number into A
            1269: 98 84       EORA  $84                  // xor with another random number...
            126B: 84 3F       ANDA  #$3F
            126D: 8B E0       ADDA  #$E0
            126F: A7 4D       STA   $000D,U              // set Y curvature factor

            1271: 86 0F       LDA   #$0F                 
            1273: BD D0 42    JSR   $D042                // JMP $D6AC - multiply A by a random number and put result in A
            1276: A7 4E       STA   $000E,U              // set countdown before spheroid changes direction
            1278: 39          RTS   


UPDATE_SPHEROID_MOVEMENT_DELTAS:
                    1279: E6 4C       LDB   $000C,U              // B = X coordinate curvature factor
                    127B: 1D          SEX                        // sign extend B into A (so D = sign extended version of B)
                    127C: E3 0E       ADDD  $000E,X              // add X delta to D

                    127E: 10 83 01 00 CMPD  #$0100               // is Y delta making the spheroid move right?
                    1282: 2D 03       BLT   $1287                // no, goto $1287
                    1284: CC 01 00    LDD   #$0100               // set X delta to move right
                    1287: 10 83 FF 00 CMPD  #$FF00               // is X delta making the spheroid move left?
                    128B: 2E 03       BGT   $1290               
                    128D: CC FF 00    LDD   #$FF00               // set X delta to move left 
                    1290: ED 0E       STD   $000E,X              // set X delta (only temporarily// this value will be overwritten in $129D)
                    1292: 43          COMA                        
                    1293: 53          COMB  
                    1294: 58          ASLB  
                    1295: 49          ROLA  
                    1296: 58          ASLB  
                    1297: 49          ROLA  
                    1298: 1F 89       TFR   A,B
                    129A: 1D          SEX   
                    129B: E3 0E       ADDD  $000E,X              // add X delta to D 
                    129D: ED 0E       STD   $000E,X              // set X delta



                    129F: E6 4D       LDB   $000D,U              // B = Y coordinate curvature factor 
                    12A1: 1D          SEX                        // sign extend B into A (so D = sign extended version of B) 
                    12A2: E3 88 10    ADDD  $10,X                // add Y delta to D              
                    12A5: 10 83 02 00 CMPD  #$0200               // is Y delta making the spheroid move down?
                    12A9: 2D 03       BLT   $12AE                // no, goto $12AE
                    12AB: CC 02 00    LDD   #$0200               // set Y delta to move down
                    12AE: 10 83 FE 00 CMPD  #$FE00               // is Y delta making the spheroid move up?
                    12B2: 2E 03       BGT   $12B7
                    12B4: CC FE 00    LDD   #$FE00               // set Y delta to move up
                    12B7: ED 88 10    STD   $10,X                // set Y delta (only temporarily// this value will be overwritten in $12C4)
                    12BA: 43          COMA  
                    12BB: 53          COMB  
                    12BC: 58          ASLB  
                    12BD: 49          ROLA  
                    12BE: 1F 89       TFR   A,B
                    12C0: 1D          SEX   
                    12C1: E3 88 10    ADDD  $10,X                // D+= Y delta
                    12C4: ED 88 10    STD   $10,X                // set Y delta to D
                    12C7: 39          RTS   



                        SPHEROID_COLLISION_HANDLER:
                        12C8: 96 48       LDA   $48                 // player collision detection called this?
                        12CA: 26 24       BNE   $12F0               // yes
                        12CC: BD D0 78    JSR   $D078               // JMP $D320 - deallocate object, and its metadata, and erase object from screen
                        12CF: DE 1B       LDU   $1B
                        12D1: EC C4       LDD   ,U
                        12D3: DD 1B       STD   $1B
                        // spheroid is dead
                        12D5: BD D0 54    JSR   $D054               // JMP $D281 - reserve object metadata entry and call function
                        12D8: 12 F1          // pointer to function    

                        12DA: EF 07       STU   $0007,X              // set object metadata pointer in this object
                        12DC: CC 14 F6    LDD   #$14F6               // animation frame metadata pointer  
                        12DF: ED 42       STD   $0002,U
                        12E1: 7A BE 6F    DEC   cur_sphereoids
                        12E4: CC 02 10    LDD   #$0210
                        12E7: BD D0 0C    JSR   $D00C                // JMP $DB9C - update player score
                        12EA: CC 11 51    LDD   #$1151
                        12ED: 7E D0 4B    JMP   $D04B                // JMP $D3C7 - play sound with priority

                        12F0: 39          RTS   



//
// When you shoot a spheroid, it's drawn a different colour (the same colour as the player score, to be precise)  
// for a short while, to signify it's dying. Then it disappears and the points value of the spheroid appears in its place.
//

DRAW_SPHEROID_IN_DEATH_THROES:
12F1: CC FF AA    LDD   #$FFAA               // A = colour to draw points value of spheroid in, B = colour to draw dying spheroid in 
12F4: ED 4B       STD   $000B,U              // set colour remap values in object metadata
12F6: 86 07       LDA   #$07                 // countdown before spheroid disappears and spheroid points value appears in its place
12F8: A7 4D       STA   $000D,U
12FA: AE 47       LDX   $0007,U              // X = pointer to object from object metadata
12FC: 10 AE 02    LDY   $0002,X              // Y = pointer to animation frame metadata
12FF: EC 04       LDD   $0004,X              // D= blitter destination
1301: BD D0 1E    JSR   $D01E                // JMP $DABF - clear image rectangle
1304: 31 24       LEAY  $0004,Y              // Set Y to pointer to animation frame metadata
1306: 10 AF 02    STY   $0002,X
1309: 6A 4D       DEC   $000D,U              // decrement countdown before score value is shown
130B: 27 11       BEQ   $131E                // if countdown is 0, time to show the points value of the sphereoid, goto $131E
130D: A6 4C       LDA   $000C,U              // otherwise, draw the spheroid in the colour specified at $12F1
130F: 97 2D       STA   $2D                  // set colour remap value
1311: EC 04       LDD   $0004,X              // D = blitter destination
1313: BD D0 90    JSR   $D090                // JMP $DA9E - do solid and transparent blit
1316: 86 02       LDA   #$02                 // delay before calling function
1318: 8E 12 FA    LDX   #$12FA               // address of function to call
131B: 7E D0 66    JMP   $D066                // JMP $D1E3 - allocate task


//
// The spheroid is dead, now show its points value
//
//

DRAW_SPHEROID_POINTS_VALUE:
131E: EC 04       LDD   $0004,X              // D= blitter destination of spheroid
1320: C3 01 05    ADDD  #$0105               // adjust position for score image 
1323: ED 04       STD   $0004,X              // set blitter destination
1325: 86 1E       LDA   #$1E
1327: A7 49       STA   $0009,U              // set countdown of how long score is displayed
1329: FC 00 0C    LDD   $000C                // read points value animation frame metadata pointer 
132C: ED 02       STD   $0002,X              // set pointer to animation frame metadata
132E: AE 47       LDX   $0007,U              // get pointer to object from object metadata
1330: A6 4B       LDA   $000B,U
1332: 97 2D       STA   $2D                  // set solid colour 
1334: 10 AE 02    LDY   $0002,X              // set pointer to animation frame metadata
1337: EC 04       LDD   $0004,X              // set D = blitter destination
1339: BD D0 90    JSR   $D090                // JMP $DA9E - do solid and transparent blit, to draw points value of spheroid
133C: 6A 49       DEC   $0009,U              // decrement countdown of score display
133E: 27 08       BEQ   $1348                // if 0, the score has been displayed long enough, goto $1348
1340: 86 02       LDA   #$02                 // delay before calling function
1342: 8E 13 2E    LDX   #$132E               // address of function to call 
1345: 7E D0 66    JMP   $D066                // JMP $D1E3 - allocate task

// clear the score off screen
1348: BD D0 1E    JSR   $D01E                // JMP $DABF: clear image rectangle
134B: DC 1B       LDD   $1B                  // read "free object entry" pointer
134D: ED 84       STD   ,X                   // store in this object (creating a forward only linked list that includes this object)
134F: 9F 1B       STX   $1B                  // set "free object entry" linked list to begin with this object
1351: 7E D0 63    JMP   $D063                // JMP $D1F3 - free object metadata and process next task



//
// X = pointer to spheroid that is spawning the enforcer
//
//
//
//

                    CREATE_ENFORCER:
                    1354: 34 76       PSHS  U,Y,X,B,A
                    1356: 1F 12       TFR   X,Y                  // Spheroid pointer -> Y
                    1358: BD D0 6C    JSR   $D06C                // JMP $D32B - create entity with params and add to linked list at $9817

                    // parameters to pass to $D06C
                    135B: 13 90       // address of function to call after 1 game cycle
                    135D: 18 D2       // animation frame metadata pointer
                    135E: 14 83       // address of routine to handle collision

                        1361: 27 1C       BEQ   $137F                // if Z flag set then enforcer could not be created, goto $137F
                        // X = pointer to freshly created object
                        1363: A6 2A       LDA   $000A,Y              // get X coordinate from Spheroid             
                        1365: E6 2C       LDB   $000C,Y              // get Ycoordinate from Spheroid             
                        1367: A7 0A       STA   $000A,X              // set X coordinate (whole part) of Enforcer
                        1369: E7 0C       STB   $000C,X              // set Y coordinate of Enforcer
                        136B: ED 04       STD   $0004,X              // set blitter destination
                        136D: B6 BE 5F    LDA   $BE5F                // read enforcer control variable
                        1370: BD D0 3F    JSR   $D03F                // JMP $D6B6 - get a random number lower than or equal to A
                        1373: A7 4D       STA   $000D,U              // set delay on how long it is before enforcer fires a spark
                        1375: 9F 17       STX   $17
                        1377: CC 11 4C    LDD   #$114C
                        137A: BD D0 4B    JSR   $D04B                // JMP $D3C7 - play sound with priority
                        137D: 0C ED       INC   temp_enforcer_count
                        137F: 35 F6       PULS  A,B,X,Y,U,PC //(PUL? PC=RTS)


                        //
                        // The enforcer is spawning here. This function is called to advance the spawn one frame at a time.
                        //

                        ENFORCER_SPAWN_ANIMATION:
                        1381: AE 47       LDX   $0007,U              // get pointer to enforcer object from object metadata
                        1383: EC 02       LDD   $0002,X              // get animation frame metadata pointer
                        1385: C3 00 04    ADDD  #$0004               // bump to next animation frame metadata in the list
                        1388: 10 83 18 E6 CMPD  #$18E6               // last animation frame of spawn?
                        138C: 24 0A       BCC   $1398                // if >= last frame then goto $1398 - the enforcer's ready to attack!
                        138E: ED 02       STD   $0002,X              // set animation frame metadata pointer
                        1390: 86 08       LDA   #$08                 // set delay before next call to this routine, to advance spawn
                        1392: 8E 13 81    LDX   #$1381               // address of function to call
                        1395: 7E D0 66    JMP   $D066                // JMP $D1E3 - allocate task

                        // when we get here, the enforcer has spawned and is ready to attack!
                        ENFORCER_SPAWN_COMPLETE:
                        1398: ED 02       STD   $0002,X              // set animation frame metadata pointer
                        139A: BD 13 B5    JSR   $13B5                // pick the location that the enforcer wants to move to


                        //
                        // This routine is the enforcer AI. I haven't called this ANIMATE_ENFORCER because the enforcer has no animations!
                        //

                ENFORCER_AI:
                139D: AE 47       LDX   $0007,U              // get pointer to object into X
                139F: 6A 4E       DEC   $000E,U              // decrement countdown before enforcer selects a new location to move to
                13A1: 26 03       BNE   $13A6                // if countdown !=0, keep the enforcer going in its current direction, goto $13A6
                13A3: BD 13 B5    JSR   $13B5                // otherwise, the enforcer must evaluate where it wants to move to next 
                13A6: 6A 4D       DEC   $000D,U              // decrement enforcer spark countdown. When countdown == 0, the enforcer will fire a spark.
                13A8: 26 03       BNE   $13AD                // if countdown !=0, goto $13AD
                13AA: BD 14 04    JSR   $1404                // counter is ==0, call function to fire a spark. 
                13AD: 86 03       LDA   #$03                 // delay before calling this enforcer AI function again
                13AF: 8E 13 9D    LDX   #$139D               // address of enforcer AI function 
                13B2: 7E D0 66    JMP   $D066                // JMP $D1E3 - allocate task


//
// Pick a destination for the enforcer to move to.
//
// See $DCFF for information on how the enforcer glides so smoothly.
//

                    PICK_ENFORCER_DESTINATION:
                    13B5: BD D0 3C    JSR   $D03C                // JMP $D6C8 - get random numbers into A and B
                    13B8: 84 1F       ANDA  #$1F                 // make A a number between 0..31 decimal
                    13BA: A7 4E       STA   $000E,U              // countdown before enforcer selects new location to move to
                    13BC: 4F          CLRA                       // A = 0 
                    13BD: 57          ASRB                       // move bit 0 of B into carry while preserving bit 7 (sign bit)  
                    13BE: 57          ASRB  
                    13BF: 57          ASRB  
                    13C0: DB 5E       ADDB  $5E                  // B+= most significant byte of player blitter destination (the horizontal component)
                    // at this point B is an X coordinate that the enforcer is considering moving to.
                    13C2: C1 07       CMPB  #$07                 // at left-most of playfield?             
                    13C4: 24 02       BCC   $13C8                // no, goto $13C8
                    13C6: C6 07       LDB   #$07               
                    13C8: 81 8F       CMPA  #$8F                 // why is A being read when it's zero (see $13BC) - don't they mean to use B? Could this be the enforcer bug?
                    13CA: 23 0A       BLS   $13D6                // as a result of A always being 0, this code always executes 

                    // I've put a breakpoint on this block of code in MAME debugger and it's never been called.
                    13CC: C1 CF       CMPB  #$CF
                    13CE: 24 04       BCC   $13D4
                    13D0: C6 8F       LDB   #$8F
                    13D2: 20 02       BRA   $13D6
                    13D4: C6 07       LDB   #$07
                    // end of code that is never called
                    13D6: E0 0A       SUBB  $000A,X              // B-= X coordinate (whole part) of enforcer 
                    13D8: 82 00       SBCA  #$00

                    13DA: 58          ASLB                       // move bit 7 of B into carry  
                    13DB: 49          ROLA                         
                    //
                    // if you want to see how the deltas affect the horizontal movement of the enforcer, or indeed any omnidirectional object, put a breakpoint on the line below,
                    // and just before executing the instruction, set register D to 0, $FF00 or $0100 in the MAME debugger.
                    // $FF00 = move to left, $0100 = move to right.If you set D to 0, there will no movement on the horizontal axis at all.
                    // Tinker with the least significant byte (the fractional part) to have the enforcer move in oblique angles.
                    //
                    13DC: ED 0E       STD   $000E,X              // set X delta of enforcer


                    13DE: 4F          CLRA  
                    13DF: D6 85       LDB   $85                  // get a random number into B
                    13E1: 57          ASRB                       // shift B right 1, preserve sign bit   
                    13E2: 57          ASRB                       // shift B right 1, preserve sign bit   
                    13E3: 57          ASRB                       // shift B right 1, preserve sign bit 
                    13E4: DB 5F       ADDB  $5F                  // B+= least significant byte of player blitter destination (the vertical component) 
                    13E6: C1 EA       CMPB  #$EA                 // at very bottom of playfield?
                    13E8: 23 02       BLS   $13EC                // if <= bottom of playfield goto $13EC
                    13EA: C6 EA       LDB   #$EA
                    13EC: C1 18       CMPB  #$18                 // >= top of playfield (#$18 is 24 decimal)?
                    13EE: 24 0A       BCC   $13FA                // yes
                    13F0: C1 0C       CMPB  #$0C
                    13F2: 24 04       BCC   $13F8
                    13F4: C6 EA       LDB   #$EA
                    13F6: 20 02       BRA   $13FA

                    13F8: C6 18       LDB   #$18
                    13FA: E0 0C       SUBB  $000C,X               // B-= Y coordinate (whole part) of enforcer
                    13FC: 82 00       SBCA  #$00
                    13FE: 58          ASLB  
                    13FF: 49          ROLA  
                                    //
                // if you want to see how the deltas affect the vertical movement of the enforcer, or indeed any omnidirectional object, put a breakpoint on the line below,
                // and just before executing the instruction, set register D to 0, $FF00 or $0100 in the MAME debugger.
                // $FF00 = move up, $0100 = move down.If you set D to 0, there will no movement on the vertical axis at all.
                // Tinker with the least significant byte (the fractional part) to have the enforcer move in oblique angles.
                //
                1400: ED 88 10    STD   $10,X                 // set Y delta of enforcer
                1403: 39          RTS   

//
                // Enforcer missiles are called "sparks".  As you can see from this function, there's a maximum of 20 on screen at once.
                //

                CREATE_SPARK:
                1404: 34 50       PSHS  U,X
                1406: 1F 12       TFR   X,Y
                1408: B6 BE 5F    LDA   $BE5F                // read enforcer spark control variable
                140B: BD D0 3F    JSR   $D03F                // JMP $D6B6 - get a random number lower than or equal to A
                140E: A7 4D       STA   $000D,U              // store in "countdown before fire next spark" field
                1410: 96 8A       LDA   $8A                  // get count of sparks on screen
                1412: 81 14       CMPA  #$14                 // compare to #$14 (20 decimal)
                1414: 24 6B       BCC   $1481                // if count >= 20 decimal, goto 1481. Can't create any more sparks
                1416: 96 42       LDA   $42
                1418: 81 11       CMPA  #$11
                141A: 24 65       BCC   $1481
                141C: BD D0 6C    JSR   $D06C                // JMP $D32B - create entity with params and add to linked list at $9817
                141F: 14 A8       // address of function to call after 1 game cycle
                1421: 1A 34       // animation frame metadata pointer to spark first frame
                1423: 14 DC       // address of routine to handle collision
                1425: 27 5A       BEQ   $1481
                1427: 0C 8A       INC   $8A                  // increment number of sparks on screen 
                1429: EC 24       LDD   $0004,Y
                142B: A7 0A       STA   $000A,X              // store A in X coordinate (whole part) of spark
                142D: E7 0C       STB   $000C,X              // store B in Y coordinate of spark
                142F: ED 04       STD   $0004,X              // store D in blitter destination of spark
                //
// After doing a bit of toying about with the A and B registers, I've deduced this part of the CREATE_SPARK function is to calculate the 
// spark's initial angle, speed and longevity.
//
1431: D6 84       LDB   $84                  // get a random number into B
1433: C4 1F       ANDB  #$1F                 // and with #$1F (preserve bits 0..5) giving a number from 0..31 decimal
1435: CB F0       ADDB  #$F0                 // B+= #$F0   (240 decimal) - or you could look at it this way, B -= #$0F
1437: 96 5E       LDA   $5E                  // get player's blitter destination hi byte
1439: 81 17       CMPA  #$17                 
143B: 24 01       BCC   $143E                // if >= #$17, goto 143E  
143D: 5F          CLRB                                               
143E: DB 5E       ADDB  $5E                  // add player's blitter destination hi byte
1440: 4F          CLRA  
1441: E0 04       SUBB  $0004,X              // B-= spark's blitter destination hi byte
1443: 82 00       SBCA  #$00                 // if the subtraction caused a carry, make A = $FF, else A=0  
1445: 58          ASLB  
1446: 49          ROLA                         
1447: 58          ASLB  
1448: 49          ROLA            
1449: ED 0E       STD   $000E,X              // set X delta of object
144B: D6 86       LDB   $86
144D: C4 1F       ANDB  #$1F
144F: CB F0       ADDB  #$F0
1451: DB 5F       ADDB  $5F                  // add player's blitter destination lo byte
1453: 4F          CLRA  
1454: E0 05       SUBB  $0005,X              // B-= spark's blitter destination lo byte
1456: 82 00       SBCA  #$00                 // if the subtraction caused a carry, make A = $FF, else A=0
1458: 58          ASLB  
1459: 49          ROLA  
145A: 58          ASLB  
145B: 49          ROLA  
145C: ED 88 10    STD   $10,X                // set Y delta of object
145F: D6 86       LDB   $86                  // get a random number  
1461: C4 1F       ANDB  #$1F
1463: CB F0       ADDB  #$F0
1465: 1D          SEX                        // make D = sign extended version of B   
1466: ED 49       STD   $0009,U              // set X curvature factor
1468: D6 85       LDB   $85                  // get a random number
146A: C4 1F       ANDB  #$1F
146C: CB F0       ADDB  #$F0
146E: 1D          SEX                        // make D = sign extended version of B
146F: ED 4B       STD   $000B,U              // set Y curvature factor
1471: 9F 17       STX   $17
1473: 96 85       LDA   $85                  // get a "random" number (probably same value as $1468)
1475: 84 0F       ANDA  #$0F                 // mask in 4 least significant bits leaving a number 0- #$0F (15 decimal)
1477: 8B 14       ADDA  #$14                 // add #$14 (20 decimal) to the result
1479: A7 4E       STA   $000E,U              // set counter for how long this spark will live
147B: CC 11 56    LDD   #$1156
147E: BD D0 4B    JSR   $D04B                // JMP $D3C7 - play sound with priority
1481: 35 D0       PULS  X,U,PC //(PUL? PC=RTS)


ENFORCER_COLLISION_HANDLER:
1483: 96 48       LDA   $48                  // called by player collision detection?
1485: 26 20       BNE   $14A7                // yes
1487: BD D0 78    JSR   $D078                // JMP $D320 - deallocate object, and its metadata, and erase object from screen
148A: 9E 1B       LDX   $1B                  // X = pointer to free object linked list 
148C: EC 84       LDD   ,X                   
148E: DD 1B       STD   $1B                  // mark this object as the first entry in the free object linked list
1490: BD 5B 43    JSR   $5B43                // JMP $5C1F - create an explosion              
1493: DC 1B       LDD   $1B
1495: ED 84       STD   ,X
1497: 9F 1B       STX   $1B
1499: 0A ED       DEC   temp_enforcer_count
149B: CC 01 15    LDD   #$0115
149E: BD D0 0C    JSR   $D00C                // JMP $DB9C - update player score
14A1: CC 11 5B    LDD   #$115B
14A4: 7E D0 4B    JMP   $D04B                // JMP $D3C7 - play sound with priority
14A7: 39          RTS   



ANIMATE_SPARK:
14A8: AE 47       LDX   $0007,U              // get pointer to enforcer object from object metadata
14AA: EC 02       LDD   $0002,X              // get animation frame metadata pointer
14AC: C3 00 04    ADDD  #$0004               // bump 4 to move to next animation frame metadata
14AF: 10 83 1A 40 CMPD  #$1A40               // gone past end of animation frame metadata list?              
14B3: 23 03       BLS   $14B8                // if not, go to $14B8 
14B5: CC 1A 34    LDD   #$1A34               // pointer to start of spark animation
14B8: ED 02       STD   $0002,X              // set animation frame metadata pointer

// 
14BA: EC 0E       LDD   $000E,X              // read X delta of object
14BC: E3 49       ADDD  $0009,U              // take into account curvature factor of spark
14BE: ED 0E       STD   $000E,X              // and store back to X delta
14C0: EC 88 10    LDD   $10,X                // read Y delta of object
14C3: E3 4B       ADDD  $000B,U              // take into account curvature factor of spark
14C5: ED 88 10    STD   $10,X                // and store back to Y delta
14C8: 6A 4E       DEC   $000E,U              // life counter, when zero the spark disappears.
14CA: 27 08       BEQ   $14D4
14CC: 86 04       LDA   #$04                 // delay before calling function
14CE: 8E 14 A8    LDX   #$14A8               // address of next function to call for this object 
14D1: 7E D0 66    JMP   $D066                // JMP $D1E3 - allocate task

// spark has burnt out
14D4: BD D0 75    JSR   $D075                // JMP $D31B - deallocate object and erase object from screen               
14D7: 0A 8A       DEC   $8A                  // decrement count of sparks on screen
14D9: 7E D0 63    JMP   $D063                // JMP $D1F3 - free object metadata and process next task

14DC: 96 48       LDA   $48                  // player collision detection?
14DE: 26 11       BNE   $14F1                // yes
14E0: BD D0 78    JSR   $D078                // JMP $D320 - deallocate object, and its metadata, and erase object from screen
14E3: 0A 8A       DEC   $8A                  // decrement count of sparks on screen
14E5: CC 00 25    LDD   #$0025
14E8: BD D0 0C    JSR   $D00C                // JMP $DB9C - update player score
14EB: CC 11 60    LDD   #$1160
14EE: 7E D0 4B    JMP   $D04B                // JMP $D3C7 - play sound with priority





                INITIALISE_ALL_BRAINS:
                1AF4: 0F 95       CLR   $95                  // clear "progging" flag
                1AF6: B6 BE 6E    LDA   cur_brains           // get count of brains
                1AF9: 34 02       PSHS  A                    // save on the stack
                1AFB: 27 58       BEQ   $1B55                // exit if count == 0
                1AFD: D6 95       LDB   $95

                //
                // Security related code.
                //
                1AFF: 10 8E D0 15 LDY   #$D015
                1B03: EB A4       ADDB  ,Y                   // B+= *Y
                1B05: 31 28       LEAY  $0008,Y              // Y = Y + 8 
                1B07: 10 8C EA B1 CMPY  #$EAB1            
                1B0B: 25 F6       BCS   $1B03
                1B0D: C1 4A       CMPB  #$4A                 // if after all that adding in $1b03 the total is #$4A... (For the blue label this is always true)
                1B0F: 27 0E       BEQ   $1B1F                // The ROM hasn't been tampered with, security check passes, so goto $1B1F. 

                // corrupt game state deliberately. 
                1B11: 96 85       LDA   $85
                1B13: 81 20       CMPA  #$20
                1B15: 24 08       BCC   $1B1F
                1B17: 86 98       LDA   #$98               
                1B19: D6 86       LDB   $86
                1B1B: 1F 02       TFR   D,Y                  // so Y will be #$98xx, which is where game state resides.
                1B1D: 63 A4       COM   ,Y                   // Change game state and ruin the game...


                    // normal game resumes
                    1B1F: BD D0 54    JSR   $D054                // JMP $D281 - reserve object metadata entry and call function
                    1B22: 1B D8          // pointer to function    

                    1B24: 33 84       LEAU  ,X                   // U = X = object metadata entry
                    1B26: BD D0 7B    JSR   $D07B                // JMP $D2DA - reserve entry in list used by grunts, hulks, brains, progs, cruise missiles and tanks (starts at $9821)
                    // X= object entry
                    1B29: CC 21 59    LDD   #$2159               // pointer to animation frame metadata for brain standing still (start of wave)
                    1B2C: ED 02       STD   $0002,X              // set current animation frame metadata pointer
                    1B2E: ED 88 14    STD   $14,X                // set previous animation frame metadata pointer (previous = current)
                    1B31: EF 06       STU   $0006,X              // set pointer to object metadata
                    1B33: AF 47       STX   $0007,U              // set pointer to object in object metadata
                    1B35: CC 1C B2    LDD   #$1CB2               // *pointer to pointer* to animation frame metadata of brain moving down (as you see at the start of the wave)
                    1B38: ED 4D       STD   $000D,U              // store in object metadata
                    1B3A: 6F 4B       CLR   $000B,U              // clear animation table index (0-based)
                    1B3C: CC 1D D6    LDD   #$1DD6               // address of routine to call when brain is shot
                    1B3F: ED 08       STD   $0008,X
                    1B41: 8D 14       BSR   $1B57                // set the brain's initial position
                    1B43: BD 1B 95    JSR   $1B95                // find nearest family member to prog
                    // Y = family member
                    1B46: B6 BE 62    LDA   $BE62                // read brain cruise missile fire delay field
                    1B49: BD D0 3F    JSR   $D03F                // JMP $D6B6 - get a random number lower than or equal to A
                    1B4C: A7 4C       STA   $000C,U              // set countdown to fire cruise missile
                    1B4E: BD D0 18    JSR   $D018                // JMP $DAF2 - do blit
                    1B51: 6A E4       DEC   ,S                   // reduce count of brains left to initialise on stack
                    1B53: 26 CA       BNE   $1B1F                // if !=0 , do next brain
                    1B55: 35 82       PULS  A,PC //(PUL? PC=RTS)


                    SET_BRAIN_INITIAL_POSITION:
                    1B57: BD 26 C3    JSR   $26C3                // JMP $3199 - get random position on playfield for object (returns: A = X coordinate, B = Y coordinate)
                    1B5A: ED 04       STD   $0004,X              // set blitter destination
                    1B5C: A7 0A       STA   $000A,X              // set brain X coordinate (whole part)
                    1B5E: E7 0C       STB   $000C,X              // set brain Y coordinate
                    1B60: 10 AE 02    LDY   $0002,X              // Y = pointer to animation frame metadata             
                    1B63: 0D 84       TST   $84                  // read random number variable
                    1B65: 2B 17       BMI   $1B7E                // if bit 7 is set goto $1b7e, to do some tinkering with the Y component of the brain position.
                    1B67: 86 10       LDA   #$10                 // number to multiply by (16 decimal)
                    1B69: BD D0 42    JSR   $D042                // JMP $D6AC - multiply A by a random number and put result in A
                    // A = result of multiplication
                    1B6C: 0D 85       TST   $85                  // read another random number variable
                    1B6E: 2B 04       BMI   $1B74                // if bit 7 is set (number is negative) goto $1b74   
                    1B70: 8B 07       ADDA  #$07                 // add in left border coordinate 
                    1B72: 20 05       BRA   $1B79
                    1B74: AB A4       ADDA  ,Y                   // add width of brain image to A
                    1B76: 40          NEGA                       // A = -A  
                    1B77: 8B 8F       ADDA  #$8F                 // #$8F is furthest permissible right position on playfield. So calc is: A= (#$8F - Abs(A))
                    1B79: A7 04       STA   $0004,X              // set most significant byte of blitter destination 
                    1B7B: A7 0A       STA   $000A,X              // set brain X coordinate (whole part)
                    1B7D: 39          RTS   

                        //
                        // this piece of code adjusts the Y component of the brain's position.
                        //
                        1B7E: 86 20       LDA   #$20
                        1B80: BD D0 42    JSR   $D042                // JMP $D6AC - multiply A by a random number and put result in A
                        // A = result of multiplication
                        1B83: 0D 86       TST   $86                  // read yet another random number variable
                        1B85: 2B 04       BMI   $1B8B                // if bit 7 is set (number is negative) goto $1B8B
                        1B87: 8B 18       ADDA  #$18                 // add in top border coordinate
                        1B89: 20 05       BRA   $1B90

                        1B8B: AB 21       ADDA  $0001,Y              // add height of brain image to A
                        1B8D: 40          NEGA                       // A= -A 
                        1B8E: 8B EA       ADDA  #$EA                 // #$EA is furthermost permissible down position on playfield. So calc is: A = (#$EA - Abs(A))
                        1B90: A7 05       STA   $0005,X              // store in least significant byte of blitter destination (the Y part)
                        1B92: A7 0C       STA   $000C,X              // set Y coordinate of brain position (whole part)
                        1B94: 39          RTS   


                    // Find the nearest family member to program. 
                    //
                    // Now here's where the infamous "brains all go for the same family member" bug (or "feature" depending what way you look at it) resides.
                    //
                    // On starting wave 5 and inspecting the list entries, I found that the family member entries aren't in the list by the time this function has been called.
                    // All entries in the list are NULL (WORD 0). As the algorithm to find a family member finds NULL in every value, it by default returns a pointer to the 
                    // first entry of the list: $B354.  Thus, *all* Brains get a target of $B354.
                    //
                    // When $B354 *is* populated with a pointer to a family member, as the wave begins or shortly thereafter, guess what family member gets the slot? That's right - Mikey!
                    // That's why all Brains go for Mikey straight away.
                    //
                    // if this function was called *after* all family members were added to the list on wave start, it would work properly.
                    //
                    // Expects:
                    // X = pointer to brain object
                    //
                    // returns: Y = pointer to entry in family member list (e.g. $B354)
                    //
                    // 

                    FIND_NEAREST_FAMILY_MEMBER_TO_PROG:
                    1B95: CC FF FF    LDD   #$FFFF               // D = closest distance 
                    1B98: 10 8E B3 54 LDY   #$B354               // start of family member pointer list.  
                    1B9C: 34 66       PSHS  U,Y,B,A
                    1B9E: EE A4       LDU   ,Y                   // read family member pointer from list
                    1BA0: 27 28       BEQ   $1BCA                // if null, goto $1BCA
                    1BA2: 4F          CLRA                      
                    1BA3: E6 44       LDB   $0004,U              // get blitter destination hi byte (X component of address) of family member into B                
                    1BA5: E0 04       SUBB  $0004,X              // B-= blitter destination hi byte (X coordinate) of brain
                    1BA7: 82 00       SBCA  #$00                 // if there's a carry, A will be made #$FF and the bpl below will not execute                     
                    1BA9: 2A 04       BPL   $1BAF                  
                    1BAB: 43          COMA                       // these 2 lines negate D, making D a positive number again                           
                    1BAC: 50          NEGB                       //                                  
                    1BAD: 82 FF       SBCA  #$FF                 // A+= -1
                    1BAF: DD 2B       STD   $2B
                    1BB1: 4F          CLRA  
                    1BB2: E6 45       LDB   $0005,U              // get blitter destination lo byte (Y component of screen address) of family member
                    1BB4: E0 05       SUBB  $0005,X              //
                    1BB6: 82 00       SBCA  #$00                 // if there's a carry, A will be made #$FF and the bpl below will not execute 
                    1BB8: 2A 04       BPL   $1BBE
                    1BBA: 43          COMA                       // these 2 lines negate D, making D a positive number again  
                    1BBB: 50          NEGB  
                    1BBC: 82 FF       SBCA  #$FF                 // A+= -1
                    1BBE: D3 2B       ADDD  $2B
                    1BC0: 10 A3 E4    CMPD  ,S                   // is D, our distance, higher than the "distance to nearest family member" value on the stack?
                    1BC3: 22 05       BHI   $1BCA                // yes, we've not found a family member closer this time, goto $1BCA
                    1BC5: ED E4       STD   ,S                   // no, this distance is lower than previous "closest", so record the "closer" distance.
                    1BC7: 10 AF 62    STY   $0002,S              // and update Y (pointer to the current closest family member ) on stack. 
                    1BCA: 31 22       LEAY  $0002,Y              // Y += 2. Point to next family member pointer in list
                    1BCC: 10 8C B3 A4 CMPY  #$B3A4               // at end of family member list?
                    1BD0: 26 CC       BNE   $1B9E                // if not at end of list, goto $1B9E
                    1BD2: 35 66       PULS  A,B,Y,U              // Y will now hold the closest family member
                    1BD4: 10 AF 49    STY   $0009,U              // store family member as brain target
                    1BD7: 39          RTS   

                    1BD8: 96 59       LDA   $59
                    1BDA: 85 7F       BITA  #$7F
                    1BDC: 27 08       BEQ   $1BE6                
                    1BDE: 86 04       LDA   #$04                 // delay before calling function
                    1BE0: 8E 1B D8    LDX   #$1BD8               // address of function to call (this one!)
                    1BE3: 7E D0 66    JMP   $D066                // JMP $D1E3 - allocate task

                    1BE6: 86 0C       LDA   #$0C                 // delay before calling function
                    1BE8: 8E 1B EE    LDX   #$1BEE               // function to call (animate brain)
                    1BEB: 7E D0 66    JMP   $D066                // JMP $D1E3 - allocate task



                    BRAIN_AI:
                    1BEE: AE 47       LDX   $0007,U              // get pointer to brain object into X                            
                    1BF0: CC 00 00    LDD   #$0000               // clear horizontal and vertical movement temp variables 
                    1BF3: DD 2B       STD   $2B
                    1BF5: 10 AE D8 09 LDY   [$09,U]              // is our target still alive?             
                    1BF9: 26 14       BNE   $1C0F                // if target is not null then it is alive, goto $1C0F
                    1BFB: 10 8E 98 5A LDY   #$985A               // Brain needs a target. $985A is the player object. 
                    1BFF: B6 BE 6A    LDA   cur_mommies          // count how many family members there are on screen
                    1C02: BB BE 6B    ADDA  cur_daddies
                    1C05: BB BE 6C    ADDA  cur_mikeys
                    1C08: 27 05       BEQ   $1C0F                // if 0 family members goto $1C0F - the brains will target the player
                    1C0A: BD 1B 95    JSR   $1B95                // otherwise, family members exist, so find nearest family member to program
                    // Y = target family member
                    1C0D: 20 E6       BRA   $1BF5

                    // here: X = brain, Y = target
                    ANIMATE_BRAIN:
                    1C0F: A6 24       LDA   $0004,Y              // get hi byte (X coordinate) of target's blitter destination into A
                    1C11: A0 04       SUBA  $0004,X              // A-= hi byte of brain blitter destination
                    1C13: 8B 02       ADDA  #$02                 // A+=2
                    1C15: 81 04       CMPA  #$04                 // 
                    1C17: 23 0B       BLS   $1C24                // if the brain's close enough on the horizontal axis to its target, it doesn't need to face left or right
                    1C19: C6 01       LDB   #$01                 // set horizontal movement direction to be right for this brain 
                    1C1B: A6 24       LDA   $0004,Y              // get hi byte of target blitter destination into A 
                    1C1D: A1 04       CMPA  $0004,X              // compare to hi byte of brain blitter destination
                    1C1F: 24 01       BCC   $1C22                // if target is to the right goto $1C22 
                    1C21: 50          NEGB                       // make B (our horizontal direction register) = $FF
                    1C22: D7 2B       STB   $2B                  // store horizontal movement value for brain (1= move brain right, $FF = move brain left)
                    1C24: A6 25       LDA   $0005,Y              // get lo byte (Y component) of target blitter destination into A             
                    1C26: C6 01       LDB   #$01                 // set vertical movement direction to be down for this brain
                    1C28: A1 05       CMPA  $0005,X              // 
                    1C2A: 24 01       BCC   $1C2D                // if target is below brain goto $1C2D
                    1C2C: 50          NEGB                       // make B (our vertical direction register) = $FF (up). The brain's target is above it 
                    1C2D: D7 2C       STB   $2C                  // store vertical movement direction for brain (1= move brain down, $FF = move brain up)
                    1C2F: EC 04       LDD   $0004,X              // get blitter destination of brain 
                    1C31: 9B 2B       ADDA  $2B                  // add horizontal movement value (see $1C22)
                    1C33: DB 2C       ADDB  $2C                  // add vertical movement value (see $1C2D)
                    1C35: BD 00 06    JSR   $0006                // ensure brain stays in bounds
                    1C38: 27 04       BEQ   $1C3E                // if brain is in bounds goto $1C3E
                    1C3A: 90 2B       SUBA  $2B                  // otherwise undo the movement brain attempted to make 
                    1C3C: D0 2C       SUBB  $2C
                    1C3E: A7 0A       STA   $000A,X              // update brain's X coordinate (whole part)            
                    1C40: E7 0C       STB   $000C,X              // update brain's Y coordinate
                    1C42: 10 8C 98 5A CMPY  #$985A               // is player this brains target?
                    1C46: 27 10       BEQ   $1C58                // yes, goto $1C58

// if we get here, the brain is going after a family member.
// how close is this brain to the family member?
// X = brain object pointer, Y = family member pointer, D = brain's blitter position
1C48: E0 25       SUBB  $0005,Y              // B-= target's Y component of blitter destination          
1C4A: CB 03       ADDB  #$03                 // B+= 3, to adjust B. I find the reason for this hard to explain even though I know "why" in my head.  
1C4C: C1 06       CMPB  #$06                 // is target 6 pixels (or less) beneath the adjusted B? 
1C4E: 22 08       BHI   $1C58                // if >6 pixels beneath, target is out of reach, goto $1C58
1C50: A0 24       SUBA  $0004,Y              // A-= target's X coordinate
1C52: 8B 03       ADDA  #$03                 // A+= 3, to adjust A.
1C54: 81 06       CMPA  #$06                 // is target <=12 pixels to the right of the adjusted A? Remember 2 pixels per byte.
1C56: 23 6A       BLS   $1CC2                // if <= than 12 pixels, BEGIN PROGRAMMING THE HUMAN!!!!!!!!!!!!! (sorry, got carried away there.)
1C58: 96 2B       LDA   $2B                  // read horizontal direction temp field
1C5A: 27 0C       BEQ   $1C68                // if 0, meaning the brain is not moving horizontally, goto $1C68
1C5C: 2B 05       BMI   $1C63                // if $FF (up) goto $1C63
1C5E: CC 1C AA    LDD   #$1CAA               // pointer to walk right animation table
1C61: 20 11       BRA   $1C74

1C63: CC 1C A2    LDD   #$1CA2               // pointer to walk left animation table 
1C66: 20 0C       BRA   $1C74

1C68: 96 2C       LDA   $2C                  // read vertical direction temp field
1C6A: 2B 05       BMI   $1C71                // if bit 7 is set (ie: the value is negative) goto $1C71 to make brain walk up
1C6C: CC 1C B2    LDD   #$1CB2               // pointer to walk down animation table
1C6F: 20 03       BRA   $1C74

1C71: CC 1C BA    LDD   #$1CBA               // pointer to walk up animation table

// D = pointer to animation sequence table for brain (see $1CA2) 
1C74: 10 A3 4D    CMPD  $000D,U              // are we moving in a direction that uses the same animation sequence as the one last used?
1C77: 27 04       BEQ   $1C7D                // yes, no need to change the animation table we're using, goto $1C7D
1C79: ED 4D       STD   $000D,U              // no, different animation needed, set animation table pointer in object metadata 
1C7B: 20 08       BRA   $1C85

1C7D: E6 4B       LDB   $000B,U              // get index into animation table into B
1C7F: CB 02       ADDB  #$02                 // bump index to next entry 
1C81: C1 08       CMPB  #$08                 // have we hit the end of the animation sequence?
1C83: 25 01       BCS   $1C86                // if not, goto $1C86
1C85: 5F          CLRB                       // yes, so we need to reset the index into the animation table back to 0
1C86: E7 4B       STB   $000B,U              // and update the index to point to the correct animation frame metadata entry
1C88: 10 AE 4D    LDY   $000D,U              // Y = animation sequence table pointer
1C8B: EC A5       LDD   B,Y                  // D = *(animation sequence table pointer+index into table)
1C8D: ED 02       STD   $0002,X              // set animation frame metadata pointer to D
1C8F: BD D0 8D    JSR   $D08D                // JMP $DB2F - erase then re-blit object 
1C92: 6A 4C       DEC   $000C,U              // decrement cruise missile countdown. When zero, brain will fire a cruise missile.
1C94: 26 03       BNE   $1C99                
1C96: BD 20 06    JSR   $2006                // fire a cruise missile! 
1C99: 8E 1B EE    LDX   #$1BEE               // pointer to "animate brain" routine
1C9C: B6 BE 63    LDA   $BE63                // delay before calling function
1C9F: 7E D0 66    JMP   $D066                // JMP $D1E3 - allocate task

BRAIN_ANIMATION_TABLES:
1CA2: 21 41                                  // address of animation frame metadata for brain walking left #1 
1CA4: 21 45                                  // address of animation frame metadata for brain walking left #2 
1CA6: 21 41                                  // address of animation frame metadata for brain walking left #1
1CA8: 21 49                                  // address of animation frame metadata for brain walking left #3
1CAA: 21 4D                                  // address of animation frame metadata for brain walking right #1 
1CAC: 21 51                                  // do I really need to repeat myself :)  
1CAE: 21 4D 
1CB0: 21 55 
1CB2: 21 59                                  // address of animation frame metadata for brain moving down....
1CB4: 21 5D 
1CB6: 21 59 
1CB8: 21 61 
1CBA: 21 65                                  // address of animation frame metadata for brain moving up....   
1CBC: 21 69 
1CBE: 21 65 
1CC0: 21 6D 


//
// The brain's got a family member to program!
// X = pointer to brain object
// Y = pointer to family member object
//

BEGIN_PROGRAMMING_FAMILY_MEMBER:
1CC2: A6 0A       LDA   $000A,X              // get X coordinate (whole part) of brain 
1CC4: A1 24       CMPA  $0004,Y              // compare to hi byte (X component) of family member blitter destination 
1CC6: 25 12       BCS   $1CDA                // if brain.X <= family member.X goto $1CDA
1CC8: A6 0A       LDA   $000A,X              // get X coordinate (whole part) of brain         
1CCA: A0 B8 02    SUBA  [$02,Y]              // subtract width of family member being prog'd
1CCD: 80 01       SUBA  #$01
1CCF: 81 07       CMPA  #$07                 // is the result past the left edge of the playfield?
1CD1: 25 07       BCS   $1CDA                // yes, so result is invalid, goto $1CDA
1CD3: A7 2A       STA   $000A,Y              // set X coordinate of family member being prog'd. Now family member will be standing left of brain.
1CD5: CC 21 41    LDD   #$2141               // animation frame pointer of brain facing left, ready to program human
1CD8: 20 0D       BRA   $1CE7
1CDA: A6 0A       LDA   $000A,X              // get X coordinate (whole part) of brain 
1CDC: 8B 08       ADDA  #$08                 // X coordinate += 8 (16 pixels)
1CDE: 81 8B       CMPA  #$8B                 // X coordinate > #$8B? is this sprite, when you take its width into account, off the playfield?  
1CE0: 24 E6       BCC   $1CC8                // yes, X coordinate is invalid, goto $1CC8
1CE2: A7 2A       STA   $000A,Y              // store to X coordinate of family member. Now family member will be standing right of brain. 
1CE4: CC 21 4D    LDD   #$214D               // animation frame pointer of brain facing right, ready to program human
1CE7: ED 02       STD   $0002,X              // update brain animation frame metadata pointer            
1CE9: A6 0C       LDA   $000C,X              // read brain Y coordinate
1CEB: 8B 02       ADDA  #$02                 // Y+ = 2
1CED: A7 2C       STA   $000C,Y              // set family member Y coordinate. 
1CEF: BD D0 15    JSR   $D015                // JMP $DB03 - erase object from screen
1CF2: 6F 0B       CLR   $000B,X
1CF4: 6F 88 12    CLR   $12,X                // clear flag for image to be shifted right one pixel
1CF7: BD 1D AF    JSR   $1DAF                // draw brain in programming mode!!
// done the brain prep, now do the prog prep.
1CFA: AE D8 09    LDX   [$09,U]              // get pointer to family member object from family member list ($B354 - $B3A4.)              
1CFD: 34 50       PSHS  U,X
1CFF: 86 01       LDA   #$01
1D01: 97 95       STA   $95                  // set "you are being prog'd!" flag which collision handler will read 
1D03: AD 98 08    JSR   [$08,X]              // call family member's collision handler
1D06: 35 50       PULS  X,U
1D08: 0F 95       CLR   $95
1D0A: EC 84       LDD   ,X                   // mark family member object as free              
1D0C: DD 1B       STD   $1B
1D0E: AF 49       STX   $0009,U              // set brain's target in object metadata
1D10: 6F 0B       CLR   $000B,X
1D12: 6F 88 12    CLR   $12,X
1D15: 10 AE 06    LDY   $0006,X              // Y = pointer to family member object's metadata
1D18: EC 29       LDD   $0009,Y              // D = pointer to object metadata's very own animation frame metadata pointer. Confused? 
1D1A: ED 02       STD   $0002,X              // set family member objects animation frame metadata pointer (to "standing still" image)
1D1C: 86 14       LDA   #$14                 // count of how long to make prog shake for (see $1D7A)
1D1E: A7 4B       STA   $000B,U
1D20: AE 47       LDX   $0007,U              // get pointer to brain object from brain object's metadata
1D22: CC 1A EA    LDD   #$1AEA
1D25: BD D0 4B    JSR   $D04B                // JMP $D3C7 - play sound with priority 
1D28: BD 1D AF    JSR   $1DAF                // draw the brain prog'ing away. 
1D2B: AE 49       LDX   $0009,U              // X = pointer to family member object from brain object's metadata
1D2D: EC 04       LDD   $0004,X              // D = blit destination of family member
1D2F: 10 AE 02    LDY   $0002,X              // Y = pointer to animation frame metadata
1D32: BD D0 1E    JSR   $D01E                // JMP $DABF: clear image rectangle
1D35: A6 0A       LDA   $000A,X              // A = X coordinate (whole part) 

DRAW_PROG_STARTING_TO_SHAKE:
1D37: D6 84       LDB   $84                  // get a random number
1D39: C4 07       ANDB  #$07                 // mask in bits 0..2, giving us a number between 0..7 in B
1D3B: EB 0C       ADDB  $000C,X              // B = B + Y coordinate
1D3D: C1 DC       CMPB  #$DC                 // B <= #$DC? (will the shaking prog be drawn within the playfield?)
1D3F: 23 02       BLS   $1D43                // yes, no need to adjust Y, goto $1D43             
1D41: C6 DC       LDB   #$DC                 // No, so make B #$DC. The prog's Y coordinate has been adjusted to keep it in the playfield. 
1D43: ED 04       STD   $0004,X              // blit destination = D            
1D45: CC AA BB    LDD   #$AABB               // set remap colour 1 and 2
1D48: 8D 78       BSR   $1DC2                // draw rectangle in colour A, then family member image as solid with colour B    
1D4A: 86 02       LDA   #$02                 // delay before calling function
1D4C: 8E 1D 52    LDX   #$1D52               // address of function to call
1D4F: 7E D0 66    JMP   $D066                // JMP $D1E3 - allocate task


1D52: AE 49       LDX   $0009,U              // X = pointer to family member object being programmed
1D54: EC 04       LDD   $0004,X              // D = blitter destination
1D56: 10 AE 02    LDY   $0002,X              // Y = pointer to animation frame metadata
1D59: BD D0 1E    JSR   $D01E                // JMP $DABF: clear image rectangle

// this is another part that makes the prog "shake" vertically as the Brain is programming it...
1D5C: A6 0A       LDA   $000A,X              // A = X coordinate (whole part)
1D5E: D6 84       LDB   $84                  // get a random number into B
1D60: C4 07       ANDB  #$07                 // make number from 0..7
1D62: 50          NEGB                       
1D63: EB 0C       ADDB  $000C,X              // B += Y coordinate. This gives us a coordinate to draw the shaking prog at - but we never update the prog's actual Y coordinate in memory
1D65: C1 18       CMPB  #$18                 // is B > top border wall of game ?
1D67: 24 02       BCC   $1D6B                // Yes, calculated Y coordinate is within game bounds, no need to adjust it, goto $1D6B
1D69: C6 18       LDB   #$18                 // otherwise draw prog at very top of game confines
1D6B: ED 04       STD   $0004,X              // blit destination = D            
1D6D: CC AA BB    LDD   #$AABB               // set remap colour 1 and 2
1D70: 8D 50       BSR   $1DC2                // draw rectangle in colour A, then family member as solid with colour B
1D72: 86 02       LDA   #$02                 // delay before calling function
1D74: 8E 1D 7A    LDX   #$1D7A               // address of function to call
1D77: 7E D0 66    JMP   $D066                // JMP $D1E3 - allocate task           

1D7A: 6A 4B       DEC   $000B,U              // decrement the prog'ing countdown. When 0 the prog'ing is done
1D7C: 26 A2       BNE   $1D20                // if countdown !=0 then goto 1D20, keep drawing brain proging and family member being prog'd. 
1D7E: CC 1A EF    LDD   #$1AEF
1D81: BD D0 4B    JSR   $D04B                // JMP $D3C7 - play sound with priority
1D84: AE 49       LDX   $0009,U              // get pointer to family member target from brain object metadata
1D86: DC 1B       LDD   $1B
1D88: ED 84       STD   ,X
1D8A: 9F 1B       STX   $1B                  // mark family member as a free object (the programming's done!)
1D8C: EC 04       LDD   $0004,X              // D = blitter destination
1D8E: 10 AE 02    LDY   $0002,X              // Y = pointer to animation frame metadata
1D91: BD D0 1E    JSR   $D01E                // JMP $DABF: clear image rectangle
// no idea why these are reloaded here, the previous subroutine saved D on stack and didn't corrupt Y
1D94: EC 04       LDD   $0004,X              // D = blitter destination                    
1D96: 10 AE 02    LDY   $0002,X              // Y = pointer to animation frame metadata
1D99: BD 1E 19    JSR   $1E19                // create the prog
1D9C: AE 47       LDX   $0007,U              // get pointer to object from object metadata
1D9E: EC 04       LDD   $0004,X              // D = blitter destination
1DA0: 10 AE 02    LDY   $0002,X              // Y = pointer to animation frame metadata
1DA3: BD D0 1E    JSR   $D01E                // JMP $DABF: clear image rectangle
1DA6: BD D0 18    JSR   $D018                // JMP $DAF2 - do blit
1DA9: BD 1B 95    JSR   $1B95                // find another family member to prog!!!!
1DAC: 7E 1B EE    JMP   $1BEE


DRAW_BRAIN_IN_PROGGING_STATE:
1DAF: C6 BB       LDB   #$BB                 // remap colour
1DB1: D7 2D       STB   $2D
1DB3: A6 0A       LDA   $000A,X              // A = object X coordinate (whole part)
1DB5: E6 0C       LDB   $000C,X              // read object Y coordinate
1DB7: ED 04       STD   $0004,X              // set blitter destination pointer
1DB9: 10 AE 02    LDY   $0002,X              // Y = pointer to animation frame metadata
1DBC: BD D0 93    JSR   $D093                // JMP $DA61 - blit rectangle with colour remap 
1DBF: 7E D0 18    JMP   $D018                // JMP $DAF2 - do blit


// Blit an image as a single solid colour, with another solid colour as its background.
// Think of when the progs are being programmed, mommy/daddy/mikey is drawn as a solid shape
// and has a rapidly cycling background colour.
//
// X = object pointer
// A = solid colour to draw as rectangular background
// B = solid colour to draw image belonging to X in
//

BLIT_IMAGE_AS_SOLID_COLOUR_WITH_SOLID_BACKGROUND:
1DC2: 34 06       PSHS  B,A
1DC4: 97 2D       STA   $2D                  // store remap colour 1                             
1DC6: EC 04       LDD   $0004,X              // D = blitter destination
1DC8: BD D0 93    JSR   $D093                // JMP $DA61 - blit rectangle with colour remap
1DCB: A6 61       LDA   $0001,S              // A = B (remap colour 2)
1DCD: 97 2D       STA   $2D                  // $2D = remap colour 2
1DCF: A6 04       LDA   $0004,X              // get blitter destination
1DD1: BD D0 90    JSR   $D090                // JMP $DA9E - do solid and transparent blit
1DD4: 35 86       PULS  A,B,PC //(PUL? PC=RTS)


BRAIN_COLLISION_HANDLER:
1DD6: 96 48       LDA   $48                  // player collision detection?
1DD8: 26 3C       BNE   $1E16                // yes, goto $1E16. We don't do anything here.
1DDA: 7A BE 6E    DEC   cur_brains           // oh dear, the brain's been hit by a laser. Reduce brain count
1DDD: BD 5B 4F    JSR   $5B4F                // JMP $5C0A
1DE0: BD D0 7E    JSR   $D07E                // JMP $D2C2 - remove baddy from baddies list
1DE3: AE 06       LDX   $0006,X              // X = pointer to object metadata for this object
1DE5: 33 84       LEAU  ,X
1DE7: BD D0 5D    JSR   $D05D                // JMP $D218 - deallocate object metadata entry
1DEA: EC 42       LDD   $0002,U
1DEC: 10 83 1D 52 CMPD  #$1D52
1DF0: 25 17       BCS   $1E09
1DF2: AE 49       LDX   $0009,U              // get pointer to family member target from brain object metadata
1DF4: DC 1B       LDD   $1B                  // get free object entry list pointer
1DF6: ED 84       STD   ,X                   // store the family member object as next object in free object linked list
1DF8: 9F 1B       STX   $1B                  // make this dead family member object start of the free object entry linked list
1DFA: 10 AE 02    LDY   $0002,X              // Y = pointer to animation frame metadata
1DFD: EC 04       LDD   $0004,X              // D = blitter destination
1DFF: BD D0 1E    JSR   $D01E                // JMP $DABF: clear image rectangle
1E02: 0C 95       INC   $95
1E04: BD 00 09    JSR   $0009                // JSR $0351 - draw points value for family member saved from progging
1E07: 0F 95       CLR   $95
1E09: CC 1A CD    LDD   #$1ACD
1E0C: BD D0 4B    JSR   $D04B                // JMP $D3C7 - play sound with priority
1E0F: CC 01 50    LDD   #$0150
1E12: BD D0 0C    JSR   $D00C                // JMP $DB9C - update player score
1E15: 39          RTS   

1E16: 7E D0 18    JMP   $D018                // JMP $DAF2 - do blit


//
// D = blitter destination of family member that's been prog'd
// Y = pointer to animation frame metadata (so that prog can use frames of family member when rendering itself)

CREATE_PROG:
1E19: 34 56       PSHS  U,X,B,A
1E1B: DC 1D       LDD   $1D                  // do we have space for prog in the prog list?
1E1D: 27 34       BEQ   $1E53                // no, so goto $1E53, which is an RTS 
1E1F: 4F          CLRA  
1E20: 8E 1E AB    LDX   #$1EAB               // address of prog animation function to call
1E23: BD D0 5A    JSR   $D05A                // JMP $D243 - reserve object metadata entry in list @ $981D and call function in X 
1E26: 33 84       LEAU  ,X                   // U = object metadata entry
1E28: BD 1F FC    JSR   $1FFC                // call function to clear (zero) bytes 7..31 decimal in object metadata
1E2B: 86 11       LDA   #$11
1E2D: A7 4F       STA   $000F,U              // set prog trail index to start of trail list, which begins in memory at U + #$11 (17 decimal).
                                             // for more info on the "prog trail" see $1EFD
1E2F: BD D0 7B    JSR   $D07B                // JMP $D2DA - reserve entry in list used by grunts, hulks, brains, progs, cruise missiles and tanks (starts at $9821)
// X = pointer to reserved object
1E32: AF 47       STX   $0007,U              // save pointer to this prog object in prog object metadata 
1E34: EF 06       STU   $0006,X              // set pointer to metadata in this prog object
1E36: 10 AF 49    STY   $0009,U              // set pointer to animation frame metadata in object metadata (phew!)
1E39: 10 AF 02    STY   $0002,X              // set current animation frame metadata pointer 
1E3C: 10 AF 88 14 STY   $14,X                // set previous animation frame metadata pointer (previous = current)
1E40: EC E4       LDD   ,S                   // read D from stack (remember, A and B comprise 16 bit register D)
1E42: A7 0A       STA   $000A,X              // set X coordinate (whole part)
1E44: E7 0C       STB   $000C,X              // set Y coordinate
1E46: CC 1F 1F    LDD   #$1F1F               // address of function to call when this prog is in a collision
1E49: ED 08       STD   $0008,X                 
1E4B: 8D 08       BSR   $1E55                // compute distances from player for prog to move towards  
1E4D: 8D 22       BSR   $1E71                // set initial prog direction
1E4F: 4F          CLRA  
1E50: 5F          CLRB                       // D = 0 
1E51: ED 04       STD   $0004,X              // set blitter destination to be NULL
1E53: 35 D6       PULS  A,B,X,U,PC //(PUL? PC=RTS)


//
// This function here computes two signed bytes: X Distance and Y Distance. 
// The X Distance and Y Distance variables are added on to the Player X and Player Y coordinates respectively.
// The Prog will run to the resulting point(PlayerX + X Distance, PlayerY + Y Distance) coordinates - AS LONG AS THE
// COORDINATES ARE WITHIN PLAYFIELD BOUNDS. 
//
// Obviously, the smaller the distances, the closer the prog chases towards the player.
//

COMPUTE_X_AND_Y_DISTANCES_TO_CHASE:
1E55: 86 0F       LDA   #$0F                 // load A with 15 (decimal) 
1E57: BD D0 3F    JSR   $D03F                // JMP $D6B6 - get a random number lower than or equal to A
1E5A: 8B F0       ADDA  #$F0                 // A+= -16 (decimal). This will make the number in A negative
1E5C: 40          NEGA                       // make number positive
1E5D: 48          ASLA                       // multiply by 2  
1E5E: 48          ASLA                       // multiply by 2 again
1E5F: 8B E0       ADDA  #$E0                 // A+= -32
1E61: A7 4B       STA   $000B,U              // save as X Distance 
1E63: 86 12       LDA   #$12                 // load a with 18 decimal
1E65: BD D0 3F    JSR   $D03F                // JMP $D6B6 - get a random number lower than or equal to A
1E68: 8B ED       ADDA  #$ED                 // A+= -19 (decimal). This will make the number in A negative
1E6A: 40          NEGA                       // make number positive
1E6B: 48          ASLA                       // multiply by 2  
1E6C: 8B EE       ADDA  #$EE                 // A+= -18 (decimal)
1E6E: A7 4C       STA   $000C,U              // save as Y Distance
1E70: 39          RTS   


// Instead of me wittering on about X-axis and Y axis, I'll make this simple.
//
// A prog can move in the following directions:
//
// LEFT, RIGHT, UP, DOWN. That is all.
//
// No combinations thereof are permitted.
//

CHANGE_PROG_DIRECTION:
1E71: 96 85       LDA   $85                  // read a random number
1E73: 2B 18       BMI   $1E8D                // if negative (bit 7 set) goto $1E8D - make the prog move vertically                    

// if we get here, the prog is going to move horizontally...
1E75: 96 64       LDA   $64                  // Get player X coordinate
1E77: AB 4B       ADDA  $000B,U              // add in X distance, to give target X
1E79: 81 BF       CMPA  #$BF                 // is target X *way* off the playfield bounds??
1E7B: 23 02       BLS   $1E7F                // no, goto $1E7F
1E7D: 86 07       LDA   #$07                 // otherwise, set target X to be left border edge 
1E7F: A1 0A       CMPA  $000A,X              // compare to prog's X coordinate (whole part)
1E81: 23 05       BLS   $1E88                // if target X <= prog X, goto $1E88 to make the prog move LEFT

1E83: CC 1F D8    LDD   #$1FD8               // pointer to animation table to move prog RIGHT
1E86: 20 1B       BRA   $1EA3                // skip over the code that moves the prog vertically 

1E88: CC 1F CC    LDD   #$1FCC               // pointer to animation table to move prog LEFT
1E8B: 20 16       BRA   $1EA3                // skip over the code that moves the prog vertically

// if we get here, the prog is going to move vertically...
1E8D: 96 66       LDA   $66                  // Get player Y coordinate
1E8F: AB 4C       ADDA  $000C,U              // add in Y distance, to give target Y
1E91: 81 FC       CMPA  #$FC                 // is target Y *way* off the playfield bounds?
1E93: 23 02       BLS   $1E97                // 
1E95: 86 18       LDA   #$18
1E97: A1 0C       CMPA  $000C,X              // compare to prog's Y coordinate
1E99: 23 05       BLS   $1EA0                // if target Y<= prog Y, goto $1EA0 to make the prog move UP

1E9B: CC 1F E4    LDD   #$1FE4               // pointer to animation table to move prog DOWN          
1E9E: 20 03       BRA   $1EA3

1EA0: CC 1F F0    LDD   #$1FF0               // pointer to animation table to move prog  UP
1EA3: ED 4D       STD   $000D,U              // update animation table pointer for prog
1EA5: 86 FD       LDA   #$FD                 // set A to -3 decimal (this might look strange, but look at code at $1EB3, which adds 3 to this value before it is used)
1EA7: A7 88 13    STA   $13,X                // set index into animation tables
1EAA: 39          RTS   


ANIMATE_PROG:
1EAB: AE 47       LDX   $0007,U              // get pointer to object into X
1EAD: 10 AE 4D    LDY   $000D,U              // get pointer to prog animation table into Y (see $1FCC for description of animation table)
1EB0: A6 88 13    LDA   $13,X                // get index into animation tables (as each entry in the table takes 3 bytes, this number is a multiple of 3)
1EB3: 8B 03       ADDA  #$03                 // bump index to next entry in animation table, by adding 3
1EB5: 81 09       CMPA  #$09                 // there's 12 bytes per entry 
1EB7: 23 01       BLS   $1EBA                // if we're not at the end of the animation table then goto $1EBA
1EB9: 4F          CLRA                       // reset index - taking the animation back to the start
1EBA: A7 88 13    STA   $13,X                // set animation index
1EBD: 31 A6       LEAY  A,Y                  // Y = Y + A 
1EBF: E6 A4       LDB   ,Y                   // read offset into animation metadata list (see docs at $1FCC)
1EC1: 4F          CLRA                       // clear A so that doesn't affect the addition below   
1EC2: E3 49       ADDD  $0009,U              // add D to animation frame metadata list pointer. Now D points to animation frame metadata, used for the blit funcs.
1EC4: ED 02       STD   $0002,X              // set pointer to animation frame metadata
1EC6: EC 21       LDD   $0001,Y              // get direction deltas to add to X and Y coordinates (see $1FCC)  
1EC8: AB 0A       ADDA  $000A,X              // A += X coordinate of prog (whole part)
1ECA: EB 0C       ADDB  $000C,X              // B += Y coordinate of prog
1ECC: BD 00 06    JSR   $0006                // test that object is in bounds
1ECF: 26 13       BNE   $1EE4                // if zero flag not set, object coordinate is invalid, goto $1EE4 to change prog direction
1ED1: A7 0A       STA   $000A,X              // X coordinate (whole part) = A
1ED3: E7 0C       STB   $000C,X              // Y coordinate = B
1ED5: 96 84       LDA   $84                  // get a random number
1ED7: 81 F8       CMPA  #$F8                 // compare to #$F8 (248 decimal)
1ED9: 23 03       BLS   $1EDE                
1EDB: BD 1E 55    JSR   $1E55                // call COMPUTE_X_AND_Y_DISTANCES_TO_CHASE
1EDE: 96 86       LDA   $86                  // read a random number
1EE0: 81 E4       CMPA  #$E4                 // compare to #$E4 (228 decimal)
1EE2: 23 03       BLS   $1EE7                // if <= goto $1EE7, do not change prog direction
1EE4: BD 1E 71    JSR   $1E71                // change prog direction
1EE7: 10 AE 02    LDY   $0002,X              // Y = pointer to animation frame metadata
1EEA: A6 4F       LDA   $000F,U              // get prog trail list index into A
1EEC: EC C6       LDD   A,U                  // D = blitter destination
1EEE: BD D0 1E    JSR   $D01E                // JMP $DABF: clear image rectangle (erase the "tail" of the prog)
1EF1: CC EE 00    LDD   #$EE00               // colours               
1EF4: BD 1D C2    JSR   $1DC2                // draw rectangle in colour A, then prog as solid with colour B
1EF7: A6 0A       LDA   $000A,X              // A = X coordinate of prog (whole part)
1EF9: E6 0C       LDB   $000C,X              // B = Y coordinate of prog (whole part)
1EFB: ED 04       STD   $0004,X              // set blitter destination of object
1EFD: 1F 02       TFR   D,Y                  // Y = blitter destination
//
// The prog trail is a list - not a queue - of 7 pointers. Each pointer contains a screen address where blits of the prog have been made. 
// The prog trail is used to remember where the prog was blitted, so that the "trail" of the prog can be erased from the screen.
//
1EFF: A6 4F       LDA   $000F,U              // get prog trail list index
1F01: 10 AF C6    STY   A,U                  // * (A+U) = blitter destination 
1F04: 8B 02       ADDA  #$02                 // bump index to next item in prog trail, effectively "growing" the trail
1F06: 81 1F       CMPA  #$1F                 // are we at the end of the list?
1F08: 25 02       BCS   $1F0C                // no, goto $1F0C
1F0A: 86 11       LDA   #$11                 // reset prog trail index to start of list
1F0C: A7 4F       STA   $000F,U              // update prog trail index to be A
1F0E: 10 AE 02    LDY   $0002,X              // Y = animation frame metadata pointer
1F11: CC 00 AA    LDD   #$00AA               // remap colours 1 + 2. 
1F14: BD 1D C2    JSR   $1DC2                // blit solid background in A + then do solid and transparent blit with B 
1F17: 86 03       LDA   #$03                 // delay before calling function
1F19: 8E 1E AB    LDX   #$1EAB               // address of function to call
1F1C: 7E D0 66    JMP   $D066                // JMP $D1E3 - allocate task



PROG_COLLISION_DETECTION:
1F1F: 96 48       LDA   $48                  // is the player calling this function?
1F21: 26 44       BNE   $1F67                // yes, goto $1F67 (don't do anything) 
//
// The prog has been killed. We need to erase the trail of the prog, as well as the prog itself.
//
1F23: 34 10       PSHS  X                    // save pointer to prog object on stack
1F25: 10 AE 02    LDY   $0002,X              // Y = pointer to animation frame metadata
1F28: AE 06       LDX   $0006,X              // get pointer to object metadata for this object into X
1F2A: 86 11       LDA   #$11                 // start of prog trail which begins at (X + #$11) (#$11 is 17 decimal)
1F2C: 34 02       PSHS  A
1F2E: EC 86       LDD   A,X                  // Get pointer to where prog was blitted
1F30: BD D0 1E    JSR   $D01E                // JMP $DABF: clear image rectangle
1F33: 35 02       PULS  A
1F35: 8B 02       ADDA  #$02                 // bump to next entry in the prog trail   
1F37: 81 1F       CMPA  #$1F                 // have we reached the end of the trail? (ie: all segments of prog trail have been erased)
1F39: 25 F1       BCS   $1F2C                // no, goto $1F2C and clear rest of prog trail
1F3B: BD D0 5D    JSR   $D05D                // JMP $D218 - deallocate object metadata entry
1F3E: 35 10       PULS  X                    // restore pointer to prog object from stack
1F40: CC 1F 68    LDD   #$1F68               // pointer to animation frame metadata
1F43: ED 02       STD   $0002,X              // set current animation frame metadata pointer
1F45: 86 8A       LDA   #$8A
1F47: A1 04       CMPA  $0004,X              // compare to Hi byte (X component) of blitter destination
1F49: 24 02       BCC   $1F4D                // if A > #$8A (138 decimal) goto $1F4D
1F4B: A7 04       STA   $0004,X
1F4D: 86 DB       LDA   #$DB                 // 
1F4F: A1 05       CMPA  $0005,X              // compare to Lo byte (y component) of blitter destination
1F51: 24 02       BCC   $1F55                // if A > #$DB (219 decimal) goto $1F55
1F53: A7 05       STA   $0005,X
1F55: BD 5B 43    JSR   $5B43                // JMP $5C1F - create an explosion
1F58: BD D0 7E    JSR   $D07E                // JMP $D2C2 - remove baddy from baddies list
1F5B: CC 1A DA    LDD   #$1ADA
1F5E: BD D0 4B    JSR   $D04B                // JMP $D3C7 - play sound with priority
1F61: CC 01 10    LDD   #$0110
1F64: BD D0 0C    JSR   $D00C                // JMP $DB9C - update player score
1F67: 39          RTS   

// Animation frame metadata
1F68: 06 10 1F 6C 


1F6C: AA AA AA AA AA A0 AA 00 00 00 0A A0 
1F78: AA 0B B0 BB 0A A0 AA 0B B0 BB 0A A0 AA 0B B0 BB 
1F88: 0A A0 AA 00 00 00 0A A0 AA AA A0 AA AA A0 AA A0 
1F98: 00 00 AA A0 AA 00 00 00 0A A0 AA 0A 00 0A 0A A0 
1FA8: AA 0A 00 0A 0A A0 AA AA 0A 0A AA A0 AA AA 0A 0A 
1FB8: AA A0 AA AA 0A 0A AA A0 AA 00 0A 00 0A A0 AA AA 
1FC8: AA AA AA A0 


//
// Animation tables for prog.
//
// Byte 0: offset into family member animation metadata list.  
// Byte 1: signed offset to add to X coordinate of prog
// Byte 2: signed offset to add to Y coordinate of prog
//
//

PROG_ANIMATION_TABLES:

1FCC : 
00 FE 00 
04 FE 00 
00 FE 00 
08 FE 00 

1FD8: 
0C 02 00 
10 02 00 
0C 02 00 
14 02 00 

1FE4: 
18 00 04 
1C 00 04 
18 00 04 
20 00 04 

1FF0: 
24 00 FC 
28 00 FC 
24 00 FC 
2C 00 FC 


//
//
//

CLEAR_BYTES_7_TO_30_FROM_U:
1FFC: 86 07       LDA   #$07 
1FFE: 6F C6       CLR   A, U                   
2000: 4C          INCA  
2001: 81 1F       CMPA  #$1F                 // compare A to #$1F (31 decimal)
2003: 25 F9       BCS   $1FFE                // if lower, goto $1FFE
2005: 39          RTS   



//
// The missiles that Brains fire at the player are called "Cruise missiles"
//
//

CREATE_CRUISE_MISSILE:
2006: 34 50       PSHS  U,X
2008: B6 BE 62    LDA   $BE62                // read "maximum delay before firing cruise missile" global setting                
200B: BD D0 3F    JSR   $D03F                // JMP $D6B6 - get a random number lower than or equal to A
200E: A7 4C       STA   $000C,U              // set delay to fire next cruise missile in Brain
2010: 96 8E       LDA   $8E                  // get count of cruise missiles currently on screen                      
2012: 81 08       CMPA  #$08                 // 8?
2014: 24 43       BCC   $2059                // if >=8, we have enough missiles on screen as it is, goto $2059 (exit)
2016: DC 1D       LDD   $1D                  // do we have a slot for the cruise missile to go into?
2018: 27 3F       BEQ   $2059                // if not, goto $2059
201A: 31 84       LEAY  ,X                   // Y = X
201C: 4F          CLRA  
201D: 8E 20 B0    LDX   #$20B0               // address of cruise missile AI/animation  routine
2020: BD D0 5A    JSR   $D05A                // JMP $D243 - reserve object metadata entry in list @ $981D and add function pointed to by X to "task list" 
2023: 33 84       LEAU  ,X                   // X = pointer to object metadata entry. Now U = X. 
2025: 8D D5       BSR   $1FFC                // clear bytes (U+7 to U+31)
2027: BD D0 7B    JSR   $D07B                // JMP $D2DA - reserve entry in list used by grunts, hulks, brains, progs, cruise missiles and tanks (starts at $9821)
202A: CC 20 5B    LDD   #$205B               // pointer to collision detection animation frame metadata for cruise missile (see $D7F4) 
202D: ED 88 16    STD   $16,X                // 
2030: CC 20 6B    LDD   #$206B               // pointer to cruise missile animation frame metadata
2033: ED 02       STD   $0002,X              // set current animation frame metadata pointer
2035: ED 88 14    STD   $14,X                // set previous animation frame metadata pointer (previous = current)
2038: CC 21 19    LDD   #$2119               // set address of routine to call when shot
203B: ED 08       STD   $0008,X         
203D: EF 06       STU   $0006,X              // set pointer to object metadata in object
203F: AF 47       STX   $0007,U              // set pointer to object in object metadata
2041: EC 24       LDD   $0004,Y             
2043: C3 03 04    ADDD  #$0304
2046: ED 04       STD   $0004,X              // set "last" blitter destination             
2048: ED 0A       STD   $000A,X              // set coordinates             
204A: BD 20 7B    JSR   $207B                // pick direction for cruise missile to go in
204D: 0C 8E       INC   $8E                  // increment cruise missile count
204F: 86 0D       LDA   #$0D             
2051: A7 4C       STA   $000C,U              // reset "cruise missile trail" list index to beginning
2053: CC 1A E2    LDD   #$1AE2
2056: BD D0 4B    JSR   $D04B                // JMP $D3C7 - play sound with priority
2059: 35 D0       PULS  X,U,PC //(PUL? PC=RTS)

205B: 03 04 20 5F FF FF FF FF FF FF FF FF FF FF FF FF 

206B: 03 04 20 6F 00 00 00 00 FF 00 00 FF 00 00 00 00 


//
// Pick a direction for cruise missile
//

PICK_CRUISE_MISSILE_DIRECTION:
207B: CC 00 00    LDD   #$0000               
207E: ED 49       STD   $0009,U              // clear deltas of cruise missile
2080: 96 84       LDA   $84                  // get a random number
2082: 2A 13       BPL   $2097                // if bit 7 is not set, no adjustment of horizontal movement to be done, goto $2097
2084: 84 0F       ANDA  #$0F                 // mask off bottom 4 bits
2086: 8B FA       ADDA  #$FA                 // add -6 to A
2088: 9B 64       ADDA  $64                  // add in player's X coordinate ($9864) to give target X
208A: C6 01       LDB   #$01                 // X delta =1 (moving right) 
208C: A1 0A       CMPA  $000A,X              // compare A to cruise missile X coordinate
208E: 24 01       BCC   $2091                // if target X >= X coordinate, goto $2091                
2090: 50          NEGB                       // X delta = -1 (moving left)   
2091: E7 49       STB   $0009,U              // set X delta of cruise missile
2093: 96 86       LDA   $86                  // read a random number
2095: 2B 11       BMI   $20A8                // if bit 7 set, goto $20A8 
2097: 96 85       LDA   $85                  // get another random number
2099: 84 0F       ANDA  #$0F                 // mask off bottom 4 bits, to give a number from 0..15 in A
209B: 8B FA       ADDA  #$FA                 // add -6 to A
209D: C6 01       LDB   #$01                 // Y delta = 1 (moving down)
209F: 9B 66       ADDA  $66                  // add in player's Y coordinate ($9866)
20A1: A1 0B       CMPA  $000B,X              // compare A to cruise missile Y coordinate
20A3: 24 01       BCC   $20A6                // if A >= Y coordinate, goto $20A6
20A5: 50          NEGB                       // Y delta = -1 (moving up)  
20A6: E7 4A       STB   $000A,U              // set Y delta of cruise missile
20A8: 86 07       LDA   #$07
20AA: BD D0 3F    JSR   $D03F                // JMP $D6B6 - get a random number lower than or equal to A
20AD: A7 4B       STA   $000B,U              // set countdown before cruise missile changes direction
20AF: 39          RTS   


// Cruise missile AI & animation logic

ANIMATE_CRUISE_MISSILE:
20B0: AE 47       LDX   $0007,U              // get object pointer from object metadata
20B2: 6A 4B       DEC   $000B,U              // decrement countdown before cruise missile changes direction
20B4: 26 03       BNE   $20B9                // if countdown != 0, goto $20B9
20B6: BD 20 7B    JSR   $207B                // otherwise, countdown is zero, its time for cruise missile to change direction
20B9: BD 20 C7    JSR   $20C7                // move cruise missile (creating a trail)           
20BC: BD 20 C7    JSR   $20C7                // move cruise missile again (creating a trail)
20BF: 86 02       LDA   #$02                 // delay before calling function
20C1: 8E 20 B0    LDX   #$20B0               // address of function to call
20C4: 7E D0 66    JMP   $D066                // JMP $D1E3 - allocate task
 

MOVE_CRUISE_MISSILE:
20C7: EC 0A       LDD   $000A,X              // D = objects coordinates (MSB = X coordinate, LSB = Y coordinate). 
20C9: AB 49       ADDA  $0009,U              // add cruise missile's X delta to most significant byte of coordinate
20CB: 81 07       CMPA  #$07                 // cruise missile at left-most border?
20CD: 24 06       BCC   $20D5                // no, goto $20D5
20CF: A0 49       SUBA  $0009,U              // yes, cruise missile has reached edge of screen, can't move any further, so undo change made at $20C9
20D1: 60 49       NEG   $0009,U              // negate X delta of cruise missile (making it move in opposite direction horizontally)
20D3: 20 F4       BRA   $20C9

20D5: 81 8E       CMPA  #$8E                 // cruise missile at right-most border?
20D7: 22 F6       BHI   $20CF                // yes, goto $20CF to undo change made at $20C9

20D9: EB 4A       ADDB  $000A,U              // add cruise missile's Y delta to most significant byte (whole part) of Y coordinate
20DB: C1 18       CMPB  #$18                 // cruise missile at top-most border?
20DD: 24 06       BCC   $20E5                // no, goto $20E5
20DF: E0 4A       SUBB  $000A,U              // undo change made at $20D9
20E1: 60 4A       NEG   $000A,U              // negate Y delta of cruise missile (making it move in opposite direction horizontally)
20E3: 20 F4       BRA   $20D9

20E5: C1 EA       CMPB  #$EA                 // cruise missile at bottom-most border?                 
20E7: 22 F6       BHI   $20DF                // yes, undo change made at $20D9

// A = X coordinate
// B = Y coordinate
// X = pointer to cruise missile object

DRAW_CRUISE_MISSILE:
20E9: 10 8E DD DD LDY   #$DDDD               // pixel colours to write (remember 4 bits per pixel)
20ED: 10 AF 98 0A STY   [$0A,X]              // write 4 pixels to screen RAM 
20F1: ED 0A       STD   $000A,X              // update screen address to write pixels to
20F3: 83 01 01    SUBD  #$0101
20F6: ED 04       STD   $0004,X              // update blitter destination
20F8: 10 8E 00 00 LDY   #$0000               // 4 black pixels 
20FC: A6 4C       LDA   $000C,U              // read index into "cruise missile trail" list
20FE: 10 AF D6    STY   [A,U]                // write black pixels to trail (thus erasing trail)
2101: CC AA AA    LDD   #$AAAA               // colour of cruise missile "head"
2104: 10 AE 0A    LDY   $000A,X              // get blitter address of head
2107: ED A4       STD   ,Y                   // draw cruise missle head
2109: A6 4C       LDA   $000C,U              // get "cruise missile trail" list index           
210B: 10 AF C6    STY   A,U                  // save blitter address of head of cruise missile in list
210E: 8B 02       ADDA  #$02                 // bump to next entry in list
2110: 81 1F       CMPA  #$1F                 // at end of list buffer (meaning cruise missile trail can't expand any more)? 
2112: 25 02       BCS   $2116                // no, goto $2116
2114: 86 0D       LDA   #$0D                 // yes, reset "cruise missile trail" list index to beginning
2116: A7 4C       STA   $000C,U              // update cruise missile trail list index
2118: 39          RTS   



CRUISE_MISSILE_COLLISION_HANDLER:
2119: 0A 8E       DEC   $8E                  // reduce count of cruise missiles on screen
211B: 96 48       LDA   $48                  // player collision detection?
211D: 26 21       BNE   $2140                // yes
211F: BD D0 7E    JSR   $D07E                // JMP $D2C2 - remove baddy from baddies list
2122: AE 06       LDX   $0006,X              // get pointer to object metadata into X
2124: CE 00 00    LDU   #$0000               // 4 black pixels 
2127: 86 0D       LDA   #$0D                 // start of "cruise missile trail" list
2129: EF 96       STU   [A,X]                // write pixels, deleting the "tail" of the cruise missile 
                                             // one segment at a time   
212B: 8B 02       ADDA  #$02                 // bump index to next item in "cruise missile trail" list
212D: 81 1F       CMPA  #$1F                 // have all segments of the cruise missile's trail been erased?
212F: 26 F8       BNE   $2129                // no, goto $2129
2131: BD D0 5D    JSR   $D05D                // JMP $D218 - deallocate object metadata entry
2134: CC 00 25    LDD   #$0025
2137: BD D0 0C    JSR   $D00C                // JMP $DB9C - update player score
213A: CC 1A D5    LDD   #$1AD5
213D: BD D0 4B    JSR   $D04B                // JMP $D3C7 - play sound with priority
2140: 39          RTS   




BEGIN_WAVE:
2826: BD 2B 0B    JSR   $2B0B                // Read in object counts for this wave (how many grunts, hulks, family members etc etc)

// U = #$BE72
2829: BD 2F 8C    JSR   $2F8C                // WAVE_START_PLAYER
282C: 0F 06       CLR   $06
282E: 7F C0 06    CLR   $C006                // clear a colour register. 
2831: BD 00 00    JSR   $0000                // JMP $016D - initialise all hulks
2834: BD 1A C0    JSR   $1AC0                // JMP $1AF4 - initialise all brains
2837: BD 4B 00    JSR   $4B00                // JMP $4D10 - initialise all tanks
283A: BD 00 03    JSR   $0003                // JMP $02B2 - initialise all family members
283D: BD 38 83    JSR   $3883                // JMP $3950 - initialise all electrodes
2840: BD 38 80    JSR   $3880                // JMP $38AA - initialise all grunts  
2843: BD 29 A4    JSR   $29A4                // clear all baddies from screen 
2846: 86 08       LDA   #$08
2848: 97 92       STA   $92
284A: BD D0 54    JSR   $D054                // JMP $D281 - reserve object metadata entry and call function
284D: 35 4B       // pointer to function      // spawn task to draw all electrodes   
284F: BD 29 8F    JSR   $298F                // draw all electrodes
2852: BD D0 33    JSR   LOAD_DA51_PALETTE1
2855: BD 11 40    JSR   $1140                // JMP $1168 - initialise all spheroids
2858: BD 4B 03    JSR   $4B03                // JMP $4B36 - initialise all quarks
285B: 86 19       LDA   #$19                 // bit flags for do not draw player + ?
285D: 97 59       STA   $59
285F: B6 BE 6E    LDA   cur_brains           // any brains on this wave?
2862: 27 0D       BEQ   $2871                // no, goto $2871

2864: BD D0 54    JSR   $D054                // JMP $D281 - reserve object metadata entry and call function
2867: 41 40       // pointer to function, which is a JMP $459B - begin brain wave 
2869: 86 96       LDA   #$96                 // delay before calling function
286B: 8E 28 74    LDX   #$2874               // address of function to call 
286E: 7E D0 66    JMP   $D066                // JMP $D1E3 - allocate task

2871: 7E 28 FE    JMP   $28FE                // No brains on this wave, just draw as usual


2874: BD 29 F5    JSR   $29F5
2877: BD 29 8F    JSR   $298F
287A: 86 06       LDA   #$06                 // delay
287C: 8E 28 82    LDX   #$2882               // address of function to call
287F: 7E D0 66    JMP   $D066                // JMP $D1E3 - allocate task

2882: BD 29 D2    JSR   $29D2
2885: 86 04       LDA   #$04                 // delay
2887: 8E 28 8D    LDX   #$288D               // address of function to call
288A: 7E D0 66    JMP   $D066                // JMP $D1E3 - allocate task

288D: BD 29 83    JSR   $2983
2890: BD D0 54    JSR   $D054                // JMP $D281 - reserve object metadata entry and call function
2893: 31 B5       // pointer to function
2895: BD D0 54    JSR   $D054                // JMP $D281 - reserve object metadata entry and call function
2898: 30 B3       // pointer to function
289A: 0F 59       CLR   $59
289C: 86 0C       LDA   #$0C
289E: 8E 28 A4    LDX   #$28A4
28A1: 7E D0 66    JMP   $D066                // JMP $D1E3 - allocate task

28A4: BD 29 83    JSR   $2983
28A7: BD 29 8F    JSR   $298F
28AA: 86 0A       LDA   #$0A
28AC: 8E 28 B2    LDX   #$28B2
28AF: 7E D0 66    JMP   $D066                // JMP $D1E3 - allocate task

28B2: BD 29 83    JSR   $2983
28B5: BD 29 8F    JSR   $298F
28B8: 86 04       LDA   #$04
28BA: 97 92       STA   $92
28BC: 0F CF       CLR   $CF                  // colour 0 (black)
28BE: 86 71       LDA   #$71                 // clear the "(C) 1982 Williams Electronics" message at the bottom 
28C0: BD 5F 96    JSR   $5F96                // JMP $613F: print string in small font
28C3: BD 34 C0    JSR   $34C0                // print wave number
28C6: 8E 20 FB    LDX   #$20FB
28C9: CE 2C 03    LDU   #$2C03
28CC: A6 C0       LDA   ,U+
28CE: 88 5A       EORA  #$5A
28D0: 27 05       BEQ   $28D7
28D2: BD 5F 90    JSR   $5F90
28D5: 20 F5       BRA   $28CC

28D7: 7E 2A 85    JMP   $2A85

28DA:  (C) 1982 WILLIAMS ELECTRONICS I
28FA: NC. 


//
// Draw all baddies for each wave except brain waves
//
//
//
//

28FE: DE 15       LDU   $15                  // load U with function call list pointer
2900: 6F 47       CLR   $0007,U
2902: 8E 98 21    LDX   #$9821               // pointer to grunts_hulks_brains_progs_cruise_tanks list start             
2905: AF 49       STX   $0009,U
2907: 9E 21       LDX   $21                  // read first entry in list
2909: AF 4B       STX   $000B,U
290B: AF 4D       STX   $000D,U
290D: 86 01       LDA   #$01
290F: 34 02       PSHS  A
2911: AE 49       LDX   $0009,U              // get pointer to object list
2913: AE 84       LDX   ,X                   // read next entry in list
2915: 27 15       BEQ   $292C                // if NULL, goto $292C 
2917: BD 29 B5    JSR   $29B5                // 
// A6 = X coord, A7 = Y coord
291A: A6 47       LDA   $0007,U
291C: 84 03       ANDA  #$03
291E: 81 03       CMPA  #$03
2920: 26 05       BNE   $2927
2922: BD 5B 58    JSR   $5B58                // JMP $5BB1 which goes to $F066 if fancy attract mode is set ON
2925: 20 03       BRA   $292A

2927: BD 5B 46    JSR   $5B46                // JMP $5BC6

// X = 
292A: AF 49       STX   $0009,U
292C: 6C 47       INC   $0007,U
292E: A6 47       LDA   $0007,U
2930: 81 20       CMPA  #$20
2932: 23 0D       BLS   $2941
2934: 10 AE 4D    LDY   $000D,U
2937: 27 18       BEQ   $2951
2939: 10 AE A4    LDY   ,Y
293C: 27 13       BEQ   $2951
293E: 10 AF 4D    STY   $000D,U
2941: 6A E4       DEC   ,S
2943: 26 CC       BNE   $2911
2945: 35 02       PULS  A
2947: 8D 1C       BSR   $2965
2949: 86 01       LDA   #$01                 // delay before calling function
294B: 8E 29 0D    LDX   #$290D               // address of function to call
294E: 7E D0 66    JMP   $D066                // JMP $D1E3 - allocate task

2951: 35 02       PULS  A
2953: 86 02       LDA   #$02                 // delay before calling function
2955: 8E 29 5B    LDX   #$295B               // address of function to call
2958: 7E D0 66    JMP   $D066                // JMP $D1E3 - allocate task

295B: 8D 26       BSR   $2983
295D: 86 0A       LDA   #$0A                 // delay before calling function
295F: 8E 28 74    LDX   #$2874               // address of function to call
2962: 7E D0 66    JMP   $D066                // JMP $D1E3 - allocate task

2965: 34 10       PSHS  X
2967: 86 04       LDA   #$04
2969: 97 2B       STA   $2B
296B: AE 4B       LDX   $000B,U
296D: AC 4D       CPX   $000D,U
296F: 26 05       BNE   $2976
2971: 8E 98 21    LDX   #$9821               // pointer to GRUNTS_HULKS_BRAINS_PROGS_CRUISE_TANKS list start
2974: 20 03       BRA   $2979

2976: BD D0 18    JSR   $D018                // JMP $DAF2 - do blit
2979: AE 84       LDX   ,X
297B: 0A 2B       DEC   $2B
297D: 26 EE       BNE   $296D
297F: AF 4B       STX   $000B,U
2981: 35 90       PULS  X,PC //(PUL? PC=RTS)


DRAW_ALL_GRUNTS_HULKS_BRAINS_PROGS_CRUISE_TANKS:
2983: 9E 21       LDX   $21                  // pointer to list start
2985: 27 07       BEQ   $298E
2987: BD D0 18    JSR   $D018                // JMP   $DAF2 - do blit
298A: AE 84       LDX   ,X
298C: 26 F9       BNE   $2987
298E: 39          RTS   


DRAW_ALL_ELECTRODES:
298F: 9E 23       LDX   $23                  // pointer to electrodes list start
2991: 27 0C       BEQ   $299F
2993: 96 90       LDA   $90                  // load electrode colour
2995: BD 38 88    JSR   $3888                // JMP   $3942 - do solid & transparent blit
2998: AF 98 06    STX   [$06,X]
299B: AE 84       LDX   ,X
299D: 26 F4       BNE   $2993
299F: 39          RTS   


CLEAR_ALL_ELECTRODES:
29A0: 9E 23       LDX   $23                  // pointer to electrodes list start
29A2: 20 02       BRA   $29A6


CLEAR_ALL_GRUNTS_HULKS_BRAINS_PROGS_CRUISE_TANKS:
29A4: 9E 21       LDX   $21                  // pointer to baddies list start
29A6: 27 0C       BEQ   $29B4
29A8: EC 04       LDD   $0004,X              // D = "last" blitter destination
29AA: 10 AE 02    LDY   $0002,X              // Y = pointer to animation frame metadata
29AD: BD D0 1E    JSR   $D01E                // JMP $DABF: clear image rectangle
29B0: AE 84       LDX   ,X                   // X = next object in chain
29B2: 26 F4       BNE   $29A8                // if X!=NULL then $29A8
29B4: 39          RTS   


//
//
//
//
29B5: 34 46       PSHS  U,B,A
29B7: EE 02       LDU   $0002,X              // U = pointer to animation frame metadata
29B9: E6 C4       LDB   ,U                   // B = width in bytes of animation frame
29BB: A6 04       LDA   $0004,X              // get X component of blitter destination into A
29BD: 48          ASLA                       // multiply by 2. 
29BE: 24 02       BCC   $29C2
29C0: 86 FF       LDA   #$FF
29C2: 3D          MUL                        // D = width in bytes of animation frame *   
29C3: AB 04       ADDA  $0004,X
29C5: 97 A6       STA   $A6
29C7: E6 41       LDB   $0001,U              // B = height in bytes of animation frame
29C9: A6 05       LDA   $0005,X              // get Y component of blitter destination into A 
29CB: 3D          MUL                        // D = height * Y component  
29CC: AB 05       ADDA  $0005,X                
29CE: 97 A7       STA   $A7
29D0: 35 C6       PULS  A,B,U,PC //(PUL? PC=RTS)




29D2: 8E 98 5A    LDX   #$985A               // player_object_start
29D5: 10 AE 02    LDY   $0002,X              // animation frame metadata pointer
29D8: A6 21       LDA   $0001,Y              // A = height of player animation  
29DA: 34 02       PSHS  A
29DC: A6 E4       LDA   ,S
29DE: 9B 5F       ADDA  $5F                  // add in LSB of player blitter destination (X component)
29E0: 4A          DECA  
29E1: 97 A7       STA   $A7
29E3: 4F          CLRA  
29E4: BD 46 86    JSR   $4686                // JMP $46E6
29E7: 43          COMA  
29E8: BD 46 86    JSR   $4686                // JMP $46E6 
29EB: A6 E4       LDA   ,S
29ED: 80 03       SUBA  #$03
29EF: A7 E4       STA   ,S
29F1: 2A E9       BPL   $29DC
29F3: 35 82       PULS  A,PC //(PUL? PC=RTS)


//
// 
//

29F5: 8E 98 5A    LDX   #$985A               // player_object_start
29F8: 10 AE 02    LDY   $0002,X              // get pointer to animation frame metadata for player
29FB: A6 21       LDA   $0001,Y              // A = height of animation frame
29FD: 34 02       PSHS  A                    // save height on stack
29FF: A6 E4       LDA   ,S                   // get height from stack
2A01: 9B 5F       ADDA  $5F                  // add in LSB of player blitter destination (Y component)
2A03: 4A          DECA  
2A04: 97 A7       STA   $A7
2A06: BD 5B 46    JSR   $5B46                // JMP $5BC6 - draw warp in vertically
2A09: 6A E4       DEC   ,S                   // decrement height on stack
2A0B: 26 F2       BNE   $29FF                // if nonzero, goto $29FF
2A0D: A6 A4       LDA   ,Y                   // get width of animation frame
2A0F: A7 E4       STA   ,S                   // save on stack
2A11: A6 E4       LDA   ,S
2A13: 9B 5E       ADDA  $5E                  // add in MSB of player blitter destination (X component) 
2A15: 4A          DECA  
2A16: 97 A6       STA   $A6
2A18: BD 5B 58    JSR   $5B58                // JMP $5BB1 - draw warp in horizontally
2A1B: 6A E4       DEC   ,S
2A1D: 26 F2       BNE   $2A11
2A1F: 35 82       PULS  A,PC //(PUL? PC=RTS)



BORDER_WALL_COLOUR_TABLE:
2A4B: 22 55 11 EE 77 33 44 88 00 CC 

                        ELECTRODE_COLOUR_TABLE:
                        2A55: FF EE BB DD EE FF 11 BB DD AA 

                        // add to $3B05 to compute address of electrode animation frame metadata
                        ELECTRODE_ANIMATION_FRAME_METADATA_OFFSET_TABLE:
                        2A5F: 00 10 20 30 40 50 70 80 00 60 

LASER_SPLASH_DAMAGE_COLOUR_TABLE:
2A69: 99 00 99 66 99 99 99 11 AA 99 


//
// Returns total number of enemies on screen, excluding any missiles and progs.
//

COUNT_ENEMIES_ON_SCREEN:
2A73: B6 BE 68    LDA   cur_grunts
2A76: BB BE 6F    ADDA  cur_sphereoids
2A79: 9B ED       ADDA  temp_enforcer_count
2A7B: BB BE 6E    ADDA  cur_brains
2A7E: BB BE 71    ADDA  cur_tanks
2A81: BB BE 70    ADDA  cur_quarks
2A84: 39          RTS   


2A85: DE 15       LDU   $15
2A87: 86 12       LDA   #$12
2A89: A7 47       STA   $0007,U
2A8B: 0F F0       CLR   $F0
2A8D: 8D E4       BSR   $2A73                // count enemies on screen (excluding missiles and progs)
2A8F: 26 24       BNE   $2AB5                // if there are some enemies left, goto $2AB5
2A91: BD D0 45    JSR   $D045                // JMP $D699 - get addr of current player game state into X
2A94: 6C 09       INC   $0009,X              // increment wave number for player
2A96: 26 02       BNE   $2A9A                // have we passed wave 255 and are now in wave 0 (which wouldn't be right) ? if not, goto $2A9A
2A98: 6C 09       INC   $0009,X              // otherwise, we're back to wave 1
2A9A: 6C 08       INC   $0008,X              // this appears to increment the number of lives the player has.... but why? 
2A9C: CC 26 EB    LDD   #$26EB
2A9F: BD D0 4B    JSR   $D04B                // JMP $D3C7 - play sound with priority
2AA2: BD 2B 7C    JSR   $2B7C                // initialise settings and object counts for current player wave 
2AA5: BD D0 60    JSR   $D060                // JMP $D1FF - free all object metadata entries
2AA8: 86 7F       LDA   #$7F
2AAA: 97 59       STA   $59
2AAC: BD D0 12    JSR   CLR_SCREEN1
2AAF: BD 57 00    JSR   $5700                // JMP $5703 - draw colour cycling tunnel effect
2AB2: 7E 27 A3    JMP   $27A3


//
// Easter egg code
//

EASTER_EGG_PART_1:
2AB5: B6 C8 04    LDA   widget_pia_dataa
2AB8: 81 58       CMPA  #$58                 // move right + 1p + fire up
2ABA: 26 03       BNE   $2ABF
2ABC: BD D0 69    JSR   $D069                // JMP D30E
2ABF: 6A 47       DEC   $0007,U
2AC1: 26 31       BNE   $2AF4
2AC3: 86 0F       LDA   #$0F
2AC5: A7 47       STA   $0007,U

// Update grunt speed as level progresses
2AC7: B6 BE 68    LDA   cur_grunts           // read number of grunts on screen
2ACA: 81 1E       CMPA  #$1E                 // compare to 30 decimal
2ACC: 24 26       BCC   $2AF4              
2ACE: CC FF FE    LDD   #$FFFE
2AD1: 0D F0       TST   $F0
2AD3: 26 03       BNE   $2AD8
2AD5: CC FE FC    LDD   #$FEFC
2AD8: BB BE 5D    ADDA  $BE5D                // A+= grunt speed throttle setting
2ADB: 0F F0       CLR   $F0
2ADD: 81 01       CMPA  #$01
2ADF: 2C 02       BGE   $2AE3
2AE1: 86 01       LDA   #$01                 // lowest (most difficult) it can be
2AE3: B7 BE 5D    STA   $BE5D                // update grunt speed throttle setting 
2AE6: FB BE 5C    ADDB  $BE5C
2AE9: F1 BE 5D    CMPB  $BE5D                // compare to grunt speed throttle setting 
2AEC: 2C 03       BGE   $2AF1                
2AEE: F6 BE 5D    LDB   $BE5D                // set grunt movement speed to the throttle setting, which is the fastest the grunts can move for this level
2AF1: F7 BE 5C    STB   $BE5C                // update grunt movement speed
2AF4: 96 EE       LDA   $EE                  // read minute calculation field. 
2AF6: 4C          INCA                       
2AF7: 81 96       CMPA  #$96                 // compare to 150 decimal. When this gets to 150 another minute has elapsed in the game. 
2AF9: 25 06       BCS   $2B01                // no, minute hasn't elapsed yet
2AFB: C6 06       LDB   #$06                 // index of "number of minutes played" in CMOS bookkeeping totals
2AFD: BD D0 BD    JSR   $D0BD                // JMP $D655 - increment bookkeeping total by 1
2B00: 4F          CLRA                       // reset minute calculation field
2B01: 97 EE       STA   $EE                  // update minute calculation field
2B03: 86 0F       LDA   #$0F
2B05: 8E 2A 8D    LDX   #$2A8D
2B08: 7E D0 66    JMP   $D066                // JMP $D1E3 - allocate task


// When its a player's turn, get the wave difficulty settings and the number of objects (baddies/family etc) remaining on the wave from the relevant player's wave state and copy to "current wave state".
// The system will then use the current wave state information to run the wave at the right difficulty and right number of baddies.
//
// See also $2B7C, which is responsible for initialising the wave state on wave start.
//

LOAD_SETTINGS_AND_OBJECT_COUNTS_FOR_CURRENT_PLAYER_WAVE:
2B0B: BD D0 45    JSR   $D045                // JMP $D699 - get addr of current player game state into X
2B0E: 30 0A       LEAX  $000A,X              // X+=10. X now points to $BDEE for player 1, $BE2A for player 2
2B10: CE BE 5C    LDU   #$BE5C
2B13: A6 80       LDA   ,X+                  // read byte from player wave state at X. Increment X by 1
2B15: A7 C0       STA   ,U+                  // store byte at U to update current wave state. Increment U by 1.
2B17: 11 83 BE 72 CMPU  #$BE72
2B1B: 26 F6       BNE   $2B13

// wonder why they didn't just push X on the stack at $2B0B and pop it off here instead of calling function to set X?
2B1D: BD D0 45    JSR   $D045                // JMP $D699 - get addr of current player game state into X
2B20: A6 09       LDA   $0009,X              // read wave number
2B22: 81 04       CMPA  #$04                 // compare wave number to 4               
2B24: 22 32       BHI   $2B58                // wave number > 4? If so goto $2B58, which exits function
2B26: E6 08       LDB   $0008,X              // B = number of lives left
2B28: DD 2B       STD   $2B                  // save wave number & lives left
2B2A: 5D          TSTB                       // lives left == 0?
2B2B: 27 12       BEQ   $2B3F                // yes, goto $2B3F - the player must be having a shocker of a game 
2B2D: 81 02       CMPA  #$02                 // wave number == 2 ?
2B2F: 22 27       BHI   $2B58                // if >2 then exit
//
// OK, we're in wave 1 or 2. The following code reads the number of lives the player has left and determines
// if the number is the same as or higher as the "turns per player" setting in the CMOS.
// If the number is the same or higher, then the player's doing OK and the routine exits.
// Otherwise the player's not doing too great, so some remedial action is needed - the enforcer and grunts
// speed settings are changed. 
//
// Here's Larry Demar's comments after I raised this discovery:
// <BEGIN QUOTE>
// "The Bozo mode was not in the original Robotron code. There were some complaints from the field about how brutal 
// the game was to new players and Scott has discovered the code put in to address these complaints. 
// In that 2nd release the default difficulty was also moved down from 5 to 3. 
// If you are down a man very early in the game then the settings are dialed as low as they can go through the first wave.
// <END QUOTE>
//
2B31: 8E CC 02    LDX   #$CC02               // address of turns per player setting in CMOS
2B34: BD D0 A2    JSR   PACK_2_BYTES_INTO_A1           // convert 2 bytes to BCD  
2B37: BD D0 C6    JSR   $D0C6                // JMP $D5D8 - convert from BCD to normal number
2B3A: 4A          DECA  
2B3B: 91 2C       CMPA  $2C                  // compare to lives left
2B3D: 23 19       BLS   $2B58                // if turns per player <= player lives left, player's doing OK, goto $2b58 and exit
2B3F: 96 2B       LDA   $2B                  // read wave number
2B41: 8E 2B 55    LDX   #$2B55               // $2B55 is start of remedial action table - 4 bytes. 
2B44: 48          ASLA                       // 
2B45: 48          ASLA                       // multiplies A by 4
2B46: 30 86       LEAX  A,X                  // X = X + A
2B48: EC 81       LDD   ,X++
2B4A: B7 BE 60    STA   $BE60                // set enforcer spawn control variable
2B4D: F7 BE 5F    STB   $BE5F                // set enforcer spark control variable
2B50: EC 84       LDD   ,X
2B52: B7 BE 5C    STA   $BE5C                // set grunt delay initial setting
2B55: F7 BE 5D    STB   $BE5D                // set grunt delay minimum value 
2B58: 39          RTS   



//
// Settings to make game a bit easier
// Nicknamed "BOZO MODE" apparently.
//
BOZO_MODE_TABLE:
2B59: 26 60 1E 0F       
2B5D: 26 60 19 0C 
2B61: 24 30 14 0A
2B65: 1E 1E 0F 07

       
2B69: BD D0 45    JSR   $D045                // JMP $D699 - get addr of current player game state into X
2B6C: 30 0A       LEAX  $000A,X              // point X to wave snapshot for player. The player has died, and we're storing info
                                             // about the wave in the snapshot, so we can rebuild the wave the player's next turn. 
2B6E: CE BE 5C    LDU   #$BE5C               // copy from $BE5C to $BE71 
2B71: A6 C0       LDA   ,U+
2B73: A7 80       STA   ,X+
2B75: 11 83 BE 72 CMPU  #$BE72
2B79: 26 F6       BNE   $2B71
2B7B: 39          RTS   


//
// This routine is responsible for setting the numbers of objects for the current wave and difficulty level related fields.
//
//

INITIALISE_SETTINGS_AND_OBJECT_COUNTS_FOR_CURRENT_PLAYER_WAVE:
2B7C: 8E CC 14    LDX   #$CC14               // address of difficulty_of_play value in CMOS
2B7F: BD D0 A5    JSR   $D0A5                // JMP $D523 - pack 2 bytes at X into B as BCD   
2B82: BD D0 B4    JSR   $D0B4                // JMP $D5E2 - convert BCD in B into base 10 number
2B85: BD D0 45    JSR   $D045                // JMP $D699  - get addr of current player game state into X
2B88: C1 05       CMPB  #$05                 // is difficulty of play at "recommended" level?
2B8A: 24 14       BCC   $2BA0                // if difficulty is recommended level or harder, goto $2BA0

// if we get here, the game is set to easier difficulty than normal :) 
2B8C: A6 09       LDA   $0009,X              // read wave number
2B8E: 81 0E       CMPA  #$0E                 // is wave number #$0E (14 decimal) ?
2B90: 25 02       BCS   $2B94                // if wave number is < 14 decimal goto $2B94
2B92: C6 05       LDB   #$05
2B94: 81 05       CMPA  #$05                 // is wave number #$5 ? 
2B96: 25 08       BCS   $2BA0                // if wave number < 5 goto $2BA0
2B98: A6 08       LDA   $0008,X              // read lives left
2B9A: 81 03       CMPA  #$03                 // does player have at least 3 lives left?
2B9C: 25 02       BCS   $2BA0                // if player has < 3 lives, goto $2BA0
2B9E: C6 05       LDB   #$05

// B = difficulty of play level
2BA0: C0 05       SUBB  #$05                 // subtract 5 from difficulty of play value
2BA2: D7 2C       STB   $2C                  // and store in $2C. 
2BA4: 2A 01       BPL   $2BA7                // if the result is still positive, goto $2BA7 
2BA6: 50          NEGB                       // if we get here, B is a negative number, so NEGB makes B positive again  
2BA7: D7 2B       STB   $2B
2BA9: E6 09       LDB   $0009,X              // read wave number into B (which I will call "temp wave number")
2BAB: CE 2C 22    LDU   #$2C22
2BAE: 30 0A       LEAX  $000A,X              // X+= 10 decimal
2BB0: C1 28       CMPB  #$28                 // is temp wave number #$28 (40 decimal) ? 
2BB2: 23 04       BLS   $2BB8                // if temp wave number <= 40 decimal, goto $2BB8
2BB4: C0 14       SUBB  #$14                 // substract #$14 (20 decimal) from temp wave number
2BB6: 20 F8       BRA   $2BB0                // goto $2BB0 to continue until temp wave number value is 40 decimal or less 

// B = wave number to load data for. Is a number from 1-40
// X = pointer to player wave state setting 
// $2B = Math.Abs(Difficulty setting - 5)
// $2C = (Difficulty setting - 5)
//

2BB8: 11 83 2E 24 CMPU  #$2E24               // is U register now pointing within the object count tables?
2BBC: 25 06       BCS   $2BC4                // if U < #$2E24 then no, we're not in the object count tables just yet, goto $2BC4 

// When the game hits this piece of code, its time to set up the number of objects (grunts, electrodes) for the wave.

2BBE: 33 5D       LEAU  $-3,U                // U -= 3, so as to adjust U correctly to start of object count list
2BC0: A6 C5       LDA   B,U                  // A = *(U + wave number) where wave number is 1..40. A now holds count for an object type (how many of object type to create at wave start).                   
2BC2: 20 31       BRA   $2BF5                // store it.

// This part of the code computes difficulty settings for the wave. 
//
// B = wave number to load data for. Is a number from 1-40
// X = pointer to player wave state setting 
// U = pointer to difficulty settings table
// $2B = Math.Abs(Difficulty setting value - 5) - referred to as "difficulty setting absolute value 1" below
// $2C = (Difficulty setting - 5) - referred to as "difficulty setting value 2" below
//
//

2BC4: A6 C5       LDA   B,U                  // A = *(U + wave number)  . A now holds value for given wave (now referred to as "wave setting value")
                                    
2BC6: 34 06       PSHS  B,A                  // push wave number in B and wave setting value in A onto stack
2BC8: E6 5E       LDB   $-2,U                // B = *(U-2)
2BCA: C4 1F       ANDB  #$1F                 // mask in bits 0..5 
2BCC: 96 2B       LDA   $2B                  // get difficulty setting absolute value 1 (see code @ $2BA0) 
2BCE: 3D          MUL                        // multiply A and B together to give result in D
2BCF: 35 02       PULS  A                    // restore wave setting value from the stack (see $2BC6)
2BD1: 3D          MUL                        // and multiply with difficulty setting absolute value 1. 

2BD2: 89 00       ADCA  #$00                 

2BD4: D6 2C       LDB   $2C                  // get difficulty setting value 2 (will be a negative number if difficulty level is easier than "recommended") 
2BD6: E8 5E       EORB  $-2,U                // EOR with multiplier byte 0 in table                               
2BD8: 35 04       PULS  B                    // restore wave number into B from stack 
2BDA: 2A 09       BPL   $2BE5                // if the EOR caused the result to be positive (ie: bit 7 is not set) goto $2BE5

// This code only executes if bit 7 of the "multiplier" byte is set AND difficulty level is "recommended" or harder
2BDC: 40          NEGA                         
2BDD: 27 06       BEQ   $2BE5
2BDF: AB C5       ADDA  B,U                  // A+= *(B+U) 
2BE1: 25 06       BCS   $2BE9
2BE3: 20 08       BRA   $2BED

2BE5: AB C5       ADDA  B,U                  // A+= *(B+U) 
2BE7: 25 0A       BCS   $2BF3                // if a carry occurred, just use maximum value for wave

// A = value to store in wave setting
2BE9: A1 5F       CMPA  $-1,U                // compare wave setting to minimum threshold for current wave
2BEB: 24 02       BCC   $2BEF                // if setting value is >= minimum threshold, goto $2BEF
2BED: A6 5F       LDA   $-1,U                // otherwise, A is an invalid setting, so load A with minimum value allowed for wave
2BEF: A1 C4       CMPA  ,U                   // compare wave setting to maximum threshold for current wave
2BF1: 23 02       BLS   $2BF5                // if setting value is <= maximum threshold, its OK, goto $2BF5, which will write the value "as-is" to player wave state
2BF3: A6 C4       LDA   ,U                   // otherwise, A is an invalid setting, so load A with maximum value allowed for wave
2BF5: A7 80       STA   ,X+                  // write to wave state
2BF7: 33 C8 2B    LEAU  $2B,U                // U += $2B (43 decimal) - bump to next table
2BFA: 11 83 2F 8B CMPU  #$2F8B               // has U went past the area of memory reserved for the settings data table? 
2BFE: 25 B8       BCS   $2BB8                // if < #$2F8B, then no, there's more settings to be done
2C00: 6F 80       CLR   ,X+                  // terminate wave state table with byte 0 marker
2C02: 39          RTS   

2C03: 01 19 06 7A 6B 63 62 68 7A 0D 13 16 16 13 1B 

2C12: 17 
2C13: 09 7A 1F 16 1F 19 67 7A 13 14 19 67 5A 




WAVE_DIFFICULTY_SETTINGS_TABLES:

//
// This is used to configure difficulty settings in the wave. Each table here takes up exactly 43 bytes.
//

// Byte 0: the "multiplier" byte 
//     Bits 0..4 of the byte serve as a multiplier. The resulting value is multiplied by the difficulty level value held in $2B.
//     **** Note: The difficulty level value in $2B is Math.Abs((CMOS difficulty level setting value) - 5). 
//          e.g. "recommended" difficulty has a value of 5 in CMOS, so $2B will hold 0   ****
//
//     Bit 7 of the byte is a special flag. 
//       
//
// Byte 1: minimum value
// Byte 2: maximum value
// Bytes 3 - 42 (decimal):  values per level


//
// Grunt move probability table. The values in the table are used to compute the probability of a grunt moving. See docs for $BE5C.
//

2C20: 8E 0A 14 14 0F 0F 0F 0F 0F 0F 0F 0F 0F 0E 0E 0E  
2C30: 0E 0E 0D 0D 0D 0D 0D 0E 0E 0E 0E 0E 0E 0D 0D 0D  
2C40: 0D 0D 0D 0C 0C 0C 0C 0C 0C 0F 03              

//
// Grunt move probability limit table. The values in the table are used to compute a limit for the top speed of grunts on a wave. See docs for $BE5D.
//

2C4B: 8E 03 0A 09 07 06 05 05 05 05 04 04 04 04 04 04  
2C5B: 04 04 04 04 04 04 04 04 04 04 04 04 04 03 03 04  
2C6B: 03 03 03 03 03 03 03 03 03 04 03             

//
// Enforcer/ quark drop count control value.  The values below do not represent how many enforcers/tanks are dropped per level, but are used to calculate
// the maximum that can be dropped by each spheroid and quark. See docs for $BE5E.
//

2C76: 0E 08 0C 0A 0A 0A 0A 0A 0A 0A 0A 0A 0A 0A 0A 0A  
2C86: 0A 0A 0A 0A 0A 0A 0A 0B 0B 0B 0B 0B 0B 0B 0B 0B  
2C96: 0B 0B 0B 0B 0B 0B 0B 0B 0B 0B 0B                 

//
// Enforcer fire control table. The values in the table are used to compute how often enforcers can fire sparks at a player. See docs for $BE5F.
//

2CA1: 8E 0D 28 1E 1C 1A 18 16 14 12 12 10 0E 0E 0E 0E 
2CB1: 0E 0E 0E 0E 0E 0E 0E 0F 0F 0F 0F 0F 0F 0F 0F 0F 
2CC1: 0E 0E 0E 0E 0E 0E 0E 0E 0E 0E 0E               
 

//
// enforcer spawn control table. The values in the table are used to compute how fast spheroids can spawn enforcers. See docs for $BE60.
//

2CCC: 8E 0C 28 1E 1C 1A 18 1E 14 12 10 12 19 0C 0C 0C  
2CDC: 19 19 0C 0C 0C 12 14 0E 0E 0E 0E 0E 19 0E 0E 12  
2CEC: 19 0C 0C 0C 0C 19 0C 0C 0C 12 14                 

//
// Hulk speed table. The values in this table are used to compute the hulks walking speed. See docs for $BE61.
//

2CF7: 8E 05 09 08 08 07 07 07 07 07 06 06 06 06 05 05  
2D07: 05 05 05 05 05 05 05 05 05 05 05 05 05 05 05 05  
2D17: 05 05 05 05 05 05 05 05 05 05 05                 


//
// Regulates how often brains can fire a cruise missile at the player. See docs for $BE62.
//

2D22:  8E 19 50 40 40 40 40 40 28 28 26 26 26 26 26 26  
2D32:  26 26 26 24 24 24 24 20 20 20 20 20 20 20 1E 1E  
2D42:  1E 1E 1E 19 19 19 19 19 19 19 19                 

//
// Brain speed control table.  See docs for $BE63.
//

2D4D:  8E 06 0A 08 08 08 08 08 07 07 07 07 07 07 07 07  
2D5D:  07 07 06 06 06 06 06 06 06 06 06 06 06 06 06 06  
2D6D:  06 06 06 06 06 06 06 06 06 06 06                 


//
// Tank shell firing control table. Used to compute how often tanks can fire shells. See docs for $BE64.
//
//

2D78: 8E 14 28 20 20 20 20 20 20 20 1E 
2D83: 1E 1E 1E 1E 1E 1C 1C 1C 1C 1C 1C 1C 1E 1E 1E 1E 
2D93: 1E 1E 1C 1C 1C 1C 1C 1A 1A 1A 1A 1A 18 18 18 18 


//
// TODO: what is this tables exact purpose? It's quark related, but what?  See docs for $BE65.
//
//


2DA3: 0E A0 FF B0 B0 B0 B0 B0 B0 B0 B0 B0 B0 B0 B0 B0 
2DB3: B0 B0 B0 B0 B0 B0 B0 B8 B8 B8 B8 B8 B8 B8 B8 B8 
2DC3: B8 C0 C0 C0 C0 C0 C0 C0 C0 C0 C0 

//
// Quark tank spawn delay control table. Used to compute how often quarks can spawn tanks. See docs for $BE66.
//

2DCE: 8E 0C 30 10 10 
2DD3: 10 10 10 10 10 10 10 10 10 10 10 10 0F 0F 0F 0F 
2DE3: 0F 0F 0E 0E 0E 0E 0E 0E 0E 0E 0E 0E 0E 0E 0E 0E 
2DF3: 0E 0E 0E 0E 0E 0E 


//
// Quark movement table. TODO: Not quite sure about exactly how this affects the quark's movement yet. See docs for $BE67.
//
//

2DF9: 0E 28 44 32 32 32 32 32 32 32 
2E03: 32 32 32 32 32 38 38 38 38 38 38 38 38 38 38 38 
2E13: 38 38 38 38 38 3C 3C 3C 3C 3C 3C 3C 3C 3C 3C 3C 
2E23: 3C 


WAVE_OBJECT_COUNT_TABLES:

// There are 40 entries below for each type of object, an entry for each wave.

//
// Grunt counts
//
//
// wave 1 = #$0F (15 decimal) grunts.
// Wave 2 = #$11 (17 decimal) 
// Wave 3 = #$16 (22 decimal)
// Wave 4 = #$22 (34 decimal)
// .. and so on
// 

2E24: 0F 11 16 22 14 20 00 23 3C 19 23 00 23 1B 19 
2E33: 23 00 23 46 19 23 00 23 00 19 23 00 23 4B 19 23 
2E43: 00 23 1E 1B 23 00 23 50 1E 

//
// Electrode counts
//

2E4C: 05 0F 19 19 14 19 00 
2E53: 19 00 14 19 00 19 05 14 19 00 19 00 14 19 00 19 
2E63: 00 14 19 00 19 00 14 19 00 19 00 0F 19 00 19 00 
2E73: 0F 


//
// Mommies
//

2E74: 01 01 02 02 0F 03 
2E7A: 04 03 03 00 03 03 03 05 00 
2E83: 03 03 03 03 08 03 03 03 03 19 03 03 03 03 00 03 
2E93: 03 03 03 00 03 03 03 03 0A 


//
// Daddies
//

2E9C: 01 01 02 02 00 03 04 03 03
2EA5: 16 03 03 03 05 00 03 03 03 03 08 03 03 03 
2EB3: 03 00 03 03 03 03 19 03 03 03 03 00 03 03 03 03 
2EC3: 0A 


//
// Mikeys
//

2EC4: 00 01 02 02 01 03 04 03 03 00 03 03 03 05 16 
2ED3: 03 03 03 03 08 03 03 03 03 01 03 03 03 03 00 03 
2EE3: 03 03 03 19 03 03 03 03 0A 


//
// Hulks
//

2EEC: 00 05 06 07 00 07 0C 08 04 00 08 0D 08 14 02 
2EFB: 03 0E 08 03 02 08 0F 08 
2F03: 0D 01 08 10 08 04 01 08 10 08 19 02 08 10 08 06 
2F13: 02 

//
// Brains 
// Note how brains only appear every 5th entry..... 
//

2F14: 00 00 00 00 0F 00 00 00 00 14 00 00 00 00 14 
2F23: 00 00 00 
2F26: 00 14 00 00 00 00 15 00 00 00 00 16 00 
2F33: 00 00 00 17 00 00 00 00 19 

//
// Spheroids
//

2F3C: 00 01 03 04 01 04 00 
2F43: 05 05 01 05 00 05 02 01 05 00 05 05 02 05 
2F51: 00 05 
2F53: 06 01 05 00 05 05 01 05 00 05 02 01 05 00 05 05 
2F63: 01 


//
// Quarks
//

2F64: 00 00 00 00 00 00 0A 00 00 00 00 0C 00 00 00 
2F73: 00 0C 00 00 00 00 0C 00 07 
2F7C: 00 00 0C 01 01 01 01 0D 01 02 02 02 0E 02 01 01 


// WAVE START - SETS UP PLAYER POSITION

WAVE_START_PLAYER:
2F8C: 8E 98 5A    LDX   #$985A               // player_object_start
2F8F: CC 36 03    LDD   #$3603               // set animation frame metadata pointer to $3603. First 2 bytes at 3603: 04 0C (width and height, 2 pixels per byte for width), next 2 bytes 37 3B (pointer to actual image)                  
2F92: ED 02       STD   $0002,X              // set current animation frame metadata pointer
2F94: ED 88 14    STD   $14,X                // set previous animation frame metadata pointer (previous = current)             
2F97: 0F 70       CLR   $70                  // flag that indicates player animation needs to change                  
2F99: 0F 71       CLR   $71                  // index into animation sequence = 0 (meaning, the start)  
2F9B: CC 30 7B    LDD   #$307B               // pointer to player animation sequence                    
2F9E: DD 72       STD   $72
2FA0: CC 4A 7C    LDD   #$4A7C               // A = 4A, B = 7C (middle of the screen)
2FA3: ED 04       STD   $0004,X              // set "last" blitter destination
2FA5: A7 0A       STA   $000A,X              // Set player X coordinate (whole part) to #$4A (74 decimal)
2FA7: 6F 0B       CLR   $000B,X              // set fractional part of X coordinate to 0 
2FA9: E7 0C       STB   $000C,X              // Set player Y coordinate to #$7C (124 decimal)
2FAB: 6F 0D       CLR   $000D,X              // set fractional part of Y coordinate to 0
2FAD: 0F 87       CLR   $87                  // number of player lasers on screen = 0
2FAF: 0F 48       CLR   $48                  // flag used in collision detection. When set to 1, it means player collision detection routine is checking for collisions.
2FB1: 0F 8D       CLR   $8D                  // number of family members saved = 0
2FB3: 0F 8E       CLR   $8E                  // number of cruise missiles on screen = 0
2FB5: 0F 8A       CLR   $8A                  // number of sparks on screen = 0
2FB7: 0F 95       CLR   $95                  // clear the "family member being prog'd" flag
2FB9: 0F ED       CLR   temp_enforcer_count
2FBB: 86 02       LDA   #$02
2FBD: 97 EF       STA   $EF                  // tank movement delay
2FBF: 0F F1       CLR   $F1                  // number of tank shells on screen = 0
2FC1: 39          RTS   

2FC2: 96 59       LDA   $59
2FC4: 85 01       BITA  #$01
2FC6: 27 01       BEQ   $2FC9
2FC8: 39          RTS   

2FC9: 4D          TSTA  
2FCA: 2A 04       BPL   $2FD0

// Hmm, this looks suspicious. Looks like this is injecting fake player movements to the move player routine.
// TODO: See if this code is called during demo time, which I suspect it is
2FCC: 96 52       LDA   $52
2FCE: 20 03       BRA   $2FD3



MOVE_PLAYER:
2FD0: B6 C8 04    LDA   widget_pia_dataa     // read movement stick bits (bits 0-3)
2FD3: 8E 98 5A    LDX   #$985A               // player_object_start (X register doesn't appear to be used in this routine?)
2FD6: CE 30 31    LDU   #$3031               // pointer to player movement and animation sequence descriptor table (see $3031)
2FD9: 84 0F       ANDA  #$0F                 // Only want the movement bits from the stick and nothing else
2FDB: 48          ASLA  
2FDC: 48          ASLA                       // A = A * 4  
2FDD: 33 C6       LEAU  A,U                  // U = U + A
2FDF: EC C4       LDD   ,U                   // Load A with horizontal direction delta and B with vertical direction delta
2FE1: DB 66       ADDB  $66                  // Add B to $9866 (player_y)
2FE3: C1 18       CMPB  #$18                 // is Y past top border wall ? (invalid)
2FE5: 25 06       BCS   $2FED                // yes, so don't update Y coordinate, try updating X coordinate instead
2FE7: C1 DF       CMPB  #$DF                 // is Y > bottom border wall ? (invalid)
2FE9: 22 02       BHI   $2FED                // yes, so don't update Y coordinate, try updating X coordinate instead
2FEB: D7 66       STB   $66                  // store B in $9866 (player_y)
2FED: 5F          CLRB                       // clear B because we're moving the fractional part of the horizontal delta into it  
2FEE: 47          ASRA                       // shift bit 0 into carry, while preserving bit 7 (the sign bit)
2FEF: 56          RORB                       // move carry into B, to give us the fractional part
2FF0: D3 64       ADDD  $64                  // Add D to $9864 (player_x)
2FF2: 81 07       CMPA  #$07                 // is player X past left border wall? (invalid)
2FF4: 25 06       BCS   $2FFC                // yes, coordinate is invalid, goto $2FFC
2FF6: 81 8C       CMPA  #$8C                 // is player X past far right boundary of screen? (invalid)
2FF8: 22 02       BHI   $2FFC                // yes, coordinate is invalid, goto $2FFC
2FFA: DD 64       STD   $64                  // store D in $9864 (player_x)
2FFC: EC 42       LDD   $0002,U              // get pointer to animation table into D (see $3071 for description of table)                 
2FFE: 27 30       BEQ   $3030                
3000: 10 93 72    CMPD  $72                  // are we still using the same the same animation table as before? 
3003: 27 06       BEQ   $300B                // yes, don't need to update pointer to it, goto $300B
3005: DD 72       STD   $72                  // animation needs to change, so update pointer to current animation sequence 
3007: 0F 71       CLR   $71                  // set index into animation to 0 (the start)
3009: 0F 70       CLR   $70
//
// The player may have moved but that doesn't necessarily mean the animation frame changes also. 
// It appears that $70, when 0, is the flag that says "OK, time to change animation frame"
//
300B: D6 70       LDB   $70                  // is it time to change the animation frame in the sequence?
300D: 26 17       BNE   $3026                // no, goto $3026
300F: DE 72       LDU   $72                  // get pointer to animation sequence  
3011: 96 71       LDA   $71                  // read index into animation sequence  
3013: E6 C6       LDB   A,U                  // get byte from animation sequence into B                    
3015: 26 04       BNE   $301B                // if byte is not 0, where zero indicates the end of the animation sequence, goto $301B
3017: 0F 71       CLR   $71                  // otherwise, byte is 0, animation sequence needs to start at first frame (index 0)
3019: E6 C4       LDB   ,U                   // read first byte from 
301B: 0C 71       INC   $71                  // bump index into animation sequence to next entry
301D: 5A          DECB                       // B--//  
301E: 58          ASLB                       //   
301F: 58          ASLB                       // Multiply B by 4 
3020: 4F          CLRA  
3021: C3 35 EB    ADDD  #$35EB               // compute pointer to current animation frame metadata for current player animation               
3024: DD 5C       STD   $5C                  // set animation frame metadata pointer for player
3026: 96 70       LDA   $70                  // read animation frame change countup - yes, count *up*
3028: 4C          INCA                       // count up, erm, counts up by 1...
3029: 81 02       CMPA  #$02                 // is countup < 2? When countup = 2, animation frame will change to next in sequence
302B: 25 01       BCS   $302E                // yes, <2, so no change of animation frame required yet, goto $302E 
302D: 4F          CLRA                       // OK count up is 2, so reset count up to 0. $300B will pick this up, and next frame will be drawn
302E: 97 70       STA   $70                  // update count up. 
3030: 39          RTS   


//
// X = pointer to object
// A = 
// U = pointer to linked list of objects to check for collision with
//

CHECK_IF_ANOTHER_OBJECT_PRESENT:
3085: 34 46            PSHS  U,B,A
3087: 34 06            PSHS  B,A
3089: E3 98 02         ADDD  [$02,X]         // add in width & height of animation frame metadata
308C: 34 06            PSHS  B,A             // save height (in B) and width (in A) on stack
308E: 20 1B            BRA   $30AB
3090: EC 44            LDD   $4,U
3092: A1 E4            CMPA  ,S
3094: 24 15            BCC   $30AB
3096: E1 61            CMPB  $1,S
3098: 24 11            BCC   $30AB
309A: E3 D8 02         ADDD  [$02,U]
309D: A1 62            CMPA  $2,S
309F: 23 0A            BLS   $30AB
30A1: E1 63            CMPB  $3,S
30A3: 23 06            BLS   $30AB
30A5: 34 40            PSHS  U
30A7: AC E1            CMPX  ,S++
30A9: 26 04            BNE   $30AF
30AB: EE C4            LDU   ,U              // get next object in the list            
30AD: 26 E1            BNE   $3090
30AF: 32 64            LEAS  $4,S
30B1: 35 C6            PULS  A,B,U,PC // (PUL? PC=RTS)


PLAYER_COLLISION_DETECTION:
30B3: 86 01       LDA   #$01
30B5: 97 48       STA   $48                  // Set flag to say it's the player calling the collision detection function
30B7: DC 5E       LDD   $5E                  // D = blitter destination of player
30B9: DE 6E       LDU   $6E                  // U = animation frame metadata pointer
30BB: 8E 98 21    LDX   #$9821               // X = pointer to grunts_hulks_brains_progs_cruise_tanks list
30BE: BD D0 27    JSR   $D027                // JMP $D7C9 - collision detection function
30C1: 26 2C       BNE   $30EF                // if collision, goto $30EF, KILL_PLAYER
30C3: DC 5E       LDD   $5E
30C5: DE 6E       LDU   $6E
30C7: 8E 98 23    LDX   #$9823               // pointer to electrode linked list
30CA: BD D0 27    JSR   $D027                // JMP $D7C9 - collision detection function
30CD: 26 20       BNE   $30EF                // if collision, goto $30EF, KILL_PLAYER
30CF: DC 5E       LDD   $5E
30D1: DE 6E       LDU   $6E
30D3: 8E 98 17    LDX   #$9817               // pointer to spheroids_enforcers_quarks_sparks_shells list
30D6: BD D0 27    JSR   $D027                // JMP $D7C9 - collision detection function
30D9: 26 14       BNE   $30EF                // if collision, goto $30EF, KILL_PLAYER
30DB: DC 5E       LDD   $5E
30DD: DE 6E       LDU   $6E
30DF: 8E 98 1F    LDX   #$981F               // family member linked list start
30E2: BD D0 27    JSR   $D027                // JMP $D7C9 - collision detection function
30E5: 0F 48       CLR   $48
30E7: 86 01       LDA   #$01                 // delay before calling function
30E9: 8E 30 B3    LDX   #$30B3               // address of function to call for this object next
30EC: 7E D0 66    JMP   $D066                // JMP $D1E3 - allocate task             

// Player has hit something

KILL_PLAYER:
30EF: CC 26 D9    LDD   #$26D9
30F2: BD D0 4B    JSR   $D04B                // JMP $D3C7 - play sound with priority
30F5: 86 1B       LDA   #$1B
30F7: 97 59       STA   $59
30F9: BD D0 60    JSR   $D060                // JMP D1FF    
30FC: C6 07       LDB   #$07                 // index of "men played" entry in CMOS bookkeeping totals
30FE: BD D0 BD    JSR   $D0BD                // JMP $D655 - increment bookkeeping total by 1
3101: BD D0 24    JSR   $D024                // JMP $D89E - create tasks to animate colour palette
3104: BD 5B 4C    JSR   $5B4C                // Make player flash when dying
3107: BD D0 45    JSR   $D045                // JMP $D699 - get addr of current player game state into X (but why? results never used!)
310A: B6 BD EC    LDA   p1_men               // any more men left for either player?    
310D: BA BE 28    ORA   p2_men
3110: 26 1E       BNE   $3130                // there's lives left, so adjust wave
3112: 86 FF       LDA   #$FF                 // no more men left
3114: 97 59       STA   $59
3116: CC 1C 0A    LDD   #$1C0A               // width in bytes = 1C, height = 0A
3119: 8E 3C 7E    LDX   #$3C7E               // blitter dest
311C: BD D0 1B    JSR   $D01B                // JMP $DADF - clear rectangle to black
311F: 86 28       LDA   #$28
3121: C6 AA       LDB   #$AA
3123: D7 CF       STB   $CF
3125: BD 5F 99    JSR   JMP_PRINT_STRING_LARGE_FONT    // JMP $6147         // print GAME OVER
3128: 86 78       LDA   #$78
312A: 8E E3 D3    LDX   #GET_INITIALS1
312D: 7E D0 66    JMP   $D066                // JMP $D1E3 - allocate task


//
// 
//

POST_PLAYER_DEATH_WAVE_ADJUST:
3130: BD D0 45    JSR   $D045                // JMP $D699 - get addr of current player game state into X
3133: A6 0B       LDA   $000B,X
3135: B7 BE 5D    STA   $BE5D                // set grunt minimum delay value (the absolute lowest delay any grunt can have before moving again. lower value = faster)
3138: B1 BE 5C    CMPA  $BE5C                // is the delay value beneath the current grunt delay control value? (ie: has wave lasted so long that grunts are moving too fast)
313B: 23 03       BLS   $3140                // yes, no need to adjust current grunt delay value, goto $3140
313D: B7 BE 5C    STA   $BE5C                // otherwise, make grunt delay setting = minimum grunt delay value, so grunts don't move faster than they should

3140: 4F          CLRA                       // reset A to 0 
3141: D6 ED       LDB   temp_enforcer_count  // any enforcers on screen?
3143: 27 1E       BEQ   $3163                // no, goto $3163
3145: C0 04       SUBB  #$04                 // B-= 4
3147: 2B 03       BMI   $314C                // if there's a negative result, that means B is 3 or less   
3149: 4C          INCA  
314A: 20 F9       BRA   $3145

// A = number of enforcers on screen divided by 4
// X = pointer to player game state
314C: 4D          TSTA                       // how many multiples of 4 do we have?
314D: 26 06       BNE   $3155                // if non zero, goto $3155
314F: 7D BE 6F    TST   cur_sphereoids
3152: 26 01       BNE   $3155
3154: 4C          INCA  
3155: BB BE 6F    ADDA  cur_sphereoids       // add the number of sphereoids remaining on screen to the value in A
3158: A1 88 1D    CMPA  $1D,X                // compare the value to the number of sphereoids that are on the wave originally
315B: 23 03       BLS   $3160             
315D: A6 88 1D    LDA   $1D,X                // read
3160: B7 BE 6F    STA   cur_sphereoids       // set the number of spheroids on the level to A
3163: BD 2B 69    JSR   $2B69                // copy the wave information to the player's own wave state snapshot. When it's this player's turn again, this info will be used to "re-build" the wave.
3166: BD D0 45    JSR   $D045                // JMP $D699 - get addr of current player game state into X   
3169: E6 08       LDB   $0008,X              // B = number of lives left             
316B: 26 1C       BNE   $3189                // if some lives left, goto $3189
316D: CC 1C 20    LDD   #$1C20               // width in bytes = 1C (28 decimal), height = 20 (32 decimal)
3170: 8E 3C 77    LDX   #$3C77               // blitter dest
3173: BD D0 1B    JSR   $D01B                // JMP $DADF - clear rectangle to black
3176: 86 4B       LDA   #$4B                 // string number
3178: C6 AA       LDB   #$AA                 // colour
317A: D7 CF       STB   $CF
317C: D6 3F       LDB   $3F
317E: BD 5F 99    JSR   JMP_PRINT_STRING_LARGE_FONT    // JMP $6147 
3181: 86 60       LDA   #$60
3183: 8E 31 89    LDX   #$3189
3186: 7E D0 66    JMP   $D066                // JMP $D1E3 - allocate task


SWAP_CURRENT_PLAYER:
3189: 96 3F       LDA   $3F                  // read current player 
318B: 88 03       EORA  #$03                 // make current player = 0 if current player is 1, and vice versa
318D: BD D0 48    JSR   $D048                // JMP $D699 - get addr of current player game state into X
3190: E6 08       LDB   $0008,X              // B = number of lives left
3192: 27 F7       BEQ   $318B                // if lives left is 0, goto $318B - I suspect this is to put the game into an infinite loop
3194: 97 3F       STA   $3F                  // set current player
3196: 7E 27 A3    JMP   $27A3


                        // Generate random position for an object at the start of the wave
                        //
                        // X = pointer to object
                        //
                        // Returns: A = X coordinate (multiply by 2 to get real pixel coordinate), B = Y coordinate
                        //

                        COMPUTE_INITIAL_POSITION:
                        3199: EC 98 02    LDD   [$02,X]              // get width and height into D
                        319C: 34 06       PSHS  B,A                  // save B (height) and A (width)
                        319E: 86 88       LDA   #$88                
                        31A0: A0 E0       SUBA  ,S+                  // compute #$88 minus width held on stack.
                        31A2: BD D0 42    JSR   $D042                // JMP $D6AC - multiply A by a random number and put result in A
                        31A5: 8B 06       ADDA  #$06                 // add left border 
                        31A7: 1F 89       TFR   A,B
                        31A9: 86 D2       LDA   #$D2                 // compute #$D2 minus height on stack
                        31AB: A0 E0       SUBA  ,S+             
                        31AD: BD D0 42    JSR   $D042                // JMP $D6AC - multiply A by a random number and put result in A
                        31B0: 8B 17       ADDA  #$17                 // add border top
                        31B2: 1E 89       EXG   A,B                  // swap A and B so that A = X coordinate, B = Y coordinate 
                        31B4: 39          RTS   



                        31B5: 6F 47       CLR   $0007,U
                        31B7: 6F 48       CLR   $0008,U

                        31B9: 96 59       LDA   $59
                        31BB: 2A 04       BPL   $31C1

                        //
// I'm going to go out on a limb and say that this value here is used during the demo mode, to emulate the player firing lasers.
// Am I right? Stay tuned and find out, folks!
//

31BD: DC 52       LDD   $52                     //
31BF: 20 06       BRA   $31C7


//
// Laser descriptor table. Describes the "strategy" to move the laser, positioning and animation frame metadata for a laser.
//
// There is an entry for each direction the player can fire a laser in (8 entries) and two null entries which are never used.
//
// Each entry in the table takes 6 bytes.
//
// The first two bytes is the address of the function that initialises *and* moves the laser.
// The third byte is the signed X offset to add to the players X coordinate, to place the laser in its start position.
// The fourth byte is the signed Y offset to add to the players Y coordinate, to place the laser in its start position.
// The fifth and sixth bytes form the offset into the block of data beginning at $35AE, which holds all the animation frame 
// metadata for the laser.  
//
// For example, take the 2nd entry beginning with 32 AD.
// 32AD - the first two bytes - is the address of the function that moves the laser in the given direction. 
//
// Let's inspect the next 2 bytes.
// 02 FF means the laser is going to be 4 pixels to the right of the player (remember, 2 pixels to a byte, so a value of 2 = 4 pixels) and 
// one pixel above the player. (#$FF is -1 decimal as a signed byte)
//
// And let's inspect the last 2 bytes for this entry.
// 00 04 means an offset of 4 is added to $35AE. $35AE + 4 = $35B2. Whats at memory address 35B2? 4 bytes like so:
// 01 06 35 C1
// As we know the animation frame metadata structure, we can see that we have an animation frame that is 
// 01 bytes (2 pixels) wide, 6 bytes high, and the actual pixel data begins at $35C1. 
//

LASER_DESCRIPTOR TABLE:
3237:

// null entry, never used 
00 00                                 
00 00 
00 00 

// fire up
32 AD                                       // address of function to move laser
02 FF                                       // offset from players current position. 2 bytes (=4 pixels) to right and -1 pixels above. 
00 04                                       // offset from $35AE 

// fire down
32 C7                                       // address of function to move laser 
02 04                                       // offset from players current position. 2 bytes (=4 pixels) to right and 4 pixels below top of player.  
00 04                                       // offset from $35AE 

// null entry, never used 
00 00                                       
00 00 
00 00 

// fire left
32 93                                       // address of function to move laser 
00 04                                       // offset from players current position. 0 bytes to right and 4 pixels below top of player. 
00 00                                       // offset from $35AE    

// fire up & left
33 FF                                       // address of function to move laser 
00 00                                       // offset from players current position. 0 bytes to right and 0 pixels below top of player.    
00 0C                                       // offset from $35AE  

// fire down & left
33 DC                                       // address of function to move laser 
00 04                                       // offset from players current position. 0 bytes to right and 4 pixels below top of player.  
00 08                                       // offset from $35AE  

// null entry, never used 
00 00                                       
00 00 
00 00 

// fire right
32 79                                        // address of function to move laser 
02 04                                       // offset from players current position. 2 bytes (4 pixels) to right and 4 pixels below top of player.
00 00                                       // offset from $35AE  

// fire up & right
34 22                                       // address of function to move laser 
02 00                                       // offset from players current position. 2 bytes (4 pixels) to right and 0 pixels below top of player.
00 08                                       // offset from $35AE  

// fire down & right
34 45                                       // address of function to move laser 
02 04                                       // offset from players current position. 2 bytes (4 pixels) to right and 4 pixels below top of player.  
00 0C                                       // offset from $35AE  



MOVE_PLAYER_LASER_RIGHT:
3279: AE 47       LDX   $0007,U             // get pointer to laser object from object metadata 
327B: A6 0A       LDA   $000A,X             // get X coordinate into A
327D: 8B 03       ADDA  #$03                // add 3 bytes (6 pixels) to A
327F: 81 8D       CMPA  #$8D                // at far right edge of playfield?
3281: 22 5E       BHI   $32E1               // yes, laser is out of bounds, goto $32E1
3283: A7 0A       STA   $000A,X             // no, so update laser's X coordinate  
3285: CC 01 00    LDD   #$0100              // set direction parameters for collision detection function (see docs @ $346B)
3288: BD 34 6B    JSR   $346B               // call function to handle any collisions with this laser  
328B: 86 01       LDA   #$01                // delay before calling this function
328D: 8E 32 79    LDX   #$3279              // address of this function
3290: 7E D0 66    JMP   $D066               // JMP $D1E3 - allocate task


//
// Routine to move player laser left
//
//

MOVE_PLAYER_LASER_LEFT:
3293: AE 47       LDX   $0007,U             // get pointer to laser object from object metadata  
3295: A6 0A       LDA   $000A,X             // get X coordinate into A
3297: 80 03       SUBA  #$03                // subtract 3 bytes (6 pixels, remember 2 pixels per byte) to A
3299: 81 07       CMPA  #$07                // at far left edge of playfield?
329B: 25 48       BCS   $32E5               // if <, then laser is out of bounds, goto $32E5
329D: A7 0A       STA   $000A,X             // no, so update laser's X coordinate 
329F: CC FF 00    LDD   #$FF00              // set direction parameters for collision detection function (see docs @ $346B)
32A2: BD 34 6B    JSR   $346B               // call function to handle any collisions with this laser
32A5: 86 01       LDA   #$01                // delay before calling this function
32A7: 8E 32 93    LDX   #$3293              // address of this function
32AA: 7E D0 66    JMP   $D066               // JMP $D1E3 - allocate task


//
// Routine to move player laser up
//

MOVE_PLAYER_LASER_UP:
32AD: AE 47       LDX   $0007,U             // get pointer to laser object from object metadata 
32AF: A6 0C       LDA   $000C,X             // get Y coordinate into A
32B1: 8B FA       ADDA  #$FA                // subtract 6 from A (results in move of 6 pixels) 
32B3: 81 18       CMPA  #$18                // at top of playfield?
32B5: 25 34       BCS   $32EB               // yes, laser has hit top border wall, goto $32EB
32B7: A7 0C       STA   $000C,X             // no, update laser's Y coordinate
32B9: CC 00 FF    LDD   #$00FF              // set direction parameters for collision detection function (see docs @ $346B)
32BC: BD 34 6B    JSR   $346B               // call function to handle any collisions with this laser
32BF: 86 01       LDA   #$01                // delay before calling this function
32C1: 8E 32 AD    LDX   #$32AD              // address of this function
32C4: 7E D0 66    JMP   $D066               // JMP $D1E3 - allocate task

//
// Routine to move player laser down
//

MOVE_PLAYER_LASER_DOWN:
32C7: AE 47       LDX   $0007,U             // get pointer to laser object from object metadata              
32C9: A6 0C       LDA   $000C,X             // get vertical position into A
32CB: 8B 06       ADDA  #$06                // add 6 to A (results in move of 6 pixels) 
32CD: 81 E5       CMPA  #$E5                // at bottom of playfield?
32CF: 22 1E       BHI   $32EF               // yes, laser has hit bottom border wall, goto $32EF
32D1: A7 0C       STA   $000C,X             // no, update laser's Y coordinate
32D3: CC 00 01    LDD   #$0001              // set direction parameters for collision detection function (see docs @ $346B)
32D6: BD 34 6B    JSR   $346B               // call function to handle any collisions with this laser
32D9: 86 01       LDA   #$01                // delay before calling this function
32DB: 8E 32 C7    LDX   #$32C7              // address of this function 
32DE: 7E D0 66    JMP   $D066               // JMP $D1E3 - allocate task


// called by MOVE_PLAYER_LASER_RIGHT
32E1: 86 90       LDA   #$90                // X coordinate of far right border
32E3: 20 02       BRA   $32E7

// called by MOVE_PLAYER_LASER_LEFT
32E5: 86 06       LDA   #$06                // X coordinate of far left border

32E7: E6 0C       LDB   $000C,X             // B = vertical position 
32E9: 20 0A       BRA   $32F5

// called by MOVE_PLAYER_LASER_UP
32EB: C6 17       LDB   #$17                // Y coordinate of topmost border
32ED: 20 02       BRA   $32F1

// called by MOVE_PLAYER_LASER_DOWN
32EF: C6 EB       LDB   #$EB                // Y coordinate of bottommost border
32F1: A6 0A       LDA   $000A,X             // get X coordinate of laser into A
32F3: 20 2F       BRA   $3324

//
// This routine draws the laser "impacting" on the border walls. The laser's impact spreads vertically. (think of a bullet hitting a solid wall and you'll get what I mean)
//
// D = address on screen to draw a "flattened out" laser 
//

DRAW_LASER_SPLASH_DAMAGE_VERTICAL:
32F5: ED 49       STD   $0009,U              // store address on screen of part of wall where laser hit              
32F7: BD 34 A3    JSR   $34A3                // dispose of laser object and erase laser image
32FA: AE 49       LDX   $0009,U
32FC: 96 91       LDA   $91                  // get colour to draw splash damage in A... 
32FE: D6 91       LDB   $91                  // ... and B
3300: ED 1F       STD   $-1,X                // write to screen 1 pixel above of where laser hit. 4 pixels are written - 2 horizontally and 2 vertically
3302: A7 01       STA   $0001,X              // write to screen 1 pixel below where laser hit
3304: 86 02       LDA   #$02                 // delay
3306: 8E 33 0C    LDX   #$330C               // address of function to call
3309: 7E D0 66    JMP   $D066                // JMP $D1E3 - allocate task

//
// remove splash damage from wall
//
UNDO_LASER_SPLASH_DAMAGE_VERTICAL:
330C: 96 8F       LDA   $8F                  // get wall colour                  
330E: AE 49       LDX   $0009,U              // get address on screen where laser "splash damage" was drawn
3310: A7 1F       STA   $-1,X                // and undo what was done at $3300
3312: A7 01       STA   $0001,X              // and undo what was done at $3302. 
3314: 86 01       LDA   #$01                 // delay
3316: 8E 33 1C    LDX   #$331C               // address of function to call
3319: 7E D0 66    JMP   $D066                // JMP $D1E3 - allocate task


// remove final trace of laser
RESTORE_WALL_VERTICAL:
331C: 96 8F       LDA   $8F                  // get wall colour
331E: A7 D8 09    STA   [$09,U]              // and finally erase last vestige of laser
3321: 7E D0 63    JMP   $D063                // JMP $D1F3 - free object metadata and process next task 



//
// This routine draws the laser "impacting" on the walls. The laser's impact spreads horizontally. (think of a bullet hitting a solid wall and you'll get what I mean)
//
// D = address on screen to draw a "flattened out" laser 
//

DRAW_LASER_SPLASH_DAMAGE_HORIZONTAL:
3324: C1 EA       CMPB  #$EA                 // did laser hit bottom part of wall?
3326: 24 02       BCC   $332A                // yes, goto $332A
3328: C6 16       LDB   #$16                 // ok, set Y coordinate to #$16 (22 decimal) where laser hit wall
332A: 81 06       CMPA  #$06                 // did laser hit left part of wall?                 
332C: 22 01       BHI   $332F
332E: 4C          INCA  
332F: ED 49       STD   $0009,U              // store address on screen of part of wall where laser hit              
3331: BD 34 A3    JSR   $34A3                // dispose of laser object and erase laser image
3334: 96 91       LDA   $91                  // get colour to draw flattened laser in A...  
3336: D6 91       LDB   $91                  // ... and B
3338: AE 49       LDX   $0009,U              // get address on screen where laser hit wall                          
333A: ED 84       STD   ,X                   // draw 4 pixels (2 bytes) at part of wall where laser hit
//
// Some notes. As you recall, the Williams hardware has 4 bits per pixel. Therefore 2 pixels are packed into a single byte. 
// The left nibble (bits 7..4) is the first pixel and the right nibble (bits 3..0) is the second pixel. 
333C: 96 8F       LDA   $8F                  // get wall colour  
333E: 84 F0       ANDA  #$F0                 // preserve the leftmost pixel (the left nibble, as described above)
3340: 34 02       PSHS  A                    // save result on stack
3342: 96 91       LDA   $91                  // get colour to draw flattened laser into A 
3344: 84 0F       ANDA  #$0F                 // preserve the rightmost pixel (the right nibble)
3346: AB E0       ADDA  ,S+                  // combine the leftmost pixel of the wall colour and the rightmost pixel of the flattened laser. Now A holds 2 pixels
3348: 1F 89       TFR   A,B                  // 
334A: ED 89 FF 00 STD   $FF00,X              // write D 2 pixels to left of where the laser hit the wall - creating splash damage
334E: 86 02       LDA   #$02                 // delay before calling function 
3350: 8E 33 56    LDX   #$3356               // address of function to call
3353: 7E D0 66    JMP   $D066                // JMP $D1E3 - allocate task

//
// remove splash damage from wall
//
UNDO_HORIZONTAL_SPLASH_DAMAGE:
3356: AE 49       LDX   $0009,U              // get address on screen where laser "splash damage" was drawn 
3358: 96 8F       LDA   $8F                  // get wall colour into A..
335A: D6 8F       LDB   $8F                  // and B.. Now D has 4 pixel's worth of wall colour.
335C: ED 89 FF 00 STD   $FF00,X              // write D 2 pixels (1 byte) to left of where laser hit wall. Undoes what was done at $334A
3360: 84 0F       ANDA  #$0F                 // remove left hand pixel from A. 
3362: C4 0F       ANDB  #$0F                 // remove left hand pixel from B. 
3364: 34 06       PSHS  B,A                  // push remaining pixels on stack
3366: 96 91       LDA   $91                  // get colour to draw splash damage into A... 
3368: D6 91       LDB   $91                  // and B. Now D has 4 pixel's worth of splash damage colour.
336A: 84 F0       ANDA  #$F0                 // remove right hand pixel from A
336C: C4 F0       ANDB  #$F0                 // remove right hand pixel from B
336E: E3 E1       ADDD  ,S++                 // combine those pixels with those on the stack 
3370: ED 84       STD   ,X                   // and write to the screen. The laser's splash damage is ALMOST removed now. RESTORE_WALL_HORIZONTAL completes the job.   
3372: 86 01       LDA   #$01                 // delay before calling function
3374: 8E 33 7A    LDX   #$337A               // address of function to call
3377: 7E D0 66    JMP   $D066                // JMP $D1E3 - allocate task

// remove final trace of laser
RESTORE_WALL_HORIZONTAL:
337A: 96 8F       LDA   $8F                  // get wall colour into A..
337C: D6 8F       LDB   $8F                  // and B..
337E: ED D8 09    STD   [$09,U]              // set part of wall where laser hit back to wall colour - removing last trace of laser
3381: 7E D0 63    JMP   $D063                // JMP $D1F3 - free object metadata and process next task

3384: 7E 32 F5    JMP   $32F5                // jump to DRAW_LASER_SPLASH_DAMAGE_VERTICAL

3387: 20 9B       BRA   $3324                // go to DRAW_LASER_SPLASH_DAMAGE_HORIZONTAL


//
// When we get here, the laser has hit a border wall.
//
// A = horizontal direction of laser ($FF = left, 0 =no horizontal movement, 1=right)
// B = vertical direction of laser ($FF = up, 0 = no vertical movement, 1 = down)
// Y = packed word containing deltas to add to laser position.
// Most significant byte: 
//

LASER_HIT_WALL:
3389: D7 2C       STB   $2C                  // store vertical direction
338B: 5F          CLRB  
338C: 47          ASRA  
338D: 56          RORB  
338E: DD 2D       STD   $2D
3390: 1F 20       TFR   Y,D                  // A holds horizontal delta of laser, B holds vertical delta of laser
3392: AB 0A       ADDA  $000A,X              // A+= X coordinate of laser
3394: EB 0C       ADDB  $000C,X              // B+= Y coordinate of laser
3396: A7 0A       STA   $000A,X              // update X coordinate of laser
3398: E7 0C       STB   $000C,X              // update Y coordinate of laser
339A: DC 2D       LDD   $2D
339C: E3 0A       ADDD  $000A,X
339E: ED 0A       STD   $000A,X
33A0: E6 0C       LDB   $000C,X
33A2: DB 2C       ADDB  $2C
33A4: E7 0C       STB   $000C,X
33A6: C1 EA       CMPB  #$EA                 // hit bottom wall?  
33A8: 22 DD       BHI   $3387                // yes, goto $3387, which then branches to DRAW_LASER_SPLASH_DAMAGE_HORIZONTAL
33AA: C1 18       CMPB  #$18                 // hit top wall?
33AC: 25 D9       BCS   $3387                // yes, goto $3387 
33AE: 81 8F       CMPA  #$8F                 // hit right wall?
33B0: 22 D2       BHI   $3384                // yes, goto $3384, which then jumps to DRAW_LASER_SPLASH_DAMAGE_VERTICAL
33B2: 81 07       CMPA  #$07                 // hit left wall?
33B4: 25 CE       BCS   $3384                // yes, goto $3384
33B6: 20 E2       BRA   $339A

// called by MOVE_PLAYER_LASER_DOWN_LEFT
33B8: 10 8E 00 05 LDY   #$0005
33BC: CC FF 01    LDD   #$FF01
33BF: 20 C8       BRA   $3389

// called by MOVE_LASER_UP_LEFT
33C1: 10 8E 00 00 LDY   #$0000
33C5: CC FF FF    LDD   #$FFFF
33C8: 20 BF       BRA   $3389

// called by MOVE_LASER_UP_RIGHT
33CA: 10 8E 02 00 LDY   #$0200
33CE: CC 01 FF    LDD   #$01FF
33D1: 20 B6       BRA   $3389

// called by MOVE_LASER_DOWN_RIGHT
33D3: 10 8E 02 05 LDY   #$0205
33D7: CC 01 01    LDD   #$0101
33DA: 20 AD       BRA   $3389


//
// Routine to move player laser down left
//
// I wonder why these routines are down here, instead of being up there with the rest of the laser movement code?
// Could it be, that the diagonal firing was added later when Vid Kidz decided 4-way firing wasn't good enough?
//

MOVE_PLAYER_LASER_DOWN_LEFT:
33DC: AE 47       LDX   $0007,U              // get pointer to laser object from object metadata 
33DE: A6 0A       LDA   $000A,X              // get X coordinate of laser into A
33E0: 80 03       SUBA  #$03                 // subtract 3 (effectively 6 pixels) from X coordinate
33E2: E6 0C       LDB   $000C,X              // get vertical position into B
33E4: CB 06       ADDB  #$06                 // add 6 to vertical position
33E6: 81 07       CMPA  #$07                 // has laser hit left border wall?
33E8: 25 CE       BCS   $33B8                // yes, goto $33B8                
33EA: C1 E5       CMPB  #$E5                 // has laser hit bottom border wall??
33EC: 22 CA       BHI   $33B8                // yes, goto $33B8                
33EE: A7 0A       STA   $000A,X              // update X coordinate of laser
33F0: E7 0C       STB   $000C,X              // update Y coordinate of laser
33F2: CC FF 01    LDD   #$FF01               // set direction parameters for collision detection function (see docs @ $346B) 
33F5: 8D 74       BSR   $346B                // call function to handle any collisions with this laser
33F7: 86 01       LDA   #$01
33F9: 8E 33 DC    LDX   #$33DC               // address of function to call (this one)
33FC: 7E D0 66    JMP   $D066                // JMP $D1E3 - allocate task


//
// Routine to move player laser up left.
//

MOVE_LASER_UP_LEFT:
33FF: AE 47       LDX   $0007,U              // get pointer to laser object from object metadata 
3401: A6 0A       LDA   $000A,X              // get X coordinate into A
3403: 80 03       SUBA  #$03                 // subtract 3 (effectively 6 pixels) from X coordinate
3405: 81 07       CMPA  #$07                 // has laser hit left border wall?
3407: 25 B8       BCS   $33C1                // yes, goto $33C1
3409: E6 0C       LDB   $000C,X              // get vertical position into B
340B: C0 06       SUBB  #$06                 // subtract 6 from Y coordinate 
340D: C1 18       CMPB  #$18                 // has laser hit top border wall?
340F: 25 B0       BCS   $33C1                // yes, goto $33C1
3411: A7 0A       STA   $000A,X              // update X coordinate of laser 
3413: E7 0C       STB   $000C,X              // update Y coordinate of laser
3415: CC FF FF    LDD   #$FFFF               // set direction parameters for collision detection function (see docs @ $346B)
3418: 8D 51       BSR   $346B                // call function to handle any collisions with this laser
341A: 86 01       LDA   #$01
341C: 8E 33 FF    LDX   #$33FF               // address of function to call 
341F: 7E D0 66    JMP   $D066                // JMP $D1E3 - allocate task


MOVE_LASER_UP_RIGHT:
3422: AE 47       LDX   $0007,U              // get pointer to laser object from object metadata 
3424: A6 0A       LDA   $000A,X              // get X coordinate into A  
3426: 8B 03       ADDA  #$03                 // add 3 (effectively 6 pixels) to X coordinate
3428: 81 8D       CMPA  #$8D                 // has laser hit far right border wall?
342A: 22 9E       BHI   $33CA                // yes, goto $33CA
342C: E6 0C       LDB   $000C,X              // get vertical position into B
342E: C0 06       SUBB  #$06                 // subtract 6 from Y coordinate 
3430: C1 18       CMPB  #$18                 // has laser hit top border wall?
3432: 25 96       BCS   $33CA
3434: A7 0A       STA   $000A,X              // update X coordinate of laser 
3436: E7 0C       STB   $000C,X              // update Y coordinate of laser
3438: CC 01 FF    LDD   #$01FF               // set direction parameters for collision detection function (see docs @ $346B)
343B: 8D 2E       BSR   $346B                // call function to handle any collisions with this laser
343D: 86 01       LDA   #$01
343F: 8E 34 22    LDX   #$3422               // address of function to call 
3442: 7E D0 66    JMP   $D066                // JMP $D1E3 - allocate task


MOVE_LASER_DOWN_RIGHT:
3445: AE 47       LDX   $0007,U              // get pointer to laser object from object metadata 
3447: A6 0A       LDA   $000A,X              // get X coordinate into A
3449: 8B 03       ADDA  #$03                 // add 3 (effectively 6 pixels) to X coordinate
344B: 81 8D       CMPA  #$8D                 // has laser hit far right border wall?
344D: 22 84       BHI   $33D3                // yes, goto $33D3
344F: E6 0C       LDB   $000C,X              // get vertical position into B
3451: CB 06       ADDB  #$06                 // add 6 to Y coordinate             
3453: C1 E5       CMPB  #$E5                 // has laser hit far bottom border wall?
3455: 23 03       BLS   $345A                // no, goto $345A
3457: 7E 33 D3    JMP   $33D3                

345A: A7 0A       STA   $000A,X              // update X coordinate of laser 
345C: E7 0C       STB   $000C,X              // update Y coordinate of laser
345E: CC 01 01    LDD   #$0101               // set direction parameters for collision detection function (see docs @ $346B)
3461: 8D 08       BSR   $346B                // call function to handle any collisions with this laser
3463: 86 01       LDA   #$01
3465: 8E 34 45    LDX   #$3445               // address of function to call 
3468: 7E D0 66    JMP   $D066                // JMP $D1E3 - allocate task



//
// Expects: 
// A = horizontal direction of laser ($FF = left, 0 = not moving horizontally, 1=right)
// B = vertical direction of laser ($FF = up, 0 = not moving vertically, 1 = down)
// X = pointer to laser object
//

LASER_COLLISION_DETECTION:
346B: DD 88       STD   $88                  // set player laser directions
346D: BD D0 8D    JSR   $D08D                // JMP $DB2F - erase then re-blit object 
3470: 34 50       PSHS  U,X
3472: EE 02       LDU   $0002,X              // get animation frame metadata pointer into U 
3474: EC 04       LDD   $0004,X              // read blitter destination into D           
3476: 8E 98 23    LDX   #$9823               // electrode list pointer
3479: BD D0 27    JSR   $D027                // JMP $D7C9 - collision detection function
347C: 26 1E       BNE   $349C
347E: AE E4       LDX   ,S
3480: EE 02       LDU   $0002,X
3482: EC 04       LDD   $0004,X
3484: 8E 98 21    LDX   #$9821               // pointer to grunts/hulks/brains/progs/cruise missile/tank list
3487: BD D0 27    JSR   $D027                // JMP $D7C9 - collision detection function
348A: 26 10       BNE   $349C
348C: AE E4       LDX   ,S
348E: EE 02       LDU   $0002,X
3490: EC 04       LDD   $0004,X
3492: 8E 98 17    LDX   #$9817               // pointer to quarks, sparks, sphereoids, enforcers, tank shells 
3495: BD D0 27    JSR   $D027                // JMP $D7C9 - collision detection function
3498: 26 02       BNE   $349C
349A: 35 D0       PULS  X,U,PC //(PUL? PC=RTS)

349C: 35 50       PULS  X,U
349E: 8D 03       BSR   $34A3                // dispose of laser object and erase laser image
34A0: 7E D0 63    JMP   $D063                // JMP $D1F3 - free object metadata and process next task


//
// Erase the laser image from the screen and free the laser object 
//
//

ERASE_LASER_AND_FREE_OBJECT:
34A3: BD D0 15    JSR   $D015                // JMP $DB03 - erase object from screen
34A6: DC 1B       LDD   $1B           
34A8: ED 84       STD   ,X
34AA: 9F 1B       STX   $1B                  // mark this laser as current first free object
34AC: 0A 87       DEC   $87                  // reduce count of lasers on screen
34AE: 39          RTS   



DRAW_BORDER_WALLS:
3526: 8E 06 16    LDX   #$0616
3529: 96 8F       LDA   $8F                  // read current wall colour
352B: A7 89 8A 00 STA   $8A00,X              // plot pixels for right hand border wall
352F: A7 80       STA   ,X+                  // plot pixels for left hand border wall
3531: 8C 06 EC    CMPX  #$06EC               // all side walls drawn?
3534: 23 F5       BLS   $352B                // if not, goto $352B
3536: 8E 07 16    LDX   #$0716               // screen address for top border
3539: D6 8F       LDB   $8F                  // read current wall colour (now D = wall colour)
353B: ED 84       STD   ,X                   // write top border wall
353D: ED 89 00 D5 STD   $00D5,X              // write bottom border wall
3541: 30 89 01 00 LEAX  $0100,X              // move to next pixel pair across (remember Williams graphics hardware screen layout) 
3545: 8C 8F 16    CMPX  #$8F16               // all top & bottom walls drawn?
3548: 23 F1       BLS   $353B                // if not, goto $353B
354A: 39          RTS                        // done


//
// This is a task that runs throughout the game to ensure the electrodes are drawn.
// It draws electrodes one at a time (not all at once which might be too processor intensive), 
// cycling through the electrode list from start to finish. 
//
// This is called from $284A.  
// 
// expects:
// $9890 = colour to draw electrodes in
// $9892 = number of electrodes to draw
// $9893 = pointer to animation frame metadata for electrode 
//

DRAW_ALL_ELECTRODES_TASK:
354B: DE 27       LDU   $27                  // U = pointer to electrode to draw
354D: 11 83 B3 E4 CMPU  #$B3E4               // are we at the end of the electrode list?
3551: 25 03       BCS   $3556                // no, goto $3556
3553: CE B3 A4    LDU   #$B3A4               // yes, so start again from first electrode
3556: 96 92       LDA   $92                  // A = count of electrodes to process (not same as number of electrodes alive)
3558: 34 02       PSHS  A                   
355A: 10 9E 93    LDY   $93                  // Y = pointer to list of animation frame metadata for this electrode
355D: AE C1       LDX   ,U++                 // get object pointer from U
355F: 27 21       BEQ   $3582                // if X == 0 then get next pointer 
3561: EC A4       LDD   ,Y                   // read width in bytes, and height
3563: 88 04       EORA  #$04                 // XOR width with 4 for blitter 
3565: C8 04       EORB  #$04                 // XOR height with 4 for blitter 
3567: 1A 10       ORCC  #$10                 // disable interrupts
3569: FD CA 06    STD   blitter_w_h
356C: D6 90       LDB   $90                  // read colour to draw electrodes in
356E: F7 CA 01    STB   blitter_mask
3571: EC 22       LDD   $0002,Y              // read pointer to actual image
3573: FD CA 02    STD   blitter_source
3576: EC 04       LDD   $0004,X              // read blitter destination from object
3578: FD CA 04    STD   blitter_dest
357B: C6 1A       LDB   #$1A                 // blitter flags: 11010 - transparent, solid   
357D: F7 CA 00    STB   start_blitter
3580: 1C EF       ANDCC #$EF                 // clear interrupt flag
3582: 6A E4       DEC   ,S                   // reduce count of electrodes to process by one
3584: 26 D7       BNE   $355D                // if !=0, get next one
3586: 32 61       LEAS  $0001,S              // discard A pushed on stack @ $3558
3588: DF 27       STU   $27                  // bump to next electrode to draw
358A: 86 02       LDA   #$02                 // delay
358C: 8E 35 4B    LDX   #$354B               // address of function to call (this) - this task keeps going until the wave is cleared or player dies/ game ends
358F: 7E D0 66    JMP   $D066                // JMP $D1E3 - allocate task 

3592: 03 08       COM   $08
3594: 35 96       PULS  A,B,X,PC //(PUL? PC=RTS)

3596: 02 22 00 BB 0B B0 BB 0B B0 00 20 00 88 08 80 30 
35A6: 80 30 08 08 00 88 08 80 03 01 35 BE 01 06 35 C1 
35B6: 03 06 35 C7 03 06 35 D9 AA AA AA A0 A0 A0 A0 A0 
35C6: A0 00 00 0A 00 00 A0 00 0A 00 00 A0 00 0A 00 00 
35D6: A0 00 00 A0 00 00 0A 00 00 00 A0 00 00 0A 00 00 
35E6: 00 A0 00 00 0A 





                    INITIALISE_ALL_GRUNTS:
                    38AA: B6 BE 68    LDA   cur_grunts           // read number of grunts
                    38AD: 34 02       PSHS  A
                    38AF: 27 4B       BEQ   $38FC                // if we have no grunts, goto $38FC
                    38B1: BD D0 7B    JSR   $D07B                // JMP $D2DA - reserve entry in list used by grunts, hulks, brains, progs, cruise missiles and tanks (starts at $9821)
                    // X = newly reserved object entry
                    38B4: CC 40 63    LDD   #$4063               // set blitter source to start image's metadata
                    38B7: ED 02       STD   $0002,X              // set current animation frame metadata pointer
                    38B9: ED 88 14    STD   $14,X                // set previous animation frame metadata pointer (previous = current)
                    38BC: 8D D0       BSR   $388E                // JMP $38FE - compute player safe rectangle 
                    38BE: BD 26 C3    JSR   $26C3                // JMP $3199 - get random position on playfield for object (returns: A = X coordinate, B = Y coordinate)
                    38C1: D1 2B       CMPB  $2B
                    38C3: 23 0C       BLS   $38D1
                    38C5: D1 2C       CMPB  $2C
                    38C7: 24 08       BCC   $38D1
                    38C9: 91 2D       CMPA  $2D
                    38CB: 23 04       BLS   $38D1
                    38CD: 91 2E       CMPA  $2E

                    38CF: 25 ED       BCS   $38BE                // position is invalid, go compute a new position 
                    38D1: ED 04       STD   $0004,X              // blitter destination = D
                    38D3: A7 0A       STA   $000A,X              // X coordinate = A
                    38D5: E7 0C       STB   $000C,X              // Y coordinate = B
                    38D7: 1F 03       TFR   D,U                  // U = blitter destination
                    38D9: EC 98 02    LDD   [$02,X]              // get width in bytes and height of initial grunt image into D                                 
                    38DC: BD D0 03    JSR   $D003                // JMP $DE0F - TEST_FOR_PIXELS_WITHIN_RECTANGLE
                    38DF: 26 DD       BNE   $38BE                // if Z==0 then there is something under the grunt, so new coordinates are required                         
                    38E1: B6 BE 5C    LDA   $BE5C                // 
                    38E4: BD D0 42    JSR   $D042                // JMP $D6AC - multiply A by a random number and put result in A
                    38E7: A7 88 13    STA   $13,X                // set movement delay field
                    38EA: CC 3A 76    LDD   #$3A76               // address of routine to jump to when grunt hits something
                    38ED: ED 08       STD   $0008,X              //
                    38EF: 8D 9A       BSR   $388B                // JMP $393C - blit grunt in solid colour invisible to player
                    38F1: 6A E4       DEC   ,S                   // decrement count of grunts on stack
                    38F3: 26 BC       BNE   $38B1                // if !=0 then we've got more grunts to process, goto $38B1
                    38F5: 9F 8B       STX   $8B                  // store index of last grunt in $8B.
                    38F7: BD D0 54    JSR   $D054                // JMP $D281 - reserve object metadata entry and call function
                    38FA: 39 B7          // pointer to function
                    38FC: 35 82          PULS A, PC //(PUL? PC=RTS)




                    //
                    // When a wave starts, there is an invisible rectangular "safe" area containing the player that the enemies cannot be placed into.
                    // this is to give the player a fighting chance. As you advance through waves the safe area gets smaller.
                    //
                    // 

                    COMPUTE_PLAYER_SAFE_RECTANGLE:
                    38FE: 34 56       PSHS  U,X,B,A
                    3900: BD D0 45    JSR   $D045                // JMP $D699 - get addr of current player game state into X
                    3903: A6 09       LDA   $0009,X              // read wave number
                    3905: 81 0A       CMPA  #$0A                 // compare to #$0A (10 decimal)
                    3907: 25 04       BCS   $390D                // if < goto $390D
                    3909: 86 06       LDA   #$06                 // ok, wave number is 10 or more, so use wave 6's information 
                    390B: 20 06       BRA   $3913

                    390D: 81 05       CMPA  #$05                 // compare wave number to 5
                    390F: 23 02       BLS   $3913                // if <= 5 goto $3913
                    3911: 86 05       LDA   #$05             
                    3913: 8E 39 20    LDX   #$3920               // address of safe area rectangle list. Each rectangle occupies 4 bytes.
                    3916: 48          ASLA  
                    3917: 48          ASLA                       // multiply wave number in A by 4  
                    3918: 30 86       LEAX  A,X                  // X+= A 
                    391A: EC 84       LDD   ,X                   
                    391C: DD 2B       STD   $2B
                    391E: EC 02       LDD   $0002,X
                    3920: DD 2D       STD   $2D
                    3922: 35 D6       PULS  A,B,X,U,PC //(PUL? PC=RTS)


                        // wave 1 safe area
                        3924: 40 B0   // 64   190
                        3926: 1A 7A    // 26 // 122


                        // wave 2 safe area
                        3928: 48 A8    // 72  168
                        392A: 1A 7A     // 26  // 122

                        // wave 3 safe area
                        392C: 50 A0    // 80  // 160 
                        392E: 2A 6A    // 42 // 106

                        // wave 4 safe area
                        3930: 54 9D  // 84   157 
                        3932: 30 60  // // 48  // 96

                        // wave 5 safe area
                        3934: 5D 96  // 93  150 
                        3936: 35 59  // 53 // 89

                        // wave 6 safe area
                        3938: 62 94 // 98    148
                        93A: 38 5C  //  56   92



//
// Draw an object in a solid colour that the player can't see. 
//
// This function is called during the wave setup when objects like baddies and family members are given their initial places. 
// It draws the objects in a colour that we can't see, but the system can detect, to ensure no objects overlap at wave start. 
//
// We do not want objects to be stacked on top of other objects - for example a grunt being stacked on top of an electrode, that would kill them both!
//

BLIT_IN_SOLID_COLOUR_INVISIBLE_TO_PLAYER:
393C: 34 26       PSHS  Y,B,A
393E: 86 66       LDA   #$66                 // solid colour
3940: 20 02       BRA   $3944                // do solid and transparent blit


DO_SOLID_AND_TRANSPARENT_BLIT:
3942: 34 26       PSHS  Y,B,A
3944: 97 2D       STA   $2D                  // set solid colour
3946: EC 04       LDD   $0004,X              // D = blitter destination
3948: 10 AE 02    LDY   $0002,X              // Y = pointer to animation frame metadata
394B: BD D0 90    JSR   $D090                // JMP $DA9E - do solid and transparent blit
394E: 35 A6       PULS  A,B,Y,PC //(PUL? PC=RTS)



                            INITIALISE_ALL_ELECTRODES:
                            3950: 34 70       PSHS  U,Y,X
                            3952: 8E B3 A4    LDX   #$B3A4
                            3955: 9F 27       STX   $27
                            3957: 31 84       LEAY  ,X                   // Y = X (#$B3A4)
                            3959: 6F 80       CLR   ,X+                  // clear (zero) from $B3A4 to $B3E3
                            395B: 8C B3 E4    CMPX  #$B3E4
                            395E: 25 F9       BCS   $3959
                            3960: B6 BE 69    LDA   cur_electrodes       // read number of electrodes
                            3963: 34 02       PSHS  A                    // save number on stack
                            3965: 27 4E       BEQ   $39B5                // number of electrodes 0? If so, goto $39B5 (just an RTS)
                            3967: BD D0 81    JSR   $D081                // JMP $D2E7 - reserve an electrode object entry
                            396A: DC 93       LDD   $93                  // get current electrode animation frame metadata pointer
                            396C: ED 02       STD   $0002,X              // set current animation frame metadata pointer
                            396E: ED 88 14    STD   $14,X                // set previous animation frame metadata pointer (previous = current)
                            3971: 8D 8B       BSR   $38FE                // compute safe rectangle for player
                            3973: DC 2B       LDD   $2B
                            3975: C3 03 FC    ADDD  #$03FC
                            3978: DD 2B       STD   $2B
                            397A: DC 2D       LDD   $2D
                            397C: C3 02 FD    ADDD  #$02FD
                            397F: DD 2D       STD   $2D
                            3981: BD 26 C3    JSR   $26C3                // JMP $3199 - get random position on playfield for object (returns: A = X coordinate, B = Y coordinate)
                            3984: D1 2B       CMPB  $2B                  
                            3986: 23 0C       BLS   $3994
                            3988: D1 2C       CMPB  $2C
                            398A: 24 08       BCC   $3994
                            398C: 91 2D       CMPA  $2D
                            398E: 23 04       BLS   $3994
                            3990: 91 2E       CMPA  $2E
                            3992: 25 ED       BCS   $3981                // position is invalid, go recompute another position

                            3994: ED 04       STD   $0004,X              // current blitter destination
                            3996: A7 0A       STA   $000A,X              // set object X coordinate
                            3998: E7 0C       STB   $000C,X              // set object Y coordinate
                            399A: EE 04       LDU   $0004,X              // U = blitter destination of object
                            399C: EC 98 02    LDD   [$02,X]              // A= width of object in bytes, B = height of object
                            399F: BD D0 03    JSR   $D003                // JMP $DE0F - TEST_FOR_PIXELS_WITHIN_RECTANGLE
                            39A2: 26 DD       BNE   $3981                // Z flag is non-zero, pixels have been found, can't place electrodel here, goto $3981
                            39A4: CC 3A A9    LDD   #$3AA9               // Address of function to handle electrode collision detection
                            39A7: ED 08       STD   $0008,X
                            39A9: 10 AF 06    STY   $0006,X              // store pointer to object metadata 
                            39AC: 31 22       LEAY  $0002,Y            
                            39AE: BD 38 8B    JSR   $388B                // JMP $393C - blit electrode in solid colour invisible to player
                            39B1: 6A E4       DEC   ,S                   // decrement electrode count on stack
                            39B3: 26 B2       BNE   $3967            
                            39B5: 35 F2       PULS  A,X,Y,U,PC //(PUL? PC=RTS)

                            39B7: 96 59       LDA   $59
                            39B9: 85 7F       BITA  #$7F
                            39BB: 27 08       BEQ   $39C5
                            39BD: 86 02       LDA   #$02                 // delay before calling function
                            39BF: 8E 39 B7    LDX   #$39B7               // start of this function             
                            39C2: 7E D0 66    JMP   $D066                // JMP $D1E3 - allocate task       

                            39C5: 86 0A       LDA   #$0A                 // delay before calling function
                            39C7: 8E 39 CD    LDX   #$39CD               // address of function that moves the grunt
                            39CA: 7E D0 66    JMP   $D066                // JMP $D1E3 - allocate task



//
// Called by $D1E0
                        // 

                        GRUNT_AI:
                        39CD: 5F          CLRB  
                        39CE: B6 BE 68    LDA   cur_grunts           // read number of grunts
                        39D1: 34 06       PSHS  B,A                    
                        39D3: 27 0F       BEQ   $39E4                // 0? if so, go to $39E4 - we're done
                        39D5: 9E 8B       LDX   $8B                  // get pointer to FIRST grunt
                        39D7: 20 02       BRA   $39DB            

                        // here, X = pointer to a grunt object. The first two bytes of the object point
                        // to the NEXT grunt object in the list, making it a forward-only linked list type 
                        // setup. 

                    39D9: AE 84       LDX   ,X                   // get pointer to NEXT grunt 
                    39DB: 6A 88 13    DEC   $13,X                // decrement move countdown counter
                    39DE: 27 06       BEQ   $39E6                // if zero its time for grunt to move
                    39E0: 6A E4       DEC   ,S                   // decrement grunt count (on the stack)
                    39E2: 26 F5       BNE   $39D9                // go get next grunt
                    39E4: 20 7E       BRA   $3A64                // we're done with grunts

                    MOVE_GRUNT:
                    39E6: B6 BE 5C    LDA   $BE5C                // read grunt speed control field
                    39E9: BD D0 42    JSR   $D042                // JMP $D6AC - multiply A by a random number and put result in A
                    39EC: A7 88 13    STA   $13,X                // set move countdown counter to random number
                    39EF: E6 0C       LDB   $000C,X              // get grunt Y coordinate 
                    39F1: D0 66       SUBB  $66                  // subtract player_y
                    39F3: 22 08       BHI   $39FD                // no carry? if so, this means the player is above or about the same Y position as the grunt, goto $39FD
                    39F5: C1 FE       CMPB  #$FE                 // is difference from grunt Y to player Y >-2?
                    39F7: 22 16       BHI   $3A0F                // yes, so don't make any adjustments to grunt Y
                    39F9: C6 04       LDB   #$04                 // we're wanting to move grunt +4 pixels down
                    39FB: 20 06       BRA   $3A03
                    39FD: C1 02       CMPB  #$02                 // is difference from grunt Y to player Y <2 ?                    
                    39FF: 25 0E       BCS   $3A0F                // yes, so don't make any adjustments to grunt Y
                    3A01: C6 FC       LDB   #$FC                 // move grunt -4 pixels up
                    3A03: EB 0C       ADDB  $000C,X              // add in grunt Y coordinate                            
                    3A05: C1 DE       CMPB  #$DE                 // is grunt Y > $#DE? (past bottom border)
                    3A07: 22 06       BHI   $3A0F                // Yes, go to $3A0F, do not update grunt Y coordinate
                    3A09: C1 18       CMPB  #$18                 // is grunt Y < $#18 (past top border)?
                    3A0B: 25 02       BCS   $3A0F                // Yes, go to $3A0F, do not update grunt Y coordinate

                        // if we get here, grunt Y position about to be updated
                        3A0D: E7 0C       STB   $000C,X              // update grunt Y coordinate

                        // now read the grunt's X position
                        3A0F: E6 0A       LDB   $000A,X              // get grunt X coordinate 
                        3A11: D0 64       SUBB  $64                  // subtract player_X coordinate        
                        3A13: 22 04       BHI   $3A19                // no carry? if so, go to $3A19
                        3A15: C6 02       LDB   #$02                 // we're wanting to move grunt 4 pixels (2 bytes) to the right
                        3A17: 20 06       BRA   $3A1F

                        3A19: C1 01       CMPB  #$01
                        3A1B: 25 0E       BCS   $3A2B
                        3A1D: C6 FE       LDB   #$FE                 // -2 bytes to left (which is 4 pixels)
                        3A1F: EB 0A       ADDB  $000A,X              // add in grunt's X coordinate 
                        3A21: C1 8A       CMPB  #$8A                 // is grunt X > $#8A (past right border) ? 
                        3A23: 22 06       BHI   $3A2B                // Yes, go to $3A2B, do not update grunt X coordinate
                        3A25: C1 07       CMPB  #$07                 // is grunt X < #$07 (past left border) ?
                        3A27: 25 02       BCS   $3A2B                // Yes, go to $3A2B, do not update grunt X coordinate
                                                3A29: E7 0A       STB   $000A,X              // update grunt X coordinate 

                        DRAW_GRUNT:
                        3A2B: EC 02       LDD   $0002,X              // get animation frame metadata pointer 
                        3A2D: C3 00 04    ADDD  #$0004               // add 4 to bump to next animation frame's metadata (each metadata entry is 4 bytes long)
                        3A30: 10 83 40 6F CMPD  #$406F               // got to invalid frame? (meaning, past end of animation sequence)
                        3A34: 23 03       BLS   $3A39                // no
                        3A36: CC 40 63    LDD   #$4063               // reset blitter source to animation start image's metadata
                        3A39: ED 02       STD   $0002,X              // store animation frame metadata pointer
                        3A3B: BD D0 8D    JSR   $D08D                // JMP $DB2F - erase then re-blit object 
                        3A3E: 6C 61       INC   $0001,S
                        3A40: EE 02       LDU   $0002,X              // get animation frame metadata pointer                     
                        3A42: EC 04       LDD   $0004,X              // set D to current blitter destination
                        3A44: 34 10       PSHS  X                    // push grunt object pointer
                        3A46: 8E 98 23    LDX   #$9823               // pointer to linked list of electrodes (these kill grunts)
                        3A49: BD D0 27    JSR   $D027                // JMP $D7C9 - collision detection function
                        3A4C: 35 10       PULS  X                    // restore object pointer
                        3A4E: 27 0E       BEQ   $3A5E                // if zero flag set, no collision occurred, goto $3A5E
                        3A50: 10 AE 84    LDY   ,X                   // Y = next grunt in list
                        3A53: 8D 21       BSR   $3A76                // call grunt collision handler
                        3A55: 6A E4       DEC   ,S                   // decrement grunt count on stack
                        3A57: 27 0B       BEQ   $3A64                // if 0, we're done with grunts
                        3A59: 30 A4       LEAX  ,Y                   // X = Y. So now X is next grunt in list                        
                        3A5B: 7E 39 DB    JMP   $39DB                // process the grunt at X

                        3A5E: 6A E4       DEC   ,S                   // decrement grunt count on stack                    
                        3A60: 10 26 FF 75 LBNE  $39D9                // if !=0 then process grunt
                        3A64: EC E1       LDD   ,S++                 // restore A and B
                        3A66: 27 06       BEQ   $3A6E

                        3A68: CC 38 A0    LDD   #$38A0
                        3A6B: BD D0 4B    JSR   $D04B                // JMP $D3C7 - play sound with priority
                        3A6E: 86 04       LDA   #$04                 // delay before calling function
                        3A70: 8E 39 CD    LDX   #$39CD               // address of function to call
                        3A73: 7E D0 66    JMP   $D066                // JMP $D1E3 - allocate task



                        //
                        // X = grunt that was in a collision
                        //

                        GRUNT_COLLISION_HANDLER:
                        3A76: 96 48       LDA   $48                  // is it the player collision detection routine invoking this handler?
                        3A78: 26 2C       BNE   $3AA6                // yes, goto $3AA6
                        3A7A: BD 5B 43    JSR   $5B43                // JMP $5C1F - create an explosion
                        3A7D: 9C 8B       CPX   $8B                  // compare X to last grunt created pointer 
                        3A7F: 26 04       BNE   $3A85                // if != then goto $3A85
                        3A81: EC 84       LDD   ,X                   // get pointer to next object in object list (which must be a grunt)
                        3A83: DD 8B       STD   $8B                  // and store in $8B - the pointer to the grunt list             
                        3A85: BD D0 7E    JSR   $D07E                // JMP $D2C2 - remove baddy from baddies list
                        3A88: CC 01 10    LDD   #$0110        
                        3A8B: BD D0 0C    JSR   $D00C                // JMP $DB9C - update player score
                        3A8E: CC 38 98    LDD   #$3898               // pointer to data to use
                        3A91: BD D0 4B    JSR   $D04B                // JMP $D3C7 - play sound with priority
                        3A94: C6 E0       LDB   #$E0
                        3A96: B6 BE 5C    LDA   $BE5C                // read grunt speed control field.   
                        3A99: 3D          MUL   
                        3A9A: B1 BE 5D    CMPA  $BE5D                // compare to grunt movement delay minimum (the lower this value is, the faster the grunts can move)
                        3A9D: 25 03       BCS   $3AA2                // if A < grunt delay minimum, then A is invalid, the grunts delay is as low as it can be for the wave. Goto $3AA2
                        3A9F: B7 BE 5C    STA   $BE5C                // set grunt speed control field. This will increase the remaining grunts' speed as more die  
                        3AA2: 7A BE 68    DEC   cur_grunts           // reduce grunt count
                        3AA5: 39          RTS   

                        3AA6: 7E D0 18    JMP   $D018                // JMP   $DAF2 - do blit


                        //
                        //

                        ELECTRODE_COLLISION_HANDLER:
                        3AA9: 96 48       LDA   $48                  // was it the player that called this routine?
                        3AAB: 26 27       BNE   $3AD4                // yes, so do nothing, just exit
                        3AAD: BD D0 84    JSR   $D084                // JMP $D2CA: deallocate electrode object
                        3AB0: CC 00 00    LDD   #$0000
                        3AB3: ED 98 06    STD   [$06,X]
                        3AB6: BD D0 15    JSR   $D015                // JMP $DB03 - erase object from screen
                        3AB9: 7A BE 69    DEC   cur_electrodes       // decrement number of electrodes on screen
                        3ABC: DC 13       LDD   $13
                        3ABE: 27 13       BEQ   $3AD3
                        3AC0: 33 84       LEAU  ,X
                        3AC2: AE 84       LDX   ,X
                        3AC4: 9F 1B       STX   $1B
                        3AC6: BD D0 54    JSR   $D054                // JMP $D281 - reserve object metadata entry and call function
                        3AC9: 3A D9       // pointer to function
                        3ACB: EF 07       STU   $7,X
                        3ACD: CC 38 A5    LDD   #$38A5
                        3AD0: 7E D0 4B    JMP   $D04B
                        3AD3: 39          RTS   

                        3AD4: 96 90       LDA   $90
                        3AD6: 7E 38 88    JMP   $3888                // JMP   $3942

                        3AD9: AE 47       LDX   $0007,U              // X= pointer to electrode object 
                        3ADB: 10 AE 02    LDY   $0002,X              // Y = pointer to animation frame metadata
                        3ADE: 20 17       BRA   $3AF7                // would have been better going to 3AFA, it just stores same value as it read


                        //
                        // this code is called when an electrode dies
                        //

                        ELECTRODE_DEATH:
                        3AE0: AE 47       LDX   $0007,U              // get object pointer
                        3AE2: 10 AE 02    LDY   $0002,X              // load Y with animation frame metadata pointer
                        3AE5: 31 25       LEAY  $0005,Y              // Y = Y + 5
                        3AE7: A6 A4       LDA   ,Y                   // read next animation frame
                        3AE9: 26 0C       BNE   $3AF7                // if not zero (where 0 means "end of animation frame sequence") goto $3AF7, draw electrode dying

                        // OK, we've got an animation frame of zero, so end of death animation sequence, time to remove electrode
                        3AEB: BD D0 15    JSR   $D015                // JMP $DB03 - erase object from screen
                        3AEE: DC 1B       LDD   $1B
                        3AF0: ED 84       STD   ,X
                        3AF2: 9F 1B       STX   $1B
                        3AF4: 7E D0 63    JMP   $D063                // JMP $D1F3 - free object metadata and process next task

                        DRAW_ELECTRODE_DYING:
                        3AF7: 10 AF 02    STY   $0002,X              // update animation frame metadata pointer
                        3AFA: BD D0 8D    JSR   $D08D                // JMP $DB2F - erase then re-blit object 
                        3AFD: A6 24       LDA   $0004,Y              // get delay
                        3AFF: 8E 3A E0    LDX   #$3AE0               // address of function to call                      
                        3B02: 7E D0 66    JMP   $D066                // JMP $D1E3 - allocate task

//
// Colour tables used in pixel operations during brain wave warp in
// 

BRAIN_WAVE_WARP_COLOUR_TABLES:
// table 0
4148: 99 22 55 11 99 22 55 11 99 22 55 11 99 22 55 11 99 22 55 11 
// table 1
415C: AA CC AA CC AA CC AA CC AA CC AA CC AA CC AA CC AA CC AA CC 
// table 2
4170: 99 77 99 77 99 77 99 77 99 77 99 77 99 77 99 77 99 77 99 77 
// table 3
4184: 11 55 11 55 11 55 11 55 11 55 11 55 11 55 11 55 11 55 11 55 
// table 4
4198: FF EE DD CC BB AA FF EE DD CC BB AA FF EE DD CC BB AA FF EE 
// table 5
41AC: 11 66 77 BB AA 11 66 77 BB AA 11 66 77 BB AA 11 66 77 BB AA 
// table 6
41C0: 33 55 33 55 AA 33 55 33 55 AA 33 55 33 55 AA 33 55 33 55 AA 

// These are pointers to colour tables above 
BRAIN_WAVE_WARP_COLOUR_TABLE_LOOKUPS:
41D4: 41 48                                  // points to colour table @ 4148
41D6: 41 5C                                  // points to table @ 415C 
41D8: 41 70                                  // points to table @ 4170
41DA: 41 84                                  // you get the rest...
41DC: 41 98 
41DE: 41 AC 
41F0: 41 C0 
41F2: 41 98 

41E4: 20 43       BRA   $4229

41E6: OPYRIGHT 1982 WILLIAMS ELECTRONI
4206: CS INC. 





//
// Expects:
// Y = 
//
// Returns:
// Y = 
// $B3E4 = 
// 

4300: 34 10       PSHS  X
4302: AE A4       LDX   ,Y
4304: AF 9F B3 EB STX   [$B3EB,X]
4308: BE B3 E4    LDX   $B3E4
430B: AF A4       STX   ,Y
430D: 10 BF B3 E4 STY   $B3E4
4311: 10 BE B3 EB LDY   $B3EB
4315: 35 90       PULS  X,PC //(PUL? PC=RTS)


//
// Called from $45E4 - brain wave
//

DO_BRAIN_WAVE_BADDY_WARP_IN_EFFECT:
4317: 10 8E B3 E6 LDY   #$B3E6               // get pointer to last image processing buffer metadata in the list.
431B: 20 0C       BRA   $4329

431D: BD 42 89    JSR   $4289                // call GET_NEXT_PIXEL_OPERATION
4320: 11 83 43 BA CMPU  #$43BA               // have we reached the last pixel op?
4324: 27 0D       BEQ   $4333                // yes
// X = 
4326: BD 42 A2    JSR   $42A2                // perform the pixel operation on the image processing buffer
4329: 10 BF B3 EB STY   $B3EB                // store current image processing buffer metadata being processed
432D: 10 AE A4    LDY   ,Y                   // get pointer to next image processing buffer metadata 
4330: 26 EB       BNE   $431D                // if not NULL goto $431D
4332: 39          RTS   

4333: BD 43 00    JSR   $4300
4336: 20 F1       BRA   $4329




//
// This routine first creates a linked list of image processing buffer metadata objects. The metadata includes a pointer to an image processing buffer.
// An image processing buffer is simply pixel data used to enable per-pixel effects on the baddies during the "warp-in" phase of a brain wave.
// Why? you can't update the sprite pixel data because it is held in ROM, so what you need to do is create a copy of the pixel data in RAM,
// make modifications (such as the warp in pixel scrambling), and then blit it.
//
// Pseudocode:
//
// foreach(baddy in Grunts_Hulks_Brains_List)
// {
//     buffer = CreateImageProcessingBuffer()//
//     baddy.PreviousAnimationFrameData = baddy.AnimationFrameData//
//     baddy.AnimationFrameData = buffer.AnimationFrameData//
// }
// Call Blit_Grunts_Hulks_Brains_List()//
//

INIT_BRAIN_WAVE:
459B: BD 42 0E    JSR   $420E                // create linked list for image processing purposes at $B3ED
459E: 9E 21       LDX   $21                  // get pointer to linked list of grunts, hulks, brains
45A0: 27 52       BEQ   $45F4                // if NULL, goto $45F4. 
45A2: BD D0 54    JSR   $D054                // JMP $D281 - reserve object metadata entry and call function 
45A5: 46 07       // pointer to function  (play brain wave warp in sounds)
45A7: 9E 21       LDX   $21                  // get pointer to linked list of grunts, hulks, brains
45A9: CC 00 00    LDD   #$0000               // set D to NULL   
45AC: 10 8E 00 00 LDY   #$0000               // set Y to NULL  
45B0: 34 06       PSHS  B,A                  // push D on stack
45B2: 34 06       PSHS  B,A                  // push D on stack again
45B4: EC 02       LDD   $0002,X              // get current animation frame metadata pointer into D
45B6: ED 88 14    STD   $14,X                // set previous animation frame metadata pointer to D  
45B9: 31 21       LEAY  $0001,Y              // Y++              
45BB: 10 8C 00 0F CMPY  #$000F               // Y == 15 decimal?   
45BF: 22 05       BHI   $45C6                // if higher than 15 decimal, goto $45C6, which resets Y to 0                               
45C1: 10 A3 E4    CMPD  ,S                   // compare animation frame metadata pointer to whats on stack                                       
45C4: 27 11       BEQ   $45D7                // if it's the same as before, we have an image processing buffer ready made to use, goto $45D7
45C6: 10 8E 00 00 LDY   #$0000               // reset Y
45CA: ED E4       STD   ,S                   // set value on stack to be the animation frame metadata pointer held in D.
// when we get here, we need to get a buffer to do some image processing with.
45CC: 34 10       PSHS  X                    // save address of current grunt/ hulk/ brain being processed on stack
45CE: AE 02       LDX   $0002,X              // get current animation frame metadata pointer into X
45D0: BD 42 34    JSR   $4234                // reserve a spare image processing buffer for our use, and get a pointer to the animation frame metadata field it contains into X. 
 45D3: AF 64      STX   $0004,S              // store animation frame metadata pointer for image processing buffer to stack for temp storage
45D5: 35 10       PULS  X                    // restore address from @45CC

45D7: EC 62       LDD   $0002,S              // get pointer to image processing buffer metadata from temp stack storage (set at $45D3)
45D9: ED 02       STD   $0002,X              // set animation frame metadata pointer to field of buffer (a cheeky pixel buffer swap)
45DB: AE 84       LDX   ,X                   // get pointer to next object in list
45DD: 26 D5       BNE   $45B4                // if not NULL (meaning, end of list) goto $45B4
45DF: 32 64       LEAS  $0004,S              // discard temp items pushed on stack 
45E1: BD 46 39    JSR   $4639                // draw all grunts, hulks and brains
45E4: BD 43 17    JSR   $4317                // do the brain wave warp in effect
45E7: BE B3 E6    LDX   $B3E6
45EA: 27 08       BEQ   $45F4
45EC: 86 01       LDA   #$01                 // delay before calling function 
45EE: 8E 45 E1    LDX   #$45E1               // address of function to call
45F1: 7E D0 66    JMP   $D066                // JMP $D1E3 - allocate task   

45F4: 9E 21       LDX   $21                  // get pointer to linked list of grunts, hulks, brains
45F6: 27 09       BEQ   $4601
45F8: EC 88 14    LDD   $14,X                // get previous animation frame metadata pointer
45FB: ED 02       STD   $0002,X              // set current animation frame metadata pointer (now current = previous)
45FD: AE 84       LDX   ,X
45FF: 26 F7       BNE   $45F8
4601: BD F0 09    JSR   $F009                // clear explosion list
4604: 7E D0 63    JMP   $D063                // JMP $D1F3 - free object metadata and process next task


PLAY_BRAIN_WAVE_WARP_IN_SOUNDS:
4607: CC 41 43    LDD   #$4143               // address of sound data
460A: BD D0 4B    JSR   $D04B                // JMP $D3C7 - play sound with priority
460D: 86 48       LDA   #$48                 // countdown                  
460F: A7 47       STA   $0007,U
4611: C6 12       LDB   #$12                 // "warp in" sound index
4613: BD D0 06    JSR   $D006                // JMP $D3B6 - play sound in B.  
4616: 6A 47       DEC   $0007,U              // decrement countdown
4618: 27 08       BEQ   $4622                // if countdown == 0, goto $4622
461A: 86 01       LDA   #$01                 // delay
461C: 8E 46 11    LDX   #$4611               // address of function to call
461F: 7E D0 66    JMP   $D066                // JMP $D1E3 - allocate task

4622: 86 24       LDA   #$24                 // countdown
4624: A7 47       STA   $0007,U
4626: C6 12       LDB   #$12                 // "warp in" sound index
4628: BD D0 06    JSR   $D006                // JMP $D3B6 - play sound in B
462B: 6A 47       DEC   $0007,U              // decrement countdown
462D: 10 27 8A 32 LBEQ  $D063                // if countdown ==0, then JMP $D1F3 - free object metadata and process next task
4631: 86 02       LDA   #$02                 // delay
4633: 8E 46 26    LDX   #$4626               // address of function to call
4636: 7E D0 66    JMP   $D066                // JMP $D1E3 - allocate task


DRAW_GRUNTS_HULKS_BRAINS:
4639: 9E 21       LDX   $21                  // get pointer to linked list of grunts, hulks, brains
463B: 27 23       BEQ   $4660                // if NULL, nothing to process, goto $4660 (RTS)
463D: 10 AE 02    LDY   $0002,X              // get animation frame metadata pointer                 
4640: EC A4       LDD   ,Y                   // A = width in bytes, B = height                  
4642: 88 04       EORA  #$04                 // necessary to xor width and height for the blitter op
4644: C8 04       EORB  #$04
4646: 1A 10       ORCC  #$10                 // disable interrupts
4648: FD CA 06    STD   blitter_w_h         
464B: EE 22       LDU   $0002,Y              // get actual pixel data pointer into U
464D: FF CA 02    STU   blitter_source
4650: EC 04       LDD   $0004,X              // get current object's blit destination
4652: FD CA 04    STD   blitter_dest
4655: 86 06       LDA   #$06                 // sync with E clock (for blit from RAM to RAM)  
4657: B7 CA 00    STA   start_blitter
465A: 1C EF       ANDCC #$EF                 // clear interrupt flag
465C: AE 84       LDX   ,X                   // get next object in the list
465E: 26 DD       BNE   $463D                // if not null then process it
4660: 39          RTS   

4661: FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF 
4671: FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF 

4680: 7E 46 8C    JMP   $468C

4683: 7E 47 3F    JMP   $473F

4686: 7E 46 E6    JMP   $46E6

4689: 7E 4A 79    JMP   $4A79

468C: 34 30       PSHS  Y,X
468E: 8E BB E4    LDX   #$BBE4
4691: 9F C0       STX   $C0
4693: 31 88 33    LEAY  $33,X
4696: 10 AF 84    STY   ,X
4699: 10 8C BD E2 CMPY  #$BDE2
469D: 24 04       BCC   $46A3
469F: 30 A4       LEAX  ,Y
46A1: 20 F0       BRA   $4693

46A3: 10 8E 00 00 LDY   #$0000
46A7: 10 AF 84    STY   ,X
46AA: 10 9F BC    STY   $BC
46AD: 10 9F BE    STY   $BE
46B0: 35 B0       PULS  X,Y,PC //(PUL? PC=RTS)


//
//
// TODO: Another linked list
//

46B2: 34 20       PSHS  Y
46B4: DE C0       LDU   $C0
46B6: 27 12       BEQ   $46CA
46B8: 10 AE C4    LDY   ,U
46BB: 10 9F C0    STY   $C0
46BE: 10 9E BC    LDY   $BC
46C1: 10 AF C4    STY   ,U
46C4: DF BC       STU   $BC
46C6: 1C FE       ANDCC #$FE                // clear carry flag to indicate that this function succeeded
46C8: 35 A0       PULS  Y,PC //(PUL? PC=RTS)

46CA: 1A 01       ORCC  #$01                // set carry flag to indicate that this function failed
46CC: 35 A0       PULS  Y,PC //(PUL? PC=RTS)


//
//
// TODO: Another linked list
//

46CE: 34 20       PSHS  Y
46D0: DE C0       LDU   $C0
46D2: 27 F6       BEQ   $46CA
46D4: 10 AE C4    LDY   ,U
46D7: 10 9F C0    STY   $C0
46DA: 10 9E BE    LDY   $BE
46DD: 10 AF C4    STY   ,U
46E0: DF BE       STU   $BE
46E2: 1C FE       ANDCC #$FE                // clear carry flag
46E4: 35 A0       PULS  Y,PC //(PUL? PC=RTS)



//
// X = object
// Y = pointer to animation frame metadata
// $A7
//
//

46E6: 34 76       PSHS  U,Y,X,B,A
46E8: BD 46 CE    JSR   $46CE
46EB: 25 40       BCS   $472D
46ED: A7 C8 12    STA   $12,U
46F0: EC 04       LDD   $0004,X              // get object's blitter destination into D
46F2: AE 02       LDX   $0002,X              // get pointer to object's animation frame metadata into X
46F4: ED 4B       STD   $000B,U
46F6: A7 44       STA   $0004,U
46F8: D6 A7       LDB   $A7
46FA: E7 45       STB   $0005,U
46FC: E0 4C       SUBB  $000C,U
46FE: 25 04       BCS   $4704
4700: E1 01       CMPB  $0001,X
4702: 25 0B       BCS   $470F
4704: E6 84       LDB   ,X
4706: 54          LSRB  
4707: E7 46       STB   $0006,U
4709: EB 4C       ADDB  $000C,U
470B: E7 45       STB   $0005,U
470D: 20 02       BRA   $4711

470F: E7 46       STB   $0006,U
4711: EC 84       LDD   ,X
4713: ED 4D       STD   $000D,U
4715: C6 01       LDB   #$01
4717: E7 C8 11    STB   $11,U
471A: 88 04       EORA  #$04
471C: C8 04       EORB  #$04
471E: ED 4F       STD   $000F,U
4720: AE 02       LDX   $0002,X
4722: AF 42       STX   $0002,U
4724: CC 10 00    LDD   #$1000
4727: ED 48       STD   $0008,U
4729: 6F 47       CLR   $0007,U
472B: 8D 02       BSR   $472F
472D: 35 F6       PULS  A,B,X,Y,U,PC //(PUL? PC=RTS)


//
// U = pointer to ???
// 
//
//

472F: AE 42       LDX   $0002,U              // X = pointer to pixel data 
4731: E6 4D       LDB   $000D,U              // B = width of image
4733: A6 4E       LDA   $000E,U              // A = height of image (number of rows to proces)
4735: 33 C8 13    LEAU  $13,U                
4738: AF C1       STX   ,U++                 // store address of pixel row at U, then increment U by 2
473A: 3A          ABX                        // X += width of image. X now points to start of next pixel row in image   
473B: 4A          DECA                       // decrement row counter
473C: 26 FA       BNE   $4738                // if not zero, goto $4738 
473E: 39          RTS   


// 
//
// X = enemy to explode
// A = value determining the direction the enemy's top half must explode  ($FF = top half of explosion moves up and left, 0 = top half moves straight up, 1= top half of explosion moves up and right)
// B = value determining the direction the enemy's bottom half must explode ($FF = top half of explosion moves down and left, 0 = bottom half moves straight down, 1 = bottom half of explosion moves down and right)
//
// $88 = horizontal direction of player's laser ($FF = left, 0=no horizontal movement, 1 = right)
// $89 =vertical direction of players laser ($FF = up, 0=no vertical movement, 1 = down)
// $A6 = pointer to screen address where enemy and object that made it explode collided 


CREATE_DIRECTIONAL_EXPLOSION:
473F: 34 76       PSHS  U,Y,X,B,A
4741: BD 46 B2    JSR   $46B2                // get next available ??? for use
4744: 25 44       BCS   $478A                // if carry is set, function failed
4746: A7 C8 12    STA   $12,U
4749: EC 04       LDD   $0004,X              // D = blitter destination
474B: AE 02       LDX   $0002,X              // X = pointer to animation frame metadata
474D: ED 4B       STD   $000B,U              // save blitter destination 
474F: A7 44       STA   $0004,U              
4751: D6 A7       LDB   $A7
4753: E7 45       STB   $0005,U
4755: E0 4C       SUBB  $000C,U
4757: 25 04       BCS   $475D
4759: E1 01       CMPB  $0001,X              //  
475B: 25 0B       BCS   $4768                // if B < height, goto $4768
475D: E6 84       LDB   ,X                   // B = height 
475F: 54          LSRB                       // B /= 2
4760: E7 46       STB   $0006,U
4762: EB 4C       ADDB  $000C,U
4764: E7 45       STB   $0005,U
4766: 20 02       BRA   $476A

4768: E7 46       STB   $0006,U
476A: EC 84       LDD   ,X                    // A = width, B = height  
476C: ED 4D       STD   $000D,U
476E: E7 C8 11    STB   $11,U
4771: C6 01       LDB   #$01
4773: 88 04       EORA  #$04                   // xor width with 4
4775: C8 04       EORB  #$04                   // xor height with 4 (this must be precalculations for blitting)
4777: ED 4F       STD   $000F,U                //
4779: AE 02       LDX   $0002,X                // X = pointer to pixel data for animation frame
477B: AF 42       STX   $0002,U                
477D: CC 01 00    LDD   #$0100
4780: ED 48       STD   $0008,U
4782: 6F 47       CLR   $0007,U
4784: 86 10       LDA   #$10
4786: A7 4A       STA   $000A,U
4788: 8D A5       BSR   $472F                  // 
478A: 35 F6       PULS  A,B,X,Y,U,PC //(PUL? PC=RTS)



// Render an explosion with A segments.
// 
// Expects:
// Register A determines how many segments are drawn. A should be from 0 to 15.
// Outside this range is invalid, and the game may reset. This is the cause of the famous "shot in the corner" bug.
//
// Returns: the system will jump to location
// $478C + (Math.Abs(A) * (13 decimal))
// 
// Why is magic number 13 decimal used, and why can you only have 16 segments?
//
// OK, look at the code starting at 478C. This set of instructions is repeated *16* (decimal) times:
// 478C: AE A1       LDX   ,Y++
// 478E: BF CA 02    STX   blitter_source
// 4791: FD CA 04    STD   blitter_dest
// 4794: FF CA 00    STU   start_blitter
// 4797: D3 BA       ADDD  $BA
//
// How many bytes does this set of instructions take up? Answer: 13 (decimal).
//
// 

4A5C: A7 A8 11    STA   $11,Y
4A5F: 80 10       SUBA  #$10                 // A -= 16. This works nicely if A is 0..16. If not, game goes kaboom!        
4A61: 40          NEGA                       // A = (0 - A), giving negative A
4A62: C6 0D       LDB   #$0D                 // 13 decimal
4A64: 3D          MUL                        // Multiply A * B (meaning D = A * 13 decimal)
4A65: C3 47 8C    ADDD  #$478C               // D += 478C to give address to jump to in the explosion segment draw
4A68: 34 26       PSHS  Y,B,A                // push Y and return address (D) to stack
4A6A: CE 0A 0A    LDU   #$0A0A
4A6D: EC 2F       LDD   $000F,Y
4A6F: 1A 10       ORCC  #$10         
4A71: FD CA 06    STD   blitter_w_h         
4A74: EC 2B       LDD   $000B,Y              // set blitter destination
4A76: 31 84       LEAY  ,X
4A78: 39          RTS                        // pull return address off stack (this is what causes the crash at times)    

4A79: 10 9E BC    LDY   $BC
4A7C: 27 0B       BEQ   $4A89
4A7E: BD 48 E1    JSR   $48E1
4A81: BD 49 54    JSR   $4954
4A84: 10 AE A4    LDY   ,Y
4A87: 26 F5       BNE   $4A7E
4A89: 10 9E BE    LDY   $BE
4A8C: 27 08       BEQ   $4A96
4A8E: BD 49 27    JSR   $4927
4A91: 10 AE A4    LDY   ,Y
4A94: 26 F8       BNE   $4A8E
4A96: 39          RTS   

4A97: FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF 
4AA7: FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF 
4AB7: FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF 
4AC7: FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF 
4AD7: FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF 
4AE7: FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF 
4AF7: FF FF FF FF FF FF FF FF FF 

4B00: 7E 4D 10    JMP   $4D10

4B03: 7E 4B 36    JMP   $4B36

4B06: 50 C2 50 0E 50 26 D0 01 08 11 00 C8 01 08 04 00 
4B16: C8 01 04 14 01 01 13 00 D0 01 03 01 01 04 15 01 
4B26: 04 13 00 D0 01 04 15 01 08 11 00 D0 01 08 19 00 


// Tank shot sound info
4B0C: D0 01

// TODO: Tank shell related sound - see $4F8C
4B11: C8 01

// Tank shell bouncing off wall sound info
4B16: C8 01

// Tank shell shot by player sound info
4B1E: D0 01

// Quark Collision sound info
4B29: D0 01

// Tank spawn sound info
4B31: D0 01

INITIALISE_ALL_QUARKS:
4B36: B6 BE 70    LDA   cur_quarks          // get count of quarks into A
4B39: 34 02       PSHS  A                   // save count on stack
4B3B: 27 43       BEQ   $4B80               // if no quarks, exit
4B3D: BD D0 6C    JSR   $D06C               // JMP $D32B - create entity with params and add to linked list at $9817
// parameters to pass to $D06C 
4B40: 4B FB       // address of function to call after 1 game cycle
4B42: 50 C6       // animation frame metadata pointer
4B44: 4B C9       // address of routine to handle collision
4B46: 27 38       BEQ   $4B80               // if could not create object, RTS
4B48: C6 1A       LDB   #$1A                // initial Y coordinate of quark
4B4A: BD D0 39    JSR   $D039               // JMP $D6CD - get a random number into A
4B4D: 2A 02       BPL   $4B51               // if bit 7 of random number not set, goto $4B51
4B4F: C6 DC       LDB   #$DC                // set Y coordinate of quark to something else
4B51: 86 7E       LDA   #$7E                // 
4B53: BD D0 42    JSR   $D042               // JMP $D6AC - multiply A by a random number and put result in A
4B56: 8B 06       ADDA  #$06                // add 6 bytes (12 pixels to X coordinate)
4B58: ED 04       STD   $0004,X             // set blitter destination
4B5A: A7 0A       STA   $000A,X             // set quark X coordinate (whole part)
4B5C: E7 0C       STB   $000C,X             // set quark Y coordinate
4B5E: B6 BE 66    LDA   $BE66               // get "maximum delay before spawning tank" control value
4B61: BD D0 3F    JSR   $D03F               // JMP $D6B6 - get a random number lower than or equal to A
4B64: A7 49       STA   $0009,U             // set countdown before spawning first tank 
4B66: B6 BE 5E    LDA   $BE5E               // read tank spawn control variable
4B69: BD D0 3F    JSR   $D03F               // JMP $D6B6 - get a random number lower than or equal to A
4B6C: 44          LSRA                      // Divide by 2 (putting bit 0 into carry)
4B6D: 89 00       ADCA  #$00                // Ensure that value is non zero
4B6F: A7 4A       STA   $000A,U             // set number of tanks this quark can spawn
4B71: CC 50 D2    LDD   #$50D2              // pointer to collision detection animation frame metadata for quark (see $D7F4)
4B74: ED 88 16    STD   $16,X
4B77: 9F 17       STX   $17
4B79: BD 4B 82    JSR   $4B82               // set initial quark direction 
4B7C: 6A E4       DEC   ,S                  // decrement count of quarks on stack
4B7E: 26 BD       BNE   $4B3D
4B80: 35 82       PULS  A,PC //(PUL? PC=RTS)



CHANGE_QUARK_DIRECTION:
4B82: B6 BE 67    LDA   $BE67
4B85: BD D0 3F    JSR   $D03F               // JMP $D6B6 - get a random number lower than or equal to A
4B88: E6 0A       LDB   $000A,X             // get quark X coordinate (whole part)             
4B8A: C1 0C       CMPB  #$0C                // X coordinate <= #$0C (12 decimal)?
4B8C: 23 09       BLS   $4B97               // yes, goto $4b97 where the value in A will be used to compute a new delta for X axis
4B8E: C1 83       CMPB  #$83                // X coordinate >=#$83 (131 decimal)?
4B90: 24 04       BCC   $4B96               // yes, goto $4b97 where the value in A will be used to compute a new delta for X axis
4B92: D6 86       LDB   $86                 // OK, if this quark's not at the left or right playfield border, get another random number into B...
4B94: 2A 01       BPL   $4B97               // and if the random number now in B is positive then goto $4b97, otherwise... 
4B96: 40          NEGA                      // ... negate A, which will make the quark move to some other X coordinate entirely

// compute delta to keep adding to X coordinate 
// A = (I suspect) the destination X coordinate

4B97: 1F 89       TFR   A,B
4B99: 1D          SEX   
4B9A: 58          ASLB  
4B9B: 49          ROLA  
4B9C: 58          ASLB  
4B9D: 49          ROLA  
4B9E: ED 0E       STD   $000E,X             // set X delta
4BA0: B6 BE 67    LDA   $BE67
4BA3: BD D0 3F    JSR   $D03F               // JMP $D6B6 - get a random number lower than or equal to A
4BA6: E6 0C       LDB   $000C,X             // get quark Y coordinate
4BA8: C1 1D       CMPB  #$1D                // Y coordinate <= $#1D (29 decimal)?
4BAA: 23 09       BLS   $4BB5               // yes, goto $4bb5 where the value in A will be used to compute a new delta for Y axis
4BAC: C1 D6       CMPB  #$D6                // Y coordinate >= $D6 (230 decimal) ?
4BAE: 24 04       BCC   $4BB4               // yes, goto $4bb5 where the value in A will be used to compute a new delta for Y axis
4BB0: D6 85       LDB   $85                 // OK, if this quark's not at the left or right playfield border, get another random number into B...
4BB2: 2B 01       BMI   $4BB5               // and if the random number now in B is negative then goto $4bb5, otherwise...  
4BB4: 40          NEGA                      // ... negate A, which will make the quark move to some other Y coordinate entirely  

// compute delta to keep adding to Y coordinate
// A = (I suspect) the destination Y coordinate
4BB5: 1F 89       TFR   A,B
4BB7: 1D          SEX   
4BB8: 58          ASLB  
4BB9: 49          ROLA  
4BBA: 58          ASLB  
4BBB: 49          ROLA  
4BBC: 58          ASLB  
4BBD: 49          ROLA  
4BBE: ED 88 10    STD   $10,X               // set Y delta
4BC1: 96 84       LDA   $84                 // read a random number
4BC3: 84 1F       ANDA  #$1F                // Make number from 0..31 decimal 
4BC5: 4C          INCA                      // Add 1 to ensure value is nonzero
4BC6: A7 4E       STA   $000E,U             // set countdown before quark picks new direction to move in
4BC8: 39          RTS   


QUARK_COLLISION_HANDLER:
4BC9: 96 48       LDA   $48                 // has player been hit?
4BCB: 26 2D       BNE   $4BFA               // if yes, goto $4BFA
4BCD: BD D0 78    JSR   $D078               // JMP $D320 - deallocate object, and its metadata, and erase object from screen
4BD0: DE 1B       LDU   $1B
4BD2: EC C4       LDD   ,U
4BD4: DD 1B       STD   $1B
4BD6: BD D0 54    JSR   $D054               // JMP $D281 - reserve object metadata entry and call function
4BD9: 11 43       // pointer to function
4BDB: EF 07       STU   $0007,X
4BDD: CC 50 C6    LDD   #$50C6              // quark animation metadata
4BE0: ED 42       STD   $0002,U
4BE2: CC DD DD    LDD   #$DDDD
4BE5: ED 0B       STD   $000B,X
4BE7: 86 08       LDA   #$08
4BE9: A7 0D       STA   $000D,X
4BEB: CC 4B 29    LDD   #$4B29
4BEE: BD D0 4B    JSR   $D04B                // JMP $D3C7 - play sound with priority
4BF1: CC 02 10    LDD   #$0210
4BF4: BD D0 0C    JSR   $D00C                // JMP $DB9C - update player score
4BF7: 7A BE 70    DEC   cur_quarks
4BFA: 39          RTS   


ANIMATE_QUARK:
4BFB: AE 47       LDX   $0007,U              // get pointer to quark object
4BFD: EC 02       LDD   $0002,X              // get pointer to animation frame metadata into D
4BFF: C3 00 04    ADDD  #$0004               // bump D to pointer to next animation frame metadata 
4C02: 10 83 50 D2 CMPD  #$50D2               // hit end of animation frame metadata for quark?
4C06: 23 0B       BLS   $4C13                // no
4C08: CC 50 C2    LDD   #$50C2               // back to first image of quark
4C0B: 0D 59       TST   $59
4C0D: 26 04       BNE   $4C13
4C0F: 6A 49       DEC   $0009,U              // decrement tank spawn countdown
4C11: 27 11       BEQ   $4C24                // if 0, goto $4C24, it 
4C13: ED 02       STD   $0002,X              // set pointer to animation frame metadata
4C15: 6A 4E       DEC   $000E,U              // decrement countdown before quark picks new direction to move in
4C17: 26 03       BNE   $4C1C                // if countdown not hit 0, no direction change, goto $4C1C 
4C19: BD 4B 82    JSR   $4B82                // otherwise, pick a new direction for quark to move in
4C1C: 86 03       LDA   #$03                 // delay before calling function
4C1E: 8E 4B FB    LDX   #$4BFB               // pointer to animate quark routine to call
4C21: 7E D0 66    JMP   $D066                // JMP $D1E3 - allocate task


SET_TANK_SPAWN_COUNTDOWN:
4C24: B6 BE 66    LDA   $BE66                // 
4C27: 44          LSRA  
4C28: 4C          INCA  
4C29: BD D0 3F    JSR   $D03F                // JMP $D6B6 - get a random number lower than or equal to A
4C2C: A7 49       STA   $0009,U

4C2E: AE 47       LDX   $0007,U              // get object pointer into X
4C30: 6A 49       DEC   $0009,U              // decrement tank spawn countdown  
4C32: 26 1C       BNE   $4C50            
4C34: 96 42       LDA   $42
4C36: 81 11       CMPA  #$11
4C38: 24 EA       BCC   $4C24
4C3A: 96 13       LDA   $13                  // this piece of code determines if we have any free objects we can use ..
4C3C: 9A 1B       ORA   $1B                  // ... to hold a new tank
4C3E: 27 E4       BEQ   $4C24                // if not, goto $4C24, we'll wait for a free object to become available (e.g.: something dies)
4C40: B6 BE 71    LDA   cur_tanks   
4C43: 81 14       CMPA  #$14                 // compare number of tanks to #$14  (20 decimal)
4C45: 24 DD       BCC   $4C24                // if we've got >= 20 tanks, go to $4C24 
4C47: BD 4C AC    JSR   $4CAC                // spawn a tank!
4C4A: 6A 4A       DEC   $000A,U              // decrement counter of tanks left to spawn             
4C4C: 27 21       BEQ   $4C6F 
4C4E: 20 D4       BRA   $4C24

4C50: EC 02       LDD   $0002,X             // get pointer to animation frame metadata
4C52: C3 00 04    ADDD  #$0004              // bump to next image
4C55: 10 83 50 E2 CMPD  #$50E2              // hit end of animation frame metadata list for tank?
4C59: 23 03       BLS   $4C5E               // if not, go to $4C5E
4C5B: CC 50 C2    LDD   #$50C2              // reset animation frame metadata pointer to start of animation frame metadata list
4C5E: ED 02       STD   $0002,X             // set animation frame metadata pointer
4C60: 6A 4E       DEC   $000E,U             
4C62: 26 03       BNE   $4C67
4C64: BD 4B 82    JSR   $4B82               // change quark direction
4C67: 86 03       LDA   #$03                // delay before calling function
4C69: 8E 4C 2E    LDX   #$4C2E              // address of function to call
4C6C: 7E D0 66    JMP   $D066               // JMP $D1E3 - allocate task

4C6F: CC 00 00    LDD   #$0000
4C72: ED 0E       STD   $000E,X             // set X delta
4C74: CC 02 00    LDD   #$0200
4C77: 0D 84       TST   $84
4C79: 2A 01       BPL   $4C7C
4C7B: 40          NEGA  
4C7C: ED 88 10    STD   $10,X                // set Y delta

//
// the Quark's dropped all its tanks, it now wants to get off screen....
//

MAKE_QUARK_VAMOOSE:
4C7F: AE 47       LDX   $0007,U             // get object pointer             
4C81: EC 02       LDD   $0002,X             // get animation frame metadata pointer into D
4C83: 83 00 04    SUBD  #$0004              // D -= 4 (point D to previous animation frame metadata)
4C86: 10 83 50 C2 CMPD  #$50C2              // beyond start of animation frame metadata list?
4C8A: 24 0D       BCC   $4C99               // no
4C8C: A6 0C       LDA   $000C,X             // read object Y coordinate           
4C8E: 81 1A       CMPA  #$1A                // <= #$1A (26 decimal) ?
4C90: 23 11       BLS   $4CA3               // yes, so remove this object from playfield 
4C92: 81 DA       CMPA  #$DA                // >#$DA (218 decimal) ? 
4C94: 24 0D       BCC   $4CA3               // yes, so remove this object from playfield
4C96: CC 50 E2    LDD   #$50E2              // load D with address of quark animation frame metadata
4C99: ED 02       STD   $0002,X             // set animation frame metadata pointer
4C9B: 86 03       LDA   #$03                // delay before calling function
4C9D: 8E 4C 7F    LDX   #$4C7F              // function to call next (this one!)
4CA0: 7E D0 66    JMP   $D066               // JMP $D1E3 - allocate task

4CA3: BD D0 75    JSR   $D075               // JMP $D31B - deallocate object and erase object from screen 
4CA6: 7A BE 70    DEC   cur_quarks
4CA9: 7E D0 63    JMP   $D063               // JMP $D1F3 - free object metadata and process next task



//
// Spawn a tank.
//
// X = pointer to quark giving birth
//

SPAWN_TANK:
4CAC: 34 76       PSHS  U,Y,X,B,A
4CAE: 31 84       LEAY  ,X                  // Y = X
4CB0: BD D0 54    JSR   $D054               // JMP $D281 - reserve object metadata entry and call function
4CB3: 4D 83       // values to pass to the function 
4CB5: 33 84       LEAU  ,X                  // U = X
4CB7: BD D0 7B    JSR   $D07B               // JMP $D2DA - reserve entry in list used by grunts, hulks, brains, progs, cruise missiles and tanks (starts at $9821)
// X = pointer to object
4CBA: 7C BE 71    INC   cur_tanks           // increment number of tanks on screen counter
4CBD: CC 50 0E    LDD   #$500E              // $500E - pointer to animation frame metadata
4CC0: ED 02       STD   $0002,X             // set current animation frame metadata pointer
4CC2: ED 88 14    STD   $14,X               // set previous animation frame metadata pointer (previous = current)
4CC5: EF 06       STU   $0006,X             // set pointer to object metadata
4CC7: AF 47       STX   $0007,U             // set back-pointer to object, from object metadata
4CC9: CC 4D F2    LDD   #$4DF2              // store pointer to routine that handles tank collision
4CCC: ED 08       STD   $0008,X
4CCE: CC 4B 31    LDD   #$4B31
4CD1: BD D0 4B    JSR   $D04B               // JMP $D3C7 - play sound with priority 
4CD4: EC 24       LDD   $0004,Y             // D = blitter destination of quark
4CD6: C1 18       CMPB  #$18                // compare vertical position of quark to #$18 (24 decimal) 
4CD8: 27 01       BEQ   $4CDB
4CDA: 5A          DECB  
4CDB: C3 02 06    ADDD  #$0206              // birth place of tank = 4 pixels from left of quark, 6 pixels from top
4CDE: ED 04       STD   $0004,X             // set blitter destination
4CE0: A7 0A       STA   $000A,X             // set X coordinate (whole part)
4CE2: E7 0C       STB   $000C,X             // set Y coordinate
4CE4: BD 4E 11    JSR   $4E11               // pick a destination for tank to move to
4CE7: B6 BE 64    LDA   $BE64               // read "tank fire delay"   
4CEA: A7 4D       STA   $000D,U
4CEC: BD D0 18    JSR   $D018               // JMP   $DAF2 - do blit
4CEF: 35 F6       PULS  A,B,X,Y,U,PC //(PUL? PC=RTS)

4CF1:  (C) WILLIAMS ELECTRONICS INC. 


//
//
//
//

INITIALISE_ALL_TANKS:
4D10: B6 BE 71    LDA   cur_tanks           // get count of tanks for this wave into A            
4D13: 34 02       PSHS  A                
4D15: 27 4A       BEQ   $4D61               // if count ==0, no tanks on this wave, goto $4D61 (RTS)
4D17: BD D0 54    JSR   $D054               // JMP $D281 - reserve object metadata entry and call function
4D1A: 4D 8B       // data to pass to function (looks like an address to call)
4D1C: 8B 33       LEAU, X
4D1E: 84 BD       JSR   $D07B               // JMP $D2DA - reserve entry in list used by grunts, hulks, brains, progs, cruise missiles and tanks (starts at $9821)
4D21: CC 50 26    LDD   #$5026
4D24: ED 02       STD   $0002,X             // set current animation frame metadata pointer
4D26: ED 88 14    STD   $14,X               // set previous animation frame metadata pointer (previous = current)
4D29: EF 06       STU   $0006,X             // set pointer to object metadata to U
4D2B: AF 47       STX   $0007,U             // set pointer to this object in object metadata  
4D2D: CC 4D F2    LDD   #$4DF2              // address of tank collision handler routine 
4D30: ED 08       STD   $0008,X
4D32: BD 38 8E    JSR   $388E               // JMP $38FE -compute safe rectangle for player
4D35: BD 26 C3    JSR   $26C3               // JMP $3199 - get random position on playfield for object (returns: A = X coordinate, B = Y coordinate)
// determine if the computed position is valid (meaning, not in the player's safe area)
4D38: D1 2B       CMPB  $2B
4D3A: 23 0C       BLS   $4D48
4D3C: D1 2C       CMPB  $2C
4D3E: 24 08       BCC   $4D48
4D40: 91 2D       CMPA  $2D
4D42: 23 04       BLS   $4D48
4D44: 91 2E       CMPA  $2E
4D46: 23 ED       BLS   $4D35               // position is invalid, get another one
4D48: ED 04       STD   $0004,X             // set blitter destination of object
4D4A: A7 0A       STA   $000A,X             // set X coordinate (whole part) of tank
4D4C: E7 0C       STB   $000C,X             // set Y coordinate of tank
4D4E: BD 4E 11    JSR   $4E11               // pick initial direction for tank to move
4D51: 96 84       LDA   $84                 // get a random number into A
4D53: 84 1F       ANDA  #$1F                // mask off lower 5 bits giving a number from 0..31                
4D55: BB BE 64    ADDA  $BE64               // add on "tank fire delay variable" to set countdown before firing.       
4D58: A7 4D       STA   $000D,U             // set countdown before firing first shell
4D5A: BD 38 8B    JSR   $388B               // JMP $393C - blit tank in solid colour invisible to player
4D5D: 6A E4       DEC   ,S                  // decrement count of tanks left to do on the stack
4D5F: 26 B6       BNE   $4D17               // if !=0, goto $4D17  
4D61: 35 82       PULS  A,PC //(PUL? PC=RTS)


//
// TODO: Find out why this is doing some animation. Is this demo related code??
//

4D63: AE 47       LDX   $0007,U             // get pointer to object into X
4D65: BD D0 15    JSR   $D015               // JMP $DB03 - erase object from screen
4D68: EC 04       LDD   $0004,X             // get blitter destination into D
4D6A: 10 AE 02    LDY   $0002,X             // Y = pointer to animation frame metadata
4D6D: AB 24       ADDA  $0004,Y
4D6F: EB 25       ADDB  $0005,Y
4D71: A7 0A       STA   $000A,X             // set tank X coordinate MSB
4D73: E7 0C       STB   $000C,X             // set tank Y coordinate MSB
4D75: 31 26       LEAY  $0006,Y             // Y+= 6
4D77: 10 AF 02    STY   $0002,X
4D7A: BD D0 18    JSR   $D018               // JMP   $DAF2 - do blit
4D7D: 10 8C 50 26 CMPY  #$5026
4D81: 24 08       BCC   $4D8B
4D83: 86 0C       LDA   #$0C                // delay before calling function
4D85: 8E 4D 63    LDX   #$4D63              // address of function to call
4D88: 7E D0 66    JMP   $D066               // JMP $D1E3 - allocate task



// Spawned by $4D17

WAIT_FOR_PERMISSION_TO_MOVE_TANK:
4D8B: 96 59       LDA   $59                 // read a game control flag
4D8D: 85 7F       BITA  #$7F                // if no bits from 0..6 are set..
4D8F: 27 08       BEQ   $4D99               // then you can animate the tank!
4D91: 86 0F       LDA   #$0F                // otherwise, wait. delay before calling function
4D93: 8E 4D 8B    LDX   #$4D8B              // address of function to call
4D96: 7E D0 66    JMP   $D066               // JMP $D1E3 - allocate task


ANIMATE_TANK:
4D99: AE 47       LDX   $0007,U             // get object pointer in X
4D9B: 6A 4D       DEC   $000D,U             // decrement tank fire countdown
4D9D: 26 03       BNE   $4DA2               // if countdown !=0 goto $4DA2  
4D9F: BD 4E 46    JSR   $4E46               // if countdown is 0 then fire a tank shell 
4DA2: A6 4B       LDA   $000B,U             // get horizontal delta of tank
4DA4: 5F          CLRB  
4DA5: 47          ASRA  
4DA6: 56          RORB  
4DA7: E3 0A       ADDD  $000A,X             // add delta to X coordinate of tank
4DA9: 34 06       PSHS  B,A                 // save result of addition in D on stack
4DAB: E6 4C       LDB   $000C,U             // get vertical delta of tank
4DAD: EB 0C       ADDB  $000C,X             // add delta to vertical position of tank
4DAF: BD 00 06    JSR   $0006               // test that object is in bounds
4DB2: 27 04       BEQ   $4DB8               // yes tank is in bounds, goto $4DB8
4DB4: 32 62       LEAS  $0002,S             // discard items pushed on stack @ 4DA9
4DB6: 20 2F       BRA   $4DE7                
4DB8: E7 0C       STB   $000C,X             // update vertical position of tank         
4DBA: 35 06       PULS  A,B                 // restore new X coordinate of tank from stack
4DBC: ED 0A       STD   $000A,X             // update X coordinate of tank
//
// This piece of code specifies how the tank is animated. If the tank is moving to the LEFT, the tank animation runs "backwards",
// but if the tank is moving in any other direction the animation runs "forwards".
// I never noticed this in the game before....
//
4DBE: EC 02       LDD   $0002,X             // read current animation frame metadata pointer
4DC0: 6D 4B       TST   $000B,U             // is the tank moving to the right (or, put another way, just not moving left) ?             
4DC2: 2A 0E       BPL   $4DD2               // yes, goto $4DD2
// make tank animation play "backwards"
4DC4: 83 00 04    SUBD  #$0004              // bump animation frame metadata pointer to previous animation (making tank animation go *backwards*) 
4DC7: 10 83 50 26 CMPD  #$5026              // have we gone past the start animation frame?
4DCB: 24 11       BCC   $4DDE               // no, goto $4DDE
4DCD: CC 50 32    LDD   #$5032              // yes, so set pointer to last tank animation 
4DD0: 20 0C       BRA   $4DDE

// make tank animation play "forward"
4DD2: C3 00 04    ADDD  #$0004              // bump to next animation frame metadata in list for tank
4DD5: 10 83 50 32 CMPD  #$5032              // gone past last animation frame metadata in list?
4DD9: 23 03       BLS   $4DDE               // no, goto $4DDE
4DDB: CC 50 26    LDD   #$5026              // yes, reset to first animation frame metadata for tank

4DDE: ED 02       STD   $0002,X             // set animation frame metadata pointer
4DE0: BD D0 8D    JSR   $D08D               // JMP $DB2F - erase then re-blit object 
4DE3: 6A 4E       DEC   $000E,U             // decrement "tank move" countdown
4DE5: 26 03       BNE   $4DEA               // if !=0, not time to change direction, goto $4DEA
4DE7: BD 4E 11    JSR   $4E11               // otherwise, countdown hit 0, find a new direction for the tank to move in
4DEA: 96 EF       LDA   $EF                 // delay before calling function
4DEC: 8E 4D 99    LDX   #$4D99              // address of function to call
4DEF: 7E D0 66    JMP   $D066               // JMP $D1E3 - allocate task


// 
TANK_COLLISION_HANDLER:
4DF2: 96 48       LDA   $48                 // player collision detection?
4DF4: 26 1A       BNE   $4E10               // yes
4DF6: 7A BE 71    DEC   cur_tanks
4DF9: BD 5B 4F    JSR   $5B4F               // JMP $5C0A
4DFC: BD D0 7E    JSR   $D07E               // JMP $D2C2 - remove baddy from baddies list
4DFF: AE 06       LDX   $0006,X             // get pointer to object metadata into X
4E01: BD D0 5D    JSR   $D05D               // JMP $D218 - deallocate object metadata entry
4E04: CC 01 20    LDD   #$0120
4E07: BD D0 0C    JSR   $D00C               // JMP $DB9C - update player score
4E0A: CC 4B 0C    LDD   #$4B0C
4E0D: BD D0 4B    JSR   $D04B               // JMP $D3C7 - play sound with priority
4E10: 39          RTS   



//
// Tank needs to move somewhere.
// Depending on a random number, the tank either moves towards a random position on the screen
// OR gravitates towards the player.
//

PICK_DESTINATION_TO_MOVE_TANK_TO:
4E11: 96 84       LDA   $84                 // get a random number into A                 
4E13: 81 60       CMPA  #$60                // compare to #$60 (96 decimal)
4E15: 23 05       BLS   $4E1C               // if lower or the same goto $4E1C - gravitate towards player 
4E17: BD 26 C3    JSR   $26C3               // JMP $3199 - get random position on playfield for object (returns: A = X coordinate, B = Y coordinate)
4E1A: 20 02       BRA   $4E1E               // and skip over the next line...

4E1C: DC 5E       LDD   $5E                 // read player's blitter destination

4E1E: DD 2B       STD   $2B                 
// what this piece of code does is check to see if the screen destination in $2B
// is 16 pixels above or below the tank. If it's less than 16 pixels, the B register is cleared to indicate "no vertical movement"
4E20: E0 05       SUBB  $0005,X             // B = B - low byte of tank blitter destination (vertical component) 
4E22: 24 01       BCC   $4E25               // if the subtraction didn't cause a carry, goto $4E25
4E24: 50          NEGB                      // OK, the subtraction caused a carry and the result is negative. NEGB will make the result positive again.
4E25: C1 10       CMPB  #$10                // is the vertical distance between the tank and the destination #$10 (16 decimal) ?
4E27: 24 03       BCC   $4E2C               // it's more than 16 pixels, goto $4E2C
4E29: 5F          CLRB                      // ok, distance is 16 pixels or less, clear the B register (see $4E3C comments) to make tank move horizontally only                          
4E2A: 20 09       BRA   $4E35               // and skip over the lines which determine whether to move tank up or down (as we're not moving vertically)    

4E2C: DC 2B       LDD   $2B                 // get screen destination where tank wants move into A & B (A=horizontal part, B = vertical part)
4E2E: E1 05       CMPB  $0005,X             // compare vertical part of screen destination with tank's current vertical position  
4E30: C6 01       LDB   #$01                // when B = 1, tank will move down 
4E32: 24 01       BCC   $4E35               // if vertical pos of screen destination > tank's current vertical position goto $4E35    
4E34: 50          NEGB                      // B = #$FF, tank will move up  

4E35: A1 04       CMPA  $0004,X             // compare horizontal pos of screen destination with tank's current X coordinate
4E37: 86 01       LDA   #$01                // when A = 1, tank will move right
4E39: 24 01       BCC   $4E3C               // if horizontal pos of screen destination > tank's current X coordinate goto $4E35
4E3B: 40          NEGA                      // move tank left  
//
// At this point: A = horizontal direction of tank ($FF = left, 0 = no horizontal movement, 1=right)
// B = vertical direction of tank ($FF = up, 0 = no vertical movement, 1= down)
// 
4E3C: ED 4B       STD   $000B,U              // $000B = horizontal direction, $000C = vertical direction
4E3E: 96 84       LDA   $84                  // read a random number
4E40: 84 1F       ANDA  #$1F                 // mask in bits 0..4, giving us a number from 0..31 
4E42: 4C          INCA                       // ensure number is nonzero
4E43: A7 4E       STA   $000E,U              // set "move tank" countdown (see $4DE3)
4E45: 39          RTS   



//
// X = pointer to tank
//
CREATE_TANK_SHELL:
4E46: 34 50       PSHS  U,X
4E48: 31 84       LEAY  ,X                   // Y = pointer to tank
4E4A: B6 BE 64    LDA   $BE64
4E4D: A7 4D       STA   $000D,U              // reset countdown for tank to shell
4E4F: 96 42       LDA   $42
4E51: 81 11       CMPA  #$11
4E53: 10 24 01 3B LBCC  $4F92                // just an RTS
4E57: 96 F1       LDA   $F1                  // read count of tank shells on screen   
4E59: 81 14       CMPA  #$14                 // compare to #$14 (20 decimal)
4E5B: 10 22 01 33 LBHI  $4F92                // if higher than 20 decimal, goto $4F92 (exits function)          
4E5F: 0C F1       INC   $F1                  // increment count of tank shells on screen
4E61: BD D0 6C    JSR   $D06C                // JMP $D32B - create entity with params and add to linked list at $9817
4E64: 4F 94       // parameters to pass to $D06C - function to call on next game cycle           
4E66: 4F EE       // parameters to pass to $D06C - animation frame metadata pointer for tank shell
4E68: 4F D5       // parameters to pass to $D06C - function to call when this object has a collision
4E6A: 10 27 01 24 LBEQ  $4F92                // if the zero flag is set, then can't create shell, goto $4F92 (RTS)
4E6E: EC 24       LDD   $4,Y                 // get blitter destination of tank                  
4E70: C3 01 00    ADDD  #$0100               // add 256 to it, making result 2 pixels to right of previous 
4E73: A7 0A       STA   $A,X                 // set X coordinate of shell
4E75: E7 0C       STB   $C,X                 // set Y coordinate of shell
4E77: ED 04       STD   $4,X                 // set blitter destination of shell
// We now need to set the direction vector for the shell to follow..
4E79: C6 80       LDB   #$80                 // load B with 128 decimal...          
4E7B: D1 84       CMPB  $84                  // compare B to a random number                      
4E7D: 23 55       BLS   $4ED4                // if B <= the random number then goto $4ED4                
4E7F: D6 86       LDB   $86                  // read another random number
4E81: C4 1F       ANDB  #$1F                 // mask in bits 0..5, giving a number from 0..31 decimal
4E83: CB F0       ADDB  #$F0                 // add -16 decimal to the number. Now B is, as a signed byte, in range of -16 .. 15 decimal
4E85: 96 5E       LDA   $5E                  // read player blitter destination hi byte (X component) 
4E87: 81 11       CMPA  #$11                 // how close is the player to the left hand border wall?                  
4E89: 24 01       BCC   $4E8C                // if X component is > #$11 (17 decimal) then not too close to the wall, goto $4E8C
4E8B: 5F          CLRB                       // otherwise, the player is close to the left wall, clear B   
4E8C: DB 5E       ADDB  $5E                  // B+= player blitter destination hi byte (X component)
4E8E: 4F          CLRA  
4E8F: E0 04       SUBB  $4,X                 // B -= tank shell blitter destination hi byte (X component)
4E91: 82 00       SBCA  #$00                 // if a carry occurred, A will be made #$FF (-1 decimal). This is a flag to indicate B needs to be negated.
4E93: 34 02       PSHS  A                                       
4E95: 2A 01       BPL   $4E98                // if A is not #$FF, goto $4E98
4E97: 50          NEGB                       // B = NEG(B)  
4E98: B6 BE 65    LDA   $BE65                // read tank shell accuracy setting                
4E9B: 3D          MUL   
4E9C: 1F 89       TFR   A,B
4E9E: A6 E0       LDA   ,S+                  // restore flag from stack (see $4E93). A is either #$FF or 0.
4EA0: 2A 01       BPL   $4EA3                // if A is not #$FF, and thus not a negative value, goto $4EA3
4EA2: 53          COMB                       // flip bits in B.                         
4EA3: 58          ASLB                       // move bit 7 of b into carry, and shift remaining bits to left   
4EA4: 49          ROLA                       // move carry into bit 0 of A, and rotate remaining bits left  
4EA5: 58          ASLB                       // move bit 7 of b into carry, and shift remaining bits to left  
4EA6: 49          ROLA                       // move carry into bit 0 of A, and rotate remaining bits left
4EA7: 58          ASLB                       // move bit 7 of b into carry, and shift remaining bits to left
4EA8: 49          ROLA                       // move carry into bit 0 of A, and rotate remaining bits left  
4EA9: ED 0E       STD   $000E,X              // set X delta of tank shell
// now do the vertical delta of the tank shell
4EAB: D6 86       LDB   $86                  // read another random number
4EAD: C4 1F       ANDB  #$1F                 // mask in bits 0..5, giving a number from 0..31  
4EAF: CB F0       ADDB  #$F0                 // add -16 decimal to the number. Now B is, as a signed byte, in range of -16 .. 15 decimal
4EB1: DB 5F       ADDB  $5F                  // B+= player blitter destination lo byte (Y component)  
4EB3: 4F          CLRA  
4EB4: E0 05       SUBB  $0005,X              // B -= tank shell blitter destination lo byte (Y component)
4EB6: 82 00       SBCA  #$00                 // if a carry occurred, A will be made #$FF (-1 decimal). This is a flag to indicate B needs to be negated.
// At this point, B is the vertical distance between the shell's current Y coordinate and where the Y coordinate of where shell has been aimed at (an area near the player)
// a negative value in B states the shell's target is above, a positive value in B states the shell's target is below.
4EB8: 34 02       PSHS  A
4EBA: 2A 01       BPL   $4EBD                // if A is not #$FF, goto $4EBD
4EBC: 50          NEGB                       // B = -B
4EBD: B6 BE 65    LDA   $BE65                // read tank shell accuracy setting
4EC0: 3D          MUL   
4EC1: 1F 89       TFR   A,B
4EC3: A6 E0       LDA   ,S+                  // restore flag from stack (see $4EB8). A is either #$FF or 0.                
4EC5: 2A 01       BPL   $4EC8
4EC7: 53          COMB                       // flip bits in B  
4EC8: 58          ASLB                       // move bit 7 of b into carry, and shift remaining bits to left// next 4 instructions move   
4EC9: 49          ROLA                       // move carry into bit 0 of A, and rotate remaining bits left  
4ECA: 58          ASLB                       // move bit 7 of b into carry, and shift remaining bits to left
4ECB: 49          ROLA                       // move carry into bit 0 of A, and rotate remaining bits left
4ECC: 58          ASLB                       // move bit 7 of b into carry, and shift remaining bits to left
4ECD: 49          ROLA                       // move carry into bit 0 of A, and rotate remaining bits left  
4ECE: ED 88 10    STD   $10,X                // set Y delta of tank shell
4ED1: 7E 4F 82    JMP   $4F82

// Called from $4E7D
//
//
// X = pointer to newly created tank shell
//
4ED4: BD D0 39    JSR   $D039                // JMP $D6CD - get a random number into A
4ED7: 44          LSRA                       // move bit 0 into carry  
4ED8: 25 29       BCS   $4F03                // if carry is now set from LSRA, goto $4F03                
4EDA: 4F          CLRA  
4EDB: D6 84       LDB   $84                  // get a random number                  
4EDD: C4 1F       ANDB  #$1F                 // ensure number in range of 0..31 decimal
4EDF: CB F0       ADDB  #$F0                 // add -16 decimal, to make number in range of -16 to 15 decimal
4EE1: EB 05       ADDB  $0005,X              // B+= tank shell blitter destination lo byte (Y component) 
4EE3: DB 5F       ADDB  $5F                  // B+= player blitter destination lo byte (Y component)                   
4EE5: 89 00       ADCA  #$00
4EE7: 44          LSRA  
4EE8: 56          RORB  
4EE9: 96 86       LDA   $86                  // get another random number
4EEB: 84 07       ANDA  #$07                 // ensure number in range of 0..7 decimal
4EED: 27 0A       BEQ   $4EF9                // if number == 0, goto $4EF9
4EEF: 96 5E       LDA   $5E                  // get hi byte (X component) of player blitter destination
4EF1: 81 4B       CMPA  #$4B                 // is player on the right half of the screen?
4EF3: 25 0A       BCS   $4EFF                // no, player is either in centre or left half of screen, goto $4EFF
4EF5: 86 8F       LDA   #$8F                 // ok, player is in right half of screen, aim at the far right wall
4EF7: 20 33       BRA   $4F2C

4EF9: 96 5E       LDA   $5E                  // get hi byte (X component) of player blitter destination
4EFB: 81 4B       CMPA  #$4B                 // is player in right half of screen?
4EFD: 23 F6       BLS   $4EF5                // no, player is in left hand half or centre of screen, goto $4EF5
4EFF: 86 07       LDA   #$07                 // ok, player is in left half of screen, aim at the far left wall
4F01: 20 29       BRA   $4F2C

4F03: 4F          CLRA  
4F04: D6 84       LDB   $84                  // get a random number into A
4F06: C4 0F       ANDB  #$0F                 // ensure number in range of 0..15 decimal
4F08: CB F8       ADDB  #$F8                 // add -8 decimal, to make number in range of -8 to 7 decimal                  
4F0A: EB 04       ADDB  $0004,X              // B+= tank shell blitter destination hi byte (X component) 
4F0C: DB 5E       ADDB  $5E                  // add hi byte (X component) of player blitter destination                  
4F0E: 89 00       ADCA  #$00
4F10: 44          LSRA  
4F11: 56          RORB  
4F12: 96 86       LDA   $86                  // get another random number
4F14: 84 07       ANDA  #$07                 // ensure number in range of 0..7 decimal
4F16: 27 0A       BEQ   $4F22
4F18: 96 5F       LDA   $5F                  // get lo byte (Y component) of player blitter destination 
4F1A: 81 81       CMPA  #$81                 // is player in bottom half of screen?
4F1C: 25 0A       BCS   $4F28                // no, goto $4F28, shell will be aimed at top wall
4F1E: 86 EA       LDA   #$EA                 // ok, player is in bottom half of screen, aim at the bottom wall
4F20: 20 08       BRA   $4F2A

4F22: 96 5F       LDA   $5F                  // get lo byte (Y component) of player blitter destination 
4F24: 81 81       CMPA  #$81                 // is player in bottom half of the screen?
4F26: 23 F6       BLS   $4F1E                // no, goto $4F1E
4F28: 86 18       LDA   #$18                 // player is in top half of screen, so aim at top wall

4F2A: 1E 89       EXG   A,B

// A = X coordinate to shoot shell at
// B = Y coordinate to shoot shell at
4F2C: 97 2B       STA   $2B
4F2E: 4F          CLRA  
4F2F: E0 05       SUBB  $0005,X
4F31: 82 00       SBCA  #$00
4F33: ED 88 10    STD   $10,X                // set Y delta of shell
4F36: D6 2B       LDB   $2B
4F38: 4F          CLRA  
4F39: E0 04       SUBB  $0004,X
4F3B: 82 00       SBCA  #$00
4F3D: ED 0E       STD   $000E,X              // set X delta of shell
4F3F: F6 BE 65    LDB   $BE65                // read tank shell accuracy setting
4F42: 86 40       LDA   #$40
4F44: 3D          MUL   
4F45: 1F 89       TFR   A,B
4F47: 4F          CLRA  
4F48: 58          ASLB  
4F49: 49          ROLA  
4F4A: 58          ASLB  
4F4B: 49          ROLA  
4F4C: 34 06       PSHS  B,A
4F4E: 43          COMA  
4F4F: 53          COMB  
4F50: 34 06       PSHS  B,A
4F52: 58          ASLB  
4F53: 49          ROLA  
4F54: 34 06       PSHS  B,A
4F56: 43          COMA  
4F57: 53          COMB  
4F58: 34 06       PSHS  B,A
4F5A: EC 0E       LDD   $000E,X              // read X delta
4F5C: 10 A3 64    CMPD  $0004,S
4F5F: 2F 1F       BLE   $4F80
4F61: 10 A3 66    CMPD  $0006,S
4F64: 2C 1A       BGE   $4F80
4F66: EC 88 10    LDD   $10,X                // read Y delta
4F69: 10 A3 62    CMPD  $0002,S
4F6C: 2F 12       BLE   $4F80
4F6E: 10 A3 E4    CMPD  ,S
4F71: 2C 0D       BGE   $4F80
4F73: 58          ASLB  
4F74: 49          ROLA  
4F75: ED 88 10    STD   $10,X                // set Y delta 
4F78: EC 0E       LDD   $000E,X              // read X delta
4F7A: 58          ASLB  
4F7B: 49          ROLA  
4F7C: ED 0E       STD   $000E,X              // set X delta
4F7E: 20 DC       BRA   $4F5C

4F80: 32 68       LEAS  $0008,S              // discard values pushed on stack @ 4F4C, 4F50, 4F54, 4F58
4F82: 9F 17       STX   $17
4F84: 96 85       LDA   $85                  // get another random number
4F86: 84 1F       ANDA  #$1F                 // ensure value in range of 0..31 decimal 
4F88: 8B 30       ADDA  #$30                 // add 48 decimal
4F8A: A7 4E       STA   $000E,U              // set lifespan of shell 
4F8C: CC 4B 11    LDD   #$4B11
4F8F: BD D0 4B    JSR   $D04B                // JMP $D3C7 - play sound with priority
4F92: 35 D0       PULS  X,U,PC //(PUL? PC=RTS)


MAKE_TANK_SHELL_BOUNCE_IF_HITS_BORDER_WALL:
4F94: AE 47       LDX   $0007,U
4F96: EC 0A       LDD   $000A,X             // get tank shell X coordinate into D 
4F98: E3 0E       ADDD  $000E,X             // add X delta 
4F9A: 81 07       CMPA  #$07                // hit left border wall?  
4F9C: 25 23       BCS   $4FC1               // yes, so goto $4FC1 to make the tank shell bounce off  
4F9E: 81 8B       CMPA  #$8B                // hit right border wall?
4FA0: 22 1F       BHI   $4FC1               // yes, so goto $4FC1 to make the tank shell bounce off  
4FA2: EC 0C       LDD   $000C,X             // get tank shell Y coordinate into D 
4FA4: E3 88 10    ADDD  $10,X               // add Y delta to D 
4FA7: 81 18       CMPA  #$18                // hit top border wall? 
4FA9: 25 1C       BCS   $4FC7               // yes, so goto $4FC7 to make the tank shell bounce off
4FAB: 81 E3       CMPA  #$E3                // hit bottom border wall?
4FAD: 22 18       BHI   $4FC7               // yes, so goto $4FC7 to make the tank shell bounce off
4FAF: 6A 4E       DEC   $000E,U             // decrement tank shell lifespan counter
4FB1: 27 08       BEQ   $4FBB               // if =0 goto $4FBB to remove the tank shell from the playfield
4FB3: 86 02       LDA   #$02
4FB5: 8E 4F 94    LDX   #$4F94
4FB8: 7E D0 66    JMP   $D066               // JMP $D1E3 - allocate task

//
// Remove a tank shell from the screen.
//
// This is where the infamous "only 20 tank shells fired in a wave" bug is to be found.
// The "current number of tank shells on screen" variable at $98F1 should be decremented when a tank shell "fizzles out".
// However, that never happens, so the game logic thinks there is always 20 shells on screen, and prevents no more from being created.  
//

REMOVE_TANK_SHELL:
// if you were able somehow to add DEC $F1 here, the bug would be fixed....
4FBB: BD D0 75    JSR   $D075               // JMP $D31B - deallocate object and erase object from screen               // JMP $D31B
4FBE: 7E D0 63    JMP   $D063               // JMP $D1F3 - free object metadata and process next task


//
// Called when the tank shell hits the left-most or right-most border
// The shell will fly off in the opposite direction
//
TANK_SHELL_BOUNCE_HORIZONTAL:
4FC1: 63 0E       COM   $000E,X             // flip bits X delta
4FC3: 63 0F       COM   $000F,X
4FC5: 20 06       BRA   $4FCD


//
// Called when the tank shell hits the top-most or bottom-most border
// The shell will fly off in the opposite direction
//
TANK_SHELL_BOUNCE_VERTICAL:
4FC7: 63 88 10    COM   $10,X               // flip bits Y delta
4FCA: 63 88 11    COM   $11,X
4FCD: CC 4B 16    LDD   #$4B16
4FD0: BD D0 4B    JSR   $D04B               // JMP $D3C7 - play sound with priority
4FD3: 20 DE       BRA   $4FB3


SHELL_COLLISION_HANDLER:
4FD5: 96 48       LDA   $48                 // did the player collision routine call this function?
4FD7: 26 14       BNE   $4FED               // yes, goto $4FED
4FD9: 0A F1       DEC   $F1                 // decrement number of tank shells on screen count
4FDB: BD 5B 43    JSR   $5B43               // JMP $5C1F - create an explosion
4FDE: BD D0 78    JSR   $D078               // JMP $D320 - deallocate object, and its metadata, and erase object from screen
4FE1: CC 00 25    LDD   #$0025
4FE4: BD D0 0C    JSR   $D00C               // JMP $DB9C - update player score
4FE7: CC 4B 1E    LDD   #$4B1E
4FEA: 7E D0 4B    JMP   $D04B               // JMP $D3C7 - play sound with priority

4FED: 39          RTS   




// X = pointer to object
// $A7 = Y coordinate
//
//
// Called by $29F5, 

DRAW_WARP_IN_VERTICALLY:
5BC6: 34 76       PSHS  U,Y,X,B,A
5BC8: 8D BA       BSR   $5B84                // reserve free object for warping in
5BCA: 25 3C       BCS   $5C08                // if carry set, could not reserve object , so goto $5C08 which is RTS
5BCC: CC 0A 0A    LDD   #$0A0A
5BCF: ED C8 10    STD   $10,U
5BD2: EC 04       LDD   $0004,X
5BD4: ED 49       STD   $0009,U              
5BD6: AE 02       LDX   $0002,X
5BD8: D6 A7       LDB   $A7
5BDA: E7 44       STB   $0004,U
5BDC: E0 4A       SUBB  $000A,U
5BDE: 25 04       BCS   $5BE4
5BE0: E1 01       CMPB  $0001,X
5BE2: 25 0B       BCS   $5BEF
5BE4: E6 84       LDB   ,X
5BE6: 54          LSRB  
5BE7: E7 45       STB   $0005,U
5BE9: EB 4A       ADDB  $000A,U
5BEB: E7 44       STB   $0004,U
5BED: 20 02       BRA   $5BF1

5BEF: E7 45       STB   $0005,U
5BF1: EC 84       LDD   ,X
5BF3: ED 4B       STD   $000B,U
5BF5: C6 01       LDB   #$01
5BF7: E7 4F       STB   $000F,U
5BF9: 88 04       EORA  #$04
5BFB: C8 04       EORB  #$04
5BFD: ED 4D       STD   $000D,U
5BFF: AE 02       LDX   $0002,X
5C01: AF 42       STX   $0002,U
5C03: CC 10 00    LDD   #$1000
5C06: ED 46       STD   $0006,U
5C08: 35 F6       PULS  A,B,X,Y,U,PC //(PUL? PC=RTS)



5C0A: CC 01 00    LDD   #$0100
5C0D: DD 88       STD   $88                 // set player laser direction fields
5C0F: 8D 0E       BSR   $5C1F               // create explosion 
5C11: 7E 5B 5B    JMP   $5B5B


5C14: CC 01 01    LDD   #$0101              // down, right
5C17: DD 88       STD   $88                 // set laser direction fields
5C19: 8D 04       BSR   $5C1F               // create explosion
5C1B: 86 FF       LDA   #$FF
5C1D: 97 88       STA   $88




//
// When an enemy has been shot or collided with an object that kills it (e.g. laser, electrode), this routine is called to make it explode. 
//
// X = enemy that's to explode
// $88 = horizontal direction of player's laser ($FF = left, 0=no horizontal movement, 1 = right)
// $89 =vertical direction of players laser ($FF = up, 0=no vertical movement, 1 = down)
// $A6 = pointer to screen address where enemy and object that killed it collided
//

MAKE_ENEMY_EXPLODE:
5C1F: 34 76       PSHS  U,Y,X,B,A
5C21: 96 88       LDA   $88                 // A = horizontal direction of player's laser ($FF = left, 0=laser moving vertical only, 1 = right)
5C23: 26 07       BNE   $5C2C               // if the players laser is moving on the horizontal axis only, goto $5C2C               
5C25: BD 5B 5B    JSR   $5B5B               // JMP $5BBB (read fancy mode flag, and if is on, go to $F0D7, which creates the actual explosion)
5C28: 24 7D       BCC   $5CA7               // if carry clear, couldn't create an explosion, so exit 
5C2A: 20 13       BRA   $5C3F

5C2C: D6 89       LDB   $89                 // B = vertical direction of players laser ($FF = up, 0=laser moving horizontal only, 1 = down)
5C2E: 27 0A       BEQ   $5C3A               // if players laser is moving on the horizontal axis but not vertical axis, goto $5C3A
5C30: 98 89       EORA  $89                 // A = A xor laser vertical direction
5C32: 43          COMA                      // flip bits
5C33: BD 46 83    JSR   $4683               // JMP $473F - create a directional explosion
5C36: 24 6F       BCC   $5CA7               // if carry clear, exit
5C38: 20 05       BRA   $5C3F

5C3A: BD 5B 6C    JSR   $5B6C               // reserve an object in U              
5C3D: 24 0A       BCC   $5C49               // if carry clear, then object reservation was successful, goto $5C49.

// if we get here, couldn't make the enemy explode so we just remove him from the screen. 
5C3F: 10 AE 02    LDY   $0002,X             // Y = pointer to animation frame metadata 
5C42: EC 04       LDD   $0004,X             // D = blitter destination
5C44: BD D0 1E    JSR   $D01E               // JMP $DABF: clear image rectangle
5C47: 20 5E       BRA   $5CA7               // exit




//

// Called by $D17A after INITIAL TESTS INDICATE: message.
77A0: JMP $77A5


77A2: A5 79       BITA  $FFF9,S

//
// TODO: 
//
//
//

77A5: BD D0 60    JSR   $D060               // JMP $D1FF - free all object metadata entries               
77A8: 0F F4       CLR   $F4
77AA: BD D0 54    JSR   $D054               // JMP $D281 - reserve object metadata entry and call function
77AD: 77 B9       // pointer to function
77AF: 8E 77 E4    LDX   #$77E4 
77B2: 4F          CLRA
77B3: BD D0 5A    JSR   $D05A               // JMP $D243 - reserve object metadata entry in list @ $981D and call function in X 
77B6: 7E D0 63    JMP   $D063               // JMP $D1F3 - free object metadata and process next task

77B9: 96 51       LDA   $51
77BB: A7 47       STA   $0007,U
77BD: 96 51       LDA   $51
77BF: A1 47       CMPA  $0007,U
77C1: 27 05       BEQ   $77C8
77C3: 0C F4       INC   $F4
77C5: 7E 79 9D    JMP   $799D

77C8: 86 08       LDA   #$08                // delay before calling function
77CA: 8E 77 BD    LDX   #$77BD              // address of function to call
77CD: 7E D0 66    JMP   $D066               // JMP $D1E3 - allocate task

77D0: 8A 77       ORA   #$77
77D2: 8A CA       ORA   #$CA
77D4: 8B 16       ADDA  #$16
77D6: 8A CA       ORA   #$CA
77D8: 8B 95       ADDA  #$95
77DA: 8A 77       ORA   #$77
77DC: 8A CA       ORA   #$CA
77DE: 8B CB       ADDA  #$CB
77E0: 8C 07 00    CMPX  #$0700
77E3: 00        NEG   $BD

77E4: BD D0 12    JSR   CLR_SCREEN1          // JMP $DB7C - Clear the screen 
77E7: BD DF 40    JSR   $DF40
77EA: 0F F4       CLR   $F4
77EC: 7E 79 9D    JMP   $799D

77EF: 0F F4       CLR   $F4
77F1: BD D0 60    JSR   $D060                // JMP $D1FF - free all object metadata entries
77F4: BD D0 30    JSR   $D030                // JMP $D7A5 - initialise all object lists
77F7: BD D0 12    JSR   CLR_SCREEN1
77FA: BD D0 54    JSR   $D054                // JMP $D281 - reserve object metadata entry and call function
77FD: 77 B9       // pointer to function
77FF: 0F 0C       CLR   $0C
7801: 0F 0E       CLR   $0E
7803: 86 03       LDA   #$03                 // delay
7805: 8E 78 0B    LDX   #$780B               // address of task
7808: 7E D0 66    JMP   $D066                // JMP $D1E3 - allocate task 

780B: 8E 18 3A    LDX   #$183A
780E: AF 49       STX   $0009,U
7810: 8E 9A B0    LDX   #$9AB0
7813: 10 8E 77 D0 LDY   #$77D0
7817: 10 AF 47    STY   $0007,U
781A: AF 4B       STX   $000B,U
781C: 86 01       LDA   #$01                 // delay
781E: 8E 78 24    LDX   #$7824               // address of task
7821: 7E D0 66    JMP   $D066                // JMP $D1E3 - allocate task

7824: 10 AE 4B    LDY   $000B,U
7827: CC 0B 0E    LDD   #$0B0E
782A: ED A4       STD   ,Y
782C: C6 0D       LDB   #$0D
782E: ED 24       STD   $0004,Y
7830: 30 2A       LEAX  $000A,Y
7832: AF 22       STX   $0002,Y
7834: 30 A9 00 A4 LEAX  $00A4,Y
7838: AF 26       STX   $0006,Y
783A: AE 49       LDX   $0009,U
783C: AF 28       STX   $0008,Y
783E: 10 AE 47    LDY   $0007,U
7841: EE A4       LDU   ,Y
7843: 27 33       BEQ   $7878
7845: 5F          CLRB  
7846: 86 CE       LDA   #$CE
7848: 34 10       PSHS  X
784A: BD 8D 69    JSR   $8D69                // call RENDER_GRAPHIC
784D: DE 15       LDU   $15
784F: 30 89 02 00 LEAX  $0200,X
7853: AF 49       STX   $0009,U
7855: 35 10       PULS  X
7857: 10 AE 4B    LDY   $000B,U
785A: 31 2A       LEAY  $000A,Y
785C: CC 0B 1B    LDD   #$0B1B
785F: BD D0 B7    JSR   $D0B7                // JMP $DE59 : COPY_FROM_SCREEN_TO_RAM
7862: AE 4B       LDX   $000B,U
7864: 30 89 01 33 LEAX  $0133,X
7868: 10 AE 47    LDY   $0007,U
786B: 31 22       LEAY  $0002,Y
786D: 20 A8       BRA   $7817

786F: 34 02       PSHS  A
7871: B6 CC 13    LDA   $CC13                // read "fancy attract mode" setting from CMOS
7874: 84 0F       ANDA  #$0F
7876: 35 82       PULS  A,PC //(PUL? PC=RTS)

7878: 8D F5       BSR   $786F
787A: 27 03       BEQ   $787F
787C: BD D0 12    JSR   CLR_SCREEN1
787F: 86 07       LDA   #$07
7881: 97 0C       STA   $0C
7883: 86 3F       LDA   #$3F
7885: 97 0E       STA   $0E
7887: 8D E6       BSR   $786F
7889: 10 27 0F 19 LBEQ  $87A6
788D: 96 59       LDA   $59
788F: 84 FB       ANDA  #$FB
7891: 97 59       STA   $59
7893: DE 15       LDU   $15
7895: 10 8E 9A B0 LDY   #$9AB0
7899: 10 AF 47    STY   $0007,U
789C: 86 09       LDA   #$09
789E: A7 49       STA   $0009,U
78A0: 20 08       BRA   $78AA

78A2: 86 08       LDA   #$08
78A4: 8E 78 AA    LDX   #$78AA
78A7: 7E D0 66    JMP   $D066                // JMP $D1E3 - allocate task

78AA: 10 AE 47    LDY   $0007,U
78AD: EC 28       LDD   $0008,Y
78AF: CB 0D       ADDB  #$0D
78B1: D7 A7       STB   $A7
78B3: C0 0D       SUBB  #$0D
78B5: 30 A4       LEAX  ,Y
78B7: BD 5B 55    JSR   $5B55
78BA: CB 0E       ADDB  #$0E
78BC: D7 A7       STB   $A7
78BE: 30 24       LEAX  $0004,Y
78C0: BD 5B 55    JSR   $5B55
78C3: 31 A9 01 33 LEAY  $0133,Y
78C7: 10 AF 47    STY   $0007,U
78CA: 6A 49       DEC   $0009,U
78CC: 26 D4       BNE   $78A2
78CE: 86 20       LDA   #$20
78D0: 8E 87 A6    LDX   #$87A6
78D3: 7E D0 66    JMP   $D066                // JMP $D1E3 - allocate task

78D6: 86 3F       LDA   #$3F
78D8: 97 0F       STA   $0F
78DA: 86 07       LDA   #$07
78DC: 97 0D       STA   $0D
78DE: BD D0 54    JSR   $D054                // JMP $D281 - reserve object metadata entry and call function
78E1: D0 C3       // pointer to function
78E3: 10 8E 8C E8 LDY   #$8CE8
78E7: 5F          CLRB  
78E8: 8E 39 5C    LDX   #$395C
78EB: 86 FD       LDA   #$FD
78ED: EE B1       LDU   [,Y++]
78EF: 27 05       BEQ   $78F6
78F1: BD 8D 69    JSR   $8D69
78F4: 20 F7       BRA   $78ED

78F6: EE A1       LDU   ,Y++
78F8: 27 05       BEQ   $78FF
78FA: BD 8D 69    JSR   $8D69               // call RENDER_GRAPHIC
78FD: 20 F7       BRA   $78F6

78FF: BD D0 54    JSR   $D054               // JMP $D281 - reserve object metadata entry and call function
7902: 79 2D          // pointer to function 
7904: 10 8E 79 75 LDY   #$7975
7908: 8E 98 0E    LDX   #$980E
790B: 86 01       LDA   #$01
790D: DE 15       LDU   $15
790F: AF 49       STX   $0009,U
7911: 10 AF 4B    STY   $000B,U
7914: A7 4D       STA   $000D,U
7916: AE 49       LDX   $0009,U
7918: AF 47       STX   $0007,U
791A: AE 47       LDX   $0007,U
791C: A6 80       LDA   ,X+
791E: 27 F6       BEQ   $7916
7920: A7 D8 0B    STA   [$0B,U]
7923: AF 47       STX   $0007,U
7925: A6 4D       LDA   $000D,U
7927: 8E 79 1A    LDX   #$791A
792A: 7E D0 66    JMP   $D066               // JMP $D1E3 - allocate task

792D: 96 86       LDA   $86
792F: 2A 10       BPL   $7941
7931: 86 07       LDA   #$07
7933: 97 0C       STA   $0C
7935: BD D0 39    JSR   $D039               // JMP $D6CD - get a random number into A
7938: 84 07       ANDA  #$07
793A: 4C          INCA  
793B: 8E 79 41    LDX   #$7941
793E: 7E D0 66    JMP   $D066               // JMP $D1E3 - allocate task

7941: 96 84       LDA   $84
7943: 84 03       ANDA  #$03
7945: 27 0A       BEQ   $7951
7947: 0F 0C       CLR   $0C
7949: 86 03       LDA   #$03
794B: 8E 79 51    LDX   #$7951
794E: 7E D0 66    JMP   $D066               // JMP $D1E3 - allocate task

7951: 8E 79 8B    LDX   #$798B
7954: BD D0 39    JSR   $D039               // JMP $D6CD - get a random number into A
7957: 84 0F       ANDA  #$0F
7959: A6 86       LDA   A,X
795B: 97 0C       STA   $0C
795D: 86 07       LDA   #$07
795F: 8E 79 65    LDX   #$7965
7962: 7E D0 66    JMP   $D066               // JMP $D1E3 - allocate task

7965: 96 86       LDA   $86
7967: 84 03       ANDA  #$03
7969: 27 C2       BEQ   $792D
796B: 0F 0C       CLR   $0C
796D: 86 04       LDA   #$04
796F: 8E 79 2D    LDX   #$792D
7972: 7E D0 66    JMP   $D066               // JMP $D1E3 - allocate task

7975: 3F 3F 3F 37 2F 27 1F 17 0F 07 07 07 0F 17 1F 27 
7985: 2F 37 3F 3F 3F 00 

798B: FF C0 C7 1F 07 07 C0 C7 FF C0 C7 16 07 FF C0 C7 

799B: 20 37       BRA   $79D4

799D: 96 F4       LDA   $F4
799F: 8A 80       ORA   #$80
79A1: 97 F4       STA   $F4
79A3: 8D 0A       BSR   $79AF
79A5: 86 81       LDA   #$81
79A7: BD 5F 99    JSR   JMP_PRINT_STRING_LARGE_FONT    // JMP $6147  print SAVE THE LAST HUMAN FAMILY
79AA: 8E 83 B2    LDX   #$83B2
79AD: 20 2A       BRA   $79D9



INTRODUCE_MUTANT_SAVIOUR_SCRIPT:
83B7: 01 7E 97                               // $7D31  - SET_ANIMATION_FRAME_METADATA_FOR_STORYLINE_CHARACTER            
83BA: 07 18 A0                               // $7CC1  - SET_STORYLINE_CHARACTER_POSITION: X,Y coordinates 18,A0        
83BD: 15 84 0F                               // $7C05  - EXECUTE_CHARACTER_STORYLINE: character script for mutant saviour @840F.


83C0: 04 60 02                               // $7D1F      
83C3: 06 0B 90                               // $7D2B
83C6: 0B FF 0B       
83C9: FF 03 50








D000: 7E D1 06    JMP   $D106

D003: 7E DE 0F    JMP   $DE0F

D006: 7E D3 B6    JMP   $D3B6

D009: 7E DC 11    JMP   $DC11

D00C: 7E DB 9C    JMP   $DB9C

D00F: 7E DC 13    JMP   $DC13

CLR_SCREEN1:
D012: 7E DB 7C    JMP   CLR_SCREEN

D015: 7E DB 03    JMP   $DB03

D018: 7E DA F2    JMP   $DAF2

D01B: 7E DA DF    JMP   $DADF

D01E: 7E DA BF    JMP   $DABF

D021: 7E DA 82    JMP   $DA82

D024: 7E D8 9E    JMP   $D89E

D027: 7E D7 C9    JMP   $D7C9

D02A: 7E D5 F5    JMP   $D5F5

D02D: 7E D5 E2    JMP   $D5E2

D030: 7E D7 A5    JMP   $D7A5

LOAD_DA51_PALETTE1:
D033: 7E D7 95    JMP   LOAD_DA51_PALETTE

D036: 7E D6 EC    JMP   $D6EC

D039: 7E D6 CD    JMP   $D6CD

D03C: 7E D6 C8    JMP   $D6C8

D03F: 7E D6 B6    JMP   $D6B6

D042: 7E D6 AC    JMP   $D6AC

D045: 7E D6 99    JMP   $D699

D048: 7E D6 A8    JMP   $D6A8

D04B: 7E D3 C7    JMP   $D3C7

D04E: 7E D2 A7    JMP   $D2A7

D051: 7E D2 8F    JMP   $D28F

D054: 7E D2 81    JMP   $D281

D057: 7E D2 5A    JMP   $D25A

D05A: 7E D2 43    JMP   $D243

D05D: 7E D2 18    JMP   $D218

D060: 7E D1 FF    JMP   $D1FF

D063: 7E D1 F3    JMP   $D1F3

D066: 7E D1 E3    JMP   $D1E3

D069: 7E D3 0E    JMP   $D30E

D06C: 7E D3 2B    JMP   $D32B

D06F: 7E D2 FD    JMP   $D2FD

D072: 7E D3 06    JMP   $D306

D075: 7E D3 1B    JMP   $D31B

D078: 7E D3 20    JMP   $D320

D07B: 7E D2 DA    JMP   $D2DA

D07E: 7E D2 C2    JMP   $D2C2

D081: 7E D2 E7    JMP   $D2E7

D084: 7E D2 CA    JMP   $D2CA

D087: 7E D2 F2    JMP   $D2F2

D08A: 7E D2 D2    JMP   $D2D2

D08D: 7E DB 2F    JMP   $DB2F

D090: 7E DA 9E    JMP   $DA9E

D093: 7E DA 61    JMP   $DA61

D096: 7E D1 96    JMP   $D196

FLIP_SCR_UP1:
D099: 7E D4 FC    JMP   FLIP_SCR_UP

FLIP_SCR_DOWN1:
D09C: 7E D5 03    JMP   FLIP_SCR_DOWN

D09F: 7E D5 C0    JMP   $D5C0

PACK_2_BYTES_INTO_A1:
D0A2: 7E D5 12    JMP   PACK_2_BYTES_INTO_A

D0A5: 7E D5 23    JMP   $D523

D0A8: 7E D5 21    JMP   $D521

STA_NIB_X1:
D0AB: 7E D5 2B    JMP   STA_NIB_X

D0AE: 7E D5 39    JMP   $D539

D0B1: 7E D5 37    JMP   $D537

D0B4: 7E D5 E2    JMP   $D5E2

D0B7: 7E DE 59    JMP   $DE59

D0BA: 7E D6 5B    JMP   $D65B

D0BD: 7E D6 55    JMP   $D655

D0C0: 7E D1 8A    JMP   $D18A

D0C3: 7E DA 0D    JMP   $DA0D

D0C6: 7E D5 D8    JMP   $D5D8

D0C9: EF 01       STU   $0001,X
D0CB: 20 1E       BRA   $D0EB

D0CD: 00 FF       NEG   $FF
D0CF: 01          Illegal Opcode
D0D0: 20 0C       BRA   $D0DE

D0D2: 00 FF       NEG   $FF
D0D4: 01          Illegal Opcode
D0D5: 20 20       BRA   $D0F7

D0D7: 00 FF       NEG   $FF
D0D9: 03 10       COM   $10
D0DB: 24 00       BCC   $D0DD
D0DD: FF 01 20    STU   $0120
D0E0: 27 00       BEQ   $D0E2
D0E2: FF 01 20    STU   $0120


// 
D0E5: 2D 00       BLT   $D0E7


D0E7: FF 02 10    STU   $0210
D0EA: 35 00       PULS  
D0EC: FF 01 20    STU   $0120
D0EF: 3A          ABX   
D0F0: 00 FF       NEG   $FF
D0F2: 01          Illegal Opcode
D0F3: 20 3E       BRA   $D133

D0F5: 00 00       NEG   $00
D0F7: 34 FF       PSHS  PC,U,Y,X,DP,B,A,CC
D0F9: 35 00       PULS  
D0FB: 34 00       PSHS  
D0FD: 3C 

// 
D0FE: C8 0C      
D100: C8 0E 
D102: C8 04 
D104: C8 06





//
// TODO: 
//
//

D196: 8E 98 11    LDX   #$9811
D199: 9F 15       STX   $15                  // create first entry in tasks list
D19B: 96 10       LDA   $10
D19D: 81 02       CMPA  #$02
D19F: 25 FA       BCS   $D19B
D1A1: 48          ASLA                       // multiply A...  
D1A2: 48          ASLA  
D1A3: 48          ASLA                       // .. by 8
D1A4: 9B 42       ADDA  $42
D1A6: 44          LSRA  
D1A7: 97 42       STA   $42
D1A9: 0F 10       CLR   $10
D1AB: BD D6 CD    JSR   $D6CD                // Get a random number into A
D1AE: 96 59       LDA   $59
D1B0: 85 04       BITA  #$04
D1B2: 26 03       BNE   $D1B7
D1B4: BD 5B 49    JSR   $5B49
D1B7: 9E 33       LDX   $33
D1B9: 26 0C       BNE   $D1C7
D1BB: 9E 37       LDX   $37
D1BD: 27 17       BEQ   $D1D6
D1BF: DC 39       LDD   $39
D1C1: 0F 37       CLR   $37
D1C3: 0F 38       CLR   $38
D1C5: 20 06       BRA   $D1CD

D1C7: DC 35       LDD   $35
D1C9: 0F 33       CLR   $33
D1CB: 0F 34       CLR   $34
D1CD: D4 59       ANDB  $59
D1CF: 26 E6       BNE   $D1B7
D1D1: BD D0 57    JSR   $D057                // JMP $D25A - reserve object metadata entry in list @ $9813 and call function in X 
D1D4: 20 E1       BRA   $D1B7

D1D6: DE 11       LDU   $11                  // U = pointer to list used by enforcer, quark, spark and shell
D1D8: 27 13       BEQ   $D1ED


D1DA: 6A 44       DEC   $0004,U              // decrement countdown before executing task
D1DC: 26 0B       BNE   $D1E9                // if !=0 then go do next object
D1DE: DF 15       STU   $15                  // save address of current object being processed
D1E0: 6E D8 02    JMP   [$02,U]              // call routine to execute task


// Allocate a task. 
//
// A = initial delay before calling function. Multiply A by 16 Millisec to get real delay
// X = address of function to jump to when delay expires
//

ALLOCATE_TASK:
D1E3: DE 15       LDU   $15                  // get pointer to free metadata slot
D1E5: A7 44       STA   $0004,U              // set countdown before task executes
D1E7: AF 42       STX   $0002,U              // store address of routine to jump to
D1E9: EE C4       LDU   ,U                   // read next object entry
D1EB: 26 ED       BNE   $D1DA                // if !=NULL then go process it
D1ED: 10 CE BF 70 LDS   #stacktop
D1F1: 20 A3       BRA   $D196


// Returns: U = pointer to a task 

FREE_OBJECT_METADATA_AND_PROCESS_TASKS:
D1F3: 9E 15       LDX   $15                  // X = pointer to current task 
D1F5: 10 CE BF 70 LDS   #stacktop
D1F9: 8D 1D       BSR   $D218                // free object metadata entry in X             
D1FB: 33 84       LEAU  ,X
D1FD: 20 EA       BRA   $D1E9                // process object entry in U



//
// This routine appears to free all object metadata currently reserved
//
//

FREE_ALL_OBJECT_METADATA:
D1FF: 34 12       PSHS  X,A
D201: 8E 98 11    LDX   #$9811               // object metadata list start
D204: AE 84       LDX   ,X                   // read pointer to object metadata
D206: 27 0E       BEQ   $D216                // if NULL then exit
D208: 9C 15       CPX   $15         
D20A: 27 F8       BEQ   $D204
D20C: A6 05       LDA   $0005,X
D20E: 81 01       CMPA  #$01
D210: 27 F2       BEQ   $D204
D212: 8D 04       BSR   $D218                // free object metadata entry
D214: 20 EE       BRA   $D204                // process next

D216: 35 92       PULS  A,X,PC //(PUL? PC=RTS)



// Called when an object is gone (e.g.: when it's been killed, rescued) and its associated metadata
// needs to be freed for use by other objects.
//
// Expects: X = pointer to an object's metadata
// Returns: X = 

FREE_OBJECT_METADATA_ENTRY:
D218: 34 46       PSHS  U,B,A
D21A: CE 98 11    LDU   #$9811               // object metadata list start
D21D: AC C4       CPX   ,U                   // x == *u ? (have we matched x in the list?)
D21F: 26 18       BNE   $D239                // if x != *u, goto $d239
D221: EC 84       LDD   ,X                   // get pointer to NEXT object metadata entry into D                   
D223: ED C4       STD   ,U                   // store in list                              
D225: A6 06       LDA   $0006,X
D227: 27 06       BEQ   $D22F
D229: DC 1D       LDD   $1D                  // get pointer to progs and cruise missile metadata list
D22B: 9F 1D       STX   $1D
D22D: 20 04       BRA   $D233
D22F: DC 13       LDD   $13                  // get pointer to enforcer, quark, spark and shell metadata list
D231: 9F 13       STX   $13
D233: ED 84       STD   ,X
D235: 30 C4       LEAX  ,U
D237: 35 C6       PULS  A,B,U,PC //(PUL? PC=RTS)

D239: EE C4       LDU   ,U                  // get next entry in object metadata list
D23B: 26 E0       BNE   $D21D               // if not null goto $D21D
D23D: 8D 00       BSR   $D23F               
D23F: 1A 10       ORCC  #$10                // disable interrupts
D241: 20 FE       BRA   $D241               // put in an infinite loop - this must be to invoke the watchdog! 



//
// Reserve an entry in the THIRD object metadata linked list, which is pointed to by $981D
// This linked list of object metadata is used by progs and cruise missiles.
//
// See also: 
// $1E23 - CREATE_PROG
// $2020 - CREATE_CRUISE_MISSILE
//
// On entry: X = pointer to function to call IMMEDIATELY
//
// Returns: X = pointer to object metadata 
//

RESERVE_OBJECT_METADATA_ENTRY_1D:
D243: 34 62       PSHS  U,Y,A
D245: DE 1D       LDU   $1D
D247: 26 01       BNE   $D24A               // ???????? !!!!! $D24A is invalid code. But this routine still works, I stepped through it in MAME.
D249: BD D2 3F    JSR   $D23F               // invoke watchdog
D24C: 10 AE C4    LDY   ,U
D24F: 10 9F 1D    STY   $1D
D252: 86 01       LDA   #$01                // flag to say that this object is in list $1D (see $D225)
D254: A7 46       STA   $0006,U
D256: A6 E4       LDA   ,S                  // read A from stack
D258: 20 11       BRA   $D26B


//
// Reserve an entry in the SECOND object metadata linked list, which is pointed to by $9813
// This list of object metadata is used by enforcer, quark, spark and shell.
//
// See also:
// $3201 - 
//
//
// On entry: X = function to call IMMEDIATELY
// A = ???
//
// On exit: X = pointer to object metadata entry in list 

RESERVE_OBJECT_METADATA_ENTRY_13:
D25A: 34 62       PSHS  U,Y,A
D25C: DE 13       LDU   $13                  // get valid object metadata entry
D25E: 26 03       BNE   $D263                // if not NULL goto $D263
D260: BD D2 3F    JSR   $D23F                // OK, this value is null, jump into an infinite loop to invoke watchdog
D263: 10 AE C4    LDY   ,U                   // Y = *U. Get next valid object metadata entry..
D266: 10 9F 13    STY   $13                  // ...and store in $13
D269: 6F 46       CLR   $0006,U
D26B: AF 42       STX   $0002,U              // function to call (see $D1E0)
D26D: A7 45       STA   $0005,U
D26F: 86 01       LDA   #$01
D271: A7 44       STA   $0004,U              // delay
D273: AE 9F 98 15 LDX   [$9815]
D277: EF 9F 98 15 STU   [$9815]
D27B: AF C4       STX   ,U
D27D: 30 C4       LEAX  ,U                   // X= U
D27F: 35 E2       PULS  A,Y,U,PC //(PUL? PC=RTS)



//
// Strange bit of code here. Called a lot.
// You'll see blocks of code like the following in the disassembly:
//
// BD D0 54    JSR   $D054                   // JMP $D281
// 77 A0          // pointer to function to call
// EF 07       STU   $0007,X
//
// What happens is that the function loads the return address (the address the system would jump to
// when it encounters an RTS or a PULS PC) from the stack into U. Cunningly, the return address  
// points to 2 bytes which are parameters. A PULU X reads the 2 bytes from the return address into X, 
// in this case 77 A0.
// 
// The return address is then updated on the stack to what U is *after* the PULU.  
// When an RTS or PULS PC is hit, the system will pop the return address off the stack,
// which of course now points to the instruction immediately *following* the 2 parameter bytes:
// STU $0007,X . The parameter bytes never get processed by the CPU as instructions (which is a good thing).
//
// The system continues as normal.
// 
// This is a crude way of passing parameters to a function, wonder why the Vid Kidz did it this way?
//
// See also:
// $017C - INITIALISE_SINGLE_HULK
// $02D9 - INITIALISE_FAMILY_MEMBERS
// $12D5 - SPHEROID_COLLISION_HANDLER (this routine draws the spheroid dying)
// $1B1F - INITIALISE_ALL_BRAINS
// $38F7 - INITIALISE_ALL_GRUNTS
//
//
// Returns: X set to object metadata entry.
//

RESERVE_OBJECT_METADATA_AND_CALL_FUNCTION:
D281: 34 42       PSHS  U,A                                
D283: EE 63       LDU   $0003,S              // get return address off the stack and put into U
D285: 37 10       PULU  X                    // pull parameters from U into X
D287: EF 63       STU   $0003,S              // update return address of this function to be == U.             
D289: 86 00       LDA   #$00
D28B: 8D CD       BSR   $D25A                // reserve object metadata entry
D28D: 35 C2       PULS  A,U,PC //(PUL? PC=RTS)


//
// Reserve an object in the linked list for use by a game entity (Player, grunt etc etc.)
// Returns: X = the newly reserved object
//

RESERVE_OBJECT_IN_LINKED_LIST:
D28F: 34 06       PSHS  B,A
D291: 9E 1B       LDX   $1B                  // read pointer to free object in linked list
D293: 26 03       BNE   $D298                // if not 0 (end of available space) go to $D298
D295: BD D2 3F    JSR   $D23F                // pointer is zero - so go to a subroutine that ends up infinite loop. I think this is to force the watchdog to reset the game
D298: EC 84       LDD   ,X                   // D = *pointer - now D points to the *next* free object, as this one has been taken up 
D29A: DD 1B       STD   $1B                  // save free object pointer
D29C: C6 02       LDB   #$02                 // zero from position X+2 to X+#$18 - clear allocated object's internal state to 0
D29E: 6F 85       CLR   B,X
D2A0: 5C          INCB  
D2A1: C1 18       CMPB  #$18
D2A3: 26 F9       BNE   $D29E
D2A5: 35 86       PULS  A,B,PC //(PUL? PC=RTS)


// Called when an object dies or needs to disappear. The object entry is then free for re-use.
// 
// X = Object to free
// U = pointer to linked list that contains the object
//

FREE_OBJECT:
D2A7: AC C4       CPX   ,U                   // find X in the list 
D2A9: 26 10       BNE   $D2BB
// OK we've found X in the list
D2AB: 10 AE D4    LDY   [,U]                 // need to check to see what this does        
D2AE: 10 AF C4    STY   ,U
D2B1: 10 9E 1B    LDY   $1B                  // get pointer to next object
D2B4: 9F 1B       STX   $1B                  // mark this object in X as current free object
D2B6: 10 AF 84    STY   ,X                   // set pointer to next free object at (*X) - thus creating a chain of "free objects"  
D2B9: 35 F0       PULS  X,Y,U,PC //(PUL? PC=RTS)

D2BB: EE C4       LDU   ,U
D2BD: 26 E8       BNE   $D2A7
D2BF: BD D2 3F    JSR   $D23F                // go to a subroutine that forces an infinite loop - to force watchdog



//
// Called to free a grunt, hulk, brain, prog, cruise missile or tank from the linked list beginning @ $9821.
// This is called when the entity has been killed.
//
// X = object to free from linked list 
FREE_GRUNT_HULK_BRAIN_PROG_CRUISE_OR_TANK_OBJECT:
D2C2: 34 70       PSHS  U,Y,X
D2C4: CE 98 21    LDU   #$9821               // pointer to grunts_hulks_brains_progs_cruise_tanks list start
D2C7: 7E D0 4E    JMP   $D04E                // JMP $D2A7: free object for use                



// Called to free an electrode from the linked list beginning @ $9823.
// This is called when the entity has been killed.
//
// X = electrode to free from linked list 
FREE_ELECTRODE_OBJECT:
D2CA: 34 70       PSHS  U,Y,X
D2CC: CE 98 23    LDU   #$9823               // pointer to electrode list
D2CF: 7E D0 4E    JMP   $D04E                // JMP $D2A7: free object for use                



// Called to free a family member from the linked list beginning @ $981F.
// This is called when the family member is either rescued/killed or just starting to be prog'd
//
// X = family member to free from linked list 
FREE_FAMILY_MEMBER_OBJECT:
D2D2: 34 70       PSHS  U,Y,X
D2D4: CE 98 1F    LDU   #$981F               // pointer to family list
D2D7: 7E D0 4E    JMP   $D04E                // JMP $D2A7: free object for use 


RESERVE_GRUNT_HULK_BRAIN_PROG_CRUISE_TANK:
D2DA: 34 06       PSHS  B,A
D2DC: BD D0 51    JSR   $D051                // JMP $D28F - reserve an object entry     
// X = the newly reserved object
D2DF: DC 21       LDD   $21                  // get pointer to last object created
D2E1: 9F 21       STX   $21                  // store pointer to freshly created object in $21
D2E3: ED 84       STD   ,X                   // create linked list from X to D
D2E5: 35 86       PULS  A,B,PC //(PUL? PC=RTS)


RESERVE_ELECTRODE_OBJECT:
D2E7: 34 06       PSHS  B,A
D2E9: BD D0 51    JSR   $D051                // JMP $D28F - reserve an object entry        
// X = the newly reserved object
D2EC: DC 23       LDD   $23                  // get pointer to last electrode created
D2EE: 9F 23       STX   $23                  // store pointer to freshly created object in $21
D2F0: 20 F1       BRA   $D2E3



RESERVE_FAMILY_MEMBER_OBJECT:
D2F2: 34 06       PSHS  B,A
D2F4: BD D0 51    JSR   $D051                // JMP $D28F - reserve an object entry      
// at this point X = our new object
D2F7: DC 1F       LDD   $1F                  // get pointer to last family object created                                    
D2F9: 9F 1F       STX   $1F                  // store object entry into family object pointer
D2FB: 20 E6       BRA   $D2E3


//
//
//

RESERVE_OBJECT_FOR_SPHEROID_ENFORCER_QUARK_SPARK_SHELL:
D2FD: 34 06       PSHS  B,A
D2FF: BD D0 51    JSR   $D051                // JMP $D28F: reserve an object entry      
// X = the newly reserved object
D302: DC 17       LDD   $17                    
D304: 20 DD       BRA   $D2E3                // *X = D




//
// Called to free an enforcer, quark, spark, or shell from the linked list beginning @ $9817.
// This is called when the entity has been killed or expires (e.g. spark fizzles out).
//
// X = object to free from linked list 
//

FREE_ENFORCER_QUARK_SPARK_SHELL_OBJECT:
D306: 34 70       PSHS  U,Y,X
D308: CE 98 17    LDU   #$9817               // address of list for those types of entities
D30B: 7E D0 4E    JMP   $D04E                // JMP $D2A7: free object for use               


D30E: 10 8E AE D9 LDY   #$AED9
D312: BD D0 54    JSR   $D054                // JMP D281
D315: D3 68       // pointer to function
D317: 10 AF 09    STY   $0009,X
D31A: 39          RTS   


FREE_ENFORCER_QUARK_SPARK_SPHEROID_SHELL_OBJECT_AND_ERASE_SPRITE:
D31B: 8D E9       BSR   $D306               // free baddy from list
D31D: 7E D0 15    JMP   $D015               // JMP $DB03: erase object's sprite from screen



FREE_ENFORCER_QUARK_SPARK_SPHEROID_SHELL_OBJECT_AND_METADATA_THEN_ERASE_SPRITE:
D320: 34 10       PSHS  X
D322: 8D F7       BSR   $D31B               // free object from its list
D324: AE 06       LDX   $0006,X             // get pointer to object metadata
D326: BD D0 5D    JSR   $D05D               // JMP $D218 - deallocate object metadata entry
D329: 35 90       PULS  X,PC //(PUL? PC=RTS)



// Create an entity with parameters. An entity in this case can be a spark, an enforcer, a quark, or a tank shell.
//
// Returns: pointer to new entity in X
//
// See also:
// $1358 - CREATE_ENFORCER
// $141C - CREATE_SPARK
// $4B3D - INITIALISE_ALL_QUARKS
// $4E61 - CREATE_TANK_SHELL
//
// Notes: 
// When this function is called, the function obtains the function return address from the stack,
// pulls *6* bytes from the return address, which are its parameters (see below for description) 
// then modifies the return address on the stack to point to the instruction *immediately following the last parameter*.
// When the function returns (ie: hits RTS) the game continues from the line of code following the parameters! Quite smart eh?
//
// There are 3 parameters, all are pointers:
// First parameter: pointer to constructor to initialise object 
// Second parameter: animation frame metadata pointer
// Third parameter:  pointer to collision detection routine
//

CREATE_ENFORCER_QUARK_SPARK_SHELL:
D32B: 34 26       PSHS  Y,B,A
D32D: 9E 1B       LDX   $1B                  // read free object slot
D32F: 27 2E       BEQ   $D35F                // if its null we don't have any free objects - must be a lot happening! - so just exit
D331: 9E 13       LDX   $13                  // read object linked list pointer
D333: 27 2A       BEQ   $D35F                // if its null we've no object slots available either
D335: 4F          CLRA  
D336: EE 64       LDU   $0004,S              // U = return address from stack
D338: 37 10       PULU  X                    // pull pointer to function that initialises object (akin to a constructor in C++/Java/C# etc.) from U into X
D33A: BD D0 57    JSR   $D057                // JMP $D25A - reserve object metadata entry in list @ $9813 and call function in X 
// X = pointer to object metadata entry
D33D: 31 84       LEAY  ,X                   // Y = X
D33F: BD D0 6F    JSR   $D06F                // JMP $D2FD - reserve an object entry & store at $17.
// X = pointer to freshly created object
D342: EC C1       LDD   ,U++                 // read next 2 bytes (animation frame metadata pointer) from U into D                 
D344: ED 88 14    STD   $14,X                // set previous animation frame metadata pointer
D347: ED 02       STD   $0002,X              // set current animation frame metadata pointer (previous = current)
D349: 37 06       PULU  A,B                  // pull pointer to collision detection routine from U into D
D34B: ED 08       STD   $0008,X              // store pointer to routine that handles collision detection
D34D: EF 64       STU   $0004,S
D34F: 33 A4       LEAU  ,Y                   // U = Y 
D351: EF 06       STU   $0006,X              // set pointer to object metadata in this object
D353: AF 47       STX   $0007,U              // set pointer to this object in the object metadata entry
D355: 4F          CLRA  
D356: 5F          CLRB  
D357: ED 88 10    STD   $10,X                // set Y delta to 0
D35A: ED 0E       STD   $000E,X              // set X delta to 0
D35C: 43          COMA                       // flip bits (xor with #$FF) to set z flag 
D35D: 35 A6       PULS  A,B,Y,PC //(PUL? PC=RTS)
//
// If we get here, the object can't be created, so we need to clear the z flag
//
D35F: EE 64       LDU   $0004,S              // U = Y from stack
D361: 33 48       LEAU  $0008,U
D363: EF 64       STU   $0004,S
D365: 4F          CLRA                       // clear zero flag to indicate failure  
D366: 35 A6       PULS  A,B,Y,PC //(PUL? PC=RTS)

D368: 96 F2       LDA   $F2
D36A: 26 47       BNE   $D3B3
D36C: 0C F2       INC   $F2
D36E: 86 03       LDA   #$03
D370: AE 49       LDX   $0009,U
D372: 30 89 28 57 LEAX  $2857,X
D376: AF 49       STX   $0009,U
D378: A7 47       STA   $0007,U
D37A: 86 08       LDA   #$08
D37C: 8E D3 82    LDX   #$D382
D37F: 7E D0 66    JMP   $D066                // JMP $D1E3 - allocate function call





//
// Divide A by B.
//
// For example, on entry to this function, if A was set to 16 decimal and B was 4 decimal, 
// the value returned by this function (in A) would be 4. 
//
// Expects: 
// A= value
// B= divisor
//
// Returns:
// A = (A divided by B) as BCD
// B = modulo of (A divided by B) 
// 

DIVIDE_A_BY_B:
D5C0: 34 04       PSHS  B                    // save divisor on stack ready for use @$D5CF
D5C2: 5D          TSTB                       // is B nonzero?   
D5C3: 26 03       BNE   $D5C8                // yes, goto $D5C8
D5C5: 4F          CLRA                       // B, the divisor, is zero. You can't divide by zero, so set A to zero.
D5C6: 35 84       PULS  B,PC //(PUL? PC=RTS)  // ...and exit.
D5C8: 1E 89       EXG   A,B                  // Now A = Divisor, B = Value
D5CA: 86 99       LDA   #$99                 // when you add 1 to #$99, and apply DAA, A becomes 0 
D5CC: 8B 01       ADDA  #$01                 // increment result count (eventual result of division) by 1
D5CE: 19          DAA                        // ensure A is a valid BCD number 
D5CF: E0 E4       SUBB  ,S                   // subtract divisor held on stack, from value in B 
D5D1: 24 F9       BCC   $D5CC                // if there's no carry, that is to say there's a positive integer left from subtraction, goto $D5CC   
D5D3: EB E0       ADDB  ,S+                  // produce modulo 
D5D5: 39          RTS   




//
// Get a pointer to the state of the current player.
//
// Expects: $3F set to player number (1 or 2)
//
// Returns: X = pointer to player state
//

LOAD_X_WITH_ADDR_OF_CURRENT_PLAYER_STATE:
D699: 34 02       PSHS  A
D69B: 96 3F       LDA   $3F                  // read player number
D69D: 8E BD E4    LDX   #p1_score
D6A0: 4A          DECA                       // player number --
D6A1: 27 03       BEQ   $D6A6                // if we're player 1 this value will be 0, return
D6A3: 8E BE 20    LDX   #p2_score            // otherwise we're player 2...
D6A6: 35 82       PULS  A,PC //(PUL? PC=RTS)

D6A8: 34 02       PSHS  A
D6AA: 20 F1       BRA   $D69D


//
// A = number to multiply random number with
//
// Returns: A = product of multiplication
//

MULTIPLY_A_BY_RANDOM_NUMBER:
D6AC: 34 04       PSHS  B
D6AE: 1F 89       TFR   A,B                    
D6B0: 8D 1B       BSR   $D6CD                // get random number in A
D6B2: 3D          MUL                        // D = A * B  
D6B3: 4C          INCA                       // to ensure A is nonzero
D6B4: 35 84       PULS  B,PC //(PUL? PC=RTS)


//
// Get a random number lower than or equal to the value in register A.
//

GET_RANDOM_NUMBER_LOWER_THAN_OR_EQUAL_TO_A:
D6B6: 34 02       PSHS  A                    // save a on stack
D6B8: 8D 13       BSR   $D6CD                // get a random number
D6BA: A1 E4       CMPA  ,S                   // compare random number to A to on stack
D6BC: 23 03       BLS   $D6C1                // if random number <= A on stack, goto $D6C1
D6BE: 44          LSRA                       // divide random number by 2  
D6BF: 20 F9       BRA   $D6BA                // repeat compare

D6C1: 4D          TSTA                       // check if A is 0  
D6C2: 26 01       BNE   $D6C5                // no
D6C4: 4C          INCA                       // otherwise, make A = 1
D6C5: 32 61       LEAS  $0001,S              // discard A on stack
D6C7: 39          RTS                        // return


GET_RANDOM_NUMBER_INTO_A_AND_B:
D6C8: 8D 03       BSR   $D6CD                // get a random number
D6CA: D6 86       LDB   $86
D6CC: 39          RTS   




//
// This routine initialises the object metadata lists 
//

INITIALISE_OBJECT_METADATA_LISTS:
D6EC: 34 56       PSHS  U,X,B,A
D6EE: 4F          CLRA  
D6EF: 5F          CLRB                      // make D = NULL

// initialise list used by enforcer, quark, spark and shell
D6F0: 8E A9 E0    LDX   #$A9E0
D6F3: CE 97 6F    LDU   #$976F
D6F6: 9F 13       STX   $13                 // set main object list pointer
D6F8: 30 0F       LEAX  $000F,X             // X+=#$0F (15 decimal)
D6FA: AF 11       STX   -$F,X               // store pointer to object at X in the previous object (X-15 decimal), establishing a forward only linked list
D6FC: 8C B0 D9    CMPX  #$B0D9
D6FF: 26 F7       BNE   $D6F8
D701: ED 84       STD   ,X                  // terminate list with NULL
D703: DD 11       STD   $11                 // set $9811 to be NULL

// initialise list used by progs & cruise missiles
D705: 8E B0 E8    LDX   #$B0E8
D708: 9F 1D       STX   $1D
D70A: 30 88 1F    LEAX  $1F,X               // X+= #$1F (31 decimal)
D70D: AF 88 E1    STX   -$1F,X
D710: 8C B3 35    CMPX  #$B335
D713: 26 F5       BNE   $D70A
D715: ED 84       STD   ,X                  // terminate list with NULL

// Initialise function call list
// D = 0 at this point
D717: 8E 98 11    LDX   #$9811              //
D71A: 9F 15       STX   $15
D71C: C6 07       LDB   #$07
D71E: 1F 01       TFR   D,X                 // X = B, as A is 0
D720: AB 84       ADDA  ,X
D722: 30 88 10    LEAX  $10,X               // X = X + #$10 (16 decimal)
D725: 8C 89 35    CMPX  #$8935
D728: 25 F6       BCS   $D720
D72A: A7 C9 01 84 STA   $0184,U
D72E: 35 D6       PULS  A,B,X,U,PC //(PUL? PC=RTS)

D730: BD D0 60    JSR   $D060               // JMP $D1FF - free all object metadata entries
D733: 86 FF       LDA   #$FF
D735: 97 59       STA   $59
D737: 86 01       LDA   #$01                // delay before calling function
D739: 8E D7 3F    LDX   #$D73F              // address of function to call  
D73C: 7E D0 66    JMP   $D066               // JMP $D1E3 - allocate function call



INITIALISE_ALL_OBJECT_LISTS:
D7A5: 34 17       PSHS  X,B,A,CC
D7A7: 1A FF       ORCC  #$FF
D7A9: 8E 99 00    LDX   #$9900               // set start of object linked list and store in $981B
D7AC: 9F 1B       STX   $1B
D7AE: 30 88 18    LEAX  $18,X                // add #$18 to X
D7B1: AF 88 E8    STX   -$18,X               // set *(X-#$18) to X - this is to establish a forward-only linked list
D7B4: 8C A9 C8    CMPX  #$A9C8
D7B7: 26 F5       BNE   $D7AE
D7B9: 4F          CLRA                       // set D to 0
D7BA: 5F          CLRB  
D7BB: ED 84       STD   ,X                   // mark end of list with two zeros
D7BD: DD 21       STD   $21                  // zero grunts_hulks_brains_progs_cruise_tanks
D7BF: DD 17       STD   $17                  // zero spheroids_enforcers_quarks_sparks_shells linked list pointer
D7C1: DD 19       STD   $19                  // 
D7C3: DD 23       STD   $23                  // zero electrodes linked list pointer
D7C5: DD 1F       STD   $1F                  // zero family linked list pointer
D7C7: 35 97       PULS  CC,A,B,X,PC //(PUL? PC=RTS)


//
// Checks for a collision between the main object (object ONE) and a list of other objects.
//
// D = blitter destination of object ONE.
// X = pointer to linked list of objects to check collision with object ONE. 
// U = animation frame metadata pointer of object ONE.
// $48 = 1 if its the player collision detection routine calling this function, 0 otherwise
//
// Returns: 
//
//


COLLISION_DETECTION_FUNCTION:
D7C9: DD 7C       STD   $7C                  // save blitter destination of object ONE to $7C
D7CB: E3 C4       ADDD  ,U                   // add in width and height of object ONE
D7CD: DD 7E       STD   $7E                  // store in $7E. Think of $7C, $7D, to $7E, $7F defining the rectangular area that object ONE occupies now.
D7CF: 20 17       BRA   $D7E8
// X = pointer to object OTHER - the object that *may* have collided with object ONE
D7D1: EC 04       LDD   $0004,X              // get blitter destination of object OTHER to compare against object ONEs boundaries            
D7D3: 27 13       BEQ   $D7E8                // if NULL, process next object

// perform rectangle intersection check.
// $7C,$7D = X and Y coordinates of top left of object ONE'S rectangle 
// $7E,$7F = X and Y coordinates of bottom right of object ONE'S rectangle 
// D = blitter destination of object OTHER 
D7D5: 91 7E       CMPA  $7E                  // compare A (the X component) to bottom right X coordinate of rectangle                                    
D7D7: 24 0F       BCC   $D7E8                // if A is >= this value then there is no intersection, goto $D7E8 
D7D9: D1 7F       CMPB  $7F                  // compare B (the Y component) to bottom right Y coordinate of rectangle
D7DB: 24 0B       BCC   $D7E8                // if B is >= this value then there is no intersection, goto $D7E8 
D7DD: E3 98 02    ADDD  [$02,X]              // D+= width & height of object being compared to object ONE
D7E0: 91 7C       CMPA  $7C                  // compare A to top left X coordinate of rectangle
D7E2: 23 04       BLS   $D7E8                // if A <= this value then there is no intersection, goto $D7E8
D7E4: D1 7D       CMPB  $7D                  // compare B to top left Y coordinate of rectangle
D7E6: 22 06       BHI   $D7EE                // if > then a possible collision

// if we get here, no collision has taken place, so get next object in the list, and try that
D7E8: AE 84       LDX   ,X                   // get next object in list
D7EA: 26 E5       BNE   $D7D1                // if object is not NULL, go to $D7D1
D7EC: 39          RTS                        // otherwise we're done

D7ED: Unused byte

// There might be a collision. We need to execute a collision detection check on a per-pixel level.
//
// At this point:
// U = animation frame metadata pointer of object ONE 
// D = blitter destination of object OTHER
// X = pointer to object OTHER
// $7C,$7D = X and Y coordinates of top left of rectangle of object ONE
// $7E,$7F = X and Y coordinates of bottom right of rectangle of object ONE 
D7EE: DF 82       STU   $82                 // store animation frame metadata pointer
D7F0: 0D 48       TST   $48                 // is it the player that's calling this function? (see $30B3)
D7F2: 26 06       BNE   $D7FA               // yes
D7F4: 10 AE 88 16 LDY   $16,X               // has collision detection animation frame metadata (a "collision mask") been supplied for this object?
D7F8: 26 03       BNE   $D7FD               // yes, so use the width and height in the metadata, goto $D7FD
D7FA: 10 AE 02    LDY   $0002,X             // get pointer to animation frame metadata of object OTHER
D7FD: A3 A4       SUBD  ,Y                  // subtract width & height of object OTHER from its blitter destination 
D7FF: 10 9F 2D    STY   $2D                 // store animation frame metadata pointer in $2D
D802: DD 2B       STD   $2B                 // store adjusted blitter destination to $2B 
D804: 4F          CLRA                      // D= 0    
D805: 5F          CLRB  
D806: DD 76       STD   $76                 // $76,$77 = 0
D808: DD 78       STD   $78                 // $78,$79 = 0
// at this point:
// U = animation frame metadata pointer of object ONE 
// X = pointer to object OTHER 
// Y = pointer to animation frame metadata of object OTHER
// $2B = adjusted (see $D7FD) blitter destination of object OTHER
// $2D = animation frame metadata pointer of object OTHER
// $7C,$7D = X and Y coordinate of top left of rectangle of object ONE
// $7E,$7F = X and Y coordinate of bottom right of rectangle of object ONE 
D80A: DC 2B       LDD   $2B                 // D = adjusted blitter destination of object OTHER (see $D7FD)                
D80C: D0 7D       SUBB  $7D                 // B (the Y component of blitter destination) -= top Y coordinate of object ONE, to give vertical distance in pixels
D80E: 22 05       BHI   $D815               // if no carry after subtraction and non-zero result, ie distance is a non zero positive number, goto $D815
D810: 50          NEGB                      // Make B a positive number 
D811: D7 77       STB   $77                 // $77 = vertical distance in pixels between object OTHER and object ONE
D813: 20 02       BRA   $D817
D815: D7 79       STB   $79                 // $79 = B

// now do horizontal axis
D817: 90 7C       SUBA  $7C                 // A (the X component of blitter destination) -= left X coordinate of object ONE, to give horizontal distance in pixels 
D819: 22 05       BHI   $D820               // if no carry after subtraction and non-zero result, ie distance is a non zero positive number, goto $D815
D81B: 40          NEGA                      // Make A a positive number 
D81C: 97 76       STA   $76                 // $76 = A
D81E: 20 02       BRA   $D822

D820: 97 78       STA   $78

D822: DC 2B       LDD   $2B                 // get adjusted blitter destination of object OTHER (see $D7FD) into D    
D824: E3 A4       ADDD  ,Y                  // and add width and height of image, which restores D back to the *real* blitter destination of object OTHER
D826: D0 7F       SUBB  $7F                 // B-= Y coordinate of bottom right of rectangle of object ONE
D828: 22 01       BHI   $D82B               // if result is a non-zero positive number, goto $D82B
D82A: 5F          CLRB                      // otherwise result is 0 or negative, so set B to 0
D82B: 90 7E       SUBA  $7E                 //  
D82D: 22 01       BHI   $D830               // if result is a non-zero positive number, goto $D82B
D82F: 4F          CLRA                      // otherwise result is 0 or negative, so set A to 0
D830: DD 80       STD   $80 
// at this point:
// U = animation frame metadata pointer of object ONE 
// X = pointer to object OTHER 
// Y = pointer to animation frame metadata of object OTHER
// $2B = adjusted (see $D7FD) blitter destination of object OTHER
// $2D = animation frame metadata pointer of object OTHER
D832: EC A4       LDD   ,Y                  // get width and height of object OTHER into D 
D834: 93 76       SUBD  $76                      
D836: 93 80       SUBD  $80
D838: DD 74       STD   $74
D83A: A6 C4       LDA   ,U                  // get width of object ONE                  
D83C: 97 7B       STA   $7B
D83E: D6 79       LDB   $79
D840: 3D          MUL   
D841: EE 42       LDU   $0002,U             // U now = pointer to very first 2 pixels of animation frame for object ONE 
D843: 33 CB       LEAU  D,U                 // U = U + D
D845: A6 A4       LDA   ,Y                 
D847: 97 7A       STA   $7A
D849: D6 77       LDB   $77
D84B: 3D          MUL   
D84C: 10 AE 22    LDY   $0002,Y             // Y = pointer to very first 2 pixels of animation frame for object OTHER
D84F: 31 AB       LEAY  D,Y                 // Y = Y + D
D851: 96 76       LDA   $76
D853: 31 A6       LEAY  A,Y                 // Y = Y + A
D855: 96 78       LDA   $78
D857: 33 C6       LEAU  A,U                 // U = U + A
D859: D6 74       LDB   $74
D85B: 5A          DECB  
D85C: A6 C5       LDA   B,U                 // read pixels at U + B                                  
D85E: 27 2C       BEQ   $D88C               // if 0 then consider these pixels as transparent, do not use in collision detection, goto $D88C 
D860: A6 A5       LDA   B,Y                 // read pixels at Y + B
D862: 27 28       BEQ   $D88C               // if 0 then consider these pixels as transparent, do not use in collision detection, goto $D88C  
D864: 31 A5       LEAY  B,Y                 // Y = Y + B 
D866: 1F 20       TFR   Y,D                 
D868: DE 2D       LDU   $2D                 // U - pointer to animation frame metadata of object OTHER
D86A: A3 42       SUBD  $0002,U
D86C: 10 AE 04    LDY   $0004,X             // Y = blitter destination of object OTHER
D86F: E0 C4       SUBB  ,U
D871: 82 00       SBCA  #$00
D873: 25 08       BCS   $D87D
D875: 31 21       LEAY  $0001,Y             // Y++ 
D877: E0 C4       SUBB  ,U
D879: 82 00       SBCA  #$00
D87B: 24 F8       BCC   $D875
D87D: EB C4       ADDB  ,U
D87F: 1F 98       TFR   B,A
D881: 5F          CLRB  
D882: 33 AB       LEAU  D,Y
D884: DF A6       STU   $A6                  // save screen address of pixel where collision occurred into $A6
D886: AD 98 08    JSR   [$08,X]              // call object X's collision handler 
D889: 86 01       LDA   #$01
D88B: 39          RTS   


// Updates the player score.
//
// Expects:
//
// A & B represent points to add to the score. I can't think of a better word than "represent" at the moment.
//
// B is a BCD number . A is the number of trailing zeros to put after the BCD number. 
// 
// Example, B=#$15 and A=3  means 15 with 3 trailing zeros = 15000 decimal to add to score.
//
// More examples:
// to add 100 to score, set a=1, b=#$10 
// to add 150 to score, set a=1, b=#$15
// to add 1000 to score, set a= 2, b = #$10 
// to add 1500 to score, set a= 2, b = #$15
// to add 10000 to score, set a = 3, b = #$10
// to add 100000 to score, set a = 4, b = #$10
// to add 150000 to score, set a = 4, b = #$15
//
// I'm sure you get the drift!!!
//
// returns: All registers same as on entry.
//
//

UPDATE_PLAYER_SCORE:
DB9C: 34 76       PSHS  U,Y,X,B,A
DB9E: 0C F0       INC   $F0

// As there are 2 numbers packed into a BCD encoded byte, divide A by 2.
// The result of this division is used to calculate an index to the first BCD number pair to update (see $DBB4).
// I will call the index the "r-index" later on.
DBA0: 44          LSRA                      // divide A bye 2 
DBA1: 34 02       PSHS  A                   // save r-index on stack. It will be used @ $DBB6
DBA3: 86 00       LDA   #$00                // Clear A.
DBA5: 24 08       BCC   $DBAF               // the r-index is an even number, goto $DBAF

// if we get here, then the "number of trailing zeroes" value passed in A on entry is an odd number. 
// Due to how 2 numbers are packed into a BCD byte, an odd number of trailing zeroes means the value in B can't be directly used to update the BCD 
// score byte at r-index without some massaging.
// So, we need to split the value in B up over 2 bytes...   

DBA7: 58          ASLB                      // shift 4 most significant bits of B into 4 least significant bits of A                        
DBA8: 49          ROLA                        
DBA9: 58          ASLB  
DBAA: 49          ROLA  
DBAB: 58          ASLB  
DBAC: 49          ROLA  
DBAD: 58          ASLB  
DBAE: 49          ROLA  

// Result of all the bit shifting:
//
// A = BCD value to add to score[r_index-1] 
// B = BCD value to add to score[r_index]//
// 

DBAF: BD D0 45    JSR   $D045               // JMP $D699 - get addr of current player game state into X. Now X = pointer to score
DBB2: DD 2B       STD   $2B

// $2B = BCD value to add to score[r_index-1]   
// $2C = BCD value to add to score[r_index]//

DBB4: C6 03       LDB   #$03                // B = index of last BCD digit pair in score (the tens part of the score, to be precise).
DBB6: E0 E0       SUBB  ,S+                 // subtract value on stack from B. B is now the "r-index", a zero-based index into the first digit to update. 
DBB8: A6 85       LDA   B,X                 // Read BCD digit pair from score[r_index]
DBBA: 9B 2C       ADDA  $2C                 // A +=  BCD points value to add 
DBBC: 19          DAA                       // Ensure result is valid BCD  
DBBD: A7 85       STA   B,X                 // update score digit pair at [r-index]
DBBF: 5A          DECB                      // bump index to point to next digit pair (going from tens, to thousands, to hundreds of thousands, to millions) 
DBC0: 2B 0E       BMI   $DBD0               // if b==-1 then we have just updated the millions score digits and there are no more digits we can do, goto $DBD0
DBC2: A6 85       LDA   B,X                 // A = *(X+B)
DBC4: 99 2B       ADCA  $2B                 // add in the BCD value to add to score [r_index-1]. Take into account any carry from last addition too.
DBC6: 19          DAA                       // and again, ensure that we have valid BCD digits. Carry flag will be set if carry over to next digit is required
DBC7: A7 85       STA   B,X                 // update score digit at (X+B)
DBC9: 86 00       LDA   #$00                // OK, we set the value to carry over to zero. So only the carry flag will be added to remaining digits
DBCB: 97 2B       STA   $2B                 // clear value to add 
DBCD: 5A          DECB                      // adjust index to point to previous score digit pair  
DBCE: 2A F2       BPL   $DBC2               // if b>=0 then we've got score digits left to update, goto $DBC2               

// this part of the code checks to see if we get a new life or not.
DBD0: DC 46       LDD   $46                 // read value of "bonus life every XYZ". See docs for $9846 and $9847 for info.
DBD2: 27 38       BEQ   $DC0C               // if 0, that means that earning bonus lives has been disabled, the arcade owner is money grabbing... goto $DC0C
DBD4: 31 04       LEAY  $0004,X             // Y = X + 4. Now Y points to p1_next_free_man (or if you're player 2, p2_next_free_man)   
DBD6: EC 84       LDD   ,X                  // read first 4 BCD digits of score 
DBD8: 10 A3 A4    CMPD  ,Y                  // compare to first 4 BCD digits of the score required to get a new life
DBDB: 26 05       BNE   $DBE2               // if not the same, goto $DBE2
DBDD: EC 02       LDD   $0002,X             // read last 4 BCD digits of score
DBDF: 10 A3 22    CMPD  $0002,Y             // compare to last 4 BCD digits of the score required to get a new life
DBE2: 25 28       BCS   $DC0C               // if lower, then you don't get a new life, sorry.. goto $DC0C

// If we get here, we are getting a bonus life. We need to calculate the score required to get the NEXT bonus life.
DBE4: A6 22       LDA   $0002,Y             // read the "thousands" part of the score required to get a bonus life - the score we just passed.
DBE6: 9B 47       ADDA  $47
DBE8: 19          DAA                       // ensure the result is valid BCD. Carry will be set or cleared if required   
DBE9: A7 22       STA   $0002,Y             // update the "thousands" part of the score required to get a bonus life. 
DBEB: A6 21       LDA   $0001,Y             // 
DBED: 99 46       ADCA  $46
DBEF: 19          DAA   
DBF0: A7 21       STA   $0001,Y
DBF2: A6 A4       LDA   ,Y
DBF4: 89 00       ADCA  #$00
DBF6: 19          DAA   
DBF7: A7 A4       STA   ,Y
DBF9: CC D0 C9    LDD   #$D0C9              // address of sound info
DBFC: BD D0 4B    JSR   $D04B               // JMP $D3C7 - play sound with priority
DBFF: BD D0 45    JSR   $D045               // JMP $D699 - get addr of current player game state into X
DC02: 6C 08       INC   $0008,X             // increment player lives
DC04: BD 26 C9    JSR   $26C9               // JMP $34E0 - draw player lives remaining
DC07: C6 05       LDB   #$05                // index to "extra men earned" entry in bookkeeping totals
DC09: BD D0 BD    JSR   $D0BD               // JMP $D655 - increment bookkeeping total by 1
DC0C: 8D 03       BSR   $DC11               // draw player score  
DC0E: 35 76       PULS  A,B,X,Y,U
DC10: 39          RTS   



//
// Interrupt handler
//
// Updates palette in game.
// Draws and updates spheroids, enforcers, sparks and player
//
//

DC56: B6 C8 0E    LDA   rom_pia_datab
DC59: 86 01       LDA   #$01
DC5B: 9A 45       ORA   $45              
DC5D: B7 C9 00    STA   rom_enable_scr_ctrl  // change rom access state
DC60: B6 CB 00    LDA   vidctrs              // read beam counter (raster vertical position)
DC63: 81 80       CMPA  #$80
DC65: 25 32       BCS   $DC99                // if beam counter < #$80 (128 decimal) goto $DC99
DC67: 96 43       LDA   $43
DC69: 26 20       BNE   $DC8B
DC6B: 0C 43       INC   $43
DC6D: 0C 10       INC   $10
DC6F: BD D3 E0    JSR   $D3E0                // play any sounds that need to be played
DC72: BD 26 C0    JSR   $26C0
DC75: B6 CB 00    LDA   vidctrs              // read beam counter (raster vertical position)
DC78: 7F CA 01    CLR   blitter_mask
DC7B: D6 45       LDB   $45
DC7D: C5 02       BITB  #$02
DC7F: 27 0C       BEQ   $DC8D
DC81: 8B 10       ADDA  #$10                 // add #$10 to the beam counter value in A
DC83: 97 41       STA   $41                  // and store in $9841
DC85: BD DC FF    JSR   $DCFF                // draw *and* move all spheroids, sparks, enforcers
DC88: BD DD 4E    JSR   $DD4E                // draw player (version 1) 
DC8B: 20 54       BRA   $DCE1                // restore rom access state and return from interrupt

DC8D: 80 10       SUBA  #$10                 // substract #$10 from the beam counter value in A
DC8F: 97 41       STA   $41                  // and store in $9841
DC91: BD DD 90    JSR   $DD90                // draw *and* move all objects (version 2)
DC94: BD DD 3E    JSR   $DD3E                // draw player (version 2)
DC97: 20 48       BRA   $DCE1                // restore rom access state and return from interrupt

DC99: D6 43       LDB   $43
DC9B: 27 44       BEQ   $DCE1
DC9D: 0F 43       CLR   $43
DC9F: 0C 10       INC   $10
DCA1: C6 39       LDB   #$39                 // ensure watchdog doesn't reset
DCA3: F7 CB FF    STB   watchdog            
DCA6: 81 04       CMPA  #$04
DCA8: 22 1B       BHI   $DCC5
DCAA: CE C0 10    LDU   #$C010               // end of palette 
DCAD: DC 0A       LDD   $0A
DCAF: 9E 0C       LDX   $0C
DCB1: 10 9E 0E    LDY   $0E
DCB4: 36 36       PSHU  Y,X,B,A             // set palette colours 15-10
DCB6: DC 04       LDD   $04
DCB8: 9E 06       LDX   $06
DCBA: 10 9E 08    LDY   $08
DCBD: 36 36       PSHU  Y,X,B,A             // set palette colours 9-4
DCBF: DC 00       LDD   $00
DCC1: 9E 02       LDX   $02
DCC3: 36 16       PSHU  X,B,A               // set palette colours 3-0
DCC5: 0C 44       INC   $44
DCC7: BD D4 4D    JSR   $D44D
DCCA: 7F CA 01    CLR   blitter_mask
DCCD: D6 45       LDB   $45                 // read rom state copy 
DCCF: C5 02       BITB  #$02
DCD1: 27 08       BEQ   $DCDB
DCD3: BD DC E7    JSR   $DCE7               // draw all spheroids, sparks, enforcers (but does not move objects) version 1
DCD6: BD DD 3E    JSR   $DD3E               // draw player    
DCD9: 20 06       BRA   $DCE1               // restore rom write state and return from interrupt

DCDB: BD DD 60    JSR   $DD60               // draw all spheroids, sparks, enforcers  (but does not move objects) version 2
DCDE: BD DD 4E    JSR   $DD4E               // draw player
DCE1: 96 45       LDA   $45
DCE3: B7 C9 00    STA   rom_enable_scr_ctrl
DCE6: 3B          RTI                       // return from interrupt   


//
// Not all objects
//
//

DRAW_ALL_SPHEROIDS_ENFORCERS_SPARKS_AND_TANK_SHELLS_BELOW_RASTER_BEAM:
DCE7: 96 59       LDA   $59
DCE9: 85 08       BITA  #$08
DCEB: 26 11       BNE   $DCFE
DCED: 9E 17       LDX   $17
DCEF: 27 0D       BEQ   $DCFE
DCF1: EC 04       LDD   $0004,X             // get blitter destination
DCF3: D1 41       CMPB  $41                 // compare to beam counter value
DCF5: 22 03       BHI   $DCFA
DCF7: BD DD CE    JSR   $DDCE               // erase then redraw object          
DCFA: AE 84       LDX   ,X
DCFC: 26 F3       BNE   $DCF1
DCFE: 39          RTS   




// This routine moves (that is to say, updates their X and Y coordinates) of all spheroids, enforcers, sparks and tank shells.
// In addition, it will draw them, but only if they have a Y coordinate *above* the current raster beam position.
// There's a near duplicate of this method at $DD90, the only difference with the other method is that it renders the baddies *below* the current raster beam position.
//
// This code's called from the interrupt routine, which is why these object types glide so smoothly.
//
// Thanks to Jim Bowley for seeing what I couldn't see in the enforcer movement routine. 
// Also thanks to Eugene Jarvis, Larry DeMar for confirming what Jim thought!! Yes, the men themselves (Eugene via Eugene's wife.) Thanks very much.
//
// I (Scott) will try to explain this in plain English for the casual readers who are interested.
// 
// You will notice in the code below references to $000E,X and $10,X.
// In an omnidirectional object like an enforcer or a spark, these fields are the horizontal and vertical movement deltas 
// (= values to be repeatedly added to X and Y coordinates of an object)
// Yes, you could say they are vectors, if that makes things clearer.
//
// The deltas are comprised of 16 bits.
// The most significant byte, bits 15..8, is the *signed* integer part of the delta. This can be zero. Bit 15 set means delta is negative.    
// The least significant byte, bits 7..0, is the FRACTIONAL part of the delta. Think of these as a fraction N/256.
//
// In this way you can represent a real number using a word value, as long as you are happy with the fractional part being in 1/256ths.
//
// Example:
// say you wanted to represent a delta of 0.5. You would set the most significant byte to 0, and least significant byte to #$80 (128 decimal, which is half of 256)
//
// the horizontal delta is added to the 16-bit current X coordinate of the object ($000A,X) and the result (including fractional part) is written back to $000A,X.
// If you add a negative delta to the X coordinate, the object will move left on the screen.
// If you add a positive delta to the X coordinate, the object will move right.
// 
// The vertical delta is added to the 16-bit current Y coordinate of the object ($000C,X) and the result (including fractional part) is written back to $000C,X.
// If you add a negative delta to the Y coordinate, the object will move up.
// If you add a positive delta to the Y coordinate, the object will move down.
//
// After the additions are done the system then takes only the *most significant bytes* of the X and Y coordinates - NOT the full 16 bits - and uses
// them to form a memory address for the blitter to write to, which is held in $0004,X. 
//
//

MOVE_ALL_SPHEROIDS_ENFORCERS_SPARKS_AND_DRAW_IF_ABOVE_RASTER_BEAM:
DCFF: 96 59       LDA   $59
DD01: 85 08       BITA  #$08
DD03: 26 72       BNE   $DD77
DD05: 9E 17       LDX   $17                 // get pointer to linked list of all spheroid, enforcer, spark objects into X
DD07: 27 34       BEQ   $DD3D               // if null, goto $DD3D
DD09: EC 0A       LDD   $000A,X             // get X coordinate into D
DD0B: EE 02       LDU   $0002,X             // get animation frame metadata pointer into U
DD0D: E3 0E       ADDD  $000E,X             // add X delta
DD0F: 81 07       CMPA  #$07                // at leftmost of playfield area?
DD11: 25 0A       BCS   $DD1D               // <7, so yes, invalid coordinate, do not update X coordinate and goto $DD1D
DD13: AB C4       ADDA  ,U                  // add width of animation frame (remember first byte of animation frame metadata is width)
DD15: 81 90       CMPA  #$90                // > #$90 (144 decimal) ?
DD17: 22 04       BHI   $DD1D               // yes, invalid coordinate, do not update X coordinate and goto $DD1D 
DD19: A0 C4       SUBA  ,U
DD1B: ED 0A       STD   $000A,X             // update X coordinate with D
// now do Y coordinate part
DD1D: EC 0C       LDD   $000C,X             // get Y coordinate into D. A = whole part, B = fractional part            
DD1F: E3 88 10    ADDD  $10,X               // add Y delta
DD22: 81 18       CMPA  #$18                // at topmost of playfield area? (#$18 = 24 decimal)
DD24: 25 0A       BCS   $DD30               // <#$18, so yes, invalid coordinate, do not update Y coordinate and goto $DD30
DD26: AB 41       ADDA  $0001,U             // add height of animation frame (second byte of animation frame metadata is height)
DD28: 81 EB       CMPA  #$EB                // at bottom-most of playfield area? (235 decimal)
DD2A: 22 04       BHI   $DD30               // if higher than #$EB then invalid coordinate, do not update Y coordinate and goto $DD30
DD2C: A0 41       SUBA  $0001,U
DD2E: ED 0C       STD   $000C,X             // update Y coordinate with D
DD30: EC 04       LDD   $0004,X             // get blitter destination into D
DD32: D1 41       CMPB  $41                 // "if vertical part of blitter destination is <= beam counter variable, do not draw object""
DD34: 23 03       BLS   $DD39
DD36: BD DD CE    JSR   $DDCE               // erase then redraw object          
DD39: AE 84       LDX   ,X                  // get pointer to next object
DD3B: 26 CC       BNE   $DD09               // if not null goto $DD09
DD3D: 39          RTS   



DRAW_PLAYER_IF_ABOVE_RASTER_BEAM:
DD3E: 96 59       LDA   $59
DD40: 85 10       BITA  #$10
DD42: 26 09       BNE   $DD4D
DD44: 8E 98 5A    LDX   #$985A              // player_object_start
DD47: DC 5E       LDD   $5E                 // player blitter destination
DD49: D1 41       CMPB  $41                 // compare to beam counter vertical value
DD4B: 23 11       BLS   $DD5E               // draw player
DD4D: 39          RTS   


DRAW_PLAYER_IF_BELOW_RASTER_BEAM:
DD4E: 96 59       LDA   $59
DD50: 85 10       BITA  #$10
DD52: 26 F9       BNE   $DD4D
DD54: 8E 98 5A    LDX   #$985A              // player_object_start
DD57: DC 5E       LDD   $5E                 // player blitter destination
DD59: D1 41       CMPB  $41                 // compare to beam counter vertical value
DD5B: 22 71       BHI   $DDCE               // erase then redraw object          
DD5D: 39          RTS   

DD5E: 20 6E       BRA   $DDCE               // erase then redraw object          



DRAW_ALL_SPHEROIDS_ENFORCERS_SPARKS_AND_TANK_SHELLS_ABOVE_RASTER_BEAM:
DD60: 96 59       LDA   $59
DD62: 85 08       BITA  #$08
DD64: 26 10       BNE   $DD76
DD66: 9E 17       LDX   $17
DD68: 27 0C       BEQ   $DD76
DD6A: EC 04       LDD   $0004,X
DD6C: D1 41       CMPB  $41                 // compare to beam counter vertical value
DD6E: 23 02       BLS   $DD72
DD70: 8D 5C       BSR   $DDCE               // erase then redraw object           
DD72: AE 84       LDX   ,X
DD74: 26 F4       BNE   $DD6A
DD76: 39          RTS   



DRAW_ALL_SPHEROIDS_ENFORCERS_SPARKS_AND_TANK_SHELLS:
DD77: 96 59       LDA   $59
DD79: 85 02       BITA  #$02
DD7B: 26 12       BNE   $DD8F
DD7D: 96 44       LDA   $44
DD7F: 84 07       ANDA  #$07
DD81: 26 0C       BNE   $DD8F
DD83: 9E 17       LDX   $17
DD85: 27 08       BEQ   $DD8F
DD87: EC 04       LDD   $0004,X
DD89: 8D 43       BSR   $DDCE               // erase then redraw object          
DD8B: AE 84       LDX   ,X
DD8D: 26 F8       BNE   $DD87
DD8F: 39          RTS   


// This routine is pretty much a copy of $DCFF - with one difference. The baddies will only be rendered
// if they are *below* the current raster beam position.
//
//

MOVE_ALL_SPHEROIDS_ENFORCERS_SPARKS_AND_DRAW_IF_BELOW_RASTER_BEAM:
DD90: 96 59       LDA   $59
DD92: 85 08       BITA  #$08
DD94: 26 E1       BNE   $DD77
DD96: 9E 17       LDX   $17                 // get pointer to all spheroids, enforcers, sparks into X
DD98: 27 33       BEQ   $DDCD               // if null, goto $DDCD
DD9A: EC 0A       LDD   $000A,X             // get X coordinate into D
DD9C: EE 02       LDU   $0002,X             // get animation frame metadata pointer into U
DD9E: E3 0E       ADDD  $000E,X             // add X delta
DDA0: 81 07       CMPA  #$07                // at leftmost of playfield area?
DDA2: 25 0A       BCS   $DDAE               // <7, so yes, invalid coordinate, do not update X coordinate and goto $DDAE
DDA4: AB C4       ADDA  ,U                  // add width of animation frame (remember first byte of animation frame metadata is width)
DDA6: 81 90       CMPA  #$90                // > #$90 (144 decimal) ?
DDA8: 22 04       BHI   $DDAE               // yes, invalid coordinate, do not update X coordinate and goto $DDAE
DDAA: A0 C4       SUBA  ,U
DDAC: ED 0A       STD   $000A,X             // update X coordinate with D
// now do Y coordinate part
DDAE: EC 0C       LDD   $000C,X             // get Y coordinate into D 
DDB0: E3 88 10    ADDD  $10,X               // add Y delta
DDB3: 81 18       CMPA  #$18                // at topmost of playfield area? (#$18 = 24 decimal)
DDB5: 25 0A       BCS   $DDC1               // <#$18, so yes, invalid coordinate, do not update Y coordinate and goto $DDC1             
DDB7: AB 41       ADDA  $0001,U             // add height of animation frame (second byte of animation frame metadata is height)
DDB9: 81 EB       CMPA  #$EB                // at bottom-most of playfield area? (235 decimal)
DDBB: 22 04       BHI   $DDC1               // if higher than #$EB then invalid coordinate, do not update Y coordinate and goto $DD30
DDBD: A0 41       SUBA  $0001,U
DDBF: ED 0C       STD   $000C,X             // update Y coordinate with D
DDC1: EC 04       LDD   $0004,X             // get blitter destination into D
DDC3: D1 41       CMPB  $41                 // "if vertical part of blitter destination is > beam counter variable, do not draw object""
DDC5: 22 02       BHI   $DDC9
DDC7: 8D 05       BSR   $DDCE               // erase then redraw object          
DDC9: AE 84       LDX   ,X                  // get pointer to next object
DDCB: 26 CD       BNE   $DD9A               // if not null goto $DD9A
DDCD: 39          RTS   




//
// Tests for pixels within a rectangle.
// This function is called to ensure it's "safe" to place an object at a given position.
//
// For example, at $38DC the grunt initialisation routine calls this function to ensure that no grunts are placed
// directly on top of electrodes that would kill them instantly. See also $393C
//
// A = width of rectangle
// B = height of rectangle
// U = screen position representing top left of rectangle
//
// Returns: Z flag is zero if no pixels detected in rectangle


TEST_FOR_PIXELS_WITHIN_RECTANGLE:
DE0F: 34 56       PSHS  U,X,B,A
DE11: 8E DA 05    LDX   #$DA05
DE14: 34 06       PSHS  B,A                  // save height and width on the stack
DE16: C6 FE       LDB   #$FE
DE18: D4 45       ANDB  $45
DE1A: D7 45       STB   $45
DE1C: F7 C9 00    STB   rom_enable_scr_ctrl  // turn off ROM to allow reads from screen RAM
DE1F: 5F          CLRB  
DE20: 6A 61       DEC   $0001,S              // decrement height (B) by 1 on the stack
DE22: A6 61       LDA   $0001,S              // get adjusted height into A
DE24: EA C6       ORB   A,U                  // B = B | *(U+A)   - basically get values of pixels and OR them into B
DE26: 4A          DECA                       // decrement height counter         
DE27: 2A FB       BPL   $DE24                // if a>=0 goto $DE24

// At this point B holds a value which if non-zero means there are some pixels 
DE29: 86 37       LDA   #$37
DE2B: 33 C9 01 00 LEAU  $0100,U              // bump U to point to next pixel to the right of previous
DE2F: 6A E4       DEC   ,S                   // decrement width counter
DE31: 26 EF       BNE   $DE22                // if width counter !=0 then goto DE22

// at this point B is either non-zero (meaning some pixels were found) or zero (meaning no pixels were found)
// this looks to me like security code, to make the game behave unpredictably.
DE33: A1 89 BE EE CMPA  -$4112,X             // compare A to *$98EE 
DE37: 27 12       BEQ   $DE4B
DE39: 96 86       LDA   $86                  // read a random number
DE3B: 81 01       CMPA  #$01                 // is number > 1 ? 
DE3D: 22 0C       BHI   $DE4B                // if higher than 1 goto $DE4B (normal service is resumed)

// haha, looks like this piece of code is trying to corrupt some fields in the object state!!! 
DE3F: 34 04       PSHS  B
DE41: D6 85       LDB   $85                   
DE43: 86 98       LDA   #$98                 // to form address #$98xx where B register = xx
DE45: 1F 01       TFR   D,X
DE47: 6A 84       DEC   ,X                   // ouch! change the value in *X - who knows what this will break?
DE49: 35 04       PULS  B
DE4B: 86 01       LDA   #$01                 // enable ROM again
DE4D: 9A 45       ORA   $45
DE4F: 97 45       STA   $45
DE51: B7 C9 00    STA   rom_enable_scr_ctrl
DE54: 5D          TSTB                       // set zero flag according to B. if B is non zero (meaning, there are pixels found) then Z flag = 0   
DE55: 32 62       LEAS  $0002,S              // discard B and A pushed on stack at $DE14
DE57: 35 D6       PULS  A,B,X,U,PC //(PUL? PC=RTS)









//
// Read 2 bytes from X and return a BCD number. 1 byte per BCD digit: tens first, units second. 
//
// Each digit read from X is clamped (limited) to 9. This function always returns a valid BCD number.
//
// Expects:
// X = pointer to 2 bytes. 
// Byte 0: number from 0 .. #$0F (15 decimal)
// Byte 1: number from 0 .. #$0F (15 decimal)
//
// Returns: A is a valid BCD value
//          X is 2 more than on entry
//

CLAMP_BCD_VALUE_AT_X:
FBA2: 34 04       PSHS  B
FBA4: BD D0 A2    JSR   PACK_2_BYTES_INTO_A1           // read first 2 bytes from X and pack them into A
FBA7: 1F 89       TFR   A,B                            // B = A. A is going to be used to sanity check the low nibble, and B is for high nibble                             
FBA9: 84 0F       ANDA  #$0F                           // mask in lower nibble of A, mask out high hibble  
FBAB: 81 09       CMPA  #$09                           // is value in A <= 9? 
FBAD: 23 02       BLS   $FBB1                          // yes, we have valid BCD for the lower nibble, goto $FBB1
FBAF: 86 09       LDA   #$09                           // clamp A to 9
// now sanity check the upper nibble
FBB1: C4 F0       ANDB  #$F0                           // mask in high nibble and mask out low nibble
FBB3: C1 90       CMPB  #$90                           // is first digit of BCD value in B <= 9?
FBB5: 23 02       BLS   $FBB9                          // yes, we have valid BCD for the high nibble, goto $FBB9
FBB7: C6 90       LDB   #$90                           // clamp high nibble to 9
FBB9: 34 04       PSHS  B                              // save high nibble on stack
FBBB: AA E0       ORA   ,S+                            // and OR it with the low nibble. A is now a valid BCD number
FBBD: 35 84       PULS  B,PC //(PUL? PC=RTS)


// 
//
// X = pointer to 6 bytes where low nibble of each byte is a number from 0-9. Represents a number to be divided.  
//
// Y = pointer to 6 bytes where low nibble of each byte is a number from 0-9. Represents the divisor.
//

DIVIDE_X_BY_Y:
FBBF: 34 76       PSHS  U,Y,X,B,A
FBC1: CC 00 00    LDD   #$0000               
FBC4: FD B4 18    STD   $B418                // $B418 & B419 = 0
FBC7: FD B4 1A    STD   $B41A                // $B41A & B41B = 0
FBCA: 8D D6       BSR   $FBA2                // Read 2 bytes from X, convert to BCD and store in A 
FBCC: B7 B4 06    STA   $B406                // store first 2 digits of number to be divided as BCD in $B406
FBCF: 8D D1       BSR   $FBA2                // Read 2 bytes from X, convert to BCD and store in A          
FBD1: B7 B4 07    STA   $B407                // store next 2 digits of number to be divided as BCD in $B407
FBD4: 8D CC       BSR   $FBA2                // Read 2 bytes from X, convert to BCD and store in A  
FBD6: B7 B4 08    STA   $B408                // store last 2 digits of number to be divided as BCD in $B408
FBD9: CC 00 00    LDD   #$0000
FBDC: B7 B4 09    STA   $B409                // $B409 = 0
FBDF: FD B4 0A    STD   $B40A                // $B40A & B40B = 0
FBE2: B7 B4 15    STA   $B415                // $B415 = 0
FBE5: FD B4 16    STD   $B416                // $B416 & B417 = 0
FBE8: 1F 21       TFR   Y,X
FBEA: BD FB A2    JSR   $FBA2                // Read 2 bytes from X, convert to BCD and store in A 
FBED: B7 B4 12    STA   $B412                // store first 2 digits of divisor as BCD in $B412
FBF0: BD FB A2    JSR   $FBA2                // Read 2 bytes from X, convert to BCD and store in A 
FBF3: B7 B4 13    STA   $B413                // store next 2 digits of divisor as BCD in $B413
FBF6: BD FB A2    JSR   $FBA2                // Read 2 bytes from X, convert to BCD and store in A   
FBF9: B7 B4 14    STA   $B414                // store last 2 digits of divisor as BCD in $B413
FBFC: 26 05       BNE   $FC03                // if last 2 digits are nonzero, goto $FC03
// if we get here, then we need to check first 4 digits of divisor and see if they are zero.
// this will prevent us from trying to divide by zero.
FBFE: FC B4 12    LDD   $B412                // read first 2 BCD digits of divisor  
FC01: 27 3A       BEQ   $FC3D                // if 0, then we can't divide, so exit routine   

FC03: CE B4 1A    LDU   #$B41A
FC06: 7D B4 12    TST   $B412                // read first 2 digits of divisor
FC09: 26 12       BNE   $FC1D                // if 0, goto $FC1D 
FC0B: 33 5F       LEAU  $-1,U

// Copy contents of $B413 - $B418 to $B412 - $B417 (basically shift bytes one along!)
FC0D: C6 05       LDB   #$05
FC0F: 8E B4 12    LDX   #$B412               // X points to BCD packed byte containing first 2 digits of divisor
FC12: A6 01       LDA   $0001,X                            
FC14: A7 80       STA   ,X+                 
FC16: 5A          DECB  
FC17: 26 F9       BNE   $FC12
FC19: 6F 84       CLR   ,X                   // clear byte at end
FC1B: 20 E9       BRA   $FC06

FC1D: 8E B4 06    LDX   #$B406               // X points to BCD packed byte containing first 2 digits of number to be divided
FC20: 8D 1D       BSR   $FC3F
FC22: 24 FC       BCC   $FC20
FC24: 10 8E B4 17 LDY   #$B417
FC28: C6 05       LDB   #$05
FC2A: A6 3F       LDA   $-1,Y
FC2C: A7 A4       STA   ,Y
FC2E: 31 3F       LEAY  $-1,Y
FC30: 5A          DECB  
FC31: 26 F7       BNE   $FC2A
FC33: 6F A4       CLR   ,Y
FC35: 33 41       LEAU  $0001,U
FC37: 11 83 B4 1B CMPU  #$B41B
FC3B: 23 E3       BLS   $FC20
FC3D: 35 F6       PULS  A,B,X,Y,U,PC //(PUL? PC=RTS)

//
// X = pointer to BCD packed byte from number to be divided
// 
FC3F: 10 8E B4 12 LDY   #$B412               // Y points to BCD packed byte containing first 2 digits of divisor
FC43: 86 00       LDA   #$00
FC45: E6 86       LDB   A,X                  // read BCD byte from number to be divided                  
FC47: E0 A0       SUBB  ,Y+                  // subtract BCD byte from divisor
FC49: 22 07       BHI   $FC52                // if no carry or zero result, goto $FC52
FC4B: 25 40       BCS   $FC8D                // if there was a carry, set carry flag (again!) and exit
FC4D: 4C          INCA                       
FC4E: 81 06       CMPA  #$06
FC50: 25 F3       BCS   $FC45

FC52: C6 06       LDB   #$06
FC54: 10 8E B4 0C LDY   #$B40C
FC58: 86 99       LDA   #$99
FC5A: A0 26       SUBA  $0006,Y           
FC5C: A7 A0       STA   ,Y+                  // update digits in divisor
FC5E: 5A          DECB  
FC5F: 26 F7       BNE   $FC58
FC61: C6 06       LDB   #$06
FC63: 1C FE       ANDCC #$FE                 // clear carry flag
FC65: 86 01       LDA   #$01
FC67: A9 A2       ADCA  ,-Y
FC69: 19          DAA   
FC6A: A7 A4       STA   ,Y
FC6C: 86 00       LDA   #$00
FC6E: 5A          DECB  
FC6F: 26 F6       BNE   $FC67
FC71: C6 05       LDB   #$05
FC73: 10 8E B4 12 LDY   #$B412              // Y points to BCD packed byte containing first 2 digits of divisor
FC77: 1C FE       ANDCC #$FE                // clear carry flag
FC79: A6 A2       LDA   ,-Y
FC7B: A9 85       ADCA  B,X
FC7D: 19          DAA   
FC7E: A7 85       STA   B,X
FC80: 5A          DECB  
FC81: 2A F6       BPL   $FC79
FC83: A6 C4       LDA   ,U
FC85: 8B 01       ADDA  #$01
FC87: 19          DAA   
FC88: A7 C4       STA   ,U
FC8A: 1C FE       ANDCC #$FE                // clear carry flag 
FC8C: 39          RTS   

FC8D: 1A 01       ORCC  #$01                // set carry flag
FC8F: 39          RTS   



FC90: BD D0 12    JSR   CLR_SCREEN1
FC93: CC FE 01    LDD   #$FE01
FC96: ED 47       STD   $0007,U
FC98: 39          RTS   


