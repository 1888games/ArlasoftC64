//Standard imports
#import "./syslabels.asm"

//Potential screen buffer locations
.label SCREEN_BUFFER_0 = $0400
.label SCREEN_BUFFER_1 = $6000
.label SCREEN_BUFFER_2 = $4c00

//Start of disassembled code
* = $0801 "Base Address"

    L_0801:
        asl 
        php 

        .byte $00,$00,$9e,$32,$30,$36,$34,$00,$00,$00,$00,$ff,$ff

    L_0810:
        jsr L_29f9
        jsr L_0865
        jsr L_0893
        jsr $2712
        jsr L_0856
    L_081f:
        lda #$00
        sta $5f
        sta $60
        lda #$00
        sta L_0e2f + $2
        sta L_0e2f + $7
        lda #$fc
        sta L_0e2f + $10
        lda #$fc
        sta L_0e2f + $11
        lda #$fd
        sta L_0e2f + $12
        lda L_0854
    L_083f:
        ora #$fc
        sta L_0e2f + $13
        lda #$7f
        ldx #$07
    L_0848:
        sta L_0e2f,x
        sta L_0e2f + $8,x
        dex 
        bpl L_0848
        jmp $7cf3

    L_0854:
         .byte $00,$00

    L_0856:
        ldx #$00
        txa 
    L_0859:
        sta $02,x
        sta $0200,x
        sta $0300,x
        inx 
        bne L_0859
        rts 


    L_0865:
        lda #$e5
        sta $02
        lda #$39
        sta $03
        lda #$00
        sta $04
        lda #$68
        sta $05
    L_0875:
        ldy #$00
    L_0877:
        lda ($02),y
        sta ($04),y
        iny 
        bne L_0877
        inc $03
        inc $05
        lda $05
        cmp #$80
        bne L_0875
        rts 


        jsr L_121c
        jsr L_1779
        jsr L_1802
        rts 


    L_0893:
        lda #$fc
        sta $6dd0
        sta $6f47
        sta $7252
        sta $729d
        sta $72ba
        sta $72ff
        sta $73e2
        sta $73ea
        sta $7c35
        sta $7800
        lda #$36
        sta $680d
        lda #$0e
        sta $680e
        lda #$31
        sta $6816
        lda #$0e
        sta $6817
        lda #$33
        sta $6cdc
        lda #$0e
        sta $6cdd
        lda #$32
        sta $6dfa
        lda #$0e
        sta $6dfb
        lda #$32
        sta $6e83
        lda #$0e
        sta $6e84
        lda #$35
        sta $7ab4
        lda #$0e
        sta $7ab5
        lda #$36
        sta $7d09
        lda #$0e
        sta $7d0a
        lda #$30
        sta $7ded
        lda #$0e
        sta $7dee
        lda #$30
        sta $7df2
        lda #$0e
        sta $7df3
        lda #$30
        sta $7e05
        lda #$0e
        sta $7e06
        lda #$30
        sta $7e0a
        lda #$0e
        sta $7e0b
        lda #$36
        sta $7e1e
        lda #$0e
        sta $7e1f
        lda #$30
        sta $7e76
        lda #$0e
        sta $7e77
        lda #$30
        sta $7e7b
        lda #$0e
        sta $7e7c
        lda #$31
        sta $7e83
        lda #$0e
        sta $7e84
        lda #$34
        sta $7e93
        lda #$0e
        sta $7e94
        lda #$32
        sta $7e9a
        lda #$0e
        sta $7e9b
        lda #$32
        sta $7fa2
        lda #$0e
        sta $7fa3
        lda #$32
        sta $7fbe
        lda #$0e
        sta $7fbf
        lda #$33
        sta $7fc2
        lda #$0e
        sta $7fc3
        lda #$36
        sta $7fee
        lda #$0e
        sta $7fef
        lda #$3a
        sta $68b7
        lda #$0e
        sta $68b8
        lda #$3b
        sta $68c0
        lda #$0e
        sta $68c1
        lda #$3e
        sta $6e41
        lda #$0e
        sta $6e42
        lda #$3d
        sta $6e4a
        lda #$0e
        sta $6e4b
        lda #$3e
        sta $7087
        lda #$0e
        sta $7088
        lda #$3d
        sta $7090
        lda #$0e
        sta $7091
        lda #$3c
        sta $70a1
        lda #$0e
        sta $70a2
        lda #$3c
        sta $753c
        lda #$0e
        sta $753d
        lda #$37
        sta $7a96
        lda #$0e
        sta $7a97
        lda #$37
        sta $7fac
        lda #$0e
        sta $7fad
        lda #$3e
        sta $7fc6
        lda #$0e
        sta $7fc7
        lda #$3d
        sta $7fca
        lda #$0e
        sta $7fcb
        lda #$3c
        sta $7fce
        lda #$0e
        sta $7fcf
        lda #$41
        sta $6ee0
        lda #$0e
        sta $6ee1
        lda #$42
        sta $77f7
        lda #$0e
        sta $77f8
        lda #$3f
        sta $7d27
        lda #$0e
        sta $7d28
        lda #$40
        sta $7d2c
        lda #$0e
        sta $7d2d
        lda #$41
        sta $7d37
        lda #$0e
        sta $7d38
        lda #$3f
        sta $7f08
        lda #$0e
        sta $7f09
        lda #$3f
        sta $7f14
        lda #$0e
        sta $7f15
        lda #$41
        sta $7f2e
        lda #$0e
        sta $7f2f
        lda #$40
        sta $7f39
        lda #$0e
        sta $7f3a
        lda #$4c
        sta $6f03
        lda #$0e
        sta $6f04
        lda #$4d
        sta $6f06
        lda #$0e
        sta $6f07
        lda #$4f
        sta $6f09
        lda #$0e
        sta $6f0a
        lda #$50
        sta $6f0c
        lda #$0e
        sta $6f0d
        lda #$51
        sta $6f0f
        lda #$0e
        sta $6f10
        lda #$4f
        sta $70a8
        lda #$0e
        sta $70a9
        lda #$4f
        sta $70e4
        lda #$0e
        sta $70e5
        lda #$4e
        sta $7567
        lda #$0e
        sta $7568
        lda #$4c
        sta $756c
        lda #$0e
        sta $756d
        lda #$4d
        sta $7574
        lda #$0e
        sta $7575
        lda #$50
        sta $757b
        lda #$0e
        sta $757c
        lda #$4f
        sta $7586
        lda #$0e
        sta $7587
        lda #$51
        sta $7bb8
        lda #$0e
        sta $7bb9
        lda #$51
        sta $7fe1
        lda #$0e
        sta $7fe2
        lda #$47
        sta $6823
        lda #$0e
        sta $6824
        lda #$47
        sta $7fe7
        lda #$0e
        sta $7fe8
        lda #$48
        sta $68cb
        lda #$0e
        sta $68cc
        lda #$48
        sta $68eb
        lda #$0e
        sta $68ec
        lda #$48
        sta $69c7
        lda #$0e
        sta $69c8
        lda #$48
        sta $73c1
        lda #$0e
        sta $73c2
        lda #$48
        sta $7b9f
        lda #$0e
        sta $7ba0
        lda #$48
        sta $7d24
        lda #$0e
        sta $7d25
        lda #$48
        sta $7e59
        lda #$0e
        sta $7e5a
        lda #$48
        sta $7fbb
        lda #$0e
        sta $7fbc
        lda #$48
        sta $7fe4
        lda #$0e
        sta $7fe5
        lda #$49
        sta $6826
        lda #$0e
        sta $6827
        lda #$49
        sta $7d6c
        lda #$0e
        sta $7d6d
        lda #$49
        sta $7d85
        lda #$0e
        sta $7d86
        lda #$49
        sta $7da5
        lda #$0e
    L_0b80:
        sta $7da6
        lda #$49
        sta $7df8
        lda #$0e
        sta $7df9
        lda #$49
        sta $7e10
        lda #$0e
        sta $7e11
        lda #$49
        sta $7e1b
        lda #$0e
        sta $7e1c
        lda #$49
        sta $7e43
        lda #$0e
        sta $7e44
        lda #$49
        sta $7e88
        lda #$0e
        sta $7e89
        lda #$4a
        sta $6efd
        lda #$0e
        sta $6efe
        lda #$4a
        sta $75ca
        lda #$0e
        sta $75cb
        lda #$4b
        sta $6f00
        lda #$0e
        sta $6f01
        lda #$4b
        sta $75a5
        lda #$0e
        sta $75a6
        lda #$4b
        sta $75bd
        lda #$0e
        sta $75be
        lda #$4b
        sta $7de6
        lda #$0e
        sta $7de7
        lda #$4b
        sta $7e00
        lda #$0e
        sta $7e01
        lda #$64
        sta $681c
        sta $6821
        sta $682f
        sta $7d10
        sta $7d15
    L_0c0c:
        sta $7d1a
    L_0c0f:
        lda #$64
        sta $6835
        lda #$7e
        sta $7887
        lda #$11
        sta $7888
        lda #$a0
        sta $6f36
        lda #$11
        sta $6f37
        lda #$9f
        sta $6f39
        lda #$10
        sta $6f3a
        lda #$9f
        sta $7798
        lda #$10
        sta $7799
        lda #$a0
        sta $779e
        lda #$11
        sta $779f
        lda #$9d
        sta $7863
        lda #$10
        sta $7864
        lda #$9e
        sta $7869
        lda #$11
        sta $786a
        lda #$9f
        sta $7bdc
        lda #$10
        sta $7bdd
        lda #$a0
        sta $7be1
        lda #$11
        sta $7be2
        lda #$e9
        sta $734e
        lda #$10
        sta $734f
        lda #$ea
        sta $7351
        lda #$11
        sta $7352
        lda #$f1
        sta $736b
        lda #$10
        sta $736c
        lda #$f2
        sta $736e
        lda #$11
        sta $736f
        lda #$f9
        sta $737d
        lda #$10
        sta $737e
        lda #$fa
        sta $7380
        lda #$11
        sta $7381
        lda #$07
        sta $746f
        lda #$11
        sta $7470
        lda #$08
        sta $747d
        lda #$12
        sta $747e
        lda #$07
        sta $749e
        lda #$11
        sta $749f
        lda #$08
        sta $74b4
        lda #$12
        sta $74b5
        lda #$fb
        sta $74d5
        lda #$10
        sta $74d6
        lda #$fc
        sta $74d8
        lda #$11
        sta $74d9
        lda #$fb
        sta $74e6
        lda #$10
        sta $74e7
        lda #$fc
        sta $74e0
        lda #$11
        sta $74e1
        lda #$13
        sta $7533
        lda #$11
        sta $7534
        lda #$14
        sta $7536
        lda #$12
        sta $7537
        lda #$37
        sta $77e9
        lda #$11
        sta $77ea
        lda #$ea
        sta $7c41
        sta $7c42
        lda #$60
        sta $6ad7
        lda #$ea
        sta $6813
        sta $6814
        sta $6818
        sta $6819
        sta $680f
        sta $6810
        sta $7d0b
        sta $7d0c
        sta $7def
        sta $7df0
        sta $7df4
        sta $7df5
        sta $7e07
        sta $7e08
        sta $7e0c
        sta $7e0d
        sta $6813
        sta $6814
        sta $7e20
        sta $7e21
        lda #$20
        sta $680c
        lda #$89
        sta $680d
        lda #$08
        sta $680e
        lda #$ea
        sta $680f
        sta $6810
        lda #$20
        sta $7c03
        lda #$56
        sta $7c04
        lda #$0e
        sta $7c05
        lda #$ea
        sta $7c06
        lda #$20
        sta $7862
        lda #$81
        sta $7863
        lda #$0e
        sta $7864
        lda #$20
        sta $7bdb
        lda #$9b
        sta $7bdc
        lda #$0f
        sta $7bdd
        lda #$20
        sta $7797
        lda #$b1
        sta $7798
        lda #$0f
        sta $7799
        lda #$20
        sta $6f4f
        lda #$c7
        sta $6f50
        lda #$0f
        sta $6f51
        lda #$20
        sta $6f35
        lda #$e0
        sta $6f36
        lda #$0f
        sta $6f37
        lda #$20
        sta $7d08
        lda #$fa
        sta $7d09
        lda #$0f
        sta $7d0a
        lda #$20
        sta $68ca
        sta $68ea
        sta $69c6
        sta $73c0
        sta $7b9e
        sta $7d23
        lda #$4e
        sta $68cb
        sta $68eb
        sta $69c7
        sta $73c1
        sta $7b9f
        sta $7d24
        lda #$10
        sta $68cc
        sta $68ec
        sta $69c8
        sta $73c2
        sta $7ba0
        sta $7d25
        lda #$82
        sta $74d0
        lda #$10
        sta $74d1
        rts 



    L_0e2f:
         .fill $27, $0
        .byte $48,$ac,$9a,$0e,$a9,$ff,$99,$9b,$0e,$68,$48,$c8,$99,$9b,$0e,$8a
        .byte $38,$e9,$24,$8d,$80,$0e,$18,$a9,$bf,$ed,$80,$0e,$c8,$99,$9b,$0e
        .byte $c8,$8c,$9a,$0e,$68,$a0,$00,$84,$05,$60

    L_0e80:
        .byte $00
        .byte $8c,$99,$0e,$ac,$9a,$0e,$4a,$38,$e9,$01,$99,$9b,$0e,$c8,$8c,$9a
        .byte $0e,$ac,$99,$0e,$bd,$9d,$10,$60

    L_0e99:
        .fill $102, $0
        .byte $8c,$b0,$0f,$ac,$9a,$0e,$4a,$99,$9b,$0e,$c8,$8c,$9a,$0e,$ac,$b0
        .byte $0f,$bd,$9f,$10,$60

    L_0fb0:
        .byte $00
        .byte $8c,$c6,$0f,$ac,$9a,$0e,$4a,$99,$9b,$0e,$c8,$8c,$9a,$0e,$ac,$c6
        .byte $0f,$b9,$9f,$10,$60

    L_0fc6:
        .byte $00
        .byte $48,$8c,$de,$0f,$ac,$9a,$0e,$a9,$2b,$99,$9b,$0e,$c8,$8c,$9a,$0e
        .byte $ac,$de,$0f,$68,$4c,$fc,$7b

    L_0fde:
        .byte $00,$00
        .byte $8c,$f8,$0f,$ac,$9a,$0e,$ad,$f8,$0f,$4a,$99,$9b,$0e,$c8,$8c,$9a
        .byte $0e,$ac,$f8,$0f,$be,$a0,$10,$60

    L_0ff8:
        .byte $00,$00
        .byte $8d,$18,$10,$8c,$17,$10,$a0,$00

    L_1002:
        lda L_1017 + $2,y
        sta.a $001d,y
    L_1008:
        iny 
        cpy #$35
        bne L_1002
        jsr L_27d9
        ldy L_1017
        lda L_1017 + $1
        rts 



    L_1017:
         .byte $00,$00,$13
        .byte $20,$05,$20,$93,$19,$87,$19,$84,$19,$79,$19,$70,$19,$66,$19,$19
        .byte $00,$07,$00,$18,$19,$1c,$18,$00,$15,$19

    L_1034:
        .byte $00,$0f,$1c,$00,$12,$0c,$00,$1c,$0f,$00,$0f,$1c,$00,$1c
        .byte $1e,$00,$00,$00,$00,$00,$0c,$0b,$1f,$1c,$1e,$00,$8d,$81,$10,$8e
        .byte $7f,$10,$8c,$80,$10,$ad,$81,$10,$cd,$7e,$10,$f0,$1e,$8d,$7e,$10
        .byte $a2,$00

    L_1064:
        ldy $0200,x
        lda $0300,x
        sta $0200,x
        tya 
        sta $0300,x
        dex 
        bne L_1064
        lda L_107e + $3
        ldx L_107e + $1
        ldy L_107e + $2
    L_107d:
        rts 



    L_107e:
         .byte $00,$00,$00,$00
        .byte $a6,$09,$a5,$04,$9d,$91,$10,$a5,$06,$9d,$92,$10,$4c,$49,$7c

    L_1091:
        .byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$d0,$2c,$cb
        .byte $dd,$ca,$2e,$cb,$32,$cb,$3a,$cb,$41,$cb,$48,$cb,$4f,$cb,$56,$cb
        .byte $5b,$cb,$63,$cb,$78,$ca,$80,$ca,$8d,$ca,$93,$ca,$9b,$ca,$a3,$ca
        .byte $aa,$ca,$b3,$ca,$ba,$ca,$c1,$ca,$c7,$ca,$cd,$ca,$d2,$ca,$d8,$ca
        .byte $dd,$ca,$e3,$ca,$ea,$ca,$f3,$ca,$fb,$ca,$02,$cb,$08,$cb,$0e,$cb
        .byte $13,$cb,$1a,$cb,$1f,$cb,$26,$cb,$d0,$c8,$b5,$c8,$96,$c8,$80,$c8
        .byte $f3,$c8,$ff,$c8,$0d,$c9,$1a,$c9,$29,$c9,$c6,$ff,$c1,$fe,$c3,$f1
        .byte $cd,$f1,$c7,$f1,$c1,$fd,$d8,$1e,$32,$ec,$00,$c4,$3c,$14,$0a,$46
        .byte $d8,$d8,$90,$52,$a8,$52,$cc,$52,$f0,$52,$14,$53,$36,$53,$5a,$53
        .byte $7e,$53,$a2,$53,$c6,$53,$ea,$53,$0e,$54,$32,$54,$56,$54,$7a,$54
        .byte $9e,$54,$c2,$54,$0f,$f6,$00,$03,$06,$09,$0c,$10,$13,$16,$19,$1c
        .byte $1f,$22,$25,$28,$2b,$2e,$31,$33,$36,$39,$3c,$3f,$41,$44,$47,$49
        .byte $4c,$4e,$51,$53,$55,$58,$5a,$5c,$5e,$60,$62,$64,$66,$68,$6a,$6b
        .byte $6d,$6f,$70,$71,$73,$74

    L_1167:
        adc $76,x
        sei 
        adc $7a7a,y

        .byte $7b,$7c,$7d,$7d,$7e,$7e,$7e,$7f,$7f,$7f,$7f,$00,$00,$00,$00,$00
        .byte $00,$0b,$13,$19,$2f,$41,$55,$6f,$77,$7d,$87,$91,$63,$56,$60,$6e
        .byte $3c,$ec,$4d,$c0,$a4,$0a,$ea,$6c,$08,$00,$ec,$f2,$b0,$6e,$3c,$ec
        .byte $48,$5a,$b8,$66,$92,$42,$9a,$82,$c3,$12,$0e,$12,$90,$4c,$4d,$f1
        .byte $a4,$12,$2d,$d2,$0a,$64,$c2,$6c,$0f,$66,$cd,$82,$6c,$9a,$c3,$4a
        .byte $85,$c0,$a6,$6e,$60,$6c,$9e,$0a,$c2,$42,$c4,$c2,$ba,$60,$49,$f0
        .byte $0c,$12,$c6,$12,$b0,$00

    L_11d3:
        ldx $6e
        rts 



        .byte $58,$ed,$12,$b5,$e8,$29,$d2,$0e,$d8,$4c,$82,$82,$70,$c2,$6c,$0b
        .byte $6e,$09,$e6,$b5,$92,$3e,$00,$a6,$6e,$60,$6e,$c1,$6c,$c0,$00,$59
        .byte $62,$48,$66,$d2,$6d,$18,$4e,$9b,$64,$09,$02,$a4,$0a,$ed,$c0,$18
        .byte $4e,$9b,$64,$08

    L_120a:
        .byte $c2
        .byte $a4,$0a,$e8,$00,$20,$4e,$9b,$64,$b8,$46,$0d,$20,$2f,$40

    L_1219:
        .byte $00,$04,$04

    L_121c:
        ldx L_1219 + $1
        lda $02f6
        cmp #$0c
        bcc L_1227
        inx 
    L_1227:
        stx L_1219 + $2
        inc L_1219
        lda L_1219
        cmp L_1219 + $2
        bcs L_123b
        lda #$00
        sta L_0e99 + $1
        rts 


    L_123b:
        lda #$00
        sta L_1219
        jsr L_2885
        jsr L_2184
    L_1246:
        lda #$2f
        sta $00
        lda $01
        and #$f8
        ora #$05
        sta $01
        lda L_2883
        ora #$1d
        sta $1269
        lda #$43
        sta $1268
        ldx #$27
    L_1261:
        ldy L_1619 + $3,x
        lda L_15f4,x
        sta $6619,y
        dex 
        bpl L_1261
        lda $32
        and $33
        bmi L_1276
        jmp L_14f8
    L_1276:
        lda $1c
        bne L_1289
        lda $5d
        and #$04
        bne L_1289
        lda $1d
        ora $1e
        beq L_1289
        jmp L_14f8
    L_1289:
        ldy #$00
        ldx #$1a
    L_128d:
        lda $0200,x
        beq L_12f5
        pha 
        stx L_15c7 + $4
        lda $02d2,x
        sta L_15c7 + $2
        lda $028c,x
        asl L_15c7 + $2
        rol 
        asl L_15c7 + $2
        rol 
        asl L_15c7 + $2
        rol 
        sta L_15c7 + $3
        sec 
        lda #$bf
        sbc L_15c7 + $3
        cmp #$b8
        bcc L_12bc
        pla 
        jmp L_12f2
    L_12bc:
        tay 
        lda $02af,x
        sta L_15c7 + $2
        lda $0269,x
        asl L_15c7 + $2
        rol 
        asl L_15c7 + $2
        rol 
        asl L_15c7 + $2
        rol 
        tax 
        stx L_15c7 + $7
        pla 
        bpl L_12e6
        lsr 
        lsr 
        lsr 
        lsr 
        lsr 
        and #$03
        clc 
        adc #$0e
        jmp L_12ef
    L_12e6:
        and #$1f
        tax 
        lda L_15c7 + $9,x
        ldx L_15c7 + $7
    L_12ef:
        jsr L_1a2a
    L_12f2:
        ldx L_15c7 + $4
    L_12f5:
        dex 
        bmi L_12fb
        jmp L_128d
    L_12fb:
        lda $021b
        bne L_1303
        jmp L_143f
    L_1303:
        cmp #$01
        bne L_130a
        jmp L_13c6
    L_130a:
        lda $02ed
        sta L_15c7 + $2
        lda $02a7
        asl L_15c7 + $2
        rol 
        asl L_15c7 + $2
        rol 
        asl L_15c7 + $2
        rol 
        sta L_15c7 + $3
        sec 
        lda #$c7
        sbc L_15c7 + $3
        tay 
        lda $02ca
        sta L_15c7 + $2
        lda $0284
        asl L_15c7 + $2
        rol 
        asl L_15c7 + $2
        rol 
        asl L_15c7 + $2
        rol 
        clc 
        adc #$08
        tax 
        lda $021b
        eor #$ff
        and #$70
        lsr 
        lsr 
        lsr 
        sta L_1642 + $3
        stx L_15c7 + $2
        sty L_15c7 + $3
    L_1355:
        ldx L_1642 + $3
        txa 
        asl 
        asl 
        pha 
        clc 
        adc #$80
        sta $13a6
        lda #$31
        adc #$00
        sta $13a7
        pla 
        clc 
        adc #$b0
        sta $139e
        lda #$31
        adc #$00
        sta $139f
        lda L_1091,x
        cmp #$80
        ror 
        cmp #$80
        ror 
        clc 
        adc L_15c7 + $2
        sta L_1642 + $4
        lda L_1091 + $1,x
        cmp #$80
        ror 
        cmp #$80
        ror 
        clc 
        adc L_15c7 + $3
        sta L_1642 + $5
        ldx #$07
    L_1399:
        stx L_1642 + $6
        clc 
        lda $1907,x
        adc L_1642 + $5
        tay 
        clc 
        lda L_1966,x
        adc L_1642 + $4
        tax 
        lda #$07
        cpy #$c8
        bcs L_13b5
        jsr L_22fb
    L_13b5:
        ldx L_1642 + $6
        dex 
        bpl L_1399
        dec L_1642 + $3
        dec L_1642 + $3
        bpl L_1355
        jmp L_143f
    L_13c6:
        lda $02ed
        sta L_15c7 + $2
        lda $02a7
        asl L_15c7 + $2
        rol 
        asl L_15c7 + $2
        rol 
        asl L_15c7 + $2
        rol 
        sta L_15c7 + $3
        sec 
        lda #$bf
        sbc L_15c7 + $3
        clc 
        adc #$05
        sta L_15c7 + $6
        cmp #$c0
        bcc L_13f1
        jmp L_143f
    L_13f1:
        tay 
        lda $02ca
        sta L_15c7 + $2
        lda $0284
        asl L_15c7 + $2
        rol 
        asl L_15c7 + $2
        rol 
        asl L_15c7 + $2
        rol 
        clc 
        adc #$05
        sta L_15c7 + $5
        ldx $61
        lda L_1649,x
        ldx L_15c7 + $5
        jsr $234f
        lda L_0e2f + $d
        bpl L_143f
        lda $5c
        and #$04
        beq L_143f
        ldx $61
        lda L_1649,x
        sec 
        sbc #$25
        tax 
        lda L_1760 + $1,x
        clc 
        adc L_15c7 + $6
        tay 
        lda $1749,x
        clc 
        adc L_15c7 + $5
        tax 
        jsr L_22fb
    L_143f:
        lda $021c
        beq L_149d
        pha 
        lda $02ee
        sta L_15c7 + $2
        lda $02a8
        asl L_15c7 + $2
        rol 
        asl L_15c7 + $2
        rol 
        asl L_15c7 + $2
        rol 
        sta L_15c7 + $3
        sec 
        lda #$bf
        sbc L_15c7 + $3
        tay 
        lda $02cb
        sta L_15c7 + $2
        lda $0285
        asl L_15c7 + $2
        rol 
        asl L_15c7 + $2
        rol 
        asl L_15c7 + $2
        rol 
        tax 
        stx L_15c7 + $7
        pla 
        bpl L_148d
        lsr 
        lsr 
        lsr 
        lsr 
        lsr 
        and #$03
        clc 
        adc #$0e
        jmp L_1496
    L_148d:
        and #$03
        tax 
        lda L_15f0,x
        ldx L_15c7 + $7
    L_1496:
        cpy #$b8
        bcs L_149d
        jsr L_1a2a
    L_149d:
        ldy #$00
        ldx #$05
    L_14a1:
        lda $021d,x
        beq L_14f2
        stx L_15c7 + $7
        lda $02ef,x
        sta L_15c7 + $2
        lda $02a9,x
        asl L_15c7 + $2
        rol 
        asl L_15c7 + $2
        rol 
        asl L_15c7 + $2
        rol 
        sta L_15c7 + $3
        sec 
        lda #$c7
        sbc L_15c7 + $3
        cmp #$c8
        bcc L_14cf
        pla 
        jmp L_14ef
    L_14cf:
        tay 
        lda $02cc,x
        sta L_15c7 + $2
        lda $0286,x
        asl L_15c7 + $2
        rol 
        asl L_15c7 + $2
        rol 
        asl L_15c7 + $2
        rol 
        clc 
        adc #$08
        tax 
        lda L_15c7 + $7
        jsr L_22fb
    L_14ef:
        ldx L_15c7 + $7
    L_14f2:
        dex 
        bmi L_14f8
        jmp L_14a1
    L_14f8:
        ldy #$00
    L_14fa:
        cpy L_0e99 + $1
        beq L_153f
        sty L_15c7 + $8
        lda L_0e99 + $2,y
        cmp #$ff
        beq L_152d
        ldx L_0e2f + $25
        ldy L_0e2f + $26
        cpy #$0d
        bne L_1516
        iny 
        iny 
        iny 
    L_1516:
        cpy #$c0
        bcs L_151d
        jsr $234f
    L_151d:
        clc 
        lda L_0e2f + $25
        adc #$06
        sta L_0e2f + $25
        ldy L_15c7 + $8
        iny 
        jmp L_14fa
    L_152d:
        iny 
        lda L_0e99 + $2,y
        sta L_0e2f + $25
        iny 
        lda L_0e99 + $2,y
        sta L_0e2f + $26
        iny 
        jmp L_14fa
    L_153f:
        lda #$00
        sta L_0e99 + $1
        lda $1c
        bne L_1570
        lda $5d
        and #$04
        bne L_1570
        lda $32
        and $33
        bpl L_1570
        ldy #$41
        sty L_1642 + $2
    L_1559:
        ldx #$6c
        ldy L_1642 + $2
        lda #$07
        jsr L_22fb
        clc 
        lda L_1642 + $2
        adc #$08
        sta L_1642 + $2
        cmp #$91
        bne L_1559
    L_1570:
        lda $32
        and $33
        bmi L_15c6
        lda $31
        bne L_159f
        ldx #$6a
        ldy #$af
        jsr L_22fb
        ldx #$6b
        ldy #$af
        jsr L_22fb
        ldx #$6c
        ldy #$af
        jsr L_22fb
        ldx #$6d
        ldy #$af
        jsr L_22fb
        ldx #$6e
        ldy #$af
        jsr L_22fb
        lda #$01
    L_159f:
        cmp #$01
        bne L_15c6
        ldx #$70
        ldy #$af
        jsr L_22fb
        ldx #$71
        ldy #$af
        jsr L_22fb
        ldx #$72
        ldy #$af
        jsr L_22fb
        ldx #$73
        ldy #$af
        jsr L_22fb
        ldx #$74
    L_15c1:
        ldy #$af
        jsr L_22fb
    L_15c6:
        rts 



    L_15c7:
         .byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$02
        .byte $01,$01,$00,$00,$00,$00,$03,$05,$04,$04,$03,$03,$03,$03,$06,$08
        .byte $07,$07,$06,$06,$06,$06,$09,$0b,$0a,$0a,$09,$09,$09,$09

    L_15f0:
        .byte $0c
        .byte $0d,$0c,$0c

    L_15f4:
        .byte $04
        .byte $ee,$e0,$4e,$4e,$e0,$e9,$70,$c4,$a2,$a0,$a4,$aa,$40,$4d,$40,$84
        .byte $e2,$e0,$e4,$ee,$40,$4b,$40,$c4,$22,$20,$a4,$ac,$40,$49,$40,$04
        .byte $22,$20,$a4,$aa

    L_1619:
        .byte $e0,$e9,$70,$00,$08,$10,$18
        .byte $20,$28,$30,$38,$01,$09,$11,$19,$21,$29,$31,$39,$02,$0a,$12,$1a
        .byte $22,$2a,$32,$3a,$03,$0b,$13,$1b,$23,$2b,$33,$3b,$04,$0c,$14,$1c
        .byte $24,$2c

    L_1642:
        .byte $34,$3c,$00,$00,$00,$00,$00

    L_1649:
        and $25
        and $25
        and $26
        rol $26
        rol $26
        rol $26
        rol $26
        rol $26

        .byte $27,$27,$27,$27,$27,$27,$27,$27,$27,$27,$27,$28,$28,$28,$28,$28
        .byte $28,$28,$28,$28,$28,$29,$29,$29,$29,$29,$29,$29,$29,$29,$29,$29
        .byte $2a,$2a,$2a,$2a,$2a,$2a,$2a,$2a,$2a,$2a,$2a,$2b,$2b,$2b,$2b,$2b
        .byte $2b,$2b,$2b,$2b,$2b,$2c,$2c,$2c,$2c,$2c,$2c,$2c,$2c,$2c,$2c,$2c
        .byte $2d,$2d,$2d,$2d,$2d,$2d,$2d,$2d,$2d,$2d,$2d,$2e,$2e,$2e,$2e,$2e
        .byte $2e,$2e,$2e,$2e,$2e,$2f,$2f,$2f,$2f,$2f,$2f,$2f,$2f,$2f,$2f,$2f
        .byte $30,$30,$30,$30,$30,$30,$30,$30,$30,$30,$30,$31,$31,$31,$31,$31
        .byte $31,$31,$31,$31,$31,$32,$32,$32,$32,$32,$32,$32,$32,$32,$32,$32
        .byte $33,$33,$33,$33,$33,$33,$33,$33,$33,$33,$33,$34,$34,$34,$34,$34
        .byte $34,$34,$34,$34,$34,$35,$35,$35,$35,$35,$35,$35,$35

    L_16f6:
        and $35,x
        and $36,x
        rol $36,x
        rol $36,x
        rol $36,x
        rol $36,x
        rol $36,x

        .byte $37,$37,$37,$37,$37,$37,$37,$37,$37,$37,$38,$38,$38,$38,$38,$38
        .byte $38,$38,$38,$38,$38,$39,$39,$39,$39,$39,$39,$39,$39,$39,$39,$39
        .byte $3a,$3a,$3a,$3a,$3a,$3a,$3a,$3a,$3a,$3a,$3b,$3b,$3b,$3b,$3b,$3b
        .byte $3b,$3b,$3b,$3b,$3b,$3c,$3c,$3c,$3c,$3c,$3c,$3c,$3c,$3c,$3c,$3c
        .byte $25,$25,$25,$25,$25,$00,$00,$01,$01,$02,$03,$03,$03,$04,$05,$05
        .byte $06,$06,$06,$05,$05,$04,$03,$03,$03,$02,$01,$01

    L_1760:
        .byte $00,$03,$03,$04
        .byte $05,$05,$06,$06,$06,$05,$05,$04,$03,$03,$02,$01,$01,$01,$00,$00
        .byte $00,$01,$01,$02,$03

    L_1779:
        lda #$2f
        sta $00
        lda $01
        and #$f8
        ora #$05
        sta $01
        lda cCia1PortB
        sta L_17ff
        lda cCia1PortA
        sta L_17ff + $1
        lda #$00
        sta L_0e2f + $b
        sta L_0e2f + $c
        sta L_0e2f + $4
        sta L_0e2f + $f
        sta L_0e2f + $e
        sta L_0e2f + $d
        sta L_0e2f + $3
        ldy #$80
        lda L_17ff
        and #$10
        bne L_17bd
        sty L_0e2f + $4
        lda $32
        and $33
        bpl L_17bd
        sty L_0e2f + $b
    L_17bd:
        lda L_17ff + $1
        and #$10
        bne L_17d0
        sty L_0e2f + $4
        lda $32
        and $33
        bpl L_17d0
        sty L_0e2f + $c
    L_17d0:
        lda L_17ff
        and L_17ff + $1
        sta L_17ff + $2
        and #$08
        bne L_17e0
        sty L_0e2f + $e
    L_17e0:
        lda L_17ff + $2
        and #$04
        bne L_17ea
        sty L_0e2f + $f
    L_17ea:
        lda L_17ff + $2
        and #$02
        bne L_17f4
        sty L_0e2f + $3
    L_17f4:
        lda L_17ff + $2
        and #$01
        bne L_17fe
        sty L_0e2f + $d
    L_17fe:
        rts 



    L_17ff:
         .byte $00,$00,$00

    L_1802:
        lda L_0e2f + $1d
        cmp L_19a2 + $2
        beq L_1879
        sta L_19a2 + $2
        and #$80
        bne L_1825
        lda #$00
        sta L_19a2 + $a
        lda L_0e2f + $1c
        and #$10
        bne L_1879
        lda #$00
        sta sVoc1Control
        jmp L_18b4
    L_1825:
        lda #$01
        sta L_19a2 + $a
        lda L_0e2f + $1f
        and #$80
        bne L_1855
        lda #$00
        sta sVoc1FreqLo
        lda #$80
        sta sVoc1FreqHi
        lda #$41
        sta sVoc1Control
        lda #$80
        sta L_19a2 + $5
        sta L_19a2 + $7
        lda #$fc
        sta L_19a2 + $6
        lda #$60
        sta L_19a2 + $8
        jmp L_18b4
    L_1855:
        lda #$00
        sta sVoc1FreqLo
        lda #$60
        sta sVoc1FreqHi
        lda #$41
        sta sVoc1Control
        lda #$60
        sta L_19a2 + $5
        sta L_19a2 + $7
        lda #$fc
        sta L_19a2 + $6
        lda #$40
        sta L_19a2 + $8
        jmp L_18b4
    L_1879:
        lda L_19a2 + $a
        bne L_18b4
        lda L_0e2f + $1c
        tax 
        and #$10
        bne L_188e
        lda #$40
        sta sVoc1Control
        jmp L_18b4
    L_188e:
        txa 
        and #$04
        bne L_18a5
        lda #$00
        sta sVoc1FreqLo
        lda #$04
        sta sVoc1FreqHi
        lda #$41
        sta sVoc1Control
        jmp L_18b4
    L_18a5:
        lda #$80
        sta sVoc1FreqLo
        lda #$04
        sta sVoc1FreqHi
        lda #$41
        sta sVoc1Control
    L_18b4:
        lda L_0e2f + $1e
        cmp L_19a2 + $1
        beq L_18e7
        lda L_0e2f + $1e
        sta L_19a2 + $1
        and #$80
        bne L_18d3
        lda L_0e2f + $21
        bne L_18e7
        lda #$20
        sta sVoc2Control
        jmp L_18e7
    L_18d3:
        lda #$00
        sta sVoc2FreqLo
        lda #$40
        sta sVoc2FreqHi
        lda #$21
        sta sVoc2Control
        lda #$40
        sta L_19a2 + $3
    L_18e7:
        lda L_0e2f + $21
        cmp L_19a2
        beq L_191a
        lda L_0e2f + $21
        sta L_19a2
        bne L_1906
        lda L_0e2f + $1e
        and #$80
        bne L_191a
        lda #$20
        sta sVoc2Control
        jmp L_191a
    L_1906:
        lda #$00
        sta sVoc2FreqLo
        lda #$30
        sta sVoc2FreqHi
        lda #$21
        sta sVoc2Control
        lda #$30
        sta L_19a2 + $3
    L_191a:
        lda L_0e2f + $1b
        cmp #$3d
        bne L_193d
        lda #$80
        sta sVoc3Control
        lda #$0c
        sta sVoc3AttDec
        lda #$00
        sta sVoc3FreqLo
        lda #$02
        sta sVoc3FreqHi
        lda #$81
        sta sVoc3Control
        jmp L_197a
    L_193d:
        cmp #$fd
        bne L_195d
        lda #$80
        sta sVoc3Control
        lda #$0c
        sta sVoc3AttDec
        lda #$00
        sta sVoc3FreqLo
        lda #$03
        sta sVoc3FreqHi
        lda #$81
        sta sVoc3Control
        jmp L_197a
    L_195d:
        cmp #$bd
        bne L_197a
        lda #$80
        sta sVoc3Control
    L_1966:
        lda #$0c
        sta sVoc3AttDec
        lda #$00
        sta sVoc3FreqLo
        lda #$04
        sta sVoc3FreqHi
        lda #$81
        sta sVoc3Control
    L_197a:
        rts 


        lda L_0e2f + $20
        and #$80
        bne L_1997
        lda L_0e2f + $1d
        and #$80
    L_1987:
        bne L_1990
        lda #$00
        sta $d207
        beq L_19a1
    L_1990:
        lda #$a8
        sta $d207
        bne L_19a1
    L_1997:
        lda #$88
        sta $d207
        lda #$40
        sta $d206
    L_19a1:
        rts 



    L_19a2:
         .byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00

    L_19ad:
        lda L_19a2 + $3
        beq L_19bd
        sec 
        sbc #$01
        sta L_19a2 + $3
        beq L_19bd
        sta sVoc2FreqHi
    L_19bd:
        lda L_19a2 + $a
        beq L_19db
        lda L_19a2 + $5
        sta sVoc1FreqHi
        clc 
        adc L_19a2 + $6
        sta L_19a2 + $5
        cmp L_19a2 + $7
        bcs L_19dc
        cmp L_19a2 + $8
        beq L_19e2
        bcc L_19e2
    L_19db:
        rts 


    L_19dc:
        lda #$fc
        sta L_19a2 + $6
        rts 


    L_19e2:
        lda #$04
        sta L_19a2 + $6
        rts 


    L_19e8:
        lda #$0f
        sta sFiltMode
        lda #$00
        sta sVoc1AttDec
        lda #$f1
        sta sVoc1SusRel
        lda #$00
        sta sVoc1PWidthLo
        lda #$08
        sta sVoc1PWidthHi
        lda #$0b
        sta sVoc2AttDec
        lda #$00
        sta sVoc2SusRel
        lda #$00
        sta sVoc2PWidthLo
        lda #$08
        sta sVoc2PWidthHi
        lda #$0c
        sta sVoc3AttDec
        lda #$00
        sta sVoc3SusRel
        lda #$00
        sta sVoc3PWidthLo
        lda #$08
        sta sVoc3PWidthHi
        rts 


    L_1a2a:
        pha 
        sta L_1ada + $3
        stx L_1ada + $2
        tax 
        lda L_1b5e,x
        sta $f5
        lda L_1b6f + $1,x
        sta L_1ada + $4
        pla 
        tax 
        lda L_1ada + $5,x
        sta L_1ada
        lda L_1afa + $d,x
        sta L_1ada + $1
        ldx L_1ada + $2
        clc 
        tya 
        adc L_1ada + $4
        tay 
        lda L_2512,y
        sta $f0
        lda L_2612,y
        sta $f1
        tya 
        and #$07
        sta $f4
        asl 
        adc $f4
        eor #$ff
        adc #$1a
        sta $f4
        lda L_2883
        cmp #$40
        beq L_1a7a
        clc 
        lda $f1
        adc #$a0
        sta $f1
    L_1a7a:
        ldy L_1b81 + $1
        lda L_1ada + $3
        ora #$80
        sta L_1b81 + $202,y
        txa 
        and #$f8
        clc 
        adc $f0
        sta $f0
        sta L_1b81 + $2,y
        bcc L_1a94
        inc $f1
    L_1a94:
        lda $f1
        sta L_1b81 + $102,y
        inc L_1b81 + $1
        txa 
        and #$07
        tax 
        clc 
        lda L_22e8 + $3,x
        adc L_1ada
        sta $1ace
        lda $22f3,x
        adc L_1ada + $1
        sta $1acf
        ldx #$00
    L_1ab5:
        dec $f4
        bne L_1aca
        lda #$18
        sta $f4
        inc $f1
        clc 
        lda $f0
        adc #$38
        sta $f0
        bcc L_1aca
        inc $f1
    L_1aca:
        ldy $1b2e,x
        lda $6619,x
        ora ($f0),y
        sta ($f0),y
        inx 
        cpx $f5
        bne L_1ab5
        rts 



    L_1ada:
         .byte $07,$42,$00,$00,$00,$00,$80,$00,$80,$00,$80,$00,$80,$00,$80,$00
        .byte $80,$00,$80,$00,$80,$00,$80,$00,$80,$00,$80,$00,$80,$00,$80,$00

    L_1afa:
        .byte $80,$00,$80,$00,$80,$00,$80,$00,$80,$00,$80,$00,$80,$00
        .byte $01,$03,$04,$06,$07,$09,$0a,$0c,$0d,$0f,$10,$12,$13,$15,$16,$18
        .byte $19,$1b,$1c,$1e,$1f,$21,$22,$24,$25,$27,$28,$2b,$2d,$2e,$30,$31
        .byte $33,$34,$36,$37,$39,$3a,$00,$08,$10,$01,$09,$11,$02,$0a,$12,$03
        .byte $0b,$13,$04,$0c,$14,$05,$0d,$15,$06,$0e,$16,$07,$0f,$17,$08,$10
        .byte $18,$09,$11,$19,$0a,$12,$1a,$0b,$13,$1b,$0c,$14,$1c,$0d,$15,$1d
        .byte $0e,$16,$1e,$0f,$17,$1f

    L_1b5e:
        bmi L_1b78

        .byte $0c

    L_1b61:
        bmi L_1b7b

        .byte $0c,$30,$18,$0c,$30,$18,$0c,$1b,$0c,$1e,$27,$2a

    L_1b6f:
        .byte $30,$00,$04
        .byte $06,$00,$04,$06,$00,$04

    L_1b78:
        asl $00

        .byte $04

    L_1b7b:
        asl $04
        asl $03
        ora ($01,x)

    L_1b81:
         .fill $603, $0

    L_2184:
        ldx L_1b81 + $1
        bne L_218a
        rts 


    L_218a:
        dex 
        stx L_1b81 + $1
        lda L_1b81 + $2,x
        sta $f0
        lda L_1b81 + $102,x
        sta $f1
        lda L_1b81 + $202,x
        bmi L_21a0
        jmp L_21dd
    L_21a0:
        and #$7f
        tax 
        lda L_1b5e,x
        sta $f5
        lda $f0
        and #$07
        sta $f4
        asl 
        adc $f4
        eor #$ff
        adc #$1a
        sta $f4
        ldx #$00
    L_21b9:
        dec $f4
        bne L_21ce
        lda #$18
        sta $f4
        inc $f1
        clc 
        lda $f0
        adc #$38
        sta $f0
        bcc L_21ce
        inc $f1
    L_21ce:
        ldy $1b2e,x
        lda #$00
        sta ($f0),y
        inx 
        cpx $f5
        bne L_21b9
        jmp L_2184
    L_21dd:
        cmp #$01
        bne L_2210
        lda $f0
        and #$07
        asl 
        eor #$ff
        adc #$12
        sta $f4
        ldx #$f2
    L_21ee:
        dec $f4
        bne L_2203
        lda #$10
        sta $f4
        inc $f1
        clc 
        lda $f0
        adc #$38
        sta $f0
        bcc L_2203
        inc $f1
    L_2203:
        ldy $232e,x
        lda #$00
        sta ($f0),y
        inx 
        bne L_21ee
        jmp L_2184
    L_2210:
        lda #$00
        tay 
        sta ($f0),y
        jmp L_2184
    L_2218:
        lda #$00
        sta L_226f + $1
        lda #$80
        sta L_226f + $2
        lda #$80
        sta L_226f + $3
        lda #$31
        sta L_226f + $4
        lda #$13
        sta L_226f
    L_2231:
        lda L_226f + $1
        sta $f0
        lda L_226f + $2
        sta $f1
        ldx L_226f + $3
        ldy L_226f + $4
        jsr L_2274
        clc 
        lda L_226f + $3
        adc #$20
        sta L_226f + $3
        lda L_226f + $4
        adc #$00
        sta L_226f + $4
        clc 
        lda L_226f + $1
        adc #$80
        sta L_226f + $1
        lda L_226f + $2
        adc #$01
        sta L_226f + $2
        dec L_226f
        lda L_226f
        bne L_2231
        rts 



    L_226f:
         .byte $00,$00,$00,$00,$00

    L_2274:
        stx $2285
        stx $228c
        sty $2286
        sty $228d
        ldx #$00
        ldy #$00
    L_2284:
        lda SCREEN_BUFFER_0 + $319,x
        sta ($f0),y
        inx 
        iny 
        lda $6619,x
        sta ($f0),y
        iny 
        lda #$00
        sta ($f0),y
        inx 
        iny 
        cpx #$20
        bne L_2284
        ldx #$08
    L_229d:
        ldy #$00
    L_229f:
        lda ($f0),y
        sta L_22e8
        iny 
        lda ($f0),y
        sta L_22e8 + $1
        iny 
        lda ($f0),y
        sta L_22e8 + $2
    L_22b0:
        lsr L_22e8
        ror L_22e8 + $1
        ror L_22e8 + $2
        tya 
        pha 
        clc 
        adc #$30
        tay 
        lda L_22e8 + $2
        sta ($f0),y
        dey 
        lda L_22e8 + $1
        sta ($f0),y
        dey 
        lda L_22e8
        sta ($f0),y
        pla 
        tay 
        iny 
        cpy #$30
        bne L_229f
        clc 
        lda $f0
        adc #$30
        sta $f0
        lda $f1
        adc #$00
        sta $f1
        dex 
        bne L_229d
        rts 



    L_22e8:
         .byte $00,$00,$00,$00
        .byte $30,$60,$90,$c0,$f0,$20,$50,$80,$80,$80,$80,$80,$80,$81,$81

    L_22fb:
        tya 
        cmp #$c7
        bcc L_2302
        ldy #$c7
    L_2302:
        lda L_2512,y
        sta $f0
        lda L_2612,y
        sta $f1
        lda L_2883
        cmp #$40
        beq L_231a
        clc 
        lda $f1
        adc #$a0
        sta $f1
    L_231a:
        ldy L_1b81 + $1
        lda #$02
        sta L_1b81 + $202,y
        txa 
        and #$f8
        clc 
        adc $f0
        sta $f0
        sta L_1b81 + $2,y
        bcc L_2331
        inc $f1
    L_2331:
        lda $f1
        sta L_1b81 + $102,y
        inc L_1b81 + $1
        txa 
        and #$07
        tax 
        lda L_2347,x
        ldy #$00
        ora ($f0),y
        sta ($f0),y
        rts 



    L_2347:
         .byte $80
        .byte $40,$20,$10,$08,$04,$02

    L_234e:
        ora ($8d,x)

        .byte $0c,$24,$98,$29,$07,$0a,$49,$ff,$69,$12,$85,$f4,$98,$cd,$0d,$24
        .byte $f0,$1c,$8d,$0d,$24,$c9,$c8,$90,$02,$a0,$c7

    L_236b:
        lda L_2512,y
        sta $f0
        sta L_240c + $2
        lda L_2612,y
        sta $f1
        sta L_240c + $3
        jmp L_2388
    L_237e:
        lda L_240c + $2
        sta $f0
        lda L_240c + $3
        sta $f1
    L_2388:
        lda L_2883
        cmp #$40
        beq L_2396
        clc 
        lda $f1
        adc #$a0
        sta $f1
    L_2396:
        ldy L_1b81 + $1
        lda #$01
        sta L_1b81 + $202,y
        txa 
        and #$f8
        clc 
        adc $f0
        sta $f0
        sta L_1b81 + $2,y
        lda $f1
        adc #$00
        sta $f1
        sta L_1b81 + $102,y
        inc L_1b81 + $1
        lda L_240c
        lsr 
    L_23b9:
        sta $2403
        lda #$00
        ror 
        sta $2402
        txa 
        and #$07
        tax 
        clc 
        lda L_240c + $4,x
        adc $2402
        sta $2402
        lda $2418,x
        adc $2403
        sta $2403
        sec 
        lda $2402
        sbc #$f2
        sta $2402
        bcs L_23e7
        dec $2403
    L_23e7:
        ldx #$f2
    L_23e9:
        dec $f4
        bne L_23fe
        lda #$10
        sta $f4
        inc $f1
        clc 
        lda $f0
        adc #$38
        sta $f0
        bcc L_23fe
        inc $f1
    L_23fe:
        ldy $232e,x
        lda $6619,x
    L_2404:
        ora ($f0),y
    L_2406:
        sta ($f0),y
        inx 
        bne L_23e9
        rts 



    L_240c:
         .byte $00,$00,$00,$00,$00,$10,$20
        .byte $30,$40,$50,$60,$70,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$00,$08,$01
        .byte $09,$02,$0a,$03,$0b,$04,$0c,$05,$0d,$06,$0e,$07,$0f

    L_2430:
        lda #$e0
        sta L_2488
        lda #$33
        sta L_2488 + $1
        lda #$00
        sta L_2488 + $2
        lda #$a0
        sta L_2488 + $3
        ldx #$00
    L_2446:
        txa 
        pha 
        lda L_2488
        sta $f0
        lda L_2488 + $1
        sta $f1
        lda L_2488 + $2
    L_2455:
        sta $f2
        lda L_2488 + $3
        sta $f3
        jsr L_248c
        clc 
        lda L_2488
        adc #$07
        sta L_2488
        lda L_2488 + $1
        adc #$00
        sta L_2488 + $1
        lda L_2488 + $2
        adc #$80
        sta L_2488 + $2
        lda L_2488 + $3
        adc #$00
        sta L_2488 + $3
        pla 
        tax 
        inx 
        cpx #$3d
        bne L_2446
        rts 



    L_2488:
         .byte $00,$00,$00,$00

    L_248c:
        ldy #$00
        lda ($f0),y
        sta ($f2),y
        ldy #$01
        lda ($f0),y
        ldy #$02
        sta ($f2),y
        lda ($f0),y
        ldy #$04
        sta ($f2),y
        ldy #$03
        lda ($f0),y
        ldy #$06
        sta ($f2),y
        ldy #$04
        lda ($f0),y
        ldy #$08
        sta ($f2),y
        ldy #$05
        lda ($f0),y
        ldy #$0a
        sta ($f2),y
        ldy #$06
        lda ($f0),y
        ldy #$0c
        sta ($f2),y
        lda #$00
        ldy #$0e
        sta ($f2),y
        ldy #$01
        lda #$00
    L_24ca:
        sta ($f2),y
        iny 
        iny 
        cpy #$11
        bne L_24ca
        ldx #$08
    L_24d4:
        ldy #$00
    L_24d6:
        lda ($f2),y
        sta L_2510
        iny 
        lda ($f2),y
        sta L_2510 + $1
        lsr L_2510
        ror L_2510 + $1
        tya 
        pha 
        clc 
        adc #$10
        tay 
        lda L_2510 + $1
        sta ($f2),y
        dey 
        lda L_2510
        sta ($f2),y
        pla 
        tay 
        iny 
        cpy #$10
        bne L_24d6
        clc 
        lda $f2
        adc #$10
        sta $f2
        lda $f3
        adc #$00
        sta $f3
        dex 
        bne L_24d4
        rts 



    L_2510:
         .byte $00,$00

    L_2512:
        jsr $2221

        .byte $23,$24,$25,$26,$27,$60,$61,$62,$63,$64,$65,$66,$67,$a0,$a1,$a2
        .byte $a3,$a4,$a5,$a6,$a7,$e0,$e1,$e2,$e3,$e4,$e5,$e6,$e7,$20,$21,$22
        .byte $23,$24,$25,$26,$27,$60,$61,$62,$63,$64,$65,$66,$67,$a0,$a1,$a2
        .byte $a3,$a4,$a5,$a6,$a7,$e0,$e1,$e2,$e3,$e4,$e5,$e6,$e7,$20,$21,$22
        .byte $23,$24,$25,$26,$27,$60,$61,$62,$63,$64,$65,$66,$67,$a0,$a1,$a2
        .byte $a3,$a4,$a5,$a6,$a7,$e0,$e1,$e2,$e3,$e4,$e5,$e6,$e7,$20,$21,$22
        .byte $23,$24,$25,$26,$27,$60,$61,$62,$63,$64,$65,$66,$67,$a0,$a1,$a2
        .byte $a3,$a4,$a5,$a6,$a7,$e0,$e1,$e2,$e3,$e4,$e5,$e6,$e7,$20,$21,$22
        .byte $23,$24,$25,$26,$27,$60,$61,$62,$63,$64,$65,$66,$67,$a0,$a1,$a2
        .byte $a3,$a4,$a5,$a6,$a7,$e0,$e1,$e2,$e3,$e4,$e5,$e6,$e7,$20,$21,$22
        .byte $23,$24,$25,$26,$27,$60,$61,$62,$63,$64,$65,$66,$67,$a0,$a1,$a2
        .byte $a3,$a4,$a5,$a6,$a7,$e0,$e1,$e2,$e3,$e4,$e5,$e6,$e7,$20,$21,$22
        .byte $23,$24,$25,$26
        .fill $39, $27

    L_2612:
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 

        .byte $41,$41,$41,$41,$41,$41,$41,$41,$42,$42,$42,$42,$42,$42,$42,$42
        .byte $43,$43,$43,$43,$43,$43,$43,$43,$45,$45,$45,$45,$45,$45,$45,$45
        .byte $46,$46,$46,$46,$46,$46,$46,$46,$47,$47,$47,$47,$47,$47,$47,$47
        .byte $48,$48,$48,$48,$48,$48,$48,$48,$4a,$4a,$4a,$4a,$4a,$4a,$4a,$4a
        .byte $4b,$4b,$4b,$4b,$4b,$4b,$4b,$4b,$4c,$4c,$4c,$4c,$4c,$4c,$4c,$4c
        .byte $4d,$4d,$4d,$4d,$4d,$4d,$4d,$4d,$4f,$4f,$4f,$4f,$4f,$4f,$4f,$4f
        .byte $50,$50,$50,$50,$50,$50,$50,$50,$51,$51,$51,$51,$51,$51,$51,$51
        .byte $52,$52,$52,$52,$52,$52,$52,$52,$54,$54,$54,$54,$54,$54,$54,$54
        .byte $55,$55,$55,$55,$55,$55,$55,$55,$56,$56,$56,$56,$56,$56,$56,$56
        .byte $57,$57,$57,$57,$57,$57,$57,$57,$59,$59,$59,$59,$59,$59,$59,$59
        .byte $5a,$5a,$5a,$5a,$5a,$5a,$5a,$5a,$5b,$5b,$5b,$5b,$5b,$5b,$5b,$5b
        .byte $5c,$5c,$5c,$5c,$5c,$5c,$5c,$5c

    L_26d2:
        lsr $5e5e,x
        lsr $5e5e,x
        lsr $5e5e,x
        lsr $5e5e,x
        lsr $5e5e,x
        lsr $5e5e,x
        lsr $5e5e,x
        lsr $5e5e,x
        lsr $5e5e,x
        lsr $5e5e,x
        lsr $5e5e,x
        lsr $5e5e,x
        lsr $5e5e,x
        lsr $5e5e,x
        lsr $5e5e,x
        lsr $5e5e,x
        lsr $5e5e,x
        lsr $5e5e,x
        lsr $5e5e,x
        lsr $5e5e,x
        lsr $5e5e,x
        lsr $a978,x

        .byte $00,$8d,$20,$d0,$8d,$21,$d0,$ad,$55,$08,$d0,$22,$a2,$00,$a9,$f0

    L_2724:
        sta $cc00,x
        sta $cd00,x
        sta $ce00,x
        sta $cf00,x
        sta SCREEN_BUFFER_1 + $00,x
        sta SCREEN_BUFFER_1 + $100,x
        sta SCREEN_BUFFER_1 + $200,x
        sta SCREEN_BUFFER_1 + $300,x
        dex 
        bne L_2724
        jmp L_276b
    L_2742:
        ldx #$00
    L_2744:
        lda L_35f8 + $5,x
        sta $cc00,x
        sta SCREEN_BUFFER_1 + $00,x
        lda L_36fd,x
        sta $cd00,x
        sta SCREEN_BUFFER_1 + $100,x
        lda L_37fd,x
        sta $ce00,x
        sta SCREEN_BUFFER_1 + $200,x
        lda $38fd,x
        sta $cf00,x
        sta SCREEN_BUFFER_1 + $300,x
        dex 
        bne L_2744
    L_276b:
        lda #$2f
        sta $00
        lda $01
        and #$f8
        ora #$05
        sta $01
        lda cCia2PortA
        and #$fe
        sta cCia2PortA
        lda #$80
        sta vMemControl
        lda #$00
        sta vScreenControl1
        jsr L_2218
        jsr L_358b
        jsr L_2430
        jsr L_29d8
        lda #$30
        sta vScreenControl1
        lda #$e0
        sta cCia1DDRA
        jsr L_19e8
        lda #$34
        sta $0318
        sta $fffa
        lda #$28
        sta $0319
        sta $fffb
        lda #$80
        sta $fffc
        lda #$28
        sta $fffd
        lda #$58
        sta $fffe
        lda #$28
        sta $ffff
        lda #$05
        sta L_1219 + $1
        lda $d030
        cmp #$ff
        beq L_27d8
        dec L_1219 + $1
        jsr L_2812
    L_27d8:
        rts 


    L_27d9:
        lda #$2f
        sta $00
        lda $01
        and #$f8
        ora #$05
        sta $01
        lda #$34
        sta $0318
        sta $fffa
        lda #$28
        sta $0319
        sta $fffb
        lda #$7f
        sta cCia2IntControl
        lda cCia2IntControl
        lda #$20
        sta cCia2TimerALo
    L_2802:
        lda #$4e
        sta cCia2TimerAHi
        lda #$81
        sta cCia2IntControl
        lda #$11
        sta cCia2TimerAControl
        rts 


    L_2812:
        lda #$7f
        sta cCia2IntControl
        sta cCia1IntControl
        lda cCia1IntControl
        lda cCia2IntControl
        lda vScreenControl1
        and #$7f
        sta vScreenControl1
        lda #$2e
        sta vRaster
        lda #$01
        sta vIRQMasks
        cli 
        rts 


        pha 
        tya 
        pha 
        ldy #$7f
        lda cCia2IntControl
        sty cCia2IntControl
        and #$01
        beq L_284e
        lda #$01
        sta L_29d1
        inc L_2857
        jsr L_19ad
    L_284e:
        lda #$81
        sta cCia2IntControl
        pla 
        tay 
        pla 
        rti 

    L_2857:
         .byte $00
        .byte $48,$a9,$ff,$8d,$19,$d0,$ad,$12,$d0,$c9,$fb,$b0,$0c,$a9,$00,$8d
        .byte $30,$d0,$a9,$fb,$8d,$12,$d0,$68,$40

    L_2871:
        lda #$01
        sta $d030
        lda #$2e
        sta vRaster
        lda cCia1IntControl
        pla 
        rti 
        jmp $7cf3
    L_2883:
        rti 
    L_2884:
        rti 
    L_2885:
        lda L_2883
        cmp #$e0
        bne L_288e
        beq L_2891
    L_288e:
        jmp L_2931
    L_2891:
        lda #$82
        sta $1a7b
        sta $1a9a
        sta $2185
        sta $218c
        sta $231b
        sta $2337
        sta $2397
        sta $23b3
        lda #$1b
        sta $1a7c
        sta $1a9b
        sta $2186
        sta $218d
        sta $231c
        sta $2338
        sta $2398
        sta $23b4
        lda #$83
        sta $1a8e
        sta $218f
        sta $232b
        sta $23a7
        lda #$1b
        sta $1a8f
        sta $2190
        sta $232c
        sta $23a8
        lda #$83
        sta $1a97
        sta $2194
        sta $2334
        sta $23b0
        lda #$1c
        sta $1a98
        sta $2195
        sta $2335
        sta $23b1
        lda #$83
        sta $1a83
        sta $2199
        sta $2320
        sta $239c
        lda #$1d
        sta $1a84
        sta $219a
        sta $2321
        sta $239d
        lda #$40
        sta L_2883
    L_291e:
        bit vScreenControl1
        bpl L_291e
        lda cCia2PortA
        lda #$c4
        sta cCia2PortA
        lda #$38
        sta vMemControl
        rts 


    L_2931:
        lda #$83
        sta $1a7b
        sta $1a9a
        sta $2185
        sta $218c
        sta $231b
        sta $2337
        sta $2397
        sta $23b3
        lda #$1e
        sta $1a7c
        sta $1a9b
        sta $2186
        sta $218d
        sta $231c
        sta $2338
        sta $2398
        sta $23b4
        lda #$84
        sta $1a8e
        sta $218f
        sta $232b
        sta $23a7
        lda #$1e
        sta $1a8f
        sta $2190
        sta $232c
        sta $23a8
        lda #$84
        sta $1a97
        sta $2194
        sta $2334
        sta $23b0
        lda #$1f
        sta $1a98
        sta $2195
        sta $2335
        sta $23b1
        lda #$84
        sta $1a83
        sta $2199
        sta $2320
        sta $239c
        lda #$20
        sta $1a84
        sta $219a
        sta $2321
        sta $239d
        lda #$e0
        sta L_2883
    L_29be:
        bit vScreenControl1
        bpl L_29be
        lda cCia2PortA
        lda #$c6
        sta cCia2PortA
        lda #$80
        sta vMemControl
        rts 



    L_29d1:
         .byte $00
        .byte $a9,$e0,$8d,$84,$28,$60

    L_29d8:
        lda #$40
        sta $f1
        lda #$e0
        sta $f3
        lda #$00
        sta $f0
        sta $f2
        ldx #$20
    L_29e8:
        ldy #$00
    L_29ea:
        sta ($f0),y
        sta ($f2),y
        iny 
        bne L_29ea
        inc $f1
        inc $f3
        dex 
        bne L_29e8
        rts 


    L_29f9:
        lda #$00
        sta vBorderCol
        sta vBackgCol0
        jsr L_2e4f
        lda #$93
        jsr $ffd2
        lda #$0e
        jsr $ffd2
        lda #$08
        jsr $ffd2
        lda #$9a
        jsr $ffd2
        lda #$0d
        jsr $ffd2
        lda #$0d
        jsr $ffd2
        lda #$0d
        jsr $ffd2
    L_2a27:
        lda #$0d
        jsr $ffd2
        jsr L_2f9b
        rts 


        rts 


        rts 


        rts 


        rts 


        rts 


        rts 


        rts 


        rts 


        rts 


        rts 


        rts 


        rts 


        rts 


        rts 


        rts 


        rts 


        rts 


        rts 


        rts 


        rts 


        rts 


        rts 


        rts 


        rts 


        rts 


        rts 


        rts 


        rts 


        rts 


        rts 


        rts 


        rts 


        rts 


        rts 


        rts 


        rts 


        rts 


        rts 


        rts 



        .byte $00,$20,$9b,$2f,$05,$61,$53,$54,$45,$52,$4f,$49,$44,$53,$20,$65
        .byte $4d,$55,$4c,$41,$54,$4f,$52,$20,$46,$4f,$52,$20,$54,$48,$45,$20
        .byte $63,$4f,$4d,$4d,$4f,$44,$4f,$52,$45,$20,$36,$34,$20,$00,$20,$9b
        .byte $2f
        .fill $28, $20
        .byte $00,$20,$9b,$2f,$20,$05,$20,$42,$59,$20,$6e,$4f,$52,$42,$45,$52
        .byte $54,$20,$6b,$45,$48,$52,$45,$52,$20,$49,$4e,$20,$66,$45,$42,$52
        .byte $55,$41,$52,$59,$20,$32,$30,$31,$33,$20,$20,$20,$9a,$00,$20,$9b
        .byte $2f
        .fill $28, $20
        .byte $00,$20,$9b,$2f,$20,$20,$20,$20,$20,$20,$20,$20,$4e,$4f,$52,$42
        .byte $45,$52,$54,$a4,$4b,$45,$48,$52,$45,$52,$40,$59,$41,$48,$4f,$4f
        .byte $2e,$44,$45,$20,$20,$20,$20,$20,$20,$20,$20,$20,$00,$20,$9b,$2f
        .byte $20,$20,$20,$20,$20,$48,$54,$54,$50,$3a,$2f,$2f,$57,$45,$42,$2e
        .byte $55,$54,$41,$4e,$45,$54,$2e,$41,$54,$2f,$4e,$4b,$45,$48,$52,$45
        .byte $52,$2f,$20,$20,$20,$20,$20,$20,$20,$00,$20,$9b,$2f
        .fill $17, $60

    L_2b7d:
        rts 


        rts 


        rts 


        rts 


        rts 


        rts 


        rts 


        rts 


        rts 


        rts 


        rts 


        rts 


        rts 


        rts 


        rts 


        rts 


        rts 



        .byte $00,$20,$9b,$2f,$05,$20,$20,$20,$63,$4f,$4e,$54,$52,$4f,$4c,$20
        .byte $47,$41,$4d,$45,$20,$57,$49,$54,$48,$20,$4a,$4f,$59,$53,$54,$49
        .byte $43,$4b,$20,$31,$20,$4f,$52,$20,$32,$3a,$20,$20,$20,$9a,$20,$20
        .byte $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$6c,$45,$46,$54,$20,$2e
        .byte $2e,$2e,$20,$72,$4f,$54,$41,$54,$45,$20,$6c,$45,$46,$54
        .fill $13, $20
        .byte $72,$49,$47,$48,$54,$20,$2e,$2e,$2e,$20,$72,$4f,$54,$41,$54,$45
        .byte $20,$72,$49,$47,$48,$54
        .fill $15, $20
        .byte $75,$50,$20,$2e,$2e,$2e,$20,$74,$48,$52,$55,$53,$54

    L_2c27:
        .fill $18, $20
        .byte $20,$64,$4f,$57,$4e,$20,$2e,$2e,$2e,$20,$68,$59,$50,$45,$52,$53
        .byte $50,$41,$43,$45
        .fill $15, $20
        .byte $66,$49,$52,$45,$20,$2e,$2e,$2e,$20,$66,$49,$52,$45
        .fill $19, $20
        .byte $66,$49,$52,$45,$20,$31,$20,$2e,$2e,$2e,$20,$73,$54,$41,$52,$54
        .byte $20,$31,$20,$70,$4c,$41,$59,$45,$52,$20,$20,$20,$20,$20,$20,$20
        .byte $20,$20,$20,$20,$20,$20,$20,$20,$66,$49,$52,$45,$20,$32,$20,$2e
        .byte $2e,$2e,$20,$73,$54,$41,$52,$54,$20,$32,$20,$70,$4c,$41,$59,$45
        .byte $52,$53,$20,$20,$20,$20,$00,$20,$9b,$2f
        .fill $28, $60
        .byte $05,$20,$20,$66,$31,$9a,$20,$54,$4f,$20,$43,$48,$41,$4e,$47,$45
        .byte $20,$4c,$41,$4e,$47,$55,$41,$47,$45,$3a,$20,$05,$65,$4e,$47,$4c
        .byte $49,$53,$48,$20,$20,$20,$20,$20,$20,$20,$20,$9a

    L_2d2c:
        ora $20
        jsr L_3364 + $2
        txs 
        jsr L_4f45 + $f
        jsr L_4843

        .byte $41,$4e,$47,$45,$20,$4f,$56,$45,$52,$4c,$41,$59,$3a,$20,$20,$05
        .byte $6f,$46,$46,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$9a
        .byte $00,$20,$9b,$2f
        .fill $28, $60
        .byte $05,$20,$20,$20,$20,$20,$20,$70,$52,$45,$53,$53,$20,$46,$49,$52
        .byte $45,$20,$42,$55,$54,$54,$4f,$4e,$20,$54,$4f,$20,$53,$54,$41,$52
        .byte $54,$21,$20,$20,$20,$20,$00,$a9,$01,$8d,$98,$2f

    L_2db0:
        jsr $ffe4
        cmp #$85
        bne L_2dc8
        inc L_0854
        lda L_0854
        and #$03
        sta L_0854
        jsr L_2df1
        jmp L_2ded
    L_2dc8:
        cmp #$86
        bne L_2ddd
        inc L_0854 + $1
        lda L_0854 + $1
        and #$01
        sta L_0854 + $1
        jsr $2e24
        jmp L_2ded
    L_2ddd:
        lda cCia1PortB
        and cCia1PortA
        and #$10
        bne L_2ded
        lda #$00
        sta vSprEnable
        rts 


    L_2ded:
        jmp L_2db0
        rts 


    L_2df1:
        asl 
        asl 
        asl 
        tax 
        ldy #$00
    L_2df7:
        lda L_2e04,x
        sta SCREEN_BUFFER_0 + $361,y
        inx 
        iny 
        cpy #$08
        bne L_2df7
        rts 



    L_2e04:
         .byte $45,$0e,$07,$0c
        .byte $09,$13,$08,$20,$44,$05,$15,$14,$13,$03,$08,$20,$46,$12,$01,$0e
        .byte $03,$01,$09,$13,$45,$13,$10,$01

    L_2e20:
        asl L_0c0f
        jsr $55ad
        php 
        bne L_2e38
        ldx #$00
    L_2e2b:
        lda L_2e47,x
    L_2e2e:
        beq L_2e37
        sta SCREEN_BUFFER_0 + $389,x
        inx 
        jmp L_2e2b
    L_2e37:
        rts 


    L_2e38:
        ldx #$00
    L_2e3a:
        lda L_2e4a + $1,x
        beq L_2e46
        sta SCREEN_BUFFER_0 + $389,x
        inx 
        jmp L_2e3a
    L_2e46:
        rts 



    L_2e47:
         .byte $4f
        .byte $06,$06

    L_2e4a:
        .byte $00,$4f
        .byte $0e,$20,$00

    L_2e4f:
        lda #$c0
        sta $07f8
        lda #$c1
        sta $07f9
        lda #$c2
        sta $07fa
        lda #$c3
        sta $07fb
        lda #$c4
        sta $07fc
        lda #$c5
        sta $07fd
        lda #$36
        sta vSprite0Y
        sta vSprite1Y
        sta vSprite2Y
        sta vSprite3Y
        sta vSprite4Y
        sta vSprite5Y
        lda #$78
        sta vSprite0X
        lda #$90
        sta vSprite1X
        lda #$a8
        sta vSprite2X
        lda #$c0
        sta vSprite3X
        lda #$d8
        sta vSprite4X
        lda #$f0
        sta vSprite5X
        lda #$01
        sta vSpr0Col
        sta vSpr1Col
        sta vSpr2Col
        sta vSpr3Col
        sta vSpr4Col
        sta vSpr5Col
        lda #$3f
        sta vSprEnable
        rts 


        dec $2f99
        beq L_2ebf
        rts 


    L_2ebf:
        lda L_2f9a
        sta $2f99
        sec 
        lda L_2f8b
        sbc #$01
        sta L_2f8b
        lda L_2f90 + $1
        sbc #$00
        and #$01
        sta L_2f90 + $1
        sec 
        lda L_2f8b + $1
        sbc #$01
        sta L_2f8b + $1
        lda L_2f90 + $2
        sbc #$00
        and #$01
        sta L_2f90 + $2
        sec 
        lda L_2f8b + $2
        sbc #$01
        sta L_2f8b + $2
        lda L_2f90 + $3
        sbc #$00
        and #$01
        sta L_2f90 + $3
        sec 
        lda L_2f8e
        sbc #$01
        sta L_2f8e
        lda L_2f90 + $4
        sbc #$00
        and #$01
        sta L_2f90 + $4
        sec 
        lda $2f8f
        sbc #$01
        sta $2f8f
        lda L_2f90 + $5
        sbc #$00
        and #$01
        sta L_2f90 + $5
        sec 
        lda L_2f90
        sbc #$01
        sta L_2f90
        lda L_2f90 + $6
        sbc #$00
        and #$01
        sta L_2f90 + $6
        lda L_2f90 + $6
        sta L_2f90 + $7
        lda L_2f90 + $5
        lsr 
        rol L_2f90 + $7
        lda L_2f90 + $4
        lsr 
        rol L_2f90 + $7
        lda L_2f90 + $3
        lsr 
        rol L_2f90 + $7
        lda L_2f90 + $2
        lsr 
        rol L_2f90 + $7
        lda L_2f90 + $1
        lsr 
        rol L_2f90 + $7
        lda L_2f90 + $7
        sta vSpriteXMSB
        lda L_2f8b
        sta vSprite0X
        lda L_2f8b + $1
        sta vSprite1X
        lda L_2f8b + $2
        sta vSprite2X
        lda L_2f8e
        sta vSprite3X
        lda $2f8f
        sta vSprite4X
        lda L_2f90
        sta vSprite5X
        rts 



    L_2f8b:
         .byte $78,$90,$a8

    L_2f8e:
        cpy #$d8

    L_2f90:
         .byte $f0,$00,$00,$00,$00,$00,$00,$00

    L_2f98:
        ora ($00,x)

    L_2f9a:
         .byte $80

    L_2f9b:
        clc 
        pla 
        adc #$01
        sta $2fa9
        pla 
        adc #$00
        sta $2faa
    L_2fa8:
        lda $4213
        beq L_2fc4
        jsr $ffd2
        clc 
        lda $2fa9
        adc #$01
        sta $2fa9
        lda $2faa
        adc #$00
        sta $2faa
        jmp L_2fa8
    L_2fc4:
        lda $2faa
        pha 
        lda $2fa9
        pha 
        rts 


        sta $2fd4
        stx $2fd5
    L_2fd3:
        lda $4213
        beq L_2fef
        jsr $ffd2
        clc 
        lda $2fd4
        adc #$01
        sta $2fd4
        lda $2fd5
        adc #$00
        sta $2fd5
        jmp L_2fd3
    L_2fef:
        rts 



    L_2ff0:
         .fill $14, $0
        .byte $2c,$c0,$00,$40,$22,$00,$9f,$a1,$00,$9f,$8b,$00,$3f,$a7,$01,$3f
        .byte $97,$00,$7f,$d7,$02,$ff,$c7,$04,$ff,$d7,$01,$ff,$c7,$05,$f7,$e0
        .byte $0b

    L_3025:
        .byte $f7,$ff,$03,$ff,$ff,$17,$ff,$ff,$27,$ff,$ff,$2f
        .byte $81,$ef,$4f,$91,$e7,$9f,$11,$f1,$40,$6c,$04,$66,$4c,$cc,$00,$6e
        .byte $00,$00,$80,$cd,$99,$38,$00,$00,$ff,$3f,$ff,$ff,$bf,$ff,$ff,$ff
        .byte $ff,$cf,$ff,$ff,$e7,$87,$e3,$f8,$07,$cb,$ff,$57,$db,$ff,$b7,$c3
        .byte $ff,$87,$d3,$7f,$87,$d3,$1f,$af,$c7,$9f,$af,$c7,$ff,$cf,$97,$fe
        .byte $5f,$97,$fe,$3f,$af,$f1,$9f,$2f,$04,$40,$10,$d8,$6d,$99,$00,$00
        .byte $00,$00,$99,$99,$b3,$00,$00,$00,$ff,$f7,$ff,$ff,$f7,$ff,$ff,$f7
        .byte $ff,$ff,$f7,$ff,$f0,$0f,$87,$f0,$0f,$87,$ff,$cf,$ff,$ff,$cf,$ff
        .byte $ff,$cf,$ff,$e0,$0f,$ff,$c0,$1f,$ff,$ff,$df,$0f,$ff,$df,$4f,$ff
        .byte $df,$0f,$ff,$ff,$4f,$ff,$3e,$af,$00,$00,$20,$99,$99,$33,$00,$00
        .byte $30,$00,$03,$03,$26,$4c,$00,$80,$99,$fe,$4f,$c7,$ff,$0f,$ef,$ff
        .byte $9f,$ff,$ff,$df,$ff,$87,$df,$ff,$27,$ff,$fe,$17,$fe,$be,$87,$fe
        .byte $3e,$17,$fe,$bf,$2f,$fe,$be,$4f,$fc,$bf,$1f,$bc,$9f,$ff,$7c,$9f
        .byte $fe,$7d,$8f,$fe,$7d,$83,$f0,$7d,$30,$02,$00,$23

    L_30fd:
        and ($66),y

        .byte $00,$00,$00,$00,$66,$64,$2c,$00,$0a,$10,$3f,$f9,$9f,$3f,$fc,$3f
        .byte $7f,$fe,$7f,$7f,$fe,$ff,$7c,$3e,$7c,$7d,$5f,$7f,$fa,$5f,$7f,$f8
        .byte $bf,$7f,$fa,$3e,$3f,$fa,$3e,$c7,$f0,$be,$f1,$ff,$fc,$f9,$ff,$fd
        .byte $ff,$ff,$f0,$ff,$ff,$f2,$ff,$ff,$19,$3f,$00,$60,$00,$66,$40,$6c
        .byte $00,$00,$00,$00,$c8,$00,$00,$04,$00,$00,$f2,$00,$00,$f8,$00,$00
        .byte $fc,$00,$00,$fd,$00,$00,$7d,$00,$00,$80,$00,$00,$f4,$00,$00,$fa
        .byte $00,$00,$f8,$00,$00,$f8

    L_3165:
        .byte $00,$00,$fa,$00,$00,$fa,$00,$00
        .byte $f8,$00,$00,$f4,$00,$00,$e0,$00

    L_3175:
        .byte $00,$90,$00,$00
        .byte $20,$00,$00,$c0,$00,$00,$00

    L_3180:
        php 
        bpl L_3197
        plp 

        .byte $22,$44,$41,$42,$80,$81,$80,$02,$80,$02,$80,$04,$80,$02,$80,$02
        .byte $80,$01,$80

    L_3197:
        ora ($40,x)
        asl $20
        clc 
        clc 
        jsr $c007

        .byte $02,$40,$05,$a0,$08,$90,$08,$20,$08,$20,$08,$10,$04,$60

    L_31ae:
        .byte $03,$80,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
        .byte $00,$00,$01,$80,$02,$c0,$02,$40,$01,$80
        .fill $18, $0
        .byte $08,$10,$16,$68,$21,$84,$40,$02,$80,$01,$40,$0e,$40,$10,$20,$08
        .byte $20,$06,$40,$01,$40,$01,$80,$02,$40,$02,$23,$04,$14,$c8,$08

    L_31ff:
        .byte $30,$02
        .byte $40,$05,$a0,$08,$10,$04,$60,$04,$20,$08,$10,$05,$a0,$02,$40,$00
        .byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00

    L_3220:
        ora ($80,x)

        .byte $02,$c0,$02,$40,$01,$80
        .fill $18, $0
        .byte $03,$f0,$04,$08,$08,$08,$10,$04,$20,$02,$40,$02

    L_324c:
        beq L_324f
        php 
    L_324f:
        ora ($70,x)
        ora ($80,x)
        sta ($41,x)

        .byte $82,$42,$82,$22,$84,$24,$84,$14,$88,$08,$f0,$01,$c0,$02,$20,$04
        .byte $20,$0e,$10,$08,$10,$04,$a0,$05,$a0,$02,$c0,$00,$00,$00,$00,$00
        .byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$01,$80,$01,$40,$02
        .byte $c0,$01,$80
        .fill $18, $0
        .byte $0f,$c0,$08,$30,$04,$08,$02,$06,$fe

    L_32a9:
        ora ($80,x)
        ora ($80,x)

        .byte $07,$80,$78,$80,$20,$80,$18,$40,$06,$40,$01,$20,$01,$10,$42,$13
        .byte $a4,$0c,$18,$03,$80,$02,$60,$0e,$10,$08,$70,$08,$40,$04,$20,$04
        .byte $90,$03,$60,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
        .byte $00,$00,$00,$01,$80,$03,$40,$02,$40,$01,$80
        .fill $18, $0
        .byte $03,$c0,$02,$40,$07,$e0,$08,$10,$10,$08,$3f,$fc,$10,$08,$08,$10
        .byte $07,$e0,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
        .byte $01,$80,$02,$40,$05,$a0,$03,$c0,$00

    L_3329:
        .fill $17, $0
        .byte $10,$10,$02,$00,$00,$00,$00,$08,$04,$00,$00,$00,$00,$00,$10,$10
        .byte $00,$40,$04,$10,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00

    L_3360:
        jsr.a $0000
        php 

    L_3364:
         .byte $02,$00,$00,$00,$00,$00,$00,$04,$04,$00,$00,$00,$00,$00
        .byte $20,$08,$00,$00,$00,$40,$04,$08,$00,$00,$00,$00,$00,$00,$40,$08
        .byte $00,$00,$02,$00,$00,$00,$00,$00,$00,$02,$08,$00,$00,$00,$00,$00
        .byte $00,$00,$40,$08,$00,$40,$00,$00,$08,$08,$00,$00,$00,$00,$80,$04
        .byte $00,$00,$02,$00,$00,$00,$00,$00,$00,$00,$00,$01,$08,$00,$00,$00
        .byte $00,$00,$00,$00,$80,$04,$00,$00,$00,$40,$00,$00,$08,$04,$00,$00
        .byte $00,$00,$00,$00,$00,$00,$04,$00,$03,$00,$02,$c0,$02,$30,$02,$c0
        .byte $03,$00,$04
        .fill $12, $0
        .byte $f8,$88,$88,$88,$88,$88,$f8,$20,$20,$20,$20,$20,$20,$20,$f8,$08
        .byte $08,$f8,$80,$80,$f8,$f8,$08,$08,$f8

    L_3400:
        php 
        php 
        sed 
        dey 
        dey 
        dey 
        sed 
        php 
        php 
        php 
        sed 

        .byte $80,$80,$f8,$08,$08,$f8,$80,$80,$80,$f8,$88,$88,$f8,$f8,$08,$08
        .byte $08,$08,$08,$08,$f8

    L_3420:
        dey 
        dey 
        sed 
        dey 
        dey 
        sed 
        sed 
        dey 
        dey 
    L_3429:
        sed 
        php 
        php 
        php 
        jsr $8850

    L_3430:
         .byte $88,$f8,$88,$88,$f0,$88,$88,$f0,$88
        .byte $88,$f0,$f8,$80,$80,$80,$80,$80,$f8,$e0,$90,$88,$88,$88,$90,$e0
        .byte $f8,$80,$80,$f0,$80,$80,$f8,$f8,$80,$80,$f0,$80,$80,$80,$f8,$88
        .byte $88,$80,$b8,$88,$f8,$88,$88,$88,$f8,$88,$88,$88,$f8,$20,$20,$20
        .byte $20,$20,$f8,$08,$08,$08,$08,$88,$48,$38,$90,$a0,$c0,$80,$c0,$a0
        .byte $90,$80,$80,$80,$80,$80,$80,$f8,$88,$d8,$a8,$88,$88,$88,$88,$88
        .byte $c8,$a8,$a8

    L_348c:
        tya 
        tya 
        dey 
        sed 
        dey 
        dey 
        dey 
        dey 
        dey 
        sed 
        sed 
        dey 
        dey 
        sed 

        .byte $80,$80,$80,$f8,$88,$88,$88,$a8,$90,$e8,$f8,$88,$88,$f8,$a0,$90
        .byte $88,$f8,$80,$80,$f8,$08,$08,$f8,$f8,$20,$20,$20,$20,$20,$20,$88
        .byte $88,$88,$88,$88,$88,$f8,$88,$88,$50,$50,$50,$20,$20,$88,$88,$88
        .byte $88,$a8,$d8,$88,$88,$88,$50,$20,$50,$88,$88,$88,$50,$20,$20,$20
        .byte $20,$20,$f8,$08,$10,$20,$40,$80,$f8,$00,$c0,$78

    L_34e6:
        lsr $78
        cpy #$00

        .byte $00,$f0,$4e,$4c,$70,$40,$00,$00,$1e,$e4,$28,$10,$20,$00,$06,$1c
        .byte $64,$e8,$18,$10,$10,$04,$0c,$14,$38,$48,$08,$08,$08,$18,$18,$28
        .byte $24,$7c,$04,$10,$10

    L_350f:
        plp 
        plp 
        plp 

        .byte $7c,$44

    L_3514:
        jsr L_3025 + $b

    L_3517:
         .byte $48,$48,$7c
        .byte $40,$40,$60,$50,$48,$34,$20,$20,$c0,$b0,$4c,$4e,$30,$30,$10,$00
        .byte $f0,$4e,$30,$10,$08,$00,$00,$1e,$e4,$64,$1c,$04,$00,$00,$06,$3c
        .byte $c4,$3c,$06,$00,$04,$1c,$64,$f4,$0e,$00,$00,$08,$10,$30,$5e,$e0
        .byte $00,$00,$10,$30,$30,$4e,$58,$e0,$80,$20,$20,$34,$48,$50,$60,$40
        .byte $40,$7c,$48,$48,$30,$30,$20,$44,$7c,$28,$28,$28,$10,$10,$04,$7c
        .byte $24,$28,$18,$18,$08,$08,$08,$58,$28,$14,$0c,$04,$10,$10

    L_3578:
        clc 
        inx 

        .byte $34,$0c,$02,$00

    L_357e:
        jsr $2810

        .byte $f4,$0e,$00,$00,$40,$70,$4c

    L_3588:
        lsr.a $00e0,x
    L_358b:
        ldx #$2f
    L_358d:
        lda L_359d,x
    L_3590:
        sta L_3180,x
        lda L_35c8 + $5,x
        sta L_31ae + $2,x
        dex 
        bpl L_358d
        rts 



    L_359d:
         .byte $00,$ff,$ff
        .byte $fe,$fd,$fc,$fc,$00,$00,$01,$01,$02,$02,$00,$00,$00,$00,$01,$02
        .byte $03,$00,$00,$00,$00,$00,$ff,$fe,$fd,$fc,$00,$00,$00,$00,$ff,$fe
        .byte $fd,$00,$00,$00,$00,$00,$01,$02

    L_35c8:
        .byte $00,$00,$00,$00,$00,$00
        .byte $01,$02,$03,$04,$05,$06,$00,$00,$01,$02,$03,$04,$00,$00,$00,$00
        .byte $00,$ff,$ff,$00,$00,$00,$00,$00,$ff,$fe,$fd,$fc,$00,$00,$00,$00
        .byte $00,$ff,$ff,$00,$00,$00,$00,$00,$01,$02

    L_35f8:
        .byte $00,$00,$00,$00,$00,$f0,$f0

    L_35ff:
        beq L_3631
        bmi L_3633

        .byte $30,$d0,$d0,$d0,$d0,$d0,$d0,$e0,$e0,$e0,$e0,$e0,$e0,$e0

    L_3611:
        cpx #$e0
    L_3613:
        cpx #$e0
    L_3615:
        cpx #$e0
    L_3617:
        cpx #$d0

        .byte $d0,$d0,$d0,$d0,$d0,$30,$30,$30,$30,$f0

    L_3623:
        beq L_3615
    L_3625:
        beq L_3617
    L_3627:
        beq L_3659
        bmi L_365b

        .byte $d0,$d0,$d0,$d0,$d0,$e0

    L_3631:
        cpx #$e0
    L_3633:
        cpx #$e0
        cpx #$e0
        cpx #$e0
        cpx #$e0
    L_363b:
        cpx #$e0
    L_363d:
        cpx #$e0
    L_363f:
        cpx #$e0
        cpx #$d0
        bne L_3615
        bne L_3617

        .byte $30,$30,$30,$f0,$f0,$f0,$f0,$f0

    L_364f:
        .byte $30,$30

    L_3651:
        bmi L_3623
        bne L_3625
        bne L_3627
        cpx #$e0
    L_3659:
        cpx #$e0
    L_365b:
        cpx #$60
        rts 


    L_365e:
        rts 


        rts 


        rts 


        rts 


        rts 


        rts 


    L_3664:
        rts 


        rts 



    L_3666:
         .byte $e0,$e0,$e0,$e0,$e0,$d0,$d0,$d0,$d0,$d0
        .byte $30,$30

    L_3672:
        bmi L_3664
    L_3674:
        beq L_3666
        bmi L_36a8
        bmi L_36aa

        .byte $d0,$d0,$d0,$e0,$e0,$e0,$e0,$e0,$60,$60,$60,$60

    L_3686:
        rts 


        rts 


        rts 


        rts 


        rts 


        rts 


        rts 


        rts 


    L_368e:
        rts 


        rts 



        .byte $e0,$e0,$e0,$e0,$e0,$d0,$d0,$d0,$30,$30,$30,$30,$f0,$f0,$30,$30
        .byte $30,$d0

    L_36a2:
        bne L_3674
        bne L_3686
        cpx #$e0
    L_36a8:
        cpx #$60
    L_36aa:
        rts 


        rts 


        rts 


    L_36ad:
        rts 


        rts 


        rti 
        rti 
        rti 
        rti 
        rts 


        rts 


    L_36b5:
        rts 


        rts 


        rts 


        rts 



        .byte $e0,$e0,$e0,$e0,$d0,$d0,$d0,$d0,$30,$30,$30,$f0,$30,$30,$30,$d0
        .byte $d0,$d0,$d0,$e0,$e0,$e0,$e0,$60,$60,$60,$60

    L_36d4:
        rts 


        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rts 


        rts 


        rts 


        rts 


        rts 



        .byte $e0,$e0,$e0,$e0,$d0,$d0,$d0,$d0,$30,$30,$30,$30,$30,$30,$d0,$d0
        .byte $d0,$e0,$e0,$e0,$e0,$60,$60,$60,$60,$40,$40

    L_36fd:
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rts 


        rts 


        rts 


        rts 



        .byte $e0,$e0,$e0,$e0,$d0,$d0,$d0,$30,$30,$30,$30,$30,$30,$d0,$d0,$d0
        .byte $e0,$e0,$e0,$60,$60

    L_3720:
        rts 


        rts 


        rti 
        rti 
        rti 
        rti 
        rti 

        .byte $20,$20,$20,$20,$40,$40,$40,$40,$40,$60,$60,$60,$60

    L_3734:
        .byte $e0,$e0,$e0,$d0,$d0,$d0,$30,$30,$30,$30,$30,$d0,$d0,$d0
        .byte $e0,$e0,$e0,$e0,$60

    L_3747:
        rts 


        rts 


        rti 
        rti 
        rti 
        rti 

        .byte $20,$20,$20,$20,$20,$20,$20,$20,$40,$40,$40,$40,$60,$60,$60,$e0
        .byte $e0,$e0,$e0,$d0,$d0,$d0,$30,$30,$30,$30,$d0,$d0,$d0,$e0,$e0,$e0
        .byte $60,$60,$60,$60,$40,$40

    L_3773:
        rti 

        .byte $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$40,$40,$40,$60,$60

    L_3783:
        rts 


        rts 



    L_3785:
         .byte $e0,$e0,$e0,$d0,$d0,$d0,$30,$30,$30,$30,$d0,$d0
        .byte $d0,$e0,$e0,$e0,$60

    L_3796:
        rts 


        rts 


        rti 
        rti 
        rti 
    L_379b:
        rti 

        .byte $20,$20,$20,$20,$70,$70,$20,$20,$20,$20,$40,$40,$40,$40,$60,$60
        .byte $60,$e0,$e0,$e0,$d0,$d0,$d0,$30,$30,$30,$30,$d0,$d0,$d0,$e0,$e0
        .byte $e0,$60,$60,$60,$40,$40,$40,$20,$20,$20,$20,$70,$70,$70,$70,$20
        .byte $20,$20,$20,$40,$40,$40,$60,$60,$60,$e0,$e0,$e0,$d0,$d0,$d0,$30
        .byte $30,$30,$30,$d0,$d0,$d0,$e0,$e0,$e0

    L_37e5:
        rts 


        rts 


    L_37e7:
        rts 


        rti 
        rti 
        rti 

        .byte $20,$20,$20,$70,$70,$70,$70,$70,$70,$20,$20,$20,$40,$40,$40,$60
        .byte $60,$60

    L_37fd:
        .byte $e0,$e0,$e0,$d0,$d0,$d0,$30,$30,$30,$30,$d0,$d0,$d0,$e0
        .byte $e0,$e0,$60,$60,$60,$40,$40,$40,$20,$20,$20,$70,$70,$70,$70,$70
        .byte $70,$20,$20,$20,$40,$40,$40,$60,$60,$60,$e0,$e0,$e0,$d0,$d0,$d0
        .byte $30,$30,$30,$30,$d0,$d0,$d0,$e0,$e0,$e0,$60,$60,$60,$40,$40,$40
        .byte $20,$20,$20,$20,$70,$70,$70,$70,$20,$20,$20,$20,$40,$40,$40,$60

    L_384b:
        rts 


        rts 



    L_384d:
         .byte $e0,$e0,$e0,$d0,$d0,$d0,$30,$30,$30,$30,$d0,$d0,$d0,$e0
        .byte $e0,$e0,$60,$60,$60

    L_3860:
        rti 
        rti 
    L_3862:
        rti 
    L_3863:
        rti 

        .byte $20,$20,$20,$20,$70,$70,$20,$20,$20,$20,$40,$40,$40,$40,$60,$60
        .byte $60,$e0,$e0,$e0,$d0

    L_3879:
        bne L_384b
        bmi L_38ad
        bmi L_38af
        bne L_384d + $4
        bne L_3863
        cpx #$e0
        rts 


        rts 


        rts 


    L_3888:
        rts 


        rti 
    L_388a:
        rti 
    L_388b:
        rti 

        .byte $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$40,$40,$40

    L_3899:
        rts 


        rts 


        rts 


        rts 



        .byte $e0,$e0,$e0,$d0,$d0,$d0,$30,$30,$30,$30,$d0,$d0,$d0,$e0,$e0,$e0

    L_38ad:
        cpx #$60
    L_38af:
        rts 


        rts 


        rti 
        rti 
        rti 
    L_38b4:
        rti 

        .byte $20,$20,$20,$20,$20,$20,$20,$20,$40,$40,$40,$40,$60,$60,$60

    L_38c4:
        .byte $e0,$e0,$e0,$e0,$d0,$d0,$d0,$30,$30,$30,$30,$30,$d0,$d0
        .byte $d0,$e0,$e0,$e0,$60

    L_38d7:
        rts 


        rts 


        rts 


        rti 
        rti 
    L_38dc:
        rti 
        rti 
        rti 

        .byte $20,$20,$20,$20,$40,$40,$40,$40,$40,$60,$60,$60,$60,$e0,$e0,$e0
        .byte $d0,$d0,$d0,$30,$30,$30,$30,$30,$30,$d0,$d0,$d0,$e0,$e0,$e0,$e0
        .byte $60,$60,$60,$60,$40,$40

    L_3905:
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rts 


        rts 


        rts 


        rts 



        .byte $e0,$e0,$e0,$e0,$d0,$d0,$d0,$30,$30,$30,$30,$30,$30,$d0,$d0,$d0
        .byte $d0,$e0,$e0,$e0,$e0,$60,$60,$60,$60,$60,$40,$40,$40,$40,$40,$40
        .byte $40,$40,$60,$60,$60

    L_3938:
        rts 


    L_3939:
        rts 



    L_393a:
         .byte $e0,$e0,$e0,$e0,$d0,$d0,$d0,$d0,$30,$30,$30,$f0,$30,$30,$d0,$d0
        .byte $d0,$d0,$e0,$e0,$e0,$e0

    L_3950:
        rts 


        rts 


        rts 


        rts 


        rts 


        rti 
    L_3956:
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rti 
        rts 


    L_395e:
        rts 


        rts 


    L_3960:
        rts 


        rts 


        cpx #$e0
        cpx #$e0
        bne L_3938
        bne L_393a
        bmi L_399c
    L_396c:
        bmi L_395e
    L_396e:
        bmi L_39a0
        bmi L_39a2
        bne L_393a + $a
        bne L_3956
        cpx #$e0
        cpx #$e0
        rts 


        rts 


        rts 


        rts 


        rts 


        rts 


    L_3980:
        rts 


        rts 


        rts 


        rts 


        rts 


        rts 


    L_3986:
        rts 


        rts 


        cpx #$e0
        cpx #$e0
        cpx #$d0
        bne L_3960
        bmi L_39c2
        bmi L_39c4
    L_3994:
        beq L_3986
    L_3996:
        beq L_39c8
    L_3998:
        bmi L_39ca
        bne L_396c
    L_399c:
        bne L_396e
        bne L_3980
    L_39a0:
        cpx #$e0
    L_39a2:
        cpx #$e0
        rts 


        rts 


        rts 


        rts 


        rts 


        rts 


        rts 


        rts 


    L_39ac:
        rts 


        rts 



    L_39ae:
         .byte $e0,$e0,$e0,$e0,$e0,$d0,$d0,$d0,$d0,$d0,$30,$30
        .byte $30,$f0,$f0,$f0,$f0,$f0,$30,$30

    L_39c2:
        bmi L_3994
    L_39c4:
        bne L_3996
        bne L_3998
    L_39c8:
        cpx #$e0
    L_39ca:
        cpx #$e0
        cpx #$e0
        cpx #$e0
        cpx #$e0
        cpx #$e0
    L_39d4:
        cpx #$e0
        cpx #$e0
        cpx #$e0
        bne L_39ac
        bne L_39ae

        .byte $d0,$30,$30,$30,$f0,$f0,$f0,$4c,$f3,$7c

    L_39e8:
        jsr $6efa
        jsr $6ed8
    L_39ee:
        jsr $7168
    L_39f1:
        lda L_1b81 + $486
    L_39f4:
        bmi L_39f4
        lsr $5b
        bcc L_39f1
    L_39fa:
        lda L_1b81 + $481
        bmi L_39fa
        lda $4001
        eor #$02
        sta $4001
        sta L_2ff0 + $10
    L_3a0a:
        sta L_3400
        inc $5c
        bne L_3a13
        inc $5d
    L_3a13:
        ldx #$40
        and #$02
        bne L_3a1b
        ldx #$44
    L_3a1b:
        lda #$02
        sta $02
        stx $03
        jsr $6885
        bcs L_39e8
        jsr $765c
        jsr $6d90
        bpl L_3a49
        jsr $73c4
        bcs L_3a49
        lda $5a
        bne L_3a43
        jsr $6cd7
        jsr $6e74
        jsr $703f
        jsr $6b93
    L_3a43:
        jsr $6f57
        jsr $69f0
    L_3a49:
        jsr $724f
        jsr $7555
        lda #$7f
        tax 
        jsr $7c03
        jsr $77b5
        jsr $7bc0
        lda $02fb
        beq L_3a63
        dec $02fb
    L_3a63:
        ora $02f6
        bne L_39f1
        beq L_39ee
        lda $1c
        beq L_3a82
        lda $5a
        bne L_3a75
        jmp $6960
    L_3a75:
        dec $5a
        jsr $69e2
    L_3a7a:
        clc 
        rts 


    L_3a7c:
        lda #$02
        sta $70
        bne L_3a95
    L_3a82:
        lda $71
        and #$03
        beq L_3a7c
        clc 
        adc #$07
        tay 
        lda $32
        and $33
        bpl L_3a95
        jsr $77f6
    L_3a95:
        ldy $70
        beq L_3a7a
        ldx #$01
        lda $2403
        bmi L_3ac3
        cpy #$02
        bcc L_3b20
        lda L_2404
        bpl L_3b20
        lda $6f
        ora #$04
        sta $6f
        sta L_31ff + $1
        jsr $6ed8
        jsr $7168
        jsr $71e8
        lda $56
        sta $58
        ldx #$02
        dec $70
    L_3ac3:
        stx $1c
        dec $70
        lda $6f
        and #$f8
        eor $1c
        sta $6f
        sta L_31ff + $1
        jsr $71e8
        lda #$01
        sta $02fa
        sta $03fa
        lda #$92
        sta $02f8
        sta $03f8
        sta $03f7
        sta $02f7
        lda #$7f
        sta $02fb
        sta $03fb
        lda #$05
        sta $02fd
        sta $03fd
        lda #$ff
        sta $32
        sta $33
        lda #$80
        sta $5a
        asl 
        sta $18
        sta $19
        lda $56
        sta $57
        lda #$04
        sta $6c
        sta $6e
        lda #$30
        sta $02fc
        sta $03fc
        sta L_3e00
        rts 


    L_3b20:
        lda $32
        and $32
        bpl L_3b31
        lda $5c
        and #$20
        bne L_3b31
        ldy #$06
        jsr $77f6
    L_3b31:
        lda $5c
        and #$0f
        bne L_3b43
        lda #$01
        cmp $70
        adc #$01
        eor #$01
        eor $6f
        sta $6f
    L_3b43:
        clc 
        rts 


        lda $5c
        and #$3f
        bne L_3b55
        lda $02fc
        cmp #$08
        beq L_3b55
        dec $02fc
    L_3b55:
        ldx $18
        lda $57,x
        bne L_3b77
        lda $021f
        ora $0220
        ora $0221
        ora $0222
        bne L_3b77
        ldy #$07
        jsr $77f6
        lda $1c
        cmp #$02
        bcc L_3b77
        jsr $69e2
    L_3b77:
        lda $021b
        bne L_3bb2
        lda $02fa
        cmp #$80
        bne L_3bb2
        lda #$10
        sta $02fa
        ldx $1c
        lda $57
        ora $58
        beq L_3bb4
        jsr $702d
        dex 
        beq L_3bb2
        lda #$80
        sta $5a
        lda $18
        eor #$01
        tax 
        lda $57,x
        beq L_3bb2
        stx $18
        lda #$04
        eor $6f
        sta $6f
        sta L_31ff + $1
        txa 
        asl 
        sta $19
    L_3bb2:
        clc 
        rts 


    L_3bb4:
        stx $1a
        lda #$ff
        sta $1c
        jsr $6efa
        lda $6f
        and #$f8
        ora #$03
        sta $6f
        clc 
        rts 


        ldy #$01
        jsr $77f6
        ldy $18
        iny 
        tya 
        jsr $7bd1
        rts 



        .byte $71,$a2,$07

    L_3bd7:
        lda $021b,x
        beq L_3bde
        bpl L_3be2
    L_3bde:
        dex 
        bpl L_3bd7
        rts 


    L_3be2:
        ldy #$1c
        cpx #$04
        bcs L_3bef
        dey 
        txa 
        bne L_3bef
    L_3bec:
        dey 
        bmi L_3bde
    L_3bef:
        lda $0200,y
        beq L_3bec
        bmi L_3bec
        sta $0b
        lda $02af,y
        sec 
        sbc $02ca,x
        sta $08
    L_3c01:
        lda $0269,y
    L_3c04:
        sbc $0284,x
        lsr 
        ror $08
        asl 
        beq L_3c19
        bpl L_3c7c
        eor #$fe
        bne L_3c7c
        lda $08
        eor #$ff
        sta $08
    L_3c19:
        lda $02d2,y
        sec 
        sbc $02ed,x
        sta $09
        lda $028c,y
        sbc $02a7,x
        lsr 
        ror $09
        asl 
        beq L_3c3a
        bpl L_3c7c
        eor #$fe
        bne L_3c7c
        lda $09
        eor #$ff
        sta $09
    L_3c3a:
        lda #$2a
        lsr $0b
        bcs L_3c48
        lda #$48
        lsr $0b
        bcs L_3c48
        lda #$84
    L_3c48:
        cpx #$01
        bcs L_3c4e
        adc #$1c
    L_3c4e:
        bne L_3c5c
        adc #$12
        ldx $021c
        dex 
        beq L_3c5a
        adc #$12
    L_3c5a:
        ldx #$01
    L_3c5c:
        cmp $08
        bcc L_3c7c
        cmp $09
        bcc L_3c7c
        sta $0b
        lsr 
        clc 
        adc $0b
        sta $0b
        lda $09
        adc $08
        bcs L_3c7c
        cmp $0b
        bcs L_3c7c
        jsr $6b0f
    L_3c79:
        jmp $69f9
    L_3c7c:
        dey 
        bmi L_3c79
        jmp $6a0a
        lda $0200,y
        and #$07
        sta $08
        jsr $77b5
        and #$18
        ora $08
        sta $0200,x
        lda $02af,y
        sta $02af,x
        lda $0269,y
        sta $0269,x
        lda $02d2,y
        sta $02d2,x
        lda $028c,y
        sta $028c,x
        lda $0223,y
        sta $0223,x
        lda $0246,y
        sta $0246,x
        rts 


        sta $0b
        stx $0c
        ldy #$00
    L_3cbe:
        iny 
        lda ($0b),y
        eor $09
        sta ($02),y
        dey 
        cmp #$f0
        bcs L_3ce8
        cmp #$a0
        bcs L_3ce4
        lda ($0b),y
        sta ($02),y
        iny 
        iny 
        lda ($0b),y
        sta ($02),y
        iny 
        lda ($0b),y
        eor $08
        adc $17
        sta ($02),y
    L_3ce1:
        iny 
        bne L_3cbe
    L_3ce4:
        dey 
        jmp $7c39
    L_3ce8:
        lda ($0b),y
        eor $08
        clc 
        adc $17
        sta ($02),y
        iny 
        bne L_3ce1
        cpx #$01
        bne L_3d00
        cpy #$1b
        bne L_3d0e
        ldx #$00
        ldy #$1c
    L_3d00:
        txa 
        bne L_3d21
        lda #$81
        sta $02fa
        ldx $18
        dec $57,x
        ldx #$00
    L_3d0e:
        lda #$a0
        sta $021b,x
        lda #$00
        sta $023e,x
        sta $0261,x
        cpy #$1b
        bcc L_3d2c
        bcs L_3d58
    L_3d21:
        lda #$00
        sta $021b,x
        cpy #$1b
        beq L_3d4b
        bcs L_3d58
    L_3d2c:
        jsr $75ec
    L_3d2f:
        lda $0200,y
        and #$03
        eor #$02
        lsr 
        ror 
        ror 
        ora #$3f
        sta $69
        lda #$a0
        sta $0200,y
        lda #$00
        sta $0223,y
        sta $0246,y
        rts 


    L_3d4b:
        txa 
        ldx $18
        dec $57,x
        tax 
        lda #$81
        sta $02fa
        bne L_3d2f
    L_3d58:
        lda $02f8
        sta $02f7
        lda $1c
        beq L_3d2f
        stx $0d
        ldx $19
        lda $021c
        lsr 
        lda #$99
        bcs L_3d70
        lda #$20
    L_3d70:
        jsr $7397
        ldx $0d
        jmp $6b4a
        lda $5c
        and #$03
        beq L_3d7f
    L_3d7e:
        rts 


    L_3d7f:
        lda $021c
        bmi L_3d7e
        beq L_3d89
        jmp $6c34
    L_3d89:
        lda $1c
        beq L_3d94
        lda $021b
        beq L_3d7e
        bmi L_3d7e
    L_3d94:
        lda $02f9
        beq L_3d9c
        dec $02f9
    L_3d9c:
        dec $02f7
        bne L_3d7e
        lda #$12
        sta $02f7
        lda $02f9
        beq L_3db5
        lda $02f6
        beq L_3d7e
        cmp $02fd
        bcs L_3d7e
    L_3db5:
        lda $02f8
        sec 
        sbc #$06
        cmp #$20
        bcc L_3dc2
        sta $02f8
    L_3dc2:
        lda #$00
        sta $02cb
        sta $0285
        jsr $77b5
        lsr 
        ror $02ee
        lsr 
        ror $02ee
        lsr 
        ror $02ee
        cmp #$18
        bcc L_3ddf
        and #$17
    L_3ddf:
        sta $02a8
        ldx #$10
        bit $60
        bvs L_3df4
        lda #$1f
        sta $0285
        lda #$ff
        sta $02cb
        ldx #$f0
    L_3df4:
        stx $023f
        ldx #$02
        lda $02f8
        bmi L_3e15
        ldy $19
    L_3e00:
        lda.a $0053,y
        cmp #$30
        bcs L_3e14
        jsr $77b5
        sta $08
        lda $02f8
        lsr 
        cmp $08
        bcs L_3e15
    L_3e14:
        dex 
    L_3e15:
        stx $021c
        rts 


        lda $5c
        asl 
        bne L_3e2a
        jsr $77b5
        and #$03
        tax 
        lda $6cd3,x
        sta $0262
    L_3e2a:
        lda $1c
        beq L_3e33
        lda $02fa
        bne L_3e38
    L_3e33:
        dec $02f7
        beq L_3e39
    L_3e38:
        rts 


    L_3e39:
        lda #$0a
        sta $02f7
        lda $021c
        lsr 
        beq L_3e4a
        jsr $77b5
        jmp $6cc4
    L_3e4a:
        lda $023f
        cmp #$80
        ror 
        sta $0c
        lda $02ca
        sec 
        sbc $02cb
        sta $0b
        lda $0284
        sbc $0285
        asl $0b
        rol 
        asl $0b
        rol 
        sec 
        sbc $0c
        tax 
        lda $0262
        cmp #$80
        ror 
        sta $0c
        lda $02ed
        sec 
        sbc $02ee
        sta $0b
        lda $02a7
        sbc $02a8
        asl $0b
        rol 
        asl $0b
        rol 
        sec 
        sbc $0c
        tay 
        jsr $76f0
        sta $62
        jsr $77b5
        ldx $19
        ldy $53,x
        cpy #$35
        ldx #$00
        bcc L_3e9f
        inx 
    L_3e9f:
        and $6ccf,x
        bpl L_3ea7
        ora $6cd1,x
    L_3ea7:
        adc $62
        sta $62
        ldy #$03
        ldx #$01
        stx $0e
        jmp $6cf2

        .byte $8f,$87,$70,$78,$f0,$00,$00,$10,$a5,$1c,$f0,$21,$0e,$04,$20,$66
        .byte $63,$24,$63,$10,$18,$70,$16,$ad,$fa,$02,$d0,$11,$aa,$a9,$03,$85
        .byte $0e,$a0,$07

    L_3ed7:
        lda $021b,y
        beq L_3ee2
        dey 
        cpy $0e
        bne L_3ed7
    L_3ee1:
        rts 


    L_3ee2:
        stx $0d
        lda #$12
        sta $021b,y
        lda $61,x
        jsr $77d2
        ldx $0d
        cmp #$80
        ror 
        sta $09
        clc 
        adc $023e,x
        bmi L_3f03
        cmp #$70
        bcc L_3f09
        lda #$6f
        bne L_3f09
    L_3f03:
        cmp #$91
        bcs L_3f09
        lda #$91
    L_3f09:
        sta $023e,y
        lda $61,x
        jsr $77d5
        ldx $0d
        cmp #$80
        ror 
        sta $0c
        clc 
        adc $0261,x
        bmi L_3f26
        cmp #$70
        bcc L_3f2c
        lda #$6f
        bne L_3f2c
    L_3f26:
        cmp #$91
        bcs L_3f2c
        lda #$91
    L_3f2c:
        sta $0261,y
        ldx #$00
        lda $09
        bpl L_3f36
        dex 
    L_3f36:
        stx $08
        ldx $0d
        cmp #$80
        ror 
        clc 
        adc $09
        clc 
        adc $02ca,x
        sta $02ca,y
        lda $08
        adc $0284,x
        sta $0284,y
        ldx #$00
        lda $0c
        bpl L_3f56
        dex 
    L_3f56:
        stx $0b
        ldx $0d
        cmp #$80
        ror 
        clc 
        adc $0c
        clc 
        adc $02ed,x
        sta $02ed,y
        lda $0b
        adc $02a7,x
        sta $02a7,y
        lda #$80
        sta $66,x
        rts 


        cld 
        lda $32
        and $33
        bpl L_3f7c
        rts 


    L_3f7c:
        lda $1a
        lsr 
        beq L_3f99
        ldy #$01
        jsr $77f6
        ldy #$02
        ldx $33
        bpl L_3f8d
        dey 
    L_3f8d:
        sty $18
        lda $5c
        and #$10
        bne L_3f99
        tya 
        jsr $7bd1
    L_3f99:
        lsr $18
        jsr $73b2
        ldy #$02
        jsr $77f6
        ldy #$03
        jsr $77f6
        ldy #$04
        jsr $77f6
        ldy #$05
        jsr $77f6
        lda #$20
        sta $00
        lda #$64
        ldx #$39
        jsr $7c03
        lda #$70
        jsr $7cde
        ldx $18
        ldy $32,x
        sty $0b
        tya 
        clc 
        adc $31
        sta $0c
        jsr $6f1a
        ldy $0b
        iny 
        jsr $6f1a
        ldy $0b
        iny 
        iny 
        jsr $6f1a
        lda L_1b81 + $482
        rol 
        rol $63
        lda $63
        and #$1f
        cmp #$07
        bne L_4013
        inc $31
        lda $31
        cmp #$03
        bcc L_4007
        ldx $18
        lda #$ff
        sta $32,x
    L_3ffa:
        ldx #$00
        stx $18
        stx $31
    L_4000:
        ldx #$f0
    L_4002:
        stx $5d
        jmp $73b2
    L_4007:
        inc $0c
        ldx $0c
        lda #$f4
        sta $5d
        lda #$0b
        sta $34,x
    L_4013:
        lda $5d
        bne L_401f
        lda #$ff
        sta $32
        sta $33
        bmi L_3ffa
    L_401f:
        lda $5c
        and #$07
        bne L_4056
        lda $2407
        bpl L_402e
        lda #$01
        bne L_4035
    L_402e:
        lda L_2406
        bpl L_4056
        lda #$ff
    L_4035:
        ldx $0c
        clc 
        adc $34,x
        bmi L_404c
        cmp #$0b
        bcs L_404e
    L_4040:
        cmp #$01
        beq L_4048
        lda #$00
        beq L_4054
    L_4048:
        lda #$0b
        bne L_4054
    L_404c:
        lda #$24
    L_404e:
        cmp #$25
        bcc L_4054
        lda #$00
    L_4054:
        sta $34,x
    L_4056:
        lda #$00
        rts 


        lda $1c
        beq L_40bc
        lda $021b
        bmi L_40bc
        lda $02fa
        bne L_40bc
        lda L_1b81 + $482
        bpl L_40bc
        lda #$00
        sta $021b
        sta $023e
        sta $0261
        lda #$30
        sta $02fa
        jsr $77b5
        and #$1f
        cmp #$1d
        bcc L_4087
        lda #$1c
    L_4087:
        cmp #$03
        bcs L_408d
        lda #$03
    L_408d:
        sta $0284
        ldx #$05
    L_4092:
        jsr $77b5
        dex 
        bne L_4092
        and #$1f
        inx 
        cmp #$18
        bcc L_40ab
        and #$07
        asl 
        adc #$04
        cmp $02f6
        bcc L_40ab
        ldx #$80
    L_40ab:
        cmp #$15
        bcc L_40b1
        lda #$14
    L_40b1:
        cmp #$03
        bcs L_40b7
        lda #$03
    L_40b7:
        sta $02a7
        stx $59
    L_40bc:
        rts 


        lda #$02
        sta $02f5
        ldx #$03
        lsr L_2802
        bcs L_40ca
        inx 
    L_40ca:
        stx $56
        lda #$00
        ldx #$04
    L_40d0:
        sta $021b,x
        sta $021f,x
        sta $51,x
        dex 
        bpl L_40d0
        sta $02f6
        rts 


        lda #$00
        sta $3600
        sta $3a00
        sta $3c00
        sta L_3c01
        sta $3c03
        sta L_3c04
        sta $3c05
        sta $69
        sta $66
        sta $67
        sta $68
        rts 


        lda.a $0034,y
        asl 
        tay 
        bne L_411a
        lda $32
        and $33
        bmi L_411a
        lda #$72
        ldx #$f8
        jsr $7d45
        lda #$01
        ldx #$f8
        jmp $7d45
    L_411a:
        ldx $56d5,y
        lda $56d4,y
        jmp $7d45
        beq L_413b
        sty $08
        ldx #$d5
        ldy #$e0
        sty $00
        jsr $7c03
    L_4130:
        ldx #$da
        lda #$54
        jsr $7bfc
        dec $08
        bne L_4130
    L_413b:
        rts 


        ldx #$22
    L_413e:
        lda $0200,x
        bne L_4147
    L_4143:
        dex 
        bpl L_413e
        rts 


    L_4147:
        bpl L_41ac
        jsr $7708
        lsr 
        lsr 
        lsr 
        lsr 
        cpx #$1b
        bne L_415b
        lda $5c
        and #$01
        lsr 
        beq L_415c
    L_415b:
        sec 
    L_415c:
        adc $0200,x
        bmi L_4186
        cpx #$1b
        beq L_4178
        bcs L_417e
        dec $02f6
        bne L_4171
        ldy #$7f
        sty $02fb
    L_4171:
        lda #$00
        sta $0200,x
        beq L_4143
    L_4178:
        jsr $71e8
        jmp $6f8c
    L_417e:
        lda $02f8
        sta $02f7
        bne L_4171
    L_4186:
        sta $0200,x
        and #$f0
        clc 
        adc #$10
        cpx #$1b
        bne L_4194
        lda #$00
    L_4194:
        tay 
        lda $02af,x
        sta $04
        lda $0269,x
        sta $05
        lda $02d2,x
        sta $06
        lda $028c,x
        sta $07
        jmp $7027
    L_41ac:
        clc 
        ldy #$00
        lda $0223,x
        bpl L_41b5
        dey 
    L_41b5:
        adc $02af,x
        sta $02af,x
        sta $04
        tya 
        adc $0269,x
        cmp #$20
        bcc L_41d1
        and #$1f
        cpx #$1c
        bne L_41d1
        jsr $702d
        jmp $6f5e
    L_41d1:
        sta $0269,x
        sta $05
        clc 
        ldy #$00
        lda $0246,x
        bpl L_41e0
        ldy #$ff
    L_41e0:
        adc $02d2,x
        sta $02d2,x
        sta $06
        tya 
        adc $028c,x
        cmp #$18
        bcc L_41f8
        beq L_41f6
        lda #$17
        bne L_41f8
    L_41f6:
        lda #$00
    L_41f8:
        sta $028c,x
        sta $07
        lda $0200,x
        ldy #$e0
        lsr 
        bcs L_420c
        ldy #$f0
        lsr 
        bcs L_420c
        ldy #$00
    L_420c:
        jsr $72fe
        jmp $6f5e
        lda $02f8
        sta $02f7
        lda #$00
        sta $021c
        sta $023f
        sta $0262
        rts 


        lda $1c
        beq L_426a
        lda $021b
        bmi L_426a
        lda $02fa
        beq L_426b
        dec $02fa
        bne L_426a
        ldy $59
        bmi L_4254
        bne L_424d
        jsr $7139
        bne L_4266
        ldy $021c
        beq L_424d
        ldy #$02
        sty $02fa
        rts 


    L_424d:
        lda #$01
        sta $021b
        bne L_4266
    L_4254:
        lda #$a0
        sta $021b
        ldx #$3e
        stx $69
        ldx $18
        dec $57,x
        lda #$81
        sta $02fa
    L_4266:
        lda #$00
        sta $59
    L_426a:
        rts 


    L_426b:
        lda $2407
        bpl L_4274
        lda #$03
        bne L_427b
    L_4274:
        lda L_2406
        bpl L_4280
        lda #$fd
    L_427b:
        clc 
        adc $61
        sta $61
    L_4280:
        lda $5c
        lsr 
        bcs L_426a
        lda $2405
        bpl L_42c6
        lda #$80
        sta $3c03
        ldy #$00
        lda $61
        jsr $77d2
        bpl L_4299
        dey 
    L_4299:
        asl 
        clc 
        adc $64
        tax 
        tya 
        adc $023e
        jsr $7125
        sta $023e
        stx $64
        ldy #$00
        lda $61
        jsr $77d5
        bpl L_42b4
        dey 
    L_42b4:
        asl 
        clc 
        adc $65
        tax 
        tya 
        adc $0261
        jsr $7125
        sta $0261
        stx $65
        rts 


    L_42c6:
        lda #$00
        sta $3c03
        lda $023e
        ora $64
        beq L_42ea
        lda $023e
        asl 
        ldx #$ff
        clc 
        eor #$ff
        bmi L_42df
        inx 
        sec 
    L_42df:
        adc $64
        sta $64
        txa 
        adc $023e
        sta $023e
    L_42ea:
        lda $65
        ora $0261
        beq L_4309
        lda $0261
        asl 
        ldx #$ff
        clc 
        eor #$ff
        bmi L_42fe
        sec 
        inx 
    L_42fe:
        adc $65
        sta $65
        txa 
        adc $0261
        sta $0261
    L_4309:
        rts 


        bmi L_4315
        cmp #$40
        bcc L_431d
        ldx #$ff
        lda #$3f
        rts 


    L_4315:
        cmp #$c0
        bcs L_431d
        ldx #$01
        lda #$c0
    L_431d:
        rts 


        ldx #$1c
    L_4320:
        lda $0200,x
        beq L_4343
        lda $0269,x
        sec 
        sbc $0284
        cmp #$04
        bcc L_4334
        cmp #$fc
        bcc L_4343
    L_4334:
        lda $028c,x
        sec 
        sbc $02a7
        cmp #$04
        bcc L_4348
        cmp #$fc
        bcs L_4348
    L_4343:
        dex 
        bpl L_4320
        inx 
        rts 


    L_4348:
        inc $02fa
        rts 



        .byte $90,$a2,$1a,$ad,$fb,$02,$d0,$70,$ad,$1c,$02,$d0,$73,$8d,$3f,$02
        .byte $8d,$62,$02,$ee,$fd,$02,$ad,$fd,$02,$c9,$0b,$90,$03,$ce,$fd,$02

    L_436c:
        lda $02f5
        clc 
        adc #$02
        cmp #$0b
        bcc L_4378
        lda #$0b
    L_4378:
        sta $02f6
        sta $02f5
        sta $08
        ldy #$1c
    L_4382:
        jsr $77b5
        and #$18
        ora #$04
        sta $0200,x
        jsr $7203
        jsr $77b5
        lsr 
        and #$1f
        bcc L_43aa
        cmp #$18
        bcc L_439d
        and #$17
    L_439d:
        sta $028c,x
        lda #$00
        sta $0269,x
        sta $02af,x
        beq L_43b5
    L_43aa:
        sta $0269,x
        lda #$00
        sta $028c,x
        sta $02d2,x
    L_43b5:
        dex 
        dec $08
        bne L_4382
        lda #$7f
        sta $02f7
        lda #$30
        sta $02fc
    L_43c4:
        lda #$00
    L_43c6:
        sta $0200,x
        dex 
        bpl L_43c6
    L_43cc:
        rts 


        lda #$60
        sta $02ca
        sta $02ed
        lda #$00
        sta $023e
        sta $0261
        lda #$10
        sta $0284
        lda #$0c
        sta $02a7
        rts 


        jsr $77b5
        and #$8f
        bpl L_43f1
        ora #$f0
    L_43f1:
        clc 
        adc $0223,y
        jsr $7233
        sta $0223,x
        jsr $77b5
        jsr $77b5
        jsr $77b5
        jsr $77b5
        and #$8f
        bpl L_440d
        ora #$f0
    L_440d:
        clc 
        adc $0246,y
        jsr $7233
        sta $0246,x
        rts 


        bpl L_4427
        cmp #$e1
        bcs L_4420
        lda #$e1
    L_4420:
        cmp #$fb
        bcc L_4433
        lda #$fa
        rts 


    L_4427:
        cmp #$06
        bcs L_442d
        lda #$06
    L_442d:
        cmp #$20
        bcc L_4433
        lda #$1f
    L_4433:
        rts 


        lda #$10
        sta $00
        lda #$50
        ldx #$a4
        jsr $7bfc
        lda #$19
        ldx #$db
        jsr $7c03
        lda #$70
        jsr $7cde
        ldx #$00
        lda $1c
        cmp #$02
        bne L_446b
        lda $18
        bne L_446b
        ldx #$20
        lda $021b
        ora $59
        bne L_446b
        lda $02fa
        bmi L_446b
        lda $5c
        and #$10
        beq L_4478
    L_446b:
        lda #$52
        ldy #$02
        sec 
        jsr $773f
        lda #$00
        jsr $778b
    L_4478:
        lda #$28
        ldy $57
        jsr $6f3e
        lda #$00
        sta $00
        lda #$78
        ldx #$db
        jsr $7c03
        lda #$50
        jsr $7cde
        lda #$1d
        ldy #$02
        sec 
        jsr $773f
        lda #$00
        jsr $7bd1
        lda #$10
        sta $00
        lda #$c0
        ldx #$db
        jsr $7c03
        lda #$50
        jsr $7cde
        ldx #$00
        lda $1c
        cmp #$01
        beq L_44e2
        bcc L_44ce
        lda $18
        beq L_44ce
        ldx #$20
        lda $021b
        ora $59
        bne L_44ce
        lda $02fa
        bmi L_44ce
        lda $5c
        and #$10
        beq L_44db
    L_44ce:
        lda #$54
        ldy #$02
        sec 
        jsr $773f
        lda #$00
        jsr $778b
    L_44db:
        lda #$cf
        ldy $58
        jmp $6f3e
    L_44e2:
        rts 


        sty $00
        stx $0d
        lda $05
        lsr 
        ror $04
        lsr 
        ror $04
        lsr 
        ror $04
        sta $05
        lda $07
        clc 
        adc #$04
        lsr 
        ror $06
        lsr 
        ror $06
        lsr 
        ror $06
        sta $07
        ldx #$04
        jsr $7c1c
        lda #$70
        sec 
        sbc $00
        cmp #$a0
        bcc L_4520
    L_4512:
        pha 
        lda #$90
        jsr $7cde
        pla 
        sec 
        sbc #$10
        cmp #$a0
        bcs L_4512
    L_4520:
        jsr $7cde
        ldx $0d
        lda $0200,x
        bpl L_4540
        cpx #$1b
        beq L_453a
        and #$0c
        lsr 
        tay 
        lda L_50f8,y
        ldx $50f9,y
        bne L_4555
    L_453a:
        jsr $7465
        ldx $0d
        rts 


    L_4540:
        cpx #$1b
        beq L_455b
    L_4544:
        cpx #$1c
        beq L_4561
        bcs L_4569
        and #$18
        lsr 
        lsr 
        tay 
        lda L_51da + $4,y
        ldx L_51da + $5,y
    L_4555:
        jsr $7d45
        ldx $0d
        rts 


    L_455b:
        jsr $750b
        ldx $0d
        rts 


    L_4561:
        lda $5250
        ldx $5251
        bne L_4555
    L_4569:
        lda #$70
    L_456b:
        ldx #$f0
        jsr $7ce0
        ldx $0d
        lda $5c
        and #$03
        bne L_457b
        dec $0200,x
    L_457b:
        rts 


        sed 
        adc $52,x
        sta $52,x
        bcc L_4595
        lda $53,x
        adc #$00
        sta $53,x
        and #$0f
        bne L_4595
        lda #$b0
        sta $68
        ldx $18
        inc $57,x
    L_4595:
        cld 
        rts 


        lda $18
        asl 
        asl 
        sta $08
        lda $6f
        and #$fb
        ora $08
        sta $6f
        sta L_31ff + $1
        rts 


        lda $1c
        beq L_45af
    L_45ad:
        clc 
        rts 


    L_45af:
        lda $5d
        and #$04
        bne L_45ad
        lda $1d
        ora $1e
        beq L_45ad
        ldy #$00
        jsr $77f6
        ldx #$00
        stx $10
        lda #$01
        sta $00
        lda #$a7
        sta $0e
        lda #$10
        sta $00
    L_45d0:
        lda $1d,x
        ora $1e,x
        beq L_463d
        stx $0f
        lda #$5f
        ldx $0e
        jsr $7c03
        lda #$40
        jsr $7cde
        lda $0f
        lsr 
        sed 
        adc #$01
        cld 
        sta $0d
        lda #$0d
        sec 
        ldy #$01
        ldx #$00
        jsr $773f
        lda #$40
        tax 
        jsr $7ce0
        ldy #$00
        jsr $6f35
        lda $0f
        clc 
        adc #$1d
        ldy #$02
        sec 
        ldx #$00
        jsr $773f
        lda #$00
        jsr $7bd1
        ldy #$00
        jsr $6f35
        ldy $10
        jsr $6f1a
        inc $10
        ldy $10
        jsr $6f1a
        inc $10
        ldy $10
        jsr $6f1a
        inc $10
        lda $0e
        sec 
        sbc #$08
        sta $0e
        ldx $0f
        inx 
        inx 
        cpx #$14
        bcc L_45d0
    L_463d:
        sec 
        rts 


        ldx #$1a
    L_4641:
        lda $0200,x
        beq L_4649
        dex 
        bpl L_4641
    L_4649:
        rts 


        lda $021b
        cmp #$a2
        bcs L_4673
        ldx #$0a
    L_4653:
        lda L_50ec,x
        lsr 
        lsr 
        lsr 
        lsr 
        clc 
        adc #$f8
        eor #$f8
        sta $7e,x
        lda $50ed,x
        lsr 
        lsr 
        lsr 
        lsr 
        clc 
        adc #$f8
        eor #$f8
        sta $8a,x
        dex 
        dex 
        bpl L_4653
    L_4673:
        lda $021b
        eor #$ff
        and #$70
        lsr 
        lsr 
        lsr 
        tax 
    L_467e:
        stx $09
        ldy #$00
        lda L_50ec,x
        bpl L_4688
        dey 
    L_4688:
        clc 
        adc $7d,x
        sta $7d,x
        tya 
        adc $7e,x
        sta $7e,x
        sta $04
        sty $05
        ldy #$00
        lda $50ed,x
        bpl L_469e
        dey 
    L_469e:
        clc 
        adc $89,x
        sta $89,x
        tya 
        adc $8a,x
        sta $8a,x
        sta $06
        sty $07
        lda $02
        sta $0b
        lda $03
        sta $0c
        jsr $7c49
        ldy $09
        lda L_50e0,y
        ldx $50e1,y
        jsr $7d45
        ldy $09
        lda $50e1,y
        eor #$04
        tax 
        lda L_50e0,y
        and #$0f
        eor #$04
        jsr $7d45
        ldy #$ff
    L_46d6:
        iny 
        lda ($0b),y
        sta ($02),y
        iny 
        lda ($0b),y
        eor #$04
        sta ($02),y
        cpy #$03
        bcc L_46d6
        jsr $7c39
        ldx $09
        dex 
        dex 
        bpl L_467e
        rts 


        ldx #$00
        stx $17
        ldy #$00
        lda $61
        bpl L_4700
        ldy #$04
        txa 
        sec 
        sbc $61
    L_4700:
        sta $08
        bit $08
        bmi L_4708
        bvc L_470f
    L_4708:
        ldx #$04
        lda #$80
        sec 
        sbc $08
    L_470f:
        stx $08
        sty $09
        lsr 
        and #$fe
        tay 
        lda $526e,y
        ldx $526f,y
        jsr $6ad3
    L_4720:
        lda $2405
        bpl L_4739
        lda $5c
        and #$04
        beq L_4739
        iny 
        iny 
        sec 
        ldx $0c
        tya 
        adc $0b
        bcc L_4736
        inx 
    L_4736:
        jsr $6ad3
    L_4739:
        rts 


        lda $1c
        bne L_473f
        rts 


    L_473f:
        ldx #$00
        lda $021c
        bmi L_4750
        beq L_4750
        ror 
        ror 
        ror 
        sta $3c02
        ldx #$80
    L_4750:
        stx $3c00
        ldx #$01
        jsr $75cd
        sta L_3c01
        dex 
        jsr $75cd
        sta L_3c04
        lda $021b
        cmp #$01
        beq L_476d
        txa 
        sta $3c03
    L_476d:
        lda $02f6
        beq L_4783
        lda $021b
        bmi L_4783
        ora $59
        beq L_4783
        lda $6d
        beq L_4793
        dec $6d
        bne L_47a4
    L_4783:
        lda $6c
        and #$0f
        sta $6c
        sta $3a00
        lda $02fc
        sta $6e
        bpl L_47a4
    L_4793:
        dec $6e
        bne L_47a4
        lda #$04
        sta $6d
        lda $6c
        eor #$14
        sta $6c
        sta $3a00
    L_47a4:
        lda $69
        tax 
        and #$3f
        beq L_47ac
        dex 
    L_47ac:
        stx $69
        stx $3600
        rts 


        lda $6a,x
        bmi L_47c2
        lda $66,x
        bpl L_47cc
        lda #$10
        sta $66,x
    L_47be:
        lda #$80
        bmi L_47ce
    L_47c2:
        lda $66,x
        beq L_47cc
        bmi L_47cc
        dec $66,x
        bne L_47be
    L_47cc:
        lda #$00
    L_47ce:
        sta $6a,x
        rts 


        stx $0d
        lda #$50
        sta $02f9
        lda $0200,y
        and #$78
        sta $0e
        lda $0200,y
        and #$07
        lsr 
        tax 
        beq L_47ea
        ora $0e
    L_47ea:
        sta $0200,y
        lda $1c
        beq L_4802
        lda $0d
        beq L_47f9
        cmp #$04
        bcc L_4802
    L_47f9:
        lda $7659,x
        ldx $19
        clc 
        jsr $7397
    L_4802:
        ldx $0200,y
        beq L_483b
        jsr $745a
        bmi L_483b
        inc $02f6
        jsr $6a9d
        jsr $7203
        lda $0223,x
        and #$1f
        asl 
        eor $02af,x
        sta $02af,x
        jsr $745c
        bmi L_483b
        inc $02f6
        jsr $6a9d
        jsr $7203
        lda $0246,x
        and #$1f
        asl 
        eor $02d2,x
        sta $02d2,x
    L_483b:
        ldx $0d
        rts 



        .byte $10,$05,$02,$a5,$1c

    L_4843:
        bpl L_487d
        ldx #$02
        sta $5d
        sta $32
        sta $33
    L_484d:
        ldy #$00
    L_484f:
        lda.a $001d,y
        cmp $52,x
    L_4854:
        lda.a $001e,y
        sbc $53,x
        bcc L_487e
        iny 
        iny 
        cpy #$14
        bcc L_484f
        dex 
        dex 
        bpl L_484d
        lda $33
        bmi L_4877
        cmp $32
        bcc L_4877
        adc #$02
        cmp #$1e
        bcc L_4875
        lda #$ff
    L_4875:
        sta $33
    L_4877:
        lda #$00
        sta $1c
        sta $31
    L_487d:
        rts 



    L_487e:
         .byte $86,$0b,$84,$0c,$8a,$4a,$aa,$98,$4a,$65,$0c,$85,$0d,$95,$32,$a2
        .byte $1b,$a0,$12,$e4,$0d,$f0,$1f,$b5,$31,$95,$34,$b5,$32,$95,$35,$b5
        .byte $33,$95,$36,$b9,$1b,$00,$99,$1d,$00,$b9,$1c,$00,$99,$1e,$00,$88
        .byte $88,$ca,$ca,$ca,$d0,$dd,$a9,$0b,$95,$34,$a9,$00,$95,$35,$95,$36
        .byte $a9,$f0,$85,$5d,$a6,$0b,$a4,$0c,$b5,$53,$99,$1e,$00,$b5,$52,$99
        .byte $1d,$00,$a0,$00,$f0,$8d,$df,$98,$10,$09,$20,$08,$77,$20,$fc,$76
        .byte $4c,$08,$77

    L_48e1:
        tay 
        txa 
        bpl L_48f3
        jsr $7708
        jsr $770e
        eor #$80
        eor #$ff
        clc 
        adc #$01
        rts 


    L_48f3:
        sta $0c
        tya 
        cmp $0c
        beq L_490a
        bcc L_490d
        ldy $0c
        sta $0c
        tya 
        jsr $7728
        sec 
        sbc #$40
        jmp $7708
    L_490a:
        lda #$20
        rts 


    L_490d:
        jsr $776c
        lda $772f,x
        rts 



        .byte $00,$02,$05,$07,$0a,$0c,$0f,$11,$13,$15,$17,$19,$1a,$1c,$1d,$1f
        .byte $08,$86,$17,$88,$84,$16,$18,$65,$16,$85,$15,$28,$aa

    L_4931:
        php 
        lda $00,x
        lsr 
        lsr 
        lsr 
        lsr 
        plp 
        jsr $7785
        lda $16
        bne L_4941
        clc 
    L_4941:
        ldx $15
        lda $00,x
        jsr $7785
        dec $15
        ldx $15
        dec $16
        bpl L_4931
        rts 


        ldy #$00
        sty $0b
        ldy #$04
    L_4957:
        rol $0b
        rol 
        cmp $0c
        bcc L_4960
        sbc $0c
    L_4960:
        dey 
        bne L_4957
        lda $0b
        rol 
    L_4966:
        and #$0f
        tax 
        rts 


        bcc L_4970
        and #$0f
        beq L_4997
    L_4970:
        ldx $17
    L_4972:
        beq L_4997
        and #$0f
        clc 
        adc #$01
        php 
        asl 
        tay 
        lda $56d4,y
        asl 
        sta $0b
        lda $56d5,y
        rol 
        and #$1f
        ora #$40
        sta $0c
        lda #$00
        sta $08
        sta $09
        jsr $6ad7
        plp 
        rts 


    L_4997:
        jmp $7bcb
        asl $5f
        rol $60
        bpl L_49a2
        inc $5f
    L_49a2:
        lda $5f
        bit $77d1
        beq L_49ad
        eor #$01
        sta $5f
    L_49ad:
        ora $60
        bne L_49b3
        inc $5f
    L_49b3:
        lda $5f
        rts 



        .byte $02,$18,$69,$40,$10,$08,$29,$7f,$20,$df,$77,$4c,$08,$77

    L_49c4:
        cmp #$41
        bcc L_49cc
        eor #$7f
        adc #$00
    L_49cc:
        tax 
        lda $57b9,x
        rts 



        .byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$ad,$03,$28,$29,$03,$0a
        .byte $aa,$a9,$10,$85,$00,$bd,$88,$78,$85,$09,$bd,$87,$78,$85,$08,$71
        .byte $08,$85,$08,$90,$02,$e6,$09

    L_49f8:
        tya 
        asl 
        tay 
        lda $7871,y
        ldx $7872,y
        jsr $7c03
        lda #$70
        jsr $7cde
        ldy #$00
        ldx #$00
    L_4a0d:
        lda ($08,x)
        sta $0b
        lsr 
        lsr 
        jsr $784d
        lda ($08,x)
        rol 
        rol $0b
        rol 
        lda $0b
        rol 
        asl 
        jsr $7853
        lda ($08,x)
        sta $0b
        jsr $784d
        lsr $0b
        bcc L_4a0d
    L_4a2e:
        dey 
        jmp $7c39
        inc $08
        bne L_4a38
        inc $09
    L_4a38:
        and #$3e
        bne L_4a40
        pla 
        pla 
        bne L_4a2e
    L_4a40:
        cmp #$0a
        bcc L_4a46
        adc #$0d
    L_4a46:
        tax 
        lda $56d2,x
        sta ($02),y
        iny 
        lda $56d3,x
        sta ($02),y
        iny 
        ldx #$00
        rts 



        .byte $64,$b6,$64,$b6,$0c,$aa,$0c,$a2,$0c,$9a,$0c,$92,$64,$c6,$64,$9d
        .byte $50,$39,$50,$39,$50,$39

    L_4a6c:
        asl $8f57,x
        sei 
        lsr $79

        .byte $f3,$79,$0b,$15,$1b,$35,$4d,$65,$7f,$8d,$93,$9f,$ab,$64,$d2,$3b
        .byte $2e,$c2,$6c,$5a,$4c,$93,$6f,$bd,$1a,$4c,$12,$b0,$40,$6b,$2c,$0a
        .byte $6c,$5a,$4c,$93,$6e,$0b,$6e,$c0,$52,$6c,$92,$b8,$50,$4d,$82,$f2
        .byte $58

    L_4aa3:
        bcc L_4af1
    L_4aa5:
        eor SCREEN_BUFFER_2 + $f0

        .byte $80,$33,$70,$c2,$42,$5a,$4c,$4c,$82,$bb,$52,$0b,$58,$b2,$42,$6c
        .byte $9a,$c3,$4a,$82,$64,$0a,$5a,$90,$00

    L_4ac1:
        inc $6c,x
        ora #$b2

        .byte $3b,$2e,$c1,$4c,$4c,$b6,$2b,$20,$0d,$a6

    L_4acf:
        .byte $c1,$70,$48,$50,$b6,$52,$3b,$d2,$90,$00,$da,$64,$90,$4c
        .byte $c9,$d8,$be,$0a,$32,$42,$9b,$c2,$67,$68,$4d,$ae,$a1,$4e,$48,$50
        .byte $b6,$52,$3b,$d2

    L_4af1:
        bcc L_4af3
    L_4af3:
        ldx $b60a,y
        asl $d294,x
    L_4af9:
        ldx #$92
        asl 
        bit SCREEN_BUFFER_2 + $2ca

        .byte $7a,$65,$bd,$1a,$4c,$12,$92,$13,$18,$62,$ca,$64,$f2,$42,$20,$6e
        .byte $a3,$52,$82,$40,$18,$62,$ca,$64,$f2,$42,$18,$6e,$a3,$52,$80,$00
        .byte $20,$62,$ca,$64,$f2,$64,$08,$c2,$bd,$1a,$4c,$00,$0b,$15,$19,$31
        .byte $41,$57,$73,$7f,$89,$95,$a1,$8a,$5a,$84,$12,$cd,$82,$b9,$e6,$b2
        .byte $40

    L_4b40:
        .byte $74,$f2
        .byte $4d,$83,$d4,$f0,$b2,$42,$b9,$e6,$b2,$42,$4d,$f0,$0e,$64,$0a,$12
        .byte $b8,$46,$10,$62,$4b,$60,$82,$72,$b5,$c0,$be,$a8,$0a,$64,$c5,$92
        .byte $f0,$74,$9d,$c2,$6c,$9a,$c3,$4a,$82,$6f,$a4,$f2,$bd,$d2,$f0,$6c
        .byte $9e,$0a,$c2,$42,$a4,$f2,$b0,$74,$9d,$c2,$6c,$9a,$c3,$4a,$82,$6f
        .byte $a4,$f2,$bd,$d2,$f0,$58,$ed,$12,$b5,$e8,$29,$d2,$0d,$72,$2c,$90
        .byte $0c,$12,$c6,$2c,$48,$4e,$9d,$ac,$49,$f0,$48,$00,$2d,$28,$cf,$52
        .byte $b0,$6e,$cd,$82,$be,$0a,$b6,$00,$53,$64,$0a,$12,$0d,$0a,$b6,$1a
        .byte $48,$00,$18,$68,$6a,$4e,$48,$48,$0b,$a6,$ca,$72,$b5,$c0,$18,$68
        .byte $6a,$4e,$48,$46,$0b,$a6,$ca,$72,$b0,$00

    L_4bcc:
        jsr $6a68

        .byte $4e,$4d,$c2,$18,$5c,$9e,$52,$cd,$80,$0b,$11,$17,$31,$45,$5f,$6b
        .byte $73,$7d,$89,$93,$b2,$4e,$9d,$90,$b8,$00,$76,$56,$2a,$26,$b0

    L_4bee:
        rti 

        .byte $be,$42,$a6,$64,$c1,$5c,$48,$52,$be,$0a,$0a,$64,$c5,$92,$0c,$26
        .byte $b8,$50,$6a,$7c,$0c,$52,$74,$ec,$4d,$c0,$a4,$ec,$0a,$8a,$d4,$ec
        .byte $0a,$64,$c5,$92,$0d,$f2,$b8,$5a,$93,$4e,$69,$60,$4d,$c0,$9d,$2c
        .byte $6c,$4a,$0d,$a6,$c1,$70,$48,$68,$2d,$8a,$0d,$d2,$82,$4e,$3b,$66
        .byte $91,$6c,$0c,$0a,$0c,$12,$c5,$8b,$9d,$2c,$6c,$4a,$0b,$3a,$a2,$6c
        .byte $bd,$0a,$3a,$40,$a6,$60,$b9,$6c,$0d,$f0,$2d,$b1,$76

    L_4c4c:
        .byte $52,$5c,$c2,$c2
        .byte $6c,$8b,$64,$2a,$27,$18,$54,$69,$d8,$28,$48,$0b,$b2,$4a,$e6,$b8
        .byte $00,$18,$54,$69,$d8,$28,$46,$0b,$b2,$4a,$e7,$20,$54,$69

    L_4c6e:
        .byte $d8,$2d,$c2,$18,$5c
        .byte $ca,$56,$98,$00,$52,$a2,$02,$bd,$00,$24,$0a,$b5,$7a,$29,$1f,$90
        .byte $37,$f0,$10,$c9,$1b,$b0,$0a,$a8,$a5,$5e,$29,$07,$c9,$07,$98,$90
        .byte $02

    L_4c94:
        sbc #$01
    L_4c96:
        sta $7a,x
        lda L_1b81 + $485
        and #$80
        beq L_4ca3
        lda #$f0
        sta $72
    L_4ca3:
        lda $72
        beq L_4caf
        dec $72
        lda #$00
        sta $7a,x
        sta $77,x
    L_4caf:
        clc 
        lda $77,x
        beq L_4cd7
        dec $77,x
        bne L_4cd7
        sec 
        bcs L_4cd7
    L_4cbb:
        cmp #$1b
        bcs L_4cc8
        lda $7a,x
        adc #$20
        bcc L_4c96
        beq L_4cc8
        clc 
    L_4cc8:
        lda #$1f
        bcs L_4c96
        sta $7a,x
        lda $77,x
        beq L_4cd3
        sec 
    L_4cd3:
        lda #$78
        sta $77,x
    L_4cd7:
        bcc L_4cfc
        lda #$00
        cpx #$01
        bcc L_4cf5
        beq L_4ced
        lda $71
        and #$0c
        lsr 
        lsr 
        beq L_4cf5
        adc #$02
        bne L_4cf5
    L_4ced:
        lda $71
        and #$10
        beq L_4cf5
        lda #$01
    L_4cf5:
        sec 
        adc $73
        sta $73
        inc $74,x
    L_4cfc:
        dex 
        bmi L_4d02
        jmp $7a95
    L_4d02:
        lda $71
        and #$03
        tay 
        beq L_4d1b
        lsr 
        adc #$00
        eor #$ff
        sec 
        adc $73
        bcc L_4d1d
        cpy #$02
        bcs L_4d19
        inc $70
    L_4d19:
        inc $70
    L_4d1b:
        sta $73
    L_4d1d:
        lda $5e
        lsr 
        bcs L_4d49
        ldy #$00
        ldx #$02
    L_4d26:
        lda $74,x
        beq L_4d33
        cmp #$10
        bcc L_4d33
        adc #$ef
        iny 
        sta $74,x
    L_4d33:
        dex 
        bpl L_4d26
        tya 
        bne L_4d49
        ldx #$02
    L_4d3b:
        lda $74,x
        beq L_4d46
        clc 
        adc #$ef
        sta $74,x
        bmi L_4d49
    L_4d46:
        dex 
        bpl L_4d3b
    L_4d49:
        rts 


        pha 
        tya 
    L_4d4c:
        pha 
        txa 
        pha 
        cld 
        lda $01ff
        ora $01d0
    L_4d56:
        bne L_4d56
        inc $5e
        lda $5e
        and #$03
        bne L_4d68
        inc $5b
        lda $5b
        cmp #$04
    L_4d66:
        bcs L_4d66
    L_4d68:
        jsr $7a93
        lda $6f
        and #$c7
        bit $74
        bpl L_4d75
        ora #$08
    L_4d75:
        bit $75
        bpl L_4d7b
        ora #$10
    L_4d7b:
        bit $76
        bpl L_4d81
        ora #$20
    L_4d81:
        sta $6f
        sta L_31ff + $1
        lda $72
        beq L_4d8e
        lda #$80
        bne L_4d9c
    L_4d8e:
        lda $68
        beq L_4d9c
        lda $5c
        ror 
        bcc L_4d99
        dec $68
    L_4d99:
        ror 
        ror 
        ror 
    L_4d9c:
        sta $3c05
        pla 
        tax 
        pla 
        tay 
        pla 
        rti 
        lda #$b0
        ldy #$00
        sta ($02),y
        iny 
        sta ($02),y
        bne L_4e1e
        bcc L_4db6
        and #$0f
        beq L_4dbb
    L_4db6:
        and #$0f
        clc 
        adc #$01
    L_4dbb:
        php 
        asl 
        ldy #$00
        tax 
        lda $56d4,x
        sta ($02),y
        lda $56d5,x
        iny 
        sta ($02),y
        jsr $7c39
        plp 
        rts 


        lsr 
        and #$0f
        ora #$e0
    L_4dd5:
        ldy #$01
        sta ($02),y
        dey 
        txa 
        ror 
        sta ($02),y
        iny 
        bne L_4e1e
        lsr 
        and #$0f
        ora #$c0
        bne L_4dd5
        ldy #$00
        sty $05
        sty $07
        asl 
        rol $05
        asl 
        rol $05
        sta $04
        txa 
        asl 
        rol $07
        asl 
        rol $07
        sta $06
        ldx #$04
        lda $02,x
        ldy #$00
        sta ($02),y
        lda $03,x
        and #$0f
        ora #$a0
        iny 
        sta ($02),y
        lda $00,x
        iny 
        sta ($02),y
        lda $01,x
        and #$0f
        ora $00
        iny 
        sta ($02),y
    L_4e1e:
        tya 
        sec 
    L_4e20:
        adc $02
        sta $02
        bcc L_4e28
        inc $03
    L_4e28:
        rts 


        lda #$d0
        jmp $7bc2
        lda $05
        cmp #$80
        bcc L_4e45
        eor #$ff
        sta $05
        lda $04
        eor #$ff
        adc #$00
        sta $04
        bcc L_4e44
        inc $05
    L_4e44:
        sec 
    L_4e45:
        rol $08
        lda $07
    L_4e49:
        cmp #$80
        bcc L_4e5e
        eor #$ff
        sta $07
        lda $06
        eor #$ff
        adc #$00
        sta $06
        bcc L_4e5d
        inc $07
    L_4e5d:
        sec 
    L_4e5e:
        rol $08
        lda $05
        ora $07
        beq L_4e70
        ldx #$00
        cmp #$02
        bcs L_4e90
        ldy #$01
        bne L_4e80
    L_4e70:
        ldy #$02
        ldx #$09
        lda $04
        ora $06
        beq L_4e90
        bmi L_4e80
    L_4e7c:
        iny 
        asl 
        bpl L_4e7c
    L_4e80:
        tya 
        tax 
        lda $05
    L_4e84:
        asl $04
        rol 
        asl $06
        rol $07
        dey 
        bne L_4e84
        sta $05
    L_4e90:
        txa 
        sec 
        sbc #$0a
        eor #$ff
        asl 
        ror $08
        rol 
        ror $08
        rol 
        asl 
        sta $08
        ldy #$00
        lda $06
        sta ($02),y
        lda $08
        and #$f4
        ora $07
        iny 
        sta ($02),y
        lda $04
        iny 
        sta ($02),y
        lda $08
        and #$02
        asl 
        ora $01
        ora $05
        iny 
        sta ($02),y
        jmp $7c39
        ldx #$00
        ldy #$01
        sta ($02),y
        dey 
        tya 
        sta ($02),y
        iny 
        iny 
        sta ($02),y
        iny 
        txa 
        sta ($02),y
        jmp $7c39
        ldx #$fe
        txs 
        cld 
        lda #$00
        tax 
    L_4edf:
        dex 
        sta $0300,x
        sta $0200,x
        sta $0100,x
        sta $00,x
        bne L_4edf
        ldy L_1b81 + $486
        bmi L_4f35
        inx 
        stx L_4000
        lda #$e2
        sta $4001
        lda #$b0
        sta $4003
        sta $32
        sta $33
        lda #$03
        sta $6f
        sta L_31ff + $1
        and $2800
        sta $71
        lda $2801
        and #$03
        asl 
        asl 
        ora $71
        sta $71
        lda L_2802
        and #$02
        asl 
        asl 
        asl 
        ora $71
        sta $71
        jmp $6803
        ldy #$00
        sta ($02),y
        iny 
        txa 
        sta ($02),y
        jmp $7c39

    L_4f35:
         .byte $9d,$00,$40,$9d,$00,$41,$9d,$00,$42,$9d,$00,$43,$9d,$00,$44,$9d

    L_4f45:
        .byte $00,$45,$9d,$00,$46,$9d,$00,$47,$e8,$d0,$e5,$8d,$00,$34,$a2,$00

    L_4f55:
        .byte $b5,$00,$d0,$47,$a9,$11,$95,$00,$a8,$55,$00,$d0,$3e,$98,$0a,$90
        .byte $f5,$e8,$d0,$ec,$8d,$00,$34,$8a,$85,$00,$2a,$85,$01,$a0,$00,$a2
        .byte $11,$b1,$00,$d0,$2a,$8a,$91,$00,$51,$00,$d0,$23,$8a,$0a,$aa,$90
        .byte $f4,$c8,$d0,$eb,$8d,$00,$34,$e6,$01,$a6,$01,$e0,$04,$90,$e0,$a9
        .byte $40,$e0,$40,$90,$d6,$e0,$48,$90,$d6,$b0,$69,$a0,$00,$f0,$0e,$a0
        .byte $00,$a6,$01,$e0,$04,$90,$06,$c8,$e0,$44,$90,$01,$c8,$c9,$10,$2a
        .byte $29,$1f,$c9,$02,$2a,$29,$03,$88,$30,$04,$0a,$0a,$90,$f9,$4a,$a2
        .byte $14,$90,$02,$a2,$1d,$8e,$00,$3a,$a2,$00,$a0,$08,$2c,$01,$20,$10
        .byte $fb,$2c,$01,$20,$30,$fb,$ca,$8d,$00,$34,$d0,$f0,$88,$d0,$ed,$8e
        .byte $00,$3a,$a0,$08,$2c,$01,$20,$10,$fb,$2c,$01,$20,$30,$fb,$ca,$8d

    L_4ff5:
        .byte $00,$34,$d0,$f0,$88,$d0,$ed,$aa,$d0,$c4,$8d,$00,$34,$ad,$07,$20
        .byte $30,$f8,$10,$fe,$a9,$00,$a8,$aa,$85,$08,$a9,$50,$85,$09,$a9,$04
        .byte $85,$0b,$a9,$ff,$51,$08,$c8,$d0,$fb,$e6,$09,$c6,$0b,$d0,$f5,$95
        .byte $0d,$e8,$8d,$00,$34,$a5,$09,$c9,$58,$90,$e1,$d0,$02,$a9,$68,$c9
        .byte $80,$90,$d9,$8d,$00,$03,$a2,$04,$8e,$00,$32,$86,$15,$a2,$00,$cd

    L_5045:
        .byte $00,$02,$f0,$01,$e8,$ad,$00,$03,$c9,$88,$f0,$01,$e8,$86,$16,$a9
        .byte $10,$85,$00,$a2,$24,$ad,$01,$20,$10,$fb,$ad,$01,$20,$30,$fb,$ca
        .byte $10,$f3,$2c,$02,$20,$30,$fb,$8d,$00,$34,$a9,$00,$85,$02,$a9,$40
        .byte $85,$03,$ad,$05,$20,$10,$5b

    L_507c:
        ldx $15
        lda L_1b81 + $482
    L_5081:
        bpl L_508d
        eor.a $0009
        bpl L_508d
        dex 
        beq L_508d
        stx $15
    L_508d:
        ldy $7ebb,x
        lda #$b0
        sta ($02),y
        dey 
        dey 
    L_5096:
        lda $7ec0,y
        sta ($02),y
        dey 
        bpl L_5096
        jmp $7f9d

        .byte $33,$1d,$17,$0d,$80,$a0,$00,$00,$00,$70,$00,$00,$ff,$92,$ff,$73
        .byte $d0,$a1,$30,$02,$00,$70,$00,$00,$7f,$fb,$0d,$e0,$00,$b0,$7e,$fa
        .byte $11,$c0,$78,$fe,$00,$b0,$13,$c0,$00,$d0,$15,$c0,$00,$d0,$17,$c0
        .byte $00,$d0,$7a,$f8,$00,$d0,$a9,$50,$a2,$00,$20,$fc,$7b,$a9,$69

    L_50e0:
        ldx #$93
        jsr $7c03
        lda #$30
    L_50e7:
        jsr $7cde
        ldx #$03
    L_50ec:
        lda $2800,x
        and #$01
        stx $0b
        jsr $7bd1
        ldx $0b
    L_50f8:
        lda $2800,x
        and #$02
        lsr 
        jsr $7bd1
        ldx $0b
        dex 
        bpl L_50ec
        lda #$7a
        ldx #$9d
        jsr $7c03
        lda #$10
        jsr $7cde
        lda L_2802
        and #$02
        lsr 
        adc #$01
        jsr $7bd1
        lda $2801
        and #$03
        tax 
        lda $7ff5,x
        jsr $7bd1
        lda $16
        beq L_5134
        ldx #$88
        lda #$50
        jsr $7bfc
    L_5134:
        ldx #$96
        stx.a $000c
        ldx #$07
    L_513b:
        lda $0d,x
        beq L_5176
        pha 
        stx.a $000b
        ldx.a $000c
        txa 
        sec 
        sbc #$08
        sta.a $000c
        lda #$20
        jsr $7c03
        lda #$70
        jsr $7cde
        lda.a $000b
        jsr $7bd1
        lda $56d4
        ldx $56d5
        jsr $7d45
        pla 
        pha 
        lsr 
        lsr 
        lsr 
        lsr 
        jsr $7bd1
        pla 
        jsr $7bd1
        ldx.a $000b
    L_5176:
        dex 
        bpl L_513b
        lda #$7f
        tax 
        jsr $7c03
        jsr $7bc0
        lda #$00
        ldx #$04
    L_5186:
        rol L_1b81 + $482,x
        ror 
        dex 
        bpl L_5186
        tay 
        ldx #$07
    L_5190:
        rol $2400,x
        rol 
        dex 
        bpl L_5190
        tax 
        eor $08
        stx $08
        php 
        lda #$04
        sta L_31ff + $1
        rol L_1b81 + $482
        rol 
        rol L_1b81 + $483
        rol 
        rol $2407
        rol 
        rol L_2406
        rol 
        rol $2405
        rol 
        tax 
        plp 
        bne L_51c3
        eor $0a
        bne L_51c3
        tya 
        eor $09
        beq L_51c5
    L_51c3:
        lda #$80
    L_51c5:
        sta $3c05
        sta L_31ff + $1
        sta L_2ff0 + $10
        stx $0a
        sty $09
        lda L_1b81 + $486
    L_51d5:
        bpl L_51d5
        jmp $7e73

    L_51da:
         .byte $01,$04,$05,$06,$4e,$65,$7b,$f3,$7c,$f3,$7c
        .byte $ea
