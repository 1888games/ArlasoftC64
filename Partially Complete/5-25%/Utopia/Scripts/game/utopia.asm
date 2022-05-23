
//  MOB allocation:
//                              MOB data ptr:
//      0, 1    Weather         $31D,   $325
//      2, 3    Player 0, 1     $32D,   $335
//      4, 5    Pirates         $33D,   $345
//      6, 7    Fish            $34D,   $355


//  Item numbers used in game are identical to their keypad numbering.
//  These numbers get used many places.
//
//      1   Fort            4   School          7   Rebel
//      2   Factory         5   Hospital        8   PT boat
//      3   Crop            6   House           9   Fishing boat


SCOR_0      EQU     $15D        // Player 0 score -- two bytes
SCOR_1      EQU     $15F        // Player 1 score -- two bytes

RSCO_0      EQU     $161        // Player 0 round score -- one byte
RSCO_1      EQU     $162        // Player 1 round score -- one byte

PRSC_0      EQU     $163        // Player 0 prev round score -- one byte
PRSC_1      EQU     $164        // Player 0 prev round score -- one byte

POPU_0      EQU     $165        // Population for player 0 (two bytes)
POPU_1      EQU     $167        // Population for player 1 (two bytes)

RGLD_0      EQU     $169        // Gold acquired by player 0 this round
RGLD_1      EQU     $16A        // Gold acquired by player 1 this round

GOLD_0      EQU     $16B        // Current gold for player 0 (two bytes)
GOLD_1      EQU     $16D        // Current gold for player 1 (two bytes)


//  The next 9 pairs of variables are indexed as follows:
//
//      $16D + item_type*2 + player.  Item types range from 1 .. 9  (?)
//
//  The count for # rebels doesn't appear to be used.
//  The count for PT boats isn't accurately maintained and never consulted.
//
FORT_0      EQU     $16F        // Number of forts for player 0
FORT_1      EQU     $170        // Number of forts for player 1
FTRY_0      EQU     $171        // Number of factories for player 0
FTRY_1      EQU     $172        // Number of factories for player 1
CROP_0      EQU     $173        // Number of crops for player 0
CROP_1      EQU     $174        // Number of crops for player 1
SCHL_0      EQU     $175        // Number of schools for player 0
SCHL_1      EQU     $176        // Number of schools for player 1
HOSP_0      EQU     $177        // Number of hospitals for player 0
HOSP_1      EQU     $178        // Number of hospitals for player 1
HOUS_0      EQU     $179        // Number of houses for player 0
HOUS_1      EQU     $17A        // Number of houses for player 1
REBL_0      EQU     $17B        // Number of rebels for player 0 \_ Not so?
REBL_1      EQU     $17C        // Number of rebels for player 1 /
PTBO_0      EQU     $17D        // Number of PT boats for player 0
PTBO_1      EQU     $17E        // Number of PT boats for player 1
F_BO_0      EQU     $17F        // Number of Fishing boats for player 0
F_BO_1      EQU     $180        // Number of Fishing boats for player 1

// These get reused when scoring each player. 
H_SCOR      EQU     $181        // Housing score 
G_SCOR      EQU     $182        // GDP score 
F_SCOR      EQU     $183        // Food score
N_FTRY      EQU     $184        // Number of factories 

RBLTRY      EQU     $185        // Counter:  Try placing rebel up to 250 times
RBLTYP      EQU     $186        // Mercernary or computer gen'd rebel?

CURPLR      EQU     $187        // Player currently being processed / scored
CURSEL      EQU     $188        // Current selection being processed

SLCT_0      EQU     $189        // Current input selection for player 0
SLCT_1      EQU     $18A        // Current input selection for player 1

BARINH      EQU     $18B        // Inhibit gold-bar display if non-zero
TICSEC      EQU     $18C        // tic number within second (0..19)
REMSEC      EQU     $18D        // remaining seconds this round
CURTRN      EQU     $18E        // current turn number

NUMTRN      EQU     $18F        // Number of turns in the game
TRNLEN      EQU     $190        // Length of each turn in seconds
TICINH      EQU     $191        // Flag to inhibit timer-tick task

SC_TOT      EQU     $192        // Flag:  Display SCORES or TOTALS

FISH_0      EQU     $193        // Fishing time counter for player 0
FISH_1      EQU     $194        // Fishing time counter for player 1

SNKFRM      EQU     $197        // Animation frame # of sinking ship animation
SNK_AT      EQU     $198        // Offset into BACKTAB of sinking ship
SNKACT      EQU     $199        // Is a "sinking ship" animation active?
SNKCNT      EQU     $19A        // Frame-to-frame delay counter for animation

// Cursor modes: 0 = rectangle, 8 = PT Boat, 9 = Fishing boat
CURS_0      EQU     $19B        // Cursor mode for player 0
CURS_1      EQU     $19C        // Cursor mode for player 1

TDMG_0      EQU     $19D        // Total weather damage accumulated for plyr 0
TDMG_1      EQU     $19E        // Total weather damage accumulated for plyr 1
DMG_RT      EQU     $19F        // Damage rate for a particular storm

RCRP_0      EQU     $1A0        // Rain on crop counter for player 0
RCRP_1      EQU     $1A1        // Rain on crop counter for player 1

CKAXIS      EQU     $1A3        // Current axis for island/boat coll detection
SHPLOC      EQU     $1A4        // Offset into BACKTAB that a boat overlaps

        ORG     $5000
.HEADER:
        BIDECLE .GFX_ANIM_5D1A  // 5000  Ptr: MOB graphic images
        BIDECLE .TIMER          // 5002  Ptr: EXEC timer table
        BIDECLE .START          // 5004  Ptr: Start of game
        BIDECLE .GFX_LIST_5E4A  // 5006  Ptr: Backgnd gfx list
        BIDECLE .GRAM_INIT_5024 // 5008  Ptr: GRAM init sequence
        BIDECLE .TITLE          // 500A  Ptr: Date/Title
        DECLE   $007E           // 500C  Key-click / flags
        DECLE   $0000           // 500D  Border extension
        DECLE   $0000           // 500E  Color Stack / FGBG
        DECLE   $0001,  $0003   // 500F  Color Stack init (0, 1)
        DECLE   $0001,  $0003   // 5011  Color Stack init (2, 3)
        DECLE   $0001           // 5013  Border color init

        // Allocation of MOBs to GRAM slots
        DECLE   $01F0,  $01E0,  $01D0,  $01C0   // 5014   01F0 01E0 01D0 01C0
        DECLE   $01B0,  $01A0,  $0190,  $0180   // 5018   01B0 01A0 0190 0180

.TIMER: BIDECLE TICTSK          // 501C  TICTSK = 51A3
        DECLE   $0001,  $0000   // 501E  Timer interval
        BIDECLE $0000           // 5020  End of timer table

        DECLE   $0000,  $0000                   // 5022   0000 0000
.GRAM_INIT_5024:
        DECLE   $0021           // 5024  # of GRAM cards to init
        DECLE   $0001,  $0380   // 5025  #00-07:  CART #00-07 ----
        DECLE   $0011,  $0380   // 5027  #08-0F:  CART #08-0F ----
        DECLE   $0021,  $0380   // 5029  #10-17:  CART #10-17 ----
        DECLE   $0031,  $0380   // 502B  #18-1F:  CART #18-1F ----
        DECLE   $0040           // 502D  #20   :  CART #20    ----

.TITLE: DECLE   81                              // 502E  Cartridge year
        STRING  "UTOPIA", 0                     // 502F  Title string

        STRING  "CPY@'81MATTEL"

        // Clear the display (zero $200 - $2EF)
CLRSCR:
L_5043: PSHR    R5                  // 5043  \
        MVII    #$0200, R4          // 5044   |  Clear the screen
        MVII    #$00F0, R0          // 5046   |- by writing 0 to
        JSR     R5, X_FILL_ZERO     // 5048   |  $200 - $2EF
        PULR    R7                  // 504B  /   

.START: PSHR    R5                  // 504C  Push return addr
        MVO     R7, TICINH          // 504D  Disable timer task
                                    
L_504F: JSR     R5, CLRSCR          // 504F  Clear the screen

        CLRR    R3                  // 5052  \
        MVII    #$0229, R4          // 5053   |_ Prompt for # of turns
        JSR     R5, X_PRINT_R5      // 5055   |
        STRING  "TERM OF OFFICE:",0 // 5058  /

        // Get number of turns from keypad
        MVII    #$0002, R0          // 5068  \
        MVII    #$025A, R1          // 506A   |
        CLRR    R2                  // 506C   |_ Get input via keypad
        SDBD                        // 506D   |
        MVII    #INPUT_DISP, R4     // 506E   |
        JSR     R5,     X_GET_NUM1  // 5071  / 

        CMPI    #$0032, R0          // 5074  \
        BGT     L_507C              // 5076   |_ Must be 1 to 50 inclusive
        CMPI    #$0000, R0          // 5078   |
        BGT     L_5081              // 507A  /

L_507C: JSR     R5, X_PLAY_RAZZ2    // 507C  Out of range:  RAZZ!
        B       L_504F              // 507F  Start over.

L_5081: MVO     R0,     NUMTRN      // 5081  Save number of turns

L_5083: MVII    #$0278, R4          // 5083  \
        MVII    #$0078, R0          // 5085   |- Clear bottom half of screen
        JSR     R5, X_FILL_ZERO     // 5087  /

        CLRR    R3                  // 508A  \
        MVII    #$0279, R4          // 508B   |_ Prompt for turn length
        JSR     R5, X_PRINT_R5      // 508D   |
        STRING  "TURN LENGTH:", 0   // 5090  /

        // Get turn length from keypad
        MVII    #$0003, R0          // 509D  \
        MVII    #$02AA, R1          // 509F   |
        CLRR    R2                  // 50A1   |_ Read turn length from keypad
        SDBD                        // 50A2   |
        MVII    #INPUT_DISP, R4     // 50A3   |
        JSR     R5, X_GET_NUM1      // 50A6  /

        // Allow turn lengths from 30 to 120.
        CMPI    #$0078, R0          // 50A9  \_ Too long?
        BLE     L_50B2              // 50AB  /

L_50AD: JSR     R5, X_PLAY_RAZZ2    // 50AD  \_ RAZZ and repeat
        B       L_5083              // 50B0  /

L_50B2: CMPI    #$001E, R0          // 50B2  \_ Too short?
        BLT     L_50AD              // 50B4  /

        MVO     R0,     TRNLEN      // 50B6  Save turn length

        CLRR    R1                  // 50B8  \_ Enable timer task to run
        MVO     R1,     TICINH      // 50B9  /
        B       L_50C1              // 50BB  Initialize game

//--------------------
        // Allow both controllers to make numeric input by forcing them
        // both to player 0... ?
KEYPAD_FORCE_0:
        CLRR    R1                  // 50BD  
        J       X_INPUT_DIGIT       // 50BE  
//--------------------

L_50C1:
        JSR     R5,     CLRSCR      // 50C1  Wipe the screen

        MVII    #$032D, R2          // 50C4  \
        SDBD                        // 50C6   |
        MVII    #PLY0_MOB_INIT, R1  // 50C7   |- Initialize cursors for
        MVII    #$0002, R0          // 50CA   |  both players
        JSR     R5, X_INIT_MOBS     // 50CC  /

        // ---------------------------------------------------------------- //
        //  Unpack the display (both islands)
        //
        //  The offset table holds a list of display offsets to place 
        //  cards at on the display.  The picture table holds the list of
        //  GRAM card numbers to place at those offsets.
        //
        //  For the left island, display cards have bit 14 set equal to 1.
        //  For the right island, display cards have bit 14 set equal to 0.
        // ---------------------------------------------------------------- //
        SDBD                            // 50CF  \
        MVII    #LFT_ISLE_OFS_TBL, R1   // 50D0   |_ Set up pointers to 
        SDBD                            // 50D3   |  offset and picture tables
        MVII    #LFT_ISLE_PIC_TBL, R4   // 50D4  /

L_50D7: MVI@    R1,     R2              // 50D7  Get next offset
        ADDI    #$0200, R2              // 50D8  Turn into display pointer

        // Setup up format word based on whether we're on left or right isle
        SDBD                            // 50DA
        CMPI    #RGT_ISLE_OFS_TBL, R1   // 50DB  \_ Are we on right island?
        BGE     L_50E6                  // 50DE  /  

        SDBD                            // 50E0  \_ No:  Set bit 14.
        MVII    #$4803, R0              // 50E1  /  Otherwise -- GRAM + tan
        B       L_50EA                  // 50E4  

L_50E6: SDBD                            // 50E6  \_ Yes:  Clear bit 14
        MVII    #$0803, R0              // 50E7  /  Otherwise -- GRAM + tan

L_50EA: JSR     R5,     DISP_ISLE_CARD  // 50EA  Display GRAM card

        SDBD                            // 50ED  \
        CMPI    #LFT_ISLE_PIC_TBL, R1   // 50EE   |- Loop until we reach
        BNEQ    L_50D7                  // 50F1  /   end of the table

        // ---------------------------------------------------------------- //
        //  Game State Initialization:
        //
        //   -- Set up controller dispatch
        //   -- Set population to 1000
        //   -- Initialize the turn length
        //   -- Set gold bars to 100
        // ---------------------------------------------------------------- //

        // Set up controller dispatch table
        SDBD                            // 50F3 
        MVII    #CTRL_DISPATCH_TBL, R0  // 50F4 
        MVO     R0,     G_035D          // 50F7 

        // Initialize population for both players
        MVII    #$03E8, R0              // 50F9  Initial population = 1000
        MVO     R0,     POPU_0          // 50FB  \
        SWAP    R0,     1               // 50FD   |- Write out player 0's pop
        MVO     R0,     POPU_0 + 1      // 50FE  / 
        SWAP    R0,     1               // 5100   
        MVO     R0,     POPU_1          // 5101  \
        SWAP    R0,     1               // 5103   |- Write out player 1's pop
        MVO     R0,     POPU_1 + 1      // 5104  /

        // Initialize the turn length
        MVI     TRNLEN, R1              // 5106  
        MVO     R1,     REMSEC          // 5108  

        JSR     R5,     STAT_UPD_TIME   // 510A  Display time in status line

        // Initialize gold bars for each player. (two bytes each)
        MVII    #$0064, R0              // 510D  
        MVO     R0,     GOLD_0          // 510F  
        MVO     R0,     GOLD_1          // 5111  

        JSR     R5,     STAT_UPD_GOLD   // 5113  Display gold in status line

        // Initialize "current input selection" for each player
        MVII    #$0014, R0              // 5116  
        MVO     R0,     SLCT_0          // 5118  Player 0 current input select
        MVO     R0,     SLCT_1          // 511A  Player 1 current input select
        PULR    R7                      // 511C  

        // ---------------------------------------------------------------- //
        //  DISP_ISLE_CARD -- display a card on one of the islands
        //
        //  INPUT
        //      R0  Format word (XORed with card # for display)
        //      R1  Pointer into isle index table 
        //      R4  Pointer into isle picture table 
        //      
        //  OUTPUT
        //      R0  Final, merged display word
        //      R1  Incremented by 1 (otherwise unused
        //      R3  Shifted card #, without format word applied
        //      R4  Incremented by 1
        // ---------------------------------------------------------------- //
DISP_ISLE_CARD:
        PSHR    R5                      // 511D  Save return address
        MVI@    R4,     R3              // 511E  Get card index number
        SLL     R3,     2               // 511F  \_ shift left by 3 for display
        SLL     R3,     1               // 5120  /  
        XORR    R3,     R0              // 5121  Merge with format word
        MVO@    R0,     R2              // 5122  Write to display
        INCR    R1                      // 5123  Increment offset table pointer
        PULR    R7                      // 5124  Return

        // ---------------------------------------------------------------- //
        //  Controller dispatch table
        //
        //
        //  Top action:  Display total score
        //  Lower left:  Display island population
        //  Lower right: Display previous round score
        // ---------------------------------------------------------------- //
CTRL_DISPATCH_TBL:
        BIDECLE DISC_INPUT  // 5125  Disc dispatch
        BIDECLE KEYPAD_INP  // 5127  Keypad dispatch
        BIDECLE DISP_SCORE  // 5129  Top act:  Display total score
        BIDECLE DISP_POP    // 512B  Lft act:  Display island population
        BIDECLE DISP_ROUND  // 512D  Rgt act:  Display previous round score

        //  List of display offsets for the left and right islands,
        //  followed by GRAM card indices associated with these positions.
        //  (Ref: code @ 50D0 - 50F1, and subrtn at 511D - 5124)
        //
        //  $512F - $514B           $514C - $5168
        //  ....................    ....................
        //  ....................    ....................
        //  ..#.................    ..........##.#..#...
        //  .###................    ..........#######...
        //  .###................    ..........##..####..
        //  .#####..............    ...............####.
        //  ...####.............    ................###.
        //  ....#####...........    ...............####.
        //  ...###.#####........    .................#..
        //  ....................    ....................
        //  ....................    ....................
        //  ....................    ....................

LFT_ISLE_OFS_TBL:
        DECLE   $002A,  $003D,  $003E,  $003F   // 512F   002A 003D 003E 003F
        DECLE   $0051,  $0052,  $0053,  $0065   // 5133   0051 0052 0053 0065
        DECLE   $0066,  $0067,  $0068,  $0069   // 5137   0066 0067 0068 0069
        DECLE   $007B,  $007C,  $007D,  $007E   // 513B   007B 007C 007D 007E
        DECLE   $0090,  $0091,  $0092,  $0093   // 513F   0090 0091 0092 0093
        DECLE   $0094,  $00A3,  $00A4,  $00A5   // 5143   0094 00A3 00A4 00A5
        DECLE   $00A7,  $00A8,  $00A9,  $00AA   // 5147   00A7 00A8 00A9 00AA
        DECLE   $00AB                           // 514B   00AB

RGT_ISLE_OFS_TBL:
        DECLE   $0032,  $0033,  $0035,  $0038   // 514C   0032 0033 0035 0038
        DECLE   $0046,  $0047,  $0048,  $0049   // 5150   0046 0047 0048 0049
        DECLE   $004A,  $004B,  $004C,  $005A   // 5154   004A 004B 004C 005A
        DECLE   $005B,  $005E,  $005F,  $0060   // 5158   005B 005E 005F 0060
        DECLE   $0061,  $0073,  $0074,  $0075   // 515C   0061 0073 0074 0075
        DECLE   $0076,  $0088,  $0089,  $008A   // 5160   0076 0088 0089 008A
        DECLE   $009B,  $009C,  $009D,  $009E   // 5164   009B 009C 009D 009E
        DECLE   $00B1                           // 5168   00B1 
        
LFT_ISLE_PIC_TBL:
        DECLE           $0013,  $0014,  $0000   // 5169        0013 0014 0000
        DECLE   $0015,  $0017,  $0000,  $0018   // 516C   0015 0017 0000 0018
        DECLE   $001D,  $001E,  $0000,  $0020   // 5170   001D 001E 0000 0020 
        DECLE   $0015,  $001D,  $0000,  $0000   // 5174   0015 001D 0000 0000
        DECLE   $0015,  $0017,  $0000,  $001E   // 5178   0015 0017 0000 001E
        DECLE   $0020,  $0015,  $0019,  $001E   // 517C   0020 0015 0019 001E
        DECLE   $001F,  $001D,  $001E,  $001C   // 5180   001F 001D 001E 001C
        DECLE   $001B,  $001A                   // 5184   001B 001A          

RGT_ISLE_PIC_TBL:
        DECLE                   $0014,  $0015   // 5186             0014 0015
        DECLE   $0013,  $0013,  $0017,  $0000   // 5188   0013 0013 0017 0000
        DECLE   $001B,  $001E,  $001C,  $0020   // 518C   001B 001E 001C 0020
        DECLE   $0018,  $001D,  $001F,  $001D   // 5190   0018 001D 001F 001D
        DECLE   $0000,  $0000,  $0015,  $001D   // 5194   0000 0000 0015 001D
        DECLE   $0000,  $0000,  $0015,  $0017   // 5198   0000 0000 0015 0017
        DECLE   $0000,  $0018,  $0019,  $001E   // 519C   0000 0018 0019 001E
        DECLE   $0000,  $001F,  $0016           // 51A0   0000 001F 0016


// ======================================================================== //
//  TIMER TIC TASK -- called once per tic (20Hz)                            //
// ======================================================================== //

TICTSK:
L_51A3: PSHR    R5                  // 51A3  Save return address
        MVI     TICINH, R1          // 51A4  Are timer tasks inhibited?
        TSTR    R1                  // 51A6  
        BEQ     L_51AA              // 51A7  No:  Continue
        PULR    R7                  // 51A9  Return


        // ---------------------------------------------------------------- //
        //  Per-tic weather update.                                         //
        // ---------------------------------------------------------------- //
L_51AA: MVII    #$0064, R0          // 51AA  \_ Generate a random number 0-99
        JSR     R5,     X_RAND2     // 51AC  /

        TSTR    R0                  // 51AF  \_ If it was 0, then try to 
        BEQ     L_51C6              // 51B0  /  start some weather 
        B       L_51F8              // 51B2  Update existing weather


        // Create rain / tropical storm, for R0 = 1..11 
L_51B4: SDBD                        // 51B4  
        MVII    #$5D08, R1          // 51B5  MOB ROM pointer for rain handler
        MVI@    R2,     R3          // 51B8  Get MOB attributes 
        CMPI    #$0004, R0          // 51B9  \_ Rand val 1..3:   Tropical storm
        BLT     L_51C2              // 51BB  /  Rand val 4..11:  Rain

        XORI    #$0117, R3          // 51BD  Color => grey// Y scale => 1x
L_51BF: MVO@    R3,     R2          // 51BF  Store updated attribute word
        B       L_51E9              // 51C0  

                                    // Quick aside on MOB attributes:  These
                                    // aren't what's in the STIC's A register. 
                                    // Rather, they're the EXEC flags 
                                    // associated with the MOB and are encoded
                                    // rather differently.

L_51C2: XORI    #$0107, R3          // 51C2  Color => black// Y scale => 1x
        B       L_51BF              // 51C4  


        // Are the weather MOBs busy?
L_51C6: MVII    #$031D, R1          // 51C6  Point to MOB 0 data
L_51C8: JSR     R5,     X_MOB_ACT   // 51C8  Is it allocated?
        BEQ     L_51D5              // 51CB  No:  New weather!

        ADDI    #$0008, R1          // 51CD  \
        CMPI    #$0325, R1          // 51CF   |- Check MOB 1 too
        BEQ     L_51C8              // 51D1  /
        B       L_51F8              // 51D3  Both are busy -- redirect weather?


        // Create new weather
L_51D5: MOVR    R1,     R2          // 51D5  Copy MOB ptr to R2
        SDBD                        // 51D6  \_ Point to weather MOB tables
        MVII    #$5C85, R1          // 51D7  /

        JSR     R5,     X_INIT_MOB  // 51DA  Set up skeleton of MOB record

        MVII    #$000C, R0          // 51DD  \_ Random number 0..11
        JSR     R5,     X_RAND2     // 51DF  /

        TSTR    R0                  // 51E2  \_ Non-zero, branch
        BNEQ    L_51B4              // 51E3  /

        SDBD                        // 51E5  \_ Set up ROM data base pointer    
        MVII    #$5D11, R1          // 51E6  /  for hurricane (1 in 12 chance)
L_51E9: INCR    R2                  // 51E9  \_ Write updated MOB ROM pointer
        MVO@    R1,     R2          // 51EA  /

        MVII    #$0003, R0          // 51EB  \_ Random 0..2
        JSR     R5,     X_RAND2     // 51ED  /

        TSTR    R0                  // 51F0  \_ If non-zero, done spawning
        BNEQ    L_51F8              // 51F1  /  hurricane

        INCR    R2                  // 51F3  \
        MVII    #$001B, R1          // 51F4   |_ Set X coord to 27. 
        SWAP    R1,     1           // 51F6   |  (But, it should already be 27!)
        MVO@    R1,     R2          // 51F7  /


        // Weather update -- 1 in 10 chance
L_51F8: MVII    #$031D, R1          // 51F8  Consider MOB 0 first

L_51FA: MVII    #$000A, R0          // 51FA  \_ Random number 0 - 9
        JSR     R5,     X_RAND2     // 51FC  /

        TSTR    R0                  // 51FF  \_ Skip if not 0
        BNEQ    L_5205              // 5200  /

        JSR     R5,     L_520D      // 5202  Do weather update

L_5205: ADDI    #$0008, R1          // 5205  \
        CMPI    #$0325, R1          // 5207   |- Check other weather MOB
        BEQ     L_51FA              // 5209  /
        B       L_5236              // 520B  Skip the weather update

        // Randomly update a MOB's velocity N/S/E/W
L_520D: PSHR    R5                  // 520D  Save return address

        MVII    #$0004, R0          // 520E  \_ Random value 0 - 3
        JSR     R5,     X_RAND2     // 5210  /

        // Modify velocity randomly N, S, E or W...

        MOVR    R0,     R2          // 5213  Save random # in R2
        ADDI    #$0004, R1          // 5214  \
        MOVR    R1,     R3          // 5216   |- Get (packed) velocity for MOB
        MVI@    R3,     R0          // 5217  /

        JSR     R5,     X_UNPKBYTES // 5218  Unpack X/Y velocities (signed)
                                    //       Upper byte (Xvel) to R0
                                    //       Lower byte (Yvel) to R1

        CMPI    #$0003, R2          // 521B  \_ R2 == 3? Increase X velocity
        BEQ     L_522A              // 521D  /           (Move faster east)

        CMPI    #$0002, R2          // 521F  \_ R2 == 2? Decrease X velocity
        BEQ     L_522D              // 5221  /           (Move faster west)

        CMPI    #$0001, R2          // 5223  \_ R2 == 1? Increase Y velocity
        BEQ     L_5230              // 5225  /           (Move faster south)

        DECR    R1                  // 5227  \_ Else:    Decrease Y velocity
        B       L_5231              // 5228  /           (Move faster north)

L_522A: INCR    R0                  // 522A  \_ Xvel += 1
        B       L_5231              // 522B  /

L_522D: DECR    R0                  // 522D  \_ Xvel -= 1
        B       L_5231              // 522E  /

L_5230: INCR    R1                  // 5230  Yvel += 1

L_5231: JSR     R5,     X_PACKBYTES // 5231  Re-pack X/Y velocities

        MVO@    R0,     R3          // 5234  Store updated vel to MOB record
        PULR    R7                  // 5235  return


        // Fish update time
L_5236: MVII    #$0014, R0          // 5236  \
        JSR     R5,     X_RAND2     // 5238   |_ If rand() % 20 == 0,   
        TSTR    R0                  // 523B   |  try to make new fish.
        BEQ     L_5240              // 523C  /
        B       L_52B5              // 523E  Update existing fish

L_5240: MVII    #$034D, R1          // 5240  Point to first fish MOB

L_5242: JSR     R5,     X_MOB_ACT   // 5242  \_ Is this school of fish active?
        BEQ     L_524F              // 5245  /  No:  New fish!

        ADDI    #$0008, R1          // 5247  \
        CMPI    #$0355, R1          // 5249   |- Move to next school of fish
        BEQ     L_5242              // 524B  /  
        B       L_52B5              // 524D  Move to pirates update

        // Make new fish!
L_524F: CLRR    R0                  // 524F  \
        SDBD                        // 5250   |- Why all the extra code?!
        XORI    #$08A4, R0          // 5251  /   
        MVO@    R0,     R1          // 5254  Set MOB attribute to $08A4
                                    //        -- Not visible (?)
                                    //        -- Enable object interactions
                                    //        -- Full-height 8x8 object
                                    //        -- Prio = MOB below cards
                                    //        -- Green (Color #4)

        CLRR    R0                  // 5255  \
        SDBD                        // 5256   |- Why all the extra code?!
        XORI    #$D8C0, R0          // 5257  /

        ADDI    #$0005, R1          // 525A  \_ Update MOB animation word
        MVO@    R0,     R1          // 525C  /

        SUBI    #$0004, R1          // 525D  \
        SDBD                        // 525F   |_ MOB dispatch / animation table
        MVII    #FISH_MOB_TBL, R0   // 5260   |  
        MVO@    R0,     R1          // 5263  /
        DECR    R1                  // 5264  Point back to head of MOB record

        JSR     R5,     L_526A      // 5265  

        B       L_52B5              // 5268  Check next school of fish

        // Spawn a MOB at one of the four corners
L_526A: PSHR    R5                  // 526A  
        PSHR    R1                  // 526B  
        MOVR    R1,     R2          // 526C  Copy MOB ptr to R2

        MVII    #$0008, R0          // 526D  \
        JSR     R5,     X_RAND2     // 526F   |- Generate rand val 0..7
        PSHR    R0                  // 5272  /   and save it to the stack

        MVII    #$0002, R0          // 5273  \_ Generate 0/1 random value
        JSR     R5,     X_RAND2     // 5275  /

        TSTR    R0                  // 5278  \_ If 0 (50% chance) spawn at 
        BEQ     L_5284              // 5279  /  bottom, else spawn at top

        PULR    R0                  // 527B  Restore 0..7 number
        ADDI    #$0003, R2          // 527C  Point to Y coordinate
        ADDI    #$0008, R0          // 527E  Rand number in 8 .. 15 range

L_5280: SWAP    R0,     1           // 5280  \_ Set the 8q8 Y coordinate
        MVO@    R0,     R2          // 5281  /  to 8..15 or 80..87
        B       L_528B              // 5282  

L_5284: PULR    R0                  // 5284  Restore 0..7 number
        ADDI    #$0003, R2          // 5285  Point to Y coordinate
        ADDI    #$0050, R0          // 5287  Rand number in 80 .. 87 range
        B       L_5280              // 5289  Set Y coordinate

L_528B: DECR    R2                  // 528B  Rewind to the X coordinate

        MVII    #$0002, R0          // 528C  \_ Generate a 0/1 number
        JSR     R5,     X_RAND2     // 528E  /

        TSTR    R0                  // 5291  \_ 0: spawn at left
        BEQ     L_52AB              // 5292  /  1: spawn at right

        MVII    #$00A7, R0          // 5294  \
        SWAP    R0,     1           // 5296   |- set X coord to 167
        MVO@    R0,     R2          // 5297  /

        ADDI    #$0002, R2          // 5298  \
        SDBD                        // 529A   |_ with slow leftward vel (-3)
        MVII    #$FFFD, R0          // 529B   |  and no vertical vel.
        CLRR    R1                  // 529E  / 

L_529F: JSR     R5,     X_PACKBYTES // 529F  

        MVO@    R0,     R2          // 52A2  Save initial velocity
        PULR    R1                  // 52A3  Restore original MOB ptr.
        MVI@    R1,     R0          // 52A4  \
        SDBD                        // 52A5   |_ Make MOB visible now that
        XORI    #$1000, R0          // 52A6   |  it's constructed (bit 12 
        MVO@    R0,     R1          // 52A9  /   in attribute word)
        PULR    R7                  // 52AA  Done making new fish!

L_52AB: CLRR    R0                  // 52AB  \
        SWAP    R0,     1           // 52AC   |- Set X to 0... why the SWAP?!?
        MVO@    R0,     R2          // 52AD  /
        ADDI    #$0002, R2          // 52AE  Point to velocity
        MVII    #$0003, R0          // 52B0  Move in a slow rightward dir (+3)
        CLRR    R1                  // 52B2  and no Y velocity
        B       L_529F              // 52B3  Go set velocity and return

        // Try to spawn pirates
L_52B5: MVII    #$0064, R0          // 52B5  \
        JSR     R5,     X_RAND2     // 52B7   |
        TSTR    R0                  // 52BA   |- Spawn new pirates with 1:100
        BEQ     L_52BF              // 52BB   |  chance.
        B       L_52E5              // 52BD  /

L_52BF: MVII    #$033D, R1          // 52BF  Point to MOB #4 (Pirate 0)

L_52C1: JSR     R5,     X_MOB_ACT   // 52C1  \_ If inactive, try to spawn a
        BEQ     L_52CE              // 52C4  /  pirate.

        ADDI    #$0008, R1          // 52C6  \
        CMPI    #$0345, R1          // 52C8   |- Check second pirate
        BEQ     L_52C1              // 52CA  /
        B       L_52E5              // 52CC  Done spawning pirates

        // Spawn a pirate
L_52CE: CLRR    R0                  // 52CE  \
        SDBD                        // 52CF   |_ Set MOB attributes to $0800
        XORI    #$0800, R0          // 52D0   |
        MVO@    R0,     R1          // 52D3  /
        CLRR    R0                  // 52D4  \
        XORI    #$00C0, R0          // 52D5   |_ Set up animation for MOB
        ADDI    #$0005, R1          // 52D7   |
        MVO@    R0,     R1          // 52D9  /
        SUBI    #$0004, R1          // 52DA  \
        SDBD                        // 52DC   |_ Point to pirate's MOB ROM data
        MVII    #$5CFB, R0          // 52DD   |
        MVO@    R0,     R1          // 52E0  /
        DECR    R1                  // 52E1  Point to head of MOB record

        JSR     R5,     L_526A      // 52E2  Spawn the pirate in one of the
                                    //       four corners.

        // Pirate update
L_52E5: MVII    #$033D, R1          // 52E5  Point to MOB #4 (Pirate 0)

L_52E7: MVII    #$000A, R0          // 52E7  \
        JSR     R5,     X_RAND2     // 52E9   |_ Decide to update velocity
        TSTR    R0                  // 52EC   |  1:10 chance
        BNEQ    L_52F4              // 52ED  /

        PSHR    R1                  // 52EF  \
        JSR     R5,     L_520D      // 52F0   |- Do random velocity update
        PULR    R1                  // 52F3  /

L_52F4: ADDI    #$0008, R1          // 52F4  \
        CMPI    #$0355, R1          // 52F6   |- Loop for second pirate
        BLE     L_52E7              // 52F8  /


        // Island / (Boat, Fish) collision checks  (player and pirates both)
        MVII    #$032D, R1          // 52FA  Point to Player 0 MOB data

L_52FC: MOVR    R1,     R2          // 52FC  Save MOB data ptr
        ADDI    #$0001, R2          // 52FD  Point to ROM data ptr
        MVI@    R2,     R4          // 52FF  \
        SDBD                        // 5300   |- Is it a cursor?
        CMPI    #$5CB5, R4          // 5301  /
        BEQ     L_530B              // 5304  Yes:  Loop to next player

        PSHR    R1                  // 5306  \
        JSR     R5,     L_5320      // 5307   |- Keep boat (PT or fishing)
        PULR    R1                  // 530A  /   from running aground

L_530B: ADDI    #$0008, R1          // 530B  \
        CMPI    #$0335, R1          // 530D   |- Check player 1...
        BEQ     L_52FC              // 530F  /

        MVII    #$033D, R1          // 5311  Point to Pirate 0 MOB data

L_5313: PSHR    R1                  // 5313  \
        JSR     R5,     L_5320      // 5314   |- Keep pirate from running
        PULR    R1                  // 5317  /   aground

        ADDI    #$0008, R1          // 5318  \
        CMPI    #$0355, R1          // 531A   |- Check Pirate 1 and both
        BLE     L_5313              // 531C  /   fish
        B       STAT_TIC            // 531E  Done collision checking// do status

        // Try to keep ships from running aground,
        // as well as updating left/right mirror flags.
L_5320: PSHR    R5                  // 5320  Save return address...
        PSHR    R5                  // 5321  ... twice??  Wow.

        CLRR    R3                  // 5322  \_ Clear axis flag 
        MVO     R3,     CKAXIS      // 5323  /  0 means X, 1 means Y

        MOVR    R1,     R3          // 5325  Copy MOB ptr to R3

        ADDI    #$0004, R1          // 5326  \_ Load X/Y packed vel into R0
        MVI@    R1,     R0          // 5328  /

        JSR     R5,     X_UNPKBYTES // 5329  Unpack X/Y velocity
                                    //       Upper byte (Xvel) to R0
                                    //       Lower byte (Yvel) to R1

        MOVR    R1,     R4          // 532C  Move Y vel to R4
        MOVR    R3,     R1          // 532D  Move MOB ptr to R1
        PSHR    R3                  // 532E  Save MOB ptr on stack

        JSR     R5,     MOB_TO_CARD // 532F  Get display card # in R2 for MOB

        SUBI    #$0200, R2          // 5332  Convert to display offset
        MVO     R2,     SHPLOC      // 5334  Store to 1A4
        ADDI    #$0200, R2          // 5336  Convert back to display ptr

        PULR    R3                  // 5338  Restore MOB data ptr
        MVI@    R3,     R1          // 5339  Get MOB attributes

        TSTR    R0                  // 533A  Is X velocity 0?
        BEQ     L_5346              // 533B  Yes: No update to MOB attrs

        SDBD                        // 533D  \_ clear X mirror flag
        ANDI    #$FDFF, R1          // 533E  /
        TSTR    R0                  // 5341  \_ Are we going right?
        BPL     L_5346              // 5342  /

        XORI    #$0200, R1          // 5344  No: Set X mirror flag

L_5346: MVO@    R1,     R3          // 5346  Store updated attributes.

        // Look ahead of direction boat is traveling by one card.
        // Note, this look-ahead is the reason you can't sail dead-on 
        // toward an island, but you can get close to the shore if you 
        // come in from the side.
        TSTR    R0                  // 5347  \_ If X vel 0, skip rest of 
L_5348: BEQ     L_53B5              // 5348  /  velocity / horiz coll update?
        BPL     L_5358              // 534A  If moving right/down, go to L_5358

        MVI     CKAXIS, R1          // 534C  \
        TSTR    R1                  // 534E   |- X or Y axis?
        BNEQ    L_5354              // 534F  /

        DECR    R2                  // 5351  \__ Check to left of boat
        B       L_5362              // 5352  /

L_5354: SUBI    #$0014, R2          // 5354  \__ Check above boat
        B       L_5362              // 5356  /

L_5358: MVI     CKAXIS, R1          // 5358  \
        TSTR    R1                  // 535A   |- X or Y axis?
        BNEQ    L_5360              // 535B  /

        INCR    R2                  // 535D  \__ Check to right of boat
        B       L_5362              // 535E  /

L_5360: ADDI    #$0014, R2          // 5360  Check below boat

L_5362: CMPI    #$0200, R2          // 5362  \
        BMI     L_53B5              // 5364   |_ Clip to display.  Skip test
        CMPI    #$02F0, R2          // 5366   |  if pointer is out-of-bounds
        BPL     L_53B5              // 5368  /

        JSR     R5, GRAM_OR_GROM    // 536A  \_ GROM cards are "open seas"
        BNEQ    L_5377              // 536D  /  Z=0 means GRAM

        JSR     R5, GET_TILE_NO     // 536F  Get tile number of GROM card

        TSTR    R1                  // 5372  \_ Zero is open seas
        BEQ     L_53B5              // 5373  /  Non-zero is status bar
        B       L_538A              // 5375  Nudge off of status bar

L_5377: JSR     R5, GET_TILE_NO     // 5377  Get tile under current position

        CMPI    #$033D, R3          // 537A  \_ Are we Pirate 0?
        BEQ     L_5386              // 537C  /  Treat PT boats as land.

        CMPI    #$0345, R3          // 537E  \_ Are we Pirate 1?
        BEQ     L_5386              // 5380  /  Treat PT boats as land.

        CMPI    #$0008, R1          // 5382  \_ PT boat ahead?
        BEQ     L_53B5              // 5384  /  Ignore it.

L_5386: CMPI    #$0009, R1          // 5386  \_ Fishing boat ahead?
        BEQ     L_53B5              // 5388  /  Ignore it.

L_538A: MOVR    R3,     R1          // 538A  Copy MOB ptr to R1

        MVI     CKAXIS, R2          // 538B  \
        TSTR    R2                  // 538D   |- X or Y axis?
        BNEQ    L_5395              // 538E  /

        ADDI    #$0002, R1          // 5390  Point to X posn in MOB rec
        PSHR    R0                  // 5392  Save X vel on stack.
        B       L_5398              // 5393  

L_5395: ADDI    #$0003, R1          // 5395  Point to Y posn in MOB rec
        PSHR    R4                  // 5397  Save Y vel on stack.

L_5398: MVI@    R1,     R2          // 5398  \_ Get position// swap MSB into
        SWAP    R2,     1           // 5399  /  bottom
        PULR    R5                  // 539A  Get velocity (X or Y) from stack
        TSTR    R5                  // 539B  \_ Positive or negative velocity?
        BPL     L_53A5              // 539C  /

        // Negative velocity tests:
        CMPI    #$00A0, R2          // 539E  \_ Greater than or equal to 160?
        BGE     L_53AA              // 53A0  /  Yes: No update.
                                    //       Bug here: Shouldn't this be 96
                                    //       when testing Y axis?

        INCR    R2                  // 53A2  \_ Nudge ship to the right
        B       L_53AA              // 53A3  /  or down.

        // Positive velocity tests:
L_53A5: CMPI    #$0008, R2          // 53A5  \_ Less than or equal to 8?
        BLE     L_53AA              // 53A7  /  Yes: No update.

        DECR    R2                  // 53A9  Nudge ship to the left or up.

L_53AA: SWAP    R2,     1           // 53AA  \_ Store updated position.
        MVO@    R2,     R1          // 53AB  /

        // If we nudged, then we need to stop movement on that axis.
        MVI     CKAXIS, R5          // 53AC  \
        TSTR    R5                  // 53AE   |- X or Y axis?
        BNEQ    L_53B4              // 53AF  /

        CLRR    R0                  // 53B1  \_ Clear X velocity, continue.
        B       L_53B5              // 53B2  /

L_53B4: CLRR    R4                  // 53B4  Clear Y velocity.

L_53B5: MVI     CKAXIS, R2          // 53B5  \
        TSTR    R2                  // 53B7   |- X or Y axis?
        BNEQ    L_53C4              // 53B8  /   If Y axis, store out updates

        INCR    R2                  // 53BA  \__ Check Y axis after X.
        MVO     R2,     CKAXIS      // 53BB  /

        MVI     SHPLOC, R2          // 53BD  \__ Reload card offset for ship
        ADDI    #$0200, R2          // 53BF  /
        TSTR    R4                  // 53C1  Check sign of Y axis
        B       L_5348              // 53C2  Continue coll check for Y axis

L_53C4: MOVR    R4,     R1          // 53C4  \__ Pack X, Y vel back together
        JSR     R5,     X_PACKBYTES // 53C5  /

        MOVR    R3,     R2          // 53C8  \
        ADDI    #$0004, R2          // 53C9   |- Store out updated velocity
        MVO@    R0,     R2          // 53CB  /
        PULR    R5                  // 53CC  Restore saved return address (?)
        PULR    R7                  // 53CD  Return

        // ---------------------------------------------------------------- //
        //  Get the tile number associated with a background card.          //
        // ---------------------------------------------------------------- //
GET_TILE_NO:
Lx53CE: PSHR    R5                  // 53CE  
        MVI@    R2,     R1          // 53CF  Read card from BACKTAB
        SLR     R1,     2           // 53D0  \_ shift tile # down
        SLR     R1,     1           // 53D1  /
        ANDI    #$00FF, R1          // 53D2  Mask out other bits.
        PULR    R7                  // 53D4  

        // ---------------------------------------------------------------- //
        //  Test whether a given tile is GRAM or GROM.                      //
        //      Z == 1 means GROM                                           //
        //      Z == 0 means GRAM                                           //
        // ---------------------------------------------------------------- //
GRAM_OR_GROM:
Lx53D5: PSHR    R5                  // 53D5   
        MVI@    R2,     R1          // 53D6   Get card
        SDBD                        // 53D7   
        ANDI    #$0800, R1          // 53D8   Keep GRAM/GROM bit
        TSTR    R1                  // 53DB   Z = 1 means GROM, Z = 0 means GRAM
        PULR    R7                  // 53DC   


        // ---------------------------------------------------------------- //
        //  20 tics in a second.  Figure out second boundaries by           //
        //  counting off 20 tics.                                           //
        // ---------------------------------------------------------------- //
STAT_TIC:
L_53DD: MVI     TICSEC, R0          // 53DD  \
        INCR    R0                  // 53DF   |_ Count from 0..19
        CMPI    #$0014, R0          // 53E0   |  and roll back to 0
        BNEQ    L_53E5              // 53E2   |
        CLRR    R0                  // 53E4  /

L_53E5: MVO     R0,     TICSEC      // 53E5  

        TSTR    R0                  // 53E7  \_ Not end of second?
        BNEQ    STAT_UPD_FULL       // 53E8  /  Update status and return

        // Count down remaining seconds
        MVI     REMSEC, R0          // 53EA  \
        DECR    R0                  // 53EC   |- Count down remaining seconds
        TSTR    R0                  // 53ED  / 
        BNEQ    L_5403              // 53EE  More to go:  Save and print stats

        // Do end of round stuff
        JSR     R5,     L_5FEF      // 53F0  End of round tone.
        JSR     R5,     L_59CD      // 53F3  Score end of round.

        MVI     CURTRN, R1          // 53F6  \
        INCR    R1                  // 53F8   |_ Increment the current turn,
        MVO     R1,     CURTRN      // 53F9   |  update stats and resume.
        B       L_5429              // 53FB  /


        // End of game?
L_53FD: CMP     NUMTRN, R1          // 53FD  
        BGE     L_547E              // 53FF  

        MVI     TRNLEN, R0          // 5401  
L_5403: MVO     R0,     REMSEC      // 5403  


        // ---------------------------------------------------------------- //
        //  Update status bar completely.                                   //
        // ---------------------------------------------------------------- //
STAT_UPD_FULL:
Lx5405: JSR     R5, STAT_UPD_TIME   // 5405  Update time/round
        JSR     R5, STAT_UPD_GOLD   // 5408  Update gold bars

        J       L_54E8              // 540B  Update sinking ships

        // ---------------------------------------------------------------- //
        //  Update the turns and time remaining in status bar.              //
        // ---------------------------------------------------------------- //
STAT_UPD_TIME:
Lx540E: PSHR    R5                  // 540E  Save return address

        // Compute turns remaining
        MVI     NUMTRN, R0          // 540F  \_ Turns remaining equals
        SUB     CURTRN, R0          // 5411  /  NUMTRN - CURTRN

        // print turns remaining
        MVII    #$0002, R1          // 5413  \   Print turns remaining
        CLRR    R3                  // 5415   |  in status bar.  R1 is
        XORI    #$0006, R3          // 5416   |- field width// R3 is color.
        MVII    #$02E3, R4          // 5418   |  R4 is position.
        JSR     R5, X_PRNUM_RGT     // 541A  /   

        // print remaining time
        MVI     REMSEC, R0          // 541D  \
        MVII    #$0004, R1          // 541F   |_ Print remaining seconds.
        MVII    #$02E5, R4          // 5421   |  R1 is field width, R4 is
        JSR     R5, X_PRNUM_RGT     // 5423  /   position.

        J       L_54E8              // 5426  Update sinking ships

        // ---------------------------------------------------------------- //
        //  Display round score for both players.                           //
        //  Called during end-of-round summary.                             //
        // ---------------------------------------------------------------- //
L_5429: CLRR    R1                  // 5429  \
        JSR     R5, DISP_ROUND_U    // 542A   |_ Display round totals for
        MVII    #$0001, R1          // 542D   |  both left and right plyrs
        JSR     R5, DISP_ROUND_U    // 542F  /

L_5432: MVII    #$02E3, R4          // 5432  \
        CLRR    R3                  // 5434   |- Prepare to print "TOTALS"
        XORI    #$0007, R3          // 5435  /   or "SCORES" based on $192

        MVI     SC_TOT, R1          // 5437  \
        TSTR    R1                  // 5439   |- If $192 == 0 print SCORES
        BNEQ    L_5448              // 543A  /   else print TOTALS.

        JSR     R5, X_PRINT_R5      // 543C  \
        STRING  "SCORES"            // 543F   |- Four scores and seven
        DECLE   $0000               // 5445  /   rounds ago...

        B       L_5452              // 5446  

L_5448: JSR     R5, X_PRINT_R5      // 5448  \
        STRING  "TOTALS"            // 544B   |- Not a delicious breakfast
        DECLE   $0000               // 5451  /

L_5452: SDBD                        // 5452  \
        MVII    #$30D4, R4          // 5453   |  Delay loop that calls
L_5456: SDBD                        // 5456   |  RAND repeatedly, but
        MVII    #$4572, R1          // 5457   |- does not actually advance
        JSR     R5,     X_RAND2     // 545A   |  random number generator.
        DECR    R4                  // 545D   |  
        TSTR    R4                  // 545E   |  
        BPL     L_5456              // 545F  /

        MVI     SC_TOT, R1          // 5461  \
        TSTR    R1                  // 5463   |- Break out of loop after
        BNEQ    L_5475              // 5464  /   displaying totals

        MVII    #$0001, R1          // 5466  \__ Display totals on next iter
        MVO     R1,     SC_TOT      // 5468  /

        CLRR    R1                  // 546A  \_ Display score for
        JSR     R5, DISP_SCORE      // 546B  /  player 0

        MVII    #$0001, R1          // 546E  \_ Display score for
        JSR     R5, DISP_SCORE      // 5470  /  player 1

        B       L_5432              // 5473  Do it again, displaying totals


L_5475: CLRR    R1                  // 5475  
        MVO     R1,     SC_TOT      // 5476  Clear flag in $192
        MVO     R1,     BARINH      // 5478  Allow gold bar display
        MVI     CURTRN, R1          // 547A  Get current turn
        B       L_53FD              // 547C  End of game or next round?


        // ---------------------------------------------------------------- //
        //  End of game                                                     //
        // ---------------------------------------------------------------- //
L_547E: SDBD                        // 547E   \
        MVII    #$1906, R0          // 547F    |- Disable hand controllers
        MVO     R0,     G_035D      // 5482   /
        MVII    #$0001, R0          // 5484   \_ Disable timer task
        MVO     R0,     TICINH      // 5486   /

        CLRR    R3                  // 5488   \
        MVII    #$02CC, R4          // 5489    |
        JSR     R5, X_PRINT_R5      // 548B    |- The fat lady doth sing
        STRING  "FINAL  SCORE"      // 548E    |
        DECLE   $0000               // 549A   /

        JSR     R5, X_KILL_MOBS     // 549B   Bye bye, MOBs

        PULR    R7                  // 549E   Return to the EXEC

        // ---------------------------------------------------------------- //
        //  Parked boats can fish...                                        //
        // ---------------------------------------------------------------- //
PARK_FISH:
L_549F: PSHR    R5                  // 549F  

        JSR     R5, MOB_TO_CARD     // 54A0  \_ Look under the school 
        JSR     R5, GET_TILE_NO     // 54A3  /  of fish

        CMPI    #$0009, R1          // 54A6  \_ Parked fishing boat?
        BNEQ    L_54CA              // 54A8  /

        MVI@    R2,     R1          // 54AA  \
        SLLC    R1,     2           // 54AB   |  Set CURPLR based on bit
        BOV     L_54B2              // 54AC   |  14 of card.  Bit 14=1
        MVII    #$0001, R1          // 54AE   |- means Player 0.  Same as
        B       L_54B3              // 54B0   |  island cards. (see unpk
L_54B2: CLRR    R1                  // 54B2   |  code above)
L_54B3: MVO     R1,     CURPLR      // 54B3  /   

L_54B5: MVII    #FISH_0,R1          // 54B5  \
        ADD     CURPLR, R1          // 54B7   |  Parked boats register a 
        MVI@    R1,     R2          // 54B9   |_ new fish after 50 
        INCR    R2                  // 54BA   |  "interactions".
        CMPI    #$0032, R2          // 54BB   |  
        BNEQ    L_54C9              // 54BD  /

        CLRR    R2                  // 54BF  \
        MVO@    R2,     R1          // 54C0   |_ Clear the fishing counter
        JSR     R5, INC_GOLD        // 54C1   |  and ring up a gold bar
        JSR     R5, FISH_PLING      // 54C4  /   (with sound effect!)

        B       L_54CA              // 54C7  Branch to "return" (why?)

L_54C9: MVO@    R2,     R1          // 54C9  Store updated fishing ctr
L_54CA: PULR    R7                  // 54CA  Return

        // ---------------------------------------------------------------- //
        //  Un-parked boats can also fish                                   //
        // ---------------------------------------------------------------- //
UNPARK_FISH:
        PSHR    R5                  // 54CB  
        SUBI    #$0002, R0          // 54CC  \_ Map MOB 2/3 to player 0/1
        MVO     R0,     CURPLR      // 54CE  /
        B       L_54B5              // 54D0  Ring up the fish...

        // ---------------------------------------------------------------- //
        //  Award a single gold bar to CURPLR                               //
        // ---------------------------------------------------------------- //
INC_GOLD:
Lx54D2: PSHR    R5                  // 54D2  
        MVII    #GOLD_0,R4          // 54D3  \_ Index to current player's gold
        JSR     R5,     L_5A29      // 54D5  /

        SDBD                        // 54D8  \
        MVI@    R4,     R1          // 54D9   |
        INCR    R1                  // 54DA   |
        SUBI    #$0002, R4          // 54DB   |- Give player one more gold bar
        MVO@    R1,     R4          // 54DD   |
        SWAP    R1,     1           // 54DE   |
        MVO@    R1,     R4          // 54DF  /
        MVII    #RGLD_0,R1          // 54E0  \
        ADD     CURPLR, R1          // 54E2   |  Add 1 to the amount of gold
        MVI@    R1,     R2          // 54E4   |- this player has earned this 
        INCR    R2                  // 54E5   |  round.
        MVO@    R2,     R1          // 54E6  /

        PULR    R7                  // 54E7  


        // ---------------------------------------------------------------- //
        //  Update sinking ship animation.  (Non-MOB ships.)                //
        // ---------------------------------------------------------------- //
L_54E8: MVI     SNKACT, R2          // 54E8  \
        TSTR    R2                  // 54EA   |_ Is there a ship sinking?
        BNEQ    L_5555              // 54EB   |  Update its animation or leave.
        PULR    R7                  // 54ED  /

        // ---------------------------------------------------------------- //
        //  PT Boat / Pirate vs. Background interaction handler.            //
        // ---------------------------------------------------------------- //
L_54EE: PSHR    R5                  // 54EE  
        MVI     SNKACT, R2          // 54EF  \
        TSTR    R2                  // 54F1   |- If flag at $199 set, leave.
        BNEQ    L_54F7              // 54F2  /   (sinking ship active?)

        JSR     R5,     L_54F8      // 54F4  Check MOB against fishing boats

L_54F7: PULR    R7                  // 54F7  

        // ---------------------------------------------------------------- //
        //  Try to sink a parked fishing boat with this MOB.                //
        // ---------------------------------------------------------------- //
L_54F8: PSHR    R5                  // 54F8  
        MOVR    R1,     R4          // 54F9  Copy MOB # to R4

        JSR     R5, MOB_TO_CARD     // 54FA  \_ Get card under this ship
        JSR     R5, GET_TILE_NO     // 54FD  /

        CMPI    #$0009, R1          // 5500  \_ Not a fishing boat?  Leave.
        BNEQ    L_553B              // 5502  /

        MOVR    R4,     R1          // 5504  
        PSHR    R2                  // 5505  
        PSHR    R4                  // 5506  

        JSR     R5, FORT_NEAR_MOB   // 5507  Is there a fort nearby?

        PULR    R4                  // 550A  
        PULR    R2                  // 550B  
        TSTR    R1                  // 550C  
        BNEQ    L_553C              // 550D  Yes:  Ours or theirs?

L_550F: MVI@    R2,     R1          // 550F  \
        SLLC    R1,     2           // 5510   |- Boat owned by player 0 or 1?
        BOV     L_554C              // 5511  /   

        CMPI    #$0335, R4          // 5513  \__ Player 1 boat and player 1 MOB?
        BEQ     L_553B              // 5515  /   Leave.

        MVII    #$0001, R1          // 5517  \__ Player 1's gonna lose a boat.
        MVO     R1,     CURPLR      // 5519  /

L_551B: MVII    #$0195, R1          // 551B  \
        ADD     CURPLR, R1          // 551D   |_ Increment boat-touch counter
        MVI@    R1,     R0          // 551F   |  for player
        INCR    R0                  // 5520  /
        CMPI    #$0014, R0          // 5521  Is it 20 yet?
        BLT     L_553A              // 5523  No:  Haven't touched long enough.

        MVII    #$0009, R3          // 5525  \__ "You sunk my fishing boat!"
        JSR     R5,     L_570D      // 5527  /   Decrement boat count.

L_552A: SUBI    #$0200, R2          // 552A  \__ Record where to sink
        MVO     R2,     SNK_AT      // 552C  /
        MVII    #$0001, R2          // 552E  \__ Sinking in progress
        MVO     R2,     SNKACT      // 5530  /
        MVII    #$000A, R2          // 5532  \__ First frame of sinking ship
        MVO     R2,     SNKFRM      // 5534  /
        JSR     R5,     $5FA8       // 5536  Play the sinking ship sound.

        CLRR    R0                  // 5539  Clear boat-touch counter
L_553A: MVO@    R0,     R1          // 553A  Store updated boat-touch counter
L_553B: PULR    R7                  // 553B  Leave

L_553C: MVI@    R2,     R1          // 553C  Get boat
        MVI     CURPLR, R0          // 553D  Get fort owner
        SLLC    R1,     2           // 553F  \_ Check boat owner (player 0/1)
        BOV     L_5547              // 5540  /

        TSTR    R0                  // 5542  \_ Boat and fort both player 1?
        BNEQ    L_553B              // 5543  /  Leave.
        B       L_550F              // 5545  Else, no fort protection. Continue.

L_5547: TSTR    R0                  // 5547  \_ Boat and fort both player 0?
        BEQ     L_553B              // 5548  /  Leave.
        B       L_550F              // 554A  Else, no fort protection. Continue.

L_554C: CMPI    #$032D, R4          // 554C  \__ Player 0 boat and player 0 MOB?
        BEQ     L_553B              // 554E  /   Leave.

        CLRR    R1                  // 5550  \__ Player 0's gonna lose a boat.
        MVO     R1,     CURPLR      // 5551  /
        B       L_551B              // 5553  

        // ---------------------------------------------------------------- //
        //  Update sinking boat animation (non-MOB fishing boats)           //
        // ---------------------------------------------------------------- //
L_5555: MVI     SNKCNT, R0          // 5555  \__ Animation rate counter
        INCR    R0                  // 5557  /
        MVI     SNKFRM, R1          // 5558  \__ Animation frame number
        CMPI    #$0010, R1          // 555A  /   ($0A thru $11)
        BLT     L_5562              // 555C  

        CMPI    #$0013, R0          // 555E  \__ Slow down last couple frames
        B       L_5564              // 5560  /   Anim rate of 19 tic/frame

L_5562: CMPI    #$0006, R0          // 5562  \__ Normal anim rate of 6 tic/frame
L_5564: BEQ     L_5569              // 5564  /

        MVO     R0,     SNKCNT      // 5566  \__ Update anim time counter and
        PULR    R7                  // 5568  /   leave if not at anim rate yet

L_5569: CLRR    R0                  // 5569  \__ Reset animation time counte
        MVO     R0,     SNKCNT      // 556A  /

        MVI     SNKFRM, R0          // 556C  Get frame number
        MVI     SNK_AT, R2          // 556E  \__ Get position onscreen
        ADDI    #$0200, R2          // 5570  /

        MVI@    R2,     R1          // 5572  Load card from screen
        INCR    R0                  // 5573  Increment frame number
        CMPI    #$0013, R0          // 5574  \__ Is this the last frame?
        BGE     L_5588              // 5576  /

        SDBD                        // 5578  \
        ANDI    #$F807, R1          // 5579   |
        MOVR    R0,     R3          // 557C   |
        SLL     R3,     2           // 557D   |_ Merge the animation frame
        SLL     R3,     1           // 557E   |  into the display card
        SDBD                        // 557F   |
        ANDI    #$07F8, R3          // 5580   |
        XORR    R3,     R1          // 5583  /

        MVO@    R1,     R2          // 5584  Store updated animation to display
        MVO     R0,     SNKFRM      // 5585  Store updated animation frame #
        PULR    R7                  // 5587  Leave

        // Last frame:  Remove boat
L_5588: SDBD                        // 5588  \
        ANDI    #$3000, R1          // 5589   |- Clear boat out of water
        MVO@    R1,     R2          // 558C  / 
        CLRR    R1                  // 558D  \__ Clear "sinking in progress"
        MVO     R1,     SNKACT      // 558E  /
        PULR    R7                  // 5590  Leave

        // ---------------------------------------------------------------- //
        //  Try to sink a parked boat.  (Weather)                           //
        // ---------------------------------------------------------------- //
L_5591: PSHR    R5                  // 5591  
        MVI     SNKACT, R0          // 5592  \
        TSTR    R0                  // 5594   |- Skip if sinking in progress
        BNEQ    L_54F7              // 5595  /
        B       L_552A              // 5597  Sink it!


        // ---------------------------------------------------------------- //
        //  Sink an unparked boat.  (Weather)                               //
        // ---------------------------------------------------------------- //
        PSHR    R5                  // 5599  (unused?)
L_559A: MVI@    R1,     R0          // 559A  \
        SDBD                        // 559B   |_ Halt MOB
        XORI    #$8000, R0          // 559C   |
        MVO@    R0,     R1          // 559F  /
        ADDI    #$0001, R1          // 55A0  
        MVI@    R1,     R0          // 55A2  Get ROM data pointer
        SDBD                        // 55A3  
        CMPI    #PIRT_MOB_TBL, R0   // 55A4  \_ Is it a pirate?
        BEQ     L_55B1              // 55A7  /

        MVO     R0,     G_032C      // 55A9  Remember ROM data ptr

        SDBD                        // 55AB  \
        MVII    #SINK_MOB_TBL, R0   // 55AC   |- Normal sink animation
        B       L_55B5              // 55AF  /   (timeout vect releases cursor)

L_55B1: SDBD                        // 55B1  \_ Pirate sink animation
        MVII    #PSNK_MOB_TBL, R0   // 55B2  /  (no timeout vector)

L_55B5: MVO@    R0,     R1          // 55B5  Sink the ship.
        
        ADDI    #$0005, R1          // 55B6  \
        MVII    #$0030, R0          // 55B8   |- Set animation rate
        MVO@    R0,     R1          // 55BA  /
        JSR     R5,     L_5FA8      // 55BB  Play sinking ship sound.

        PULR    R7                  // 55BE  Leave.

        // ---------------------------------------------------------------- //
        //  Fishing boat interacts w/ other player's boat.                  //
        // ---------------------------------------------------------------- //
L_55BF: PSHR    R5                  // 55BF  
        MOVR    R3,     R0          // 55C0  
        MOVR    R1,     R2          // 55C1  

        JSR     R5, X_GET_MOB_ADDR  // 55C2  Look up other MOB

        ADDI    #$0001, R1          // 55C5  \
        MVI@    R1,     R0          // 55C7   |_ Is it a PT boat?
        SDBD                        // 55C8   |
        CMPI    #PTBO_MOB_TBL, R0   // 55C9  /
        BNEQ    L_55D8              // 55CC  Nope:  Leave.

        MOVR    R2,     R1          // 55CE  

        JSR     R5, FORT_NEAR_MOB   // 55CF  Is there a fort nearby?

        TSTR    R1                  // 55D2  \__ Yes:  See if fort is
        BNEQ    L_55D9              // 55D3  /   for the other player 

L_55D5: MOVR    R2,     R1          // 55D5  \__ No:  Sink it!
        B       L_559A              // 55D6  /

L_55D8: PULR    R7                  // 55D8  Leave.

L_55D9: MVI     CURPLR, R1          // 55D9  \
        TSTR    R1                  // 55DB   |- Fort owned by player 0 or 1?
        BNEQ    L_55E3              // 55DC  /

        CMPI    #$032D, R2          // 55DE  \__ Player 0 fort but ship is
        BNEQ    L_55D5              // 55E0  /   player 1?  Sink it.
        PULR    R7                  // 55E2  Leave.

L_55E3: CMPI    #$0335, R2          // 55E3  \__ Player 1 fort but ship is
        BNEQ    L_55D5              // 55E5  /   player 0?  Sink it.
        PULR    R7                  // 55E7  Leave.

        // ---------------------------------------------------------------- //
        //  Release cursor after sinking un-parked boat.                    //
        // ---------------------------------------------------------------- //
L_55E8: PSHR    R5                  // 55E8  
        MVI@    R1,     R2          // 55E9  \
        SDBD                        // 55EA   |_ Mark MOB invisible
        XORI    #$1000, R2          // 55EB   |
        MVO@    R2,     R1          // 55EE  /

        MVI     G_032C, R3          // 55EF  Get saved boat-type

        MOVR    R1,     R2          // 55F1  \
        CMPI    #$032D, R1          // 55F2   |- Player 0 or 1?
        BNEQ    L_560C              // 55F4  /

        // reinit player 0's cursor
        SDBD                        // 55F6  \
        CMPI    #PTBO_MOB_TBL, R3   // 55F7   |- Was it a PT boat?  If so
        BEQ     L_5601              // 55FA  /   just release cursor.

        MVI     F_BO_0, R0          // 55FC  \
        DECR    R0                  // 55FE   |- Otherwise decrement player 0
        MVO     R0,     F_BO_0      // 55FF  /   fishing boat count.

L_5601: CLRR    R1                  // 5601  \__ Set player 0's cursor mode
        MVO     R1,     CURS_0      // 5602  /   back to "cursor"

        SDBD                        // 5604  \__ Re-init player 0's cursor MOB
        MVII    #PLY0_MOB_INIT, R1  // 5605  /

L_5608: JSR     R5,     X_INIT_MOB  // 5608  \__ Set up cursor MOB and leave
        PULR    R7                  // 560B  /

        // reinit player 1's cursor
L_560C: SDBD                        // 560C  \
        CMPI    #PTBO_MOB_TBL, R3   // 560D   |- Was it a PT boat?  If so
        BEQ     L_5617              // 5610  /   just release cursor.

        MVI     F_BO_1, R0          // 5612  \
        DECR    R0                  // 5614   |- Otherwise, decrement player 1
        MVO     R0,     F_BO_1      // 5615  /   fishing boat count.

L_5617: CLRR    R1                  // 5617  \__ Set player 1's cursor mode
        MVO     R1,     CURS_1      // 5618  /   back to "cursor"

        SDBD                        // 561A  \
        MVII    #PLY1_MOB_INIT, R1  // 561B   |- Re-init player 1's cursor MOB
        B       L_5608              // 561E  /


        // ---------------------------------------------------------------- //
        //  Unparked fishing boat vs. pirate!                               //
        // ---------------------------------------------------------------- //
L_5620: PSHR    R5                  // 5620  

        JSR     R5, FORT_NEAR_MOB   // 5621  Is there a fort nearby?

        TSTR    R1                  // 5624  \__ Yes:  Leave.  Forts protect
        BNEQ    L_55D8              // 5625  /   all unparked ships from pirates

        MOVR    R2,     R1          // 5627  \__ No:  Next stop is Davy
        B       L_559A              // 5628  /        Jones' locker.


        // ---------------------------------------------------------------- //
        //  Kill a MOB and return.  (unused?)                               //
        // ---------------------------------------------------------------- //
        JSR     R5, X_KILL_MOB      // 562A   0004 0114 03AE
        PULR    R7                  // 562D   02B7

        // ---------------------------------------------------------------- //
        //  Unparked boat (fishing or PT) interacting with weather          //
        // ---------------------------------------------------------------- //
L_562E: PSHR    R5                  // 562E  
        MOVR    R3,     R0          // 562F  
        MOVR    R1,     R2          // 5630  

        JSR     R5, X_GET_MOB_ADDR  // 5631  Get address of weather MOB

        ADDI    #$0001, R1          // 5634  \
        MVI@    R1,     R0          // 5636   |_ Rain or hurricane?
        SDBD                        // 5637   |
        CMPI    #RAIN_MOB_TBL, R0   // 5638  / 
        BEQ     L_55D8              // 563B  Rain:  Leave.

        MOVR    R2,     R1          // 563D  \__ Hurricane:  Buh bye!
        B       L_559A              // 563E  /

        // ---------------------------------------------------------------- //
        //  Unparked PT boat interacting with pirate                        //
        // ---------------------------------------------------------------- //
L_5640: PSHR    R5                  // 5640  
        MOVR    R3,     R0          // 5641  

        JSR     R5, X_GET_MOB_ADDR  // 5642  Get pirate's MOB data ptr

        ADDI    #$0004, R1          // 5645  \
        CLRR    R0                  // 5647   |- Halt the pirate.
        MVO@    R0,     R1          // 5648  /
        PULR    R7                  // 5649  

        // ---------------------------------------------------------------- //
        //  Look for a fort within 1 square of a MOB.                       //
        // ---------------------------------------------------------------- //
FORT_NEAR_MOB:
L_564A: PSHR    R5                  // 564A  
        PSHR    R1                  // 564B  

        JSR     R5, MOB_TO_CARD     // 564C  Convert MOB position to card posn

L_564F: CLRR    R0                  // 564F  First search positive offsets

L_5650: SDBD                        // 5650  \__ Point to neighbor offset table
        MVII    #NBR_TBL, R4        // 5651  /

L_5654: MVI@    R4,     R1          // 5654  Get neighbor offset

        TSTR    R0                  // 5655  \__ Add or subtract?
        BNEQ    L_565B              // 5656  /

        ADDR    R2,     R1          // 5658  \__ R0 = 0:  Add neighbor offset
        B       L_565F              // 5659  /

L_565B: PSHR    R2                  // 565B  \
        SUBR    R1,     R2          // 565C   |_ R0 = 1:  Sub neighbor offset
        MOVR    R2,     R1          // 565D   |
        PULR    R2                  // 565E  /

L_565F: MVI@    R1,     R3          // 565F  Get card 
        SLR     R3,     2           // 5660  \
        SLR     R3,     1           // 5661   |_ Is it a fort?
        ANDI    #$00FF, R3          // 5662   |
        CMPI    #$0001, R3          // 5664  /
        BEQ     L_567A              // 5666  

        SDBD                        // 5668  \__ Are we at end of table?
        CMPI    #NBR_TBL+4, R4      // 5669  /
        BEQ     L_5670              // 566C  Yes:  Go around outer loop
        B       L_5654              // 566E  No:   Get next offset.

L_5670: TSTR    R0                  // 5670  \_ We did both pos and neg?
        BNEQ    L_5677              // 5671  /  Yes:  Leave, no fort found.

        MVII    #$0001, R0          // 5673  \_ Do negative offsets
        B       L_5650              // 5675  /

L_5677: CLRR    R1                  // 5677  \
        PULR    R2                  // 5678   |- No fort found.  Leave.
        PULR    R7                  // 5679  /

L_567A: MVI@    R1,     R3          // 567A  \
        SLLC    R3,     2           // 567B   |- Whose fort is it?  CURPLR
        BOV     L_5686              // 567C  /   or other player?

        MVII    #$0001, R3          // 567E  Player 1's fort

L_5680: MVO     R3,     CURPLR      // 5680  Remember which player's fort
        MVII    #$0001, R1          // 5682  We found a fort!
        PULR    R2                  // 5684  \_ return
        PULR    R7                  // 5685  /

L_5686: CLRR    R3                  // 5686  Player 0's fort
        B       L_5680              // 5687  

        // Offsets for looking around a square for a fort.
        //   +1, +19, +20, +21 => E, SW, S, SE
        //   -1, -19, -20, -21 => W, NE, N, NW
NBR_TBL:
        DECLE   $0001, $0013, $0014, $0015      // 5689   0001 0013 0014 0015

        // ---------------------------------------------------------------- //
        //  Look for a fort within 1 square of a card.                      //
        //  Reuses code above for fort within 1 square of MOB.              //
        // ---------------------------------------------------------------- //
FORT_NEAR_CARD:
L_568D: PSHR    R5                  // 568D  
        PSHR    R1                  // 568E  
        B       L_564F              // 568F  


        // ---------------------------------------------------------------- //
        //  Weather interacting with the background cards.                  //
        // ---------------------------------------------------------------- //
WTHR_V_LAND:
L_5691: PSHR    R5                  // 5691   
        MOVR    R1,     R2          // 5692   
        INCR    R2                  // 5693   \_ Get MOB ROM data ptr
        MVI@    R2,     R3          // 5694   /
        SDBD                        // 5695   Is it a hurricane?
        CMPI    #HURR_MOB_TBL, R3   // 5696   (Have you ever seen a him-a-cane?)
        BNEQ    L_56A1              // 5699   Not a hurricane.

        MVII    #$0005, R2          // 569B   Damage rate = 5 for hurricane

L_569D: MVO     R2,     DMG_RT      // 569D   Store probability of death
        B       L_56AF              // 569F   Evaluate card

L_56A1: MVI@    R1,     R0          // 56A1   \
        ANDI    #$0010, R0          // 56A2    |_ Rain or tropical storm?
        TSTR    R0                  // 56A4    |  (look at bit 3 of color)
        BNEQ    L_56AB              // 56A5   /

        MVII    #$0001, R2          // 56A7   \__ Damage rate = 1 
        B       L_569D              // 56A9   /   for tropical storm

L_56AB: CLRR    R2                  // 56AB   Rain:  Doesn't kill anything
        B       L_569D              // 56AC   Store and continue.

        PULR    R7                  // 56AE   Unreached?

L_56AF: JSR     R5, MOB_TO_CARD     // 56AF   \_ What's under the weather?
        MVI@    R2,     R3          // 56B2   /


        SLLC    R3,     1           // 56B3   Bit 15 = 0 means nothing there
        BNC     L_56FF              // 56B4   If nothing, do... what?

        SLLC    R3,     1           // 56B6   \_ Player 0 or 1?
        BNC     L_5701              // 56B7   /

        CLRR    R0                  // 56B9   Bit 14 = 1:  Player 0
        MVO     R0,     CURPLR      // 56BA   

L_56BC: MVII    #TDMG_0,R1          // 56BC   \_ Point to damage accumulator
        ADD     CURPLR, R1          // 56BE   /  for player
        PSHR    R1                  // 56C0   
        MVI@    R1,     R0          // 56C1   \_ Add damage at current rate
        ADD     DMG_RT, R0          // 56C2   /
        CMPI    #$007D, R0          // 56C4   Cum damage bigger than 125?
        BLT     L_56FD              // 56C6   No:  Just store update

        // Weather takes out a structure.  Bam!
        MVI@    R2,     R3          // 56C8   \
        SLR     R3,     2           // 56C9    |_ Extract type of item in card
        SLR     R3,     1           // 56CA    |
        ANDI    #$00FF, R3          // 56CB   /
        CMPI    #$000A, R3          // 56CD   Not an item?
        BGE     L_56FD              // 56CF   Ok, fine.  Leve.

        JSR     R5,     L_570D      // 56D1   Decrement item count 

        CMPI    #$0009, R3          // 56D4   \
        BEQ     L_5707              // 56D6    |_ Animate sinking boats
        CMPI    #$0008, R3          // 56D8    |
        BEQ     L_5707              // 56DA   /

        // Ring up the casualties
        MVII    #POPU_0,R4          // 56DC   \__ Point to the population
        JSR     R5,     L_5A29      // 56DE   /   for this player

        MVII    #$0065, R0          // 56E1   \__ From 0 to 101 casualties
        JSR     R5,     X_RAND2     // 56E3   /

        SDBD                        // 56E6   \
        MVI@    R4,     R1          // 56E7    |
        SUBR    R0,     R1          // 56E8    |
        SUBI    #$0002, R4          // 56E9    |- Subtract off the casualties
        MVO@    R1,     R4          // 56EB    |  (Note: No check for -ve!)
        SWAP    R1,     1           // 56EC    |
        MVO@    R1,     R4          // 56ED   /

        MVI@    R2,     R3          // 56EE   \
        SDBD                        // 56EF    |_ Blank out the tile from
        ANDI    #$7800, R3          // 56F0    |  the island
        XORI    #$0003, R3          // 56F3   /

        JSR     R5,     L_571C      // 56F5   Look up original island graphic

        MVO@    R3,     R2          // 56F8   Store it out to the island

        CLRR    R0                  // 56F9   
        JSR     R5,     L_5FB6      // 56FA   Play "you've been smited" sfx

L_56FD: PULR    R1                  // 56FD   \_ Store accumulated damage
        MVO@    R0,     R1          // 56FE   /

L_56FF: B       L_573E              // 56FF   0200 003D

L_5701: MVII    #$0001, R1          // 5701   Bit 14 = 0:  Player 1
        MVO     R1,     CURPLR      // 5703   
        B       L_56BC              // 5705   Continue evaluating weather

L_5707: PULR    R1                  // 5707   \_ Animate the sinking ship
        JSR     R5,     L_5591      // 5708   /
        B       L_573E              // 570B   

        // ---------------------------------------------------------------- //
        //  Decrement item count for a particular item type.                //
        // ---------------------------------------------------------------- //
L_570D: PSHR    R5                  // 570D  
        MVII    #FORT_0 - 2, R4     // 570E  \
        ADDR    R3,     R4          // 5710   |- Index into "count of things"
        ADDR    R3,     R4          // 5711  /   table by item type number
        ADD     CURPLR, R4          // 5712  Pick slot for current player
        MVI@    R4,     R0          // 5714  \
        TSTR    R0                  // 5715   |- Don't decrement below zero
        BEQ     L_571B              // 5716  /   (should never happen?)

        DECR    R0                  // 5718  \
        DECR    R4                  // 5719   |- Decrement and store
        MVO@    R0,     R4          // 571A  /
L_571B: PULR    R7                  // 571B  Leave

        // ---------------------------------------------------------------- //
        //  Compute original island tile for square.                        //
        // ---------------------------------------------------------------- //
L_571C: PSHR    R5                  // 571C  \
        SDBD                        // 571D   |
        MVII    #LFT_ISLE_OFS_TBL,R5 //571E   |- Point to the offset and
        SDBD                        // 5721   |  picture tables for the islands
        MVII    #LFT_ISLE_PIC_TBL,R4 //5722  /

L_5725: MVI@    R5,     R0          // 5725  \
        ADDI    #$0200, R0          // 5726   |_ Scan through the offset table
        MVI@    R4,     R1          // 5728   |  looking for a matching offset
        CMPR    R0,     R2          // 5729  /
        BEQ     L_572E              // 572A  Found it!  
        B       L_5725              // 572C  Loop until we find it.
                                    //       Note:  An infinite loop might
                                    //       happen if R2 isn't a square on
                                    //       one of the islands.

L_572E: SLL     R1,     2           // 572E  \ 
        SLL     R1,     1           // 572F   |- Merge with formatting, flags
        XORR    R1,     R3          // 5730  /
        SDBD                        // 5731  \__ Toggle color stack advance
        XORI    #$2000, R3          // 5732  /
        INCR    R2                  // 5735  \ 
        MVI@    R2,     R1          // 5736   |
        SDBD                        // 5737   |_ Toggle color stack advance
        XORI    #$2000, R1          // 5738   |  of neighbor to the right
        MVO@    R1,     R2          // 573B   |
        DECR    R2                  // 573C  /
        PULR    R7                  // 573D  Return

        // ---------------------------------------------------------------- //
        //  Award gold if rain falls on crops.                              //
        // ---------------------------------------------------------------- //
L_573E: JSR     R5, GET_TILE_NO     // 573E   What's under the weather?

        CMPI    #$0003, R1          // 5741   \_ If not a crop, leave.
        BNEQ    L_5759              // 5743   /

        MVII    #RCRP_0,R3          // 5745   \
        ADD     CURPLR, R3          // 5747    |_ Increment crop rain counter
        MVI@    R3,     R2          // 5749    |  for player
        INCR    R2                  // 574A   / 
        CMPI    #$000C, R2          // 574B   Is it 12 yet?
        BLT     L_5758              // 574D   No:  Store update and leave

        CLRR    R2                  // 574F   Yes:  Reset counter
        MVO@    R2,     R3          // 5750   

        JSR     R5,     INC_GOLD    // 5751   You get a shiny gold bar!
        JSR     R5,     L_5F97      // 5754   Play the "rain-on-crop" sfx

        PULR    R7                  // 5757   Leave

L_5758: MVO@    R2,     R3          // 5758   Store updated rain counter
L_5759: PULR    R7                  // 5759   Leave

        // ---------------------------------------------------------------- //
        //  Display gold bars in status bar                                 //
        // ---------------------------------------------------------------- //
STAT_UPD_GOLD:
L_575A: PSHR    R5                  // 575A  Save return address
        MVI     BARINH, R1          // 575B  \   Is gold-bar display inhibited?
        TSTR    R1                  // 575D   |- Yes:  Leave. 
        BNEQ    L_58FD              // 575E  /   (58FD is PULR PC)

        MVII    #GOLD_0,R4          // 5760  \ 
        SDBD                        // 5762   |- Get gold bars for player 0
        MVI@    R4,     R0          // 5763  /

        MVII    #$0004, R1          // 5764  \
        CLRR    R3                  // 5766   |_ Display player 0's gold bars
        XORI    #$0004, R3          // 5767   |  in lower left
        MVII    #$02DD, R4          // 5769   |
        JSR     R5,     X_PRNUM_RGT // 576B  /

        MVII    #GOLD_1 R4          // 576E  \
        SDBD                        // 5770   |- Get gold bars for player 1
        MVI@    R4,     R0          // 5771  /
        B       L_59A5              // 5772  Display player 1's gold bars 

        // ---------------------------------------------------------------- //
        //  Controller disc input                                           //
        // ---------------------------------------------------------------- //
DISC_INPUT:
        PSHR    R5                  // 5774  Save return address
        MVO     R1,     CURPLR      // 5775  Remember which player this is
        TSTR    R1                  // 5777  \_ Player 0 or 1?
        BNEQ    L_5799              // 5778  /

        MVI     G_032E, R2          // 577A  Player 0 MOB ROM pointer

L_577C: MOVR    R0,     R1          // 577C   
        INCR    R0                  // 577D  \_ Disc-up event?
        BEQ     L_5796              // 577E  /

        SDBD                        // 5780  \
        CMPI    #F_BO_MOB_TBL, R2   // 5781   |- Is it a boat (fishing or PT)?
        BGE     L_579D              // 5784  /

        MVII    #$000F, R0          // 5786  Set velocity to 15 for cursor

L_5788: JSR     R5,     X_MOB_VEL   // 5788  Compute MOB velocity based on disc
                                    //       direction scaled by velocity

        MVI     CURPLR, R1          // 578B  \
        TSTR    R1                  // 578D   |- Player 0 or 1?
        BNEQ    L_5793              // 578E  /

        MVO     R0,     G_0331      // 5790  Store updated player 0 velocity
        PULR    R7                  // 5792   

L_5793: MVO     R0,     G_0339      // 5793  Store updated player 1 velocity
        PULR    R7                  // 5795   

L_5796: CLRR    R0                  // 5796  \_ Halt, hammerzeit!
        B       L_5788              // 5797  /

L_5799: MVI     G_0336, R2          // 5799  Player 1 MOB ROM pointer
        B       L_577C              // 579B  

L_579D: MVII    #$000A, R0          // 579D  \_ Set velocity to 10 for boats
        B       L_5788              // 579F  /


        // ---------------------------------------------------------------- //
        //  Numeric keypad input during main game                           //
        // ---------------------------------------------------------------- //
KEYPAD_INP:
        PSHR    R5                  // 57A1  Save return address

        MVO     R1,     CURPLR      // 57A2  Remember *who* pressed this key
        MVO     R0,     CURSEL      // 57A4  Remember what key they pressed.

        CMPI    #$0001, R0          // 57A6  Is this an item?
        BGE     L_57B4              // 57A8  Yes: Go handle it.

        // Key 0: Toggle cursor modes
        MVII    #$019B, R2          // 57AA  \
        ADD     CURPLR, R2          // 57AC   |- Get current cursor mode
        MVI@    R2,     R1          // 57AE  / 
        TSTR    R1                  // 57AF  
        BEQ     UNPARK_BOAT         // 57B0  Zero:       Try to pick up boat 
        B       PARK_BOAT           // 57B2  Non-zero:   Try to park boat

L_57B4:
        MVII    #SLCT_0,R2          // 57B4  \
        ADD     CURPLR, R2          // 57B6   |- Get this player's current
        MVI@    R2,     R1          // 57B8  /   selection state
        CMPI    #$0009, R0          // 57B9  \__ 1..9: trying to buy something
        BLE     L_57CB              // 57BB  /   See if there's existing sel.
        
                                    //       R0 = $A for clear, $B for enter

        CMPI    #$0014, R1          // 57BD  \_ Clear or enter while no
        BGE     L_5941              // 57BF  /  current selection?  RAZZ

        MVO     R1,     CURSEL      // 57C1  Copy this player's sel to CURSEL

        MVII    #$0014, R1          // 57C3  \_ Clear player's current selection
        MVO@    R1,     R2          // 57C5  /

        CMPI    #$000B, R0          // 57C6  \_ Try to buy if pressed enter
        BEQ     L_5877              // 57C8  /
        PULR    R7                  // 57CA  Else leave.

L_57CB: CMPI    #$0014, R1          // 57CB  \_ If existing sel is not $14, 
        BNEQ    L_5941              // 57CD  /  then RAZZ the player.

        MVO@    R0,     R2          // 57CF  Set player's current selection...
        PULR    R7                  // 57D0  ...and leave

L_57D1:
        MVI     CURPLR, R2          // 57D1  \
        TSTR    R2                  // 57D3   |_ Point to MOB #2 (plyr 0)
        BNEQ    L_5810              // 57D4   |  or #3 (plyr 1) for CURPLR
        MVII    #$032D, R1          // 57D6  /

        // Pick up a boat (PT or fishing) with the cursor.
UNPARK_BOAT:
L_57D8: JSR     R5, MOB_TO_CARD     // 57D8  Get card position under cursor

        MVI@    R2,     R0          // 57DB  Read card from display
        MOVR    R0,     R3          // 57DC  
        SLLC    R3,     2           // 57DD  \_ Bit 14 = 0  ==> owned by plyr 1
        BOV     L_5814              // 57DE  /  Bit 14 = 1  ==> owned by plyr 0

        MVI     CURPLR, R3          // 57E0  \
        TSTR    R3                  // 57E2   |- Razz if owned by player 1
        BEQ     L_5941              // 57E3  /   but CURPLR is 0

L_57E5: JSR     R5, GET_TILE_NO     // 57E5  What kind of thing under cursor?

        CMPI    #$0008, R1          // 57E8  \_ PT boat?  Ok!
        BEQ     L_57F2              // 57EA  /

        CMPI    #$0009, R1          // 57EC  \_ Fishing boat?  Ok!
        BEQ     L_57F2              // 57EE  /
        B       L_5941              // 57F0  Neither:  RAZZ!

L_57F2: SDBD                        // 57F2  \
        ANDI    #$3007, R0          // 57F3   |- Remove boat card from BACKTAB
        MVO@    R0,     R2          // 57F6  /

        MVI     CURPLR, R4          // 57F7  \_ Player 0 or 1?
        TSTR    R4                  // 57F9  /
        BNEQ    L_581B              // 57FA  Branch if player 1

        MVII    #$032E, R2          // 57FC  Player 0 MOB ROM pointer word
        MVO     R1,     CURS_0      // 57FE  Boat type to player 0 cursor mode

L_5800: CMPI    #$0008, R1          // 5800  \_ PT boat?  
        BEQ     L_580A              // 5802  /  Yes: branch

        SDBD                        // 5804  \_ Fishing boat.  Point to fishing
        MVII    #F_BO_MOB_TBL, R1   // 5805  /  boat MOB table.

L_5808: MVO@    R1,     R2          // 5808  Update MOB ROM table pointer
        PULR    R7                  // 5809  Leave

L_580A: SDBD                        // 580A  \_ PT boat.  Point to PT boat MOB
        MVII    #PTBO_MOB_TBL, R1   // 580B  /  table
        B       L_5808              // 580E  Update and leave

L_5810: MVII    #$0335, R1          // 5810  MOB #3 for player 1
        B       L_57D8              // 5812  

L_5814: MVI     CURPLR, R3          // 5814  \
        TSTR    R3                  // 5816   |- Owned by player 0.
        BNEQ    L_5941              // 5817  /   RAZZ if CURPLR = 1
        B       L_57E5              // 5819  Continue unparking boat

L_581B: MVII    #$0336, R2          // 581B  Player 1 MOB ROM pointer word
        MVO     R1,     CURS_1      // 581D  Boat type to player 1 cursor mode
        B       L_5800              // 581F  Continue unparking the boat

        // Put a boat back down, returning the cursor
PARK_BOAT:
L_5821: MVI     CURPLR, R2          // 5821  
        MOVR    R1,     R4          // 5823  \
        TSTR    R2                  // 5824   |_ Point R1 to CURPLR's 
        BNEQ    L_5869              // 5825   |  MOB data in RAM
        MVII    #$032D, R1          // 5827  /

L_5829: INCR    R1                  // 5829  \_ Get ROM data pointer
        MVI@    R1,     R2          // 582A  /
        SDBD                        // 582B  \   Ship sinking?  Time for
        CMPI    #SINK_MOB_TBL, R2   // 582C   |- Nelson Muntz:  "Ha ha!"
        BEQ     L_5941              // 582F  /   RAZZ.

        DECR    R1                  // 5831  Point back to base of MOB data

        JSR     R5, MOB_TO_CARD     // 5832  Index to display card for MOB

        MVI@    R2,     R0          // 5835 \
        MOVR    R0,     R3          // 5836  |
        SDBD                        // 5837  |- Anything in this card?
        ANDI    #$07F8, R3          // 5838  |
        TSTR    R3                  // 583B /
        BNEQ    L_5941              // 583C Yes:  Can't park here.  RAZZ!

        CMPI    #$02DB, R2          // 583E Fishing in the status bar?
        BGT     L_5941              // 5840 Yes:  RAZZ!

        CMPI    #$0008, R4          // 5842 \_ PT boat?
        BEQ     L_5863              // 5844 /

        SDBD                        // 5846 \_ Merge fishing boat graphic 
        XORI    #$8848, R0          // 5847 /  into display word

L_584A: SDBD                        // 584A  \_ strip color from display word
        ANDI    #$FFF8, R0          // 584B  /

        MVI     CURPLR, R3          // 584E  \
        TSTR    R3                  // 5850   |- Player 0 or 1?
        BNEQ    L_586D              // 5851  /

        SDBD                        // 5853  \_ Green card owned by player 0
        XORI    #$4004, R0          // 5854  /  (bit 14 set)
        MVO@    R0,     R2          // 5857  Put on display.
        MVII    #$032E, R2          // 5858  ROM pointer word in MOB #2 data
        CLRR    R1                  // 585A  \_ Player 0 cursor mode = cursor
        MVO     R1,     CURS_0      // 585B  /

L_585D: SDBD                        // 585D  \
        MVII    #CURS_MOB_TBL, R1   // 585E   |- Set ROM pointer for MOB to 
        B       L_5808              // 5861  /   cursor MOB data and leave

L_5863: SDBD                        // 5863  \
        XORI    #$8840, R0          // 5864   |- Merge PT boat graphic into
        B       L_584A              // 5867  /   display word

L_5869: MVII    #$0335, R1          // 5869  \_ Player 1's MOB data
        B       L_5829              // 586B  /

L_586D: XORI    #$0002, R0          // 586D  Red card owned by player 1
        MVO@    R0,     R2          // 586F  Put on display
        MVII    #$0336, R2          // 5870  ROM pointer word in MOB #3 data
        CLRR    R1                  // 5872  \_ Player 1 cursor mode = cursor
        MVO     R1,     CURS_1      // 5873  /
        B       L_585D              // 5875  Set ROM ptr to cursor and leave


        // Is it ok to buy this item at this location?
L_5877: MVI     CURSEL, R0          // 5877  \_ Who and what is making 
        MVI     CURPLR, R1          // 5879  /  the purchase?

        CMPI    #$0007, R0          // 587B  \_ Can always buy rebels 
        BEQ     L_58A0              // 587D  /  regardless of where cursor is.

        CMPI    #$0008, R0          // 587F  \_ Boats: Check for 
        BGE     L_5924              // 5881  /  boat in harbor first

        TSTR    R1                  // 5883  \   Point to MOB 2 or 3 based
        BNEQ    L_5919              // 5884   |- on the setting of CURPLR.
        MVII    #$032D, R1          // 5886  /  

L_5888: JSR     R5, MOB_TO_CARD     // 5888  Convert to card posn

        MVI     CURSEL, R0          // 588B  Load item # to buy

        JSR     R5, GRAM_OR_GROM    // 588D  Is this tile GRAM/GROM

        BEQ     L_5941              // 5890  GROM: Error!  Not on an island!

        MVI@    R2,     R1          // 5892  \
        MOVR    R1,     R3          // 5893   |_ Which island is this?
        SLLC    R3,     2           // 5894   |  (Stored in bit 14)
        BOV     L_591D              // 5895  /

        MVI     CURPLR, R3          // 5897  \   Bit 14 = 0:  Better
        TSTR    R3                  // 5899   |- be player 1, else RAZZ!
        BEQ     L_5941              // 589A  /

L_589C: MOVR    R1,     R3          // 589C  \
        SLLC    R3,     1           // 589D   |- Better be empty (bit 15=0)
        BC      L_5941              // 589E  /   else RAZZ!

        //  Buy something!  (Or fail if you don't have enough money.)
        //
        //  R1 contains card from island, which is set to have the appropriate
        //  bit 14 value for this player.
L_58A0: SDBD                        // 58A0  \
        MVII    #PRICES-1, R3       // 58A1   |
        ADDR    R0,     R3          // 58A4   |- Look up the item's price
        MVO     R1,     G_0324      // 58A5   |  (save R1 in $324 temporarily)
        MVI@    R3,     R1          // 58A7  /
        MVII    #GOLD_0,R4          // 58A8  \
        ADD     CURPLR, R4          // 58AA   |
        ADD     CURPLR, R4          // 58AC   |_ Does this player have enough
        SDBD                        // 58AE   |  gold to afford the item?
        MVI@    R4,     R0          // 58AF   |
        CMPR    R1,     R0          // 58B0  /
        BLT     L_5941              // 58B1  Nope:  RAZZ!

        SUBR    R1,     R0          // 58B3  \
        SUBI    #$0002, R4          // 58B4   |
        MVO@    R0,     R4          // 58B6   |- Yes:  Deduct the price from
        SWAP    R0,     1           // 58B7   |  the player's gold bars
        MVO@    R0,     R4          // 58B8  /

        MVI     CURSEL, R0          // 58B9  \
        CMPI    #$0007, R0          // 58BB   |- Is player buying a rebel?
        BNEQ    L_58CA              // 58BD  /   (item #7 is rebel)

        JSR     R5,     L_594C      // 58BF  Create a rebel (toggles CURPLR)
        JSR     R5,     L_595A      // 58C2  Toggle CURPLR back

        CLRR    R1                  // 58C5  \_ Rebels are computer-generated
        MVO     R1,     RBLTYP      // 58C6  /  by default
                                    //          
        B       L_58FD              // 58C8  Leave

L_58CA:
        MVI     G_0324, R1          // 58CA  Restore R1 
        SLL     R0,     2           // 58CC  \_ Shift the item number into
        SLL     R0,     1           // 58CD  /  the card # position.
        MVI     CURSEL, R3          // 58CE  \
        CMPI    #$0008, R3          // 58D0   |- Is it a boat?
        BGE     L_58D8              // 58D2  /   (PT or Fishing)

        SDBD                        // 58D4  \_ No:  Preserve bits 14-11 only
        ANDI    #$7800, R1          // 58D5  /
L_58D8:
        SDBD                        // 58D8  \_ turn bit 15 on, toggle bit 13
        XORI    #$A000, R1          // 58D9  /  (color-stack advance bit)
        XORR    R0,     R1          // 58DC  Merge in the item's card #
        MVI     CURSEL, R0          // 58DD  \
        CMPI    #$0008, R0          // 58DF   |- Were we buying a boat?
        BGE     L_58F1              // 58E1  /   Just write it out as-is

        SDBD                        // 58E3  \
        ADDI    #COLORS-1, R0       // 58E4   |
        MOVR    R0,     R3          // 58E7   |- Merge in color for the item
        MVI@    R3,     R0          // 58E8   |
        XORR    R0,     R1          // 58E9  /
        MVO@    R1,     R2          // 58EA  Write it out to the island
        INCR    R2                  // 58EB  
        MVI@    R2,     R1          // 58EC  \
        SDBD                        // 58ED   |- Toggle color-stack advance
        XORI    #$2000, R1          // 58EE  /   on neighboring card

L_58F1: MVO@    R1,     R2          // 58F1  Either display boat, or complete
                                    //       color-stack advance toggle 

        MVI     CURSEL, R0          // 58F2  \
        MVII    #FORT_0 - 2, R1     // 58F4   |
        ADDR    R0,     R1          // 58F6   |  Increment the count of 
        ADDR    R0,     R1          // 58F7   |_ "items of this type" 
        ADD     CURPLR, R1          // 58F8   |  for this player.  Note that
        MVI@    R1,     R0          // 58FA   |  rebels do not get counted.
        INCR    R0                  // 58FB   |  
        MVO@    R0,     R1          // 58FC  /

L_58FD: PULR    R7                  // 58FD  return

        // Input dispatcher routine used while entering game parameters.
INPUT_DISP:
        BIDECLE $0000               // 58FE  
        BIDECLE KEYPAD_FORCE_0      // 5900  only accept keypad input,
                                    //       and force all input to look like
                                    //       it came from player 0
        BIDECLE $0000               // 5902  
        BIDECLE $0000               // 5904  

        // Note:  First two colors in color table also form BIDECLE 0
        // for last entry in the input dispatch table above.  Nice hack.
COLORS: DECLE   C_BLK               // 5906  Fort        Black
        DECLE   C_BLK               // 5907  Factory     Black
        DECLE   C_DGR               // 5908  Crop        Dark Green
        DECLE   C_WHT               // 5909  School      White
        DECLE   C_RED               // 590A  Hospital    Red
        DECLE   C_YEL               // 590B  House       Yellow
        DECLE   C_BLK               // 590C  Rebel       Black
        DECLE   0                   // 590D  PT Boat -- color set by code
        DECLE   0                   // 590E  Fishing boat -- color set by code

        DECLE   0                   // 590F  ?
                                   
PRICES: DECLE   50                  // 5910  Fort          50 bars
        DECLE   40                  // 5911  Factory       40 bars
        DECLE   3                   // 5912  Crop           3 bars
        DECLE   35                  // 5913  School        35 bars
        DECLE   75                  // 5914  Hospital      75 bars
        DECLE   60                  // 5915  House         60 bars
        DECLE   30                  // 5916  Rebel         30 bars
        DECLE   40                  // 5917  PT boat       40 bars
        DECLE   25                  // 5918  Fishing boat  25 bars
L_5919:                           
        MVII    #$0335, R1          // 5919  MOB #3 for player 1
        B       L_5888              // 591B  
                                  
L_591D:                           
        MVI     CURPLR, R3          // 591D  \   Bit 14=1.  Better be player 1,
        TSTR    R3                  // 591F   |- else RAZZ!
        BNEQ    L_5941              // 5920  /
        B       L_589C              // 5922  Continue checks...
                                  
        // Boat in the harbor?
L_5924: TSTR    R1                  // 5924  \_ Player 0 or 1?
        BEQ     L_5934              // 5925  /
                                  
        MVII    #$0262, R2          // 5927  Check player 1's harbor
        MVI@    R2,     R1          // 5929  \
        SDBD                        // 592A   |  Get card, strip color
        ANDI    #$FFF8, R1          // 592B   |- force red, toggle cstk adv.
        SDBD                        // 592E   |  Bit 14 = 0 (owned by plyr 1)
        XORI    #$2802, R1          // 592F  /
        B       L_589C              // 5932  Was it empty?  No: RAZZ!
                                  
L_5934:                           
        MVII    #$027A, R2          // 5934  Check player 0's harbor
        MVI@    R2,     R1          // 5936  \
        SDBD                        // 5937   |  Get card, strip color
        ANDI    #$FFF8, R1          // 5938   |- force dk grn, toggle cstk adv.
        SDBD                        // 593B   |  Bit 14 = 1 (owned by plyr 0)
        XORI    #$6804, R1          // 593C  /
        B       L_589C              // 593F  Was it empty?  No: RAZZ!

L_5941:
        JSR     R5, X_PLAY_RAZZ2    // 5941  Play razz sound

        MVII    #$0014, R0          // 5944  \
        MVII    #SLCT_0,R2          // 5946   |_ Reset this player's 
        ADD     CURPLR, R2          // 5948   |  "current selection"
        MVO@    R0,     R2          // 594A  /

        PULR    R7                  // 594B  Return

        // Purchase a mercernary rebel
L_594C: PSHR    R5                  // 594C  
        MVII    #$0001, R1          // 594D  \_ Set flag indicating this is
        MVO     R1,     RBLTYP      // 594F  /  a mercernary (purchased) rebel 

        JSR     R5,     L_595A      // 5951  Toggle CURPLR

        CLRR    R0                  // 5954  \_ Reset rebel placement retry
        MVO     R0,     RBLTRY      // 5955  /  counter 
        J       L_5BE8              // 5957  Create the rebel 

        // Toggle CURPLR between 0 and 1.
        // This is hilariously inefficient.
L_595A: PSHR    R5                  // 595A  
        MVI     CURPLR, R1          // 595B  \
        TSTR    R1                  // 595D   |- If it's player 1, set it to 0
        BNEQ    L_5964              // 595E  /
                                   
        MVII    #$0001, R1          // 5960  \__ else set it to 1
        B       L_5965              // 5962  /
                                   
L_5964: CLRR    R1                  // 5964  
L_5965: MVO     R1,     CURPLR      // 5965  
        PULR    R7                  // 5967  

        // ---------------------------------------------------------------- //
        //  Convert MOB coordinates to a BACKTAB display card address       //
        //                                                                  //
        //  INPUT                                                           //
        //      R1  Pointer to MOB record in RAM                            //
        //                                                                  //
        //  OUTPUT                                                          //
        //      R1  trashed                                                 //
        //      R2  BACKTAB address of card under center of MOB             //
        //      R3  trashed                                                 //
        // ---------------------------------------------------------------- //
MOB_TO_CARD:
L_5968: PSHR    R5                  // 5968  Save return address
        MOVR    R1,     R3          // 5969  Copy MOB record ptr to R3
        ADDI    #$0002, R3          // 596A  \
        MVI@    R3,     R1          // 596C   |_ Get integer portion of X coord
        SWAP    R1,     1           // 596D   |
        ANDI    #$00FF, R1          // 596E  /
        ADDI    #$0004, R1          // 5970  \
        SLR     R1,     2           // 5972   |_ X_card = (X_coord + 4) / 8 - 1
        SLR     R1,     1           // 5973   |
        DECR    R1                  // 5974  /
        INCR    R3                  // 5975  \
        MVI@    R3,     R2          // 5976   |_ Get integer portion of Y coord
        SWAP    R2,     1           // 5977   |
        ANDI    #$00FF, R2          // 5978  /
        ADDI    #$0004, R2          // 597A  \
        SLR     R2,     2           // 597C   |_ Y_card = (Y_coord + 4) / 8 - 1
        SLR     R2,     1           // 597D   |
        DECR    R2                  // 597E  /
        PSHR    R2                  // 597F  \
        SLL     R2,     2           // 5980   |
        PULR    R2                  // 5981   |_ R2 = Y_card*20 + X_card + $200
        SLL     R2,     2           // 5982   |
        ADDR    R1,     R2          // 5983   |
        ADDI    #$0200, R2          // 5984  /
        PULR    R7                  // 5986  Return

        // ---------------------------------------------------------------- //
        //  Display (undisplay) current score                               //
        //                                                                  //
        //  INPUTS                                                          //
        //      R0  Display/undisplay  (>= 0 for disp, <0 for undisp)       //
        //      R1  Player number (0 or 1)                                  //
        // ---------------------------------------------------------------- //
DISP_SCORE:
L_5987:
        PSHR    R5                  // 5987  Save return address
        TSTR    R0                  // 5988  R0 < 0 is key release
        BMI     L_59A1              // 5989  If negative, undisplay

        MVO     R7,     BARINH      // 598B  Suppress gold bar display

        MVII    #SCOR_0,R4          // 598D  \
        ADDR    R1,     R4          // 598F   |_ Get player score
        ADDR    R1,     R4          // 5990   |  (R1 is 0 or 1 for 
        SDBD                        // 5991   |  player number.)
        MVI@    R4,     R0          // 5992  /
L_5993:
        TSTR    R1                  // 5993  Is this player 0 or 1?
        BNEQ    L_59A5              // 5994  Player 1:  Display in lwr rgt

        MVII    #$02DD, R4          // 5996  \
        CLRR    R3                  // 5998   |- Display in lower left
        XORI    #$0004, R3          // 5999  / 

L_599B: MVII    #$0004, R1          // 599B  \_ display a 4 digit number
        JSR     R5, X_PRNUM_RGT     // 599D  /

        PULR    R7                  // 59A0  Return

L_59A1: CLRR    R1                  // 59A1  \
        MVO     R1,     BARINH      // 59A2   |- Uninhibit gold bar disp.
        PULR    R7                  // 59A4  /

        // This fragment gets reused from multiple places.
L_59A5: MVII    #$02EB, R4          // 59A5  \
        CLRR    R3                  // 59A7   |_ Display value in player 1's
        XORI    #$0002, R3          // 59A8   |  status area.
        B       L_599B              // 59AA  /

        // ---------------------------------------------------------------- //
        //  Display round score unconditionally                             //
        //                                                                  //
        //  INPUTS                                                          //
        //      R1  Player number (0 or 1)                                  //
        // ---------------------------------------------------------------- //
DISP_ROUND_U:
L_59AC:
        PSHR    R5                  // 59AC  Save return address
        MVII    #RSCO_0,R2          // 59AD  \
        ADDR    R1,     R2          // 59AF   |- Get ???? for player
        MVI@    R2,     R0          // 59B0  /
        B       L_5993              // 59B1  Display (reuse logic above)

        // ---------------------------------------------------------------- //
        //  Display (undisplay) island population                           //
        //                                                                  //
        //  INPUTS                                                          //
        //      R0  Display/undisplay  (>= 0 for disp, <0 for undisp)       //
        //      R1  Player number (0 or 1)                                  //
        // ---------------------------------------------------------------- //
DISP_POP:
        PSHR    R5                  // 59B3  Save return address
        TSTR    R0                  // 59B4  Display or undisplay?
        BMI     L_59A1              // 59B5  If R0 < 0, undisplay

        MVO     R7,     BARINH      // 59B7  Inhibit gold bar display
        MVII    #POPU_0,R4          // 59B9  \
        ADDR    R1,     R4          // 59BB   |_ Get population for 
        ADDR    R1,     R4          // 59BC   |  this player's island
        SDBD                        // 59BD   |
        MVI@    R4,     R0          // 59BE  /
        B       L_5993              // 59BF  Display (reuse logic above)

        // ---------------------------------------------------------------- //
        //  Display (undisplay) round score for previous round              //
        //                                                                  //
        //  INPUTS                                                          //
        //      R0  Display/undisplay  (>= 0 for disp, <0 for undisp)       //
        //      R1  Player number (0 or 1)                                  //
        // ---------------------------------------------------------------- //
DISP_ROUND:
        PSHR    R5                  // 59C1  Save return address
        TSTR    R0                  // 59C2  Display or undisplay?
        BMI     L_59A1              // 59C3  If R0 < 0, undisplay

        MVO     R7,     BARINH      // 59C5  Inhibit gold bar display
        MVII    #RSCO_0,R4          // 59C7  \
        ADDR    R1,     R4          // 59C9   |- Get round score
        MVI@    R4,     R0          // 59CA  /
        B       L_5993              // 59CB  



// ======================================================================== //
//  The Main Round Scoring Routine!                                         //
// ======================================================================== //

L_59CD: PSHR    R5                  // 59CD  

        // ---------------------------------------------------------------- //
        //  Award gold to each player for the round.                        //
        // ---------------------------------------------------------------- //
        CLRR    R1                  // 59CE  \_ Score player 0 first
        MVO     R1,     CURPLR      // 59CF  /
L_59D1:
        // Award baseline gold for factories
        MVII    #FTRY_0,R1          // 59D1  \
        ADD     CURPLR, R1          // 59D3   |- Get number of factories
        MVI@    R1,     R0          // 59D5  /
        MVO     R0,     N_FTRY      // 59D6  Remember # of factories for later

        MVII    #$0004, R1          // 59D8  \
        JSR     R5,     X_MPY       // 59DA   |- Award 4 gold bars per factory
        JSR     R5,     AWARD_GOLD  // 59DD  /

        // Award baseline gold for fishing boats
        MVII    #F_BO_0,R1          // 59E0  \
        ADD     CURPLR, R1          // 59E2   |_ Award 1 gold bar per
        MVI@    R1,     R2          // 59E4   |  fishing boat
        JSR     R5,     AWARD_GOLD  // 59E5  /

        // Productivity bonus!  Award the smaller of:
        //  -- (Factories * (Schools + Hospitals) + Hospitals) gold bars
        //  -- 30 gold bars
        MVII    #SCHL_0,R1          // 59E8  \
        ADD     CURPLR, R1          // 59EA   |- Get number of schools
        MVI@    R1,     R0          // 59EC  /
        ADDI    #$0002, R1          // 59ED  \
        MVI@    R1,     R3          // 59EF   |- Add number of hospitals
        ADDR    R3,     R0          // 59F0  /
        MVI     N_FTRY, R1          // 59F1  Get number of factories

        JSR     R5,     X_MPY       // 59F3  Factories * (Schools + Hospitals)

        ADDR    R3,     R2          // 59F6  Add number of hospitals

        CMPI    #$001E, R2          // 59F7  \
        BLE     L_59FD              // 59F9   |- Clamp to 30
        MVII    #$001E, R2          // 59FB  /

L_59FD: JSR     R5,     AWARD_GOLD  // 59FD  Award up to 30 productivity gold

        // Give player 10 more gold bars, but don't count it toward
        // "bars earned this round"
        JSR     R5,     L_5A24      // 5A00  Give 10 gold bar baseline income

        // Now do this again for player 1
        MVI     CURPLR, R1          // 5A03  \
        TSTR    R1                  // 5A05   |- Go to next step if we just
        BNEQ    L_5A2F              // 5A06  /   finished player 1

        MVII    #$0001, R1          // 5A08  \
        MVO     R1,     CURPLR      // 5A0A   |- Compute player 1's gold
        B       L_59D1              // 5A0C  /

        // ---------------------------------------------------------------- //
        //  Award R2 gold bars to CURPLR                                    //
        // ---------------------------------------------------------------- //
AWARD_GOLD:
L_5A0E: PSHR    R5                  // 5A0E  save return address

        MVII    #RGLD_0,R1          // 5A0F  \
        ADD     CURPLR, R1          // 5A11   |  Add R2 to the total number 
        MVI@    R1,     R0          // 5A13   |- of gold bars this player
        ADDR    R2,     R0          // 5A14   |  has earned this round.
        MVO@    R0,     R1          // 5A15  /   

L_5A16: MVII    #GOLD_0,R4          // 5A16  \__ Index to this player's 
        JSR     R5,     L_5A29      // 5A18  /   number of gold bars

        SDBD                        // 5A1B  \ 
        MVI@    R4,     R0          // 5A1C   |
        ADDR    R2,     R0          // 5A1D   |  Add R2 to the total number
        SUBI    #$0002, R4          // 5A1E   |- of gold bars this player
        MVO@    R0,     R4          // 5A20   |  has.
        SWAP    R0,     1           // 5A21   |  
        MVO@    R0,     R4          // 5A22  /

        PULR    R7                  // 5A23  return

        // ---------------------------------------------------------------- //
        //  Award 10 gold bars, but don't count toward "earned this round"  //
        // ---------------------------------------------------------------- //
L_5A24: PSHR    R5                  // 5A24  
        MVII    #$000A, R2          // 5A25  10 gold bars
        B       L_5A16              // 5A27  Add to gold bars but not "earned"

        // ---------------------------------------------------------------- //
        //  Index an DBD value by CURPLR (ie. R4 += 2*CURPLR)               //
        // ---------------------------------------------------------------- //
L_5A29: PSHR    R5                  // 5A29  
        ADD     CURPLR, R4          // 5A2A  
        ADD     CURPLR, R4          // 5A2C  
        PULR    R7                  // 5A2E  

        // ---------------------------------------------------------------- //
        //  Compute population update for each player.                      //
        // ---------------------------------------------------------------- //
L_5A2F: CLRR    R1                  // 5A2F  
        MVO     R1,     CURPLR      // 5A30  Start with player 0

L_5A32: MVII    #POPU_0,R4          // 5A32  \
        JSR     R5,     L_5A29      // 5A34   |_ Get player's population
        SDBD                        // 5A37   |
        MVI@    R4,     R1          // 5A38  /

        MVII    #$000A, R2          // 5A39  \_ Divide by 10
        JSR     R5,     X_DIVR      // 5A3B  /
        MVO     R0,     G_0324      // 5A3E  Remember pop/10 in $324

        MVII    #$0028, R3          // 5A40  Fertility baseline of 50 (5.0%)
        MVII    #$000B, R4          // 5A42  Mortality baseline of 11 (1.1%)

        MVII    #CROP_0,R1          // 5A44  \_ Increase fertility 3
        JSR     R5,     L_5AAF      // 5A46  /  for every crop

        MVII    #HOSP_0,R1          // 5A49  \_ Increase fertility 3
        JSR     R5,     L_5AAF      // 5A4B  /  for every hospital

        SUBR    R2,     R4          // 5A4E  Sub 3 off mort for every hospital

        CMPI    #$0002, R4          // 5A4F  \
        BGE     L_5A55              // 5A51   |- Cap hospital effect with
        MVII    #$0002, R4          // 5A53  /   min mortality of 2 (0.2%)

L_5A55: MVII    #HOUS_0,R1          // 5A55  \
        ADD     CURPLR, R1          // 5A57   |_ Increase fertility 1 for
        MVI@    R1,     R0          // 5A59   |  every house
        ADDR    R0,     R3          // 5A5A  /

        MVII    #FTRY_0,R1          // 5A5B  \   Increase mortaility 1 for
        ADD     CURPLR, R1          // 5A5D   |_ every factory.  Note that
        MVI@    R1,     R0          // 5A5F   |  this is after clamping the
        ADDR    R0,     R4          // 5A60  /   hospital effect.

        MVII    #SCHL_0,R1          // 5A61  \
        ADD     CURPLR, R1          // 5A63   |- Get # of schools
        MVI@    R1,     R0          // 5A65  /

        MVII    #$0003, R1          // 5A66  \_ ...times 3
        JSR     R5,     X_MPY       // 5A68  /

        SUBR    R2,     R3          // 5A6B  Decrease fert 3 for every school

        CMPI    #$0040, R3          // 5A6C  \
        BLE     L_5A72              // 5A6E   |- Min fertility of 40.
        MVII    #$0040, R3          // 5A70  /

L_5A72: MVI     G_0324, R0          // 5A72  Get pop/10

        MOVR    R3,     R1          // 5A74  \_ (pop / 10) * fertility
        JSR     R5,     X_MPY       // 5A75  /

        MOVR    R2,     R3          // 5A78  Total births * 100

        MVI     G_0324, R0          // 5A79  \
        MOVR    R4,     R1          // 5A7B   |- (pop / 10) * mortality
        JSR     R5,     X_MPY       // 5A7C  /

        MOVR    R2,     R4          // 5A7F  Total deaths * 100

        MOVR    R3,     R1          // 5A80  \
        MVII    #$0064, R2          // 5A81   |- Divide by 100 for tot births
        JSR     R5,     X_DIVR      // 5A83  /   (with rounding)

        MOVR    R0,     R3          // 5A86  R3 is total births

        MOVR    R4,     R1          // 5A87  \
        MVII    #$0064, R2          // 5A88   |- Divide by 100 for tot deaths
        JSR     R5,     X_DIVR      // 5A8A  /   (with rounding)

                                    //       R0 is total deaths

        MVII    #POPU_0,R4          // 5A8D  \
        JSR     R5,     L_5A29      // 5A8F   |_ Get player's population
        SDBD                        // 5A92   |
        MVI@    R4,     R2          // 5A93  /

        ADDR    R3,     R2          // 5A94  Add births
        SUBR    R0,     R2          // 5A95  Subtract deaths

        SDBD                        // 5A96  \
        CMPI    #$270F, R2          // 5A97   |  Highly fecund society?  Cap 
        BLE     L_5AA0              // 5A9A   |- total population at 9999.
        SDBD                        // 5A9C   |
        MVII    #$270F, R2          // 5A9D  /
        
L_5AA0: SUBI    #$0002, R4          // 5AA0  \
        MVO@    R2,     R4          // 5AA2   |_ Store updated population
        SWAP    R2,     1           // 5AA3   |
        MVO@    R2,     R4          // 5AA4  /

        MVI     CURPLR, R1          // 5AA5  \
        TSTR    R1                  // 5AA7   |- Done with player 1?  
        BNEQ    L_5ABA              // 5AA8  /   Now compute round score.

        INCR    R1                  // 5AAA  \
        MVO     R1,     CURPLR      // 5AAB   |- Evaluate player 1
        B       L_5A32              // 5AAD  /

        // Get a parameter, multiply by 3 and accumulate in R3.
        // Return parameter * 3 in R2
L_5AAF: PSHR    R5                  // 5AAF  
        ADD     CURPLR, R1          // 5AB0  \_ Get parameter
        MVI@    R1,     R0          // 5AB2  /

        MVII    #$0003, R1          // 5AB3  \_ mult by 3
        JSR     R5,     X_MPY       // 5AB5  /

        ADDR    R2,     R3          // 5AB8  Accumulate in R3
        PULR    R7                  // 5AB9  


        // ---------------------------------------------------------------- //
        //  Compute round score.                                            //
        // ---------------------------------------------------------------- //
L_5ABA: CLRR    R0                  // 5ABA  \_ Start with player 0
        MVO     R0,     CURPLR      // 5ABB  /

        //  First, compute housing score.
L_5ABD: MVII    #POPU_0,R4          // 5ABD  \
        JSR     R5,     L_5A29      // 5ABF   |_ Get player's (updated)
        SDBD                        // 5AC2   |  population count
        MVI@    R4,     R1          // 5AC3  /

        MVII    #$0064, R2          // 5AC4  \_ Pop / 100
        JSR     R5,     X_DIV       // 5AC6  /

        MVO     R0,     G_0324      // 5AC9  Remember pop / 100

        MVII    #HOUS_0,R1          // 5ACB  \
        ADD     CURPLR, R1          // 5ACD   |- Get number of houses
        MVI@    R1,     R0          // 5ACF  /

        MVII    #$01F4, R1          // 5AD0  \_ Houses * 500
        JSR     R5,     X_MPY       // 5AD2  /

        MOVR    R2,     R1          // 5AD5  \
        MVI     G_0324, R2          // 5AD6   |- (Houses * 500) / (pop / 100)
        JSR     R5,     X_DIVR      // 5AD8  /   rounded

        MOVR    R0,     R1          // 5ADB  \
        MVII    #$0003, R2          // 5ADC   |- ((Houses*500)/(pop/100)) / 3
        JSR     R5,     X_DIVR      // 5ADE  /   rounded

        CMPI    #$001E, R0          // 5AE1  \
        BLE     L_5AE7              // 5AE3   |- Clamp housing score at 30
        MVII    #$001E, R0          // 5AE5  /

L_5AE7: MVO     R0,     H_SCOR      // 5AE7  Remember housing score 

        //  Compute Per Capita Gross Domestic Product (GDP) score
        //
        //  Note:  Don't try to earn more than 255 gold bars in one round.
        //         I don't personally think that's possible.
        MVII    #RGLD_0,R4          // 5AE9  \
        ADD     CURPLR, R4          // 5AEB   |- Get gold earned this round
        MVI@    R4,     R0          // 5AED  /   This is total GDP for round

        MVII    #$0064, R1          // 5AEE  \_ Multiply by 100
        JSR     R5,     X_MPY       // 5AF0  /

        MOVR    R2,     R1          // 5AF3  \   Compute per capita GDP as 
        MVI     G_0324, R2          // 5AF4   |- (gold * 100) / (pop / 100)
        JSR     R5,     X_DIVR      // 5AF6  /   rounded

        MOVR    R0,     R1          // 5AF9  \   Per capita GDP score is 
        MVII    #$000C, R2          // 5AFA   |- ((gold*100) / (pop/100)) / 12
        JSR     R5,     X_DIVR      // 5AFC  /   rounded

        CMPI    #$001E, R0          // 5AFF  \
        BLE     L_5B05              // 5B01   |- Clamp GDP score at 30
        MVII    #$001E, R0          // 5B03  /

L_5B05: MVO     R0,     G_SCOR      // 5B05  Remember per capita GDP score

        //  Compute food-supply score
        //  Note:  This can overflow if (crops + fishing boats) > 65
        MVII    #F_BO_0,R1          // 5B07  \
        ADD     CURPLR, R1          // 5B09   |- Get number of fishing boats
        MVI@    R1,     R0          // 5B0B  /

        MVII    #CROP_0,R2          // 5B0C  \
        ADD     CURPLR, R2          // 5B0E   |_ Add number of crops
        MVI@    R2,     R1          // 5B10   |
        ADDR    R0,     R1          // 5B11  /

        MVII    #$01F4, R0          // 5B12  \_ (boats + crops) * 500
        JSR     R5,     X_MPY       // 5B14  / > Can go "negative" if more
                                    //         > than 65 fishing boats + crops

        MOVR    R2,     R1          // 5B17  \
        MVI     G_0324, R2          // 5B18   |- (boat+crops)*500 / (pop/100)
        JSR     R5,     X_DIVR      // 5B1A  /

        MOVR    R0,     R1          // 5B1D  \   Food supply score:
        MVII    #$0003, R2          // 5B1E   |- ((boat+crops)*500/(pop/100))/3
        JSR     R5,     X_DIVR      // 5B20  /

        CMPI    #$001E, R0          // 5B23  \
        BLE     L_5B29              // 5B25   |- Clamp at 30
        MVII    #$001E, R0          // 5B27  /

L_5B29: MVO     R0,     F_SCOR      // 5B29  Remember food score

        CLRR    R1                  // 5B2B  \   Base round score:
        ADD     H_SCOR, R1          // 5B2C   |_ housing + GDP + food
        ADD     G_SCOR, R1          // 5B2E   |
        ADD     F_SCOR, R1          // 5B30  /

        // General welfare scoring:
        MVII    #SCHL_0,R2          // 5B32  \
        ADD     CURPLR, R2          // 5B34   |_ Add 1 point for every school
        MVI@    R2,     R0          // 5B36   |
        ADDR    R0,     R1          // 5B37  /
        MVII    #HOSP_0,R2          // 5B38  \
        ADD     CURPLR, R2          // 5B3A   |_ Add 1 point for every hospital
        MVI@    R2,     R0          // 5B3C   |
        ADDR    R0,     R1          // 5B3D  /

        CMPI    #$0064, R1          // 5B3E  \
        BLE     L_5B44              // 5B40   |- Clamp round score at 100
        MVII    #$0064, R1          // 5B42  /

L_5B44: MVII    #SCOR_0,R4          // 5B44  \
        JSR     R5,     L_5A29      // 5B46   |_ Get player's total score
        SDBD                        // 5B49   |
        MVI@    R4,     R2          // 5B4A  /

        ADDR    R1,     R2          // 5B4B  Add round score to it

        MVII    #RSCO_0,R3          // 5B4C  \
        ADD     CURPLR, R3          // 5B4E   |
        MVI@    R3,     R0          // 5B50   |_ Copy last round's score
        MVII    #PRSC_0,R3          // 5B51   |  to previous round score (PRSC)
        ADD     CURPLR, R3          // 5B53   |
        MVO@    R0,     R3          // 5B55  /

        MVII    #RSCO_0,R3          // 5B56  \
        ADD     CURPLR, R3          // 5B58   |- Save this round's score 
        MVO@    R1,     R3          // 5B5A  /   in RSCO

        SUBI    #$0002, R4          // 5B5B  \
        MVO@    R2,     R4          // 5B5D   |_ Save updated total score
        SWAP    R2,     1           // 5B5E   |
        MVO@    R2,     R4          // 5B5F  /

        MVI     CURPLR, R2          // 5B60  \
        TSTR    R2                  // 5B62   |- Done with player 1?
        BNEQ    L_5B6B              // 5B63  /   Evaluate crop mortality.

        MVII    #$0001, R1          // 5B65  \
        MVO     R1,     CURPLR      // 5B67   |- Do it again for player 1.
        B       L_5ABD              // 5B69  /

        // Random crop destruction
L_5B6B: CLRR    R1                  // 5B6B  \
        MVO     R1,     RGLD_0      // 5B6C   |- Reset earned gold bars
        MVO     R1,     RGLD_1      // 5B6E  / 

        SDBD                        // 5B70  
        MVII    #LFT_ISLE_OFS_TBL,R1// 5B71  Point to left island

L_5B74: SDBD                        // 5B74  
        CMPI    #RGT_ISLE_OFS_TBL,R1// 5B75  Are we on left or right?
        BLE     L_5B7E              // 5B78  

        MVII    #$0001, R3          // 5B7A  Right: Player 1
        B       L_5B7F              // 5B7C 
L_5B7E: CLRR    R3                  // 5B7E  Left:  Player 0

L_5B7F: MVO     R3,     CURPLR      // 5B7F  Remember current player

        MVI@    R1,     R2          // 5B81  \
        ADDI    #$0200, R2          // 5B82   |- Get a square of island
        MVI@    R2,     R3          // 5B84  /
        SLR     R3,     2           // 5B85  \
        SLR     R3,     1           // 5B86   |_ Is it a crop?
        ANDI    #$00FF, R3          // 5B87   |
        CMPI    #$0003, R3          // 5B89  /
        BNEQ    L_5BAB              // 5B8B  No:  Move to next square

        MVII    #$0003, R0          // 5B8D  \
        JSR     R5,     X_RAND2     // 5B8F   |_ 2/3 chance of surviving
        TSTR    R0                  // 5B92   |
        BNEQ    L_5BAB              // 5B93  /

        MVI@    R2,     R3          // 5B95  \
        SDBD                        // 5B96   |_ Nuke the crop
        ANDI    #$7800, R3          // 5B97   |
        XORI    #$0003, R3          // 5B9A  /

        PSHR    R1                  // 5B9C  \__ Redraw affected island square
        JSR     R5,     L_571C      // 5B9D  /

        PSHR    R3                  // 5BA0  \
        MVI     CURPLR, R1          // 5BA1   |_ Decrement number of crops
        MVII    #$0003, R3          // 5BA3   |  in player's crop count.
        JSR     R5,     L_570D      // 5BA5  /

        PULR    R3                  // 5BA8  
        PULR    R1                  // 5BA9  
        MVO@    R3,     R2          // 5BAA  Redraw square again?!

L_5BAB: INCR    R1                  // 5BAB  \
        SDBD                        // 5BAC   |- Move to next island square
        CMPI    #$5169, R1          // 5BAD  /
        BNEQ    L_5B74              // 5BB0  Stop at end of both islands

        // Did our popularity fall too far too fast?  If so, trigger a rebel. 
        // Otherwise, if things are going well, remove rebels.

        CLRR    R0                  // 5BB2  \_ Start with player 0
        MVO     R0,     CURPLR      // 5BB3  /

L_5BB5: CLRR    R0                  // 5BB5  \_ Clear rebel retry counter
        MVO     R0,     RBLTRY      // 5BB6  /

        MVII    #PRSC_0,R1          // 5BB8  \
        ADD     CURPLR, R1          // 5BBA   |- Get previous round's score
        MVI@    R1,     R0          // 5BBC  /

        MVII    #RSCO_0,R1          // 5BBD  \
        ADD     CURPLR, R1          // 5BBF   |- Get this round's score
        MVI@    R1,     R2          // 5BC1  /

        SUBR    R2,     R0          // 5BC2  \   Did we fall by more than 10
        CMPI    #$000A, R0          // 5BC3   |- points this round?  If so,
        BGE     L_5BE8              // 5BC5  /   then rebel!

        SDBD                        // 5BC7  \   If we increased by at least
        CMPI    #-10,   R0          // 5BC8   |- 10 points, remove a rebel.
        BLE     L_5C50              // 5BCB  /

        CMPI    #$001E, R2          // 5BCD  \__ Otherwise, if we're below
        BLT     L_5BE8              // 5BCF  /   popularity of 30, rebel!

        CMPI    #$0046, R2          // 5BD1  \_  If we're at least 70, remove
        BGE     L_5C50              // 5BD3  /   a rebel.

L_5BD5: MVI     CURPLR, R0          // 5BD5  \
        TSTR    R0                  // 5BD7   |- Leave once done w/ player 1
        BNEQ    L_5BE0              // 5BD8  /

        MVII    #$0001, R0          // 5BDA  \
        MVO     R0,     CURPLR      // 5BDC   |- Now check player 1
        B       L_5BB5              // 5BDE  /
L_5BE0:
        PULR    R7                  // 5BE0  Leave.

L_5BE1: MVI     RBLTYP, R0          // 5BE1  \_ Is this a scoring-inspired 
        TSTR    R0                  // 5BE3  /  rebel?
        BNEQ    L_5BE0              // 5BE4  No:  Leave
        B       L_5BD5              // 5BE6  Yes:  Move to other player

L_5BE8: MVI     RBLTRY, R0          // 5BE8  \
        CMPI    #$00FA, R0          // 5BEA   |- Try 250 times to place a
        BGT     L_5BE1              // 5BEC  /   rebel on the island

        INCR    R0                  // 5BEE  \_ Increment the rebel-tries
        MVO     R0,     RBLTRY      // 5BEF  /  counter

        MVI     CURPLR, R0          // 5BF1  \
        TSTR    R0                  // 5BF3   |- Player 0 or 1?
        BNEQ    L_5BFC              // 5BF4  /

        SDBD                        // 5BF6  \
        MVII    #LFT_ISLE_OFS_TBL,R3 //5BF7   |- Point to player 0's island
        B       L_5C00              // 5BFA  /

L_5BFC: SDBD                        // 5BFC  \__ Point to player 1's island
        MVII    #RGT_ISLE_OFS_TBL,R3 //5BFD  /

L_5C00: MVII    #$001D, R0          // 5C00  \_ Pick a random square on the
        JSR     R5,     X_RAND2     // 5C02  /  island

        ADDR    R0,     R3          // 5C05  \
        MVI@    R3,     R2          // 5C06   |_ See what's in it.
        ADDI    #$0200, R2          // 5C07   |
        JSR     R5, GET_TILE_NO     // 5C09  /

        CMPI    #$0007, R1          // 5C0C  Rebel?
        BEQ     L_5BE8              // 5C0E  Skip it!

        CMPI    #$0001, R1          // 5C10  Fort?
        BEQ     L_5BE8              // 5C12  Skip it!

        PSHR    R2                  // 5C14  Save screen position
        MVO     R1,     CURSEL      // 5C15  Remember type of thing we're nuking

        JSR     R5, FORT_NEAR_CARD  // 5C17  Is there a fort nearby?

        PULR    R2                  // 5C1A  
        TSTR    R1                  // 5C1B  Was there a fort nearby?
        BNEQ    L_5BE8              // 5C1C  Yes:  Skip the card.

        MVI     CURSEL, R1          // 5C1E  What were we nuking?

        CMPI    #$000A, R1          // 5C20  \_ Item > 10?  (island borders)
        BGT     L_5C37              // 5C22  /  Nuke directly.

        CMPI    #$0000, R1          // 5C24  \_ No item?
        BEQ     L_5C37              // 5C26  /  Nuke directly

        MOVR    R1,     R3          // 5C28  \_ Decrement item count for item
        JSR     R5,     L_570D      // 5C29  /  we're nuking

        MVI@    R2,     R1          // 5C2C  \
        SDBD                        // 5C2D   |_ Toggle color-stack advance
        XORI    #$2000, R1          // 5C2E   |  bit for item we're nuking
        MVO@    R1,     R2          // 5C31  /

        JSR     R5,     L_5FB6      // 5C32  Play "you've been smited!" sfx
        B       L_5C3F              // 5C35  Deposit the rebel

L_5C37: INCR    R2                  // 5C37  \
        MVI@    R2,     R1          // 5C38   |
        SDBD                        // 5C39   |_ Adjust color stack for
        XORI    #$2000, R1          // 5C3A   |  neighbor of rebel'd card
        MVO@    R1,     R2          // 5C3D   |
        DECR    R2                  // 5C3E  /

L_5C3F: MVI@    R2,     R1          // 5C3F  \
        SDBD                        // 5C40   |
        ANDI    #$7800, R1          // 5C41   |_ Deposit the rebel on the
        SDBD                        // 5C44   |  island. 
        XORI    #$A038, R1          // 5C45   |
        MVO@    R1,     R2          // 5C48  /

        MVI     RBLTYP, R0          // 5C49  \
        TSTR    R0                  // 5C4B   |- If this was a mercernary,
        BNEQ    L_5BE0              // 5C4C  /   leave.
        B       L_5BD5              // 5C4E  Otherwise, evaluate other player.

        // Try to remove a rebel.
L_5C50: MVI     CURPLR, R0          // 5C50  \
        TSTR    R0                  // 5C52   |- Player 0 or 1?
        BNEQ    L_5C5B              // 5C53  /

        SDBD                        // 5C55  \
        MVII    #LFT_ISLE_OFS_TBL,R3 //5C56   |- Player 0: Left island
        B       L_5C5F              // 5C59  /

L_5C5B: SDBD                        // 5C5B  \__ Player 1: Right island
        MVII    #RGT_ISLE_OFS_TBL,R3 //5C5C  /

L_5C5F: CLRR    R0                  // 5C5F  Start at the first island tile

L_5C60: MVI@    R3,     R2          // 5C60  \
        ADDI    #$0200, R2          // 5C61   |- Get the next island tile
        JSR     R5, GET_TILE_NO     // 5C63  /

        CMPI    #$0007, R1          // 5C66  \__ Is it a rebel?
        BEQ     L_5C72              // 5C68  /

        INCR    R0                  // 5C6A  \
        CMPI    #$001D, R0          // 5C6B   |  Iterate through all island
        BEQ     L_5BD5              // 5C6D   |- tiles, and check other player
        INCR    R3                  // 5C6F   |  once done with this one.
        B       L_5C60              // 5C70  /

        // Found a rebel:  Remove it!
L_5C72: MVI@    R2,     R1          // 5C72  Get the card
        SDBD                        // 5C73  
        ANDI    #$7800, R1          // 5C74  Clear the card #
        XORI    #$0003, R1          // 5C77  Force color to tan
        PSHR    R3                  // 5C79  Save tile loc
        PSHR    R0                  // 5C7A  Save loop ctr

        MOVR    R1,     R3          // 5C7B  \_ Put original island tile
        JSR     R5,     L_571C      // 5C7C  /  back in this spot

        MOVR    R3,     R1          // 5C7F  \
        PULR    R0                  // 5C80   |_ Overwrite it??
        PULR    R3                  // 5C81   |
        MVO@    R1,     R2          // 5C82  /
        B       L_5BD5              // 5C83  Examine next player.

        // ---------------------------------------------------------------- //
        //  MOB record template for "Weather".                              //
        // ---------------------------------------------------------------- //
WTHR_TMPL:
        BIDECLE $3947       // 5C85  Initial attribute word
                            //        -- Double X size
                            //        -- Visible
                            //        -- Interacts
                            //        -- Scale Y size 4x
                            //        -- 16-row MOB
                            //        -- Color 7 (white)
                            //
        BIDECLE $0000       // 5C87  Initial ROM addr: NUL -- fills in later
        BIDECLE $1B00       // 5C89  Initial X position 8Q8 (27 decimal)
        BIDECLE $0000       // 5C8B  Initial Y position 8Q8 ( 0 decimal)
        DECLE   $0004       // 5C8C  Initial X velocity: +4
        DECLE   $0005       // 5C8D  Initial Y velocity: +5
        BIDECLE $0280       // 5C8F  Animation rate
        BIDECLE $0000       // 5C91  Timeout (unused)
        BIDECLE $0000       // 5C93  "Extra" (unused)

        // ---------------------------------------------------------------- //
        //  Player cursor initializer records                               //
        // ---------------------------------------------------------------- //
PLY0_MOB_INIT:
        BIDECLE $1A84       // 5C95  Initial attribute word
        BIDECLE $5CB5       // 5C97  MOB ROM data pointer
        BIDECLE $2A00       // 5C99  Initial X position 8Q8
        BIDECLE $4E00       // 5C9B  Initial Y position 8Q8
        DECLE   $000        // 5C9D  Initial X velocity
        DECLE   $000        // 5C9E  Initial Y velocity
        BIDECLE $00C0       // 5C9F  Animation rate
        BIDECLE $0000       // 5CA1  Timeout (unused)
        BIDECLE $0000       // 5CA3  "Extra" (unused)
                           
PLY1_MOB_INIT:             
        BIDECLE $1A82       // 5CA5  Initial attribute word
        BIDECLE $5CB5       // 5CA7  MOB ROM data pointer
        BIDECLE $8E00       // 5CA9  Initial X position 8Q8
        BIDECLE $1C00       // 5CAB  Initial Y position 8Q8
        DECLE   $000        // 5CAD  Initial X velocity
        DECLE   $000        // 5CAE  Initial Y velocity
        BIDECLE $00C0       // 5CAF  Animation rate
        BIDECLE $0000       // 5CB1  Timeout (unused)
        BIDECLE $0000       // 5CB3  "Extra" (unused)

        // ---------------------------------------------------------------- //
        //  Player Cursor MOB ROM table                                     //
        // ---------------------------------------------------------------- //
CURS_MOB_TBL:
        DECLE   $300, $000  // 5CB5  No boundary dispatch// keep onscreen
        BIDECLE $0000       // 5CB7  No timeout dispatch
        DECLE   $01, $00    // 5CB9  Anim loop: 1 picture starting at 0
        DECLE   $0000       // 5CBB  No interactions.

        // ---------------------------------------------------------------- //
        //  Fishing boat MOB ROM table                                      //
        // ---------------------------------------------------------------- //
F_BO_MOB_TBL:
        DECLE   $300, $000  // 5CBC  No boundary dispatch// keep onscreen
        BIDECLE $0000       // 5CBE  No timeout dispatch
        DECLE   $01, $01    // 5CC0  Anim loop: 1 picture starting at 1
        DECLE   $0010       // 5CC2  No bkgnd interaction// 8 MOB interactions
        DECLE   $02E, $056  // 5CC3  Interact w/ obj 0 at $562E (weather)
        DECLE   $02E, $156  // 5CC5  Interact w/ obj 1 at $562E (weather)
        DECLE   $2BF, $055  // 5CC7  Interact w/ obj 2 at $55BF (other player)
        DECLE   $2BF, $155  // 5CC9  Interact w/ obj 3 at $55BF (other player)
        DECLE   $120, $056  // 5CCB  Interact w/ obj 4 at $5620 (pirate)
        DECLE   $120, $156  // 5CCD  Interact w/ obj 5 at $5620 (pirate)
        DECLE   $3CB, $054  // 5CCF  Interact w/ obj 6 at $54CB (fish)
        DECLE   $3CB, $154  // 5CD1  Interact w/ obj 7 at $54CB (fish)

        // ---------------------------------------------------------------- //
        //  PT boat MOB ROM table                                           //
        // ---------------------------------------------------------------- //
PTBO_MOB_TBL:
        DECLE   $300, $000  // 5CD3  No boundary dispatch// keep onscreen
        BIDECLE $0000       // 5CD5  No timeout dispatch
        DECLE   $01, $02    // 5CD7  Anim loop: 1 picture starting at 2
        DECLE   $9          // 5CD9  Background interaction + 4 MOB interactions
        BIDECLE $54EE       // 5CDA  Background interaction
        DECLE   $02E,  $056 // 5CDC  Interact w/ obj 0 at $562E (weather)
        DECLE   $02E,  $156 // 5CDE  Interact w/ obj 1 at $562E (weather)
        DECLE   $140,  $056 // 5CE0  Interact w/ obj 4 at $5640 (pirate)      
        DECLE   $140,  $156 // 5CE2  Interact w/ obj 5 at $5640 (pirate)      

        // ---------------------------------------------------------------- //
        //  Sinking player boat MOB ROM table                               //
        // ---------------------------------------------------------------- //
SINK_MOB_TBL:
        DECLE   $300,  $000 // 5CE4  No boundary dispatch// keep onscreen
        BIDECLE $55E8       // 5CE6  Timeout:  Recycle the MOB after anim.
        DECLE   $08,  $03   // 5CE8  Anim loop: 8 pictures starting at 3
        DECLE   $0000       // 5CEA  No interactions
        
        // ---------------------------------------------------------------- //
        //  Sinking pirate boat MOB ROM table                               //
        // ---------------------------------------------------------------- //
PSNK_MOB_TBL:
        DECLE   $300,  $000 // 5CEB  No boundary dispatch// keep onscreen
        BIDECLE $17AE       // 5CED  Timeout:  Kill the MOB after animation
        DECLE   $08,  $03   // 5CEF  Anim loop: 8 pictures starting at 3
        DECLE   $0000       // 5CF1  No interactions

        // ---------------------------------------------------------------- //
        //  Fish MOB ROM table                                              //
        // ---------------------------------------------------------------- //
FISH_MOB_TBL:
        DECLE   $2AE, $017  // 5CF2  Kill object when it goes offscreen
        BIDECLE $0000       // 5CF4  No timeout dispatch
        DECLE   $04, $0B    // 5CF6  Anim loop:  4 pictures starting at $0B
        DECLE   $0001       // 5CF8  Interact w/ background only
        BIDECLE PARK_FISH   // 5CF9  Look for parked fishing boats (549F)


        // ---------------------------------------------------------------- //
        //  Pirate MOB ROM table                                            //
        // ---------------------------------------------------------------- //
PIRT_MOB_TBL:
        DECLE   $2AE, $017  // 5CFB  Kill object when it goes offscreen
        BIDECLE $0000       // 5CFD  No timeout dispatch
        DECLE   $01, $0F    // 5CFF  Anim loop:  1 picture starting at $0F
        DECLE   $0005       // 5D01  Interact w/ background & 2 MOBs.
        BIDECLE $54EE       // 5D02  Background interaction dispatch
        BIDECLE $562E       // 5D04  MOB 0 interaction dispatch (weather)
        DECLE   $2E, $156   // 5D06  MOB 1 interaction dispatch (weather)

        // ---------------------------------------------------------------- //
        //  Rain MOB ROM table                                              //
        // ---------------------------------------------------------------- //
RAIN_MOB_TBL:
        DECLE   $2AE, $017  // 5D08  Kill object when it goes offscreen
        BIDECLE $0000       // 5D0A  No timeout dispatch
        DECLE   $05, $10    // 5D0C  Anim loop: 5 pictures starting at $10
        DECLE   $0001       // 5D0E  Interact with background only
        BIDECLE WTHR_V_LAND // 5D0F  Handler for background interaction ($5691)

        // ---------------------------------------------------------------- //
        //  Hurricane MOB ROM table                                         //
        // ---------------------------------------------------------------- //
HURR_MOB_TBL:
        DECLE   $2AE, $017  // 5D11  Kill object when it goes offscreen
        BIDECLE $0000       // 5D13  
        DECLE   $06, $1A    // 5D15  Anim loop: 6 pictures starting at $1A
        DECLE   $01         // 5D17  Interact with background only
        BIDECLE WTHR_V_LAND // 5D18  Handler for background interaction ($5691)


.GFX_ANIM_5D1A
        gfx_row "########"    // 5D1A  MOB PIC #00
        gfx_row "#......#"    // 
        gfx_row "#......#"    // 
        gfx_row "#......#"    // 
        gfx_row "#......#"    // 5D1E  
        gfx_row "#......#"    // 
        gfx_row "#......#"    // 
        gfx_row "########"    // 

        gfx_row "........"    // 5D22  MOB PIC #01
        gfx_row ".....#.."    // 
        gfx_row "#....#.."    // 
        gfx_row ".#.###.."    // 
        gfx_row "########"    // 5D26  
        gfx_row ".######."    // 
        gfx_row "........"    // 
        gfx_row "........"    // 

        gfx_row "........"    // 5D2A  MOB PIC #02
        gfx_row "........"    // 
        gfx_row "....#..."    // 
        gfx_row "...###.."    // 
        gfx_row ".#######"    // 5D2E  
        gfx_row "..#####."    // 
        gfx_row "........"    // 
        gfx_row "........"    // 

        gfx_row ".....#.."    // 5D32  MOB PIC #03
        gfx_row "#.#....#"    // 
        gfx_row ".....#.."    // 
        gfx_row ".#.###.."    // 
        gfx_row "########"    // 5D36  
        gfx_row ".######."    // 
        gfx_row "........"    // 
        gfx_row "........"    // 

        gfx_row "#.#....."    // 5D3A  MOB PIC #04
        gfx_row "......#."    // 
        gfx_row ".#.#.#.#"    // 
        gfx_row "........"    // 
        gfx_row "########"    // 5D3E  
        gfx_row ".######."    // 
        gfx_row "........"    // 
        gfx_row "........"    // 

        gfx_row "#.#....#"    // 5D42  MOB PIC #05
        gfx_row "....#..."    // 
        gfx_row ".#...#.."    // 
        gfx_row "...#...."    // 
        gfx_row "##...###"    // 5D46  
        gfx_row ".######."    // 
        gfx_row "........"    // 
        gfx_row "........"    // 

        gfx_row "#....#.."    // 5D4A  MOB PIC #06
        gfx_row "..#...#."    // 
        gfx_row "........"    // 
        gfx_row ".....##."    // 
        gfx_row "....##.."    // 5D4E  
        gfx_row ".#####.."    // 
        gfx_row "........"    // 
        gfx_row "........"    // 

        gfx_row "#......#"    // 5D52  MOB PIC #07
        gfx_row "........"    // 
        gfx_row ".....#.."    // 
        gfx_row "....##.."    // 
        gfx_row "..###..."    // 5D56  
        gfx_row ".###...."    // 
        gfx_row "........"    // 
        gfx_row "........"    // 

        gfx_row "........"    // 5D5A  MOB PIC #08
        gfx_row "........"    // 
        gfx_row "........"    // 
        gfx_row ".....#.."    // 
        gfx_row "....##.."    // 5D5E  
        gfx_row "..###..."    // 
        gfx_row "........"    // 
        gfx_row "........"    // 

        gfx_row "........"    // 5D62  MOB PIC #09
        gfx_row "........"    // 
        gfx_row "........"    // 
        gfx_row "........"    // 
        gfx_row "....#..."    // 5D66  
        gfx_row "...##..."    // 
        gfx_row "........"    // 
        gfx_row "........"    // 

        gfx_row "........"    // 5D6A  MOB PIC #0A
        gfx_row "........"    // 
        gfx_row "........"    // 
        gfx_row "........"    // 
        gfx_row "........"    // 5D6E  
        gfx_row "...#...."    // 
        gfx_row "........"    // 
        gfx_row "........"    // 

        gfx_row "...#...."    // 5D72  MOB PIC #0B
        gfx_row ".#..#.#."    // 
        gfx_row "..#..#.."    // 
        gfx_row "##..#..#"    // 
        gfx_row "..#...#."    // 5D76  
        gfx_row "..#.#..."    // 
        gfx_row ".#...#.."    // 
        gfx_row "...##..."    // 

        gfx_row "....#..."    // 5D7A  MOB PIC #0C
        gfx_row "..#..##."    // 
        gfx_row ".#.#...."    // 
        gfx_row ".##.#.#."    // 
        gfx_row "#......#"    // 5D7E  
        gfx_row "..#.##.."    // 
        gfx_row "...#...."    // 
        gfx_row "..#..#.."    // 

        gfx_row "...#...."    // 5D82  MOB PIC #0D
        gfx_row "...#.#.."    // 
        gfx_row ".#....##"    // 
        gfx_row "..#.#..."    // 
        gfx_row "#..#.#.#"    // 5D86  
        gfx_row "#.#.#.#."    // 
        gfx_row ".#.#..#."    // 
        gfx_row "....#..."    // 

        gfx_row "..#.#..."    // 5D8A  MOB PIC #0E
        gfx_row "...#..#."    // 
        gfx_row ".##.#.#."    // 
        gfx_row "#....#.#"    // 
        gfx_row "..#.#..#"    // 5D8E  
        gfx_row "#..#..#."    // 
        gfx_row "..#..#.."    // 
        gfx_row "...#...."    // 

        gfx_row "..##...."    // 5D92  MOB PIC #0F
        gfx_row "...#...."    // 
        gfx_row ".#.#.##."    // 
        gfx_row ".#.#.#.#"    // 
        gfx_row ".#.#.##."    // 5D96  
        gfx_row ".#.#.#.."    // 
        gfx_row "########"    // 
        gfx_row ".######."    // 

        gfx_row "....#..."    // 5D9A  MOB PIC #10 & #11
        gfx_row ".######."    // 
        gfx_row "########"    // 
        gfx_row "########"    // 
        gfx_row ".######."    // 5D9E  
        gfx_row "...#...."    // 
        gfx_row ".....#.."    // 
        gfx_row ".#......"    // 
        gfx_row "......#."    // 5DA2  
        gfx_row "#..#...."    // 
        gfx_row ".......#"    // 
        gfx_row ".#...#.."    // 
        gfx_row "........"    // 5DA6  
        gfx_row "....#.#."    // 
        gfx_row "..#....."    // 
        gfx_row ".....#.."    // 

        gfx_row "....#..."    // 5DAA  MOB PIC #12 & #13
        gfx_row ".######."    // 
        gfx_row "########"    // 
        gfx_row "########"    // 
        gfx_row ".######."    // 5DAE  
        gfx_row "...#...."    // 
        gfx_row "..#..#.."    // 
        gfx_row "........"    // 
        gfx_row ".....#.."    // 5DB2  
        gfx_row ".#......"    // 
        gfx_row "......#."    // 
        gfx_row "#..#...."    // 
        gfx_row ".......#"    // 5DB6  
        gfx_row ".#...#.."    // 
        gfx_row "........"    // 
        gfx_row "....#.#."    // 

        gfx_row "....#..."    // 5DBA  MOB PIC #14 & #15
        gfx_row ".######."    // 
        gfx_row "########"    // 
        gfx_row "########"    // 
        gfx_row ".######."    // 5DBE  
        gfx_row "...#...."    // 
        gfx_row "....#.#."    // 
        gfx_row "........"    // 
        gfx_row "..#..#.."    // 5DC2  
        gfx_row "........"    // 
        gfx_row ".....#.."    // 
        gfx_row ".#......"    // 
        gfx_row "......#."    // 5DC6  
        gfx_row "#..#...."    // 
        gfx_row ".......#"    // 
        gfx_row ".#...#.."    // 

        gfx_row "....#..."    // 5DCA  MOB PIC #16 & #17
        gfx_row ".######."    // 
        gfx_row "########"    // 
        gfx_row "########"    // 
        gfx_row ".######."    // 5DCE  
        gfx_row "...#...."    // 
        gfx_row ".#...#.#"    // 
        gfx_row "........"    // 
        gfx_row "....#.#."    // 5DD2  
        gfx_row "........"    // 
        gfx_row "..#..#.."    // 
        gfx_row "........"    // 
        gfx_row ".....#.."    // 5DD6  
        gfx_row ".#......"    // 
        gfx_row "......#."    // 
        gfx_row "#..#...."    // 

        gfx_row "....#..."    // 5DDA  MOB PIC #18 & #19
        gfx_row ".######."    // 
        gfx_row "########"    // 
        gfx_row "########"    // 
        gfx_row ".######."    // 5DDE  
        gfx_row "...#...."    // 
        gfx_row "#.....#."    // 
        gfx_row "...#...#"    // 
        gfx_row ".#...#.."    // 5DE2  
        gfx_row "........"    // 
        gfx_row "....#.#."    // 
        gfx_row "........"    // 
        gfx_row "..#..#.."    // 5DE6  
        gfx_row "........"    // 
        gfx_row ".....#.."    // 
        gfx_row ".#......"    // 
        
        gfx_row "...#...."    // 5DEA  MOB PIC #1A & #1B
        gfx_row "....#..."    // 
        gfx_row "...#...."    // 
        gfx_row "...##..."    // 
        gfx_row "...##..."    // 5DEE  
        gfx_row "....#..."    // 
        gfx_row "...#...."    // 
        gfx_row "....#..."    // 
        gfx_row "........"    // 5DF2  
        gfx_row "........"    // 
        gfx_row "........"    // 
        gfx_row "........"    // 
        gfx_row "........"    // 5DF6  
        gfx_row "........"    // 
        gfx_row "........"    // 
        gfx_row "........"    // 

        gfx_row "....#..."    // 5DFA  MOB PIC #1C & #1D
        gfx_row ".....#.."    // 
        gfx_row "....#..."    // 
        gfx_row "...##..."    // 
        gfx_row "...##..."    // 5DFE  
        gfx_row "...#...."    // 
        gfx_row "..#....."    // 
        gfx_row "...#...."    // 
        gfx_row "........"    // 5E02  
        gfx_row "........"    // 
        gfx_row "........"    // 
        gfx_row "........"    // 
        gfx_row "........"    // 5E06  
        gfx_row "........"    // 
        gfx_row "........"    // 
        gfx_row "........"    // 

        gfx_row "......#."    // 5E0A  MOB PIC #1E & #1F
        gfx_row "......#."    // 
        gfx_row ".....#.."    // 
        gfx_row "...##..."    // 
        gfx_row "...##..."    // 5E0E  
        gfx_row "..#....."    // 
        gfx_row ".#......"    // 
        gfx_row ".#......"    // 
        gfx_row "........"    // 5E12  
        gfx_row "........"    // 
        gfx_row "........"    // 
        gfx_row "........"    // 
        gfx_row "........"    // 5E16  
        gfx_row "........"    // 
        gfx_row "........"    // 
        gfx_row "........"    // 

        gfx_row "........"    // 5E1A  MOB PIC #20 & #21
        gfx_row "........"    // 
        gfx_row "........"    // 
        gfx_row ".#.###.#"    // 
        gfx_row "#.###.#."    // 5E1E  
        gfx_row "........"    // 
        gfx_row "........"    // 
        gfx_row "........"    // 
        gfx_row "........"    // 5E22  
        gfx_row "........"    // 
        gfx_row "........"    // 
        gfx_row "........"    // 
        gfx_row "........"    // 5E26  
        gfx_row "........"    // 
        gfx_row "........"    // 
        gfx_row "........"    // 

        gfx_row "........"    // 5E2A  MOB PIC #22 & #23
        gfx_row "........"    // 
        gfx_row ".#......"    // 
        gfx_row "#.###..."    // 
        gfx_row "...##.##"    // 5E2E  
        gfx_row "......#."    // 
        gfx_row "........"    // 
        gfx_row "........"    // 
        gfx_row "........"    // 5E32  
        gfx_row "........"    // 
        gfx_row "........"    // 
        gfx_row "........"    // 
        gfx_row "........"    // 5E36  
        gfx_row "........"    // 
        gfx_row "........"    // 
        gfx_row "........"    // 

        gfx_row ".#......"    // 5E3A  MOB PIC #24 & #25
        gfx_row ".#......"    // 
        gfx_row "..#....."    // 
        gfx_row "...##..."    // 
        gfx_row "...##..."    // 5E3E  
        gfx_row ".....#.."    // 
        gfx_row "......#."    // 
        gfx_row "......#."    // 
        gfx_row "........"    // 5E42  
        gfx_row "........"    // 
        gfx_row "........"    // 
        gfx_row "........"    // 
        gfx_row "........"    // 5E46  
        gfx_row "........"    // 
        gfx_row "........"    // 
        gfx_row "........"    // 

.GFX_LIST_5E4A:

        gfx_row "########"    // 5E4A  CART PIC #00
        gfx_row "########"    // 
        gfx_row "########"    // 
        gfx_row "########"    // 
        gfx_row "########"    // 5E4E  
        gfx_row "########"    // 
        gfx_row "########"    // 
        gfx_row "########"    // 

        gfx_row "........"    // 5E52  CART PIC #01
        gfx_row "#.#.#.#."    // 
        gfx_row "#######."    // 
        gfx_row ".#####.."    // 
        gfx_row ".#####.."    // 5E56  
        gfx_row ".#####.."    // 
        gfx_row ".#####.."    // 
        gfx_row ".#####.."    // 

        gfx_row "........"    // 5E5A  CART PIC #02
        gfx_row "#.#..#.#"    // 
        gfx_row "#.#..#.#"    // 
        gfx_row "#.#..#.#"    // 
        gfx_row "########"    // 5E5E  
        gfx_row "#.####.#"    // 
        gfx_row "########"    // 
        gfx_row "###..###"    // 

        gfx_row "........"    // 5E62  CART PIC #03
        gfx_row "#.#.#.#."    // 
        gfx_row ".#...#.."    // 
        gfx_row "########"    // 
        gfx_row "........"    // 5E66  
        gfx_row "#.#.#.#."    // 
        gfx_row ".#...#.."    // 
        gfx_row "########"    // 

        gfx_row "........"    // 5E6A  CART PIC #04
        gfx_row "########"    // 
        gfx_row "...##..."    // 
        gfx_row "..####.."    // 
        gfx_row "..####.."    // 5E6E  
        gfx_row ".######."    // 
        gfx_row ".######."    // 
        gfx_row "########"    // 

        gfx_row "...##..."    // 5E72  CART PIC #05
        gfx_row "...##..."    // 
        gfx_row "...##..."    // 
        gfx_row "########"    // 
        gfx_row "########"    // 5E76  
        gfx_row "...##..."    // 
        gfx_row "...##..."    // 
        gfx_row "...##..."    // 

        gfx_row "...##..."    // 5E7A  CART PIC #06
        gfx_row "..####.."    // 
        gfx_row ".##..##."    // 
        gfx_row "########"    // 
        gfx_row "########"    // 5E7E  
        gfx_row "#..#####"    // 
        gfx_row "#..##.##"    // 
        gfx_row "#####.##"    // 

        gfx_row "....##.."    // 5E82  CART PIC #07
        gfx_row "....##.."    // 
        gfx_row "...#...#"    // 
        gfx_row ".######."    // 
        gfx_row ".##..#.."    // 5E86  
        gfx_row "###.#..."    // 
        gfx_row "..#....."    // 
        gfx_row "..#....."    // 

        gfx_row "........"    // 5E8A  CART PIC #08
        gfx_row "........"    // 
        gfx_row "....#..."    // 
        gfx_row "...###.."    // 
        gfx_row ".#######"    // 5E8E  
        gfx_row "..#####."    // 
        gfx_row "........"    // 
        gfx_row "........"    // 

        gfx_row "........"    // 5E92  CART PIC #09
        gfx_row ".....#.."    // 
        gfx_row "#....#.."    // 
        gfx_row ".#.###.."    // 
        gfx_row "########"    // 5E96  
        gfx_row ".######."    // 
        gfx_row "........"    // 
        gfx_row "........"    // 

        gfx_row "........"    // 5E9A  CART PIC #0A
        gfx_row ".....#.."    // 
        gfx_row "#.#..#.#"    // 
        gfx_row ".#.###.."    // 
        gfx_row "###.####"    // 5E9E  
        gfx_row ".######."    // 
        gfx_row "........"    // 
        gfx_row "........"    // 

        gfx_row ".....#.."    // 5EA2  CART PIC #0B
        gfx_row "#.#....#"    // 
        gfx_row ".....#.."    // 
        gfx_row ".#.###.."    // 
        gfx_row "########"    // 5EA6  
        gfx_row ".######."    // 
        gfx_row "........"    // 
        gfx_row "........"    // 

        gfx_row "#.#....."    // 5EAA  CART PIC #0C
        gfx_row "......#."    // 
        gfx_row ".#.#.#.#"    // 
        gfx_row "........"    // 
        gfx_row "########"    // 5EAE  
        gfx_row ".######."    // 
        gfx_row "........"    // 
        gfx_row "........"    // 

        gfx_row "#.#....#"    // 5EB2  CART PIC #0D
        gfx_row "....#..."    // 
        gfx_row ".#...#.."    // 
        gfx_row "...#...."    // 
        gfx_row "##...###"    // 5EB6  
        gfx_row ".######."    // 
        gfx_row "........"    // 
        gfx_row "........"    // 

        gfx_row "#....#.."    // 5EBA  CART PIC #0E
        gfx_row "..#...#."    // 
        gfx_row "........"    // 
        gfx_row ".....##."    // 
        gfx_row "....##.."    // 5EBE  
        gfx_row ".#####.."    // 
        gfx_row "........"    // 
        gfx_row "........"    // 

        gfx_row "#......#"    // 5EC2  CART PIC #0F
        gfx_row "........"    // 
        gfx_row ".....#.."    // 
        gfx_row "....##.."    // 
        gfx_row "..###..."    // 5EC6  
        gfx_row ".###...."    // 
        gfx_row "........"    // 
        gfx_row "........"    // 

        gfx_row "........"    // 5ECA  CART PIC #10
        gfx_row "........"    // 
        gfx_row "........"    // 
        gfx_row ".....#.."    // 
        gfx_row "....##.."    // 5ECE  
        gfx_row "..###..."    // 
        gfx_row "........"    // 
        gfx_row "........"    // 

        gfx_row "........"    // 5ED2  CART PIC #11
        gfx_row "........"    // 
        gfx_row "........"    // 
        gfx_row "........"    // 
        gfx_row "....#..."    // 5ED6  
        gfx_row "...##..."    // 
        gfx_row "........"    // 
        gfx_row "........"    // 

        gfx_row "........"    // 5EDA  CART PIC #12
        gfx_row "........"    // 
        gfx_row "........"    // 
        gfx_row "........"    // 
        gfx_row "........"    // 5EDE  
        gfx_row "...#...."    // 
        gfx_row "........"    // 
        gfx_row "........"    // 

        gfx_row "........"    // 5EE2  CART PIC #13
        gfx_row "........"    // 
        gfx_row "..###..."    // 
        gfx_row ".#####.."    // 
        gfx_row "...#####"    // 5EE6  
        gfx_row "..####.#"    // 
        gfx_row ".#####.#"    // 
        gfx_row "######.."    // 

        gfx_row ".....###"    // 5EEA  CART PIC #14
        gfx_row "....####"    // 
        gfx_row "..######"    // 
        gfx_row "...#####"    // 
        gfx_row "..######"    // 5EEE  
        gfx_row "...#####"    // 
        gfx_row "..######"    // 
        gfx_row ".#######"    // 

        gfx_row "#.##...."    // 5EF2  CART PIC #15
        gfx_row "#####..."    // 
        gfx_row "####..#."    // 
        gfx_row "#######."    // 
        gfx_row "######.."    // 5EF6  
        gfx_row "#####..."    // 
        gfx_row "######.."    // 
        gfx_row "#######."    // 

        gfx_row ".####..."    // 5EFA  CART PIC #16
        gfx_row "..####.."    // 
        gfx_row "..####.."    // 
        gfx_row "...###.."    // 
        gfx_row "....#..."    // 5EFE  
        gfx_row "....#..."    // 
        gfx_row "....##.."    // 
        gfx_row "........"    // 

        gfx_row "########"    // 5F02  CART PIC #17
        gfx_row ".#######"    // 
        gfx_row "..######"    // 
        gfx_row "..######"    // 
        gfx_row "...#####"    // 5F06  
        gfx_row "..######"    // 
        gfx_row "########"    // 
        gfx_row ".#######"    // 

        gfx_row "########"    // 5F0A  CART PIC #18
        gfx_row "########"    // 
        gfx_row "######.#"    // 
        gfx_row "######.."    // 
        gfx_row "#######."    // 5F0E  
        gfx_row "########"    // 
        gfx_row "########"    // 
        gfx_row "#######."    // 

        gfx_row "....####"    // 5F12  CART PIC #19
        gfx_row "...#####"    // 
        gfx_row "...#####"    // 
        gfx_row ".#######"    // 
        gfx_row "########"    // 5F16  
        gfx_row "..######"    // 
        gfx_row ".#######"    // 
        gfx_row "####.##."    // 

        gfx_row "#......."    // 5F1A  CART PIC #1A
        gfx_row "###....."    // 
        gfx_row "####...."    // 
        gfx_row "######.."    // 
        gfx_row "########"    // 5F1E  
        gfx_row "##.####."    // 
        gfx_row "#...##.."    // 
        gfx_row "........"    // 

        gfx_row ".#..##.#"    // 5F22  CART PIC #1B
        gfx_row "##.#####"    // 
        gfx_row "########"    // 
        gfx_row "########"    // 
        gfx_row "########"    // 5F26  
        gfx_row "########"    // 
        gfx_row "##...###"    // 
        gfx_row "...#####"    // 

        gfx_row ".####..#"    // 5F2A  CART PIC #1C
        gfx_row "########"    // 
        gfx_row "########"    // 
        gfx_row "########"    // 
        gfx_row "########"    // 5F2E  
        gfx_row "########"    // 
        gfx_row "########"    // 
        gfx_row ".#######"    // 

        gfx_row "########"    // 5F32  CART PIC #1D
        gfx_row "#.######"    // 
        gfx_row "#.######"    // 
        gfx_row "..######"    // 
        gfx_row ".#######"    // 5F36  
        gfx_row "########"    // 
        gfx_row "######.#"    // 
        gfx_row ".#..##.."    // 

        gfx_row "########"    // 5F3A  CART PIC #1E
        gfx_row "########"    // 
        gfx_row "########"    // 
        gfx_row "########"    // 
        gfx_row "########"    // 5F3E  
        gfx_row "##..####"    // 
        gfx_row "##...###"    // 
        gfx_row "#.....##"    // 

        gfx_row "########"    // 5F42  CART PIC #1F
        gfx_row "#######."    // 
        gfx_row "#####..."    // 
        gfx_row "######.."    // 
        gfx_row "######.."    // 5F46  
        gfx_row "######.."    // 
        gfx_row "#.###..."    // 
        gfx_row "........"    // 

        gfx_row "#....#.."    // 5F4A  CART PIC #20
        gfx_row "##..####"    // 
        gfx_row "########"    // 
        gfx_row "########"    // 
        gfx_row "########"    // 5F4E  
        gfx_row "########"    // 
        gfx_row "########"    // 
        gfx_row "########"    // 

        // This is called from one of the SFX
UC_5F52:
        MVI     .PSG0.noise,R1                  // 5F52  
        PSHR    R1                              // 5F54   0271
        SAR     R1,     1                       // 5F55   0069
        MVO     R1,     G_01A6                  // 5F56   0241 01A6
        PULR    R1                              // 5F58   02F1
        MVO     R1,     G_01A5                  // 5F59   0241 01A5
        CLRR    R1                              // 5F5B   01C9
        MVO     R1,     G_01A7                  // 5F5C   0241 01A7

        // This is called from one of the SFX
UC_5F5E:
        MVI     G_01A7, R1                      // 5F5E  
        TSTR    R1                              // 5F60   0089
        BEQ     L_5F74                          // 5F61   0204 0011

        MVI     .PSG0.noise,R1                  // 5F63   0281 01F9
        SUB     G_015C, R1                      // 5F65   0301 015C
        MVO     R1,     .PSG0.noise             // 5F67   0241 01F9
        CMP     G_01A5, R1                      // 5F69   0341 01A5
        BGE     L_5F70                          // 5F6B   020D 0003

        MVO     R1,     G_01A7                  // 5F6D   0241 01A7
        PULR    R7                              // 5F6F   02B7

L_5F70:
        CLRR    R1                              // 5F70   01C9
        MVO     R1,     G_01A7                  // 5F71   0241 01A7
        PULR    R7                              // 5F73   02B7

L_5F74:
        MVI     .PSG0.chn_a_lo,R1               // 5F74   0281 01F0
        SUBI    #$000A, R1                      // 5F76   0339 000A
        MVO     R1,     .PSG0.chn_a_lo          // 5F78   0241 01F0
        MVI     .PSG0.chn_b_lo,R1               // 5F7A   0281 01F1
        SUBI    #$0007, R1                      // 5F7C   0339 0007
        MVO     R1,     .PSG0.chn_b_lo          // 5F7E   0241 01F1
        MVI     .PSG0.chn_c_lo,R1               // 5F80   0281 01F2
        SUBI    #$000F, R1                      // 5F82   0339 000F
        MVO     R1,     .PSG0.chn_c_lo          // 5F84   0241 01F2
        MVI     .PSG0.noise,R1                  // 5F86   0281 01F9
        MVI     G_015B, R0                      // 5F88   0280 015B
        ADDR    R0,     R1                      // 5F8A   00C1
        MVO     R1,     .PSG0.noise             // 5F8B   0241 01F9
        CMP     G_01A6, R1                      // 5F8D   0341 01A6
        BLE     L_5F92                          // 5F8F   0206 0001
        PULR    R7                              // 5F91   02B7

L_5F92:
        MVII    #$0001, R1                      // 5F92   02B9 0001
        MVO     R1,     G_01A7                  // 5F94   0241 01A7
        PULR    R7                              // 5F96   02B7

L_5F97: PSHR    R5                              // 5F97   0275
        JSR     R5,     X_PLAY_SFX2             // 5F98   0004 0118 03BE
        DECLE   $0081                           // 5F9B  SFX prio
        DECLE   $0040,  $0010                   // 5F9C  SFX data
        DECLE   $0048,  $001B                   // 5F9E  SFX data
        DECLE   $0044,  $0016                   // 5FA0  SFX data
        DECLE   $02CD                           // 5FA2  SFX data
        DECLE   $038B                           // 5FA3  SFX data
        DECLE   $00FD                           // 5FA4  SFX data
        DECLE   $013D                           // 5FA5  SFX data
        DECLE   $0003,  $0075                   // 5FA6  SFX data

L_5FA8: PSHR    R5                              // 5FA8   0275
        JSR     R5,     X_PLAY_SFX2             // 5FA9   0004 0118 03BE
        DECLE   $0082                           // 5FAC  SFX data
        DECLE   $0040,  $0080                   // 5FAD  SFX data
        DECLE   $0048,  $0077                   // 5FAF  SFX data
        DECLE   $0044,  $0054                   // 5FB1  SFX data
        DECLE   $013D                           // 5FB3  SFX data
        DECLE   $0003,  $002D                   // 5FB4  SFX data

L_5FB6: PSHR    R5                              // 5FB6   0275
        JSR     R5,     X_PLAY_SFX2             // 5FB7   0004 0117 03BE
        DECLE   $0082                           // 5FBA  SFX data
        DECLE   $0040,  $0280                   // 5FBB  SFX data
        DECLE   $0048,  $0177                   // 5FBD  SFX data
        DECLE   $0044,  $0154                   // 5FBF  SFX data
        DECLE   $03ED                           // 5FC1  SFX data
        DECLE   $000B                           // 5FC2  SFX data
        DECLE   $03FD                           // 5FC3  SFX data
        DECLE   $02BD                           // 5FC4  SFX data
        DECLE   $0009                           // 5FC5  SFX data
        DECLE   $03B7                           // 5FC6  SFX data
        DECLE   $00EC,  $00F6                   // 5FC7  SFX data
        DECLE   $0077,  $0052,  $005F           // 5FC9  SFX data
        DECLE   $004F,  $00FE                   // 5FCC  SFX data
        DECLE   $0077,  $005E,  $005F           // 5FCE  SFX data
        DECLE   $0023,  $03EC                   // 5FD1  SFX data
        DECLE   $02CF                           // 5FD3  SFX end

FISH_PLING:
L_5FD4: PSHR    R5                              // 5FD4   0275
        JSR     R5,     X_PLAY_SFX2             // 5FD5   0004 0118 03BE
        DECLE   $007F                           // 5FD8  SFX prio
        DECLE   $000B                           // 5FD9  SFX data
        DECLE   $00BD                           // 5FDA  SFX data
        DECLE   $00FD                           // 5FDB  SFX data
        DECLE   $0389                           // 5FDC  SFX data
        DECLE   $03B7                           // 5FDD  SFX data
        DECLE   $03ED                           // 5FDE  SFX data
        DECLE   $0040,  $00DD                   // 5FDF  SFX data
        DECLE   $0048,  $00CC                   // 5FE1  SFX data
        DECLE   $0044,  $000B                   // 5FE3  SFX data
        DECLE   $03DB                           // 5FE5  SFX data
        DECLE   $005C,  $024F                   // 5FE6  SFX data
        DECLE   $0077,  $0052,  $005F           // 5FE8  SFX data
        DECLE   $004F,  $002E                   // 5FEB  SFX data
        DECLE   $0003,  $037C                   // 5FED  SFX data

L_5FEF: PSHR    R5                              // 5FEF   0275
        JSR     R5,     X_PIANO_TUNE            // 5FF0   0004 0118 0395
        DECLE   $03F4,  $0183                   // 5FF3  SFX data
        DECLE   $03F4,  $000D                   // 5FF5  SFX data
        DECLE   $03F4,  $00C3                   // 5FF7  SFX data
        DECLE   $03F4,  $000D                   // 5FF9  SFX data
        DECLE   $03F2                           // 5FFB  SFX data
        DECLE   $0114,  $000C                   // 5FFC  SFX data
        DECLE   $0000                           // 5FFE  SFX data
        PULR    R7                              // 5FFF   2B7

// ======================================================================== //
//  Branch cross-reference
// ------------------------------------------------------------------------ //
//  Target      Target of
//  $5043       $504F   $50C1  
//  $504C       <entry>
//  $504F       $507F  
//  $507C       $5076  
//  $5081       $507A  
//  $5083       $50B0  
//  $50AD       $50B4  
//  $50B2       $50AB  
//  $50C1       $50BB  
//  $50D7       $50F1  
//  $50E6       $50DE  
//  $50EA       $50E4  
//  $511D       $50EA  
//  $5179       $5179  
//  $518A       $518A  
//  $519B       $519B  
//  $51A3       <entry>
//  $51AA       $51A7  
//  $51B4       $51E3  
//  $51BF       $51C4  
//  $51C2       $51BB  
//  $51C6       $51B0  
//  $51C8       $51D1  
//  $51D5       $51CB  
//  $51E9       $51C0  
//  $51F8       $51B2   $51D3   $51F1  
//  $51FA       $5209  
//  $5205       $5200  
//  $520D       $5202   $52F0  
//  $522A       $521D  
//  $522D       $5221  
//  $5230       $5225  
//  $5231       $5228   $522B   $522E  
//  $5236       $520B  
//  $5240       $523C  
//  $5242       $524B  
//  $524F       $5245  
//  $526A       $5265   $52E2  
//  $5280       $5289  
//  $5284       $5279  
//  $528B       $5282  
//  $529F       $52B3  
//  $52AB       $5292  
//  $52B5       $523E   $524D   $5268  
//  $52BF       $52BB  
//  $52C1       $52CA  
//  $52CE       $52C4  
//  $52E5       $52BD   $52CC  
//  $52E7       $52F8  
//  $52F4       $52ED  
//  $52FC       $530F  
//  $530B       $5304  
//  $5313       $531C  
//  $5320       $5307   $5314  
//  $5346       $533B   $5342  
//  $5348       $53C2  
//  $5354       $534F  
//  $5358       $534A  
//  $5360       $535B  
//  $5362       $5352   $5356   $535E  
//  $5377       $536D  
//  $5386       $537C   $5380  
//  $538A       $5375  
//  $5395       $538E  
//  $5398       $5393  
//  $53A5       $539C  
//  $53AA       $53A0   $53A3   $53A7  
//  $53B4       $53AF  
//  $53B5       $5348   $5364   $5368   $5373   $5384   $5388   $53B2  
//  $53C4       $53B8  
//  $53CE       $536F   $5377   $54A3   $54FD   $573E   $57E5   $5C09   $5C63  
//  $53D5       $536A   $588D  
//  $53DD       $531E  
//  $53E5       $53E2  
//  $53FD       $547C  
//  $540E       $510A   $5405  
//  $5429       $53FB  
//  $5432       $5473  
//  $5448       $543A  
//  $5452       $5446  
//  $5456       $545F  
//  $5475       $5464  
//  $547E       $53FF  
//  $54B2       $54AC  
//  $54B3       $54B0  
//  $54B5       $54D0  
//  $54C9       $54BD  
//  $54CA       $54A8   $54C7  
//  $54D2       $54C1   $5751  
//  $54E8       $540B   $5426  
//  $54F7       $54F2   $5595  
//  $54F8       $54F4  
//  $550F       $5545   $554A  
//  $551B       $5553  
//  $552A       $5597  
//  $553A       $5523  
//  $553B       $5502   $5515   $5543   $5548   $554E  
//  $553C       $550D  
//  $5547       $5540  
//  $554C       $5511  
//  $5555       $54EB  
//  $5562       $555C  
//  $5564       $5560  
//  $5569       $5564  
//  $5588       $5576  
//  $5591       $5708  
//  $559A       $55D6   $5628   $563E  
//  $55B1       $55A7  
//  $55B5       $55AF  
//  $55D5       $55E0   $55E5  
//  $55D8       $55CC   $5625   $563B  
//  $55D9       $55D3  
//  $55E3       $55DC  
//  $5601       $55FA  
//  $5608       $561E  
//  $560C       $55F4  
//  $5617       $5610  
//  $564A       $5507   $55CF   $5621  
//  $564F       $568F  
//  $5650       $5675  
//  $5654       $566E  
//  $565B       $5656  
//  $565F       $5659  
//  $5670       $566C  
//  $5677       $5671  
//  $567A       $5666  
//  $5680       $5687  
//  $5686       $567C  
//  $568D       $5C17  
//  $569D       $56A9   $56AC  
//  $56A1       $5699  
//  $56AB       $56A5  
//  $56AF       $569F  
//  $56BC       $5705  
//  $56FD       $56C6   $56CF  
//  $56FF       $56B4  
//  $5701       $56B7  
//  $5707       $56D6   $56DA  
//  $570D       $5527   $56D1   $5BA5   $5C29  
//  $571B       $5716  
//  $571C       $56F5   $5B9D   $5C7C  
//  $5725       $572C  
//  $572E       $572A  
//  $573E       $56FF   $570B  
//  $5758       $574D  
//  $5759       $5743  
//  $575A       $5113   $5408  
//  $577C       $579B  
//  $5788       $5797   $579F  
//  $5793       $578E  
//  $5796       $577E  
//  $5799       $5778  
//  $579D       $5784  
//  $57B4       $57A8  
//  $57CB       $57BB  
//  $57D1       $57B0  
//  $57D8       $5812  
//  $57E5       $5819  
//  $57F2       $57EA   $57EE  
//  $5800       $581F  
//  $5808       $580E   $5861  
//  $580A       $5802  
//  $5810       $57D4  
//  $5814       $57DE  
//  $581B       $57FA  
//  $5821       $57B2  
//  $5829       $586B  
//  $584A       $5867  
//  $585D       $5875  
//  $5863       $5844  
//  $5869       $5825  
//  $586D       $5851  
//  $5877       $57C8  
//  $5888       $591B  
//  $589C       $5922   $5932   $593F  
//  $58A0       $587D  
//  $58CA       $58BD  
//  $58D8       $58D2  
//  $58F1       $58E1  
//  $58FD       $575E   $58C8  
//  $5919       $5884  
//  $591D       $5895  
//  $5924       $5881  
//  $5934       $5925  
//  $5941       $57BF   $57CD   $57E3   $57F0   $5817   $582F   $583C   $5840  
//  $5941       $5890   $589A   $589E   $58B1   $5920  
//  $594C       $58BF  
//  $595A       $58C2   $5951  
//  $5964       $595E  
//  $5965       $5962  
//  $5968       $532F   $54A0   $54FA   $564C   $56AF   $57D8   $5832   $5888  
//  $5987       $546B   $5470  
//  $5993       $59B1   $59BF   $59CB  
//  $599B       $59AA  
//  $59A1       $5989   $59B5   $59C3  
//  $59A5       $5772   $5994  
//  $59AC       $542A   $542F  
//  $59CD       $53F3  
//  $59D1       $5A0C  
//  $59FD       $59F9  
//  $5A0E       $59DD   $59E5   $59FD  
//  $5A16       $5A27  
//  $5A24       $5A00  
//  $5A29       $54D5   $56DE   $5A18   $5A34   $5A8F   $5ABF   $5B46  
//  $5A2F       $5A06  
//  $5A32       $5AAD  
//  $5A55       $5A51  
//  $5A72       $5A6E  
//  $5AA0       $5A9A  
//  $5AAF       $5A46   $5A4B  
//  $5ABA       $5AA8  
//  $5ABD       $5B69  
//  $5AE7       $5AE3  
//  $5B05       $5B01  
//  $5B29       $5B25  
//  $5B44       $5B40  
//  $5B6B       $5B63  
//  $5B74       $5BB0  
//  $5B7E       $5B78  
//  $5B7F       $5B7C  
//  $5BAB       $5B8B   $5B93  
//  $5BB5       $5BDE  
//  $5BD5       $5BE6   $5C4E   $5C6D   $5C83  
//  $5BE0       $5BD8   $5BE4   $5C4C  
//  $5BE1       $5BEC  
//  $5BE8       $5957   $5BC5   $5BCF   $5C0E   $5C12   $5C1C  
//  $5BFC       $5BF4  
//  $5C00       $5BFA  
//  $5C37       $5C22   $5C26  
//  $5C3F       $5C35  
//  $5C50       $5BCB   $5BD3  
//  $5C5B       $5C53  
//  $5C5F       $5C59  
//  $5C60       $5C70  
//  $5C72       $5C68  
//  $5CEE       $5CEE  
//  $5CF3       $5CF3  
//  $5CFC       $5CFC  
//  $5D09       $5D09  
//  $5D12       $5D12  
//  $5F52       <entry>
//  $5F5E       <entry>
//  $5F70       $5F6B  
//  $5F74       $5F61  
//  $5F92       $5F8F  
//  $5F97       $5754  
//  $5FD4       $54C4  
// ======================================================================== //
