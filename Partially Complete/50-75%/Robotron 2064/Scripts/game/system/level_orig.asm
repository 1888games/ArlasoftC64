
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
2E24: 0F 11 16 22 14 20 00 23 3C 19 23 00 23 1B 19 
2E33: 23 00 23 46 19 23 00 23 00 19 23 00 23 4B 19 23 
2E43: 00 23 1E 1B 23 00 23 50 1E 

// Electrode counts
2E4C: 05 0F 19 19 14 19 00 
2E53: 19 00 14 19 00 19 05 14 19 00 19 00 14 19 00 19 
2E63: 00 14 19 00 19 00 14 19 00 19 00 0F 19 00 19 00 
2E73: 0F 

// Mommies
2E74: 01 01 02 02 0F 03 
2E7A: 04 03 03 00 03 03 03 05 00 
2E83: 03 03 03 03 08 03 03 03 03 19 03 03 03 03 00 03 
2E93: 03 03 03 00 03 03 03 03 0A 

// Daddies
2E9C: 01 01 02 02 00 03 
2EA5: 04 03 03 16 03 03 03 05 00 
2EB3: 03 03 03 03 08 03 03 03 03 00 03 03 03 03 19 03
2EC3: 03 03 03 00 03 03 03 03 0A 



// Mikeys
2EC4: 00 01 02 02 01 03 
2ED3: 04 03 03 00 03 03 03 05 16 
2EE3: 03 03 03 03 08 03 03 03 03 01 03 03 03 03 00 03
	  03 03 03 19 03 03 03 03 0A 


// Hulks
2EEC: 00 05 06 07 00 07 0C 08 04 00 08 0D 08 14 02 
2EFB: 03 0E 08 03 02 08 0F 08 
2F03: 0D 01 08 10 08 04 01 08 10 08 19 02 08 10 08 06 
2F13: 02 


// Brains 
2F14: 00 00 00 00 0F 00 00 00 00 14 00 00 00 00 14 
2F23: 00 00 00 
2F26: 00 14 00 00 00 00 15 00 00 00 00 16 00 
2F33: 00 00 00 17 00 00 00 00 19 


// Spheroids
2F3C: 00 01 03 04 01 04 00 
2F43: 05 05 01 05 00 05 02 01 05 00 05 05 02 05 
2F51: 00 05 
2F53: 06 01 05 00 05 05 01 05 00 05 02 01 05 00 05 05 
2F63: 01 



// Quarks
2F64: 00 00 00 00 00 00 0A 00 00 00 00 0C 00 00 00 
2F73: 00 0C 00 00 00 00 0C 00 07 
2F7C: 00 00 0C 01 01 01 01 0D 01 02 02 02 0E 02 01 01 


































