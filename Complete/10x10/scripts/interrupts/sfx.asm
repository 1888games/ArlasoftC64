.macro sfx(sfx_id)
{		

			ldx #sfx_id
			jsr sfx_play
}

music_on: .byte 0

set_sfx_routine:
{
			lda music_on
			bne !on+
			
			lda #<play_no_music
			sta sfx_play.sfx_routine + 1
			
			lda #>play_no_music
			sta sfx_play.sfx_routine + 2
			rts
			
		!on:
			lda #<play_with_music
			sta sfx_play.sfx_routine + 1
			
			lda #>play_with_music
			sta sfx_play.sfx_routine + 2
			rts	
}

sfx_play:
{			
	sfx_routine:
			jmp play_with_music
}


//when sid is not playing, we can use any of the channels to play effects
play_no_music:
{

			lda wavetable_l,x
			ldy wavetable_h,x
			ldx channel
			dex
			bpl !skp+			
			ldx #2
		!skp:
			stx channel
			pha
			lda times7,x
			tax
			pla
			jmp sid.init + 6			
			
channel:
.byte 2
times7:
.fill 3, 7 * i			
}


play_with_music:
{
			lda wavetable_l,x
			ldy wavetable_h,x
			ldx #7 * 2
			jmp sid.init + 6
			rts
}


//effects must appear in order of priority, lowest priority first.
.label SFX_FOOTSTEP = 0
.label SFX_BALLBOUNCE = 1
.label SFX_CASH = 2
.label SFX_HIT	= 3
.label SFX_JUMP	= 4
.label SFX_LIFT	= 5
.label SFX_PLANE = 6
.label SFX_DOOR = 7
.label SFX_BONUS = 8

sfx_footstep:
.import binary "../../Assets/sfx/bzzt"

sfx_ballbounce:
.import binary "../../Assets/sfx/die"

sfx_cash:
.import binary "../../Assets/sfx/diceroll"

sfx_hit:
.import binary "../../Assets/sfx/sfx_crunch"

sfx_jump:
.import binary "../../Assets/sfx/pickup"

sfx_lift:
.import binary "../../Assets/sfx/boing.snd"

sfx_plane:
.import binary "../../Assets/sfx/sfx_arp"

sfx_door:
.import binary "../../Assets/sfx/sfx_pst"

sfx_bonus:
.import binary "../../Assets/sfx/sfx_thud"

wavetable_l:
.byte <sfx_footstep, <sfx_ballbounce, <sfx_cash, <sfx_hit, <sfx_jump, <sfx_lift, <sfx_plane, <sfx_door, <sfx_bonus

wavetable_h:
.byte >sfx_footstep, >sfx_ballbounce, >sfx_cash, >sfx_hit, >sfx_jump, >sfx_lift, >sfx_plane, >sfx_door, >sfx_bonus



