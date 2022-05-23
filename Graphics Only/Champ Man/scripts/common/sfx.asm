.macro sfx(sfx_id)
{		
		:Storestate()

		ldx #sfx_id
		jsr sfx_play

		:Restorestate()
}

.macro sfxFromX() {

		:Storestate()

		jsr sfx_play

		:Restorestate()

}

music_on: .byte 1

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
			lda channels, x
			sta channel
			lda wavetable_l,x
			ldy wavetable_h,x
			ldx channel
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


StopChannel0: {

	lda #0
	sta $d404

	rts


}




//effects must appear in order of priority, lowest priority first.
.label SFX_FIRE = 0
.label SFX_DEAD = 1
.label SFX_HIT= 2
.label SFX_UP	= 3
.label SFX_DOWN	= 4
.label SFX_LIFT	= 5
.label SFX_plaNE = 6
.label SFX_DOOR = 7
.label SFX_BONUS = 8

channels:	.byte 2, 0, 1, 1, 0, 0, 0, 0, 0, 0

sfx_fire:
.import binary "../../Assets/sfx/bonus.snd"

sfx_dead:
.import binary "../../Assets/sfx/jump.snd"


sfx_hit:
.import binary "../../Assets/sfx/pickup"


sfx_up:
.import binary "../../Assets/sfx/sfx_arp"

sfx_down:
.import binary "../../Assets/sfx/sfx_bnce"

sfx_lift:
.import binary "../../Assets/sfx/lift.snd"

sfx_plane:
.import binary "../../Assets/sfx/door.snd"

sfx_door:
.import binary "../../Assets/sfx/boing.snd"

sfx_bonus:
.import binary "../../Assets/sfx/igloo.snd"

wavetable_l:
.byte <sfx_fire, <sfx_dead, <sfx_hit, <sfx_up, <sfx_down, <sfx_lift, <sfx_plane, <sfx_door, <sfx_bonus

wavetable_h:
.byte >sfx_fire, >sfx_dead, >sfx_hit, >sfx_up, >sfx_down, >sfx_lift, >sfx_plane, >sfx_door, >sfx_bonus



