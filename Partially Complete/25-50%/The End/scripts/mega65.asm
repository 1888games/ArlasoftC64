#import "common/macros.asm"

BASICStub65(Entry,"Mega65")

* = $2100 "Main"
Entry:
        sei 
        lda #$35
        sta $01 
        lda #$7f
        sta $dc0d
        sta $dd0d
        cli 


        Loop:

                jmp Loop

       // enable40Hz()
       // enableVIC4Registers()
       // mapMemory($ffd2000, $c000)

       // lda #$01
       // sta $d020
       // jmp *