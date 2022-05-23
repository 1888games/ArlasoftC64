//Standard imports
#import "./syslabels.asm"

//Potential screen buffer locations
.label SCREEN_BUFFER_0 = $0400
.label SCREEN_BUFFER_1 = $4800



    BasicUpstart2($0501)


//Start of disassembled code
* = $0400 "Base Address"

    L_0400:
    //     ldx #$00
    //     ldy #$26
    //     stx $fb
    //     sty $fc
    //     ldx #$01
    //     ldy #$08
    //     stx $fd
    //     sty $fe
    //     ldx #$d2
    // L_0412:
    //     ldy #$00
    // L_0414:
    //     lda ($fb),y
    //     sta ($fd),y
    //     iny 
    //     bne L_0414
    //     inc $fc
    //     inc $fe
    //     dex 
    //     bne L_0412
    //     lda #$37
    //     sta $01
    //     jmp L_0800 + $1

    //     .byte $00,$00,$00,$08,$09,$20,$14,$08,$05,$12,$05,$21,$20,$27,$07,$12
    //     .byte $01,$05,$0d,$05,$20,$13,$0f,$15,$0e,$05,$13,$13,$20,$09,$0e,$14
    //     .byte $05,$12,$0e,$01,$14,$09,$0f,$0e,$01,$0c,$20,$13,$0f,$03,$03,$05
    //     .byte $12,$27,$20,$02,$19,$20,$1a,$05,$10,$10,$05,$0c,$09,$0e,$20,$07
    //     .byte $01,$0d,$05,$13,$20,$0c,$14,$04,$2e,$20,$17,$01,$13,$20,$03,$12
    //     .byte $01,$03,$0b,$05,$04,$20,$0f,$0e,$20,$30,$35,$2f,$31,$31,$2f,$31
    //     .byte $39,$39,$32,$20,$02,$19,$20,$2d,$08,$05,$12,$03,$15,$0c,$05,$13
    //     .byte $2d,$20,$0f,$06,$20,$08,$05,$01,$12,$14,$02,$05,$01,$14,$21,$20
    //     .byte $13,$0f,$0d,$05,$20,$08,$05,$0a,$01,$08,$0f,$27,$13,$20,$14,$0f
    //     .byte $3a,$20,$04,$0f,$0d,$09,$0e,$01,$14,$0f,$12,$13,$2c,$20,$0c,$05
    //     .byte $07,$05,$0e,$04,$2c,$20,$02,$12,$15,$14,$01,$0c,$2c,$20,$16,$09
    //     .byte $13,$09,$0f,$0e,$2c,$20,$14,$01,$0c,$05,$0e,$14,$2c,$20,$09,$0c
    //     .byte $0c,$15,$13,$09,$0f,$0e,$2c,$20,$01,$12,$03,$01,$04,$05,$2c,$20
    //     .byte $14,$12,$09,$01,$04,$2c,$20,$20

    * = $0501
    lda #$37
    sta $01
    cli
    jmp $8000

    L_0501:
        //.fill $2e5, $20
        .byte $20,$20,$0f,$e7,$c4,$9f,$76,$1b,$c9,$08,$ad,$42,$2b,$c9,$76,$d8
        .byte $9c,$78,$3b,$ce,$89,$97,$ea,$19,$87,$39

    L_0800:
      //  .byte $00,$00,$00,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00

    * = $810

    L_0810:
        sei 
        lda vScreenControl1
        pha 
        ldy #$00
        sty vScreenControl1
        lda cCia2DDRA
        and #$fb
        sta cCia2DDRA
        lda #$78
        sta L_090d + $1
        lda #$08
        sta L_090d + $2
        jsr L_0879
        sta L_088c
    L_0832:
        jsr L_0879
        sta $22
        jsr L_0879
        sta $23
        jsr L_0879
        sta $24
        jsr L_0879
        sta $25
    L_0846:
        lda cCia2PortA
        and #$04
        beq L_0846
        lda cCia2PortB
        sta ($22),y
        inc $22
        bne L_0858
        inc $23
    L_0858:
        lda cCia2PortA
        and #$04
        bne L_0858
        lda $22
        cmp $24
        bne L_0846
        lda $23
        cmp $25
        bne L_0846
        dec L_088c
        bne L_0832
        pla 
        sta vScreenControl1
        cli 
        jmp (L_090d + $1)
        rts 


    L_0879:
        lda cCia2PortA
        and #$04
        beq L_0879
        ldx cCia2PortB
    L_0883:
        lda cCia2PortA
        and #$04
        bne L_0883
        txa 
        rts 



    L_088c:
         .byte $00
        .byte $8d,$13,$d4,$a2,$f0,$8e,$14,$d4,$a2,$81,$8e,$12,$d4,$a0,$8f,$8c
        .byte $18,$d4,$a0,$02,$a9,$ff

    L_08a3:
        sta cCia1PortB,y
        sta cCia2PortB,y
        dey 
        bne L_08a3
    L_08ac:
        cpy #$10
        bcs L_08bc
        lda L_0d2d + $3,y
        sta cCia1PortA,y
        lda L_0d3d + $3,y
        sta cCia2PortA,y
    L_08bc:
        lda L_0cfd + $3,y
        sta vSprite0X,y
        iny 
        cpy #$2f
        bne L_08ac
        jsr L_0d4d + $3
        lda $0330
        sta $c3
        lda $0331
        sta $c8
        lda #$20
        ldx #$06
        sta L_de00
        sta L_de00 + $1fe
        stx L_de00
        dec $01
        ldy #$00
        jmp.a $008e
        jsr $9ab1
        jmp $8604
        jsr L_9a49
        sta L_0883
        pha 
        jsr $902c
        pla 
        jsr L_8eca

        .byte $24,$80,$a9,$0a,$00,$00,$00,$00,$00,$af,$b0,$b2,$b1,$00,$00,$00
        .byte $ca

    L_090d:
        .byte $cb,$00,$80,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00

    L_091d:
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00

    L_09fd:
        .byte $00,$ff,$ff,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff

    L_0aed:
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff

    L_0afd:
        .byte $ff,$00,$00,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00

    L_0bfd:
        .byte $00,$ff,$ff,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff

    L_0c1d:
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff

    L_0c3d:
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff

    L_0cfd:
        .byte $ff,$00,$00,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00

    L_0d0d:
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00

    L_0d2d:
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00

    L_0d3d:
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00

    L_0d4d:
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00

    L_0dbd:
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00

    L_0dfd:
        .byte $00,$ff,$ff,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff

    L_0e0d:
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff

    L_0efd:
        .byte $ff,$00,$00,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00

    L_0f0d:
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00

    L_0f1d:
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00

    L_0f3d:
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00

    L_0ffe:
        .fill $52, $ff

    L_1050:
        lda $b4,x
        ldy $b4,x
        ldy $c5,x
        dec $c7

        .byte $c7,$c8,$c9,$ca,$c6,$cb,$c7,$cc,$b4,$b4,$c4,$b4,$b4,$b4,$cd,$b4
        .byte $ca,$b4,$c5,$ce,$cf,$c7,$b4,$b4,$b4,$b4,$8a,$89,$89,$89,$89,$89
        .byte $89,$89,$89,$89,$89,$8b,$c4,$b4,$b4,$d0,$cc,$ca,$d1,$cb,$c7,$d1
        .byte $c5,$d2,$c7,$ce,$d1,$b4,$b4,$c4,$b4,$c9,$d3,$cc,$c6,$d4,$b4,$d5
        .byte $cc,$ce,$d5,$cb,$c7,$d2,$b4,$b8

    L_10a0:
        ldy $b9,x
        tsx 
        tsx 
        tsx 
    L_10a5:
        tsx 
        tsx 
        tsx 
        tsx 
        tsx 
        tsx 
        tsx 
        tsx 
        tsx 
        tsx 
        tsx 
        tsx 
        tsx 
        tsx 
        tsx 
        tsx 
        tsx 
        tsx 
        tsx 
        tsx 
        tsx 
        tsx 
        tsx 
        tsx 
        tsx 
        tsx 
        tsx 
        tsx 
        tsx 
        stx $88
        dey 
        dey 
        dey 
        dey 
        dey 
        dey 
        dey 
        dey 
        dey 

        .byte $87
        .fill $20, $ba
        .byte $bb,$b4,$b4,$c0,$ff

    L_10f3:
        .fill $1f, $ff
        .byte $90,$91,$91,$91,$91,$91,$91,$91,$91,$91,$91,$a4
        .fill $20, $ff
        .byte $bc,$b4,$b4,$c0,$ff,$ff,$17
        .fill $1d, $ff
        .byte $8c,$a9,$a9,$a9,$a9,$a9,$a9,$a9,$a9,$a9,$a9,$8e,$9f,$a0,$a1,$ff

    L_1172:
        .fill $19, $ff
        .byte $17,$ff,$ff,$bc,$b4,$b4,$c1,$56,$56,$16,$14,$58,$58,$58,$58,$58
        .byte $58,$58,$58,$58,$58,$58,$58,$58,$58,$59,$58,$58,$58,$58,$58,$58
        .byte $58,$58,$58,$59,$58,$58,$58,$8d,$a7,$ab,$ab,$ab,$ab,$ab,$ab,$ab
        .byte $ab,$ab,$aa,$ab,$ab,$a3,$59,$58,$58,$58,$58,$58,$58,$58,$58,$58
        .byte $59,$58,$58,$58,$58,$58,$58,$58,$58,$58,$58,$58,$58,$58,$19,$58
        .byte $16,$85,$56,$bd,$b4,$b4,$c1,$56,$56,$08,$15,$56,$56,$56,$56,$56
        .byte $56,$56,$56,$56,$56,$56,$56,$56,$56,$57,$56,$56,$56,$56,$56,$56
        .byte $56,$56,$56,$57,$56,$56,$56,$56

    L_1203:
        lsr $56,x
        ldx $c2

    L_1207:
         .byte $c2,$c2,$c2,$c2,$c2,$c2,$c2,$c2,$c2
        .byte $a5,$57,$56,$56

    L_1214:
        lsr $56,x
        lsr $56,x
        lsr $56,x
        lsr $57,x
        lsr $56,x
        lsr $56,x
        lsr $56,x
        lsr $56,x
        lsr $56,x
        lsr $56,x
        lsr $1b,x

        .byte $1a,$1c,$56,$56,$bd,$b4,$b4,$c1,$56,$56,$57,$56,$56,$56,$56,$56
        .byte $56,$56,$56,$56,$56,$56,$56,$56,$56,$56,$57,$56,$56,$56,$56,$56
        .byte $56,$56,$56,$56,$57
        .fill $12, $56
        .byte $57,$56,$56,$56,$56,$56,$56,$56,$56,$56,$57,$56,$56,$56,$56,$56
        .byte $56,$56,$56,$56,$56,$56,$56,$56,$56,$56,$57,$56,$56,$bd,$b4,$b4
        .byte $c1,$56,$56,$57,$56,$56,$56,$56,$56,$56,$56,$56,$56,$56,$56,$56
        .byte $56,$56,$56,$57,$56,$56,$56,$56,$56,$56,$56,$56,$56,$57
        .fill $12, $56
        .byte $57,$56,$56,$56,$56,$56,$56,$56,$56,$56,$57,$56,$56,$56,$56,$56
        .byte $56,$56,$56,$56,$56,$56,$56,$56,$56,$56,$57,$56,$56,$bd,$b4,$b4
        .byte $c0,$ff,$ff,$03,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff
        .byte $ff,$ff,$ff,$03,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$04
        .fill $12, $1
        .byte $05,$ff

    L_1303:
        .byte $ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$03,$ff,$ff,$ff,$ff,$ff,$ff,$ff
        .byte $ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$03,$ff,$ff,$bc,$b8,$b4,$c0,$ff
        .byte $ff,$03,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff
        .byte $ff,$03

    L_1335:
        .fill $26, $ff
        .byte $03,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff
        .byte $03,$ff,$ff,$bc,$b4,$b5,$c0,$ff,$ff,$03,$ff,$ff,$ff,$ff,$ff,$ff
        .byte $ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$03
        .fill $26, $ff
        .byte $03,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff
        .byte $03,$ff,$ff,$bc,$b4,$b4,$c0,$ff,$ff,$03,$ff,$ff,$ff,$ff,$ff,$ff
        .byte $ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$03
        .fill $12, $ff
        .byte $11,$12

    L_13e9:
        .fill $12, $ff

    L_13fb:
        .byte $03,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff

    L_140b:
        .byte $03,$ff,$ff
        .byte $bc,$b4,$b4,$c1,$56,$56,$57,$56,$56,$56,$56,$56,$56,$56,$56,$56
        .byte $56,$56,$56,$56,$56,$56,$57
        .fill $26, $56
        .byte $57,$56,$56,$56,$56,$56,$56,$56,$56,$56,$56,$56,$56,$56,$56,$56
        .byte $57,$56,$56,$bd,$b4,$b4,$c1,$56,$56,$57,$56,$56,$56,$56,$56,$56
        .byte $56,$56,$56,$56,$56,$56,$56,$56,$56,$57
        .fill $26, $56
        .byte $57,$56,$56,$56,$56,$56,$56,$56,$56,$56,$56,$56,$56,$56,$56,$56
        .byte $57,$56,$56,$bd,$b4,$b4,$c1,$56,$56,$57,$56,$56,$56,$56,$56,$56
        .byte $56,$56,$56,$56,$56,$56,$56,$56,$56,$5c,$58,$58,$58,$58,$58,$58
        .byte $58,$58,$58,$58,$58,$53,$58,$58,$58,$58,$58,$58,$58,$58,$58,$58
        .byte $58,$58,$58,$58,$52,$58,$58,$58,$58,$58,$58,$58,$58,$58,$58,$58
        .byte $5b,$56,$56,$56,$56,$56,$56,$56,$56,$56,$56,$56,$56,$56,$56,$56
        .byte $57,$56,$56,$bd,$b4,$b4,$c1,$56,$56,$57
        .fill $1b, $56
        .byte $81,$82,$56,$56,$56,$56,$56,$56,$56,$56,$56,$56,$56,$56,$83,$84
        .fill $1b, $56
        .byte $57,$56,$56,$bd,$b4,$b4,$c0,$ff,$ff,$03
        .fill $1c, $ff
        .byte $4c,$4b,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$44,$43
        .fill $1c, $ff
        .byte $03,$ff,$ff,$bc,$b8,$b4,$c0,$ff,$ff,$03
        .fill $1e, $ff
        .byte $4a,$49,$48,$07,$ff,$ff,$07,$47,$46,$45
        .fill $1e, $ff
        .byte $03,$ff,$ff,$bc,$b4,$b4,$c0,$ff,$ff,$03
        .fill $22, $ff
        .byte $06,$06

    L_1619:
        .fill $22, $ff
        .byte $03,$ff,$ff,$bc,$b4,$b4,$c0,$ff,$ff,$03

    L_1645:
        .fill $46, $ff
        .byte $03,$ff,$ff,$bc,$b4,$b5,$c1,$56,$56,$57
        .fill $46, $56
        .byte $57,$56,$56,$bd,$b4,$b4,$c1,$56,$56,$57
        .fill $46, $56
        .byte $57,$56,$56,$bd,$b4,$b4,$c1,$56,$56,$57
        .fill $46, $56
        .byte $57,$56,$56,$bd,$b4,$b4,$c1,$56,$56,$57
        .fill $46, $56
        .byte $57,$56,$56,$bd,$b4,$b4,$c0,$ff,$ff,$03

    L_17d5:
        .fill $46, $ff
        .byte $03,$ff,$ff,$bc,$b8,$b4,$c0,$ff,$ff,$03

    L_1825:
        .fill $46, $ff
        .byte $03,$ff,$ff,$bc,$b4,$b4,$c0,$ff,$ff,$03
        .fill $46, $ff
        .byte $03,$ff,$ff,$bc,$b4,$b4,$c0,$ff,$ff,$03

    L_18c5:
        .fill $46, $ff
        .byte $03,$ff,$ff,$bc,$b4,$b4,$c1,$56,$56,$57
        .fill $46, $56
        .byte $57,$56,$56,$bd,$b4,$b4,$c1,$56,$56,$57
        .fill $46, $56
        .byte $57,$56,$56,$bd,$b4,$b5,$c1,$56,$56,$57
        .fill $46, $56
        .byte $57,$56,$56,$bd,$b4,$b4,$c1,$56,$56,$57
        .fill $46, $56
        .byte $57,$56,$56,$bd,$b4,$b4,$c0,$ff,$ff,$03
        .fill $46, $ff
        .byte $03,$ff,$ff,$bc,$b4,$b4,$c0,$ff,$ff,$03
        .fill $22, $ff
        .byte $07,$07
        .fill $22, $ff
        .byte $03,$ff,$ff,$bc,$b4,$b4,$c0,$ff,$ff,$03
        .fill $1e, $ff
        .byte $36,$35,$34,$06,$ff,$ff,$06,$2a,$33,$32
        .fill $1e, $ff
        .byte $03,$ff,$ff,$bc,$b4,$b4,$c0,$ff,$ff,$03
        .fill $1c, $ff
        .byte $38,$37,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$31,$30
        .fill $1c, $ff
        .byte $03,$ff,$ff,$bc,$b7,$b4,$c1,$56,$56,$57
        .fill $1b, $56
        .byte $77,$78,$56,$56,$56,$56,$56,$56,$56,$56,$56,$56,$56,$56,$7c,$7d
        .fill $1b, $56
        .byte $57,$56,$56,$56,$56,$b4,$c1,$56,$56,$57
        .fill $1a, $56
        .byte $79,$7a,$56,$56,$56,$56,$56,$56,$56,$56,$56,$56,$56,$56,$56,$56
        .byte $7e,$7f
        .fill $1a, $56
        .byte $57,$56,$56,$56,$56,$b4,$c1,$56,$56,$57
        .fill $1a, $56
        .byte $7b,$56,$56,$56,$56,$56,$56,$56,$56,$56,$56,$56,$56,$56,$56,$56
        .byte $56,$80
        .fill $1a, $56
        .byte $57,$56,$56,$56,$56,$b4,$c1,$56,$56,$08
        .fill $1a, $61
        .byte $26,$61,$61,$61,$61,$61,$61,$61,$0c,$0d,$61,$61,$61,$61,$61,$61
        .byte $61,$27
        .fill $1a, $61
        .byte $0a,$56,$56,$56,$56,$b5,$c0,$ff,$ff,$09
        .fill $1a, $6
        .byte $29,$06,$06,$06,$06,$06,$06,$06,$0e,$0f,$06,$06,$06,$06,$06,$06
        .byte $06,$28
        .fill $1a, $6
        .byte $0b,$ff,$ff,$ff,$ff,$b4,$c0,$ff,$ff,$03
        .fill $1a, $ff

    L_1d3f:
        .byte $50,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff
        .byte $ff,$3e
        .fill $1a, $ff
        .byte $03,$ff,$ff,$ff,$ff,$b4,$c0,$ff,$ff,$03
        .fill $1a, $ff
        .byte $51,$4f,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff
        .byte $40,$3f
        .fill $1a, $ff
        .byte $03,$ff,$ff,$ff,$ff

    L_1dc0:
        ldy $c0,x

        .byte $ff,$ff,$03
        .fill $1b, $ff
        .byte $4e,$4d,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$42,$41
        .fill $1b, $ff
        .byte $03,$ff,$ff,$ff,$c3,$b4,$c1,$56,$56,$57
        .fill $1c, $56
        .byte $72,$73,$56,$56,$56,$56,$56,$56,$56,$56,$56,$56,$70,$71
        .fill $1c, $56
        .byte $57,$56,$56,$bd,$b4,$b4,$c1,$56,$56,$57
        .fill $1e, $56
        .byte $74,$75,$76,$61,$56,$56,$61,$6d,$6e,$6f
        .fill $1e, $56
        .byte $57,$56,$56,$bd,$b4,$b4,$c1,$56,$56,$57
        .fill $22, $56
        .byte $62,$62
        .fill $20, $56

    L_1ef9:
        lsr $56,x

        .byte $57,$56,$56,$bd,$b4,$b4,$c1,$56,$56,$57
        .fill $46, $56
        .byte $57,$56,$56,$bd,$b4,$b4,$c0,$ff,$ff,$03
        .fill $46, $ff
        .byte $03,$ff,$ff,$bc,$b4,$b4,$c0,$ff,$ff,$03
        .fill $46, $ff
        .byte $03,$ff,$ff,$bc,$b4,$b5,$c0,$ff,$ff,$03

    L_1ff5:
        .fill $46, $ff
        .byte $03,$ff,$ff,$bc,$b4,$b4,$c0,$ff,$ff,$03
        .fill $46, $ff
        .byte $03,$ff,$ff,$bc,$b8,$b4,$c1,$56,$56,$57
        .fill $46, $56
        .byte $57,$56,$56,$bd,$b4,$b4,$c1,$56,$56,$57
        .fill $30, $56

    L_2115:
        lsr $56,x
        lsr $56,x
        lsr $56,x
        lsr $56,x
        lsr $56,x
    L_211f:
        lsr $56,x
        lsr $56,x
        lsr $56,x
        lsr $56,x
        lsr $56,x
        lsr $56,x

        .byte $57,$56,$56,$bd,$b4,$b4,$c1,$56,$56,$57
        .fill $46, $56
        .byte $57,$56,$56,$bd,$b4,$b4,$c1,$56,$56,$57
        .fill $46, $56
        .byte $57,$56,$56,$bd,$b4,$b4,$c0,$ff,$ff,$03
        .fill $46, $ff
        .byte $03,$ff,$ff,$bc,$b4,$b4,$c0,$ff,$ff,$03
        .fill $46, $ff
        .byte $03,$ff,$ff,$bc,$b4,$b4,$c0,$ff,$ff,$03
        .fill $46, $ff
        .byte $03,$ff,$ff,$bc,$b4,$b4,$c0,$ff,$ff,$03
        .fill $46, $ff
        .byte $03,$ff,$ff,$bc,$b4,$b5,$c1,$56,$56,$57
        .fill $46, $56
        .byte $57,$56,$56,$bd,$b8,$b4,$c1,$56,$56,$57
        .fill $22, $56
        .byte $61,$61
        .fill $22, $56
        .byte $57,$56,$56,$bd,$b4,$b4,$c1,$56,$56,$57
        .fill $1e, $56
        .byte $6a,$69,$68,$62,$56,$56,$62,$63,$64,$65
        .fill $1e, $56
        .byte $57,$56,$56,$bd,$b4,$b4,$c1,$56,$56,$57
        .fill $1c, $56
        .byte $6b,$6c,$56,$56,$56,$56,$56,$56,$56,$56,$56,$56,$66,$67

    L_242f:
        .fill $1c, $56
        .byte $57,$56,$56,$bd,$b4,$b4,$c0,$ff,$ff,$03
        .fill $1b, $ff
        .byte $3a,$39,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$2c,$2f
        .fill $1b, $ff
        .byte $03,$ff,$ff,$bc,$b4,$b4,$c0,$ff,$ff,$03,$ff,$ff,$ff,$ff,$ff,$ff
        .byte $ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$00,$01,$01,$01,$01,$01,$01
        .byte $01,$01,$01,$01,$01,$54,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01
        .byte $01,$01,$01,$01,$55,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01
        .byte $02,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff
        .byte $03,$ff,$ff,$bc,$b4,$b4,$c0,$ff,$ff,$03,$ff,$ff,$ff,$ff,$ff,$ff
        .byte $ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$03
        .fill $26, $ff
        .byte $03,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff
        .byte $03,$ff,$ff,$bc,$b4,$b4,$c0,$ff,$ff,$03,$ff,$ff,$ff,$ff,$ff,$ff
        .byte $ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$03
        .fill $26, $ff
        .byte $03,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff
        .byte $03,$ff,$ff,$bc,$b4,$b4,$c1,$56,$56,$57,$56,$56,$56,$56,$56,$56
        .byte $56,$56,$56,$56,$56,$56,$56,$56,$56,$57
        .fill $12, $56
        .byte $5f,$60
        .fill $12, $56
        .byte $57,$56,$56,$56,$56,$56,$56,$56,$56,$56,$56,$56,$56,$56,$56,$56
        .byte $57,$56,$56,$bd,$b4,$b5,$c1,$56,$56,$57,$56,$56,$56,$56,$56,$56
        .byte $56,$56,$56,$56,$56,$56,$56,$56,$56,$57
        .fill $26, $56
        .byte $57,$56,$56,$56,$56,$56,$56,$56,$56,$56,$56,$56,$56,$56,$56,$56
        .byte $57,$56,$56,$bd,$b8,$b4,$c1,$56,$56,$57,$56,$56,$56,$56,$56,$56
        .byte $56,$56,$56,$56,$56,$56,$56,$56,$56,$57
        .fill $26, $56
        .byte $57,$56,$56,$56,$56,$56,$56,$56,$56,$56,$56,$56,$56,$56,$56,$56
        .byte $57,$56,$56,$bd,$b4,$b4,$c1,$56,$56,$57,$56,$56,$56,$56

    L_2689:
        lsr $56,x
        lsr $56,x
        lsr $56,x
        lsr $56,x
        lsr $56,x
        lsr $57,x
        lsr $56,x
        lsr $56,x
        lsr $56,x
        lsr $56,x
        lsr $5d,x
        cli 
        cli 
        cli 
        cli 
        cli 
        cli 
        cli 
        cli 
        cli 
        cli 
        cli 
        cli 
        cli 
        cli 
        cli 
        cli 
        cli 
        cli 
        lsr L_5656,x
        lsr $56,x
        lsr $56,x
        lsr $56,x
        lsr $57,x
        lsr $56,x
        lsr $56,x
        lsr $56,x
        lsr $56,x
        lsr $56,x
        lsr $56,x
        lsr $56,x
        lsr $57,x
        lsr $56,x
        lda $b4b4,x
        cpy #$ff

        .byte $ff,$03,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff
        .byte $ff,$03,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$03
        .fill $12, $ff
        .byte $03,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$03,$ff,$ff,$ff,$ff,$ff
        .byte $ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$03,$ff,$ff,$bc,$b4,$b4
        .byte $c0,$ff,$ff,$03,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff
        .byte $ff,$ff

    L_2733:
        .byte $ff,$03,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$03,$ff,$ff,$ff
        .byte $95,$92,$92,$92,$92,$92,$92,$92,$92,$92,$92,$97,$ff,$ff,$ff,$03
        .byte $ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$03,$ff,$ff,$ff,$ff,$ff,$ff
        .byte $ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$03,$ff,$ff,$bc,$b4,$b4,$c0
        .byte $ff,$ff,$17,$1e,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff
        .byte $ff,$ff,$03,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$03,$ff,$ff,$ff
        .byte $96,$8f,$8f,$8f,$8f,$8f,$8f,$8f,$8f,$8f,$8f,$98,$ff,$ff,$ff,$03
        .byte $ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$03,$ff,$ff,$ff,$ff,$ff,$ff
        .byte $ff,$ff,$ff,$ff,$ff,$ff,$ff,$24,$23,$17,$ff,$ff,$bc,$b4,$b4,$c0
        .byte $ff,$ff,$1f,$20,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01
        .byte $01,$01,$13,$01,$01,$01,$01,$01,$01,$01,$01,$01,$13,$01,$01,$01
        .byte $99,$93,$93,$93,$93,$93,$93,$93,$93,$93,$93,$9b,$af,$b0,$01,$13

    L_27f2:
        ora ($01,x)
        ora ($01,x)
        ora ($01,x)
        ora ($01,x)
        ora ($13,x)
        ora ($01,x)
        ora ($01,x)
        ora ($01,x)
        ora ($01,x)
        ora ($01,x)
        ora ($01,x)
        ora ($22,x)
        ora ($21,x)
        clc 

        .byte $ff,$bc,$b4,$b4,$c1
        .fill $20, $56
        .byte $9a,$94,$94,$94,$94,$94,$94,$94,$94,$94,$94,$9c,$a9,$a9,$ae
        .fill $1d, $56
        .byte $bd,$b4,$b4,$c1
        .fill $20, $56
        .byte $9e,$b3,$b2,$9d,$ac,$ac,$ac,$ac,$ac,$ac,$ac,$a9,$a9,$a9,$ad
        .fill $1d, $56
        .byte $bd,$b4,$b6,$d6
        .fill $23, $be
        .byte $b1,$a2,$a2,$a2,$a2,$a2,$a2,$a2,$a2,$a2,$a2
        .fill $1e, $be
        .byte $bf,$b7,$b4,$b4,$d7,$d8,$d9,$b4,$da,$db,$dc,$b4,$dd,$d3,$b4,$db
        .byte $de,$dc,$d8,$c9,$b4,$b4,$c4,$b4,$b4,$d7,$df,$e0,$d1,$e1,$b4,$d9
        .byte $e2,$e1,$d3,$e3,$b4,$b4,$c4,$b4,$b4,$e0,$e4,$ce,$e2,$dc,$c5,$da
        .byte $e1,$e3,$b4,$c9,$d8,$da,$dc,$b4,$e0,$d8,$dc,$b4,$b4,$c4,$b4,$b4
        .byte $b4,$b4,$b4

    L_2941:
        .byte $d7,$da
        .byte $e5,$de,$d3,$db,$b4,$da,$de,$ce,$b4,$b4,$b4,$b4,$b4,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$00,$00,$ff
        .byte $ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff
        .byte $ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff
        .byte $ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff
        .byte $ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff
        .byte $ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff
        .byte $ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff
        .byte $ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff
        .byte $ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff
        .byte $ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff
        .byte $ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff
        .byte $ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff
        .byte $ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff
        .byte $ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff
        .byte $ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff
        .byte $ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff
        .byte $ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00

    L_2b00:
        .byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$3c
        .byte $3d,$3e,$3f,$00,$00,$00,$00,$00,$00,$00,$00,$00,$40,$41,$00,$00
        .byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$20,$20,$00,$00
        .byte $00,$00,$00,$00,$00,$00,$42,$43,$44,$45,$46,$00,$00,$00,$00,$00
        .byte $00,$00,$00,$47,$48,$49,$00

    L_2b41:
        .byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
        .byte $20,$20,$00,$00,$00,$00,$00,$00,$00,$00,$4a,$4b,$4c,$4d,$4e,$4f
        .byte $50,$51,$52,$53,$54,$55,$00,$56,$57,$58,$59,$5a,$5b,$5c,$5d,$5e
        .byte $5f,$60,$61,$00,$00,$00,$00,$00,$20,$20,$00,$00,$00,$00,$00,$00
        .byte $00,$00,$62,$63,$64,$65,$66,$67,$68,$69,$6a,$6b,$6c,$6d,$6e,$6f
        .byte $70,$71,$72,$73,$74,$75,$76,$77,$78,$79,$7a,$00,$00,$00,$00,$00
        .byte $20,$20,$00,$00,$00,$7b,$7c,$7d,$7e,$7f,$80,$81,$82,$83,$84,$85
        .byte $86,$7b,$7c,$87,$88,$89,$8a,$8b,$8c,$8d,$8e,$00,$00,$8f,$90,$86
        .byte $91,$8d,$92,$93,$94,$95,$96,$00,$20,$20,$00,$00,$00,$97,$98,$99
        .byte $8e,$9a,$9b,$9c,$9d,$9e,$9f,$a0,$a1,$97,$98,$a2,$97,$a3,$a0,$a4
        .byte $a5,$a6,$8e,$00,$00,$a7,$a8,$a2,$9a,$00,$8e,$97,$a9,$a5,$aa,$00
        .byte $20,$20,$00,$00,$00,$ab,$ac,$ad,$8e,$9a,$a2,$ae,$8e,$af,$b0,$a0
        .byte $a2,$97

    L_2c00:
        tya 
    L_2c01:
        lda ($b2),y

        .byte $b3,$a0,$b4,$9a,$9a,$b5,$b6,$00,$b7,$a0,$b1,$b8,$b9,$b5,$ba,$bb
        .byte $9a,$9a,$00,$20,$20,$00,$00,$00,$bc,$bd,$be,$be,$bf,$c0,$bd,$be
        .byte $c1,$c2,$c3,$c0,$c4,$c5,$c6,$c7,$c8,$c9,$c0,$bf,$bf,$c6,$be,$00
        .byte $ca,$cb,$cc,$cd,$ce,$cf,$d0,$c6,$bf,$bf,$00,$20,$20,$00,$00,$ff
        .byte $ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff
        .byte $ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff
        .byte $ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff
        .byte $ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff
        .byte $ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff
        .byte $ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff
        .byte $ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff
        .byte $ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff
        .byte $ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff
        .byte $ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff
        .byte $ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff
        .byte $ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff

    L_2d11:
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff

    L_2d41:
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00

    L_2e21:
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00

    L_2e61:
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00

    L_3021:
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00

    L_3041:
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff

    L_31f1:
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00

    L_3221:
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00

    L_32a1:
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00

    L_34f1:
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff

    L_3521:
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff

    L_3541:
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff

    L_3741:
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00

    L_38f1:
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff

    L_3981:
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00

    L_3c21:
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00

    L_3c81:
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00

    L_3ce1:
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00

    L_3e81:
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00

    L_3eb1:
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff

    L_3f31:
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff

    L_3f41:
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$00

    L_4001:
        .byte $00,$00,$00,$00,$00,$00,$00,$00
        .byte $38,$6c,$c6,$fe,$c6,$c6,$00,$00,$fc,$c6,$fc,$c6,$c6,$fc,$00,$00
        .byte $7c,$c6,$c0,$c0,$c6,$7c,$00,$00,$fc,$c6,$c6,$c6,$c6,$fc,$00,$00
        .byte $fe,$c0,$f8,$c0,$c0,$fe,$00,$00,$fe,$c0,$f8,$c0,$c0,$c0,$00,$00
        .byte $7c,$c0,$dc,$c6,$c6,$7c,$00,$00,$c6,$c6,$fe,$c6,$c6,$c6,$00,$00
        .byte $3c,$18,$18,$18,$18,$3c,$00,$00,$fc,$06,$06,$c6,$c6,$7c,$00,$00
        .byte $c6,$cc,$f8,$cc,$c6,$c6,$00,$00,$c0,$c0,$c0,$c0,$c0,$fe,$00,$00
        .byte $c6,$ee,$fe,$d6,$c6,$c6,$00,$00,$c6,$e6,$f6,$de,$ce,$c6,$00,$00
        .byte $7c,$c6,$c6,$c6,$c6,$7c,$00,$00,$fc,$c6,$c6,$fc,$c0,$c0,$00,$00
        .byte $7c,$c6,$c6,$ca,$ce,$76,$00,$00,$fc,$c6,$fc,$c6,$c6,$c6,$00,$00
        .byte $7e,$c0,$7c,$06,$06,$fc,$00,$00,$fc,$30,$30,$30,$30,$30,$00,$00
        .byte $c6,$c6,$c6,$c6,$c6,$7c,$00,$00,$c6,$c6,$c6,$c6,$6c,$38,$00,$00
        .byte $c6,$c6,$d6,$fe,$ee,$c6,$00,$00,$c6,$6c,$38,$6c,$c6,$c6,$00,$00
        .byte $c6,$c6,$7e,$06,$c6,$7c,$00,$00,$fe,$0c,$18

    L_40d4:
        .byte $30,$60

    L_40d6:
        inc.a $0000,x

        .byte $3c,$30,$30,$30,$30,$3c,$00,$00,$1e,$30,$3c,$30,$30,$7e,$00,$00
        .byte $3c,$0c,$0c,$0c,$0c,$3c
        .fill $1a, $0
        .byte $18,$18,$18

    L_410c:
        clc 

        .byte $00

    L_410e:
        clc 

        .byte $00,$00,$36,$36,$22,$00,$00,$00,$00,$00,$36,$7f,$36,$36,$7f,$36
        .byte $00,$10,$7e,$d0,$7c,$16,$fc,$10,$00,$00,$72,$54,$70,$0e,$2a,$4e
        .byte $00,$00,$18,$18,$7e,$18,$18,$00,$00,$00,$18,$18

    L_413b:
        php 

        .byte $10,$00,$00,$00,$00,$0c

    L_4142:
        clc 
        clc 
        clc 
        clc 

    L_4146:
         .byte $0c,$00,$00,$30,$18
        .byte $18,$18,$18,$30,$00,$00,$00,$24,$18,$18,$24,$00,$00,$00,$18,$18
        .byte $7e,$18,$18,$00,$00,$00,$00,$00,$00,$00,$30,$30,$40,$00,$00,$00
        .byte $7e,$7e,$00,$00,$00,$00,$00,$00,$00,$00,$30,$30,$00,$00,$02,$06
        .byte $0c,$18,$30,$60,$00,$00,$7c,$ce,$de,$f6,$e6,$7c,$00,$00,$30,$70
        .byte $30,$30,$30,$fc,$00,$00,$fc,$06,$7c,$c0,$c0,$fe,$00,$00,$fc,$06
        .byte $3c,$06,$06,$fc,$00,$00,$cc,$cc,$cc,$fe,$0c,$0c,$00,$00,$fe,$c0
        .byte $7c,$06,$c6,$7c,$00,$00,$7c,$c0,$fc,$c6,$c6,$7c,$00,$00,$fe,$0c
        .byte $18,$30,$60,$c0,$00,$00,$7c,$c6,$7c,$c6,$c6,$7c,$00,$00,$7c,$c6
        .byte $7e,$06,$c6,$7c,$00,$00,$18,$18,$00,$18,$18,$00,$00,$00,$18,$18
        .byte $00,$18,$08,$10,$00,$00,$00,$00,$00,$00,$00,$00,$01,$00,$00,$00
        .byte $00,$01,$15,$56,$6a,$00,$00,$00,$14,$55,$69,$aa,$aa,$00,$00,$00
        .byte $00,$00,$00,$40,$40,$00,$00,$00,$00,$01,$05,$16,$5a,$00,$00,$00
        .byte $40,$50,$90,$a4,$a4,$00,$00,$00,$01,$01,$05,$06,$16,$05,$16,$5a
        .byte $6a,$a9,$a5

    L_421e:
        sty $50,x
        tax 
        lda $95

        .byte $50,$40,$00,$00,$00,$56,$55,$01,$00,$00,$00,$00,$00,$40,$00,$00
        .byte $00,$00,$00,$00,$00,$01,$05,$06,$16,$1a,$1a,$59,$69,$69,$a5,$95
        .byte $91,$40,$40,$00,$00,$64,$64,$90,$50,$40,$00,$00,$00,$1a,$19,$59
        .byte $69,$64,$64,$64,$65,$40,$00,$00,$00,$00,$05,$15,$5a,$00,$00,$01
        .byte $15,$56,$6a,$aa,$a9,$01,$05,$06,$16,$5a,$5a,$69,$69,$54,$55,$a9
        .byte $aa,$5a,$5a,$69,$69,$54,$55,$a9,$aa,$9a,$56,$5a,$5a,$01,$05,$16
        .byte $5a,$69,$65,$66,$6a,$50,$54,$a4,$a9,$69,$a5,$95,$5a,$14,$55,$69
        .byte $6a,$a6,$a6,$a6,$95,$14,$54,$69,$a9

    L_429c:
        sta L_695c + $d,y
        adc $05
        ora $5a,x
        ror 
        lda $96
        tax 
        lda #$40

        .byte $50,$90,$a4,$a4,$90,$50,$50,$64,$64,$65,$65,$6a,$5a

    L_42b6:
        ora $05,x
        ora ($15,x)
        lsr $6a,x
        tax 
        sta $55,x
        eor ($00,x)
        eor ($45,x)
        stx $96,y
        txs 
        sta L_5499,y
        eor $a9,x
        tax 
        eor L_5956 + $3,y
        adc #$10
        eor ($65),y
        lda $65
        ldx $96
        stx $41,y
        eor $96
        stx $9a,y
        txs 
    L_42de:
        eor L_5060 + $9,y

        .byte $54,$a4,$a9,$59,$59,$59,$69,$05,$15,$5a,$6a,$a5,$96,$9a,$a9,$00
        .byte $41,$45,$96,$96,$96,$5a,$69,$50,$54,$a5,$a9,$69,$59,$5a,$5a,$14
        .byte $55,$69,$aa,$9a,$96,$96,$56,$00,$00,$00,$40,$40,$40,$40,$40,$69
        .byte $5a,$16,$05,$01,$00,$00,$00,$6a,$a9,$a5,$56,$56,$1a,$5a,$6a,$69
        .byte $a5,$a5,$91,$90,$90,$40,$40,$a4,$a4,$90,$50,$40,$00,$00,$00,$69
        .byte $6a,$5a,$15,$05,$00,$00,$00,$69,$aa,$96,$55,$41,$00,$00,$00,$a5
        .byte $a9,$9a,$55,$45,$00,$00,$00,$6a,$a6,$96,$55,$41,$00,$00,$00,$91
        .byte $40,$40,$00,$00,$00,$00,$00,$66,$6a,$69,$55,$14,$00,$00,$00,$95
        .byte $a6,$aa,$55,$55,$00,$00,$00,$a4,$90,$50,$40,$00,$00,$00,$00,$00
        .byte $00,$00,$00,$00,$04,$15,$19,$00,$00,$00,$00,$00,$00,$00,$55,$05
        .byte $06,$06,$16,$1a,$59,$69,$64,$99,$99,$5a,$55,$45,$00,$00,$00,$65
        .byte $a5,$91,$50,$40,$00,$00,$00,$96,$aa,$69,$55,$14,$00,$00,$00,$a9
        .byte $64,$64,$50,$10,$00,$00,$00,$65,$6a,$5a,$15,$05,$00,$00,$00,$95
        .byte $a6,$6a,$55,$15,$00,$00,$00,$a5,$95,$51,$41,$00,$00,$00,$00,$69
        .byte $69,$a4,$54,$50,$00,$00,$00,$5a,$5a,$69,$55,$14,$00,$00,$00,$40
        .byte $40,$00,$00,$00,$00,$00,$00,$2a,$2a,$2a,$2a,$02,$02,$02,$02,$a8
        .byte $a8,$a8,$a8,$80,$80,$80,$80,$a0,$a0,$a0,$a0,$a8,$a8,$a8,$a8,$a2
        .byte $a2,$a2,$a2,$a0,$a0,$a0,$a0,$aa,$aa,$aa,$aa,$28,$28,$28,$28,$89
        .byte $89,$85,$86,$16,$1a,$5a,$6a,$69,$a9,$a4,$a4,$90,$90,$90,$40,$aa
        .byte $aa,$aa,$aa,$a0,$a0,$a0,$a0,$82,$82,$a2,$a2,$a2,$a2,$a2,$a2

    L_4420:
        .byte $82,$82,$82,$82
        .byte $a2,$a2,$a2,$a2,$80,$80,$82,$82,$8a,$8a,$8a,$8a,$a0,$a0,$a8,$a8
        .byte $0a,$0a,$0a,$0a,$aa,$aa,$aa,$aa,$0a,$0a,$0a,$0a,$a0,$a0,$a0,$a0
        .byte $02,$02,$02,$02,$28,$28,$aa,$aa,$82,$82,$82,$82,$1a,$16,$05,$09
        .byte $8a,$8a,$8a,$8a,$55,$aa,$aa,$65,$55,$9a,$8a,$8a,$a6,$92,$5a,$4a
        .byte $28,$28,$28,$28,$80,$80,$a0,$a0,$28,$28,$28,$28,$a0,$a0,$a0,$a0
        .byte $a0,$a0,$a0,$a0,$2a,$2a,$aa,$aa,$a2,$a2,$a0,$a0,$00,$00,$82,$82
        .byte $8a,$8a,$0a,$0a,$02,$02,$0a,$0a,$28,$28,$28,$28,$0a,$0a,$2a,$2a
        .byte $a0,$a0,$a0,$a0,$02,$02,$82,$82,$a2,$a2,$02,$02,$aa,$aa,$aa,$aa
        .byte $80,$80,$80,$80,$2a,$2a,$2a,$2a,$28,$28,$28,$28,$a0,$a0,$a8,$a8
        .byte $28,$28,$28,$28,$02,$02,$02,$02,$02,$02,$02,$02,$80,$80,$80,$80
        .byte $80,$80,$80,$80,$aa,$aa,$aa,$aa,$aa,$aa,$a2,$a2,$28,$28,$28,$28
        .byte $28,$28,$28,$28,$6a,$69,$69,$66,$56,$1a,$0a,$0a,$40,$00,$a0,$a0
        .byte $a0,$a0,$00,$00,$a0,$a0,$aa,$aa,$aa,$aa,$aa,$aa,$a2,$a2,$82,$82
        .byte $82,$82,$82,$82,$aa,$aa,$aa,$aa,$aa,$aa,$8a,$8a,$8a,$8a,$8a,$8a
        .byte $8a,$8a,$8a,$8a,$0a,$0a,$aa,$aa,$aa,$aa,$aa,$aa,$0a,$0a,$0a,$0a
        .byte $0a,$0a,$0a,$0a,$82,$82,$82,$82,$82,$82,$82,$82,$aa,$aa,$aa,$aa
        .byte $aa,$aa,$2a,$2a,$28,$28,$2a,$2a,$2a,$2a,$2a,$2a,$28,$28,$a8,$a8
        .byte $a8,$a8,$a8,$a8,$a8,$a8,$2a,$2a,$0a,$0a,$02,$02,$0a,$0a,$0a,$0a
        .byte $8a,$8a,$8a,$8a,$80,$80,$a8,$a8,$a8,$a8

    L_454e:
        .byte $80,$80
        .byte $28,$28,$a0,$a0,$a0,$a0,$a0,$a0,$02,$02,$02,$02,$2a,$2a,$2a,$2a
        .byte $80,$80,$80,$80,$a8,$a8,$a8,$a8,$a2,$a2,$a0,$a0,$a0,$a0,$a0,$a0
        .byte $00,$00,$00,$00,$a8,$a8,$a8,$a8,$a2,$a2,$a2,$a2,$a2,$a2,$a2,$a2
        .byte $8a,$8a,$82,$82,$82,$82,$82,$82,$0a,$0a,$0a,$0a,$aa,$aa,$aa,$aa
        .byte $02,$02,$02,$02,$a2,$a2,$a2,$a2,$82,$82,$82,$82,$aa,$aa,$aa,$aa
        .byte $2a,$2a,$0a,$0a,$0a,$0a,$0a,$0a,$a0,$a0,$a0,$a0,$aa,$aa,$aa,$aa
        .byte $00,$00,$00,$00,$a0,$a0,$a0,$a0,$a2,$a2,$a2,$a2,$aa,$aa,$aa,$aa
        .byte $28,$28,$28,$28,$2a,$2a,$2a,$2a,$00,$00,$28,$28,$a8,$a8,$a8,$a8
        .byte $02,$02,$a2,$a2,$a2,$a2,$a2,$a2,$80,$80,$80,$80,$aa,$aa,$aa,$aa
        .byte $2a,$2a,$2a,$2a,$2a,$2a,$00,$00,$a8,$a8,$a8,$a8,$a8,$a8,$00,$00
        .byte $a0,$a0,$a0,$a0,$a0,$a0,$00,$00,$28,$28,$28,$28,$28,$28,$00,$00
        .byte $0a,$0a,$0a,$0a,$0a,$0a

    L_4606:
        .byte $00,$00
        .byte $a2,$a2

    L_460a:
        ldx #$a2
        ldx #$a2

        .byte $00,$00,$82,$82,$82,$82,$82,$82,$00,$00,$8a,$8a,$8a,$8a,$8a,$8a
        .byte $00,$00,$02,$02,$02,$02,$02,$02,$00,$00,$80,$80,$80,$80,$80,$80
        .byte $00,$00,$aa,$aa,$aa,$aa,$aa,$aa,$00,$00,$a2,$a2,$a0,$a0,$a0,$a0
        .byte $00,$00,$aa,$aa,$aa,$aa,$28,$28,$00,$00,$8a,$8a,$0a,$0a,$0a,$0a

    L_464e:
        .byte $00,$00
        .byte $aa,$aa,$aa,$aa,$2a,$2a,$00,$00,$8a,$8a,$82,$82,$00,$00,$00,$00
        .byte $aa,$aa,$a8,$a8,$a0,$a0,$00,$00,$2a,$2a,$0a,$0a,$02,$02,$00,$00
        .byte $a8,$a8,$a0,$a0,$80,$80,$00,$00,$aa,$aa,$2a,$2a,$0a,$0a,$00,$00
        .byte $a2,$a2,$82,$82,$02,$02

    L_4686:
        .fill $17a, $0
        .fill $78, $ff
        .byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$3c,$3d,$3e,$3f,$00,$00,$00
        .byte $00,$00,$00,$00,$00,$00,$40,$41,$00,$00,$00,$00,$00,$00,$00,$00
        .byte $00,$00,$00,$00,$00,$00,$20,$20,$00,$00,$00,$00,$00,$00,$00,$00
        .byte $42,$43,$44,$45,$46,$00,$00,$00,$00,$00,$00,$00,$00,$47,$48,$49
        .byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$20,$20
        .byte $00,$00,$00,$00,$00,$00,$00,$00,$4a,$4b,$4c,$4d,$4e,$4f,$50,$51
        .byte $52,$53,$54,$55,$00,$56,$57,$58,$59,$5a,$5b,$5c,$5d,$5e,$5f,$60
        .byte $61,$00,$00,$00,$00,$00,$20,$20,$00,$00,$00,$00,$00,$00,$00,$00
        .byte $62,$63,$64,$65,$66,$67,$68,$69,$6a,$6b,$6c,$6d,$6e,$6f,$70,$71
        .byte $72,$73,$74,$75,$76,$77,$78,$79,$7a,$00,$00,$00,$00,$00,$20,$20
        .byte $00,$00,$00,$7b,$7c,$7d,$7e,$7f,$80,$81,$82,$83,$84,$85,$86,$7b
        .byte $7c,$87,$88,$89,$8a,$8b,$8c,$8d,$8e,$00,$00,$8f,$90,$86,$91,$8d
        .byte $92,$93,$94,$95,$96,$00,$20,$20,$00,$00,$00,$97,$98,$99,$8e,$9a

    L_4948:
        .byte $9b,$9c
        .byte $9d,$9e,$9f,$a0,$a1,$97,$98,$a2,$97,$a3,$a0,$a4,$a5,$a6,$8e,$00
        .byte $00,$a7,$a8,$a2,$9a,$00,$8e,$97,$a9,$a5,$aa,$00,$20,$20,$00,$00
        .byte $00,$ab,$ac,$ad,$8e,$9a,$a2,$ae,$8e,$af,$b0,$a0,$a2,$97,$98

    L_4979:
        lda ($b2),y

        .byte $b3,$a0,$b4,$9a,$9a,$b5,$b6,$00,$b7,$a0,$b1,$b8,$b9,$b5,$ba,$bb
        .byte $9a,$9a,$00,$20,$20,$00,$00,$00,$bc,$bd,$be,$be,$bf,$c0,$bd,$be
        .byte $c1,$c2,$c3,$c0,$c4,$c5,$c6,$c7,$c8,$c9,$c0,$bf,$bf,$c6,$be,$00
        .byte $ca,$cb,$cc,$cd,$ce,$cf,$d0,$c6,$bf,$bf,$00,$20,$20
        .fill $85, $ff
        .byte $08,$01,$0c,$06,$ff,$0c,$05,$0e,$07,$14,$08,$ff,$3a,$ff,$32,$2e
        .byte $30,$30,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff
        .byte $ff,$ff,$0e,$15,$0d,$02,$05,$12,$ff,$0f,$06,$ff,$10,$0c,$01,$19
        .byte $05,$12,$13,$ff,$3a,$ff,$0f,$0e,$05
        .fill $13, $ff
        .byte $10,$0c,$01,$19,$05,$12,$ff,$31,$ff,$03,$0f,$0c,$0f,$15,$12,$ff
        .byte $3a,$ff,$19,$05,$0c,$0c,$0f,$17,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff
        .byte $ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$10,$0c,$01,$19,$05,$12,$ff,$32
        .byte $ff,$03,$0f,$0c,$0f,$15,$12,$ff,$3a,$ff,$17,$08,$09,$14,$05
        .fill $68, $ff
        .byte $0b,$09,$03,$0b,$ff,$0f,$06,$06
        .fill $60, $ff
        .byte $05,$13,$20,$0c,$14,$04,$2e,$20,$20,$20,$20,$20,$20,$03,$0f,$04
        .byte $05,$20,$02,$19,$20,$04,$01,$16,$05,$20,$13,$0f,$17,$05,$12,$02
        .byte $19,$2c,$20,$20,$07,$12,$01,$10
        .fill $38, $ff

    L_4bf8:
        clv 
    L_4bf9:
        clv 

    L_4bfa:
         .byte $00,$00,$00,$00,$ff,$00

    L_4c00:
        lsr $56,x
        lsr $56,x
        lsr $56,x
        lsr $56,x
        lsr $56,x
        lsr $56,x
        lsr $56,x
        lsr $56,x
        lsr $56,x
        lsr $56,x
        lsr $56,x
        lsr $56,x
        lsr $56,x
        lsr $56,x
        lsr $56,x
        lsr $56,x
        lsr $56,x
        lsr $56,x
        lsr $56,x
        lsr $56,x
    L_4c28:
        lsr $56,x
        lsr $56,x
        lsr $56,x
        lsr $56,x
        lsr $56,x
        lsr $56,x
        lsr $56,x
        lsr $56,x
        lsr $56,x
        lsr $56,x
        lsr $56,x
        lsr $56,x
        lsr $56,x
        lsr $56,x
        lsr $56,x
        lsr $56,x
        lsr $56,x
        lsr $56,x
        lsr $56,x
        lsr $56,x
    L_4c50:
        lsr $56,x
        lsr $56,x
        lsr $56,x
        lsr $56,x
        lsr $56,x
        lsr $56,x
        lsr $56,x
        lsr $56,x
        lsr $56,x
        lsr $56,x
        lsr $56,x
        lsr $56,x
        lsr $56,x
        lsr $56,x
        lsr $56,x
        lsr $56,x
        lsr $56,x
        lsr $56,x
        lsr $56,x
        lsr $56,x
    L_4c78:
        lsr $56,x
        lsr $56,x
        lsr $56,x
        lsr $56,x
        lsr $56,x
        lsr $56,x
        lsr $56,x
        lsr $56,x
        lsr $56,x
        lsr $56,x
        lsr $56,x
        lsr $56,x
        lsr $56,x
        lsr $56,x
        lsr $56,x
        lsr $56,x
        lsr $56,x
        lsr $56,x
        lsr $56,x
        lsr $56,x

    L_4ca0:
         .fill $3a, $ff
        .byte $07,$07

    L_4cdc:
        .fill $22, $ff
        .byte $36,$35,$34,$06,$ff,$ff,$06,$2a,$33,$32

    L_4d08:
        .fill $1c, $ff
        .byte $38,$37,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$31,$30,$ff,$ff
        .byte $ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff

    L_4d40:
        lsr $56,x
        lsr $56,x
        lsr $56,x
        lsr $56,x
        lsr $56,x
        lsr $77,x
        sei 
        lsr $56,x
        lsr $56,x
        lsr $56,x
        lsr $56,x
    L_4d55:
        lsr $56,x
        lsr $56,x

        .byte $7c,$7d
        .fill $17, $56
        .byte $79,$7a,$56,$56,$56,$56,$56,$56,$56,$56,$56,$56,$56,$56,$56,$56
        .byte $7e,$7f
        .fill $16, $56
        .byte $7b,$56,$56,$56,$56,$56,$56,$56,$56,$56,$56,$56,$56,$56,$56,$56
        .byte $56,$80,$56,$56,$56,$56,$56,$56,$56,$56,$56,$56,$56,$56

    L_4db8:
        adc ($61,x)
        adc ($61,x)
        adc ($61,x)
        adc ($61,x)
        adc ($61,x)
        rol $61
        adc ($61,x)
        adc ($61,x)
        adc ($61,x)

        .byte $0c,$0d,$61,$61,$61,$61,$61,$61,$61,$27,$61,$61,$61,$61,$61,$61
        .byte $61,$61,$61,$61,$61,$61

    L_4de0:
        asl $06
        asl $06
        asl $06
        asl $06
        asl $06
        and #$06
        asl $06
        asl $06
        asl $06
        asl SCREEN_BUFFER_0 + $20f
        asl $06
        asl $06
        asl $06
        plp 
        asl $06
        asl $06
        asl $06
        asl $06
        asl $06
        asl $06

    L_4e08:
         .byte $ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$50,$ff,$ff,$ff,$ff,$ff
        .byte $ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$3e,$ff,$ff

    L_4e26:
        .fill $14, $ff
        .byte $51,$4f

    L_4e3c:
        .byte $ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff
        .byte $40,$3f

    L_4e4c:
        .fill $17, $ff
        .byte $4e,$4d,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$42,$41
        .byte $ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff

    L_4e80:
        lsr $56,x
        lsr $56,x
        lsr $56,x
        lsr $56,x
        lsr $56,x
        lsr $56,x

        .byte $72,$73,$56,$56,$56,$56,$56,$56,$56,$56,$56,$56,$70,$71,$56,$56
        .byte $56,$56,$56,$56,$56,$56,$56,$56,$56,$56,$56,$56

    L_4ea8:
        lsr $56,x
        lsr $56,x
        lsr $56,x
        lsr $56,x
        lsr $56,x
        lsr $56,x
        lsr $56,x

        .byte $74,$75,$76,$61,$56,$56,$61,$6d,$6e,$6f,$56,$56,$56,$56,$56,$56
        .byte $56,$56,$56,$56,$56,$56,$56,$56,$56,$56

    L_4ed0:
        lsr $56,x
        lsr $56,x
        lsr $56,x
        lsr $56,x
        lsr $56,x
        lsr $56,x
        lsr $56,x
        lsr $56,x
        lsr $56,x

        .byte $62,$62
        .fill $14, $56

    L_4ef8:
        lsr $56,x
        lsr $56,x
        lsr $56,x
        lsr $56,x
        lsr $56,x
        lsr $56,x
        lsr $56,x
        lsr $56,x
        lsr $56,x
        lsr $56,x
        lsr $56,x
        lsr $56,x
        lsr $56,x
        lsr $56,x
        lsr $56,x
        lsr $56,x
        lsr $56,x
        lsr $56,x
        lsr $56,x
        lsr $56,x

    L_4f20:
         .fill $53, $ff

    L_4f73:
        .byte $ef,$ef

    L_4f75:
        inc $f0ef

        .fill $18, $ff

    L_4f90:
        .byte $ef,$f0,$ed,$f4,$f4

    L_4f95:
        .fill $2b, $ff

    L_4fc0:
        lsr $56,x
        lsr $56,x
        lsr $56,x
        lsr $56,x
        lsr $56,x
        lsr $56,x
        lsr $56,x
        lsr $56,x
        lsr $56,x
        lsr $56,x
        lsr $56,x
    L_4fd6:
        lsr $56,x
        lsr $56,x
        lsr $56,x
        lsr $56,x
        lsr $56,x
        lsr $56,x
        lsr $56,x
        lsr $56,x
        lsr $56,x

        .byte $ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff

    L_4ff8:
        .byte $00,$00,$00,$00,$00,$00,$ff,$00,$00,$00,$00,$0f,$00,$00,$0f,$00
        .byte $00,$0f,$00,$00,$3a,$c0,$00,$2a,$80,$00,$0a,$40,$00,$0a,$40,$00
        .byte $0a,$00,$00,$0f,$00,$00,$0d,$00,$00,$0d,$00,$00,$0d,$00,$00,$02
        .byte $00,$00,$03,$c0,$00,$00,$f3,$00,$00,$ff,$00,$00,$3f,$c0,$00,$03
        .byte $c0,$00,$00,$00,$00,$00,$00,$00,$0f,$00,$00,$0f,$00,$00,$0f,$00
        .byte $00,$3a,$c0,$00,$2a

    L_504d:
        .byte $80,$00,$1a
        .byte $40,$00,$0a,$00,$00,$0a,$00,$00,$0f,$00,$00,$05,$00,$00,$05,$00

    L_5060:
        .byte $00,$0b,$00,$00,$0f,$00,$00,$00,$00,$00,$00,$c3,$00,$00,$f3,$00
        .byte $00,$3f,$c0,$00,$3f,$f0,$00,$00,$f0,$00,$00,$00,$00,$00,$00,$00
        .byte $00,$00,$00,$0f,$00,$00,$0f,$00,$00,$0f,$00,$00,$3a,$c0,$00,$2a
        .byte $80,$00,$1a,$00,$00,$1a,$00,$00,$0a

    L_5099:
        .byte $00,$00,$0f,$00,$00,$07,$00,$00,$07,$00,$00,$07,$00,$00
        .byte $08,$00,$00,$0c,$30,$00,$03,$f3,$00,$00,$ff,$00,$00,$3f,$c0,$00
        .byte $0f,$c0,$00,$00,$00,$00,$00,$00,$00,$0f,$00,$00,$0f,$00,$00,$0f
        .byte $00,$00,$3a,$c0,$00,$2a,$80,$00,$1a,$40,$00,$0a,$00,$00,$0a,$00
        .byte $00,$0f,$00,$00,$05,$00,$00,$06,$00

    L_50e0:
        .byte $00,$0f,$00,$00,$0c,$00,$00,$00,$00,$00,$00,$30,$00,$00,$f0,$00
        .byte $00,$ff,$c0,$00,$3f,$f0,$00,$03,$f0,$00,$00,$00,$00,$00,$00,$00
        .byte $00,$00,$00,$0f,$00,$00,$0f,$00,$00,$0f,$00,$00,$0b,$00,$00,$0a
        .byte $80,$00,$09,$40,$00,$09,$40,$00,$0e,$00,$00,$0f,$40,$00,$34,$40
        .byte $00,$34,$b0,$00

    L_5124:
        .byte $30,$c0,$00,$00,$00,$00,$00,$3c,$00,$00,$ff,$00,$03,$ff
        .byte $c0,$00,$03,$c0,$00

    L_5137:
        .byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$0f,$00,$00,$0f,$00,$00,$0f
        .byte $00,$00,$0b,$00,$00,$1a,$80,$00,$1a,$40,$00,$0a,$40,$00,$0e,$00
        .byte $00,$0f,$00,$00,$05,$00,$00,$39,$00,$00,$31,$00,$00,$02,$c0,$00
        .byte $03,$00,$00,$03,$c0,$00,$00,$ff,$00,$00,$3f,$f0,$00,$00,$f0,$00
        .byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$0f,$00,$00,$0f,$00,$00,$0f
        .byte $00,$00,$0b,$00,$00,$1a,$80,$00,$1a,$40,$00,$1a,$00,$00,$1e,$00
        .byte $00,$0f,$00,$00,$07,$00,$00,$07,$c0,$00,$04,$00,$00,$08,$00,$00
        .byte $30,$30,$00,$0c,$0c,$00,$0c,$3c,$00,$03,$ff,$f0,$00,$0f,$f0,$00
        .byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$0f,$00,$00,$0f
        .byte $00,$00,$0f,$00,$00,$0b,$00,$00,$1a,$80,$00,$1a,$40,$00,$0a,$40
        .byte $00,$0e,$00,$00,$0f,$00,$00,$37,$00,$00,$37,$c0,$00,$33,$00,$00
        .byte $00,$00,$00,$00,$0c,$00,$00,$3f,$00,$03,$ff,$c0,$00,$03,$c0,$00
        .byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$0f,$00,$00,$0f,$00,$00,$0f
        .byte $00,$00,$0b,$00,$00,$0a,$80,$00,$09,$40,$00,$09,$40,$00,$0e,$00
        .byte $00,$0f,$00,$00,$0d,$00,$00,$0e,$00,$00,$0f,$00,$00,$0c,$00,$00
        .byte $03,$00,$00,$03,$f0,$00,$00,$ff,$00,$00,$3f,$f0,$00,$00,$f0,$00
        .byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$0f

    L_5241:
        .byte $00,$00,$0f,$00,$00,$0f,$00,$00,$0b,$00,$00,$1a,$80,$00,$1a
        .byte $40,$00,$0a,$40,$00,$0e,$00,$00,$0f,$00,$00,$06,$40,$00,$07,$40
        .byte $00,$04,$c0,$00,$08,$00,$00,$30,$00,$00,$0c,$3c,$00,$0f,$ff,$00
        .byte $00,$ff,$f0,$00,$00,$f0,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
        .byte $00,$00,$00,$03,$00,$00,$0d,$00,$00,$0d,$00,$00,$0d,$00,$00,$2b
        .byte $00,$00,$5a,$f0,$00

    L_5295:
        lsr 
        cpy #$00
        asl 

        .byte $00,$00,$0f,$00,$00,$0d,$40,$00,$3f,$40,$00,$e4,$40,$00,$04,$b0
        .byte $00,$00,$c0,$00,$00,$f3,$c0,$03,$fc,$00,$00,$3f,$00,$00,$0f,$00
        .byte $00,$00,$00,$00,$00,$00,$00,$03,$00,$00,$0d,$00,$00,$0d,$00,$00
        .byte $0d,$00,$00,$0b,$00,$00,$16,$00,$00,$1a,$c0,$00,$0a,$00,$00,$0f
        .byte $00,$00,$0f,$00,$00,$01,$c0,$00,$0d,$c0,$00,$0d,$00,$00,$02,$00
        .byte $00,$03,$c0,$00,$03,$f0,$00,$00,$ff,$00,$00,$3f,$c0,$00,$03,$c0
        .byte $00,$00,$00,$00,$00,$00,$00,$03,$00,$00,$0d,$00,$00,$0d,$00,$00
        .byte $0d,$00,$00,$0b,$00,$00,$06,$00,$00,$05,$00,$00,$0a,$00,$00,$0f
        .byte $00,$00,$0f,$c0,$00,$04,$c0,$00,$07,$00,$00,$38,$c0,$00,$30,$00
        .byte $00,$30,$0f,$00,$0f,$fc,$00,$03,$ff,$00,$00,$ff,$c0,$00,$03,$c0
        .byte $00

    L_533a:
        .byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$03,$00,$00
        .byte $0d,$00,$00,$0d,$00,$00,$0d,$00,$00,$3b,$00,$00,$fa,$50,$00

    L_5355:
        asl 
        rti 

        .byte $00,$0a,$00,$00,$0f,$00,$00,$0f,$c0,$00,$37,$c0,$00,$e4,$c0,$00
        .byte $04,$f0,$00,$00,$c0,$00,$00,$3c,$00,$03,$ff,$c0,$00,$3f,$00,$00
        .byte $0f,$00,$00,$00,$00,$00,$00,$00,$00,$03,$00,$00,$0d,$00,$00,$0d
        .byte $00,$00,$0d,$00,$00,$0b,$00,$00,$06,$00,$00,$05,$00,$00,$0a,$00
        .byte $00,$0f,$00,$00,$0d,$00,$00,$01,$40,$00,$0e,$40,$00,$0f,$00,$00
        .byte $03,$00,$00,$03,$c0,$00

    L_53ad:
        .byte $03,$f0,$00,$00,$ff,$00,$00,$3f
        .byte $c0,$00,$03,$c0,$00,$00,$00,$00,$00,$00,$00,$03,$00,$00,$0d,$00
        .byte $00,$0d,$00,$00,$0d,$00,$00,$0b,$00,$00,$16,$00,$00,$1a,$c0,$00
        .byte $0a,$00,$00,$0f,$00,$00,$0d,$40,$00,$0c,$40,$00,$0c,$80,$00,$30
        .byte $f0,$00,$30,$00,$00,$0c,$0f,$00,$0f,$fc,$00,$00,$ff,$00,$00,$3f
        .byte $c0,$00,$03,$c0,$00,$00,$00,$00,$00,$00,$00,$03,$00,$00,$0f,$00
        .byte $00,$0d,$00,$00,$0d,$00,$00,$09,$00,$00,$2a,$00,$00,$1a,$40,$00
        .byte $16,$00,$00,$07,$00,$00,$0f,$40,$00,$04,$40,$00,$06,$00,$00,$07
        .byte $00,$00,$08,$00,$00,$0c,$c0,$00,$03,$30,$00,$03,$fc,$00,$00,$ff
        .byte $00,$00,$0f,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$03,$00
        .byte $00,$0f,$00,$00,$0d,$00,$00

    L_544c:
        ora.a $0000
        and.a $0000,y

        .byte $3a,$00,$00,$06,$00,$00,$06,$00,$00,$09,$00,$00,$0f,$40,$00,$04
        .byte $40,$00,$04,$80,$00,$34,$f0,$00

    L_546a:
        .byte $30,$00,$00,$0c,$3c,$00,$03,$f0,$00,$00,$fc,$00,$00,$3c,$00,$00
        .byte $00,$00,$00,$00,$00,$00,$03,$00,$00,$0f,$00,$00,$3d,$00,$00,$3d
        .byte $00,$00,$39,$00,$00,$0a,$00,$00,$05,$40,$00,$05,$00,$00,$0b

    L_5499:
        rti 

        .byte $00,$ef,$40,$00,$e4,$40,$00,$c4,$40,$00,$00,$80,$00,$00,$c0,$00
        .byte $00,$30,$00,$03,$f0,$00,$0f,$ff,$00,$00,$3f,$00,$00,$0f,$00,$00
        .byte $00,$00,$00,$00,$00,$00,$03,$00,$00,$0f,$00,$00,$0d,$00,$00,$0d
        .byte $00,$00,$39,$00,$00,$3a,$00,$00,$06,$00,$00,$06,$00,$00,$09,$00
        .byte $00,$0f,$00,$00,$05,$00,$00,$36,$00,$00,$3c,$00,$00,$03,$00,$00
        .byte $03,$c0,$00,$00,$f0,$00,$03,$ff,$00,$00,$3f,$00,$00,$0f,$00,$00
        .byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$03,$00,$00,$0f,$00,$00,$0d
        .byte $00,$00,$0d,$00,$00,$39,$00,$00,$2a,$00,$00,$1a,$40,$00,$16,$00
        .byte $00,$07,$00,$00,$0f,$00,$00,$3d,$00,$00,$31,$40,$00,$32,$40,$00
        .byte $03,$00,$00,$0f,$30,$00,$03,$fc,$00,$00,$fc,$00,$00,$3c,$00,$00
        .byte $00,$00,$00,$00,$00,$00,$03,$00,$00,$0f,$00,$00,$0d,$00,$00,$0d
        .byte $00,$00,$29,$00,$00

    L_554f:
        ror 
        cpy #$00

        .byte $5a,$40,$00,$1a,$50,$00,$0b,$00,$00,$0f,$00,$00,$0d,$00,$00,$0d
        .byte $00,$00,$01,$00,$00,$01,$00,$00,$02,$00,$00,$03,$00,$00,$03,$ff
        .byte $00,$03,$ff,$00,$00,$0f,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
        .byte $00,$0f,$00,$00,$0f,$00,$00,$05,$00,$00,$35,$c0,$00,$2b,$80,$00
        .byte $3a,$40,$00,$1a,$40,$00,$0a,$00,$00,$0f,$00,$00,$0d,$00,$00,$0d
        .byte $00,$00,$0d,$00,$00,$02,$00,$00,$03,$cc,$00,$00,$f3,$00,$00,$ff
        .byte $00,$00,$3f,$c0,$00,$03,$c0,$00,$00,$00,$00,$00,$00,$00,$0f,$00
        .byte $00,$0f,$00,$00,$05,$00,$00,$35,$c0,$00,$2b,$90,$00,$1a,$10,$00

    L_55d2:
        asl $00,x

        .byte $00,$0a,$00,$00,$0f,$00,$00,$05,$00,$00,$05,$00,$00,$0d,$00,$00
        .byte $02,$00,$00,$03,$00,$00,$00,$c3,$00,$00,$f3,$00,$00,$3f,$c0,$00
        .byte $3f,$f0,$00,$00,$f0,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$0f
        .byte $00,$00,$0f,$00,$00,$05,$00

    L_560b:
        .byte $00
        .byte $35,$80,$00,$2b,$c0,$00,$1a,$40,$00,$1a,$00,$00,$0a,$00,$00,$0f
        .byte $00,$00,$07,$00,$00,$07,$00,$00,$07,$00,$00,$08,$00,$00,$0c,$30
        .byte $00,$03,$f3,$00,$00,$ff,$00,$00,$3f,$c0,$00,$0f,$c0,$00,$00,$00
        .byte $00,$00,$00,$00,$0f,$00,$00,$0f,$00,$00,$05,$00,$00,$35,$c0,$00
        .byte $6b,$80,$00,$4a,$40,$00,$09,$40,$00,$0a

    L_5656:
        .byte $00,$00,$0f,$00,$00
        .byte $05,$00,$00,$05,$00,$00,$07,$00,$00,$08,$00,$00,$0c,$00,$00,$03
        .byte $30,$00,$00,$f0,$00,$00,$ff,$c0,$00

    L_5674:
        .byte $3f,$f0,$00,$03,$f0,$00,$00,$00,$00,$00,$00,$00,$0c,$00,$00,$0f
        .byte $00,$00,$07,$00,$00,$07,$00,$00,$06,$00,$00,$0a,$80,$00,$1a,$40
        .byte $00,$09,$40,$00,$0d,$00,$00,$1f,$00,$00,$11,$00,$00,$09,$00,$00
        .byte $0d,$00,$00,$02,$00,$00,$03,$00,$00,$0f,$fc,$00,$00,$ff,$00,$00
        .byte $ff,$f0,$00,$0c,$f0,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$0c
        .byte $00,$00,$0f,$00,$00,$07,$00,$00,$07,$00,$00,$06,$c0,$00,$0a,$c0
        .byte $00,$09,$00,$00,$09,$00,$00,$06,$00,$00,$1f,$00,$00,$11,$00,$00
        .byte $21,$00,$00,$f1,$c0,$00,$00,$c0,$00,$03,$c0,$00,$00,$ff,$00,$00
        .byte $ff,$c0,$03,$03,$c0,$00,$00,$00,$00,$00,$00,$00,$0c,$00,$00,$0f
        .byte $00,$00,$07,$c0,$00,$07,$c0,$00,$06,$c0,$00,$0a,$00,$00,$15,$00
        .byte $00,$05,$00,$00,$1e,$00,$00,$1f,$b0,$00

    L_571e:
        ora ($b0),y

        .byte $00,$11,$30,$00,$20,$00,$00,$30,$00,$00,$c0,$00,$00,$0c,$0c,$00
        .byte $0f,$ff,$00,$00,$ff,$f0,$00,$0c,$f0,$00,$00,$00,$00,$00,$00,$00
        .byte $0c,$00,$00,$0f,$00,$00,$07,$00,$00,$07,$00,$00,$06,$c0,$00

    L_574f:
        asl 
        cpy #$00
        ora #$00

        .byte $00,$09,$00,$00,$06,$00,$00,$0f,$00,$00,$05,$00,$00,$09,$c0,$00
        .byte $03,$c0,$00,$0c,$00,$00,$03,$0c,$00,$00,$fc,$00,$00,$3f,$00,$00
        .byte $0f,$f0,$00,$00,$f0,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$0c
        .byte $00,$00,$0f,$00,$00,$07,$00,$00,$07,$00,$00,$06,$c0,$00,$0a,$80
        .byte $00,$1a,$40,$00,$09,$40,$00,$0d,$00,$00,$0f,$00,$00,$07,$c0,$00
        .byte $14,$c0,$00,$18,$c0,$00,$0c,$c0,$00,$0c,$30,$00,$00,$fc,$00,$03
        .byte $ff,$c0,$00,$c3,$c0,$00,$00,$00,$00,$00,$00,$00,$0c,$00,$00,$0f
        .byte $00,$00,$07,$00,$00,$07,$00,$00,$06,$80,$00,$3a,$90,$00,$1a,$50
        .byte $00,$5a,$40,$00,$0e,$00,$00,$0f,$00,$00,$07,$00,$00,$07,$00,$00
        .byte $04,$00,$00,$04,$00,$00,$08,$30,$00,$0c,$33,$00,$3f,$ff,$00,$00
        .byte $3f,$f0,$00

    L_57f7:
        .byte $30,$f0,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$0c,$00,$00,$07
        .byte $00,$00,$07,$00,$00,$07,$00,$00,$0e,$80,$00,$fa,$50,$00,$3a,$10
        .byte $00

    L_5818:
        asl 

        .byte $00,$00,$0f,$00,$00,$17,$00,$00,$1f,$c0,$00,$11,$b0,$00,$e1,$00
        .byte $00,$30,$00,$00,$00,$0c,$00,$00,$fc,$00,$0f,$ff,$c0,$03,$03,$c0
        .byte $00,$00,$00,$00,$00,$00,$00,$0c,$00,$00,$07,$00,$00,$07,$00,$00
        .byte $07,$00,$00,$0e,$00,$00,$09,$40,$00,$3a,$40,$00,$0a

    L_5856:
        .byte $00,$00,$0f,$00,$00,$0f,$00,$00,$34,$00,$00,$37,$00,$00,$07,$00
        .byte $00,$08,$00,$00,$3c,$00,$00,$0f,$3c,$00,$00,$ff,$00,$00,$3f,$f0
        .byte $00,$00,$f0,$00,$00,$00,$00,$00,$00,$00,$0c,$00,$00,$07,$00,$00
        .byte $07,$00,$00,$07,$00,$00,$0e,$00,$00,$09,$00,$00,$05,$00,$00,$0a
        .byte $00,$00,$0f,$00,$00,$3f,$00,$00,$31,$00,$00,$0d,$00,$00,$32,$c0
        .byte $00,$00,$c0,$00,$00,$c0,$00,$03,$f3,$00,$00,$3f,$00,$00,$ff,$f0
        .byte $00,$00,$f0,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$0c,$00,$00
        .byte $07,$00,$00,$07,$00,$00,$07,$00,$00,$0e,$c0,$00,$5a,$f0,$00,$1a
        .byte $00,$00,$0a,$00,$00,$0f,$00,$00,$3f,$00,$00,$3d,$c0,$00,$31,$b0
        .byte $00,$f1,$00,$00,$30,$00,$00,$00,$0c,$00,$0f,$ff,$00,$03,$ff,$c0
        .byte $00,$33,$c0,$00,$00,$00,$00,$00,$00,$00,$0c,$00,$00,$07,$00,$00
        .byte $07,$00,$00,$07,$00,$00,$0e,$00,$00,$09,$00,$00,$05,$00,$00,$0a
        .byte $00,$00,$0f,$00,$00,$07,$00,$00,$14,$00,$00,$1b,$00,$00,$0f,$00
        .byte $00,$0c,$00,$00,$3c,$00,$00,$0f,$00,$00,$03,$fc,$00,$00,$ff,$f0

    L_5936:
        .byte $00,$00,$f0,$00,$00,$00,$00,$00,$00,$00,$0c,$00,$00,$07,$00,$00
        .byte $07,$00,$00,$07,$00,$00,$0e,$00,$00,$09,$40,$00,$3a,$40,$00,$0a

    L_5956:
        .byte $00,$00,$0f,$00,$00,$17,$00,$00,$13,$00,$00,$23,$00,$00,$f0,$c0
        .byte $00,$00,$c0,$00,$03,$00,$00,$03,$c0,$00,$00,$ff,$00,$0f,$ff,$f0
        .byte $00,$00,$f0,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$0f,$00,$00
        .byte $0f,$00,$00,$0f,$00,$00,$0e,$00,$00,$2a,$00,$00,$16,$00,$00,$16
        .byte $00,$00,$0b,$00,$00,$1f,$00,$00,$11,$c0,$00,$e1,$c0,$00,$30,$c0
        .byte $00,$00,$00,$00,$0f,$00,$00,$03,$f0,$00,$00,$fc,$00,$00,$3f,$c0
        .byte $00,$03,$c0,$00,$00,$00,$00,$00,$00,$00,$0f,$00,$00,$0f,$00,$00
        .byte $0f,$00,$00,$0e,$00,$00,$2a,$40,$00,$1a,$40,$00,$1a,$00,$00,$0b
        .byte $00,$00,$0f,$00,$00,$05,$00,$00,$06,$c0,$00,$04,$c0,$00,$38,$00
        .byte $00,$0c,$00,$00,$0c,$00,$00,$03,$30,$00,$00,$fc,$00,$00,$3f

    L_59f5:
        .byte $f0,$00,$00,$f0,$00,$00,$00,$00,$00,$00,$00,$0f,$00,$00,$0f,$00
        .byte $00,$0f,$00,$00,$0e,$00,$00,$2a,$40,$00,$1a,$40,$00,$0a,$40,$00
        .byte $0b,$40,$00,$0f,$00,$00,$0d,$00,$00,$3d,$00,$00,$01,$00,$00,$02
        .byte $00,$00,$00,$c0,$00,$03,$00,$00,$03,$cc,$00,$00,$ff,$00,$00,$3f
        .byte $f0,$00,$00,$f0,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$0f,$00
        .byte $00,$0f,$00,$00,$0f,$00,$00,$0e,$00,$00,$2a,$40,$00,$1a,$40,$00
        .byte $1a,$00,$00,$0b,$00,$00,$0f,$00,$00,$0d,$c0,$00,$3d,$c0,$00,$0c
        .byte $c0,$00,$00,$00,$00,$00,$00,$00,$0f,$30,$00,$03,$fc,$00,$00,$3f
        .byte $c0,$00,$03,$c0,$00,$00,$00,$00,$00,$00,$00,$0f,$00,$00,$0f,$00
        .byte $00,$0f,$00,$00,$0e,$00,$00,$2a,$00,$00,$16,$00,$00,$16,$00

    L_5a94:
        .byte $00,$0b,$00,$00,$0f,$00,$00,$07,$00,$00,$0b,$00,$00,$0f,$00,$00
        .byte $03,$00,$00,$0c,$00,$00,$0f,$00,$00,$03,$f0,$00,$00,$ff,$00,$00
        .byte $0f,$f0,$00,$00,$f0,$00,$00,$00,$00,$00,$00,$00,$0f,$00,$00,$0f
        .byte $00,$00,$0f,$00,$00,$0e,$00,$00,$2a,$40,$00,$1a,$40,$00,$1a,$00
        .byte $00,$0b,$00,$00,$0f,$00,$00,$19,$00,$00,$1d,$00,$00,$31,$00,$00
        .byte $02,$00,$00,$00,$c0,$00,$03,$00,$00,$03,$f0,$00,$00,$fc,$00,$00
        .byte $3f,$f0,$00,$00,$f0

    L_5af9:
        .fill $11, $0
        .byte $3c,$00,$00,$3c,$00,$00,$14,$00,$00,$96,$00,$00,$6d,$00,$01,$28
        .byte $40,$00,$28,$00,$00,$3c,$00,$00,$55,$00,$00,$41,$00,$00,$82,$00
        .byte $00,$c3,$00,$00,$3c,$f0,$00,$03,$fc,$00,$00,$ff,$00

    L_5b37:
        .byte $00,$0f,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$10,$00
        .byte $00,$40,$00,$01,$f1,$00,$03,$74,$00,$0a,$74,$00,$3a,$a0,$00,$7e
        .byte $80,$01

    L_5b59:
        .byte $5f,$00
        .byte $0e,$14,$00,$0c,$50,$00,$03,$80,$00,$03,$00,$00,$00,$00,$00,$00
        .byte $3f,$00,$00,$0f,$fc,$00,$00,$ff,$00,$00,$0f,$00,$00,$00,$00,$00
        .byte $00,$00,$00,$00,$00,$00,$00,$00,$05,$00,$00,$01,$40,$00,$5f,$40
        .byte $00,$15,$e0,$00,$0d,$a0,$00,$0a,$ac,$00,$02,$bd,$00,$00,$f5,$40
        .byte $00,$14,$80,$00,$05,$30,$00,$02,$00,$00,$00,$c0,$00,$00,$00,$00
        .byte $00,$00,$00,$03,$ff,$00,$ff,$fc,$03,$ff,$00,$00,$00,$00,$00,$00
        .byte $00,$00,$00,$00,$00,$00,$41,$00,$00,$41,$00,$00,$7d,$00,$00,$55
        .byte $00,$00,$96,$00,$00,$2c,$00,$00,$28,$00,$00,$28,$00,$00,$3c,$00
        .byte $00,$14,$00,$00,$14,$00,$00,$14,$00,$00,$28,$00,$00,$3c,$00,$00
        .byte $00,$00,$00,$03,$f0,$00,$00,$fc,$00,$00,$ff,$00,$00,$0f,$00,$00
        .byte $03
        .fill $1d, $0
        .byte $c0,$00,$00,$30,$00,$00,$10,$00,$00,$10,$00,$00,$1e,$af,$00,$1e
        .byte $af,$03,$5e,$65,$00,$01,$7c,$00,$00,$40
        .fill $26, $0
        .byte $03,$00,$00,$0c,$00,$00,$08,$00,$00,$04,$00,$fa,$b4,$00,$fa,$b4
        .byte $00,$59,$b6,$c0,$3d,$40,$00,$01
        .fill $18, $0
        .byte $03,$5e,$a5,$03,$5e,$9c,$00,$0e,$9c,$03,$5e,$9c,$03,$5e,$a5
        .fill $16, $0
        .byte $3f,$c0,$00,$0f,$fc,$00,$00,$ff
        .fill $13, $0
        .byte $5a,$b5,$c0,$36,$b5,$c0,$36,$b0,$00

    L_5cd2:
        rol $b5,x
        cpy #$5a
        lda $c0,x

        .fill $15, $0
        .byte $0f,$f0,$00,$03,$ff,$00,$00,$0f,$f0
        .fill $14, $0
        .byte $3c,$00,$00,$3c,$00,$00,$3c,$00,$00,$aa,$00,$00,$69,$00,$01,$28
        .byte $40,$00,$28,$00,$00,$3c,$00,$00,$55,$00,$00,$41,$00,$00,$82,$00
        .byte $00,$c3,$00,$00,$3c,$f0,$00,$03,$fc,$00,$00,$ff,$00,$00,$0f,$00
        .byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$10,$00,$00,$40,$00
        .byte $01,$f1,$00,$02,$f4,$00,$0a,$b4,$00,$3a,$a0,$00,$7e,$80,$01,$5f
        .byte $00,$0e,$14,$00,$0c,$50,$00,$03,$80,$00,$03,$00,$00,$00,$00,$00
        .byte $00,$3f,$00,$00,$0f,$fc,$00,$00,$ff,$00,$00,$0f,$00,$00,$00,$00
        .byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$05,$00,$00,$01,$40,$00,$5f
        .byte $40,$00,$1f,$a0,$00,$06,$a0,$00,$0a,$ac,$00,$02,$bd,$00,$00,$f5
        .byte $40,$00,$14,$80,$00,$05,$30,$00,$02,$00,$00,$00,$c0,$00,$00,$00
        .byte $00,$00,$00,$00,$03,$ff,$00,$ff,$fc,$03,$ff,$00,$00,$00,$00,$00
        .byte $00,$00,$00,$00,$00,$00,$00,$41,$00,$00,$41,$00,$00,$7d,$00,$00
        .byte $7d,$00,$00,$be,$00,$00,$28,$00,$00,$28,$00,$00,$28,$00,$00,$3c
        .byte $00,$00,$14,$00,$00,$14,$00,$00,$14,$00,$00,$28,$00,$00,$3c,$00
        .byte $00,$00,$00,$00,$03,$f0,$00,$00,$fc,$00,$00,$ff,$00,$00,$0f,$00
        .byte $00,$03
        .fill $1d, $0
        .byte $c0,$00,$00,$30,$00,$00,$20,$00,$00,$10,$00,$00,$1e,$af,$00,$1e
        .byte $af,$03,$9e,$6f,$00,$00,$50,$00,$00,$14
        .fill $26, $0
        .byte $03,$00,$00,$0c,$00,$00,$08,$00,$00,$04,$00,$fa,$b4,$00,$fa,$b4
        .byte $00,$f9,$b6,$c0,$05,$00,$00,$14
        .fill $18, $0
        .byte $03,$5e,$a5,$03,$5e,$bc,$00,$0e,$bc,$03,$5e,$bc,$03,$5e,$a5
        .fill $16, $0
        .byte $3f,$c0,$00,$0f,$fc,$00,$00,$ff
        .fill $13, $0
        .byte $5a,$b5,$c0,$3e,$b5,$c0,$3e,$b0,$00,$3e,$b5,$c0,$5a,$b5,$c0
        .fill $15, $0
        .byte $0f,$f0,$00,$03,$ff,$00,$00,$0f,$f0
        .fill $44, $0
        .byte $24,$00,$00,$0f

    L_5f3e:
        .fill $39, $0
        .byte $24,$00,$00,$00,$00,$00,$0f

    L_5f7e:
        .fill $36, $0
        .byte $24,$00,$00,$00,$00,$00,$00,$00,$00,$0f
        .fill $33, $0
        .byte $24,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$0f

    L_5ffe:
        .fill $30, $0
        .byte $24,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$03
        .byte $c0
        .fill $2c, $0
        .byte $24
        .fill $11, $0
        .byte $03,$c0
        .fill $29, $0
        .byte $24
        .fill $14, $0
        .byte $03,$c0
        .fill $26, $0
        .byte $24
        .fill $17, $0
        .byte $03,$c0
        .fill $23, $0
        .byte $24
        .fill $1b, $0
        .byte $f0
        .fill $20, $0
        .byte $24,$00

    L_6161:
        .fill $1d, $0
        .byte $f0

    L_617f:
        .fill $1d, $0
        .byte $24
        .fill $21, $0
        .byte $f0
        .fill $1a, $0
        .byte $24
        .fill $24, $0
        .byte $f0
        .fill $17, $0
        .byte $24
        .fill $27, $0
        .byte $3c
        .fill $14, $0
        .byte $24
        .fill $2a, $0
        .byte $3c
        .fill $11, $0
        .byte $24
        .fill $2d, $0
        .byte $3c,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$24
        .fill $30, $0
        .byte $3c,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$24
        .fill $33, $0
        .byte $0f,$00,$00,$00,$00,$00,$00,$00,$00,$24
        .fill $36, $0
        .byte $0f,$00,$00,$00,$00,$00,$24
        .fill $39, $0
        .byte $0f,$00,$00,$24
        .fill $3c, $0
        .byte $0f,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$01,$00
        .byte $00,$04,$00,$00,$07,$c0,$00,$0b,$c0,$00,$0b,$c0,$00,$0a,$80,$00
        .byte $0a,$40,$00,$0e,$54,$00,$07,$c0,$00,$03,$40,$00

    L_642a:
        ora.a $0070

        .byte $03,$f0,$00,$00,$ff,$00,$00,$3c

    L_6435:
        .fill $1d, $0
        .byte $0f,$40,$00,$0f,$00,$00,$0f,$00,$00,$0a,$80,$00

    L_645e:
        asl $80

        .byte $00,$05,$70,$00,$03,$f4,$00,$01,$4b

    L_6469:
        .byte $00
        .byte $01,$73,$00,$03,$f3,$c0,$00,$ff,$c0,$00,$3f,$c0,$00

    L_6477:
        .fill $18, $0
        .byte $03,$00,$00,$0d,$00,$00,$0d,$14,$00,$03,$50,$00,$02,$80,$00,$0a
        .byte $80,$00,$06,$b0,$00,$04,$f4,$00,$04,$55,$00,$00,$1d,$b0,$00,$3f
        .byte $f0,$00,$ff,$c0,$00,$ff
        .fill $1b, $0
        .byte $30,$00,$00,$d0,$00,$00,$d1,$40,$00,$39,$00,$01,$a8,$00,$01,$a8
        .byte $00,$01,$28,$00,$01,$3c,$00,$00,$14,$00,$00,$15,$00,$00,$3d,$70
        .byte $00,$0f,$b0
        .fill $1d, $0
        .byte $3c,$00,$00,$14,$00,$00,$16,$50,$00,$aa,$00,$00,$a8,$00,$01,$68
        .byte $00,$05,$2c,$00,$00,$3c,$00,$00,$74,$00,$00,$57,$00,$00,$3b,$f0
        .byte $00,$0f,$cc,$00,$0c
        .fill $1b, $0
        .byte $0c,$00,$00,$07,$00,$01,$47,$00,$00,$6c,$00,$00,$2a,$40,$00,$2a
        .byte $40,$00,$28,$40,$00,$3c,$40,$00,$14,$00,$00,$5d,$c0,$0d,$7f,$c0
        .byte $0e,$fc
        .fill $1e, $0
        .byte $0c,$00,$00,$07,$00,$01,$47,$00,$00,$5c,$00,$00,$28,$00,$00,$2a
        .byte $00,$00,$e9,$00,$01,$f1,$00,$05,$f1

    L_65a9:
        .byte $00,$e7,$70,$00,$ff,$ff
        .byte $c0,$00,$ff,$f0,$00,$03,$c0
        .fill $1d, $0
        .byte $0f,$00,$01,$4f,$00,$00,$5f,$00,$00,$2a,$00,$00,$2a,$40,$00,$e9
        .byte $40,$01,$fc,$10,$0e,$34,$00,$0c,$d4,$00,$03,$ff,$c0,$00,$3f,$fc
        .byte $00,$00,$f0,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$0f,$00,$00
        .byte $0f,$00,$00,$0f,$00,$00,$3a,$c0,$00,$2a,$80,$00,$1a,$40,$00,$1a
        .byte $40,$00,$1a,$40,$00,$0f,$00,$00,$07,$00,$00,$05,$00,$00,$05,$00
        .byte $00,$05,$00,$00,$0a,$00,$00,$0f,$c0,$00,$03,$ff,$00,$00,$3f,$c0
        .byte $00,$0f,$f0,$00,$00,$f0,$00,$00,$00,$00,$00,$00,$00,$0f,$00,$00
        .byte $0f,$00,$00,$0f,$00,$00,$0b,$00,$00,$1a,$00,$00,$1a,$80,$00,$1a
        .byte $40,$00,$0e,$40,$00,$0f,$40,$00,$07,$00,$00,$05,$00,$00,$05,$00
        .byte $00,$09,$00,$00,$0e,$c0,$00,$03,$f0,$00,$00,$fc,$00,$00,$3f,$00
        .byte $00,$0f,$f0,$00,$00,$f0,$00,$00,$00,$00,$00,$00,$00,$03,$00,$00
        .byte $0d,$00,$00,$0d,$00,$00,$0d,$00,$00,$0b,$00,$00,$06,$00,$00,$06
        .byte $00,$00,$06,$00,$00,$07,$00,$00,$0f,$00,$00,$07,$00,$00,$07,$00
        .byte $00,$07,$00,$00,$0b,$00,$00,$0f,$00,$00,$03,$fc,$00,$00,$ff,$c0
        .byte $00,$3f,$f0,$00,$00,$f0,$00,$00,$00,$00,$00,$00,$00,$03,$00,$00
        .byte $0f,$00,$00,$0d,$00,$00,$0d,$00,$00,$0e,$40,$00,$2a,$40,$00,$1a
        .byte $40,$00,$1a,$00,$00,$1b,$00,$00,$0f,$00,$00,$0d,$00,$00,$05,$00
        .byte $00,$06,$00,$00,$0b,$00,$00,$0f,$c0,$00,$03,$ff,$00,$00,$ff,$c0
        .byte $00,$3f,$f0,$00,$03,$f0,$00,$00,$00,$00,$00,$00,$00,$0f,$00,$00
        .byte $05,$00,$00,$05,$00,$00,$35,$c0,$00,$2b,$80,$00,$1a,$40,$00,$1a
        .byte $40,$00,$1a,$40,$00,$0f,$00,$00,$0f,$00,$00,$05,$00,$00,$05,$00
        .byte $00,$05,$00,$00,$0a,$00,$00,$0f,$c0,$00,$03,$ff,$00,$00,$3f,$c0
        .byte $00,$0f,$f0,$00,$00,$f0,$00,$00,$00,$00,$00,$00,$00,$0c,$00,$00
        .byte $0f,$00,$00,$07,$00,$00,$07,$00,$00,$1b,$00,$00,$1a,$80,$00,$1a
        .byte $40,$00,$0a,$40,$00,$0e,$40,$00,$0f,$00,$00,$07,$00,$00,$05,$00
        .byte $00,$09,$00,$00,$0e,$00,$00,$3f,$00,$00,$03,$f0,$00,$00,$ff,$00
        .byte $00,$0f,$f0,$00,$00,$f0,$00,$00,$00,$00,$00,$00,$00,$0c,$00,$00
        .byte $07,$00,$00,$07,$00,$00,$07,$00,$00,$0e,$00,$00,$09,$00,$00,$09
        .byte $00,$00,$09,$00,$00,$0d,$00,$00,$0f,$00,$00,$0d,$00,$00,$0d,$00
        .byte $00,$0d,$00,$00,$0e,$00,$00,$0f,$00,$00,$03,$fc,$00,$00,$ff,$c0
        .byte $00,$3f,$f0,$00,$00,$f0,$00,$00,$00,$00,$00,$00,$00,$0f,$00,$00
        .byte $0f,$00,$00,$0f,$00,$00,$0e,$00,$00,$0a,$40,$00,$2a,$40,$00,$1a
        .byte $40,$00,$1b,$00,$00,$1f,$00,$00,$0d,$00,$00,$05,$00,$00,$05,$00
        .byte $00,$06,$00,$00,$3b,$00,$00,$0f,$c0,$00,$03,$ff,$00,$00,$ff,$c0
        .byte $00,$3f,$f0,$00,$03,$f0,$00,$00,$00,$00,$00,$00,$00,$10,$40,$00
        .byte $10,$40,$00,$1f,$40,$00,$1f,$40,$00,$1f,$40,$00,$2a,$80,$00,$0a
        .byte $00,$00,$0a,$00,$00,$0a,$00,$00,$0a,$00,$00,$0f,$00,$00,$07,$00
        .byte $00,$05,$00,$00,$05,$00,$00,$05,$00,$00,$0a,$00,$00,$0f,$c0,$00
        .byte $03,$ff,$00,$00,$3f,$c0,$00,$0f,$f0,$00,$00,$fc,$00,$00,$00,$00
        .byte $00,$00,$00,$1f,$40,$00,$1f,$40,$00,$2f,$80,$00,$2a,$80,$00,$0a
        .byte $00,$00,$0a,$00,$00,$0a,$00,$00,$0a

    L_685c:
        .byte $00,$00,$0f,$00,$00,$07,$00,$00
        .byte $05,$00,$00,$05,$00,$00,$05,$00,$00,$0a,$00,$00,$0f,$c0,$00,$03
        .byte $ff,$00,$00,$3f,$c0,$00,$0f,$f0,$00,$00,$fc,$00,$10,$00,$00,$10
        .byte $40,$00,$1f,$40,$00,$1f,$40,$00,$2f,$40,$00,$2b,$80,$00,$0a,$80
        .byte $00,$0a,$00,$00,$0a,$00,$00,$0e,$00,$00,$0f,$00,$00,$07,$00,$00
        .byte $05,$00,$00,$05,$00,$00,$09,$00,$00,$0e,$c0,$00,$03,$f0,$00,$00
        .byte $fc,$00,$00,$3f,$00,$00,$0f,$f0,$00,$00,$f0,$00,$00,$00,$00,$04
        .byte $00,$00,$0f,$10,$00,$0f,$10,$00,$2f,$10,$00,$2b,$80,$00,$0a,$80
        .byte $00,$0a,$00,$00,$0a,$00,$00,$0e,$00,$00,$0f,$00,$00,$07,$00,$00
        .byte $05,$00,$00,$05,$00,$00,$09,$00,$00,$0e,$c0,$00,$03,$f0,$00,$00
        .byte $fc,$00,$00,$3f,$00,$00,$0f,$f0,$00,$00,$f0,$00,$04,$00,$00,$04
        .byte $00,$00,$07,$00,$00,$05,$00,$00,$05,$00,$00,$09,$00,$00,$0b,$00
        .byte $00,$0a,$00,$00,$0a,$00,$00,$0a,$00,$00,$0f,$00,$00,$0f,$00,$00
        .byte $07,$00,$00,$07,$00,$00,$07,$00,$00,$0b,$00,$00,$0f,$00,$00,$03
        .byte $fc,$00,$00,$ff,$c0,$00,$3f,$f0,$00,$00,$f0,$00,$00,$00,$00,$00
        .byte $00,$00,$03,$40,$00,$0d,$40,$00,$0d,$00,$00,$0a,$00,$00,$0b,$00
        .byte $00,$0a,$00,$00,$0a

    L_6959:
        .byte $00,$00
        .byte $0a

    L_695c:
        .byte $00,$00,$0f,$00,$00,$0f,$00,$00,$07,$00,$00,$07,$00,$00,$07,$00
        .byte $00,$0b,$00,$00,$0f,$00,$00,$03,$fc,$00,$00,$ff,$c0,$00,$3f,$f0
        .byte $00,$00,$f0,$00,$00,$40,$00,$10,$40,$00,$13,$40,$00,$1f,$40,$00
        .byte $1d,$80,$00,$2d,$80,$00,$2a,$00,$00,$0a,$00,$00,$0a,$00,$00,$0a
        .byte $00,$00,$0b,$00,$00,$0f,$00,$00,$0d,$00,$00,$05,$00,$00,$06,$00
        .byte $00,$0b,$00,$00,$0f,$c0,$00,$03,$ff,$00,$00,$ff,$c0,$00,$3f,$f0
        .byte $00,$03,$f0,$00,$00,$00,$00,$00,$10,$00

    L_69c6:
        ora ($10,x)

        .byte $00,$0d,$40,$00,$05,$40,$00,$09,$80,$00,$0a,$80,$00,$0a,$00,$00
        .byte $0a,$00,$00,$0a,$00,$00,$0b,$00,$00,$0f,$00,$00,$0d,$00,$00,$05
        .byte $00,$00,$06,$00,$00,$0b,$00,$00,$0f,$c0,$00,$03,$ff,$00,$00,$ff
        .byte $c0,$00,$3f,$f0,$00,$03,$f0,$00

    L_6a00:
        .byte $10,$40,$00,$10,$40,$00,$1f
        .byte $40,$00,$15,$40,$00,$15,$40,$00,$25,$80,$00,$0b,$00,$00,$0a,$00
        .byte $00,$0a,$00,$00,$0a,$00,$00,$0f,$00,$00,$0f,$00,$00,$05,$00,$00
        .byte $05,$00,$00,$05,$00,$00,$0a,$00,$00,$0f,$c0,$00,$03,$ff,$00,$00
        .byte $3f,$c0,$00,$0f,$f0,$00,$00,$f0,$00,$00,$00,$00,$00,$00,$00,$1f
        .byte $40,$00,$15,$40,$00,$15,$40,$00,$15,$40,$00,$2b,$80,$00,$0a,$00
        .byte $00,$0a,$00,$00,$0a,$00,$00,$0f,$00,$00,$0f,$00,$00,$05,$00,$00
        .byte $05,$00,$00,$05,$00,$00,$0a,$00,$00,$0f,$c0,$00,$03,$ff,$00,$00
        .byte $3f,$c0,$00,$0f,$f0,$00,$00,$f0,$00

    L_6a80:
        .byte $10,$00,$00,$10,$40,$00,$1c
        .byte $40,$00,$1f,$40,$00,$27,$40,$00,$27,$80,$00,$0b,$80,$00,$0a,$00
        .byte $00,$0a,$00,$00,$0a,$00,$00,$0e,$00,$00,$0f,$00,$00,$07,$00,$00
        .byte $05,$00,$00,$09,$00,$00,$0e,$00,$00,$3f,$00,$00,$03,$f0,$00,$00
        .byte $ff,$00,$00,$0f,$f0,$00,$00,$f0,$00,$00,$00,$00,$40,$00,$00,$5c
        .byte $00,$00,$17,$00,$00,$15,$00,$00,$0d,$00,$00,$0a,$00,$00,$0a,$00
        .byte $00,$0a,$00,$00,$0a,$00,$00,$0e,$00,$00,$0f,$00,$00,$07,$00,$00
        .byte $05,$00,$00,$09,$00,$00,$0e,$00,$00,$3f,$00,$00,$03,$f0,$00,$00
        .byte $ff,$00,$00,$0f,$f0,$00,$00,$f0,$00

    L_6b00:
        ora ($00,x)

        .byte $00,$01,$00,$00,$0d,$00,$00,$05,$00,$00,$05,$00,$00,$06,$00,$00
        .byte $0e,$00,$00,$0a,$00,$00,$0a,$00,$00,$0a,$00,$00,$0f,$00,$00,$0f
        .byte $00,$00,$0d,$00,$00,$0d,$00,$00,$0d,$00,$00,$0e,$00,$00,$0f,$00
        .byte $00,$03,$fc,$00,$00,$ff,$c0,$00,$3f,$f0,$00,$00,$f0,$00,$00,$00
        .byte $00,$10,$00,$00,$1c,$00,$00,$17,$00,$00,$07,$00,$00,$06,$00,$00
        .byte $0a,$00,$00,$0a,$00,$00,$0a,$00,$00,$0a,$00,$00,$0f,$00,$00,$0f
        .byte $00,$00,$0d,$00,$00,$0d,$00,$00,$0d,$00,$00,$0e,$00,$00,$0f,$00
        .byte $00,$03,$fc,$00,$00,$ff,$c0,$00,$3f,$f0,$00,$00,$f0,$00,$00,$40
        .byte $00,$10,$40,$00,$1f,$40,$00,$1f,$40,$00,$1f,$80,$00,$2e,$80,$00
        .byte $2a,$00,$00,$0a,$00,$00,$0a,$00,$00,$0b,$00,$00,$0f,$00,$00,$0d
        .byte $00,$00,$05,$00,$00,$05,$00,$00,$06,$00,$00,$3b,$00,$00,$0f,$c0
        .byte $00,$03,$ff,$00,$00,$ff,$c0,$00

    L_6bba:
        .byte $3f,$f0,$00,$03,$f0,$00,$00,$00,$00,$00,$00,$00,$0f,$00,$00,$4f
        .byte $00,$00,$4f,$40,$00,$1e,$80,$00,$2a,$00,$00,$0a,$00,$00,$0a,$00
        .byte $00,$0b,$00,$00,$0f,$00,$00,$0d,$00,$00,$05,$00,$00,$05,$00,$00
        .byte $06,$00,$00,$3b,$00,$00,$0f,$c0,$00,$03,$ff,$00,$00,$ff,$c0,$00
        .byte $3f,$f0,$00,$03,$f0
        .fill $1a, $0
        .byte $3c,$00,$01,$3c,$50,$01,$aa

    L_6c20:
        .byte $70,$00,$2b,$00,$00,$ff,$00,$00
        .byte $7d,$00,$03,$b2,$c0,$03,$00,$c0,$03,$00,$c0
        .fill $27, $0
        .byte $40,$00,$07,$c0,$00,$0b,$c0,$38,$2a,$54,$35,$fa,$90,$0e,$7f,$00
        .byte $0c,$5c,$00,$03,$f0,$00,$03,$c0
        .fill $23, $0
        .byte $03,$00,$00,$0c,$c0,$00,$08,$80,$00,$01,$40,$00,$00,$7a,$54,$00
        .byte $7a,$f0,$00

    L_6ca8:
        adc.a $00f0,y
        and.a $0040,x

        .byte $f0,$50
        .fill $26, $0
        .byte $f0,$00,$03,$e0,$00,$00,$90,$00,$00,$50,$00,$00,$50,$00,$00,$78

    L_6ce6:
        .byte $00,$00
        .byte $ea,$00,$00,$eb,$d0,$00,$3b,$d4,$00,$05,$f4,$00,$01,$40
        .fill $23, $0
        .byte $c3,$00,$00,$82,$00,$00,$41,$00,$00,$ff,$00,$00,$eb,$00,$00,$aa
        .byte $c0,$01,$be,$40,$01,$3f,$40,$01,$14,$40
        .fill $23, $0
        .byte $0f,$00,$00,$0b,$c0,$00,$06,$00,$00,$05,$00,$00,$05,$00,$00,$2d
        .byte $00,$00,$ab,$00,$07,$eb,$c0,$17,$ec,$f0,$13,$50,$30,$01,$40
        .fill $22, $0
        .byte $c0,$00,$03,$30,$00,$02,$20,$00,$01,$40,$15,$ad,$00,$0f,$ad,$00
        .byte $0f,$6d,$00,$01,$7f,$c0,$05,$00,$fc
        .fill $28, $0
        .byte $01,$00,$00,$03,$d0,$00,$03,$e0,$00,$15,$a8,$2c,$06,$af,$5c,$00
        .byte $fd,$b0,$00,$35,$30,$00,$03,$f0,$00,$00,$fc,$00,$00,$00,$00,$00
        .byte $00,$00,$00,$00,$00,$00,$00,$00,$01,$54,$00,$06,$ab,$00,$16,$9b
        .byte $c0,$1f,$aa,$f0,$7f,$6a,$9c,$7f,$ea,$9c,$95,$6a,$af,$9a,$9a,$9f
        .byte $aa,$a6,$af,$aa,$a9,$ef,$aa,$ab,$ef,$9a,$ab,$ef,$76,$ab,$df,$7e
        .byte $a7,$5f,$3d,$6a,$bf,$1e,$aa,$7f,$06,$a9,$fc,$01,$57,$fc,$00,$ff
        .byte $f0,$00,$3f,$c0,$00,$00,$00,$00,$01,$7c,$00,$06,$a9,$00,$1a,$aa
        .byte $c0,$19,$aa,$70,$57,$e6,$bc,$6f,$da,$9c,$af,$fa,$af,$a7,$da,$af
        .byte $a9,$a6,$af,$aa,$aa,$af,$aa,$a9,$9f,$aa,$aa,$7f,$66,$aa,$ff,$6f
        .byte $aa,$ff,$1f,$a9,$ff

    L_6e6d:
        .byte $1f
        .byte $e9,$7f,$07,$69,$fc,$01,$57,$fc,$00,$ff,$f0,$00,$3f,$c0,$00,$00
        .byte $00,$00,$01,$7c,$00,$06,$a7,$00,$3a,$aa,$40,$3a,$aa,$70,$d6,$6a
        .byte $bc,$e9,$f9,$bc,$a9,$fa,$af,$a9,$f6,$af,$aa,$fe,$af,$aa,$7e,$af
        .byte $aa,$6a,$af,$aa,$a9,$9f

    L_6ea4:
        ror 
        tax 

        .byte $7f,$ea,$aa,$7f,$27,$aa,$ff,$17,$e9,$ff,$07,$e9,$fc,$03,$d7,$fc
        .byte $00,$ff,$f0,$00,$3f,$c0,$00

    L_6ebd:
        .byte $00,$00,$00
        .byte $01,$54,$00,$05,$a7,$00,$3a,$a9,$c0,$36,$aa

    L_6ecb:
        bvs L_6ecb
        tax 

        .byte $9c,$f5,$aa,$9c,$6a,$9a,$9f,$aa,$7e,$af,$aa,$7d,$af,$aa,$bf,$af
        .byte $aa,$bf,$af,$6a,$9f,$af,$ea,$9a,$6f,$da,$aa,$bf,$1a,$aa,$bf,$1a
        .byte $6a,$7f,$05,$e9,$fc,$03,$d7,$fc,$00,$ff,$f0,$00,$3f,$c0
        .fill $16, $0
        .byte $0f,$00,$00,$2f,$80,$00,$25,$80,$00,$1f,$40,$00,$15,$40,$00,$15
        .byte $40,$00,$05,$00,$00,$0a,$00,$00,$0f,$c0,$00,$03,$f0,$00,$00,$f0
        .fill $20, $0
        .byte $0f,$00,$00,$2a,$80,$00,$2f,$80,$00,$1f,$40,$00,$15,$40,$00,$15
        .byte $40,$00,$05,$00,$00,$0a,$00,$00,$0f,$c0,$00

    L_6f6d:
        .byte $03,$f0,$00,$00,$f0
        .fill $18, $0
        .byte $24
        .fill $35, $0
        .byte $01,$54,$00,$06,$a9,$00,$1a,$aa,$40,$1a,$aa,$70,$6a,$aa,$9c,$6a
        .byte $aa,$9c,$aa,$aa,$af,$aa,$aa,$af,$aa,$aa,$af,$aa,$aa,$af,$aa,$aa
        .byte $af,$aa,$aa,$af,$6a,$aa,$9f,$6a,$aa,$9f,$2a,$aa,$bf,$1a,$aa,$7f
        .byte $06,$a9,$fc,$01,$57,$fc,$00,$ff,$f0,$00,$3f,$c0,$00,$00,$00,$00
        .byte $01,$54,$00,$06,$a9,$00,$1a,$aa,$40,$1a,$aa,$70,$6a,$aa,$9c,$6a
        .byte $aa,$9c,$aa

    L_7013:
        tax 

        .byte $af,$aa,$aa,$af

    L_7018:
        tax 
        tax 

        .byte $af,$aa,$aa

    L_701d:
        .byte $af
        .byte $aa,$aa,$af,$aa,$aa,$af,$6a,$aa,$9f,$6a,$aa,$9f,$2a,$aa,$bf,$1a
        .byte $aa,$7f,$06,$a9,$fc,$01,$57,$fc,$00,$ff,$f0,$00,$3f,$c0,$00,$00
        .byte $00,$00,$01,$54,$00,$06,$a9,$00,$1a,$aa,$40,$1a,$aa,$70,$6a,$aa
        .byte $9c,$6a,$aa,$9c,$aa,$aa,$af,$aa,$aa,$af,$aa,$aa,$af,$aa,$aa,$af
        .byte $aa,$aa,$af,$aa,$aa,$af,$6a,$aa,$9f,$6a,$aa,$9f,$2a,$aa,$bf,$1a
        .byte $aa,$7f

    L_7070:
        asl $a9

        .byte $fc,$01,$57,$fc,$00,$ff,$f0,$00,$3f,$c0
        .fill $1c, $0
        .byte $0a,$a8,$00,$2a,$aa,$c0,$0a,$ab,$c0,$03,$ff
        .fill $1d, $0
        .byte $60,$06,$00,$6c,$06,$c0,$6c,$06,$c1,$6c,$06,$c6,$69,$5a,$db,$6a
        .byte $aa,$6c,$6f,$f9,$aa,$6c,$06,$bf,$6c,$0b,$c0,$6c,$0a,$c0,$6c,$0a
        .byte $c0,$3c,$03,$c0
        .fill $23, $0
        .byte $60,$00,$80,$6c,$00,$a0,$6c,$00,$e8,$6c,$00,$aa,$6c,$00,$fa,$ea
        .byte $aa,$03,$cf,$ff

    L_711b:
        .fill $2b, $0
        .byte $6a,$aa,$00,$6f,$ff,$c0,$6c,$00,$00,$6a,$a0,$00,$6f,$fc,$00,$ec
        .byte $00,$00,$fc
        .fill $27, $0
        .byte $55,$55,$00,$aa,$aa,$c0,$3e,$bf,$c0,$01,$b2,$b6,$01,$b1,$b6,$01
        .byte $b1,$b6,$01,$b1,$b6,$01,$b1,$b6,$01,$b1,$b6,$01,$b0,$f3,$01,$b0
        .byte $00,$00,$f0
        .fill $26, $0
        .byte $80,$1a,$1a,$a0,$6a,$db,$aa,$aa,$da,$fa,$fa,$db,$ca,$ca,$db,$ca
        .byte $ca,$da,$c3,$cf,$ff
        .fill $2b, $0
        .byte $aa,$00,$00,$ff,$c0,$00,$a0,$00,$00,$fc,$00,$00,$00,$00,$00,$aa
        .byte $00,$00,$ff,$c0
        .fill $23, $0
        .byte $55,$55,$00,$6a,$aa,$c0,$6f,$ff,$c0,$6c,$00,$60,$69,$40,$6c,$6a
        .byte $b0,$6c,$6f,$f0,$6c,$6c,$00,$6c,$6c,$00,$2a,$6c,$00,$0f,$6c,$00
        .byte $00,$3c
        .fill $27, $0
        .byte $06,$60,$00,$06,$ec,$00,$06,$ec,$00,$06,$ec,$00,$06,$ec,$00,$ab
        .byte $ea,$aa,$ff,$0f,$ff
        .fill $2b, $0
        .byte $60,$00,$00,$6c,$00,$00,$6c,$00,$00,$6c,$00,$00,$6c,$00,$00,$ea
        .byte $aa,$00,$ff,$ff,$c0
        .fill $28, $0
        .byte $4f,$10,$00,$4f,$10,$00

    L_730c:
        adc $90

        .byte $00,$25,$80,$00,$0b,$00,$00,$0a,$00,$00,$0a,$00,$00,$0a,$00,$00
        .byte $0f,$00,$00,$0d,$00,$00,$0d,$00,$00,$0d,$00,$00,$02,$00,$00,$03
        .byte $cc,$00,$00,$f3,$00,$00,$ff,$00,$00,$3f,$c0,$00,$03,$c0,$00,$00
        .byte $00,$00,$40,$10,$00,$4f,$10,$00,$4f,$10,$00

    L_7349:
        and $80

        .byte $00,$25,$80,$00,$0b,$00,$00,$0a,$00,$00,$0a,$00,$00,$0a,$00,$00
        .byte $0f,$00,$00,$05,$00,$00,$05,$00,$00,$0d,$00,$00,$02,$00,$00,$03
        .byte $00,$00,$00,$c3,$00,$00,$f3,$00,$00,$3f,$c0,$00,$3f,$f0,$00,$00
        .byte $f0,$00,$00,$00,$00,$10,$40,$00,$10,$40,$00,$1f,$40,$00,$2f,$80
        .byte $00,$25,$80,$00,$05,$00,$00,$0b,$00,$00,$0a,$00,$00,$0a,$00,$00
        .byte $0a,$00,$00,$0f,$00,$00,$07,$00,$00,$07,$00,$00,$07,$00,$00,$08
        .byte $00,$00,$0c,$30,$00,$03,$f3,$00,$00,$ff,$00,$00,$3f,$c0,$00,$0f
        .byte $c0,$00,$00,$00,$00,$00,$00,$00,$4f,$10,$00,$4f,$10,$00

    L_73c9:
        eor $10

        .byte $00,$25,$80,$00,$2b,$80,$00,$0a,$00,$00,$0a,$00,$00,$0a,$00,$00
        .byte $0f,$00,$00,$05,$00,$00,$05,$00,$00,$07,$00,$00,$08,$00,$00,$0c
        .byte $00,$00,$03,$30,$00,$00,$f0,$00,$00,$ff,$c0,$00,$3f,$f0,$00,$03
        .byte $f0,$00,$00,$00,$00,$00,$00,$00,$4f,$00,$00,$4f,$00,$00,$45,$10
        .byte $00,$25,$90,$00,$2b,$80,$00,$0a,$00,$00,$0a,$00,$00,$0a,$00,$00
        .byte $0f,$40,$00,$04,$40,$00,$04,$b0,$00,$04,$c0,$00,$08

    L_7428:
        .byte $00,$00,$0c,$00,$00,$03,$0c,$00,$00,$fc,$00,$00,$ff
        .byte $c0,$00,$3f,$f0,$00,$03,$f0,$00,$00,$00,$00,$1f,$00,$00,$15,$00
        .byte $00,$15,$00,$00,$2b,$80,$00,$2a,$90,$00

    L_744f:
        asl 
        bpl L_7452
    L_7452:
        asl 

        .byte $00,$00,$0a,$40,$00,$0f,$6c,$00,$04,$30,$00,$04,$00,$00,$04,$00
        .byte $00,$08,$00,$00,$0c,$00,$00,$00,$00,$00,$00,$c3,$c0,$00,$3f,$00
        .byte $00,$3f,$f0,$00,$0f,$fc,$00,$00,$fc,$00,$00,$c0,$00,$00,$00,$00
        .byte $0f,$10,$00,$0f,$10,$00

    L_7489:
        eor $10

        .byte $00,$65,$80,$00,$2b,$80,$00,$0a,$00,$00,$0a,$00,$00,$0a,$00,$00
        .byte $1f,$00,$00,$11,$00,$00,$e1,$00,$00,$31,$00,$00,$02,$00,$00,$03
        .byte $00,$00,$03,$00,$00,$00,$c0,$00,$00,$ff,$c0,$00,$ff,$fc,$00,$03
        .byte $f0,$00,$00,$00,$00,$0f,$40,$00,$05,$40,$00,$05,$40,$00,$2b,$80
        .byte $00,$6a,$80,$00,$4a,$00,$00,$0a,$00,$00,$1a,$00,$00,$9f,$00,$00
        .byte $c1,$00,$00,$01,$00,$00,$01,$00,$00,$02,$00,$00,$03,$00,$00,$00
        .byte $00,$00,$00,$c0,$00,$00,$30,$00,$03,$3f,$f0,$00,$ff,$fc,$00,$00
        .byte $fc,$00,$00,$00,$00,$0f,$00,$00,$05,$00,$00,$05,$00,$00,$35,$c0
        .byte $00,$2b,$80,$00,$6a,$90,$00

    L_7512:
        lsr 
        bpl L_7515
    L_7515:
        asl 

        .byte $00,$00,$0f,$00,$00,$0f,$00,$00,$05,$00,$00,$05,$00,$00,$05,$00
        .byte $00,$0a,$00,$00,$0f,$c0,$00,$03,$ff,$00,$00,$3f,$c0,$00,$0f,$f0
        .byte $00,$00,$f0,$00,$00,$00,$00,$00,$00,$00,$0f,$00,$00,$05,$00,$00
        .byte $05,$00,$00,$25,$c0,$00,$2a,$80,$00,$5a,$50,$00

    L_7552:
        lsr 
        bpl L_7555
    L_7555:
        asl 

        .byte $00,$00,$0f,$00,$00,$0f,$00,$00,$05,$00,$00,$05,$00,$00,$05,$00
        .byte $00,$0a,$00,$00,$0f,$c0,$00,$03,$ff,$00,$00,$3f,$f0,$00,$0f,$f0
        .byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
        .byte $05,$00,$00,$45,$10,$00,$6a,$90,$00

    L_758f:
        asl 

        .byte $00,$00,$0a,$00,$00,$0a,$00,$00,$0f,$00,$00,$0f,$00,$00,$05,$00
        .byte $00,$05,$00,$00,$05,$00,$00,$0a,$00,$00,$0f,$c0,$00,$03,$ff,$c0
        .byte $00,$3f,$f0,$00,$0f,$f0,$00,$00,$c0,$00,$00,$00,$00,$00,$00,$00
        .byte $00,$00,$00,$00,$00,$00,$40,$10,$00,$45,$10,$00,$15,$40,$00,$2a
        .byte $80,$00,$0a,$00,$00,$0a,$00,$00,$0a,$00,$00,$0f,$00,$00,$0f,$00
        .byte $00,$05,$00,$00,$05,$00,$00,$0f,$00,$00,$0f,$c0,$00,$03,$ff,$c0
        .byte $00,$ff,$c0,$00,$0f,$c0,$00,$00,$c0,$00,$00,$c0,$00,$00,$00,$00
        .byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$40,$10,$00,$45,$10,$00,$15
        .byte $40,$00,$2a,$80,$00,$0a,$00,$00,$0a,$00,$00,$0f,$00,$00,$0f,$00
        .byte $00,$05,$00,$00,$05,$00,$00,$0f,$00,$00,$0f,$c3,$c0,$03,$ff,$c0
        .byte $00,$ff,$f0,$00,$03,$f0,$00,$00,$30
        .fill $16, $0
        .byte $45,$10,$00,$45,$10,$00,$2a,$80,$00,$0a,$00,$00,$0f,$00,$00,$0f
        .byte $00,$00,$10,$40,$00,$10,$40,$00,$30,$cf,$00,$30,$cf,$c0,$0f,$ff
        .byte $c0,$00,$3f,$c0,$00,$0c,$f0
        .fill $1c, $0
        .byte $45,$10,$00,$45,$10,$00,$2a,$80,$00,$0a,$00,$00,$0f,$00,$00,$1f
        .byte $40,$00,$10,$7c,$00,$30,$fc,$00,$30,$ff,$c0,$0f,$fc
        .fill $29, $0
        .byte $05,$00,$00,$45,$10,$00,$6a,$90,$00

    L_76e1:
        asl 

        .byte $f0,$00,$0f,$c0,$00,$df,$70,$00

    L_76ea:
        .byte $d0,$70,$00
        .byte $c0,$30
        .fill $17, $0
        .byte $4f,$10,$00,$4f,$10,$00,$6f,$90,$00

    L_770f:
        rol 

        .byte $80,$00,$0a,$00,$00,$0a,$00,$00,$0a,$00,$00,$0a,$00,$00,$0f,$00
        .byte $00,$0d,$00,$00,$0d,$00,$00,$0d,$00,$00,$02,$00,$00,$03,$c0,$00
        .byte $00,$f3,$00,$00,$ff,$00,$00,$3f,$c0,$00,$03,$c0,$00,$00,$00,$00
        .byte $10,$40,$00,$1f,$40,$00,$1f,$40,$00,$2f,$80,$00,$2a,$80,$00,$0a
        .byte $00,$00,$0a,$00,$00,$0a,$00,$00,$0a,$00,$00,$0f,$00,$00,$05,$00
        .byte $00,$05,$00,$00,$0b,$00,$00,$0f,$00,$00,$00,$00,$00,$00,$c3,$00
        .byte $00,$f3,$00,$00,$3f,$c0,$00,$3f,$f0,$00,$00,$f0,$00,$00,$00,$00
        .byte $00,$00,$00,$0f,$00,$00,$4f,$10,$00,$4f,$10,$00

    L_778c:
        ror 
        bcc L_778f
    L_778f:
        rol 

        .byte $80,$00,$0a,$00,$00,$0a,$00,$00,$0a,$00,$00,$0f,$00,$00,$07,$00
        .byte $00,$07,$00,$00,$07,$00,$00,$08

    L_77a8:
        .byte $00,$00,$0c,$30,$00,$03,$f3,$00,$00,$ff,$00,$00,$3f
        .byte $c0,$00,$0f,$c0,$00,$00,$00,$00,$00,$00,$00,$0f,$00,$00,$4f,$10
        .byte $00,$4f,$10,$00

    L_77c9:
        rol 

        .byte $80,$00,$2a,$80,$00,$0a,$00,$00,$0a,$00,$00,$0a,$00,$00,$0f,$00
        .byte $00,$05,$00,$00,$06,$00,$00,$0f,$00,$00,$0c,$00,$00,$00,$00,$00
        .byte $00,$30,$00,$00,$f0,$00,$00,$ff,$c0,$00,$3f,$f0,$00,$03,$f0
        .fill $1f, $0
        .byte $10,$00,$00,$10,$00,$00,$3c,$00,$00,$3e,$00,$00,$3e,$f4,$00,$2a
        .byte $fb,$00,$05,$f3,$00,$0d,$7f,$c0,$03,$fc,$00,$00,$f0

    L_7835:
        .fill $26, $0
        .byte $01,$00,$00,$01,$4f,$00,$00,$6f,$00,$00,$ef,$00,$0d,$ea,$00,$0d
        .byte $ea,$50,$03,$ff,$fc,$00,$3f,$c0,$00

    L_7874:
        .fill $46, $0
        .byte $24
        .fill $1d, $0
        .byte $03,$5e,$a5,$03,$5e,$bc,$00,$0e,$bc,$03,$5e,$bc,$03,$5e,$a5,$00
        .byte $00,$00,$00,$00,$00,$00,$0f,$fc,$00,$03,$ff
        .fill $25, $0
        .byte $5a,$b5,$c0,$3e,$b5,$c0,$3e,$b0,$00,$3e,$b5,$c0,$5a,$b5,$c0,$00
        .byte $00,$00,$00,$00,$00,$03,$ff,$00,$00,$3f,$f0
        .fill $25, $0
        .byte $03,$5e,$a5,$03,$5e,$9c,$00,$0e,$9c,$03,$5e,$9c,$03,$5e,$a5,$00
        .byte $00,$00,$00,$00,$00,$00,$0f,$fc,$00,$03,$ff
        .fill $25, $0
        .byte $5a,$b5,$c0,$36,$b5,$c0,$36,$b0,$00

    L_79a1:
        rol $b5,x
        cpy #$5a
        lda $c0,x

        .byte $00,$00,$00,$00,$00,$00,$03,$ff,$00,$00,$3f,$f0
        .fill $13, $0
        .byte $03,$00,$00,$03,$80,$00,$0c,$50,$00

    L_79cf:
        asl.a $0014
        ora ($5f,x)

        .byte $00,$00,$7e,$80,$00,$3a,$a0,$00,$0a,$b4,$00,$02,$f4,$00,$01,$f1
        .byte $00,$00,$40,$00,$00,$10,$00,$00,$00,$00,$3f,$fc,$00,$03,$ff
        .fill $15, $0
        .byte $c0,$00,$02,$00,$00,$05,$30,$00,$14,$80,$00,$f5,$40,$02,$bd,$00
        .byte $0a,$ac,$00,$06,$a0,$00,$1f,$a0,$00,$5f,$40,$00,$01,$40,$00,$05
        .byte $00,$00,$00,$00,$00,$00,$ff,$c0,$00,$3f,$f0
        .fill $13, $0
        .byte $03,$00,$00,$03,$80,$00,$0c,$50,$00

    L_7a4f:
        asl.a $0014
        ora ($5f,x)

        .byte $00,$00,$7e,$80,$00,$3a,$a0,$00,$0a,$54,$00,$02,$5c,$00,$01,$71
        .byte $00,$00,$40,$00,$00,$10,$00,$00,$00,$00,$3f,$fc,$00,$03,$ff
        .fill $15, $0
        .byte $c0,$00,$02,$00,$00,$05,$30,$00,$14,$80,$00,$f5,$40,$02,$bd,$00
        .byte $0a,$ac,$00,$06,$a0,$00,$15,$a0,$00,$5f,$40,$00,$01,$40,$00,$05
        .byte $00,$00,$00,$00,$00,$00,$ff,$c0,$00,$3f,$f0,$00,$00,$00,$00,$00
        .byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$ff,$ff,$00,$00,$00,$00,$ff,$ff
        .byte $ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff
        .byte $ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff
        .byte $ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff
        .byte $ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff
        .byte $ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff
        .byte $ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff
        .byte $ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff
        .byte $ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff
        .byte $ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff
        .byte $ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff
        .byte $ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff
        .byte $ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff
        .byte $ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff
        .byte $ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff
        .byte $ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff
        .byte $ff,$ff,$00,$00,$00,$00,$ff,$ff,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00

    L_7c51:
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00

    L_7c71:
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00

    L_7cb1:
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff

    L_7d71:
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00

    L_7e71:
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff

    L_7f71:
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff

    L_7fa1:
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff

    L_7ff1:
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff
        .byte $d8,$78,$a2,$ff,$9a,$a9,$15,$85,$01,$58,$4c,$71,$be

    L_800d:
        lda #$01
        sta vIRQMasks
        lda #$00
        sta L_852f + $2
        sta L_880d
        lda #$00
        sta L_880d + $1
        lda #$07
        sta L_880d + $2
        lda #$01
        sta L_8810
        jsr L_babe
    L_802c:
        lda #$00
        sta $ec
        jsr L_853c
        lda #$00
        sta L_e006 + $2
        lda L_4001 + $2
        cmp #$3f
        beq L_8042
        jsr L_8a8b
    L_8042:
        lda #$00
        sta $ee
        sta vSprPriority
        lda #$10
        sta vScreenControl1
        lda #$10
        sta vScreenControl2
        lda #$20
        sta vMemControl
        lda #$00
        sta $22
        lda #$05
        sta vBackgCol0
        lda #$00
        sta vBorderCol
        jsr $bb93
        lda #$00
        sta vBackgCol1
        lda #$0d
        sta vBackgCol2
        lda #$20
        sta $23
        lda #$00
        sta $ea
        sta $eb
        sta $27
        sta $2a
        lda L_880d + $2
        sta L_999f
        lda L_8810
        sta L_999f + $1
        lda #$00
        sta $e5
        lda #$01
        sta $e4
    L_8095:
        jsr L_992d
        jsr L_b15c
        ldx #$06
        ldy #$07
        jsr L_959e
        jsr $99a3
        jsr L_b861
        jsr L_bba7
        lda #$00
        sta L_bd77
        ldy L_880d
        lda $8534,y
        sta $992b
        lda $8538,y
        sta L_992a
        lda #$00
        sta $9929
        sta L_9928
        lda #$10
        sta vScreenControl1
    L_80cc:
        lda #$00
        sta $e2
        sta L_852f + $1
        sta $e3
        sta $d9
        sta $d6
        sta L_c31d + $1
        sta L_c31d
        sta $d5
        sta $ca
        sta $cf
        sta L_b7c6
        sta $b7c7
        sta L_b7cd
        sta $b7ce
        lda #$28
        sta L_852f
        lda #$06
        sta $c6
        lda #$10
        sta $d0
        lda #$01
        sta $9060
        sta $b7c8
        sta L_b7c9
        sta $992c
        lda #$1e
        sta $bd78
        lda #$ff
        sta vSprEnable
        sta vSprMCM
        lda #$0a
        sta vSprMCMCol0
        lda #$00
        sta vSprMCMCol1
        lda #$01
        sta $af7c
        lda #$00
        sta L_905f
        sta $ed
        sta L_c526 + $a
        sta L_c531
        sta $b524
        sta L_b7ae
        sta L_b523
        sta L_b7ad
        sta L_af7d
        sta $af7a
        sta L_af7b
        sta L_af79
        sta $af78
        sta $b7b0
        sta $b7b2
        sta $b7af
        sta L_b7b1
        sta $ce
        sta L_9892
        jsr L_a9b7
        lda #$00
        sta $96dd
        sta L_8d13 + $6
        sta L_9293
        sta L_8d13 + $5
        sta $9292
        sta $8d1b
        sta $9295
        sta L_8d13 + $3
        sta L_9290
        sta L_a42f
        sta L_a42e
        sta $a632
        sta $a631
        sta $a634
        sta L_a633
        sta L_a465
        sta $a466
        lda #$01
        sta L_9fc2
        lda #$ff
        sta L_8533
    L_81a3:
        lda #$a0
        ldx #$a5
        jsr L_bd07
        jsr L_bba7
        jsr L_9870
        lda $26
        sta $27
        lda $29
        sta $2a
        lda $23
        sta $28
        jsr L_acd9
        jsr $ab8f
        jsr L_aa2c
        jsr L_aa8f
        jsr $a7b6
        jsr $a430
        jsr L_bd12
        jsr L_9f8a
        jsr $9caf
        lda L_bd77
        beq L_81f4
        jsr L_95e0
        lda $e5
        beq L_81eb
        lda #$00
        sta vScreenControl1
        jmp L_802c
    L_81eb:
        inc $e5
        lda #$01
        sta $e4
        jmp L_8095
    L_81f4:
        lda L_a42e
        beq L_81fc
        jsr L_a139
    L_81fc:
        lda L_a42f
        beq L_8204
        jsr L_9cda
    L_8204:
        lda $d9
        beq L_820b
        jsr L_99c4
    L_820b:
        lda $e3
        beq L_8215
        jsr L_9803
        jmp L_80cc
    L_8215:
        lda #$6e
        ldx #$73
        jsr L_bd07
        jsr L_b18a
        jsr L_b10d
        jsr $b0a9
        jsr L_b138
        lda L_880d + $1
        beq L_8236
        jsr L_b298
        jsr L_b525
        jmp L_8246
    L_8236:
        jsr L_8277
        lda $e5
        bne L_8243
        jsr L_b298
        jmp L_8246
    L_8243:
        jsr L_b525
    L_8246:
        jsr $af7e
        jsr L_afd1
        jsr L_a9a4
        jsr L_a635
        jsr $a467
        jsr L_a4d7
        jsr L_8e78
        jsr L_8adc
        jsr L_939f
        jsr L_9061
    L_8264:
        jsr $8a4a
        lda $96dd
        beq L_8274
        lda #$00
        sta vScreenControl1
        jmp L_802c
    L_8274:
        jmp L_81a3
    L_8277:
        lda L_c31d + $1
        beq L_827d
        rts 


    L_827d:
        lda $e5
        beq L_8284
        jmp L_8330
    L_8284:
        lda $e4
        beq L_829a
        cmp #$02
        beq L_828d
        rts 


    L_828d:
        dec L_852f
        lda L_852f
        beq L_8296
        rts 


    L_8296:
        lda #$00
        sta $e4
    L_829a:
        lda #$01
        sta $b7b3
        ldx $d0
        lda $c336
        clc 
        adc #$04
        sta L_c3f8 + $d,x
        lda L_c31f
        adc #$00
        sta $c3ee,x
        lda $c34d
        sta $c41c,x
        lda L_c364
        clc 
        adc #$1a
        sta $c433,x
        bcc L_82c6
        inc $c41c,x
    L_82c6:
        jsr L_8463
        lda $c34d,x
        bne L_8316
        lda L_c364,x
        cmp #$c6
        bcs L_8316
        lda $cf
        beq L_8316
    L_82d9:
        lda #$02
        sta L_c31d
        lda #$00
        sta $b7b2
        sta L_c31d + $1
        lda #$05
        sta L_af7b
        lda #$33
        sta $af7a
        jsr L_83d7
        ldy L_b7c9
        lda L_ab79,y
        sta $af7c
        lda $ab84,y
        sta L_af7d
        lda #$01
        sta L_af79
        sta L_b7ae
        lda #$00
        sta $af78
        sta L_b7ad
        jsr L_8515
        rts 


    L_8316:
        lda $cf
        beq L_832f
        lda $c34d
        cmp #$02
        beq L_82d9
        lda $c34d
        cmp #$01
        bne L_832f
        lda L_c364
        cmp #$8c
        bcs L_82d9
    L_832f:
        rts 


    L_8330:
        lda $e4
        beq L_8346
        cmp #$01
        beq L_8339
        rts 


    L_8339:
        dec L_852f
        lda L_852f
        beq L_8342
        rts 


    L_8342:
        lda #$00
        sta $e4
    L_8346:
        lda #$01
        sta $b7cc
        ldx $c6
        lda $c336
        clc 
        adc #$04
        sta L_c3f8 + $d,x
        lda L_c31f
        adc #$00
        sta $c3ee,x
        lda $c34d
        sta $c41c,x
        lda L_c364
        clc 
        adc #$1a
        sta $c433,x
        bcc L_8372
        inc $c41c,x
    L_8372:
        jsr L_84b3
        lda $c34d,x
        cmp #$02
        bne L_83bd
        lda $ca
        beq L_83bd
    L_8380:
        lda #$01
        sta L_c31d
        lda #$00
        sta $b7b0
        sta L_c31d + $1
        lda #$05
        sta L_af7b
        lda #$33
        sta $af7a
        jsr L_841d
        ldy $b7c8
        lda L_ab79,y
        sta $af7c
        lda $ab84,y
        sta L_af7d
        lda #$01
        sta L_af79
        sta $b524
        lda #$00
        sta $af78
        sta L_b523
        jsr L_8515
        rts 


    L_83bd:
        lda $ca
        beq L_83d6
        lda $c34d
        cmp #$00
        beq L_8380
        lda $c34d
        cmp #$01
        bne L_83d6
        lda L_c364
        cmp #$32
        bcc L_8380
    L_83d6:
        rts 


    L_83d7:
        lda #$02
        sta L_b7c9
        lda L_c31f,x
        beq L_83f1
        cmp #$02
        beq L_8407
        lda $c336,x
        cmp #$7c
        bcs L_8414
        cmp #$34
        bcc L_83fe
        rts 


    L_83f1:
        lda $c336
        cmp #$8c
        bcs L_83fe
        lda #$08
        sta L_b7c9
        rts 


    L_83fe:
        lda L_b7c9
        ora #$08
        sta L_b7c9
        rts 


    L_8407:
        lda $c336
        cmp #$28
        bcc L_8414
        lda #$04
        sta L_b7c9
        rts 


    L_8414:
        lda L_b7c9
        ora #$04
        sta L_b7c9
        rts 


    L_841d:
        lda #$01
        sta $b7c8
        lda L_c31f,x
        beq L_8437
        cmp #$02
        beq L_844d
        lda $c336,x
        cmp #$7c
        bcs L_845a
        cmp #$34
        bcc L_8444
        rts 


    L_8437:
        lda $c336
        cmp #$8c
        bcs L_8444
        lda #$08
        sta $b7c8
        rts 


    L_8444:
        lda $b7c8
        ora #$08
        sta $b7c8
        rts 


    L_844d:
        lda $c336
        cmp #$28
        bcc L_845a
        lda #$04
        sta $b7c8
        rts 


    L_845a:
        lda $b7c8
        ora #$04
        sta $b7c8
        rts 


    L_8463:
        lda #$02
        sta L_b7c9
        lda $c34d
        beq L_84b2
        cmp #$01
        beq L_8474
        jmp L_847b
    L_8474:
        lda L_c364
        cmp #$08
        bcc L_84b2
    L_847b:
        lda L_852f + $2
        bne L_8495
        lda L_c31f
        bne L_848c
    L_8485:
        lda $c336
        cmp #$8c
        bcc L_84b2
    L_848c:
        lda L_b7c9
        ora #$04
        sta L_b7c9
        rts 


    L_8495:
        cmp #$01
        bne L_84ab
        lda L_c31f
        beq L_8485
        cmp #$01
        beq L_84b2
    L_84a2:
        lda L_b7c9
        ora #$08
        sta L_b7c9
        rts 


    L_84ab:
        lda L_c31f
        cmp #$02
        bne L_84a2
    L_84b2:
        rts 


    L_84b3:
        lda #$01
        sta $b7c8
        lda $c34d
        cmp #$02
        beq L_8504
        cmp #$01
        beq L_84c6
        jmp L_84cd
    L_84c6:
        lda L_c364
        cmp #$08
        bcc L_8504
    L_84cd:
        lda L_852f + $2
        bne L_84e7
        lda L_c31f
        bne L_84de
    L_84d7:
        lda $c336
        cmp #$8c
        bcc L_8504
    L_84de:
        lda $b7c8
        ora #$04
        sta $b7c8
        rts 


    L_84e7:
        cmp #$01
        bne L_84fd
        lda L_c31f
        beq L_84d7
        cmp #$01
        beq L_8504
    L_84f4:
        lda $b7c8
        ora #$08
        sta $b7c8
        rts 


    L_84fd:
        lda L_c31f
        cmp #$02
        bne L_84f4
    L_8504:
        rts 


    L_8505:
        inc L_852f + $2
        lda L_852f + $2
        cmp #$03
        bne L_8514
        lda #$00
        sta L_852f + $2
    L_8514:
        rts 


    L_8515:
        lda #$01
        sta L_e006
        sta L_e006 + $1
        jsr L_e000
        rts 


    L_8521:
        lda #$02
        sta L_e006
        lda #$01
        sta L_e006 + $1
        jsr L_e000
        rts 



    L_852f:
         .byte $01,$c6,$00,$00

    L_8533:
        ora $00,x

        .byte $00,$00,$01,$02,$04,$08,$02

    L_853c:
        lda L_4001 + $2
        cmp #$3f
        bne L_8546
        jsr L_8a8b
    L_8546:
        lda #$06
        sta vBorderCol
        sta vBackgCol0
        lda #$02
        sta vBackgCol1
        lda #$07
        sta vBackgCol2
        jsr L_89aa
        jsr L_876f
        lda #$b8
        sta L_8678
        lda #$00
        sta $8677
        sta L_87c7 + $1
        sta $21
        sta L_87c7
        sta $ec
        sta L_876e
        jsr L_882b
        lda #$01
        sta $ee
        lda #$10
        sta vScreenControl1
        lda #$10
        sta vScreenControl2
        lda #$20
        sta vMemControl
        lda #$00
        sta $26
        jsr L_89cc
        jsr $87d4
        lda #$be
        sta L_8679
        lda #$00
        sta L_867a
        sta L_867b
        sta $96dd
        lda #$04
        sta L_87c7 + $2
        lda #$03
        sta vSprEnable
        sta vSprMCM
        lda #$01
        sta vSprPriority
        lda #$0b
        sta vSprMCMCol0
        lda #$00
        sta vSprMCMCol1
        jsr $867c
        lda #$04
        sta L_e006
        lda #$00
        sta L_e006 + $1
        jsr L_e009
    L_85d1:
        lda #$c8
        ldx #$cd
        jsr L_bd07
        jsr $8811
        jsr $8811
        jsr L_882b
        lda $26
        sta $27
        jsr L_8790
        jsr L_8790
        jsr L_869b
        jsr $867c
        jsr L_8602
        jsr L_8602
        lda $96dd
        beq L_85d1
        lda #$00
        sta vScreenControl1
        rts 


    L_8602:
        lda L_867a
        beq L_860b
        dec L_867a
        rts 


    L_860b:
        lda #$02
        sta L_867a
        ldy L_867b
        lda L_8642,y
        cmp #$99
        bne L_8627
        lda #$00
        sta L_867b
        lda #$02
        sta vSprPriority
        jmp L_860b
    L_8627:
        sta $8676
        lda $8676
        bne L_8634
        lda #$01
        sta vSprPriority
    L_8634:
        lda L_8679
        clc 
        adc $8676
        sta L_8679
        inc L_867b
        rts 



    L_8642:
         .byte $f5,$f6,$f7
        .byte $f8,$f9,$f9,$f9,$fa,$fa,$fb,$fb,$fc,$fc,$fd,$fd,$fd,$fe,$fe,$fe
        .byte $fe,$ff,$ff,$ff,$ff,$ff,$00,$01,$01,$01,$01,$01,$02,$02,$02,$02
        .byte $03,$03,$03,$04,$04,$05,$05,$06,$06,$07,$07,$07,$08,$09,$0a,$0b
        .byte $99,$07,$00

    L_8678:
        clv 
    L_8679:
        txa 

    L_867a:
         .byte $02

    L_867b:
        and L_77a8 + $5
        stx $f0

        .byte $04,$ce,$77,$86,$60,$a9,$03,$8d,$77,$86,$ee,$78,$86,$ad,$78,$86
        .byte $c9,$bc,$d0,$05,$a9,$b8,$8d,$78,$86

    L_8699:
        rts 


        rts 


    L_869b:
        lda cCia1PortA
        cmp #$7f
        bne L_86a7
        lda #$00
        sta L_876e
    L_86a7:
        lda L_876e
        beq L_86b0
        dec L_876e
        rts 


    L_86b0:
        lda cCia1PortA
        sta $25
        and #$01
        bne L_86cf
        lda L_87c7 + $2
        beq L_86cf
        lda #$01
        sta L_87c7
        jsr L_87a8
        dec L_87c7 + $2
        lda #$0f
        sta L_876e
        rts 


    L_86cf:
        lda $25
        and #$02
        bne L_86ed
        lda L_87c7 + $2
        cmp #$04
        beq L_86ed
        lda #$01
        sta L_87c7
        jsr L_87a8
        inc L_87c7 + $2
        lda #$0f
        sta L_876e
        rts 


    L_86ed:
        lda $25
        and #$10
        bne L_876d
        lda L_87c7 + $2
        bne L_870a
        inc L_880d
        lda L_880d
        cmp #$04
        bne L_8765
        lda #$00
        sta L_880d
        jmp L_8765
    L_870a:
        cmp #$01
        bne L_8720
        inc L_880d + $1
        lda L_880d + $1
        cmp #$02
        bne L_8765
        lda #$00
        sta L_880d + $1
        jmp L_8765
    L_8720:
        cmp #$02
        bne L_8740
    L_8724:
        inc L_880d + $2
        lda L_880d + $2
        cmp L_8810
        beq L_8724
        cmp #$08
        bne L_8765
        lda #$00
        sta L_880d + $2
        cmp L_8810
        beq L_8724
        jmp L_8765
    L_8740:
        cmp #$03
        bne L_8760
    L_8744:
        inc L_8810
        lda L_8810
        cmp L_880d + $2
        beq L_8744
        cmp #$08
        bne L_8765
        lda #$00
        sta L_8810
        cmp L_880d + $2
        beq L_8744
        jmp L_8765
    L_8760:
        lda #$01
        sta $96dd
    L_8765:
        jsr $87d4
        lda #$32
        sta L_876e
    L_876d:
        rts 



    L_876e:
         .byte $00

    L_876f:
        ldy #$00
    L_8771:
        lda L_2b00,y
        sta SCREEN_BUFFER_1 + $78,y
        lda #$0a
        sta vColorRam + $78,y
        dey 
        bne L_8771
        ldy #$3f
    L_8781:
        lda L_2c00,y
        sta SCREEN_BUFFER_1 + $178,y
        lda #$0a
        sta vColorRam + $178,y
        dey 
        bpl L_8781
        rts 


    L_8790:
        lda L_87c7 + $1
        beq L_8799
        dec L_87c7 + $1
        rts 


    L_8799:
        inc L_87c7
        lda L_87c7
        cmp #$02
        bne L_87a8
        lda #$00
        sta L_87c7
    L_87a8:
        lda #$0a
        sta L_87c7 + $1
        lda L_87c7 + $2
        asl 
        tay 
        lda L_87c7 + $3,y
        sta $1e
        lda L_87c7 + $4,y
        sta $1f
        ldy #$27
    L_87be:
        lda L_87c7
        sta ($1e),y
        dey 
        bne L_87be
        rts 



    L_87c7:
         .byte $00,$00,$04,$30,$da
        .byte $58,$da,$80,$da,$a8,$da,$20,$db,$a9,$01,$20,$cc,$89,$a9,$04,$18
        .byte $6d,$0d,$88,$20,$cc,$89,$a9,$02,$20,$cc,$89,$a9,$08,$18,$6d,$0e
        .byte $88,$20,$cc,$89,$a9,$03,$20,$cc,$89,$a9,$0b,$18,$6d,$0f,$88,$20
        .byte $cc,$89,$a9,$0a,$20,$cc,$89,$a9,$0b,$18,$6d,$10,$88,$20,$cc,$89
        .byte $60

    L_880d:
        .byte $00,$00,$07

    L_8810:
        ora ($c6,x)
        rol $10
        ora $a9,x

        .byte $07,$85,$26,$85,$26,$e6,$21,$a6,$21,$bd,$47,$88,$c9,$ff,$d0,$04
        .byte $a9,$00,$85,$21

    L_882a:
        rts 


    L_882b:
        ldy #$00
        ldx $21
    L_882f:
        lda L_8847,x
        cmp #$ff
        bne L_883b
        ldx #$00
        jmp L_882f
    L_883b:
        and #$3f
        sta SCREEN_BUFFER_1 + $398,y
        inx 
        iny 
        cpy #$28
        bne L_882f
        rts 



    L_8847:
         .byte $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
        .byte $28,$43,$29,$20,$31,$39,$39,$32,$20,$5a,$45,$50,$50,$45,$4c,$49
        .byte $4e,$20,$47,$41,$4d,$45,$53,$20,$4c,$54,$44,$2e,$20,$20,$20,$20
        .byte $20,$20,$43,$4f,$44,$45,$20,$42,$59,$20,$44,$41,$56,$45,$20,$53
        .byte $4f,$57,$45,$52,$42,$59,$2c,$20,$20,$47,$52,$41,$50,$48,$49,$43
        .byte $53,$20,$42,$59,$20,$4e,$45,$49,$4c,$20,$48,$49,$53,$4c,$4f,$50
        .byte $2c,$20,$20

    L_88a9:
        eor L_5355
        eor #$43
        jsr L_1ff5 + $31
        lsr $58
        jsr L_5936 + $c
        jsr L_4e3c + $5

        .byte $44,$59,$20,$52,$4f,$44,$47,$45,$52,$2e,$2e,$2e,$20,$20,$20,$20
        .byte $ff,$f0

    L_88cb:
        .byte $88,$fc
        .byte $88,$0e,$89,$26,$89,$52,$89,$58,$89,$5e,$89,$64,$89,$6a,$89,$6e
        .byte $89,$3c,$89,$72,$89,$79,$89,$80,$89,$87,$89,$8e,$89,$95,$89,$9c
        .byte $89,$a3,$89,$fe,$10,$14,$4b,$49,$43,$4b,$20,$4f,$46,$46,$ff,$fe
        .byte $0d,$0e,$48,$41,$4c,$46,$20,$4c,$45,$4e,$47,$54,$48,$20,$3a,$20
        .byte $ff,$fe,$07,$0f,$4e,$55,$4d,$42,$45,$52,$20,$4f,$46,$20,$50,$4c
        .byte $41,$59,$45,$52,$53,$20,$3a,$20,$ff,$fe,$09,$10,$50,$4c,$41,$59
        .byte $45,$52,$20,$31,$20,$43,$4f,$4c,$4f,$55,$52,$20,$3a,$20,$ff,$fe
        .byte $09,$11,$50,$4c,$41,$59,$45,$52,$20,$32,$20,$43,$4f,$4c,$4f,$55
        .byte $52,$20,$3a,$20,$ff,$32,$2e,$30,$30,$20,$ff,$34,$2e,$30,$30,$20
        .byte $ff,$38,$2e,$30,$30,$20,$ff,$31,$32,$2e,$30,$30,$ff,$4f,$4e,$45
        .byte $ff,$54,$57,$4f,$ff,$42,$4c,$41,$43,$4b

    L_8977:
        jsr L_57f7 + $8

        .byte $48,$49,$54,$45,$20,$ff,$52,$45,$44,$20,$20,$20,$ff,$43,$59,$41
        .byte $4e,$20,$20,$ff,$50,$55,$52,$50,$4c,$45,$ff,$47,$52,$45,$45,$4e
        .byte $20,$ff,$42,$4c,$55,$45,$20,$20,$ff,$59,$45,$4c,$4c,$4f,$57,$ff

    L_89aa:
        ldy #$00
    L_89ac:
        lda #$ff
        sta SCREEN_BUFFER_1 + $00,y
        sta SCREEN_BUFFER_1 + $100,y
        sta SCREEN_BUFFER_1 + $200,y
        sta SCREEN_BUFFER_1 + $300,y
        lda #$01
        sta vColorRam + $00,y
        sta vColorRam + $100,y
        sta vColorRam + $200,y
        sta vColorRam + $300,y
        dey 
        bne L_89ac
        rts 


    L_89cc:
        asl 
        tay 
        lda $88ca,y
        sta $1c
        lda L_88cb,y
        sta $1d
        ldy #$00
        sty L_8a48
    L_89dd:
        ldy L_8a48
        lda ($1c),y
        inc L_8a48
        cmp #$ff
        beq L_8a03
        cmp #$fe
        beq L_8a04
    L_89ed:
        cmp #$20
        beq L_89f6
        and #$3f
        jmp L_89f8
    L_89f6:
        lda #$ff
    L_89f8:
        ldy L_8a49
        sta ($1e),y
        inc L_8a49
        jmp L_89dd
    L_8a03:
        rts 


    L_8a04:
        ldy L_8a48
        lda ($1c),y
        sta L_8a49
        iny 
        lda ($1c),y
        ldx #$00
        stx $1e
        stx $1f
        asl 
        rol $1f
        asl 
        rol $1f
        asl 
        sta $1e
        rol $1f
        asl 
        rol $1f
        asl 
        rol $1f
        clc 
        adc $1e
        sta $1e
        lda $1f
        adc #$00
        sta $1f
        lda $1e
        clc 
        adc #$00
        sta $1e
        lda $1f
        adc #$48
        sta $1f
        iny 
        lda ($1c),y
        iny 
        sty L_8a48
        jmp L_89ed

    L_8a48:
         .byte $07

    L_8a49:
        and ($a9,x)

        .byte $00,$8d,$dd,$96,$a9,$7f,$8d,$00,$dc,$ad,$01,$dc,$2c,$84,$8a,$f0
        .byte $01,$60

    L_8a5d:
        lda #$7f
        sta cCia1PortA
        lda cCia1PortB
        bit L_8a84
        beq L_8a5d
    L_8a6a:
        lda #$7f
        sta cCia1PortA
        lda cCia1PortB
        bit L_8a83
        beq L_8a85
        bit L_8a81
        bne L_8a6a
        rts 



    L_8a7d:
         .byte $01,$02,$04
        .byte $08

    L_8a81:
        bpl L_8aa3
    L_8a83:
        rti 

    L_8a84:
         .byte $80

    L_8a85:
        lda #$01
        sta $96dd
        rts 


    L_8a8b:
        lda #$00
        sta vIRQMasks
        sei 
        lda #$07
        sta $00
        lda #$34
        sta $01
        lda #$d0
        sta $8abd
        sta $8ac4
        lda #$40
    L_8aa3:
        sta $8ac1
        sta $8ac8
        jsr L_8ab7
        lda #$35
        sta $01
        lda #$01
        sta vIRQMasks
        cli 
        rts 


    L_8ab7:
        ldx #$07
    L_8ab9:
        ldy #$00
    L_8abb:
        lda L_fef1 + $f,y
        pha 
        lda L_fef1 + $f,y
        sta L_fef1 + $f,y
        pla 
        sta L_fef1 + $f,y
        dey 
        bne L_8abb
        inc $8abd
        inc $8ac1
        inc $8ac4
        inc $8ac8
        dex 
        bpl L_8ab9
        rts 


    L_8adc:
        lda $8d1c
        beq L_8aea
        dec $8d1c
        lda #$6c
        sta L_c393
        rts 


    L_8aea:
        lda $e3
        beq L_8af8
        lda #$6c
        sta L_c393
        lda #$02
        sta L_8d13 + $3
    L_8af8:
        lda $d5
        beq L_8b02
        lda #$6c
        sta L_c393
        rts 


    L_8b02:
        lda L_c31d + $1
        bne L_8b51
        lda #$00
        sta L_8d13
        sta L_8d13 + $4
        lda L_8d13 + $3
        bne L_8b2f
        lda #$86
        sta L_8d13 + $1
        lda #$24
        sta L_8d13 + $2
        jsr L_8ca0
        jsr L_8ca0
        jsr L_8ca0
        lda #$6c
        sta L_c393
        jmp L_8d1d
    L_8b2f:
        cmp #$01
        bne L_8b51
        lda #$00
        sta L_8d13 + $2
        lda #$c8
        sta L_8d13 + $1
        jsr L_8ca0
        jsr L_8cf2
        jsr L_8ca0
        jsr L_8cf2
        lda #$6c
        sta L_c393
        jmp L_8d1d
    L_8b51:
        lda L_8d13 + $3
        cmp #$02
        bne L_8b9d
        lda #$01
        sta L_c3ef
        lda #$58
        sta L_c3f8 + $e
        ldy #$01
        jsr L_a6df
        lda $c365
        cmp #$58
        beq L_8b79
        bcc L_8b76
        dec $c365
        jmp L_8b79
    L_8b76:
        inc $c365
    L_8b79:
        lda $c320
        cmp #$01
        bne L_8b9c
        lda $c337
        cmp #$58
        bne L_8b9c
        lda $c365
        cmp #$58
        bne L_8b9c
        lda #$00
        sta L_8d13 + $3
        sta L_8d13 + $5
        sta L_8d1a
        sta L_8d13 + $6
    L_8b9c:
        rts 


    L_8b9d:
        cmp #$03
        bne L_8bb4
        dec $8d1b
        lda $8d1b
        bne L_8bb3
        lda #$02
        sta L_8d13 + $3
        lda #$6c
        sta L_c393
    L_8bb3:
        rts 


    L_8bb4:
        cmp #$04
        bne L_8be1
        jsr L_8ccf
        jsr L_8ccf
        jsr L_8ccf
        jsr L_8ccf
        dec L_8d13 + $5
        lda L_8d13 + $5
        bne L_8be0
        lda #$02
        sta L_8d13 + $3
        lda #$71
        sta L_c393
        lda #$08
        sta L_8d13 + $3
        lda #$1e
        sta L_8d13 + $6
    L_8be0:
        rts 


    L_8be1:
        cmp #$05
        bne L_8c0e
        jsr L_8cb8
        jsr L_8cb8
        jsr L_8cb8
        jsr L_8cb8
        dec L_8d13 + $5
        lda L_8d13 + $5
        bne L_8c0d
        lda #$02
        sta L_8d13 + $3
        lda #$70
        sta L_c393
        lda #$08
        sta L_8d13 + $3
        lda #$1e
        sta L_8d13 + $6
    L_8c0d:
        rts 


    L_8c0e:
        cmp #$08
        bne L_8c25
        dec L_8d13 + $6
        lda L_8d13 + $6
        bne L_8c24
        lda #$6c
        sta L_c393
        lda #$02
        sta L_8d13 + $3
    L_8c24:
        rts 


    L_8c25:
        cmp #$07
        bne L_8c5e
        jsr L_8cb8
        jsr L_8cb8
        jsr L_8cb8
        jsr L_8cb8
        dec L_8d13 + $5
        lda L_8d13 + $5
        bne L_8c5d
        lda #$04
        sta L_8d13 + $5
        ldy L_8d1a
        lda L_8c98,y
        cmp #$ff
        bne L_8c57
        lda #$08
        sta L_8d13 + $3
        lda #$1e
        sta L_8d13 + $6
        rts 


    L_8c57:
        sta L_c393
        inc L_8d1a
    L_8c5d:
        rts 


    L_8c5e:
        cmp #$06
        bne L_8c97
        jsr L_8ccf
        jsr L_8ccf
        jsr L_8ccf
        jsr L_8ccf
        dec L_8d13 + $5
        lda L_8d13 + $5
        bne L_8c96
        lda #$04
        sta L_8d13 + $5
        ldy L_8d1a
        lda L_8c9b + $1,y
        cmp #$ff
        bne L_8c90
        lda #$08
        sta L_8d13 + $3
        lda #$1e
        sta L_8d13 + $6
        rts 


    L_8c90:
        sta L_c393
        inc L_8d1a
    L_8c96:
        rts 


    L_8c97:
        rts 



    L_8c98:
         .byte $72
        .byte $e9,$70

    L_8c9b:
        .byte $ff,$73
        .byte $ea,$71,$ff

    L_8ca0:
        lda L_c31f
        sec 
        sbc $c320
        beq L_8cde
        bcc L_8cc7
    L_8cab:
        lda $c320
        beq L_8cb8
        lda $c337
        cmp L_8d13 + $1
        bcs L_8cc6
    L_8cb8:
        lda $c337
        clc 
        adc #$01
        sta $c337
        bcc L_8cc6
        inc $c320
    L_8cc6:
        rts 


    L_8cc7:
        lda $c337
        cmp L_8d13 + $2
        bcc L_8cdd
    L_8ccf:
        lda $c337
        sec 
        sbc #$01
        sta $c337
        bcs L_8cdd
        dec $c320
    L_8cdd:
        rts 


    L_8cde:
        lda $c336
        sec 
        sbc $c337
        beq L_8cec
        bcc L_8cc7
        jmp L_8cab
    L_8cec:
        lda #$01
        sta L_8d13
        rts 


    L_8cf2:
        lda L_c364
        clc 
        adc #$16
        sec 
        sbc $c365
        beq L_8d08
        bcc L_8d04
        inc $c365
        rts 


    L_8d04:
        dec $c365
        rts 


    L_8d08:
        lda L_8d13
        beq L_8d12
        lda #$01
        sta L_8d13 + $4
    L_8d12:
        rts 



    L_8d13:
         .byte $ad,$9f,$be,$c9,$65,$b0,$1c

    L_8d1a:
        lda L_be5a
    L_8d1d:
        lda L_8d13 + $4
        bne L_8d23
        rts 


    L_8d23:
        lda #$7c
        sta $c392
        lda #$bc
        sta L_c393
        lda #$00
        sta $a466
        jsr L_a441
        lda #$99
        sta $c6
        sta $d0
        lda #$04
        sta $cd
        jsr L_a7c1
        lda $e6
        sta $e0
        lda $e7
        sta $e1
        lda #$00
        sta L_8e77
        lda $c337
        clc 
        adc #$05
        sta $c337
        lda $c320
        adc #$00
        sta $c320
        lda #$00
        sta $af7c
        lda #$12
        sta L_8e00
        lda L_c31f
        sta $8e01
        lda $c336
        sta L_8e02
        lda #$32
        sta L_9b2d
    L_8d7b:
        lda L_8e00
        beq L_8d9b
        dec L_8e00
        lda L_8e00
        bne L_8d9b
        lda #$9c
        sta L_c393
        lda #$be
        sta $c392
        lda L_c364
        clc 
        adc #$16
        sta L_c364
    L_8d9b:
        jsr L_a2fd
        jsr L_a314
        jsr L_a635
        jsr $8e03
        jsr L_8de8
        lda L_8e77
        beq L_8d7b
        lda L_c364
        sec 
        sbc #$11
        sta L_c364
        lda #$02
        sta L_af7d
        lda #$05
        sta L_af7b
        lda #$40
        sta $af7a
        lda #$06
        sta L_af79
        lda #$00
        sta $af78
        lda #$02
        sta L_8d13 + $3
        lda #$1e
        sta $d5
        lda #$14
        sta $8d1c
        lda #$01
        sta L_c31d
        jsr L_8515
        rts 


    L_8de8:
        lda L_880d + $1
        bne L_8dff
        lda $e5
        beq L_8dff
        lda L_9b2d
        beq L_8dfa
        dec L_9b2d
        rts 


    L_8dfa:
        lda #$01
        sta L_8e77
    L_8dff:
        rts 


    L_8e00:
        lda #$00
    L_8e02:
        sta.a $00a0
        lda ($e0),y
        sta $25
        and #$04
        bne L_8e2b
        lda #$9d
        sta L_c393
        lda #$02
        sta $af7c
        lda L_8e02
        sec 
        sbc #$01
        sta $c336
        lda $8e01
        sbc #$00
        sta L_c31f
        jmp L_8e6b
    L_8e2b:
        lda $25
        and #$08
        bne L_8e4f
        lda #$9b
        sta L_c393
        lda #$01
        sta $af7c
        lda L_8e02
        clc 
        adc #$01
        sta $c336
        lda $8e01
        adc #$00
        sta L_c31f
        jmp L_8e6b
    L_8e4f:
        lda $25
        and #$02
        bne L_8e6b
        lda #$9c
        sta L_c393
        lda #$00
        sta $af7c
        lda $8e01
        sta L_c31f
        lda L_8e02
        sta $c336
    L_8e6b:
        lda $25
        and #$10
        bne L_8e76
        lda #$01
        sta L_8e77
    L_8e76:
        rts 


    L_8e77:
        php 
    L_8e78:
        lda $8d1c
        bne L_8e9c
        lda $24
        cmp #$09
        bcs L_8e9c
        jsr L_9023
    L_8e86:
        ldy #$01
        jsr L_8e9d + $2
        lda L_905f
        bne L_8e9c
        lda L_8d13 + $3
        cmp #$01
        bne L_8e9c
        lda #$02
        sta L_8d13 + $3
    L_8e9c:
        rts 



    L_8e9d:
         .byte $ce,$7d,$a9,$09,$8d,$9d,$8e,$a9,$fb
        .byte $8d,$9e,$8e,$ad,$16,$8d,$c9,$04,$90,$0a,$a9,$0c,$8d,$9d,$8e,$a9
        .byte $f8,$8d,$9e,$8e

    L_8eba:
        lda L_c31f,y
        sta $2f
        lda $c336,y
        sec 
        sbc #$04
        bcs L_8ec9
        dec $2f
    L_8ec9:
        sec 
    L_8eca:
        sbc $c336
        sta $30
        bcs L_8ed3
        dec $2f
    L_8ed3:
        lda $2f
        sec 
        sbc L_c31f
        sta $2f
        lda L_c364
        clc 
        adc #$1a
        sec 
        sbc L_c364,y
        sta $d3
        cmp #$10
        bcc L_8eec
        rts 


    L_8eec:
        ldx #$00
        lda $2f
        bne L_8efc
        lda $30
        cmp L_8e9d
        bcs L_8f0b
        jmp L_8fec
    L_8efc:
        cmp #$ff
        bne L_8f0a
        lda $30
        cmp L_8e9d + $1
        bcc L_8f0b
        jmp L_8fec
    L_8f0a:
        rts 


    L_8f0b:
        lda $af7c
        cmp #$01
        beq L_8f24
        lda $8d1b
        bne L_8f23
        lda $d3
        cmp #$07
        bcc L_8f23
        lda $30
        cmp #$1f
        bcc L_8f36
    L_8f23:
        rts 


    L_8f24:
        lda $8d1b
        bne L_8f35
        lda $d3
        cmp #$07
        bcc L_8f35
        lda $30
        cmp #$e5
        bcs L_8f6e
    L_8f35:
        rts 


    L_8f36:
        lda L_8d13 + $5
        bne L_8f35
        lda $c392
        cmp #$80
        bcs L_8f52
        lda #$0c
        sta L_8d13 + $5
        lda #$04
        sta L_8d13 + $3
        lda #$e6
        sta L_c393
        rts 


    L_8f52:
        lda L_8d13 + $3
        cmp #$06
        beq L_8f6d
        lda #$6e
        sta L_c393
        lda #$06
        sta L_8d13 + $3
        lda #$04
        sta L_8d13 + $5
        lda #$00
        sta L_8d1a
    L_8f6d:
        rts 


    L_8f6e:
        lda L_8d13 + $5
        bne L_8f35
        lda $c392
        cmp #$80
        bcs L_8f9b
        lda #$0c
        sta L_8d13 + $5
        lda #$05
        sta L_8d13 + $3
        lda #$e5
        sta L_c393
        lda $c337
        clc 
        adc #$0c
        sta $c337
        lda $c320
        adc #$00
        sta $c320
    L_8f9a:
        rts 


    L_8f9b:
        lda L_8d13 + $3
        cmp #$07
        beq L_8fc7
        lda #$6d
        sta L_c393
        lda $c337
        clc 
        adc #$0c
        sta $c337
        lda $c320
        adc #$00
        sta $c320
        lda #$07
        sta L_8d13 + $3
        lda #$04
        sta L_8d13 + $5
        lda #$00
        sta L_8d1a
    L_8fc7:
        rts 


    L_8fc8:
        lda $af7c
        beq L_8fd0
        jmp L_8f0b
    L_8fd0:
        lda $8d1b
        bne L_8f9a
        lda $c392
        cmp #$80
        bcc L_8f9a
        lda #$03
        sta L_8d13 + $3
        lda #$6f
        sta L_c393
        lda #$0c
        sta $8d1b
        rts 


    L_8fec:
        lda $d3
        cmp #$07
        bcs L_8fc8
        lda #$14
        sta $ed
        lda $af7c
        bne L_9010
        lda $9060
        sta $af7c
        inc $9060
        lda $9060
        cmp #$03
        bne L_9010
        lda #$01
        sta $9060
    L_9010:
        lda #$02
        sta L_af7d
        lda #$00
        sta L_e006
        lda #$01
        sta L_e006 + $1
        jsr L_e000
        rts 


    L_9023:
        lda $c34d
        bne L_904b
        lda L_c364
        cmp #$65
        bcs L_904b
        lda L_c31f
        bne L_9051
        lda $c336
        cmp #$f3
        bcc L_904b
    L_903b:
        lda #$01
        sta L_905f
        lda $af7a
        bne L_904a
        lda #$01
        sta L_8d13 + $3
    L_904a:
        rts 


    L_904b:
        lda #$00
        sta L_905f
        rts 


    L_9051:
        cmp #$01
        bne L_904b
        lda $c336
        cmp #$b5
        bcs L_904b
        jmp L_903b
    L_905f:
        ora $a9
    L_9061:
        lda L_9296
        beq L_906f
        dec L_9296
        lda #$74
        sta L_c396 + $8
        rts 


    L_906f:
        lda $e3
        beq L_907d
        lda #$74
        sta L_c396 + $8
        lda #$02
        sta L_9290
    L_907d:
        lda $d5
        beq L_9087
        lda #$74
        sta L_c396 + $8
        rts 


    L_9087:
        lda L_c31d + $1
        bne L_90d6
        lda #$00
        sta L_8d13
        sta L_9291
        lda L_9290
        bne L_90b4
        lda #$86
        sta L_8d13 + $1
        lda #$24
        sta L_8d13 + $2
        jsr $921d
        jsr $921d
        jsr $921d
        lda #$74
        sta L_c396 + $8
        jmp $9298
    L_90b4:
        cmp #$01
        bne L_90d6
        lda #$00
        sta L_8d13 + $2
        lda #$c8
        sta L_8d13 + $1
        jsr $921d
        jsr L_926f
        jsr $921d
        jsr L_926f
        lda #$74
        sta L_c396 + $8
        jmp $9298
    L_90d6:
        lda L_9290
        cmp #$02
        bne L_9124
        lda #$01
        sta L_c3f8 + $2
        lda #$58
        sta L_c40f + $2
        lda #$02
        sta L_c428
        lda #$6f
        sta L_c438 + $7
        ldy #$0c
        jsr L_a6df
        jsr L_a736
        lda $c32b
        cmp #$01
        bne L_9123
        lda $c342
        cmp #$58
        bne L_9123
        lda L_c359
        cmp #$02
        bne L_9123
        lda L_c36f + $1
        cmp #$6f
        bne L_9123
        lda #$00
        sta L_9290
        sta $9292
        sta $9294
        sta L_9293
    L_9123:
        rts 


    L_9124:
        cmp #$03
        bne L_913b
        dec $9295
        lda $9295
        bne L_913a
        lda #$02
        sta L_9290
        lda #$74
        sta L_c396 + $8
    L_913a:
        rts 


    L_913b:
        cmp #$04
        bne L_9163
        jsr L_924c
        jsr L_924c
        jsr L_924c
        jsr L_924c
        dec $9292
        lda $9292
        bne L_9162
        lda #$79
        sta L_c396 + $8
        lda #$08
        sta L_9290
        lda #$1e
        sta L_9293
    L_9162:
        rts 


    L_9163:
        cmp #$05
        bne L_918b
        jsr L_9235
        jsr L_9235
        jsr L_9235
        jsr L_9235
        dec $9292
        lda $9292
        bne L_918a
        lda #$78
        sta L_c396 + $8
        lda #$08
        sta L_9290
        lda #$1e
        sta L_9293
    L_918a:
        rts 


    L_918b:
        cmp #$08
        bne L_91a2
        dec L_9293
        lda L_9293
        bne L_91a1
        lda #$74
        sta L_c396 + $8
        lda #$02
        sta L_9290
    L_91a1:
        rts 


    L_91a2:
        cmp #$07
        bne L_91db
        jsr L_9235
        jsr L_9235
        jsr L_9235
        jsr L_9235
        dec $9292
        lda $9292
        bne L_91da
        lda #$04
        sta $9292
        ldy $9294
        lda L_9215,y
        cmp #$ff
        bne L_91d4
        lda #$08
        sta L_9290
        lda #$1e
        sta L_9293
        rts 


    L_91d4:
        sta L_c396 + $8
        inc $9294
    L_91da:
        rts 


    L_91db:
        cmp #$06
        bne L_9214
        jsr L_924c
        jsr L_924c
        jsr L_924c
        jsr L_924c
        dec $9292
        lda $9292
        bne L_9213
        lda #$04
        sta $9292
        ldy $9294
        lda L_9218 + $1,y
        cmp #$ff
        bne L_920d
        lda #$08
        sta L_9290
        lda #$1e
        sta L_9293
        rts 


    L_920d:
        sta L_c396 + $8
        inc $9294
    L_9213:
        rts 


    L_9214:
        rts 



    L_9215:
         .byte $7a,$e7
        .byte $78

    L_9218:
        .byte $ff,$7b
        .byte $e8,$79,$ff,$ad,$1f,$c3,$38,$ed,$2b,$c3,$f0,$35,$90,$1c

    L_9228:
        lda $c32b
        beq L_9235
        lda $c342
        cmp L_8d13 + $1
        bcs L_9243
    L_9235:
        lda $c342
        clc 
        adc #$01
        sta $c342
        bcc L_9243
        inc $c32b
    L_9243:
        rts 


    L_9244:
        lda $c342
        cmp L_8d13 + $2
        bcc L_925a
    L_924c:
        lda $c342
        sec 
        sbc #$01
        sta $c342
        bcs L_925a
        dec $c32b
    L_925a:
        rts 


    L_925b:
        lda $c336
        sec 
        sbc $c342
        beq L_9269
        bcc L_9244
        jmp L_9228
    L_9269:
        lda #$01
        sta L_8d13
        rts 


    L_926f:
        lda L_c364
        clc 
        adc #$1a
        sec 
        sbc L_c36f + $1
        beq L_9285
        bcc L_9281
        inc L_c36f + $1
        rts 


    L_9281:
        dec L_c36f + $1
        rts 


    L_9285:
        lda L_8d13
        beq L_928f
        lda #$01
        sta L_9291
    L_928f:
        rts 



    L_9290:
         .byte $bf

    L_9291:
        lda #$6c
    L_9293:
        sta $bf40,y
    L_9296:
        rts 


    L_9297:
        jsr $91ad

        .byte $92,$d0,$01,$60

    L_929e:
        lda #$7c
        sta $c392
        lda #$00
        sta $a466
        jsr L_a441
        lda #$99
        sta $c6
        sta $d0
        lda #$07
        sta $cd
        jsr L_a7c1
        lda $e8
        sta $e0
        lda $e9
        sta $e1
        lda #$00
        sta L_939e
        lda $c342
        clc 
        adc #$05
        sta $c342
        lda $c32b
        adc #$00
        sta $c32b
        lda #$bd
        sta L_c396 + $8
        lda #$00
        sta $af7c
        lda #$12
        sta L_9297
        lda #$32
        sta L_9b2d
    L_92ea:
        lda L_9297
        beq L_92fc
        dec L_9297
        lda L_9297
        bne L_92fc
        lda #$98
        sta L_c396 + $8
    L_92fc:
        jsr L_a2fd
        jsr L_a314
        jsr L_a635
        jsr L_9358
        jsr L_9340
        lda L_939e
        beq L_92ea
        lda #$01
        sta L_af7d
        lda #$05
        sta L_af7b
        lda #$40
        sta $af7a
        lda #$06
        sta L_af79
        lda #$00
        sta $af78
        lda #$02
        sta L_9290
        lda #$1e
        sta $d5
        lda #$14
        sta L_9296
        lda #$02
        sta L_c31d
        jsr L_8515
        rts 


    L_9340:
        lda L_880d + $1
        bne L_9357
        lda $e5
        bne L_9357
        lda L_9b2d
        beq L_9352
        dec L_9b2d
        rts 


    L_9352:
        lda #$01
        sta L_939e
    L_9357:
        rts 


    L_9358:
        ldy #$00
        lda ($e0),y
        sta $25
        and #$04
        bne L_936f
        lda #$9f
        sta L_c396 + $8
        lda #$02
        sta $af7c
        jmp L_9392
    L_936f:
        lda $25
        and #$08
        bne L_9382
        lda #$99
        sta L_c396 + $8
        lda #$01
        sta $af7c
        jmp L_9392
    L_9382:
        lda $25
        and #$01
        bne L_9392
        lda #$98
        sta L_c396 + $8
        lda #$00
        sta $af7c
    L_9392:
        lda $25
        and #$10
        bne L_939d
        lda #$01
        sta L_939e
    L_939d:
        rts 



    L_939e:
         .byte $a7

    L_939f:
        lda L_9296
        bne L_93c3
        lda $24
        cmp #$2a
        bcc L_93c3
        jsr L_955f
        ldy #$0c
        jsr L_93c4
        lda L_959d
        bne L_93c3
        lda L_9290
        cmp #$01
        bne L_93c3
        lda #$02
        sta L_9290
    L_93c3:
        rts 


    L_93c4:
        lda #$09
        sta L_8e9d
        lda #$fb
        sta L_8e9d + $1
        lda L_9290
        cmp #$04
        bcc L_93df
        lda #$0d
        sta L_8e9d
        lda #$f7
        sta L_8e9d + $1
    L_93df:
        lda L_c31f,y
        sta $2f
        lda $c336,y
        sec 
        sbc #$04
        bcs L_93ee
        dec $2f
    L_93ee:
        sec 
        sbc $c336
        sta $30
        bcs L_93f8
        dec $2f
    L_93f8:
        lda $2f
        sec 
        sbc L_c31f
        sta $2f
    L_9400:
        lda $c34d
        sta $d4
        lda L_c364
        clc 
        adc #$1a
        bcc L_940f
        inc $d4
    L_940f:
        sec 
        sbc L_c364,y
        sta $d3
        lda $d4
        sec 
        sbc $c34d,y
        sta $d4
        lda $d4
        bne L_9427
        lda $d3
        cmp #$e6
        bcs L_9428
    L_9427:
        rts 


    L_9428:
        ldx #$00
        lda $2f
        bne L_9438
        lda $30
        cmp L_8e9d
        bcs L_9447
        jmp L_9528
    L_9438:
        cmp #$ff
        bne L_9446
        lda $30
        cmp L_8e9d + $1
        bcc L_9447
        jmp L_9528
    L_9446:
        rts 


    L_9447:
        lda $af7c
        cmp #$01
        beq L_9460
        lda $9295
        bne L_945f
        lda $d3
        cmp #$f8
        bcc L_945f
        lda $30
        cmp #$1f
        bcc L_9472
    L_945f:
        rts 


    L_9460:
        lda $9295
        bne L_9471
        lda $d3
        cmp #$07
        bcc L_9471
        lda $30
        cmp #$e5
        bcs L_94aa
    L_9471:
        rts 


    L_9472:
        lda $9292
        bne L_9471
        lda $c392
        cmp #$80
        bcs L_948e
        lda #$0c
        sta $9292
        lda #$04
        sta L_9290
        lda #$e4
        sta L_c394
        rts 


    L_948e:
        lda L_9290
        cmp #$06
        beq L_94a9
        lda #$76
        sta L_c396 + $8
        lda #$06
        sta L_9290
        lda #$04
        sta $9292
        lda #$00
        sta $9294
    L_94a9:
        rts 


    L_94aa:
        lda $9292
        bne L_9471
        lda $c392
        cmp #$80
        bcs L_94d7
        lda #$0c
        sta $9292
        lda #$05
        sta L_9290
        lda #$e3
        sta L_c396 + $8
        lda $c342
        clc 
        adc #$0c
        sta $c342
        lda $c32b
        adc #$00
        sta $c32b
    L_94d6:
        rts 


    L_94d7:
        lda L_9290
        cmp #$07
        beq L_9503
        lda #$75
        sta L_c396 + $8
        lda $c342
        clc 
        adc #$0c
        sta $c342
        lda $c32b
        adc #$00
        sta $c32b
        lda #$07
        sta L_9290
        lda #$04
        sta $9292
        lda #$00
        sta $9294
    L_9503:
        rts 


    L_9504:
        lda $af7c
        beq L_950c
        jmp L_9447
    L_950c:
        lda $9295
        bne L_94d6
        lda $c392
        cmp #$80
        bcc L_94d6
        lda #$03
        sta L_9290
        lda #$77
        sta L_c396 + $8
        lda #$0c
        sta $9295
        rts 


    L_9528:
        lda $d3
        cmp #$f8
        bcc L_9504
        lda #$14
        sta $ed
        lda $af7c
        bne L_954c
        lda $9060
        sta $af7c
        inc $9060
        lda $9060
        cmp #$03
        bne L_954c
        lda #$01
        sta $9060
    L_954c:
        lda #$01
        sta L_af7d
        lda #$00
        sta L_e006
        lda #$01
        sta L_e006 + $1
        jsr L_e000
        rts 


    L_955f:
        lda $c34d
        cmp #$02
        bne L_9589
        lda L_c364
        cmp #$2c
        bcc L_9589
        lda L_c31f
        bne L_958f
        lda $c336
        cmp #$f3
        bcc L_9589
    L_9579:
        lda #$01
        sta L_959d
        lda $af7a
        bne L_9588
        lda #$01
        sta L_9290
    L_9588:
        rts 


    L_9589:
        lda #$00
        sta L_959d
        rts 


    L_958f:
        cmp #$01
        bne L_9589
        lda $c336
        cmp #$b5
        bcs L_9589
        jmp L_9579
    L_959d:
        asl 
    L_959e:
        lda #$01
        sta L_c31f,x
        sta L_c31f,y
        sta $c34d,x
        sta $c34d,y
        lda #$67
        sta L_c364,x
        sta L_c364,y
        lda #$44
        sta $c336,x
        lda #$6c
        sta $c336,y
        rts 


    L_95bf:
        lda #$01
        sta $c3ee,x
        sta $c3ee,y
        sta $c41c,x
        sta $c41c,y
        lda #$67
        sta $c433,x
        sta $c433,y
        lda #$44
        sta L_c3f8 + $d,x
        lda #$6c
        sta L_c3f8 + $d,y
        rts 


    L_95e0:
        lda #$02
        sta L_e006
        lda #$01
        sta L_e006 + $1
        jsr L_e000
        jsr L_96e1
        lda $e5
        bne L_9613
        lda #$07
        sta L_e006
        lda #$00
        sta L_e006 + $1
        jsr L_e009
        lda #$c3
        sta L_968f
        lda #$c4
        sta L_968f + $1
        lda #$c5
        sta L_968f + $2
        jmp L_962f
    L_9613:
        lda #$c9
        sta L_968f
        lda #$ca
        sta L_968f + $1
        lda #$cb
        sta L_968f + $2
        lda #$08
        sta L_e006
        lda #$00
        sta L_e006 + $1
        jsr L_e009
    L_962f:
        lda #$00
        jsr L_bd07
        lda #$0a
        sta L_96df + $1
        lda #$01
        sta $ec
        lda #$3f
        sta vSprEnable
        sta vSprMCM
        lda #$00
        sta vSprExpandY
        lda #$00
        sta L_96df
        sta $96de
        sta $96dd
    L_9655:
        lda #$00
        jsr L_bd07
        jsr L_98d5
        jsr $9893
        jsr L_968f + $6
        lda $96dd
        beq L_9655
        lda #$00
        sta $96dd
        lda #$01
        sta L_a2de
    L_9672:
        lda #$00
        jsr L_bd07
        dec $96dd
        lda $96dd
        bne L_9672
        dec L_a2de
        lda L_a2de
        bne L_9672
        lda #$00
        sta vScreenControl1
        sta $ec
        rts 



    L_968f:
         .byte $85,$c6,$85,$d0,$ac,$a4,$ad,$de,$96,$f0,$04
        .byte $ce,$de,$96,$60,$a9,$04,$8d,$de,$96,$ac,$df,$96,$b9,$be,$96,$c9
        .byte $99,$d0,$06,$a9,$01,$8d,$dd,$96,$60

    L_96b3:
        clc 
        adc L_96df + $1
        sta L_96df + $1
        inc L_96df
        rts 



    L_96be:
         .byte $0c,$0b
        .byte $0a,$0a,$09,$09,$08,$08,$07,$07,$06,$06,$05,$05,$04,$04,$03,$03
        .byte $03,$02,$02,$02,$02,$01,$01,$01,$01,$01,$01,$00,$99,$00,$d9

    L_96df:
        .byte $57,$bf

    L_96e1:
        ldy #$16
    L_96e3:
        lda $c532,y
        sta $c3ee,y
        lda L_c546 + $3,y
        sta L_c3f8 + $d,y
        lda L_c560,y
        sta $c41c,y
        lda L_c577,y
        sta $c433,y
        dey 
        cpy #$01
        bne L_96e3
        lda $e3
        beq L_9719
        cmp #$01
        bne L_9712
        ldx #$06
        ldy #$07
        jsr L_95bf
        jmp L_9719
    L_9712:
        ldx #$10
        ldy #$11
        jsr L_95bf
    L_9719:
        lda #$00
        sta $a466
        jsr L_a441
        lda #$99
        sta $c6
        sta $d0
        lda #$01
        sta L_c31f
        sta $c34d
        lda #$54
        sta $c336
        lda #$4e
        sta L_c364
        lda #$7c
        sta $c392
        lda $e3
        beq L_9752
        lda #$06
        sta L_8533
        lda $e3
        cmp #$01
        bne L_9752
        lda #$10
        sta L_8533
    L_9752:
        jsr L_a2fd
        jsr L_a314
        jsr L_984f
        jsr L_984f
        jsr L_984f
        jsr L_984f
        jsr L_984f
        jsr L_a635
        jsr L_a635
        lda L_a793 + $1
        cmp #$14
        bcc L_9752
        rts 


    L_9775:
        lda $e3
        cmp #$01
        beq L_9780
        ldy $c6
        jmp L_9782
    L_9780:
        ldy $d0
    L_9782:
        sty L_97f0
        lda #$05
        sta L_a2de
        lda #$00
        sta $97f2
        sta L_97f1
        lda L_880d + $1
        pha 
        lda #$01
        sta L_880d + $1
    L_979b:
        jsr L_a2fd
        jsr L_a314
        jsr L_a635
        jsr L_97b1
        lda L_a2de
        bne L_979b
        pla 
        sta L_880d + $1
        rts 


    L_97b1:
        lda L_97f1
        beq L_97ba
        dec L_97f1
        rts 


    L_97ba:
        lda #$03
        sta L_97f1
        ldx $97f2
        lda L_a2de
        cmp #$01
        bne L_97d4
        lda #$02
        sta L_97f1
        lda L_97f6 + $2,x
        jmp L_97d7
    L_97d4:
        lda $97f3,x
    L_97d7:
        cmp #$ff
        bne L_97e6
        lda #$00
        sta $97f2
        dec L_a2de
        jmp L_97ba
    L_97e6:
        ldy L_97f0
        sta $c392,y
        inc $97f2
        rts 



    L_97f0:
         .byte $00

    L_97f1:
        sta L_d0c0 + $5
        cmp ($d2),y

    L_97f6:
         .byte $d3,$ff,$d4
        .byte $d5,$d6,$d7,$d8,$d9,$da,$db,$db,$db,$ff

    L_9803:
        lda #$00
        sta $a466
        jsr L_a441
        jsr L_9775
        lda #$00
        sta L_e006 + $2
        lda L_880d + $1
        pha 
        lda #$01
        sta L_880d + $1
        jsr L_96e1
        pla 
        sta L_880d + $1
        lda $e5
        bne L_983b
        lda $e3
        cmp #$01
        beq L_9834
        inc $ea
        lda #$02
        sta $e4
        rts 


    L_9834:
        inc $eb
        lda #$01
        sta $e4
        rts 


    L_983b:
        lda $e3
        cmp #$01
        bne L_9848
        inc $ea
        lda #$01
        sta $e4
        rts 


    L_9848:
        inc $eb
        lda #$02
        sta $e4
        rts 


    L_984f:
        lda $21
        cmp #$15
        beq L_9860
        bcs L_985d
        jsr L_b7e7
        jmp L_9860
    L_985d:
        jsr $b7cf
    L_9860:
        lda $24
        cmp #$1d
        beq L_986f
        bcs L_986c
        jsr L_b813
        rts 


    L_986c:
        jsr L_b7fb
    L_986f:
        rts 


    L_9870:
        lda $26
        cmp $27
        bne L_988c
        lda $29
        cmp $2a
        bne L_988c
        lda L_9892
        beq L_9885
        dec L_9892
        rts 


    L_9885:
        jsr L_98d5
        jsr $9893
        rts 


    L_988c:
        lda #$0a
        sta L_9892
        rts 


    L_9892:
        ldx.a $00a9,y
        sta L_be6a + $1
        lda $ea
        sta L_be6a
        jsr L_bd79
        lda L_be6a + $5
        sta SCREEN_BUFFER_1 + $373
        sta L_4f73
        lda L_be6a + $6
        sta SCREEN_BUFFER_1 + $374
        sta L_4f73 + $1
        lda $eb
        sta L_be6a
        jsr L_bd79
        lda L_be6a + $5
        sta SCREEN_BUFFER_1 + $376
        sta $4f76
        lda L_be6a + $6
        sta SCREEN_BUFFER_1 + $377
        sta $4f77
        lda #$ee
        sta SCREEN_BUFFER_1 + $375
        sta L_4f75
        rts 


    L_98d5:
        lda $e4
        bne L_98ef
        dec $992c
        lda $992c
        bne L_98e6
        lda #$14
        sta $992c
    L_98e6:
        cmp #$0a
        bcc L_98ef
        lda #$ff
        jmp L_98f1
    L_98ef:
        lda #$ed
    L_98f1:
        sta SCREEN_BUFFER_1 + $392
        sta L_4f90 + $2
        lda $992b
        clc 
        adc #$ef
        sta SCREEN_BUFFER_1 + $390
        sta L_4f90
        lda L_992a
        clc 
        adc #$ef
        sta SCREEN_BUFFER_1 + $391
        sta L_4f90 + $1
        lda $9929
        clc 
        adc #$ef
        sta SCREEN_BUFFER_1 + $393
        sta L_4f90 + $3
        lda L_9928
        clc 
        adc #$ef
        sta SCREEN_BUFFER_1 + $394
        sta L_4f90 + $4
        rts 


    L_9928:
        lda #$3c
    L_992a:
        sta $aac2
    L_992d:
        lda $e5
        bne L_9951
        lda L_999f
        sta L_99a1
        lda L_999f + $1
        sta $99a2
        jsr L_9971
        lda #$00
        sta $e6
        lda #$dc
        sta $e7
        lda #$01
        sta $e8
        lda #$dc
        sta $e9
        rts 


    L_9951:
        lda L_999f + $1
        sta L_99a1
        lda L_999f
        sta $99a2
        jsr L_9971
        lda #$00
        sta $e8
        lda #$dc
        sta $e9
        lda #$01
        sta $e6
        lda #$dc
        sta $e7
        rts 


    L_9971:
        ldy #$02
    L_9973:
        lda L_99a1
        sta L_c37b,y
        iny 
        cpy #$0c
        bne L_9973
        sta L_a461
        ldy #$0d
    L_9983:
        lda $99a2
        sta L_c37b,y
        iny 
        cpy #$17
        bne L_9983
        sta L_a461 + $2
        lda #$01
        sta L_c37b
        lda #$0e
        sta $c37c
        sta $c387
        rts 



    L_999f:
         .byte $d0,$ce

    L_99a1:
        lda L_a9b0

        .byte $00,$85,$2b,$a9,$b0,$85,$2c,$a9,$00,$85,$2d,$a9,$e6,$85,$2e,$a9
        .byte $15,$85,$21,$a9,$1d,$85,$24,$a9,$00,$85,$26,$a9,$02,$85,$29,$60

    L_99c4:
        lda $c6
        pha 
        lda $d0
        pha 
        jsr L_8505
        lda $9cab
        sta L_c31f
        lda L_9cac
        sta $c34d
        lda $9cad
        sta $c336
        lda L_9cae
        sta L_c364
        lda #$02
        sta L_8d13 + $3
        sta L_9290
        lda #$7c
        sta $c392
        lda #$00
        sta $a466
        jsr L_a441
        lda $e6
        sta $e0
        lda $e7
        sta $e1
        lda $c6
        sta L_9caa
        lda #$01
        sta L_9ca4
        lda L_c31d
        cmp #$01
        bne L_9a25
        lda $d0
        sta L_9caa
        lda $e8
        sta $e0
        lda $e9
        sta $e1
        lda #$02
        sta L_9ca4
    L_9a25:
        lda #$99
        sta $c6
        sta $d0
        ldy L_9caa
        lda $9cab
        sta $c3ee,y
        lda L_9cac
        sta $c41c,y
        lda $9cad
        clc 
        adc #$05
        sta L_c3f8 + $d,y
        lda L_9cae
        clc 
        adc #$16
    L_9a49:
        sta $c433,y
        lda $c41c,y
        adc #$00
        sta $c41c,y
    L_9a54:
        jsr L_a2fd
        jsr L_a314
        jsr L_a635
        jsr L_a635
        ldy L_9caa
        lda L_c31f,y
        cmp $c3ee,y
        bne L_9a54
        lda $c336,y
        cmp L_c3f8 + $d,y
        bne L_9a54
        lda $c34d,y
        cmp $c41c,y
        bne L_9a54
        lda L_c364,y
        cmp $c433,y
        bne L_9a54
        lda $d9
        cmp #$02
        beq L_9a8c
        jmp $9b2e
    L_9a8c:
        lda #$9a
    L_9a8e:
        ldy #$16
    L_9a90:
        cpy #$0c
        beq L_9a97
        sta $c392,y
    L_9a97:
        dey 
        bne L_9a90
        lda #$84
        sta $c392
        ldy L_9caa
        lda #$ac
        sta L_9ca8
        lda #$00
        sta $9ca7
        sta L_9ca6
        sta $9ca5
        lda #$28
        sta L_9b2d
    L_9ab7:
        jsr L_a2fd
        jsr L_a314
        jsr L_9c06
        jsr L_9ad3
        jsr L_9c4c
        lda $9ca5
        beq L_9ab7
        lda #$02
        sta $af7c
        jmp L_9b72
    L_9ad3:
        lda L_880d + $1
        bne L_9ae0
        lda L_9b2d
        beq L_9ae1
        dec L_9b2d
    L_9ae0:
        rts 


    L_9ae1:
        lda $e5
        bne L_9b08
        lda L_9ca4
        cmp #$02
        bne L_9b07
        lda #$01
        sta $9ca5
        lda #$01
        sta L_af7d
        lda $c34d
        bne L_9b07
        lda L_c364
        cmp #$ac
        bcs L_9b07
        lda #$00
        sta L_af7d
    L_9b07:
        rts 


    L_9b08:
        lda L_9ca4
        cmp #$01
        bne L_9b2c
        lda #$01
        sta $9ca5
        lda #$02
        sta L_af7d
        lda $c34d
        cmp #$02
        bne L_9b2c
        lda L_c364
        cmp #$2d
        bcc L_9b2c
        lda #$00
        sta L_af7d
    L_9b2c:
        rts 


    L_9b2d:
        dec $9ea9
        ldy #$16
    L_9b32:
        cpy #$0c
        beq L_9b39
        sta $c392,y
    L_9b39:
        dey 
        bne L_9b32
        lda #$84
        sta $c392
        ldy L_9caa
        lda #$a4
        sta L_9ca8
        lda #$00
        sta $9ca7
        sta L_9ca6
        sta $9ca5
        lda #$28
        sta L_9b2d
    L_9b59:
        jsr L_a2fd
        jsr L_a314
        jsr L_9bc0
        jsr L_9c4c
        jsr L_9ad3
        lda $9ca5
        beq L_9b59
        lda #$01
        sta $af7c
    L_9b72:
        lda #$05
        sta L_af7b
        lda #$26
        sta $af7a
        lda #$05
        sta L_af79
        lda #$00
        sta $af78
        lda #$14
        sta $ed
        lda #$00
        sta L_c31d + $1
        sta $d9
        pla 
        sta $d0
        pla 
        sta $c6
        lda #$00
        sta $a632
        sta $a634
        sta L_c526 + $a
        sta L_c531
        lda L_9ca4
        cmp #$01
        bne L_9bb5
        lda #$01
        sta $b524
        sta L_c31d
        rts 


    L_9bb5:
        lda #$01
        sta L_b7ae
        lda #$02
        sta L_c31d
        rts 


    L_9bc0:
        ldy #$00
        lda ($e0),y
        sta $25
        and #$01
        bne L_9bd7
        lda #$a2
        sta L_9ca8
        lda #$01
        sta L_af7d
        jmp L_9bfa
    L_9bd7:
        lda $25
        and #$02
        bne L_9bea
        lda #$a6
        sta L_9ca8
        lda #$02
        sta L_af7d
        jmp L_9bfa
    L_9bea:
        lda $25
        and #$08
        bne L_9bfa
        lda #$a4
        sta L_9ca8
        lda #$00
        sta L_af7d
    L_9bfa:
        lda $25
        and #$10
        bne L_9c05
        lda #$01
        sta $9ca5
    L_9c05:
        rts 


    L_9c06:
        ldy #$00
        lda ($e0),y
        sta $25
        and #$01
        bne L_9c1d
        lda #$ae
        sta L_9ca8
        lda #$01
        sta L_af7d
        jmp L_9c40
    L_9c1d:
        lda $25
        and #$02
        bne L_9c30
        lda #$aa
        sta L_9ca8
        lda #$02
        sta L_af7d
        jmp L_9c40
    L_9c30:
        lda $25
        and #$04
        bne L_9c40
        lda #$ac
        sta L_9ca8
        lda #$00
        sta L_af7d
    L_9c40:
        lda $25
        and #$10
        bne L_9c4b
        lda #$01
        sta $9ca5
    L_9c4b:
        rts 


    L_9c4c:
        lda L_9ca8
        clc 
        adc $9ca7
        ldy L_9caa
        sta $c392,y
        lda L_9ca6
        bne L_9ca0
        lda #$06
        sta L_9ca6
        inc $9ca7
        lda $9ca7
        cmp #$02
        bne L_9c89
        lda #$00
        sta $9ca7
        lda $d9
        cmp #$02
        beq L_9c7f
        dec $c336
        dec $c336
        rts 


    L_9c7f:
        inc $c336
        inc $c336
        inc $c336
        rts 


    L_9c89:
        lda $d9
        cmp #$02
        beq L_9c96
        inc $c336
        inc $c336
        rts 


    L_9c96:
        dec $c336
        dec $c336
    L_9c9c:
        dec $c336
        rts 


    L_9ca0:
        dec L_9ca6
        rts 


    L_9ca4:
        rol $9d
    L_9ca6:
        lda $2f
    L_9ca8:
        sta $d1
    L_9caa:
        lda $d2
    L_9cac:
        sta $30
    L_9cae:
        jsr L_d6a4 + $1
        bne L_9cb4
        rts 


    L_9cb4:
        lda $d7
        bne L_9cc9
        lda $d8
        bne L_9cc6
        dec $d6
        jsr L_ae11
        lda #$01
        sta $d8
        rts 


    L_9cc6:
        dec $d8
        rts 


    L_9cc9:
        lda $d8
        bne L_9cd7
        dec $d6
        jsr L_ae56
        lda #$01
        sta $d8
        rts 


    L_9cd7:
        dec $d8
        rts 


    L_9cda:
        lda #$1e
        sta L_a2de
        jsr L_8505
        jsr L_8521
        lda #$02
        sta L_8d13 + $3
        sta L_9290
        lda #$6c
        sta L_c393
        lda #$74
        sta L_c396 + $8
        lda #$00
        sta $a466
        jsr L_a441
        lda $c6
        pha 
        lda $d0
        pha 
        lda #$99
        sta $c6
        sta $d0
        lda L_a42f
        cmp #$01
        bne L_9d18
        jsr L_9d66
        jmp L_9d2f
    L_9d18:
        cmp #$02
        bne L_9d22
        jsr L_9e75
        jmp L_9d2f
    L_9d22:
        cmp #$03
        bne L_9d2c
        jsr L_9dd2
        jmp L_9d2f
    L_9d2c:
        jsr L_9ee5
    L_9d2f:
        lda #$07
        sta L_af7b
        lda #$3c
        sta $af7a
        lda #$04
        sta L_af79
        lda #$00
        sta L_852f + $1
        sta $af78
        sta L_af7d
        jsr L_8515
        lda #$00
        sta L_c31d + $1
        sta L_a42e
        sta L_a42f
        pla 
        sta $d0
        pla 
        sta $c6
        lda #$00
        sta L_8d13 + $3
        sta L_9290
        rts 


    L_9d66:
        lda #$0c
        sta $cd
        jsr L_a7c1
        lda #$00
        sta L_c31f
        sta $c34d
        lda #$39
        sta $c336
        lda #$37
        sta L_c364
    L_9d7f:
        jsr L_a2fd
        jsr L_a314
        jsr L_b7fb
        jsr L_b7fb
        jsr $b7cf
        jsr $b7cf
        jsr $b7cf
        jsr L_a635
        jsr L_a635
        jsr L_8adc
        jsr L_8adc
        lda L_c32f + $1
        bne L_9d7f
        lda L_c35e
        bne L_9d7f
        lda L_c347
        cmp #$30
        bne L_9d7f
        lda L_c375
        cmp #$50
        bne L_9d7f
        dec L_a2de
        bne L_9d7f
        ldy #$11
        jsr L_9e44
        lda #$01
        sta $af7c
        lda #$1e
        sta $d6
        lda #$00
        sta $d8
        sta $d7
        rts 


    L_9dd2:
        lda #$0e
        sta $cd
        jsr L_a7c1
        lda #$00
        sta L_c31f
        lda #$02
        sta $c34d
        lda #$39
        sta $c336
        lda #$62
        sta L_c364
    L_9ded:
        jsr L_a2fd
        jsr L_a314
        jsr L_b813
        jsr L_b813
        jsr $b7cf
        jsr $b7cf
        jsr $b7cf
        jsr L_a635
        jsr L_a635
        jsr L_9061
        jsr L_9061
        lda L_c324
        bne L_9ded
        lda L_c351 + $1
        cmp #$02
        bne L_9ded
        lda L_c33b
        cmp #$30
        bne L_9ded
        lda L_c368 + $1
        cmp #$7c
        bne L_9ded
        dec L_a2de
        bne L_9ded
        ldy #$05
        jsr L_9e44
        lda #$01
        sta $af7c
        lda #$1e
        sta $d6
        lda #$00
        sta $d8
        lda #$01
        sta $d7
        rts 


    L_9e44:
        lda #$0a
        sta L_a2de
        lda #$00
        sta L_c3a8 + $1,y
        sty $c9
    L_9e50:
        jsr L_a2fd
        jsr L_a314
        ldy $c9
        lda $c336,y
        clc 
        adc #$01
        sta $c336,y
        lda #$08
        sta L_a7b4
        jsr L_a79a
        jsr L_a690
        dec L_a2de
        lda L_a2de
        bne L_9e50
        rts 


    L_9e75:
        lda #$0d
        sta $cd
        jsr L_a7c1
        lda #$02
        sta L_c31f
        lda #$00
        sta $c34d
        lda #$6e
        sta $c336
        lda #$37
        sta L_c364
    L_9e90:
        jsr L_a2fd
        jsr L_a314
        jsr L_b7fb
        jsr L_b7fb
        jsr L_b7e7
        jsr L_b7e7
        jsr L_b7e7
        jsr L_8adc
        jsr L_8adc
        jsr L_a635
        jsr L_a635
        lda L_c32f + $1
        cmp #$02
        bne L_9e90
        lda L_c35e
        bne L_9e90
        lda L_c347
        cmp #$88
        bne L_9e90
        lda L_c375
        cmp #$50
        bne L_9e90
        dec L_a2de
        bne L_9e90
        ldy #$11
        jsr L_9f59
        lda #$02
        sta $af7c
        lda #$1e
        sta $d6
        lda #$00
        sta $d8
        sta $d7
        rts 


    L_9ee5:
        lda #$0f
        sta $cd
        jsr L_a7c1
        lda #$02
        sta L_c31f
        lda #$02
        sta $c34d
        lda #$6e
        sta $c336
        lda #$62
        sta L_c364
    L_9f00:
        jsr L_a2fd
        jsr L_a314
        jsr L_b813
        jsr L_b813
        jsr L_b7e7
        jsr L_b7e7
        jsr L_b7e7
        jsr L_a635
        jsr L_a635
        jsr L_9061
        jsr L_9061
        lda L_c324
        cmp #$02
        bne L_9f00
        lda L_c351 + $1
        cmp #$02
        bne L_9f00
        lda L_c33b
        cmp #$88
        bne L_9f00
        lda L_c368 + $1
        cmp #$7c
        bne L_9f00
    L_9f3d:
        dec L_a2de
        bne L_9f00
        ldy #$05
        jsr L_9f59
        lda #$02
        sta $af7c
        lda #$1e
        sta $d6
        lda #$00
        sta $d8
        lda #$01
        sta $d7
        rts 


    L_9f59:
        lda #$0a
        sta L_a2de
        lda #$00
        sta L_c3a8 + $1,y
        sty $c9
    L_9f65:
        jsr L_a2fd
        jsr L_a314
        ldy $c9
        lda $c336,y
        sec 
        sbc #$01
        sta $c336,y
        lda #$04
        sta L_a7b4
        jsr L_a79a
        jsr L_a690
        dec L_a2de
        lda L_a2de
        bne L_9f65
        rts 


    L_9f8a:
        lda $d5
        bne L_9f8f
        rts 


    L_9f8f:
        dec $d5
        lda $d5
        bne L_9fc1
        lda #$01
        sta $c320
        sta $c32b
        lda #$58
        sta $c337
        sta $c342
        sta $c365
        lda #$00
        sta L_c34e
        lda #$02
        sta L_c359
        lda #$6f
        sta L_c36f + $1
        lda #$6c
        sta L_c393
        lda #$74
        sta L_c396 + $8
    L_9fc1:
        rts 


    L_9fc2:
        lda.a $00a2
    L_9fc5:
        lda L_c44a,x
        cmp L_9fd9 + $1
        beq L_9fd3
        inx 
        cpx #$0e
        bne L_9fc5
        rts 


    L_9fd3:
        lda #$01
        sta L_9fd9
        rts 



    L_9fd9:
         .byte $d0,$13

    L_9fdb:
        lda L_9fc2
        bne L_9fe1
        rts 


    L_9fe1:
        jsr L_9fe7
        jmp L_a036
    L_9fe7:
        lda $a632
        bne L_9ff1
        lda L_c526 + $a
        beq L_9ff2
    L_9ff1:
        rts 


    L_9ff2:
        ldy $c6
        lda L_a461
        sta L_c37b,y
        lda #$02
        sta L_a125
        lda #$50
        sta L_a122
        sta $a123
        lda #$ff
        sta $a124
    L_a00c:
        lda L_a125
        sta L_9fd9 + $1
        lda #$00
        sta L_9fd9
        jsr $9fc3
        lda L_9fd9
        beq L_a022
        jsr L_a085
    L_a022:
        inc L_a125
        lda L_a125
        cmp #$0c
        bne L_a00c
        lda $a124
        cmp #$ff
        beq L_a035
        sta $c6
    L_a035:
        rts 


    L_a036:
        lda $a634
        bne L_a040
        lda L_c531
        beq L_a041
    L_a040:
        rts 


    L_a041:
        ldy $d0
        lda L_a461 + $2
        sta L_c37b,y
        lda #$0d
        sta L_a125
        lda #$50
        sta L_a122
        sta $a123
        lda #$ff
        sta $a124
    L_a05b:
        lda L_a125
        sta L_9fd9 + $1
        lda #$00
        sta L_9fd9
        jsr $9fc3
        lda L_9fd9
        beq L_a071
        jsr L_a085
    L_a071:
        inc L_a125
        lda L_a125
        cmp #$17
        bne L_a05b
        lda $a124
        cmp #$ff
        beq L_a084
        sta $d0
    L_a084:
        rts 


    L_a085:
        ldy L_a125
        lda L_c31f,y
        sec 
        sbc L_c31f
        sta $d1
        lda $c336,y
        sec 
        sbc $c336
        sta $d2
        lda $d1
        sbc #$00
        sta $d1
        bpl L_a0b6
        sta $2f
        jsr L_a125 + $2
        lda $2f
        sta $d1
        lda $d2
        sta $30
        jsr L_a131
        lda $30
    L_a0b4:
        sta $d2
    L_a0b6:
        lda $c34d
        sec 
        sbc $c34d,y
        sta $d4
    L_a0bf:
        lda L_c364
        clc 
        adc #$1a
        bcc L_a0c9
        inc $d4
    L_a0c9:
        sec 
        sbc L_c364,y
        sta $d3
        lda $d4
        sbc #$00
        sta $d4
        bpl L_a0eb
        sta $2f
        jsr L_a125 + $2
        lda $2f
        sta $d4
        lda $d3
        sta $30
        jsr L_a131
        lda $30
        sta $d3
    L_a0eb:
        lda $d3
    L_a0ed:
        clc 
        adc $d2
        sta $d2
        lda $d1
        adc #$00
        sta $d1
        lda $d4
        clc 
        adc $d1
        sta $d1
        lda $d1
        cmp L_a122
        beq L_a109
        bcc L_a111
        rts 


    L_a109:
        lda $d2
        cmp $a123
        bcc L_a111
        rts 


    L_a111:
        lda L_a125
        sta $a124
        lda $d1
        sta L_a122
        lda $d2
        sta $a123
        rts 


    L_a122:
        jsr $a13c

    L_a125:
         .byte $ad,$26,$e6,$2f
        .byte $a9,$00,$38,$e5,$2f,$85,$2f,$60

    L_a131:
        lda #$00
        sec 
        sbc $30
        sta $30
        rts 


    L_a139:
        lda #$00
        sta $a466
        jsr L_8521
        jsr L_a441
        jsr L_8505
        lda #$02
        sta L_8d13 + $3
        sta L_9290
        lda #$6c
        sta L_c393
        lda #$74
        sta L_c394
        ldy L_a42e
        lda $a2df,y
        sta $cd
        jsr L_a7c1
        lda $c6
        pha 
        lda $d0
        pha 
        lda #$63
        sta $c6
        sta $d0
        lda #$50
        sta L_a2de
        lda #$ff
        sta $a642
        ldy L_a42e
        lda L_a2b6,y
        sta L_c3ef
        lda L_a2bb,y
        sta L_c3f8 + $e
        lda L_a2c0,y
        sta L_c41d
        lda L_a2c0 + $5,y
        sta L_c434
        lda #$00
        sta L_c3a8 + $2
        lda L_a2ca,y
        sta L_c3f8 + $2
        lda L_a2cf,y
        sta L_c40f + $2
        lda L_a2d4,y
        sta L_c428
        lda L_a2d4 + $5,y
        sta L_c438 + $7
        lda #$00
        sta $c3b5
    L_a1b7:
        jsr L_a2fd
        jsr L_a314
        ldy #$01
        jsr L_a641
        ldy #$01
        jsr L_a641
        dec L_a2de
        bne L_a1b7
        ldy L_a42e
        lda L_a2e4,y
        sta L_c31f
        lda L_a2e9,y
        sta $c336
        lda L_a2e9 + $5,y
        sta $c34d
        lda L_a2e9 + $a,y
        sta L_c364
        lda #$0c
        sta $a642
        lda L_a2f8,y
        ldy #$16
    L_a1f1:
        cpy #$0c
        beq L_a1f8
        sta $c392,y
    L_a1f8:
        dey 
        bne L_a1f1
        jsr L_b18a
        jsr L_b138
        lda L_a42e
        cmp #$03
        bcs L_a20e
        jsr L_a259
        jmp L_a211
    L_a20e:
        jsr L_a283
    L_a211:
        lda #$00
        sta $af7c
        ldy L_a42e
        lda L_a2b1,y
        sta L_af7d
        lda #$07
        sta L_af7b
        lda #$40
        sta $af7a
        lda #$03
        sta L_af79
        lda #$00
        sta L_852f + $1
        sta $af78
        lda #$00
        sta L_c31d + $1
        sta L_a42e
        pla 
        sta $d0
        pla 
        sta $c6
        lda #$1e
        sta $d5
        lda #$1e
        sta $8d1c
        sta L_9296
        lda #$00
        sta $af7c
        jsr L_8515
        rts 


    L_a259:
        lda #$0d
        sta L_a2de
        lda #$00
        sta L_c3a8 + $2
    L_a263:
        jsr L_a2fd
        jsr L_a314
        inc $c365
        inc $c365
        ldy #$01
        sty L_a7b4
        jsr L_a79a
        jsr L_a690
        dec L_a2de
        lda L_a2de
        bne L_a263
        rts 


    L_a283:
        lda #$0c
        sta L_a2de
        lda #$00
        sta $c3b5
    L_a28d:
        jsr L_a2fd
        jsr L_a314
        dec L_c36f + $1
        ldy #$0c
        lda #$02
        sta L_a7b4
        jsr L_a79a
        jsr L_a690
        dec L_a2de
        lda L_a2de
        bne L_a28d
        lda #$98
        sta L_c396 + $8
        rts 



    L_a2b1:
         .byte $00,$02,$02
        .byte $01,$01

    L_a2b6:
        .byte $00
        .byte $01,$01,$01,$01

    L_a2bb:
        .byte $00
        .byte $16,$a0,$58,$58

    L_a2c0:
        .byte $00,$00,$00,$00,$00,$00
        .byte $50,$50,$58,$58

    L_a2ca:
        .byte $00
        .byte $01,$01,$01,$01

    L_a2cf:
        .byte $00,$54,$54
        .byte $16,$a0

    L_a2d4:
        .byte $00,$02,$02,$02,$02,$00,$6f,$6f
        .byte $71,$71

    L_a2de:
        ldx $0200,y

        .byte $02,$09,$09

    L_a2e4:
        .byte $00
        .byte $01,$01,$01,$01

    L_a2e9:
        .byte $00,$12,$9c,$12,$9c,$00,$00,$00,$02,$02,$00,$52,$52
        .byte $4a,$4a

    L_a2f8:
        .byte $00,$9c,$9c
        .byte $98,$98

    L_a2fd:
        lda #$a0
        ldx #$a5
        jsr L_bd07
        jsr L_bba7
        lda $26
        sta $27
        lda $29
        sta $2a
        lda $23
        sta $28
        rts 


    L_a314:
        lda #$6e
        ldx #$73
    L_a318:
        jsr L_bd07
        jsr L_b18a
        jsr L_b10d
        jsr $b0a9
        jsr L_b138
        rts 


    L_a328:
        lda $e2
        beq L_a32f
        sta $e3
        rts 


    L_a32f:
        jsr L_9fdb
        lda $c34d
        bne L_a394
        lda L_c364
        cmp #$33
        bcs L_a394
        lda L_c31f
        beq L_a34e
        cmp #$01
        bne L_a368
        lda $c336
        cmp #$28
        bcs L_a368
    L_a34e:
        lda L_c31d + $1
        cmp #$01
        bne L_a368
        lda L_c31d
        cmp #$01
        beq L_a362
        lda #$01
        sta L_a42e
        rts 


    L_a362:
        lda #$01
        sta L_a42f
        rts 


    L_a368:
        lda L_c31f
        cmp #$02
        beq L_a37a
        cmp #$01
        bne L_a394
        lda $c336
        cmp #$7e
        bcc L_a394
    L_a37a:
        lda L_c31d + $1
        cmp #$01
        bne L_a394
        lda L_c31d
        cmp #$01
        beq L_a38e
        lda #$02
        sta L_a42e
        rts 


    L_a38e:
        lda #$02
        sta L_a42f
        rts 


    L_a394:
        lda $c34d
        cmp #$02
        bne L_a3fb
        lda L_c364
        cmp #$6b
        bcc L_a3fb
        lda L_c31f
        beq L_a3b2
        cmp #$01
        bne L_a3cf
        lda $c336
        cmp #$28
        bcs L_a3cf
    L_a3b2:
        lda L_c31d + $1
        cmp #$03
        bne L_a3fb
        lda L_c31d
        cmp #$02
        beq L_a3c6
        lda #$03
        sta L_a42e
        rts 


    L_a3c6:
        lda #$03
        sta L_a42f
        rts 


        jmp L_a3c6
    L_a3cf:
        lda L_c31f
        cmp #$02
        beq L_a3e1
        cmp #$01
        bne L_a3fb
        lda $c336
        cmp #$7e
        bcc L_a3fb
    L_a3e1:
        lda L_c31d + $1
        cmp #$03
        bne L_a3fb
        lda L_c31d
        cmp #$02
        beq L_a3f5
        lda #$04
        sta L_a42e
        rts 


    L_a3f5:
        lda #$04
        sta L_a42f
        rts 


    L_a3fb:
        lda L_c31f
        bne L_a413
        lda $c336
        cmp #$37
        bcs L_a413
        lda L_c31d + $1
        cmp #$04
        bne L_a413
        lda #$01
        sta $d9
        rts 


    L_a413:
        lda L_c31f
        cmp #$02
        bne L_a42d
        lda $c336
        cmp #$70
        bcc L_a42d
        lda L_c31d + $1
        cmp #$02
        bne L_a42d
        lda #$02
        sta $d9
        rts 


    L_a42d:
        rts 



    L_a42e:
         .byte $c3

    L_a42f:
        sta L_65a9 + $4
        ldy $f0

        .byte $04,$ce,$65,$a4,$60,$a9,$02,$8d,$65,$a4,$ee,$66,$a4

    L_a441:
        ldx $a466
        cpx #$02
        bne L_a450
        lda #$00
        sta $a466
        jmp L_a441
    L_a450:
        lda L_a461,x
        ldy $c6
        sta L_c37b,y
        lda L_a461 + $2,x
        ldy $d0
        sta L_c37b,y
        rts 



    L_a461:
         .byte $01,$0c,$03,$0c

    L_a465:
        sta $ad74
        bmi L_a42f
        beq L_a47a
        dec L_c526 + $a
        lda L_c526 + $a
        bne L_a479
        lda #$00
        sta $a632
    L_a479:
        rts 


    L_a47a:
        lda $a632
        beq L_a4d6
        dec $a632
        lda $a632
        bne L_a492
        lda #$10
        sta L_c526 + $a
        lda #$01
        sta $a632
        rts 


    L_a492:
        ldy $c6
        lda $a632
        cmp #$0a
        beq L_a4a3
        cmp #$02
        beq L_a4a3
        cmp #$04
        bne L_a4a6
    L_a4a3:
        dec L_a547
    L_a4a6:
        ldx #$01
        lda L_a547
        sta L_a630
        lda $a631
        and #$01
        beq L_a4b8
        jsr L_a574
    L_a4b8:
        lda $a631
        and #$02
        beq L_a4c2
        jsr L_a547 + $2
    L_a4c2:
        lda $a631
        and #$04
        beq L_a4cc
        jsr L_a5b7
    L_a4cc:
        lda $a631
        and #$08
        beq L_a4d6
        jsr L_a603
    L_a4d6:
        rts 


    L_a4d7:
        lda L_c531
        beq L_a4ea
        dec L_c531
        lda L_c531
        bne L_a4e9
        lda #$00
        sta $a634
    L_a4e9:
        rts 


    L_a4ea:
        lda $a634
        beq L_a546
        dec $a634
        lda $a634
        bne L_a502
        lda #$10
        sta L_c531
        lda #$01
        sta $a634
        rts 


    L_a502:
        ldy $d0
        lda $a634
        cmp #$0a
        beq L_a513
        cmp #$02
        beq L_a513
        cmp #$04
        bne L_a516
    L_a513:
        dec L_a547 + $1
    L_a516:
        ldx #$02
        lda L_a547 + $1
        sta L_a630
        lda L_a633
        and #$01
        beq L_a528
        jsr L_a574
    L_a528:
        lda L_a633
        and #$02
        beq L_a532
        jsr L_a547 + $2
    L_a532:
        lda L_a633
        and #$04
        beq L_a53c
        jsr L_a5b7
    L_a53c:
        lda L_a633
        and #$08
        beq L_a546
        jsr L_a603
    L_a546:
        rts 



    L_a547:
         .byte $78,$c5,$b9,$64,$c3
        .byte $38,$ed,$30,$a6,$99,$64,$c3,$b9,$4d,$c3,$e9,$00,$99,$4d,$c3,$d0
        .byte $16,$b9,$64,$c3,$c9,$4d,$b0,$0f,$e0,$01,$d0,$06,$a9,$01,$8d,$32
        .byte $a6,$60

    L_a56e:
        lda #$01
        sta $a634
    L_a573:
        rts 


    L_a574:
        lda L_c364,y
        clc 
        adc L_a630
        sta L_c364,y
        lda $c34d,y
        adc #$00
        sta $c34d,y
        cmp #$02
        bne L_a5a0
        lda L_c364,y
        cmp #$82
        bcc L_a5a1
    L_a591:
        cpx #$01
        bne L_a59b
        lda #$01
        sta $a632
        rts 


    L_a59b:
        lda #$01
        sta $a634
    L_a5a0:
        rts 


    L_a5a1:
        lda $c336,y
        cmp #$2d
        bcc L_a5b6
        cmp #$8c
        bcs L_a5b6
        lda L_c364,y
        cmp #$70
        bcc L_a5b6
        jmp L_a591
    L_a5b6:
        rts 


    L_a5b7:
        lda $c336,y
        sec 
        sbc L_a630
        sta $c336,y
        lda L_c31f,y
        sbc #$00
        sta L_c31f,y
        bne L_a5e2
        lda $c336,y
        cmp #$32
        bcs L_a5e1
    L_a5d2:
        cpx #$01
        bne L_a5dc
        lda #$01
        sta $a632
        rts 


    L_a5dc:
        lda #$01
        sta $a634
    L_a5e1:
        rts 


    L_a5e2:
        cmp #$01
        bne L_a602
        lda $c34d,y
        cmp #$02
        bne L_a602
        lda $c336,y
        cmp #$21
        bcc L_a602
        cmp #$8c
        bcs L_a602
        lda L_c364,y
        cmp #$70
        bcc L_a602
        jmp L_a5d2
    L_a602:
        rts 


    L_a603:
        lda $c336,y
        clc 
        adc L_a630
        sta $c336,y
        lda L_c31f,y
        adc #$00
        sta L_c31f,y
        cmp #$02
        bne L_a5e2
        lda $c336,y
        cmp #$72
        bcc L_a62f
        cpx #$01
        bne L_a62a
        lda #$01
        sta $a632
        rts 


    L_a62a:
        lda #$01
        sta $a634
    L_a62f:
        rts 


    L_a630:
        sbc L_be5a
    L_a633:
        sta $2f
    L_a635:
        lda $e4
        beq L_a63a
        rts 


    L_a63a:
        lda #$00
        sta L_a793 + $1
        ldy #$02
    L_a641:
        cpy #$0c
        beq L_a68a
        lda L_880d + $1
        bne L_a662
        lda $e5
        bne L_a658
        cpy $c6
        beq L_a68a
        jsr L_a736
        jmp L_a66a
    L_a658:
        cpy $d0
        beq L_a68a
        jsr L_a736
        jmp L_a66a
    L_a662:
        cpy $c6
        beq L_a68a
        cpy $d0
        beq L_a68a
    L_a66a:
        lda #$00
        sta $a7b5
        lda #$00
        sta L_a7b4
        lda #$00
        sta L_a793
        jsr L_a6df
        jsr L_a736
        lda L_a7b4
        beq L_a687
        sta L_c3d6 + $1,y
    L_a687:
        jsr L_a690
    L_a68a:
        iny 
        cpy #$17
        bne L_a641
        rts 


    L_a690:
        lda L_a7b4
        bne L_a6a0
        lda L_c3d6 + $1,y
        tax 
        lda L_b087 + $1,x
        sta $c392,y
        rts 


    L_a6a0:
        cpy L_8533
        bne L_a6b6
        cpy #$06
        beq L_a6b1
        lda #$0b
        sta L_a7b4
        jmp L_a6b6
    L_a6b1:
        lda #$0c
        sta L_a7b4
    L_a6b6:
        lda L_a7b4
        asl 
        tax 
        lda L_b024,x
        sta $c7
        lda L_b024 + $1,x
        sta $c8
    L_a6c5:
        sty $c9
        lda L_c3a8 + $1,y
        tay 
        lda ($c7),y
        ldy $c9
        cmp #$ff
        bne L_a6db
        lda #$00
        sta L_c3a8 + $1,y
        jmp L_a6c5
    L_a6db:
        sta $c392,y
        rts 


    L_a6df:
        lda $c3ee,y
        cmp L_c31f,y
        beq L_a723
        bcc L_a706
    L_a6e9:
        lda $c336,y
        clc 
        adc #$01
        sta $c336,y
        lda L_c31f,y
        adc #$00
        sta L_c31f,y
        jsr L_a795
        lda L_a7b4
        ora #$08
        sta L_a7b4
        rts 


    L_a706:
        lda $c336,y
        sec 
        sbc #$01
        sta $c336,y
        lda L_c31f,y
        sbc #$00
        sta L_c31f,y
        jsr L_a795
        lda L_a7b4
        ora #$04
        sta L_a7b4
        rts 


    L_a723:
        lda L_c3f8 + $d,y
        cmp $c336,y
        beq L_a730
        bcs L_a6e9
        jmp L_a706
    L_a730:
        lda #$01
        sta L_a793
        rts 


    L_a736:
        lda $c41c,y
        cmp $c34d,y
        beq L_a77d
        bcc L_a760
    L_a740:
        lda L_c364,y
        clc 
        adc #$01
        sta L_c364,y
        bcc L_a754
        lda $c34d,y
        clc 
        adc #$01
        sta $c34d,y
    L_a754:
        jsr L_a795
        lda L_a7b4
        ora #$01
        sta L_a7b4
        rts 


    L_a760:
        lda L_c364,y
        sec 
        sbc #$01
        sta L_c364,y
        lda $c34d,y
        sbc #$00
        sta $c34d,y
        jsr L_a795
        lda L_a7b4
        ora #$02
        sta L_a7b4
        rts 


    L_a77d:
        lda $c433,y
        cmp L_c364,y
        beq L_a78a
        bcs L_a740
        jmp L_a760
    L_a78a:
        lda L_a793
        beq L_a792
        inc L_a793 + $1
    L_a792:
        rts 



    L_a793:
         .byte $7f,$80

    L_a795:
        lda $a7b5
        bne L_a7b3
    L_a79a:
        lda L_c3c0,y
        sec 
        sbc #$01
        sta L_c3c0,y
        bne L_a7b3
        lda #$03
        sta L_c3c0,y
        lda L_c3a8 + $1,y
        clc 
        adc #$01
        sta L_c3a8 + $1,y
    L_a7b3:
        rts 


    L_a7b4:
        adc $a57d,x
        cpx $f0
        ora ($60,x)
        lda $af7a
        bne L_a7c1
        rts 


    L_a7c1:
        ldy $cd
        lda L_c5bd,y
        sta L_c3f0
        lda L_c5ca + $3,y
        sta $c3f1
        lda L_c5dd,y
        sta L_c3f2
        lda L_c5ea + $3,y
        sta $c3f3
        lda L_c5f9 + $4,y
        sta L_c3f4
        lda L_c607 + $6,y
        sta $c3f5
        lda $c61d,y
        sta L_c3f6
        lda L_c62d,y
        sta $c3f7
        lda L_c63d,y
        sta L_c3f8
        lda $c64d,y
        sta L_c3f8 + $1
        lda L_c6fd,y
        sta L_c3f8 + $f
        lda L_c70c + $1,y
        sta L_c3f8 + $10
        lda L_c71d,y
        sta L_c3f8 + $11
        lda L_c72d,y
        sta L_c3f8 + $12
        lda L_c738 + $5,y
        sta L_c3f8 + $13
        lda $c74d,y
        sta L_c3f8 + $14
        lda L_c75d,y
        sta L_c40d
        lda L_c76d,y
        sta $c40e
        lda L_c77d,y
        sta L_c40f
        lda L_c78d,y
        sta L_c40f + $1
        lda L_c83d,y
        sta $c41e
        lda L_c84d,y
        sta L_c41f
        lda L_c85b + $2,y
        sta $c420
        lda L_c86d,y
        sta L_c421
        lda L_c87d,y
        sta L_c422
        lda L_c88d,y
        sta $c423
        lda L_c89d,y
        sta L_c424
        lda L_c8ad,y
        sta L_c424 + $1
        lda L_c8bd,y
        sta L_c426
        lda L_c8bd + $10,y
        sta $c427
        lda L_c97d,y
        sta $c435
        lda L_c98d,y
        sta L_c436
        lda L_c99d,y
        sta $c437
        lda $c9ad,y
        sta L_c438
        lda L_c9bc + $1,y
        sta L_c438 + $1
        lda L_c9cd,y
        sta L_c438 + $2
        lda L_c9dd,y
        sta L_c438 + $3
        lda L_c9eb + $2,y
        sta L_c438 + $4
        lda L_c9f9 + $4,y
        sta L_c438 + $5
        lda $ca0d,y
        sta L_c438 + $6
        lda L_c650 + $d,y
        sta L_c3f8 + $3
        lda L_c665 + $8,y
        sta L_c3f8 + $4
        lda L_c67b + $2,y
        sta L_c3f8 + $5
        lda L_c68d,y
        sta L_c3f8 + $6
        lda L_c69d,y
        sta L_c3f8 + $7
        lda L_c6ad,y
        sta L_c3f8 + $8
        lda L_c6b9 + $4,y
        sta L_c3f8 + $9
        lda L_c6cd,y
        sta L_c3f8 + $a
        lda L_c6dd,y
        sta L_c3f8 + $b
        lda L_c6ed,y
        sta L_c3f8 + $c
        lda L_c79d,y
        sta L_c40f + $3
        lda L_c7ad,y
        sta L_c40f + $4
        lda L_c7bb + $2,y
        sta L_c40f + $5
        lda $c7cd,y
        sta L_c40f + $6
        lda L_c7dd,y
        sta L_c40f + $7
        lda L_c7ed,y
        sta L_c40f + $8
        lda L_c7fd,y
        sta L_c40f + $9
        lda L_c80c + $1,y
        sta L_c419
        lda L_c81d,y
        sta $c41a
        lda L_c82d,y
        sta L_c41b
        lda L_c8d4 + $9,y
        sta $c429
        lda L_c8ed,y
        sta L_c42a
        lda L_c8fd,y
        sta $c42b
        lda L_c90d,y
        sta L_c42c
        lda L_c91a + $3,y
        sta $c42d
        lda L_c92d,y
        sta L_c42e
        lda L_c93d,y
        sta $c42f
        lda L_c94b + $2,y
        sta L_c430
        lda L_c95d,y
        sta $c431
        lda L_c96d,y
        sta L_c432
        lda L_ca1d,y
        sta L_c438 + $8
        lda L_ca2d,y
        sta L_c438 + $9
        lda L_ca39 + $4,y
        sta L_c438 + $a
        lda L_ca4c + $1,y
        sta L_c438 + $b
        lda $ca5d,y
        sta L_c438 + $c
        lda L_ca6d,y
        sta L_c438 + $d
        lda L_ca7d,y
        sta L_c438 + $e
        lda L_ca8d,y
        sta L_c438 + $f
    L_a997:
        lda L_ca9d,y
        sta L_c448
        lda L_caa9 + $4,y
        sta L_c448 + $1
        rts 


    L_a9a4:
        lda $af7a
        beq L_a9b6
    L_a9a9:
        jsr L_a9b7
    L_a9ac:
        lda $cd
        cmp $ce
    L_a9b0:
        beq L_a9b6
        lda $cd
        sta $ce
    L_a9b6:
        rts 


    L_a9b7:
        lda #$99
        sta $cd
        lda $c34d
        bne L_a9cf
        lda L_c364
        cmp #$ac
        bcs L_a9dd
        ldx #$00
        ldy #$06
        jsr L_aa1a
        rts 


    L_a9cf:
        lda $c34d
        cmp #$01
        bne L_aa03
        lda L_c364
        cmp #$0d
    L_a9db:
        bcs L_a9e5
    L_a9dd:
        ldx #$01
        ldy #$07
        jsr L_aa1a
        rts 


    L_a9e5:
        lda L_c364
        cmp #$6c
        bcs L_a9f4
        ldx #$02
        ldy #$08
        jsr L_aa1a
        rts 


    L_a9f4:
        lda L_c364
        cmp #$cc
        bcs L_aa0a
        ldx #$03
        ldy #$09
        jsr L_aa1a
        rts 


    L_aa03:
        lda L_c364
        cmp #$2d
        bcs L_aa12
    L_aa0a:
        ldx #$04
        ldy #$0a
        jsr L_aa1a
        rts 


    L_aa12:
        ldx #$05
        ldy #$0b
        jsr L_aa1a
        rts 


    L_aa1a:
        lda L_c31f
        bne L_aa22
    L_aa1f:
        stx $cd
        rts 


    L_aa22:
        lda $c336
        cmp #$58
        bcc L_aa1f
        sty $cd
        rts 


    L_aa2c:
        lda $ed
        beq L_aa31
        rts 


    L_aa31:
        lda $cf
        beq L_aa38
        dec $cf
        rts 


    L_aa38:
        lda $b7b3
        bne L_aa3e
        rts 


    L_aa3e:
        inc $fe
        ldy $d0
        lda L_c31f,y
        sta $2f
        lda $c336,y
        sec 
        sbc #$04
        bcs L_aa51
        dec $2f
    L_aa51:
        sec 
        sbc $c336
        sta $30
        bcs L_aa5b
        dec $2f
    L_aa5b:
        lda $2f
        sec 
        sbc L_c31f
        sta $2f
        lda L_c364
        clc 
        adc #$1a
        sec 
        sbc L_c364,y
        cmp #$06
    L_aa6f:
        bcc L_aa72
        rts 


    L_aa72:
        ldx #$01
        lda $2f
        bne L_aa81
        lda $30
        cmp #$09
        bcs L_aa81
        jmp L_ab2b
    L_aa81:
        cmp #$ff
        bne L_aa8e
        lda $30
        cmp #$fb
        bcc L_aa8e
        jmp L_ab2b
    L_aa8e:
        rts 


    L_aa8f:
        lda $ed
        beq L_aa96
        dec $ed
        rts 


    L_aa96:
        lda $ca
        beq L_aa9d
        dec $ca
        rts 


    L_aa9d:
        lda $b7cc
        bne L_aaa3
        rts 


    L_aaa3:
        ldy $c6
        lda L_c31f,y
        sta $2f
        lda $c336,y
        sec 
        sbc #$04
        bcs L_aab4
        dec $2f
    L_aab4:
        sec 
        sbc $c336
        sta $30
        bcs L_aabe
        dec $2f
    L_aabe:
        lda $2f
        sec 
        sbc L_c31f
        sta $2f
        lda L_c364
        clc 
        adc #$1a
        sec 
        sbc L_c364,y
        cmp #$06
        bcc L_aad5
        rts 


    L_aad5:
        ldx #$00
        lda $2f
        bne L_aae4
        lda $30
        cmp #$09
        bcs L_aae4
        jmp L_aaf2
    L_aae4:
        cmp #$ff
        bne L_aaf1
        lda $30
        cmp #$fb
        bcc L_aaf1
        jmp L_aaf2
    L_aaf1:
        rts 


    L_aaf2:
        lda $e5
        bne L_aaf9
        jsr L_8505
    L_aaf9:
        lda #$00
        sta $e4
        sta L_c31d + $1
        lda #$01
        sta L_c31d
        lda #$03
        sta $ca
        ldy $b7c8
        lda $a632
        beq L_ab1e
        lda #$04
        sta L_af7b
        lda #$1f
        sta $af7a
        jmp L_ab61
    L_ab1e:
        lda #$03
        sta L_af7b
        lda #$0f
        sta $af7a
        jmp L_ab61
    L_ab2b:
        lda $e5
        beq L_ab32
        jsr L_8505
    L_ab32:
        lda #$00
        sta L_c31d + $1
        sta $e4
        lda #$02
        sta L_c31d
        lda #$03
        sta $cf
        ldy L_b7c9
        lda $a634
        bne L_ab57
        lda #$03
        sta L_af7b
        lda #$0f
        sta $af7a
        jmp L_ab61
    L_ab57:
        lda #$04
        sta L_af7b
        lda #$1f
        sta $af7a
    L_ab61:
        lda L_ab79,y
        sta $af7c
        lda $ab84,y
        sta L_af7d
        lda #$00
        sta $af78
        sta L_af79
        jsr L_8515
        rts 



    L_ab79:
         .byte $00,$00,$00,$00,$02,$02,$02,$00
        .byte $01,$01,$01,$00,$02,$01,$00,$00,$02,$01,$00,$00,$02,$01,$ad,$79
        .byte $af,$d0,$06,$a9,$7c,$8d,$92,$c3,$60,$38,$e9,$01,$0a,$a8,$b9,$de
        .byte $ab,$85,$cb,$b9,$df,$ab

    L_aba7:
        sta $cc
        ldy $af78
        lda ($cb),y
        cmp #$7c
        bne L_abcd
        sty $c9
        lda L_852f + $1
        bne L_abc6
        lda #$00
        sta L_e006
        lda #$01
        sta L_e006 + $1
        jsr L_e000
    L_abc6:
        ldy $c9
        lda #$7c
        jmp L_abd7
    L_abcd:
        cmp #$ff
        bne L_abd7
        lda #$00
        sta L_af79
        rts 


    L_abd7:
        sta $c392
        inc $af78
        rts 



    L_abde:
         .byte $ea,$ab
        .byte $16,$ac,$23,$ac,$60,$ac,$91,$ac,$a8,$ac,$7c,$7c,$7d,$7d,$7e,$7e
        .byte $7f,$7f,$80,$80,$81,$81,$82,$82,$82,$82,$81,$81,$81,$80,$80,$80
        .byte $7f,$7f,$7f,$7e,$7e,$7d,$7d,$7c,$7c,$7d,$7d,$7d,$7e,$7e,$7e,$7e
        .byte $7e,$7d,$7d,$7d,$7c,$ff,$7c,$7d,$7d,$7d,$7d,$7d,$7d,$7d,$7d,$7d
        .byte $7d,$7c,$ff,$7c,$7d,$7e,$7f,$80,$81,$82,$83,$84,$85,$86,$87,$88
        .byte $89,$8a,$8b,$8c,$8d,$8e,$8f,$8e,$8d,$8c,$8b,$8a,$89,$88,$87,$86
        .byte $85,$84,$83,$82,$81,$80,$7f,$7e,$7d,$7c,$7d,$7e,$7f,$80,$81,$82
        .byte $83,$83,$82,$81,$80,$7f,$7e,$7d,$7c,$7d,$7d,$7e,$7d,$7d,$7c

    L_ac5f:
        .byte $ff,$7c
        .byte $7d,$7e,$7f,$80,$81,$82,$83,$84,$84,$84,$85,$85,$85,$85,$86,$86
        .byte $85,$85,$85,$85,$84,$84,$84,$83,$83,$82,$82,$81,$80,$7f,$7e,$7d
        .byte $7c,$7d,$7e,$7e,$7e,$7f,$7f,$7f,$7f,$7f,$7e,$7e,$7e,$7d,$7c,$ff
        .byte $84,$84,$83,$83,$82,$82,$81,$81,$80,$80,$7f,$7f,$7e,$7e,$7d,$7d
        .byte $7c,$7c,$7d,$7d,$7d,$7c,$ff,$7c,$7e,$80,$82

    L_acac:
        sty $86
        dey 
        txa 
        sty $8f8e

        .byte $8f,$8e,$8d,$8c,$8b,$8a,$89,$88,$87,$86,$85,$84,$83,$82,$81,$80
        .byte $7f,$7e,$7d,$7c,$7d,$7e,$7f,$80,$81,$82,$82,$82,$80,$7f,$7e,$7d
        .byte $7c,$7d,$7d,$7d,$7c,$ff

    L_acd9:
        lda $af7a
        beq L_ad11
        cmp #$20
        beq L_acee
        cmp #$10
        beq L_acee
        cmp #$08
        beq L_acee
        cmp #$04
        bne L_acf1
    L_acee:
        dec L_af7b
    L_acf1:
        ldy L_af7b
    L_acf4:
        sty $c9
        jsr L_ad1a
        jsr L_addf
        ldy $c9
        dey 
        bne L_acf4
        dec $af7a
        lda $af7a
        bne L_ad10
        jsr L_a328
        lda #$00
        sta $d6
    L_ad10:
        rts 


    L_ad11:
        lda #$00
        sta $af7c
        sta L_af7d
        rts 


    L_ad1a:
        lda $af7c
        bne L_ad20
        rts 


    L_ad20:
        cmp #$02
        beq L_ad73
        lda L_c31f
        cmp #$02
        bne L_ad4f
        lda $c336
        cmp #$70
        bcc L_ad3f
        lda L_c31d + $1
        bne L_ad3f
        lda #$02
        sta L_c31d + $1
        jsr L_adc3
    L_ad3f:
        lda $c336
        cmp #$85
        bcc L_ad4f
        lda #$00
        sta $af7c
        sta L_af7d
        rts 


    L_ad4f:
        lda $c336
        clc 
        adc #$01
        sta $c336
        bcc L_ad5d
        inc L_c31f
    L_ad5d:
        lda L_b277
        beq L_ad6c
        lda L_b278
        cmp #$10
        bcc L_ad6c
        jsr L_b7e7
    L_ad6c:
        jsr L_ae75
        jsr L_af02
        rts 


    L_ad73:
        lda L_c31f
        bne L_ad9c
        lda $c336
        cmp #$37
        bcs L_ad9c
        lda L_c31d + $1
        bne L_ad8c
        lda #$04
        sta L_c31d + $1
        jsr L_adc3
    L_ad8c:
        lda $c336
        cmp #$22
        bcs L_ad9c
        lda #$00
        sta $af7c
        sta L_af7d
        rts 


    L_ad9c:
        lda $c336
        sec 
        sbc #$01
        sta $c336
        lda L_c31f
        sbc #$00
        sta L_c31f
        lda L_b277
        bne L_adbc
        lda L_b278
        cmp #$5a
        bcs L_adbc
        jsr $b7cf
    L_adbc:
        jsr L_ae75
        jsr L_af02
        rts 


    L_adc3:
        lda L_c31f
        sta $9cab
        lda $c336
        sta $9cad
        lda $c34d
        sta L_9cac
        lda L_c364
        sta L_9cae
        jsr L_8521
        rts 


    L_addf:
        lda L_af7d
        bne L_ade5
        rts 


    L_ade5:
        cmp #$02
        bne L_ae30
        lda $c34d
        cmp #$02
        bne L_ae11
        lda L_c364
        cmp #$6a
        bcc L_ae11
        lda L_c31d + $1
        bne L_ae01
        lda #$03
        sta L_c31d + $1
    L_ae01:
        lda L_c364
        cmp #$7a
        bcc L_ae11
        lda #$00
        sta $af7c
        sta L_af7d
        rts 


    L_ae11:
        lda L_c364
        clc 
        adc #$01
        sta L_c364
        lda $c34d
        adc #$00
        sta $c34d
        lda $b279
        cmp #$a0
        bcc L_ae2c
        jsr L_b813
    L_ae2c:
        jsr L_af02
        rts 


    L_ae30:
        lda $c34d
        bne L_ae56
        lda L_c364
        cmp #$32
        bcs L_ae46
        lda L_c31d + $1
        bne L_ae46
        lda #$01
        sta L_c31d + $1
    L_ae46:
        lda L_c364
        cmp #$22
        bcs L_ae56
        lda #$00
        sta $af7c
        sta L_af7d
        rts 


    L_ae56:
        lda L_c364
        sec 
        sbc #$01
        sta L_c364
        lda $c34d
        sbc #$00
        sta $c34d
        lda $b279
        cmp #$50
        bcs L_ae71
        jsr L_b7fb
    L_ae71:
        jsr L_ae75
        rts 


    L_ae75:
        lda $c34d
        bne L_aee3
        lda L_c364
        cmp #$33
        bcs L_aee3
        lda L_c31f
        cmp #$01
        bne L_aee3
        lda $c336
        cmp #$26
        beq L_aea9
        bcc L_aee4
        cmp #$2b
        bcs L_aeaf
        lda L_c364
        cmp #$32
        bcc L_aea9
        bne L_aea9
        lda $e2
        bne L_aee3
        jsr L_af6b
        inc L_c364
        rts 


    L_aea9:
        lda #$00
        sta $af7c
        rts 


    L_aeaf:
        cmp #$7e
        bcc L_aeda
        cmp #$80
        beq L_aecd
        bcs L_aee4
        lda L_c364
        cmp #$32
        bcc L_aed4
        bne L_aed4
        lda $e2
        bne L_aed9
        jsr L_af6b
        inc L_c364
        rts 


    L_aecd:
        lda $af7c
        cmp #$02
        beq L_aed9
    L_aed4:
        lda #$00
        sta $af7c
    L_aed9:
        rts 


    L_aeda:
        lda #$01
        sta $e2
        lda #$05
        jsr L_aef1
    L_aee3:
        rts 


    L_aee4:
        lda L_c364
        cmp #$70
        bcs L_aef0
        lda #$06
        jsr L_aef1
    L_aef0:
        rts 


    L_aef1:
        sta L_e006
        lda #$00
        sta L_e006 + $1
        jsr L_e009
        lda #$01
        sta L_852f + $1
        rts 


    L_af02:
        lda $c34d
        cmp #$02
        bne L_af61
        lda L_c364
        cmp #$6c
        bcc L_af61
        lda L_c31f
        cmp #$01
        bne L_af61
        lda $c336
        cmp #$26
        beq L_af36
        bcc L_aee4
        cmp #$2b
        bcs L_af3c
        lda L_c364
        cmp #$6d
        bne L_af36
        lda $e2
        bne L_af61
        jsr L_af6b
        dec L_c364
        rts 


    L_af36:
        lda #$00
        sta $af7c
        rts 


    L_af3c:
        cmp #$7e
        bcc L_af58
        cmp #$80
        beq L_af36
        bcs L_aee4
        lda L_c364
        cmp #$6d
        bne L_af36
        lda $e2
        bne L_af61
        jsr L_af6b
        dec L_c364
        rts 


    L_af58:
        lda #$02
        sta $e2
        lda #$05
        jsr L_aef1
    L_af61:
        rts 


        ldy $af7c
        lda L_af75,y
        sta $af7c
    L_af6b:
        ldy L_af7d
        lda L_af75,y
        sta L_af7d
        rts 



    L_af75:
         .byte $00,$02
        .byte $01,$4c

    L_af79:
        and ($b0),y
    L_af7b:
        lda #$01
    L_af7d:
        sta L_32a1 + $c
        ldx $f0

        .byte $03,$4c,$ba,$af,$ad,$cc,$b7,$f0,$26,$ad,$c8,$b7,$0a,$a8,$b9,$24
        .byte $b0,$85,$c7,$b9,$25,$b0,$85,$c8

    L_af9a:
        ldy L_b7cd
        lda ($c7),y
        cmp #$ff
        bne L_afab
        lda #$00
        sta L_b7cd
        jmp L_af9a
    L_afab:
        ldx $c6
        sta $c392,x
        rts 


    L_afb1:
        ldy $b7c8
        lda L_b087 + $1,y
        jmp L_afab
    L_afba:
        lda L_c526 + $a
        bne L_afc8
        ldy $b7c8
        lda $b093,y
        jmp L_afab
    L_afc8:
        ldy $b7c8
        lda $b09e,y
        jmp L_afab
    L_afd1:
        lda $a634
        beq L_afd9
        jmp L_b00d
    L_afd9:
        lda $b7b3
        beq L_b004
        lda L_b7c9
        asl 
        tay 
        lda L_b024,y
        sta $c7
        lda L_b024 + $1,y
        sta $c8
    L_afed:
        ldy $b7ce
        lda ($c7),y
        cmp #$ff
        bne L_affe
        lda #$00
        sta $b7ce
        jmp L_afed
    L_affe:
        ldx $d0
        sta $c392,x
        rts 


    L_b004:
        ldy L_b7c9
        lda L_b087 + $1,y
        jmp L_affe
    L_b00d:
        lda L_c531
        bne L_b01b
        ldy L_b7c9
        lda $b093,y
        jmp L_affe
    L_b01b:
        ldy L_b7c9
        lda $b09e,y
        jmp L_affe

    L_b024:
         .byte $00,$00,$5a,$b0,$3e,$b0,$00,$00
        .byte $68,$b0,$61,$b0,$6f,$b0,$00,$00,$4c,$b0,$53,$b0,$45,$b0,$76,$b0
        .byte $7f,$b0,$40,$41,$42,$43,$ff,$ff,$ff,$44,$45,$46,$47,$48,$49,$ff
        .byte $4a,$4b,$4c,$4d,$4e,$4f,$ff,$50,$51,$52,$53,$54,$55,$ff,$56,$57
        .byte $58,$59,$ff,$ff,$ff,$5a,$5b,$5c,$5d,$5e,$5f,$ff,$60

    L_b069:
        .byte $61,$62,$63,$64
        .byte $65,$ff,$66,$67,$68,$69,$6a,$6b,$ff,$cc,$cc,$cd,$cd,$ce,$ce,$cf
        .byte $cf,$ff,$dc,$dc,$dd,$dd,$de,$de,$df,$df

    L_b087:
        .byte $ff,$00,$9c
        .byte $98,$00,$9e,$9d,$9f,$00

    L_b090:
        txs 

        .byte $9b,$99,$00,$94,$90,$00

    L_b097:
        stx $95,y

        .byte $97,$00,$92,$93,$91,$00,$94,$90,$00,$96,$95,$e1,$00,$92,$93,$e0
        .byte $20,$b8,$b0,$20,$c9,$b0

    L_b0af:
        jsr L_b0da
        jsr L_b0eb
        jmp L_b0fc
        lda $c1
        sec 
        sbc $c0
    L_b0bd:
        cmp #$04
        bcs L_b0c8
        lda $c0
        clc 
        adc #$04
        sta $c1
    L_b0c8:
        rts 


        lda $c2
        sec 
        sbc $c1
        cmp #$04
        bcs L_b0d9
        lda $c1
        clc 
        adc #$04
        sta $c2
    L_b0d9:
        rts 


    L_b0da:
        lda $c3
        sec 
        sbc $c2
        cmp #$04
        bcs L_b0ea
        lda $c2
        clc 
        adc #$04
        sta $c3
    L_b0ea:
        rts 


    L_b0eb:
        lda $c4
        sec 
        sbc $c3
        cmp #$04
        bcs L_b0fb
        lda $c3
        clc 
        adc #$04
        sta $c4
    L_b0fb:
        rts 


    L_b0fc:
        lda $c5
        sec 
        sbc $c4
        cmp #$04
        bcs L_b10c
        lda $c4
        clc 
        adc #$04
        sta $c5
    L_b10c:
        rts 


    L_b10d:
        lda $80
        clc 
        adc #$2a
        sta $c0
        lda $81
        clc 
        adc #$2a
        sta $c1
        lda $82
        clc 
        adc #$2a
        sta $c2
        lda $83
        clc 
        adc #$2a
        sta $c3
        lda $84
        clc 
        adc #$2a
        sta $c4
        lda $85
        clc 
        adc #$2a
        sta $c5
        rts 


    L_b138:
        ldx #$0d
    L_b13a:
        lda L_c461,x
        sta $60,x
        lda L_c478,x
        sta $70,x
        lda L_c4a6,x
        sta $80,x
        lda L_c4d4,x
        sta $90,x
        lda L_c4bd,x
        sta $a0,x
        lda L_c44a,x
        sta $b0,x
        dex 
        bpl L_b13a
        rts 


    L_b15c:
        ldy #$16
    L_b15e:
        lda $c532,y
        sta L_c31f,y
        lda L_c546 + $3,y
        sta $c336,y
        lda L_c560,y
        sta $c34d,y
        lda L_c577,y
        sta L_c364,y
        lda L_c59a + $b,y
        sta $c392,y
        lda #$00
        sta L_c3a8 + $1,y
        lda #$01
        sta L_c3c0,y
        dey 
        bpl L_b15e
        rts 


    L_b18a:
        jsr $b27a
        ldy #$00
        sty $33
    L_b191:
        jsr L_b1f7
        iny 
        cpy #$17
        bne L_b191
        jsr L_b19f
        jmp L_b1cc
    L_b19f:
        ldx #$00
    L_b1a1:
        lda #$ff
        sta $34
        ldy #$0d
    L_b1a7:
        lda L_c4a6,y
        cmp $34
        bcs L_b1b2
        sty $35
        sta $34
    L_b1b2:
        dey 
        bpl L_b1a7
        ldy $35
        lda L_c4a6,y
        sta $50,x
        lda #$ff
        sta L_c4a6,y
        lda L_c44a,y
        sta $40,x
        inx 
        cpx #$0e
        bne L_b1a1
        rts 


    L_b1cc:
        ldx #$0d
    L_b1ce:
        lda $40,x
        tay 
        lda $c4eb,y
        sta L_c461,x
        lda L_c502,y
        sta L_c478,x
        lda L_c37b,y
        sta L_c4bd,x
        lda $c392,y
        sta L_c4d4,x
        lda $50,x
        sta L_c4a6,x
        lda $40,x
        sta L_c44a,x
        dex 
        bpl L_b1ce
        rts 


    L_b1f7:
        lda L_c31f,y
        sta $2f
        lda $c336,y
        sec 
        sbc $2c
        sta $30
        bcs L_b208
        dec $2f
    L_b208:
        lda $2f
        sec 
        sbc $2b
        sta $2f
        bne L_b21a
        lda $30
        cmp #$18
        bcc L_b224
        jmp L_b225
    L_b21a:
        cmp #$01
        bne L_b224
        lda $30
        cmp #$4c
        bcc L_b225
    L_b224:
        rts 


    L_b225:
        lda $c34d,y
        sta $31
        lda L_c364,y
        sec 
        sbc $2e
        sta $32
        bcs L_b236
        dec $31
    L_b236:
        lda $31
        sec 
        sbc $2d
        sta $31
        bne L_b24b
        lda $32
        cmp #$21
        bcc L_b24b
        lda $32
        cmp #$f4
        bcc L_b24c
    L_b24b:
        rts 


    L_b24c:
        ldx $33
        tya 
        sta L_c44a,x
        lda $2f
        sta $c4eb,y
        lda $30
        sta L_c502,y
        lda $32
        sta L_c4a6,x
        inc $33
        cpy #$00
        bne L_b276
        lda $2f
        sta L_b277
        lda $30
        sta L_b278
        lda $32
        sta $b279
    L_b276:
        rts 



    L_b277:
         .byte $4b

    L_b278:
        lda L_a0ed
        asl.a $00a9
        sta L_c502,y
        sta $c4eb,y
        sta L_c461,y
        sta L_c478,y
        lda #$fe
        sta L_c4a6,y
        lda #$ff
        sta L_c4d4,y
        dey 

        .byte $10,$e5,$60

    L_b298:
        lda $e4
        cmp #$02
        bne L_b29f
        rts 


    L_b29f:
        lda L_c526 + $a
        beq L_b2a5
        rts 


    L_b2a5:
        lda $a632
        beq L_b2ab
        rts 


    L_b2ab:
        lda #$00
        sta $b7cb
        sta L_b7ca
        sta $b7cc
        ldy #$00
        lda ($e6),y
        sta $25
        tax 
        and #$02
        bne L_b30e
        ldy $c6
        lda $c34d,y
        cmp #$02
        bne L_b2f0
        lda L_c31f,y
        cmp #$01
        bne L_b2e6
        lda $c336,y
        cmp #$2d
        bcc L_b2e6
        cmp #$8c
        bcs L_b2e6
        lda L_c364,y
        cmp #$70
        bcc L_b2f0
        jmp L_b30e
    L_b2e6:
        lda L_c364,y
        cmp #$84
        bcc L_b2f0
        jmp L_b30e
    L_b2f0:
        lda L_c364,y
        clc 
        adc #$02
        sta L_c364,y
        lda $c34d,y
        adc #$00
        sta $c34d,y
        lda #$01
        sta $b7c8
        lda #$01
        sta $b7cc
        sta L_b7ca
    L_b30e:
        lda $25
        and #$01
        bne L_b343
        ldy $c6
        lda $c34d,y
        bne L_b325
        lda L_c364,y
        cmp #$4d
        bcs L_b325
        jmp L_b343
    L_b325:
        lda L_c364,y
        sec 
        sbc #$02
        sta L_c364,y
        lda $c34d,y
        sbc #$00
        sta $c34d,y
        lda #$02
        sta $b7c8
        lda #$01
        sta $b7cb
        sta $b7cc
    L_b343:
        lda $25
        and #$04
        bne L_b3b1
        ldy $c6
        lda $c34d,y
        cmp #$02
        bne L_b36e
        lda L_c31f,y
        cmp #$01
        bne L_b36e
        lda L_c364,y
        cmp #$72
        bcc L_b36e
        lda $c336,y
        cmp #$8d
        beq L_b36b
        cmp #$8c
        bne L_b36e
    L_b36b:
        jmp L_b3b1
    L_b36e:
        lda L_c31f,y
        bne L_b37d
        lda $c336,y
        cmp #$32
        bcs L_b37d
        jmp L_b3b1
    L_b37d:
        lda $c336,y
        sec 
        sbc #$02
        sta $c336,y
        lda L_c31f,y
        sbc #$00
        sta L_c31f,y
        lda #$04
        sta $b7c8
        lda #$01
        sta $b7cc
        lda L_b7ca
        beq L_b3a7
        lda #$05
        sta $b7c8
        lda #$01
        sta $b7cc
    L_b3a7:
        lda $b7cb
        beq L_b3b1
        lda #$06
        sta $b7c8
    L_b3b1:
        lda $25
        and #$08
        bne L_b41c
        ldy $c6
        lda $c34d,y
        cmp #$02
        bne L_b3dc
        lda L_c31f,y
        cmp #$01
        bne L_b3dc
        lda L_c364,y
        cmp #$72
        bcc L_b3dc
        lda $c336,y
        cmp #$29
        beq L_b3d9
        cmp #$28
        bne L_b3dc
    L_b3d9:
        jmp L_b41c
    L_b3dc:
        lda L_c31f,y
        cmp #$02
        bne L_b3ed
        lda $c336,y
        cmp #$82
        bcc L_b3ed
        jmp L_b41c
    L_b3ed:
        lda $c336,y
        clc 
        adc #$02
        sta $c336,y
        lda L_c31f,y
        adc #$00
        sta L_c31f,y
        lda #$08
        sta $b7c8
        lda #$01
        sta $b7cc
        lda L_b7ca
        beq L_b412
        lda #$09
        sta $b7c8
    L_b412:
        lda $b7cb
        beq L_b41c
        lda #$0a
        sta $b7c8
    L_b41c:
        lda $25
        and #$10
        beq L_b425
        jmp L_b4a2
    L_b425:
        lda $b7cc
        bne L_b42b
        rts 


    L_b42b:
        lda $b524
        beq L_b433
        jmp L_b4ef
    L_b433:
        lda #$01
        sta L_b523
        lda $b7b0
        bne L_b451
        lda $ca
        bne L_b444
        jmp L_b4ef
    L_b444:
        lda #$01
        sta $b7b0
        lda #$02
        sta $b7af
        jmp L_b4ef
    L_b451:
        lda $b7af
        beq L_b45c
        dec $b7af
        jmp L_b4ef
    L_b45c:
        lda $ca
        bne L_b463
        jmp L_b4ef
    L_b463:
        lda #$01
        sta L_c31d
        lda #$00
        sta L_c31d + $1
        sta $b7b0
        sta $b7af
        lda #$05
        sta L_af7b
        lda #$33
        sta $af7a
        ldy $b7c8
        lda L_ab79,y
        sta $af7c
        lda $ab84,y
        sta L_af7d
        lda #$01
        sta L_af79
        sta $b524
        lda #$00
        sta $af78
        sta L_b523
        jsr L_8515
        jmp L_b4ef
    L_b4a2:
        lda #$00
        sta $b524
        lda $b7b0
        beq L_b4fa
        lda $b7af
        beq L_b4fa
        lda #$00
        sta $b7b0
        sta $b7af
        sta L_c31d + $1
        lda #$01
        sta L_c31d
        lda #$05
        sta L_af7b
        lda #$19
        sta $af7a
        ldy $b7c8
    L_b4ce:
        lda L_ab79,y
    L_b4d1:
        sta $af7c
        lda $ab84,y
        sta L_af7d
        lda #$02
        sta L_af79
        lda #$00
        sta L_b523
        sta $af78
        lda #$01
        sta $b524
        jsr L_8515
    L_b4ef:
        lda $b7cc
        beq L_b4f9
        ldx #$00
        jsr L_b7b4
    L_b4f9:
        rts 


    L_b4fa:
        lda L_b523
        beq L_b51b
        lda #$03
        sta L_a547
        lda #$14
        sta $a632
        lda $b7c8
        sta $a631
        lda $b7c8
        and #$03
        beq L_b51b
        lda #$0d
        sta $a632
    L_b51b:
        lda #$00
        sta L_b523
        jmp L_b4ef
    L_b523:
        ldx $8d,y
    L_b525:
        lda $e4
        cmp #$01
        bne L_b52c
        rts 


    L_b52c:
        lda L_c531
        beq L_b532
        rts 


    L_b532:
        lda $a634
        beq L_b538
        rts 


    L_b538:
        lda #$00
        sta $b7cb
        sta L_b7ca
        sta $b7b3
        ldy #$00
        lda ($e8),y
        sta $25
        tax 
        and #$02
        bne L_b59b
        ldy $d0
        lda $c34d,y
        cmp #$02
        bne L_b57d
        lda L_c31f,y
        cmp #$01
        bne L_b573
        lda $c336,y
        cmp #$2d
        bcc L_b573
        cmp #$8c
        bcs L_b573
        lda L_c364,y
        cmp #$70
        bcc L_b57d
        jmp L_b59b
    L_b573:
        lda L_c364,y
        cmp #$84
        bcc L_b57d
        jmp L_b59b
    L_b57d:
        lda L_c364,y
        clc 
        adc #$02
        sta L_c364,y
        lda $c34d,y
        adc #$00
        sta $c34d,y
        lda #$01
        sta L_b7c9
        lda #$01
        sta $b7b3
        sta L_b7ca
    L_b59b:
        lda $25
        and #$01
        bne L_b5d3
        ldy $d0
        lda $c34d,y
        lda $c34d,y
        bne L_b5b5
        lda L_c364,y
        cmp #$4d
        bcs L_b5b5
        jmp L_b5d3
    L_b5b5:
        lda L_c364,y
        sec 
        sbc #$02
        sta L_c364,y
        lda $c34d,y
        sbc #$00
        sta $c34d,y
        lda #$02
        sta L_b7c9
        lda #$01
        sta $b7cb
        sta $b7b3
    L_b5d3:
        lda $25
        and #$04
        bne L_b641
        ldy $d0
        lda $c34d,y
        cmp #$02
        bne L_b5fe
        lda L_c31f,y
        cmp #$01
        bne L_b5fe
        lda L_c364,y
        cmp #$72
        bcc L_b5fe
        lda $c336,y
        cmp #$8d
        beq L_b5f9
        cmp #$8c
    L_b5f9:
        bne L_b5fe
        jmp L_b641
    L_b5fe:
        lda L_c31f,y
        bne L_b60d
        lda $c336,y
        cmp #$32
        bcs L_b60d
        jmp L_b641
    L_b60d:
        lda $c336,y
        sec 
        sbc #$02
        sta $c336,y
        lda L_c31f,y
        sbc #$00
        sta L_c31f,y
        lda #$04
        sta L_b7c9
        lda #$01
        sta $b7b3
        lda L_b7ca
        beq L_b637
        lda #$05
        sta L_b7c9
        lda #$01
        sta $b7b3
    L_b637:
        lda $b7cb
        beq L_b641
        lda #$06
        sta L_b7c9
    L_b641:
        lda $25
        and #$08
        bne L_b6ac
        ldy $d0
        lda $c34d,y
        cmp #$02
        bne L_b66c
        lda L_c31f,y
        cmp #$01
        bne L_b66c
        lda L_c364,y
        cmp #$72
        bcc L_b66c
        lda $c336,y
        cmp #$29
        beq L_b669
        cmp #$28
        bne L_b66c
    L_b669:
        jmp L_b6ac
    L_b66c:
        lda L_c31f,y
        cmp #$02
        bne L_b67d
        lda $c336,y
        cmp #$82
        bcc L_b67d
        jmp L_b6ac
    L_b67d:
        lda $c336,y
        clc 
        adc #$02
        sta $c336,y
        lda L_c31f,y
        adc #$00
        sta L_c31f,y
        lda #$08
        sta L_b7c9
        lda #$01
        sta $b7b3
        lda L_b7ca
        beq L_b6a2
        lda #$09
        sta L_b7c9
    L_b6a2:
        lda $b7cb
        beq L_b6ac
        lda #$0a
        sta L_b7c9
    L_b6ac:
        lda $25
        and #$10
        bne L_b72f
        lda $b7b3
        bne L_b6b8
        rts 


    L_b6b8:
        lda L_b7ae
        beq L_b6c0
        jmp L_b77c
    L_b6c0:
        lda #$01
        sta L_b7ad
        lda $b7b2
        bne L_b6de
        lda $cf
        bne L_b6d1
        jmp L_b77c
    L_b6d1:
        lda #$01
        sta $b7b2
        lda #$02
        sta L_b7b1
        jmp L_b77c
    L_b6de:
        lda L_b7b1
        beq L_b6e9
        dec L_b7b1
        jmp L_b77c
    L_b6e9:
        lda $cf
        bne L_b6f0
        jmp L_b77c
    L_b6f0:
        lda #$02
        sta L_c31d
        lda #$00
        sta $b7b2
        sta L_c31d + $1
        sta L_b7b1
        lda #$05
        sta L_af7b
        lda #$33
        sta $af7a
        ldy L_b7c9
        lda L_ab79,y
        sta $af7c
        lda $ab84,y
        sta L_af7d
        lda #$01
        sta L_af79
        sta L_b7ae
        lda #$00
        sta $af78
        sta L_b7ad
        jsr L_8515
        jmp L_b77c
    L_b72f:
        lda #$00
        sta L_b7ae
        lda $b7b2
        beq L_b787
        lda L_b7b1
        beq L_b787
        lda #$00
        sta $b7b2
        sta L_c31d + $1
        sta L_b7b1
        lda #$02
        sta L_c31d
        lda #$05
        sta L_af7b
        lda #$19
        sta $af7a
        ldy L_b7c9
        lda L_ab79,y
        sta $af7c
        lda $ab84,y
        sta L_af7d
        lda #$02
        sta L_af79
        lda #$00
        sta L_b7ad
        sta $af78
        lda #$01
        sta L_b7ae
        jsr L_8515
    L_b77c:
        lda $b7b3
        beq L_b786
        ldx #$01
        jsr L_b7b4
    L_b786:
        rts 


    L_b787:
        lda L_b7ad
        beq L_b7a5
        lda #$03
        sta L_a547 + $1
        lda #$14
        sta $a634
        lda L_b7c9
        sta L_a633
        and #$03
        beq L_b7a5
        lda #$0d
        sta $a634
    L_b7a5:
        lda #$00
        sta L_b7ad
        jmp L_b77c
    L_b7ad:
        plp 
    L_b7ae:
        jmp L_b0bd
    L_b7b1:
        ora L_5099,y
    L_b7b4:
        lda L_b7c6,x
        beq L_b7bd
        dec L_b7c6,x
        rts 


    L_b7bd:
        lda #$01
        sta L_b7c6,x
        inc L_b7cd,x
        rts 


    L_b7c6:
        jmp L_f0b9 + $4

    L_b7c9:
         .byte $1a

    L_b7ca:
        sta L_4cdc + $14,y
    L_b7cd:
        lda $a540,x
        and ($c9,x)

        .byte $ff,$f0,$11,$20,$53,$b8,$e6,$26,$a5,$26,$c9,$08,$d0,$06,$a9,$00
        .byte $85,$26,$c6,$21

    L_b7e6:
        rts 


    L_b7e7:
        lda $21
        cmp #$2a
        beq L_b7fa
        jsr L_b845
        dec $26
        bpl L_b7fa
        lda #$07
        sta $26
        inc $21
    L_b7fa:
        rts 


    L_b7fb:
        lda $24
        beq L_b810
        jsr L_b837
        inc $29
        lda $29
        cmp #$08
        bne L_b810
        lda #$00
        sta $29
        dec $24
    L_b810:
        jmp L_b861
    L_b813:
        lda $24
        cmp #$39
        beq L_b826
        jsr L_b829
        dec $29
        bpl L_b826
        lda #$07
        sta $29
        inc $24
    L_b826:
        jmp L_b861
    L_b829:
        lda $2e
        clc 
        adc #$01
        sta $2e
        lda $2d
        adc #$00
        sta $2d
        rts 


    L_b837:
        lda $2e
        sec 
        sbc #$01
        sta $2e
        lda $2d
        sbc #$00
        sta $2d
        rts 


    L_b845:
        lda $2c
        clc 
        adc #$01
        sta $2c
        lda $2b
        adc #$00
        sta $2b
        rts 


    L_b853:
        lda $2c
        sec 
        sbc #$01
        sta $2c
        lda $2b
        sbc #$00
        sta $2b
        rts 


    L_b861:
        lda $24
        asl 
        tay 
        lda L_baef + $2,y
        sta $bbc4
        lda L_baef + $3,y
        sta $bbc5
        lda L_baef + $4,y
        sta $bbca
        lda L_baf4,y
        sta $bbcb
        lda $baf5,y
        sta $bbd0
        lda L_baf6,y
        sta $bbd1
        lda L_baf6 + $1,y
        sta $bbd6
        lda L_baf6 + $2,y
        sta $bbd7
        lda L_baf6 + $3,y
        sta $bbdc
        lda L_bafa,y
        sta $bbdd
        lda $bafb,y
        sta $bbe2
        lda L_bafc,y
        sta $bbe3
        lda $bafd,y
        sta $bbe8
        lda L_bafe,y
        sta $bbe9
        lda $baff,y
        sta $bbee
        lda L_bb00,y
        sta $bbef
        lda L_bb00 + $1,y
        sta $bbf4
        lda L_bb00 + $2,y
        sta $bbf5
        lda L_bb00 + $3,y
        sta $bbfa
        lda L_bb00 + $4,y
        sta $bbfb
        lda L_bb05,y
        sta $bc00
        lda $bb06,y
        sta $bc01
        lda $bb07,y
        sta $bc06
        lda L_bb08,y
        sta $bc07
        lda L_bb09,y
        sta $bc0c
        lda $bb0a,y
        sta $bc0d
        lda L_bb0b,y
        sta $bc12
        lda L_bb0b + $1,y
        sta $bc13
        lda L_bb0d,y
        sta $bc18
        lda L_bb0e,y
        sta $bc19
        lda L_bb0f,y
        sta $bc1e
        lda $bb10,y
        sta $bc1f
        lda L_bb11,y
        sta $bc24
        lda L_bb12,y
        sta $bc25
        lda $bb13,y
        sta $bc2a
        lda L_bb14,y
        sta $bc2b
        lda $bb15,y
        sta $bc30
        lda L_bb16,y
        sta $bc31
        lda $bb17,y
        sta $bc36
        lda L_bb18,y
        sta $bc37
        lda $bb19,y
        sta $bc3c
        lda L_bb1a,y
        sta $bc3d
        lda $bb1b,y
        sta $bc42
        lda L_bb1c,y
        sta $bc43
        lda $bb1d,y
        sta $bc48
        lda L_bb1e,y
        sta $bc49
        lda $bb1f,y
        sta $bc4e
        lda L_bb20,y
        sta $bc4f
        lda L_bb20 + $1,y
        sta $bc54
        lda L_bb20 + $2,y
        sta $bc55
        lda L_baef + $2,y
        sta $bc68
        lda L_baef + $3,y
        sta $bc69
        lda L_baef + $4,y
        sta $bc6e
        lda L_baf4,y
        sta $bc6f
        lda $baf5,y
        sta $bc74
        lda L_baf6,y
        sta $bc75
        lda L_baf6 + $1,y
        sta $bc7a
        lda L_baf6 + $2,y
        sta $bc7b
        lda L_baf6 + $3,y
        sta $bc80
        lda L_bafa,y
        sta $bc81
        lda $bafb,y
        sta $bc86
        lda L_bafc,y
        sta $bc87
        lda $bafd,y
        sta $bc8c
        lda L_bafe,y
        sta $bc8d
        lda $baff,y
        sta $bc92
        lda L_bb00,y
        sta $bc93
        lda L_bb00 + $1,y
        sta $bc98
        lda L_bb00 + $2,y
        sta $bc99
        lda L_bb00 + $3,y
        sta $bc9e
        lda L_bb00 + $4,y
        sta $bc9f
        lda L_bb05,y
        sta $bca4
        lda $bb06,y
        sta $bca5
        lda $bb07,y
        sta $bcaa
        lda L_bb08,y
        sta $bcab
        lda L_bb09,y
        sta $bcb0
        lda $bb0a,y
        sta $bcb1
        lda L_bb0b,y
        sta $bcb6
        lda L_bb0b + $1,y
        sta $bcb7
        lda L_bb0d,y
        sta $bcbc
        lda L_bb0e,y
        sta $bcbd
        lda L_bb0f,y
        sta $bcc2
        lda $bb10,y
        sta $bcc3
        lda L_bb11,y
        sta $bcc8
        lda L_bb12,y
        sta $bcc9
        lda $bb13,y
        sta $bcce
        lda L_bb14,y
        sta $bccf
        lda $bb15,y
        sta $bcd4
        lda L_bb16,y
        sta $bcd5
        lda $bb17,y
        sta $bcda
        lda L_bb18,y
        sta $bcdb
        lda $bb19,y
        sta $bce0
        lda L_bb1a,y
        sta $bce1
        lda $bb1b,y
        sta $bce6
        lda L_bb1c,y
    L_ba96:
        sta $bce7
        lda $bb1d,y
        sta $bcec
        lda L_bb1e,y
        sta $bced
        lda $bb1f,y
        sta $bcf2
        lda L_bb20,y
        sta $bcf3
        lda L_bb20 + $1,y
        sta $bcf8
        lda L_bb20 + $2,y
        sta $bcf9
        rts 


    L_babe:
        lda #$10
        sta L_baef
        lda #$00
        sta L_baef + $1
        ldy #$51
        ldx #$00
    L_bacc:
        lda L_baef + $1
        sta L_baef + $2,x
        lda L_baef
        sta L_baef + $3,x
        lda L_baef + $1
        clc 
        adc #$50
        sta L_baef + $1
        lda L_baef
        adc #$00
        sta L_baef
        inx 
        inx 
        dey 
        bne L_bacc
        rts 



    L_baef:
         .byte $29,$50,$00,$10,$50

    L_baf4:
        bpl L_ba96

    L_baf6:
         .byte $10,$f0,$10,$40

    L_bafa:
        ora ($90),y
    L_bafc:
        ora ($e0),y
    L_bafe:
        ora ($30),y

    L_bb00:
         .byte $12,$80,$12,$d0,$12

    L_bb05:
        jsr L_7013

    L_bb08:
         .byte $13

    L_bb09:
        cpy #$13

    L_bb0b:
         .byte $10,$14

    L_bb0d:
        rts 



    L_bb0e:
         .byte $14

    L_bb0f:
        bcs L_bb25

    L_bb11:
         .byte $00

    L_bb12:
        ora $50,x
    L_bb14:
        ora $a0,x
    L_bb16:
        ora $f0,x
    L_bb18:
        ora $40,x
    L_bb1a:
        asl $90,x
    L_bb1c:
        asl $e0,x
    L_bb1e:
        asl $30,x

    L_bb20:
         .byte $17,$80,$17,$d0,$17

    L_bb25:
        jsr L_7018

        .byte $18,$c0,$18,$10,$19,$60,$19,$b0,$19,$00,$1a,$50,$1a,$a0,$1a,$f0
        .byte $1a,$40,$1b,$90,$1b,$e0,$1b,$30,$1c,$80,$1c,$d0,$1c,$20,$1d,$70
        .byte $1d,$c0,$1d,$10,$1e,$60,$1e,$b0,$1e,$00,$1f

    L_bb53:
        bvc L_bb74
        ldy #$1f
        beq L_bb78
        rti 
        jsr $2090

    L_bb5d:
         .byte $e0,$20,$30,$21,$80
        .byte $21,$d0,$21,$20,$22,$70,$22,$c0,$22

    L_bb6b:
        .byte $10,$23
        .byte $60,$23,$b0,$23,$00,$24,$50

    L_bb74:
        bit $a0
        bit $f0
    L_bb78:
        bit $40
        and $90
        and $e0
        and $30
        rol $80
        rol $d0
        rol $20

        .byte $27,$70,$27,$c0,$27

    L_bb8b:
        bpl L_bbb5
        rts 



        .byte $28,$b0,$28,$00,$29,$a0,$00

    L_bb95:
        lda #$09
        sta vColorRam + $00,y
        sta vColorRam + $100,y
        sta vColorRam + $200,y
        sta vColorRam + $300,y
        dey 
        bne L_bb95
        rts 


    L_bba7:
        lda $22
        eor #$ff
        sta $22
        lda $22
        beq L_bbb8
        lda #$20
        sta $23
    L_bbb5:
        jmp L_bbbf
    L_bbb8:
        lda #$30
        sta $23
        jmp L_bc63
    L_bbbf:
        ldy #$00
        ldx $21
    L_bbc3:
        lda L_0ffe + $2,x
        sta SCREEN_BUFFER_1 + $00,y
        lda L_1050,x
        sta SCREEN_BUFFER_1 + $28,y
        lda L_10a0,x
        sta SCREEN_BUFFER_1 + $50,y
        lda $10f0,x
        sta SCREEN_BUFFER_1 + $78,y
        lda $1140,x
        sta SCREEN_BUFFER_1 + $a0,y
        lda $1190,x
        sta SCREEN_BUFFER_1 + $c8,y
        lda $11e0,x
        sta SCREEN_BUFFER_1 + $f0,y
        lda $1230,x
        sta SCREEN_BUFFER_1 + $118,y
        lda $1280,x
        sta SCREEN_BUFFER_1 + $140,y
        lda $12d0,x
        sta SCREEN_BUFFER_1 + $168,y
        lda $1320,x
        sta SCREEN_BUFFER_1 + $190,y
        lda $1370,x
        sta SCREEN_BUFFER_1 + $1b8,y
        lda $13c0,x
        sta SCREEN_BUFFER_1 + $1e0,y
        lda $1410,x
        sta SCREEN_BUFFER_1 + $208,y
        lda $1460,x
        sta SCREEN_BUFFER_1 + $230,y
        lda $14b0,x
        sta SCREEN_BUFFER_1 + $258,y
        lda $1500,x
        sta SCREEN_BUFFER_1 + $280,y
        lda $1550,x
        sta SCREEN_BUFFER_1 + $2a8,y
        lda $15a0,x
        sta SCREEN_BUFFER_1 + $2d0,y
        lda $15f0,x
        sta SCREEN_BUFFER_1 + $2f8,y
        lda $1640,x
        sta SCREEN_BUFFER_1 + $320,y
        lda $1690,x
        sta SCREEN_BUFFER_1 + $348,y
        lda $16e0,x
        sta SCREEN_BUFFER_1 + $370,y
        lda $1730,x
        sta SCREEN_BUFFER_1 + $398,y
        lda $1780,x
        sta SCREEN_BUFFER_1 + $3c0,y
        inx 
        iny 
        cpy #$28
        beq L_bc62
        jmp L_bbc3
    L_bc62:
        rts 


    L_bc63:
        ldy #$00
        ldx $21
    L_bc67:
        lda L_0ffe + $2,x
        sta L_4c00,y
        lda L_1050,x
        sta L_4c28,y
        lda L_10a0,x
        sta L_4c50,y
        lda $10f0,x
        sta L_4c78,y
        lda $1140,x
        sta L_4ca0,y
        lda $1190,x
        sta L_4ca0 + $28,y
        lda $11e0,x
        sta L_4cdc + $14,y
        lda $1230,x
        sta L_4d08 + $10,y
        lda $1280,x
        sta L_4d40,y
        lda $12d0,x
        sta $4d68,y
        lda $1320,x
        sta $4d90,y
        lda $1370,x
        sta L_4db8,y
        lda $13c0,x
        sta L_4de0,y
        lda $1410,x
        sta L_4e08,y
        lda $1460,x
        sta L_4e26 + $a,y
        lda $14b0,x
        sta L_4e4c + $c,y
        lda $1500,x
        sta L_4e80,y
        lda $1550,x
        sta L_4ea8,y
        lda $15a0,x
        sta L_4ed0,y
        lda $15f0,x
        sta L_4ef8,y
        lda $1640,x
        sta L_4f20,y
        lda $1690,x
        sta L_4f20 + $28,y
        lda $16e0,x
        sta L_4f20 + $50,y
        lda $1730,x
        sta L_4f95 + $3,y
        lda $1780,x
        sta L_4fc0,y
        inx 
        iny 
        cpy #$28
        beq L_bd06
        jmp L_bc67
    L_bd06:
        rts 


    L_bd07:
        cmp vRaster
        bcc L_bd07
    L_bd0c:
        cpx vRaster
        bcs L_bd0c
        rts 


    L_bd12:
        lda $e4
        bne L_bd1e
        lda $bd78
        beq L_bd1f
        dec $bd78
    L_bd1e:
        rts 


    L_bd1f:
        jsr L_bd5b
        lda #$1e
        sta $bd78
        dec L_9928
        lda L_9928
        cmp #$ff
        beq L_bd32
        rts 


    L_bd32:
        lda #$09
        sta L_9928
        dec $9929
        lda $9929
        cmp #$ff
        beq L_bd42
        rts 


    L_bd42:
        lda #$05
        sta $9929
        dec L_992a
        lda L_992a
        cmp #$ff
        beq L_bd52
        rts 


    L_bd52:
        lda #$09
        sta L_992a
        dec $992b
        rts 


    L_bd5b:
        lda $992b
        bne L_bd76
        lda L_992a
        bne L_bd76
        lda $9929
        bne L_bd76
        lda L_9928
        cmp #$01
        bne L_bd76
        lda #$01
        sta L_bd77
    L_bd76:
        rts 


    L_bd77:
        bne L_bd1e
    L_bd79:
        lda #$00
        sta L_be6a + $2
        sta L_be6a + $3
        sta L_be6a + $4
        sta L_be6a + $5
        sta L_be6a + $6
    L_bd8a:
        lda L_be6a + $1
        sec 
        sbc #$27
        beq L_bd97
        bcc L_bdbe
        jmp L_bda1
    L_bd97:
        lda L_be6a
        sec 
        sbc #$10
        beq L_bda1
        bcc L_bdbe
    L_bda1:
        inc L_be6a + $2
        lda L_be6a
        sec 
        sbc #$10
        sta L_be6a
        bcs L_bdb2
        dec L_be6a + $1
    L_bdb2:
        lda L_be6a + $1
        sec 
        sbc #$27
        sta L_be6a + $1
        jmp L_bd8a
    L_bdbe:
        lda L_be6a + $1
        sec 
        sbc #$03
        beq L_bdcb
        bcc L_bdf2
        jmp L_bdd5
    L_bdcb:
        lda L_be6a
        sec 
        sbc #$e8
        beq L_bdd5
        bcc L_bdf2
    L_bdd5:
        inc L_be6a + $3
        lda L_be6a
        sec 
        sbc #$e8
        sta L_be6a
        bcs L_bde6
        dec L_be6a + $1
    L_bde6:
        lda L_be6a + $1
        sec 
        sbc #$03
        sta L_be6a + $1
        jmp L_bdbe
    L_bdf2:
        lda L_be6a + $1
        beq L_bdfa
        jmp L_be04
    L_bdfa:
        lda L_be6a
        sec 
        sbc #$64
        beq L_be04
        bcc L_be18
    L_be04:
        inc L_be6a + $4
        lda L_be6a
        sec 
        sbc #$64
    L_be0d:
        sta L_be6a
        bcs L_be15
        dec L_be6a + $1
    L_be15:
        jmp L_bdf2
    L_be18:
        lda L_be6a
        sec 
        sbc #$0a
        beq L_be22
        bcc L_be36
    L_be22:
        inc L_be6a + $5
        lda L_be6a
        sec 
        sbc #$0a
        sta L_be6a
        bcs L_be33
        dec L_be6a + $1
    L_be33:
        jmp L_be18
    L_be36:
        lda L_be6a
        sta L_be6a + $6
        lda L_be6a + $2
        clc 
        adc #$ef
        sta L_be6a + $2
        lda L_be6a + $3
        clc 
        adc #$ef
        sta L_be6a + $3
        lda L_be6a + $4
        clc 
        adc #$ef
        sta L_be6a + $4
        lda L_be6a + $5
    L_be5a:
        clc 
        adc #$ef
        sta L_be6a + $5
        lda L_be6a + $6
    L_be63:
        clc 
        adc #$ef
        sta L_be6a + $6
        rts 



    L_be6a:
         .byte $01,$01,$01,$01,$02,$02,$02

    L_be71:
        jsr L_be7c
        lda #$00
        sta cCia1TimerAControl
        jmp L_800d
    L_be7c:
        sei 
        jsr L_bf23
        lda #$15
        sta L_fffa
        lda #$bf
        sta $fffb
        lda #$ea
        sta L_fffe
        lda #$be
        sta $ffff
        lda #$01
        sta vIRQMasks
        lda #$ff
        sta vIRQFlags
        lda #$7f
        sta cCia1IntControl
        lda cCia1IntControl
        lda #$88
        sta cCia2IntControl
        lda cCia2SSR
        lda #$08
        sta vScreenControl1
        lda #$00
        sta vIRQMasks
        lda #$00
        ldx #$54
        ldy #$bf
    L_bebe:
        jsr L_bee0
        cli 
    L_bec2:
        lda vRaster
        cmp #$80
        bne L_bec2
        cli 
        lda #$00
        sta vBackgCol0
        sta vBorderCol
        lda cCia2DDRA
        ora #$03
        sta cCia2DDRA
        lda #$02
    L_bedc:
        sta cCia2PortA
        rts 


    L_bee0:
        sta vRaster
        stx $bf04
        sty $bf05
        rts 


        sta $bf0f
        stx $bf11
        sty $bf13
        php 
        cld 
        lda $ff
        sta $bf0a
        lda #$0f
        sta $ff
        lda #$01
        sta vIRQFlags
        jmp L_bf54
    L_bf06:
        jsr L_bee0
        lda #$00
        sta $ff
        plp 
        lda #$c8
        ldx #$cd
        ldy #$2c
        rti 
    L_bf15:
        rti 
        lda #$18
        sta vScreenControl1
        lda #$00
        sta vIRQMasks
        jmp L_0810
    L_bf23:
        lda vRaster
        cmp #$fa
        bne L_bf23
        lda #$00
        sta $ee
        sta $ec
        sta vSpriteXMSB
        sta vBorderCol
        sta vBackgCol0
        sta vBackgCol1
        sta vBackgCol2
        sta vSprEnable
        sta vSprExpandX
        sta vSprExpandY
        sta vSprPriority
        sta vIRQMasks
        lda #$08
        sta vScreenControl1
        rts 


    L_bf54:
        inc L_852f + $3
        jsr L_e003
        lda $ee
        beq L_bf61
        jmp L_c035
    L_bf61:
        lda $ec
        beq L_bf68
        jmp L_c26c
    L_bf68:
        lda vScreenControl2
        and #$f8
        ora $27
        sta vScreenControl2
        lda vScreenControl1
        and #$f8
        ora $2a
        sta vScreenControl1
        lda $28
        sta vMemControl
        ldx #$07
        ldy #$00
    L_bf85:
        lda $70,x
        sta vSprite0X,y
        lda $80,x
        sta vSprite0Y,y
        iny 
        iny 
        dex 
        bpl L_bf85
        lda $a0
        sta vSpr7Col
        lda $a1
        sta vSpr6Col
        lda $a2
        sta vSpr5Col
        lda $a3
        sta vSpr4Col
        lda $a4
        sta vSpr3Col
        lda $a5
        sta vSpr2Col
        lda $a6
        sta vSpr1Col
        lda $a7
        sta vSpr0Col
        lda $90
    L_bfbe:
        sta L_4bfa + $5
        sta L_4ff8 + $7
        lda $91
        sta L_4bfa + $4
        sta L_4ff8 + $6
        lda $92
        sta L_4bfa + $3
        sta L_4ff8 + $5
        lda $93
        sta L_4bfa + $2
        sta L_4ff8 + $4
        lda $94
        sta L_4bfa + $1
        sta L_4ff8 + $3
        lda $95
        sta L_4bfa
        sta L_4ff8 + $2
        lda $96
        sta L_4bf9
        sta L_4ff8 + $1
        lda $97
        sta L_4bf8
        sta L_4ff8
        lda #$00
        sta vSpriteXMSB
        sta vSprExpandY
        ldx #$07
    L_c006:
        ldy #$00
    L_c008:
        lda $60,x
    L_c00a:
        beq L_c015
        lda vSpriteXMSB
        ora L_8a7d,y
        sta vSpriteXMSB
    L_c015:
        lda $b0,x
        bne L_c022
        lda vSprExpandY
        ora L_8a7d,y
        sta vSprExpandY
    L_c022:
        iny 
        dex 
        bpl L_c008
        lda $33
        cmp #$08
        bcc L_c06c
        lda $c0
        ldx #$75
        ldy #$c0
        jmp L_bf06
    L_c035:
        lda #$02
        sta vSpriteXMSB
        lda #$32
        sta vSprite0X
        lda #$23
        sta vSprite1X
        lda L_8679
        sta vSprite0Y
        sta vSprite1Y
        lda L_8678
        sta L_4bf8
        sta L_4bf9
        lda #$01
        sta vSpr0Col
        sta vSpr1Col
        lda #$00
        sta vSprExpandY
        lda #$e6
        ldx #$ee
        ldy #$c2
        jmp L_bf06
    L_c06c:
        lda #$00
        ldx #$54
        ldy #$bf
        jmp L_bf06
        lda vSpriteXMSB
        and #$7f
        sta vSpriteXMSB
        lda vSprExpandY
        and #$7f
        sta vSprExpandY
        lda $78
        sta vSprite7X
        lda $88
        sta vSprite7Y
        lda $a8
        sta vSpr7Col
        lda $98
        sta L_4bfa + $5
        sta L_4ff8 + $7
        lda $68
        beq L_c0a8
        lda vSpriteXMSB
        ora #$80
        sta vSpriteXMSB
    L_c0a8:
        lda $b8
        bne L_c0b4
        lda vSprExpandY
        ora #$80
        sta vSprExpandY
    L_c0b4:
        lda $33
    L_c0b6:
        cmp #$09
        bcc L_c0c3
        lda $c1
        ldx #$cc
        ldy #$c0
        jmp L_bf06
    L_c0c3:
        lda #$00
        ldx #$54
        ldy #$bf
        jmp L_bf06
        lda vSpriteXMSB
        and #$bf
        sta vSpriteXMSB
        lda vSprExpandY
        and #$bf
        sta vSprExpandY
        lda $79
        sta vSprite6X
        lda $89
        sta vSprite6Y
        lda $a9
        sta vSpr6Col
        lda $99
        sta L_4bfa + $4
        sta L_4ff8 + $6
        lda $69
        beq L_c0ff
        lda vSpriteXMSB
        ora #$40
        sta vSpriteXMSB
    L_c0ff:
        lda $b9
        bne L_c10b
        lda vSprExpandY
    L_c106:
        ora #$40
        sta vSprExpandY
    L_c10b:
        lda $33
        cmp #$0a
        bcc L_c11a
        lda $c2
        ldx #$23
        ldy #$c1
        jmp L_bf06
    L_c11a:
        lda #$00
        ldx #$54
        ldy #$bf
        jmp L_bf06
        lda vSpriteXMSB
        and #$df
        sta vSpriteXMSB
        lda vSprExpandY
        and #$df
        sta vSprExpandY
        lda $7a
        sta vSprite5X
        lda $8a
        sta vSprite5Y
        lda $aa
        sta vSpr5Col
        lda $9a
        sta L_4bfa + $3
        sta L_4ff8 + $5
        lda $6a
        beq L_c156
        lda vSpriteXMSB
        ora #$20
        sta vSpriteXMSB
    L_c156:
        lda $ba
        bne L_c162
        lda vSprExpandY
        ora #$20
        sta vSprExpandY
    L_c162:
        lda $33
        cmp #$0a
        bcc L_c171
        lda $c3
        ldx #$7a
        ldy #$c1
        jmp L_bf06
    L_c171:
        lda #$00
        ldx #$54
        ldy #$bf
        jmp L_bf06
        lda vSpriteXMSB
        and #$ef
        sta vSpriteXMSB
        lda vSprExpandY
        and #$ef
        sta vSprExpandY
        lda $7b
        sta vSprite4X
        lda $8b
        sta vSprite4Y
        lda $ab
        sta vSpr4Col
        lda $9b
        sta L_4bfa + $2
        sta L_4ff8 + $4
        lda $6b
        beq L_c1ad
        lda vSpriteXMSB
        ora #$10
        sta vSpriteXMSB
    L_c1ad:
        lda $bb
        bne L_c1b9
        lda vSprExpandY
        ora #$10
        sta vSprExpandY
    L_c1b9:
        lda $33
        cmp #$0b
        bcc L_c1c8
        lda $c4
        ldx #$d1
        ldy #$c1
        jmp L_bf06
    L_c1c8:
        lda #$00
        ldx #$54
        ldy #$bf
        jmp L_bf06
        lda vSpriteXMSB
        and #$f7
        sta vSpriteXMSB
        lda vSprExpandY
        and #$f7
        sta vSprExpandY
        lda $7c
        sta vSprite3X
        lda $8c
        sta vSprite3Y
        lda $ac
        sta vSpr3Col
        lda $9c
        sta L_4bfa + $1
        sta L_4ff8 + $3
        lda $6c
        beq L_c204
        lda vSpriteXMSB
        ora #$08
        sta vSpriteXMSB
    L_c204:
        lda $bc
        bne L_c210
        lda vSprExpandY
        ora #$08
        sta vSprExpandY
    L_c210:
        lda $33
        cmp #$0c
        bcc L_c21f
        lda $c5
        ldx #$28
        ldy #$c2
        jmp L_bf06
    L_c21f:
        lda #$00
        ldx #$54
        ldy #$bf
        jmp L_bf06
        lda vSpriteXMSB
        and #$fb
        sta vSpriteXMSB
        lda vSprExpandY
        and #$fb
        sta vSprExpandY
        lda $7d
        sta vSprite2X
        lda $8d
        sta vSprite2Y
        lda $ad
        lda #$01
        sta vSpr2Col
        lda $9d
        sta L_4bfa
        sta L_4ff8 + $2
        lda $6d
        beq L_c25d
        lda vSpriteXMSB
        ora #$04
        sta vSpriteXMSB
    L_c25d:
        lda $bd
        bne L_c269
        lda vSprExpandY
        ora #$04
        sta vSprExpandY
    L_c269:
        jmp L_c21f
    L_c26c:
        lda #$64
        sta vSprite0X
        lda #$7c
        sta vSprite1X
        lda #$94
        sta vSprite2X
        lda #$ca
        sta vSprite3X
        lda #$e2
        sta vSprite4X
        lda #$fa
        sta vSprite5X
        lda L_96df + $1
        sta vSprite0Y
        sta vSprite1Y
        sta vSprite2Y
        sta vSprite3Y
        sta vSprite4Y
        sta vSprite5Y
        lda L_968f
        sta L_4bf8
        sta L_4ff8
        lda L_968f + $1
        sta L_4bf9
    L_c2ae:
        sta L_4ff8 + $1
        lda L_968f + $2
        sta L_4bfa
        sta L_4ff8 + $2
        lda #$c6
        sta L_4bfa + $1
        sta L_4ff8 + $3
        lda #$c7
        sta L_4bfa + $2
        sta L_4ff8 + $4
        lda #$c8
        sta L_4bfa + $3
        sta L_4ff8 + $5
        lda #$00
        sta vSpriteXMSB
        lda #$04
        sta vSpr0Col
        sta vSpr1Col
        sta vSpr2Col
        sta vSpr3Col
        sta vSpr4Col
        sta vSpr5Col
        jmp L_c21f
        lda vScreenControl2
        and #$f8
        ora $27
        sta vScreenControl2
        lda #$f2
        ldx #$01
        ldy #$c3
        jmp L_bf06
        lda vScreenControl2
        and #$f8
        sta vScreenControl2
        lda #$00
        ldx #$54
        ldy #$bf
        jmp L_bf06
        lda cCia2PortA
        and #$04
        beq L_c31c
        jmp L_bf15
    L_c31c:
        rts 



    L_c31d:
         .byte $c8,$d2

    L_c31f:
        ldx $1f02,y
        stx $16,y
    L_c324:
        bmi L_c2ae
    L_c326:
        ldy $b4,x
        iny 
        iny 
        sty L_c86d + $2

        .byte $64,$aa

    L_c32f:
        .byte $82,$5a
        .byte $78,$5b,$96,$3d,$3d,$fa,$fa,$be,$aa,$fa

    L_c33b:
        .byte $fa
        .byte $98,$fe,$f0,$3c,$02,$e6,$7f,$45,$29,$29,$50

    L_c347:
        .byte $50,$82
        .byte $0a,$e6,$0b,$05,$e6

    L_c34e:
        asl cCia1DDRA,x

    L_c351:
         .byte $00,$00,$f0,$be
        .byte $be,$29,$29,$aa

    L_c359:
        ldx L_0afd + $8,y
        beq L_c326

    L_c35e:
         .byte $fa,$dc
        .byte $be,$bf,$dc,$97

    L_c364:
        and #$29
        cmp #$c9

    L_c368:
         .byte $fa,$14
        .byte $05,$32,$3d,$dc,$f0

    L_c36f:
        .byte $3c,$02,$6f,$f0,$dc
        .byte $c8

    L_c375:
        iny 
        sei 
        sei 

        .byte $00,$01,$01

    L_c37b:
        ora ($01,x)
        ora ($01,x)
        ora ($01,x)
        ora ($01,x)
        ora ($00,x)

        .byte $00,$01,$01,$01,$01,$01,$02,$01,$02,$01,$01,$02,$01,$02

    L_c393:
        .byte $02

    L_c394:
        ora ($01,x)

    L_c396:
         .byte $02,$02,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
        .byte $01,$01

    L_c3a8:
        .byte $00,$00,$00,$00,$00
        .byte $01,$00,$00,$00,$00,$00,$00,$01,$01,$02,$02,$01,$01,$01,$01,$01
        .byte $02,$01,$01

    L_c3c0:
        ora ($02,x)

        .byte $02,$02,$02,$02,$02,$02,$01,$01,$01,$01,$02,$02,$01,$01,$01,$01
        .byte $01,$02,$01,$01

    L_c3d6:
        .byte $02,$02
        .byte $01,$01,$01,$01,$01,$01,$01,$01,$02,$01,$01,$02,$01,$01,$02,$02
        .byte $01,$01,$00,$01,$01,$01,$01

    L_c3ef:
        .byte $00

    L_c3f0:
        ora ($01,x)
    L_c3f2:
        ora ($01,x)
    L_c3f4:
        ora ($01,x)
    L_c3f6:
        ora ($01,x)

    L_c3f8:
         .fill $15, $0

    L_c40d:
        ora ($00,x)

    L_c40f:
         .byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00

    L_c419:
        ora ($01,x)
    L_c41b:
        ora ($00,x)
    L_c41d:
        ora ($01,x)
    L_c41f:
        ora ($00,x)

    L_c421:
         .byte $00

    L_c422:
        ora ($01,x)

    L_c424:
         .byte $00,$00

    L_c426:
        ora ($01,x)
    L_c428:
        ora ($01,x)
    L_c42a:
        ora ($01,x)
    L_c42c:
        ora ($02,x)
    L_c42e:
        ora ($01,x)
    L_c430:
        ora ($01,x)
    L_c432:
        ora ($01,x)
    L_c434:
        ora ($01,x)
    L_c436:
        ora ($01,x)

    L_c438:
         .byte $02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02

    L_c448:
        .byte $00,$00

    L_c44a:
        ora ($00,x)
        ora ($00,x)

        .byte $00,$00,$01,$01,$00,$01,$00,$00,$00,$00,$00,$00,$00,$01,$01,$01
        .byte $00,$01,$01

    L_c461:
        ora ($01,x)
        ora ($00,x)

        .byte $00,$01,$01,$01,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$01
        .byte $01,$01,$01

    L_c478:
        ora ($02,x)

        .byte $02,$01,$02,$01,$02,$02,$02,$01,$02,$02,$01,$01,$02,$02,$00,$01
        .byte $01,$01,$00,$01,$00,$01,$00,$00,$00,$01,$00,$00,$00,$00,$01,$01
        .byte $01,$02,$01,$01,$01,$01,$01,$00,$01,$01,$00,$00

    L_c4a6:
        ora ($01,x)

        .byte $02,$02,$02,$02,$02,$02,$02,$02,$02,$01,$01,$02,$01,$01,$02,$02
        .byte $dd,$00,$60,$45,$64

    L_c4bd:
        lda ($23,x)

        .byte $b3,$a0,$0d,$5c,$82,$d2,$d2,$d2,$d2,$81,$b3,$bf,$39,$fc,$4f,$d6
        .byte $fe,$02,$a9,$5b,$4b

    L_c4d4:
        cmp $c5

        .byte $5c,$5c,$79,$5a,$b4,$a0,$c8,$bf,$c1,$ef,$a0,$dd,$bf,$c7,$a0,$a0
        .byte $0d,$0d,$be,$be,$b4,$a0,$c8,$00,$84,$6f,$a0,$9f,$bf,$64,$59,$59
        .byte $7c,$7c,$ef,$60,$16,$bf,$aa,$47,$96,$35,$98,$0f

    L_c502:
        ora $02,x
        ora ($01,x)
        and ($31),y

        .byte $8b,$b3,$be,$79,$11,$00,$d6,$3c,$3b,$9f,$98,$5b,$d2,$d2,$52,$52
        .byte $e8,$65,$15,$db,$a0,$bf,$72,$ab,$00,$db,$fc,$19,$70,$70

    L_c526:
        .byte $14,$14,$27,$00,$f0,$5c,$5b,$83,$00,$e7,$00

    L_c531:
        ora ($01,x)
        ora ($00,x)

        .byte $00,$01,$01,$01,$01,$02,$02,$02,$00,$01,$00,$00,$00,$01,$01,$01
        .byte $01

    L_c546:
        .byte $02,$02,$02,$54
        .byte $58,$74,$74,$58,$58,$4e,$62,$2e,$2e,$2e,$74,$54,$74,$74,$74,$4e
        .byte $62,$58,$58,$2e,$2e,$2e

    L_c560:
        ora ($00,x)

        .byte $00,$01,$00,$00,$01,$01,$01,$00,$00,$00,$02,$01,$01,$02,$01,$01
        .byte $01,$02,$01,$01,$02

    L_c577:
        lsr L_fa51 + $7

        .byte $5a,$a0,$fa,$32,$32,$5a,$fa,$a0,$a0,$6f,$82,$d2,$1f,$9c,$9c,$e6
        .byte $1f,$82,$d2,$1f,$01,$07,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01

    L_c59a:
        .byte $07,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$7c
        .byte $6c,$9c,$9c,$9c,$9c,$9c,$9c,$9c,$9c,$9c,$9c,$74,$98,$98,$98,$98
        .byte $98,$98,$98,$98,$98,$98,$98

    L_c5bd:
        .byte $00,$00
        .byte $01,$00,$00,$00,$00,$01,$00,$02,$00,$01,$00

    L_c5ca:
        .byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00
        .byte $01,$01,$00,$00,$01,$00,$00,$01,$01

    L_c5dd:
        .byte $00,$00,$00
        .byte $01,$01,$01,$01,$01,$01,$01,$00,$01,$00

    L_c5ea:
        .byte $00,$00,$00,$02,$02
        .byte $01,$01,$01,$01,$01,$01,$01,$01,$01,$01

    L_c5f9:
        .byte $00,$00,$00,$02,$00,$00,$00,$00,$00
        .byte $01,$00,$00,$01,$00

    L_c607:
        .byte $00,$00,$00,$00,$00,$00,$02
        .byte $01,$01,$01,$01,$01,$01,$01,$02,$01,$01,$01,$01,$01,$01,$01,$01
        .byte $01,$01,$01,$01,$01,$01,$01,$01,$02,$02,$02,$01,$01,$01,$01

    L_c62d:
        ora ($02,x)

        .byte $02,$01,$02,$02,$01,$01,$01,$02,$01,$01,$01,$01,$01,$01

    L_c63d:
        ora ($01,x)

        .byte $02,$02,$02,$02,$01,$01,$02,$01,$02,$01,$01,$01,$01,$01,$00,$01
        .byte $00

    L_c650:
        .fill $13, $0
        .byte $01,$00

    L_c665:
        .byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
        .byte $01,$00,$00,$00,$00,$00,$00,$00,$01,$01

    L_c67b:
        .byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
        .byte $01,$00,$00,$00,$00

    L_c68d:
        ora ($01,x)
        ora ($01,x)

        .byte $00,$00,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01

    L_c69d:
        ora ($01,x)
        ora ($01,x)
        ora ($00,x)
        ora ($01,x)

        .byte $02,$02,$01,$02,$00,$02,$01,$01

    L_c6ad:
        ora ($01,x)
        ora ($01,x)
        ora ($01,x)
        ora ($01,x)
        ora ($01,x)
        ora ($01,x)

    L_c6b9:
         .byte $02,$02,$00,$00,$00,$00,$00,$00,$00,$00,$00
        .byte $01,$01

    L_c6c6:
        .byte $00
        .byte $01,$01,$02,$02,$01,$01

    L_c6cd:
        ora ($02,x)
        ora ($02,x)

        .byte $02,$01,$02,$02,$01,$02,$02,$01,$01,$01,$02,$02

    L_c6dd:
        ora ($01,x)

        .byte $02,$02,$01,$01,$01,$01,$01,$01,$01,$01,$02,$02,$01,$01

    L_c6ed:
        ora ($02,x)

        .byte $02,$02,$02,$01,$01,$02,$02,$01,$01,$01,$00,$00,$01,$01

    L_c6fd:
        ldy $8c,x
        plp 
        ldy #$64
    L_c702:
        sei 
        tax 

        .byte $14,$8c,$0a,$9f,$c8,$be,$be,$83

    L_c70c:
        .byte $83,$64,$50,$be
        .byte $be,$64,$82,$5a,$6e,$29,$5a,$9e,$3d,$84,$84,$32,$32

    L_c71d:
        dec $f064,x
        ora $0a

        .byte $50,$14,$0b,$14,$0a,$c8

    L_c728:
        .byte $00
        .byte $f1,$f1,$64,$64

    L_c72d:
        asl 

        .byte $32,$78,$8c,$7d,$78,$50,$85,$be,$64,$a0

    L_c738:
        .byte $63,$b3,$b3,$30,$88,$f0,$c8,$64
        .byte $be,$f0,$0a,$f0,$6f,$a0,$fa,$fa,$be,$dd,$dd,$f9,$f9,$1e,$64,$c8
        .byte $3d,$2a,$64,$be,$8d,$01,$9f,$64,$78,$c7,$c7,$83,$83

    L_c75d:
        cpy #$f0
    L_c75f:
        ldy $8c,x
        ldx L_f035 + $8,y
        inc $e6

        .byte $14,$1e,$28,$c7,$c7,$b3,$b3

    L_c76d:
        adc $00

        .byte $3c,$c8,$0a,$0a

    L_c773:
        iny 
        bcs L_c702

        .byte $02,$f0,$be,$b3,$b3,$77,$77

    L_c77d:
        iny 

        .byte $c3,$0a,$3c,$0a,$0a,$a0,$64,$02,$f0,$28,$e6,$a0,$a0,$c8,$c8

    L_c78d:
        sta ($15,x)

        .byte $82,$5a,$96,$64,$c7,$8c,$5a,$78,$6e,$6f,$aa,$aa,$b3,$b3

    L_c79d:
        iny 

        .byte $70,$be,$b4,$aa,$be,$3d,$be,$6f,$be,$be,$6e,$e6,$e6,$c8,$c8

    L_c7ad:
        ldx L_a0bf,y

        .byte $d2,$14,$8c,$96,$aa,$de,$78,$a0,$be,$14,$14

    L_c7bb:
        .byte $bf,$bf,$64,$64,$82
        .byte $6e,$dc,$be,$78,$64,$5a,$64,$6f,$69,$c8,$c8,$8e,$8e,$3e,$02

    L_c7cf:
        rol 

        .byte $82,$f0,$8c,$82,$64,$6f,$78,$32,$63,$8d,$8d,$aa,$aa

    L_c7dd:
        ldx L_6ce6,y
        stx $82,y
        iny 

        .byte $d2,$be,$02,$1f,$96,$16,$30,$88

    L_c7eb:
        ldy $b4,x
    L_c7ed:
        iny 
        iny 
        sty L_c86d + $2

        .byte $64,$aa,$82,$5a,$78,$5b,$96,$3d,$3d,$fa,$fa

    L_c7fd:
        ldx L_faa1 + $9,y

        .byte $fa,$98,$fe,$f0,$3c,$02,$e6,$7f,$45,$29,$29,$50

    L_c80c:
        .byte $50,$82
        .byte $0a,$e6,$0b,$05,$e6,$1e,$02,$dc,$00,$00,$f0,$be,$be,$29,$29

    L_c81d:
        tax 
        ldx L_0afd + $8,y
        beq L_c7eb

        .byte $fa,$dc,$be,$bf,$dc,$97,$29,$29,$c9,$c9

    L_c82d:
        .byte $fa,$14
        .byte $05,$32,$3d,$dc,$f0,$3c,$02,$6f,$f0,$dc,$c8,$c8,$78,$78

    L_c83d:
        .byte $00
        .byte $01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$00,$00,$01,$01

    L_c84d:
        ora ($01,x)
        ora ($02,x)
        ora ($02,x)
        ora ($01,x)

        .byte $02,$01,$02,$02,$01,$01

    L_c85b:
        .byte $02,$02,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
        .byte $01,$01

    L_c86d:
        .byte $00,$00,$00,$00,$00
        .byte $01,$00,$00,$00,$00,$00,$00,$01,$01,$02,$02

    L_c87d:
        ora ($01,x)
        ora ($01,x)
        ora ($02,x)
        ora ($01,x)
        ora ($02,x)

        .byte $02,$02,$02,$02,$02,$02

    L_c88d:
        ora ($01,x)
        ora ($01,x)

        .byte $02,$02,$01,$01,$01,$01,$01,$02,$01,$01,$02,$02

    L_c89d:
        ora ($01,x)
        ora ($01,x)
        ora ($01,x)
        ora ($01,x)

        .byte $02,$01,$01,$02,$01,$01,$02,$02

    L_c8ad:
        ora ($01,x)

        .byte $00,$01,$01,$01,$01,$00,$01,$01,$01,$01,$01,$01,$01,$01

    L_c8bd:
        .fill $15, $0
        .byte $01,$00

    L_c8d4:
        .byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00
        .byte $01,$01,$01,$00,$01,$01,$01,$00,$00,$01,$01,$00,$00,$01,$01

    L_c8ed:
        ora ($01,x)
        ora ($01,x)
        ora ($02,x)
        ora ($01,x)
        ora ($01,x)
        ora ($01,x)
        ora ($01,x)
        ora ($01,x)

    L_c8fd:
         .byte $02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02

    L_c90d:
        .byte $00,$00
        .byte $01,$00,$01,$00,$00,$00,$01,$01,$00,$01,$00

    L_c91a:
        .byte $00,$00,$00,$00,$00,$00
        .byte $01,$01,$01,$00,$01,$01,$01,$01,$01,$00,$00,$01,$01

    L_c92d:
        ora ($02,x)

        .byte $02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$01,$01,$01,$01

    L_c93d:
        ora ($02,x)

        .byte $02,$01,$02,$01,$02,$02,$02,$01,$02,$02,$01,$01

    L_c94b:
        .byte $02,$02,$00
        .byte $01,$01,$01,$00,$01,$00,$01,$00,$00,$00,$01,$00,$00,$00,$00

    L_c95d:
        ora ($01,x)
        ora ($02,x)
        ora ($01,x)
        ora ($01,x)
        ora ($00,x)
        ora ($01,x)

        .byte $00,$00,$01,$01

    L_c96d:
        .byte $02,$02,$02,$02,$02,$02,$02,$02,$02
        .byte $01,$01,$02,$01,$01,$02,$02

    L_c97d:
        cmp L_5ffe + $2,x
        eor $64
        lda ($23,x)

        .byte $b3,$a0,$0d,$5c,$82,$d2,$d2,$d2,$d2

    L_c98d:
        sta ($b3,x)

        .byte $bf,$39,$fc,$4f,$d6,$fe,$02,$a9,$5b,$4b,$c5,$c5,$5c,$5c

    L_c99d:
        adc $b45a,y
        ldy #$c8

        .byte $bf,$c1,$ef,$a0,$dd,$bf,$c7,$a0,$a0,$0d,$0d,$be,$be,$b4,$a0,$c8
        .byte $00,$84,$6f,$a0,$9f,$bf,$64,$59,$59,$7c

    L_c9bc:
        .byte $7c,$ef
        .byte $60,$16,$bf,$aa,$47,$96,$35,$98,$0f,$15,$02,$01,$01,$31,$31

    L_c9cd:
        .byte $8b,$b3
        .byte $be,$79,$11,$00,$d6,$3c,$3b,$9f,$98,$5b,$d2,$d2,$52,$52

    L_c9dd:
        inx 
        adc $15

        .byte $db,$a0,$bf,$72,$ab,$00,$db,$fc,$19,$70,$70

    L_c9eb:
        .byte $14,$14,$27,$00,$f0,$5c,$5b,$83,$00,$e7,$00
        .byte $15,$27,$38

    L_c9f9:
        .byte $00,$00,$7b,$7b,$77
        .byte $a9,$a0,$c9,$64,$9f,$79,$96,$66,$5b,$9a,$d2,$6f,$6f,$dd,$dd,$85
        .byte $9f,$a0,$c7,$64,$01,$81,$70,$66,$65,$aa,$5c,$5c,$5c,$9f,$9f

    L_ca1d:
        tya 
        rol 
        eor $02

        .byte $d2,$bf,$1a,$1d,$c8,$e6,$1d,$3e,$64,$64,$00,$00

    L_ca2d:
        jmp L_a0bf

        .byte $b4,$fb,$01,$97,$ab,$ab,$4c,$be,$b6

    L_ca39:
        .byte $61,$61,$fa,$fa,$63,$4f
        .byte $19,$3b,$5b,$5b,$5a,$15,$64,$3d,$41,$3f,$1e,$1e,$47

    L_ca4c:
        .byte $47,$c7
        .byte $c0,$84,$b5,$76,$bf,$97,$dd,$4f,$be,$dd,$02,$a0,$a0,$8d,$8d,$97
        .byte $61,$c9,$bf,$3d,$4f,$be,$16,$3b,$85,$5b,$22,$50,$50,$3b,$3b

    L_ca6d:
        cpx L_18c5 + $3d

        .byte $44,$02,$5b,$02,$15,$5b,$45,$23,$4f,$3d,$3d,$9f,$9f

    L_ca7d:
        cpx L_5af9 + $a

        .byte $fa,$03,$47,$03,$5a,$19,$d6,$4f,$0f,$f1,$f1,$51,$51

    L_ca8d:
        .byte $e7,$02
        .byte $20,$20,$dc,$01,$6f,$be,$bf,$97,$c8,$5c,$6f,$6f,$d2,$d2

    L_ca9d:
        eor $81

        .byte $ab,$09,$c0,$97,$97,$c8,$e0,$e6,$a9,$d3

    L_caa9:
        .byte $d4,$d4,$d2,$d2,$64,$5a
        .byte $65,$63

    L_cab1:
        .byte $4f,$02,$64,$64,$1a,$f0,$f1,$37
        .byte $bd,$bd,$3e,$3e,$1f,$c3,$36,$c3,$cc,$b7,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff

    L_cc94:
        .byte $ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff
        .byte $ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff
        .byte $ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff

    L_ccc4:
        .byte $ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff
        .byte $ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff
        .byte $ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff
        .byte $ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00

    L_cdc4:
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$00,$00,$ff,$ff
        .byte $ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff
        .byte $ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff
        .byte $ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff
        .byte $ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff
        .byte $ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff
        .byte $ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff
        .byte $ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff
        .byte $ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff
        .byte $ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff
        .byte $ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff
        .byte $ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff
        .byte $ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff

    L_cec4:
        .byte $ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff
        .byte $ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff
        .byte $ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff
        .byte $ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$32,$83,$23,$83
        .byte $d0,$e9,$7a,$38,$e6,$ef,$a3,$f0,$06,$20,$00,$c9,$02,$90,$33,$d1
        .byte $00,$03,$d0,$00,$21,$72,$f1,$01,$03,$00,$00,$03,$f6,$f6,$f2,$f7
        .byte $f3,$fb,$f0,$f1,$f1,$f0,$f0,$f0,$fb,$f0,$f0
        .fill $11, $ff
        .byte $32,$83,$23,$83,$d0,$e9,$7a,$38,$e6,$ef,$a3,$f0,$06,$20,$00,$c9
        .byte $02,$90,$33

    L_d053:
        cmp ($00),y

        .byte $03,$d0,$00

    L_d058:
        and ($72,x)
        sbc ($01),y

        .byte $03,$00,$00,$03,$f6,$f6,$f2,$f7,$f3,$fb,$f0,$f1,$f1,$f0,$f0,$f0
        .byte $fb,$f0,$f0
        .fill $11, $ff
        .byte $32,$83,$23,$83,$d0,$e9,$7a,$38,$e6,$ef,$a3,$f0,$06,$20,$00,$c9
        .byte $02,$90,$33

    L_d093:
        cmp ($00),y

        .byte $03,$d0,$00

    L_d098:
        and ($72,x)
        sbc ($01),y

        .byte $03,$00,$00,$03,$f6,$f6,$f2,$f7,$f3,$fb,$f0,$f1,$f1,$f0,$f0,$f0
        .byte $fb,$f0,$f0

    L_d0af:
        .fill $11, $ff

    L_d0c0:
        .byte $32,$83,$23,$83,$d0,$e9,$7a
        .byte $38,$e6,$ef,$a3,$f0,$06,$20,$00,$c9,$02,$90,$33

    L_d0d3:
        cmp ($00),y

        .byte $03,$d0,$00

    L_d0d8:
        and ($72,x)
        sbc ($01),y

        .byte $03,$00,$00,$03,$f6,$f6,$f2,$f7,$f3,$fb,$f0,$f1,$f1,$f0,$f0,$f0
        .byte $fb,$f0,$f0
        .fill $11, $ff
        .byte $32,$83,$23,$83,$d0,$e9,$7a,$38,$e6,$ef,$a3,$f0,$06,$20,$00,$c9
        .byte $02,$90,$33

    L_d113:
        cmp ($00),y

        .byte $03,$d0,$00

    L_d118:
        and ($72,x)
        sbc ($01),y

        .byte $03,$00,$00,$03,$f6,$f6,$f2,$f7,$f3,$fb,$f0,$f1,$f1,$f0,$f0,$f0
        .byte $fb,$f0,$f0
        .fill $11, $ff
        .byte $32,$83,$23,$83,$d0,$e9,$7a,$38,$e6,$ef,$a3,$f0,$06,$20,$00,$c9
        .byte $02,$90,$33

    L_d153:
        cmp ($00),y

        .byte $03,$d0,$00

    L_d158:
        and ($72,x)
        sbc ($01),y

        .byte $03,$00,$00,$03,$f6,$f6,$f2,$f7,$f3,$fb,$f0,$f1,$f1,$f0,$f0,$f0
        .byte $fb,$f0,$f0
        .fill $11, $ff
        .byte $32,$83,$23,$83,$d0,$e9,$7a,$38,$e6,$ef,$a3,$f0,$06,$20,$00,$c9
        .byte $02,$90,$33

    L_d193:
        cmp ($00),y

        .byte $03,$d0,$00

    L_d198:
        and ($72,x)
        sbc ($01),y

        .byte $03,$00,$00,$03,$f6,$f6,$f2,$f7,$f3,$fb,$f0,$f1,$f1,$f0,$f0,$f0
        .byte $fb,$f0,$f0
        .fill $11, $ff
        .byte $32,$83,$23,$83,$d0,$e9,$7a,$38,$e6,$ef

    L_d1ca:
        .byte $a3
        .byte $f0,$06,$20,$00,$c9,$02,$90,$33

    L_d1d3:
        cmp ($00),y

        .byte $03,$d0,$00

    L_d1d8:
        and ($72,x)
        sbc ($01),y

        .byte $03,$00,$00,$03,$f6,$f6,$f2,$f7,$f3,$fb,$f0,$f1,$f1,$f0,$f0,$f0
        .byte $fb,$f0,$f0
        .fill $11, $ff
        .byte $32,$83,$23,$83,$d0,$e9,$7a,$38,$e6,$ef,$a3,$f0,$06,$20,$00,$c9
        .byte $02,$90,$33

    L_d213:
        cmp ($00),y

        .byte $03,$d0,$00

    L_d218:
        and ($72,x)
        sbc ($01),y

        .byte $03,$00,$00,$03,$f6,$f6,$f2,$f7,$f3,$fb,$f0,$f1,$f1,$f0,$f0,$f0
        .byte $fb,$f0,$f0
        .fill $11, $ff
        .byte $32,$83,$23,$83,$d0,$e9,$7a,$38,$e6,$ef,$a3,$f0,$06,$20,$00,$c9
        .byte $02,$90,$33

    L_d253:
        cmp ($00),y

        .byte $03,$d0,$00

    L_d258:
        and ($72,x)
        sbc ($01),y

        .byte $03,$00,$00,$03,$f6,$f6,$f2,$f7,$f3,$fb,$f0,$f1,$f1,$f0,$f0,$f0
        .byte $fb,$f0,$f0
        .fill $11, $ff
        .byte $32,$83,$23,$83,$d0,$e9,$7a,$38,$e6,$ef,$a3,$f0,$06,$20,$00,$c9
        .byte $02,$90,$33

    L_d293:
        cmp ($00),y

        .byte $03,$d0,$00

    L_d298:
        and ($72,x)
        sbc ($01),y

        .byte $03,$00,$00,$03,$f6,$f6,$f2,$f7,$f3,$fb,$f0,$f1,$f1,$f0,$f0,$f0
        .byte $fb,$f0,$f0
        .fill $11, $ff
        .byte $32,$83,$23,$83,$d0,$e9,$7a,$38,$e6,$ef,$a3,$f0,$06,$20,$00,$c9
        .byte $02,$90,$33

    L_d2d3:
        cmp ($00),y

        .byte $03,$d0,$00

    L_d2d8:
        and ($72,x)
        sbc ($01),y

        .byte $03,$00,$00,$03,$f6,$f6,$f2,$f7,$f3,$fb,$f0,$f1,$f1,$f0,$f0,$f0
        .byte $fb,$f0,$f0
        .fill $11, $ff
        .byte $32,$83,$23,$83,$d0,$e9,$7a,$38,$e6,$ef,$a3,$f0,$06,$20,$00,$c9
        .byte $02,$90,$33

    L_d313:
        cmp ($00),y

        .byte $03,$d0,$00

    L_d318:
        and ($72,x)
        sbc ($01),y

        .byte $03,$00,$00,$03,$f6,$f6,$f2,$f7,$f3,$fb,$f0,$f1,$f1,$f0,$f0,$f0
        .byte $fb,$f0,$f0
        .fill $11, $ff
        .byte $32,$83,$23,$83,$d0,$e9,$7a,$38,$e6,$ef,$a3,$f0,$06,$20,$00,$c9
        .byte $02,$90,$33

    L_d353:
        cmp ($00),y

        .byte $03,$d0,$00

    L_d358:
        and ($72,x)
        sbc ($01),y

        .byte $03,$00,$00,$03,$f6,$f6,$f2,$f7,$f3,$fb,$f0,$f1,$f1,$f0,$f0,$f0
        .byte $fb,$f0,$f0
        .fill $11, $ff
        .byte $32,$83,$23,$83,$d0,$e9,$7a,$38,$e6,$ef,$a3,$f0,$06,$20,$00,$c9
        .byte $02,$90,$33

    L_d393:
        cmp ($00),y

        .byte $03,$d0,$00

    L_d398:
        and ($72,x)
        sbc ($01),y

        .byte $03,$00,$00,$03,$f6,$f6,$f2,$f7,$f3,$fb,$f0,$f1,$f1,$f0,$f0,$f0
        .byte $fb,$f0,$f0
        .fill $11, $ff
        .byte $32,$83,$23,$83,$d0,$e9,$7a,$38,$e6,$ef,$a3,$f0,$06,$20,$00,$c9
        .byte $02,$90,$33

    L_d3d3:
        cmp ($00),y

        .byte $03,$d0,$00

    L_d3d8:
        and ($72,x)
        sbc ($01),y

        .byte $03,$00,$00,$03,$f6,$f6,$f2,$f7,$f3,$fb,$f0,$f1,$f1,$f0,$f0,$f0
        .byte $fb,$f0,$f0
        .fill $11, $ff
        .byte $d1,$06,$00,$08,$10,$08,$45,$30,$0b,$00,$08,$41,$08,$79,$00,$00
        .byte $00,$00,$00,$00,$00,$00,$a0,$f2,$1f,$00,$00,$00,$00,$00,$00,$00
        .byte $d1,$06,$00,$08,$10,$08,$45,$30,$0b,$00,$08,$41,$08,$79,$00,$00
        .byte $00,$00,$00,$00,$00,$00,$a0,$f2,$1f,$00,$00,$00,$00,$00,$00,$00
        .byte $d1,$06,$00,$08,$10,$08,$45,$30,$0b,$00,$08,$41,$08,$79,$00,$00
        .byte $00,$00,$00,$00,$00,$00,$a0,$f2,$1f,$00,$00,$00,$00,$00,$00,$00
        .byte $d1,$06,$00,$08,$10,$08,$45,$30,$0b,$00,$08,$41,$08,$79,$00,$00
        .byte $00,$00,$00,$00,$00,$00,$a0,$f2,$1f,$00,$00,$00,$00,$00,$00,$00
        .byte $d1,$06,$00,$08,$10,$08,$45,$30,$0b,$00,$08,$41,$08,$79,$00,$00
        .byte $00,$00,$00,$00,$00,$00,$a0,$f2,$1f,$00,$00,$00,$00,$00,$00,$00
        .byte $d1,$06,$00,$08,$10,$08,$45,$30,$0b,$00,$08,$41,$08,$79,$00,$00
        .byte $00,$00,$00,$00,$00,$00,$a0,$f2,$1f,$00,$00,$00,$00,$00,$00,$00
        .byte $d1,$06,$00,$08,$10,$08

    L_d4c6:
        eor $30

    L_d4c8:
         .byte $0b,$00
        .byte $08,$41,$08,$79,$00,$00,$00,$00,$00,$00,$00,$00,$a0,$f2,$1f,$00
        .byte $00,$00,$00,$00,$00,$00,$d1,$06,$00,$08,$10,$08,$45,$30,$0b,$00
        .byte $08,$41,$08,$79,$00,$00,$00,$00,$00,$00,$00,$00,$a0,$f2,$1f,$00
        .byte $00,$00,$00,$00,$00,$00,$d1,$06,$00,$08,$10,$08,$45,$30,$0b,$00
        .byte $08,$41,$08,$79,$00,$00,$00,$00,$00,$00,$00,$00,$a0,$f2,$1f,$00
        .byte $00,$00,$00,$00,$00,$00,$d1,$06,$00,$08,$10,$08,$45,$30,$0b,$00
        .byte $08,$41,$08,$79,$00,$00,$00,$00,$00,$00,$00,$00,$a0,$f2,$1f,$00
        .byte $00,$00,$00,$00,$00,$00,$d1,$06,$00,$08,$10,$08,$45,$30,$0b,$00
        .byte $08,$41,$08,$79,$00,$00,$00,$00,$00,$00,$00,$00,$a0,$f2,$1f,$00
        .byte $00,$00,$00,$00,$00,$00,$d1,$06,$00,$08,$10,$08,$45,$30,$0b,$00
        .byte $08,$41,$08,$79,$00,$00,$00,$00,$00,$00,$00,$00,$a0,$f2,$1f,$00
        .byte $00,$00,$00,$00,$00,$00,$d1,$06,$00,$08,$10,$08,$45,$30,$0b,$00
        .byte $08,$41,$08,$79,$00,$00,$00,$00,$00,$00,$00,$00,$a0,$f2,$1f,$00
        .byte $00,$00,$00,$00,$00,$00,$d1,$06,$00,$08,$10,$08,$45,$30,$0b,$00
        .byte $08,$41,$08,$79,$00,$00,$00,$00,$00,$00,$00,$00,$a0,$f2,$1f,$00
        .byte $00,$00,$00,$00,$00,$00,$d1,$06,$00,$08,$10,$08,$45,$30,$0b,$00
        .byte $08,$41,$08,$79,$00,$00,$00,$00,$00,$00,$00,$00,$a0,$f2,$1f,$00
        .byte $00,$00,$00,$00,$00,$00,$d1,$06,$00,$08,$10,$08,$45,$30,$0b,$00
        .byte $08,$41,$08,$79,$00,$00,$00,$00,$00,$00,$00,$00,$a0,$f2,$1f,$00
        .byte $00,$00,$00,$00,$00,$00,$d1,$06,$00,$08,$10,$08,$45,$30,$0b,$00
        .byte $08,$41,$08,$79,$00,$00,$00,$00,$00,$00,$00,$00,$a0,$f2,$1f,$00
        .byte $00,$00,$00,$00,$00,$00,$d1,$06,$00,$08,$10,$08,$45,$30,$0b,$00
        .byte $08,$41,$08,$79,$00,$00,$00,$00,$00,$00,$00,$00,$a0,$f2,$1f,$00
        .byte $00,$00,$00,$00,$00,$00,$d1,$06,$00,$08,$10,$08,$45,$30,$0b,$00
        .byte $08,$41,$08,$79,$00,$00,$00,$00,$00,$00,$00,$00,$a0,$f2,$1f,$00
        .byte $00,$00,$00,$00,$00,$00,$d1,$06,$00,$08,$10,$08,$45,$30,$0b,$00
        .byte $08,$41,$08,$79,$00,$00,$00,$00,$00,$00,$00,$00,$a0,$f2,$1f,$00
        .byte $00,$00,$00,$00,$00,$00,$d1,$06,$00

    L_d683:
        php 

        .byte $10,$08,$45,$30,$0b,$00,$08,$41,$08,$79,$00,$00,$00,$00,$00,$00
        .byte $00,$00,$a0,$f2,$1f,$00,$00,$00,$00,$00,$00,$00,$d1,$06,$00,$08

    L_d6a4:
        .byte $10,$08
        .byte $45,$30,$0b,$00,$08,$41,$08,$79,$00,$00,$00,$00,$00,$00,$00,$00
        .byte $a0,$f2,$1f,$00,$00,$00,$00,$00,$00,$00,$d1,$06,$00,$08,$10,$08
        .byte $45,$30,$0b,$00,$08,$41,$08,$79,$00,$00,$00,$00,$00,$00,$00,$00
        .byte $a0,$f2,$1f,$00,$00,$00,$00,$00,$00,$00,$d1,$06,$00,$08,$10,$08
        .byte $45,$30,$0b,$00,$08,$41,$08,$79,$00,$00,$00,$00,$00,$00,$00,$00
        .byte $a0,$f2,$1f,$00,$00,$00,$00,$00,$00,$00,$d1,$06,$00,$08,$10,$08
        .byte $45,$30,$0b,$00,$08,$41,$08,$79,$00,$00,$00,$00,$00,$00,$00,$00
        .byte $a0,$f2,$1f,$00,$00,$00,$00,$00,$00,$00,$d1,$06,$00,$08,$10,$08
        .byte $45,$30,$0b,$00,$08,$41,$08,$79,$00,$00,$00,$00,$00,$00,$00,$00
        .byte $a0,$f2,$1f,$00,$00,$00,$00,$00,$00,$00,$d1,$06,$00,$08,$10,$08
        .byte $45,$30,$0b,$00,$08,$41,$08,$79,$00,$00,$00,$00,$00,$00,$00,$00
        .byte $a0,$f2,$1f,$00,$00,$00,$00,$00,$00,$00,$d1,$06,$00,$08,$10,$08
        .byte $45,$30,$0b,$00,$08,$41,$08,$79,$00,$00,$00,$00,$00,$00,$00,$00
        .byte $a0,$f2,$1f,$00,$00,$00,$00,$00,$00,$00,$d1,$06,$00,$08,$10,$08
        .byte $45,$30,$0b,$00,$08,$41,$08,$79,$00,$00,$00,$00,$00,$00,$00,$00
        .byte $a0,$f2,$1f,$00,$00,$00,$00,$00,$00,$00,$d1,$06,$00,$08,$10,$08
        .byte $45,$30,$0b,$00,$08,$41,$08,$79,$00,$00,$00,$00,$00,$00,$00,$00
        .byte $a0,$f2,$1f,$00,$00,$00,$00,$00,$00,$00,$d1,$06,$00,$08,$10,$08
        .byte $45,$30,$0b,$00,$08,$41,$08,$79,$00,$00,$00,$00,$00,$00,$00,$00
        .byte $a0,$f2,$1f,$00,$00,$00,$00,$00,$00,$00,$d1,$06,$00,$08,$10,$08
        .byte $45,$30,$0b,$00,$08,$41,$08,$79,$00,$00,$00,$00,$00,$00,$00,$00
        .byte $a0,$f2,$1f,$00,$00,$00,$00,$00,$00,$00
        .fill $78, $f1
        .fill $140, $fa
        .fill $15c, $f1

    L_db14:
        sbc ($f1),y
    L_db16:
        sbc ($f1),y
    L_db18:
        sbc ($f1),y
    L_db1a:
        sbc ($f1),y
    L_db1c:
        sbc ($f1),y
    L_db1e:
        sbc ($f1),y
    L_db20:
        sbc ($f0),y
    L_db22:
        beq L_db14
    L_db24:
        beq L_db16
    L_db26:
        beq L_db18
    L_db28:
        beq L_db1a
    L_db2a:
        beq L_db1c
    L_db2c:
        beq L_db1e
    L_db2e:
        beq L_db20
    L_db30:
        beq L_db22
    L_db32:
        beq L_db24
    L_db34:
        beq L_db26
    L_db36:
        beq L_db28
    L_db38:
        beq L_db2a
        beq L_db2c
        beq L_db2e
        beq L_db30
        beq L_db32
        beq L_db34
        beq L_db36
        beq L_db38
        sbc ($f1),y
        sbc ($f1),y
        sbc ($f1),y
        sbc ($f1),y
        sbc ($f1),y
        sbc ($f1),y
        sbc ($f1),y
        sbc ($f1),y
        sbc ($f1),y
        sbc ($f1),y
        sbc ($f1),y
        sbc ($f1),y
        sbc ($f1),y
        sbc ($f1),y
        sbc ($f1),y
        sbc ($f1),y
        sbc ($f1),y
        sbc ($f1),y
        sbc ($f1),y
        sbc ($f1),y
        sbc ($f1),y
        sbc ($f1),y
        sbc ($f1),y
        sbc ($f1),y
        sbc ($f1),y
        sbc ($f1),y
        sbc ($f1),y
        sbc ($f1),y
        sbc ($f1),y
        sbc ($f1),y
        sbc ($f1),y
        sbc ($f1),y
        sbc ($f1),y
        sbc ($f1),y
        sbc ($f1),y
        sbc ($f1),y
        sbc ($f1),y
        sbc ($f1),y
        sbc ($f1),y
        sbc ($f1),y
        sbc ($f1),y
        sbc ($f1),y
        sbc ($f1),y
        sbc ($f1),y
        sbc ($f1),y
        sbc ($f1),y
        sbc ($f1),y
        sbc ($f1),y
        sbc ($f1),y
        sbc ($f1),y
        sbc ($f1),y
        sbc ($f1),y
        sbc ($f1),y
        sbc ($f1),y
        sbc ($f1),y
        sbc ($f1),y
        sbc ($f1),y
        sbc ($f1),y
        sbc ($f1),y
        sbc ($f1),y
        sbc ($f1),y
        sbc ($f1),y
        sbc ($f1),y
        sbc ($f1),y
        sbc ($f1),y
        sbc ($f1),y
        sbc ($f1),y
        sbc ($f1),y
        sbc ($f1),y
        sbc ($f1),y
        sbc ($f1),y
        sbc ($f1),y
        sbc ($f1),y
        sbc ($f1),y
        sbc ($f1),y
        sbc ($f1),y
        sbc ($f1),y
        sbc ($f1),y
        sbc ($f1),y
        sbc ($f1),y
        sbc ($f1),y
        sbc ($f1),y
        sbc ($f1),y
        sbc ($f1),y
        sbc ($f1),y
        sbc ($f1),y
        sbc ($f1),y
        sbc ($f1),y
        sbc ($f1),y
        sbc ($f1),y
        sbc ($f1),y
        sbc ($f1),y

        .byte $7f,$ff,$ff,$00,$64,$3d,$ff,$ff,$00,$00,$00,$01,$00,$01,$00,$08
        .byte $7f,$ff,$ff,$00,$64,$3d,$ff,$ff,$00,$00,$00,$01,$00,$01,$00,$08

    L_dc20:
        .byte $7f,$ff,$ff,$00,$64
        .byte $3d,$ff,$ff,$00,$00,$00,$01,$00,$01,$00,$08,$7f,$ff,$ff,$00,$64
        .byte $3d,$ff,$ff,$00,$00,$00,$01,$00,$01,$00,$08,$7f,$ff,$ff,$00,$64
        .byte $3d,$ff,$ff,$00,$00,$00,$01,$00,$01,$00,$08,$7f,$ff,$ff,$00,$64
        .byte $3d,$ff,$ff,$00,$00,$00,$01,$00,$01,$00,$08,$7f,$ff,$ff,$00,$64
        .byte $3d,$ff,$ff,$00,$00,$00,$01,$00,$01,$00,$08,$7f,$ff,$ff,$00,$64
        .byte $3d,$ff,$ff,$00,$00,$00,$01,$00,$01,$00,$08,$7f,$ff,$ff,$00,$64
        .byte $3d,$ff,$ff,$00,$00,$00,$01,$00,$01,$00,$08,$7f,$ff,$ff,$00,$64
        .byte $3d,$ff,$ff,$00,$00,$00,$01,$00,$01,$00,$08,$7f,$ff,$ff,$00,$64
        .byte $3d,$ff,$ff,$00,$00,$00,$01,$00,$01,$00,$08,$7f,$ff,$ff,$00,$64
        .byte $3d,$ff,$ff,$00,$00,$00,$01,$00,$01,$00

    L_dcbf:
        php 

        .byte $7f,$ff,$ff,$00,$64,$3d,$ff,$ff,$00,$00,$00,$01,$00,$01,$00,$08
        .byte $7f,$ff,$ff,$00,$64,$3d,$ff,$ff,$00,$00,$00,$01,$00,$01,$00,$08
        .byte $7f,$ff,$ff,$00,$64,$3d,$ff,$ff,$00,$00,$00,$01,$00,$01,$00,$08
        .byte $7f,$ff,$ff,$00,$64,$3d,$ff,$ff,$00,$00,$00,$01,$00,$01,$00,$08
        .byte $c2,$ff,$3f,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$01,$00,$00,$08,$08
        .byte $c2,$ff,$3f,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$01,$00,$00,$08,$08
        .byte $c2,$ff,$3f,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$01,$00,$00,$08,$08
        .byte $c2,$ff,$3f,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$01,$00,$00,$08,$08
        .byte $c2,$ff,$3f,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$01,$00,$00,$08,$08
        .byte $c2,$ff,$3f,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$01,$00,$00,$08,$08
        .byte $c2,$ff,$3f,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$01,$00,$00,$08,$08
        .byte $c2,$ff,$3f,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$01,$00,$00,$08,$08
        .byte $c2,$ff,$3f,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$01,$00,$00,$08,$08
        .byte $c2,$ff,$3f,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$01,$00,$00,$08,$08
        .byte $c2,$ff,$3f,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$01,$00,$00,$08,$08
        .byte $c2,$ff,$3f,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$01,$00,$00,$08,$08
        .byte $c2,$ff,$3f,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$01,$00,$00,$08,$08
        .byte $c2,$ff,$3f,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$01,$00

    L_dddd:
        .byte $00
        .byte $08,$08,$c2,$ff,$3f,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$01,$00,$00
        .byte $08,$08,$c2,$ff,$3f,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$01,$00,$00
        .byte $08,$08

    L_de00:
        .fill $200, $ff

    L_e000:
        jmp L_e606
    L_e003:
        jmp L_e080

    L_e006:
         .byte $04,$00,$ff

    L_e009:
        lda #$02
        sta $e898
        lda #$00
        sta L_e897
        sta L_e8dc + $1
        sta $e8e4
        sta L_e8e5 + $6
        ldy #$17
    L_e01e:
        sta sVoc1FreqLo,y
        dey 
        bpl L_e01e
        sty L_e006 + $2
        sty L_e8b1 + $2
        sty L_e8b8 + $2
        sty L_e8c1
        sta $e89b
        sta L_e8a2
        sta L_e8a9
        sta L_e89c
        sta $e8a3
        sta $e8aa
        sta $e89d
        sta L_e8a4
        sta L_e8ab
        sta L_e8ff + $7
        sta $e90d
        sta L_e911 + $3
        sta L_e07d
        sta L_e966 + $2
        sta L_e8ff + $9
        sta $e90f
        sta L_e911 + $5
        sta L_e966 + $5
        lda #$3f
        sta L_e899
        sta L_e89e + $2
        sta $e8a7
        lsr 
        sta sFiltMode
        sta L_e07d + $2
        lsr 
        sta L_e966 + $1
        rts 



    L_e07d:
         .byte $00,$00,$1f

    L_e080:
        lda L_e006 + $1
        beq L_e088
        jmp L_e645
    L_e088:
        lda $fb
        sta L_e911 + $6
        lda $fc
        sta L_e911 + $7
        lda $fd
        sta L_e919
        lda $fe
        sta $e91a
        lda L_e8dc + $1
        bpl L_e0b2
        lda $e8e4
        bpl L_e0b2
        lda L_e8e5 + $6
        bpl L_e0b2
        lda #$00
        sta L_e006 + $2
        beq L_e0cd
    L_e0b2:
        lda $e898
        beq L_e0c6
        dec $e898
        lda #$1f
        sta sFiltMode
        sta L_e07d + $2
        lda #$00
        beq L_e0d3
    L_e0c6:
        ldx #$00
    L_e0c8:
        lda L_e006 + $2
        bmi L_e0e8
    L_e0cd:
        sta sFiltMode
        sta L_e07d + $2
    L_e0d3:
        sta sVoc1AttDec
        sta sVoc1SusRel
        sta sVoc2AttDec
        sta sVoc2SusRel
        sta sVoc3AttDec
        sta sVoc3SusRel
        jmp L_e5f1
    L_e0e8:
        ldy L_e07d
        beq L_e11e
        cpy #$30
        bne L_e0fb
        dec L_e07d
        dey 
        sty L_e966 + $2
        jmp L_e11e
    L_e0fb:
        dec L_e966 + $2
        bpl L_e11e
        sty L_e966 + $2
        dec L_e966 + $1
        bpl L_e110
        lda #$00
        sta L_e006 + $2
        jmp L_e5f1
    L_e110:
        lda L_e07d + $2
        and #$f0
        ora L_e966 + $1
        sta sFiltMode
        sta L_e07d + $2
    L_e11e:
        ldy L_e8ae,x
        jsr L_e5aa
        lda L_e897
        bne L_e130
        dec L_e89c,x
        beq L_e133
        bmi L_e143
    L_e130:
        jmp L_e3bf
    L_e133:
        lda L_e8ff + $7,x
        beq L_e130
        lda #$00
        sta sVoc1AttDec,x
        sta sVoc1SusRel,x
        jmp L_e3bf
    L_e143:
        lda L_e8dc + $1,x
        bpl L_e14b
        jmp L_e5dd
    L_e14b:
        ldy L_e006
        cpx #$07
        beq L_e163
        cpx #$0e
        beq L_e170
        lda L_eb58 + $2,y
        sta $fb
        lda $eb75,y
        sta $fc
        jmp L_e17a
    L_e163:
        lda $eb63,y
        sta $fb
        lda L_eb7e,y
        sta $fc
        jmp L_e17a
    L_e170:
        lda L_eb6c,y
        sta $fb
        lda $eb87,y
        sta $fc
    L_e17a:
        ldy $e89b,x
    L_e17d:
        lda ($fb),y
        cmp #$40
        bcc L_e18c
        sta L_e899,x
        inc $e89b,x
        iny 
        bne L_e17d
    L_e18c:
        tay 
        lda $ec33,y
        sta $fd
        lda L_ec46,y
        sta $fe
        lda #$ff
        sta L_e966 + $3
        lda #$00
        sta L_e8c1 + $2,x
    L_e1a1:
        ldy $e89d,x
        lda ($fd),y
        bne L_e1ab
        jmp L_e28e
    L_e1ab:
        cmp #$ff
        bcc L_e1b9
        inc $e89b,x
        lda #$00
        sta $e89d,x
        beq L_e17a
    L_e1b9:
        cmp #$fd
        bcc L_e1dc
        iny 
        inc $e89d,x
        lda ($fd),y
        and #$0f
        sta L_e8ee,x
        lda #$00
        sta $e8ef,x
        lda #$01
        sta L_e89e + $1,x
        lda #$00
        sta L_e89e,x
    L_e1d7:
        inc $e89d,x
        bne L_e1a1
    L_e1dc:
        cmp #$fb
        bcc L_e1fd
        cmp #$fb
    L_e1e2:
        bne L_e1f9
        lda #$01
    L_e1e6:
        sta L_e8c1 + $2,x
        iny 
        inc $e89d,x
        lda ($fd),y
        sta L_e8c1 + $4,x
        lda #$00
        sta L_e89e + $1,x
        beq L_e1d7
    L_e1f9:
        lda #$02
        bne L_e1e6
    L_e1fd:
        cmp #$fa
        bcc L_e238
        lda #$ff
        sta L_e8b1 + $2,x
        iny 
        inc $e89d,x
        lda ($fd),y
        sta L_e8dc + $2,x
        asl 
        asl 
        asl 
        sta L_e8ae,x
        tay 
        lda L_eae1 + $1,y
        pha 
        and #$0f
        sta L_e8c6,x
        sta L_e8c7,x
        pla 
        and #$f0
        sta L_e8c8,x
        sta L_e8c8 + $1,x
        lda #$00
        sta L_e8cf + $9,x
        sta L_e89e,x
        sta L_e89e + $1,x
        beq L_e1d7
    L_e238:
        cmp #$f9
        bcc L_e248
        iny 
        inc $e89d,x
        lda ($fd),y
        sta L_e8cf + $9,x
        jmp L_e1d7
    L_e248:
        cmp #$f8
        bcc L_e25d
        iny 
        inc $e89d,x
        lda ($fd),y
        sta L_e8b1 + $3,x
        lda #$00
        sta L_e8b1 + $2,x
        jmp L_e1d7
    L_e25d:
        cmp #$f7
        bcc L_e269
        lda #$ff
        sta L_e8ff + $7,x
        jmp L_e1d7
    L_e269:
        cmp #$f6
        bcc L_e275
        lda #$00
        sta L_e8ff + $7,x
        jmp L_e1d7
    L_e275:
        cmp #$70
        bcc L_e281
        sbc #$70
        sta L_e8cf + $a,x
        jmp L_e1d7
    L_e281:
        cmp #$60
        bne L_e28e
        lda L_e8cf + $a,x
        sta L_e89c,x
        jmp L_e36f
    L_e28e:
        clc 
        adc L_e8c1 + $3,x
        sta L_e8cf + $b,x
        lda L_e8cf + $a,x
        sta L_e89c,x
        lda #$01
        sta $e8af,x
        sta $e8b0,x
        lsr 
        sta L_e8db,x
        lda L_e8cf + $b,x
        beq L_e2c7
        ldy L_e8ae,x
        lda L_eae1 + $8,y
        and #$02
        beq L_e2c2
        lda L_e8c8 + $1,x
        sta L_e8c8,x
        lda L_e8c7,x
        sta L_e8c6,x
    L_e2c2:
        lda L_e8cf + $b,x
        bne L_e2dd
    L_e2c7:
        lda L_e8dc,x
        sta L_e8cf + $b,x
        lda #$00
        sta L_e8dc,x
        ldy L_e8ae,x
        dec L_e966 + $3
        beq L_e2dd
        jmp L_e366
    L_e2dd:
        sta L_e8dc,x
        tay 
        lda $ea2c,y
        sta sVoc1FreqHi,x
        sta L_e8b1,x
        lda L_e9cc,y
        sta sVoc1FreqLo,x
        sta L_e8b1 + $1,x
        lda #$00
        sta L_e8ff + $9,x
        ldy L_e8ae,x
        jsr L_e5aa
        lda L_eae1 + $7,y
        sta sVoc1Control,x
        lda L_eae1 + $3,y
        sta sVoc1AttDec,x
        lda L_e8b1 + $2,x
        bmi L_e34e
        tya 
        pha 
        ldy L_e8b1 + $3,x
        lda L_e954,y
        sta $fb
        lda $e955,y
        sta $fc
        ldy L_e8b1 + $2,x
    L_e321:
        lda ($fb),y
        beq L_e33a
        cmp #$01
        beq L_e345
        sta sVoc1AttDec,x
        inc L_e8b1 + $2,x
        pla 
        tay 
        jmp L_e34e
        lda sVoc1AttDec,x
        jmp L_e351
    L_e33a:
        lda #$ff
        sta L_e8b1 + $2,x
        pla 
        tay 
        lda #$00
        bpl L_e351
    L_e345:
        lda #$00
        sta L_e8b1 + $2,x
        tay 
        jmp L_e321
    L_e34e:
        lda L_eae1 + $4,y
    L_e351:
        sta sVoc1SusRel,x
        lda L_e8c8,x
        sta sVoc1PWidthLo,x
        lda L_e8c6,x
        sta sVoc1PWidthHi,x
        lda L_e8cf + $9,x
        sta L_e8f0 + $1,x
    L_e366:
        lda L_eae1 + $2,y
        and L_e966 + $3
        sta sVoc1Control,x
    L_e36f:
        inc $e89d,x
        ldy $e89d,x
        lda ($fd),y
        cmp #$ff
        bne L_e3b4
        lda #$00
        sta $e89d,x
        lda L_e899,x
        cmp #$3f
        beq L_e38c
        dec L_e899,x
        bne L_e3b4
    L_e38c:
        inc $e89b,x
        ldy $e89b,x
        lda ($fb),y
        cmp #$ff
        bne L_e39f
        lda #$00
        sta $e89b,x
        beq L_e3b4
    L_e39f:
        cmp #$fd
        bne L_e3a8
        dec L_e8dc + $1,x
        bne L_e3b4
    L_e3a8:
        cmp #$fe
        bne L_e3b4
        lda #$30
        sta L_e07d
        inc $e89b,x
    L_e3b4:
        lda L_e8dc,x
        beq L_e3bf
        ldy L_e8ae,x
        jmp L_e5dd
    L_e3bf:
        lda L_eae1 + $5,y
        sta L_e966 + $4
        beq L_e40e
        lda L_e8e5 + $8,x
        bne L_e3ee
        clc 
        lda L_e8c8,x
        adc L_e966 + $4
        sta L_e8c8,x
        sta sVoc1PWidthLo,x
        lda L_e8c6,x
        adc #$00
        sta L_e8c6,x
        sta sVoc1PWidthHi,x
        clc 
        cmp #$0e
        bcc L_e40e
        inc L_e8e5 + $8,x
        bne L_e40e
    L_e3ee:
        lda L_e8c8,x
        sec 
        sbc L_e966 + $4
        sta L_e8c8,x
        sta sVoc1PWidthLo,x
        lda L_e8c6,x
        sbc #$00
        sta L_e8c6,x
        sta sVoc1PWidthHi,x
        clc 
        cmp #$08
        bcs L_e40e
        dec L_e8e5 + $8,x
    L_e40e:
        lda L_e89e + $1,x
        beq L_e458
    L_e413:
        lda L_e8ee,x
        asl 
        tay 
        lda L_e92c,y
        sta $e443
        sta $e42f
        lda $e92d,y
        sta $e444
        sta $e430
        lda $e8ef,x
        tay 
        lda $e936,y
        bpl L_e43a
        lda #$00
        sta $e8ef,x
        bpl L_e413
    L_e43a:
        lda $e8ef,x
        tay 
        lda L_e8cf + $b,x
        clc 
        adc $e936,y
        tay 
        lda L_e9cc,y
        sta sVoc1FreqLo,x
        lda $ea2c,y
        sta sVoc1FreqHi,x
        inc $e8ef,x
        jmp L_e5dd
    L_e458:
        lda L_e89e,x
        bne L_e460
        jmp L_e4dc
    L_e460:
        lda L_e8f0 + $1,x
        beq L_e46b
        dec L_e8f0 + $1,x
        jmp L_e4dc
    L_e46b:
        lda L_e8f0 + $2,x
        beq L_e474
        cmp #$03
        bcc L_e4a9
    L_e474:
        sec 
        lda L_e8b1 + $1,x
        sbc L_e8f0 + $3,x
        sta L_e8b1 + $1,x
        sta sVoc1FreqLo,x
        lda L_e8b1,x
        sbc #$00
        sta L_e8b1,x
        sta sVoc1FreqHi,x
        dec L_e8ff + $3,x
        bne L_e4a6
        lda L_e8ff + $4,x
        sta L_e8ff + $3,x
        inc L_e8f0 + $2,x
        lda L_e8f0 + $2,x
        cmp #$05
        bcc L_e4a6
        lda #$01
        sta L_e8f0 + $2,x
    L_e4a6:
        jmp L_e4d4
    L_e4a9:
        clc 
        lda L_e8b1 + $1,x
        adc L_e8f0 + $3,x
        sta L_e8b1 + $1,x
        sta sVoc1FreqLo,x
        lda L_e8b1,x
        adc #$00
        sta L_e8b1,x
        sta sVoc1FreqHi,x
        dec L_e8ff + $3,x
        beq L_e4c9
        jmp L_e54c
    L_e4c9:
        lda L_e8ff + $4,x
        sta L_e8ff + $3,x
        inc L_e8f0 + $2,x
        bne L_e54c
    L_e4d4:
        lda L_e8c1 + $2,x
        bne L_e4dc
        jmp L_e5dd
    L_e4dc:
        lda L_e8c1 + $2,x
        beq L_e540
        cmp #$01
        beq L_e4fd
        cmp #$02
        beq L_e528
        cmp #$03
        beq L_e518
        clc 
        lda L_e8b1,x
        adc L_e8c1 + $4,x
        sta L_e8b1,x
        sta sVoc1FreqHi,x
        jmp L_e540
    L_e4fd:
        clc 
        lda L_e8b1 + $1,x
        sbc L_e8c1 + $4,x
        sta L_e8b1 + $1,x
        sta sVoc1FreqLo,x
        lda L_e8b1,x
        sbc #$00
        sta L_e8b1,x
        sta sVoc1FreqHi,x
        jmp L_e540
    L_e518:
        sec 
        lda L_e8b1,x
        sbc L_e8c1 + $4,x
        sta L_e8b1,x
        sta sVoc1FreqHi,x
        jmp L_e540
    L_e528:
        clc 
        lda L_e8b1 + $1,x
        adc L_e8c1 + $4,x
        sta L_e8b1 + $1,x
        sta sVoc1FreqLo,x
        lda L_e8b1,x
        adc #$00
        sta L_e8b1,x
        sta sVoc1FreqHi,x
    L_e540:
        ldy L_e8ae,x
        lda L_eae1 + $8,y
        and #$01
        beq L_e54c
        bne L_e54f
    L_e54c:
        jmp L_e5dd
    L_e54f:
        lda $fb
        pha 
        lda $fc
        pha 
        ldy L_e8dc + $2,x
        lda $ea8c,y
        tay 
        lda L_ea9b,y
        sta $fb
        lda L_eaa0,y
        sta $fc
        ldy L_e8db,x
        lda ($fb),y
        beq L_e5a1
        bpl L_e581
        sta sVoc1Control,x
        iny 
        inc L_e8db,x
        lda ($fb),y
        sta sVoc1FreqHi,x
        iny 
        inc L_e8db,x
        bne L_e5a1
    L_e581:
        sta L_e8ff + $5,x
        iny 
        inc L_e8db,x
        sec 
        lda L_e8b1,x
        sbc ($fb),y
        sta L_e8b1,x
        iny 
        inc L_e8db,x
        lda L_e8ff + $5,x
        sta sVoc1Control,x
        lda L_e8b1,x
        sta sVoc1FreqHi,x
    L_e5a1:
        pla 
        sta $fc
        pla 
        sta $fb
        jmp L_e5dd
    L_e5aa:
        lda L_eae1 + $6,y
        beq L_e5cd
        lda L_e89a,x
        ora L_e966 + $5
        sta sFiltControl
        sta L_e966 + $5
        ldy L_e8ff + $9,x
        lda $e91b,y
        beq L_e5d9
        sta sFiltFreqHi
        inc L_e8ff + $9,x
        ldy L_e8ae,x
        rts 


    L_e5cd:
        lda L_e8ff + $6,x
        and L_e966 + $5
        sta sFiltControl
        sta L_e966 + $5
    L_e5d9:
        ldy L_e8ae,x
        rts 


    L_e5dd:
        lda L_e8ff + $8,x
        beq L_e5e6
        tax 
        jmp L_e0c8
    L_e5e6:
        dec L_e897
        bpl L_e5f1
        lda L_e895 + $1
        sta L_e897
    L_e5f1:
        lda L_e911 + $6
        sta $fb
        lda L_e911 + $7
        sta $fc
        lda L_e919
        sta $fd
        lda $e91a
        sta $fe
        rts 


    L_e606:
        lda #$01
        sta L_e006 + $2
        lsr 
        sta L_e966 + $8
        sta L_e966 + $6
        sta L_e966 + $7
        sta L_e974 + $7
        sta L_e974 + $a
        sta $e972
        sta L_e974 + $1
        sta L_e974 + $25
        sta L_e974 + $37
        sta L_e974 + $3a
        sta L_e974 + $49
        ldx #$17
    L_e62f:
        sta sVoc1FreqLo,x
        dex 
        bpl L_e62f
        lda #$0f
        sta sFiltMode
        lda #$08
        sta sVoc1PWidthHi
        lda #$00
        sta sVoc1PWidthLo
        rts 


    L_e645:
        lda L_e006 + $2
        bpl L_e64b
        rts 


    L_e64b:
        bne L_e654
        dec L_e006 + $2
        ldx #$00
        beq L_e65c
    L_e654:
        ldx L_e966 + $7
        bmi L_e66f
        dec L_e966 + $7
    L_e65c:
        stx sVoc1AttDec
        stx sVoc1SusRel
        stx sVoc2AttDec
        stx sVoc2SusRel
        stx sVoc3AttDec
        stx sVoc3SusRel
        rts 


    L_e66f:
        lda $fb
        sta L_e911 + $6
        lda $fc
        sta L_e911 + $7
        lda $fd
        sta L_e919
        lda $fe
        sta $e91a
        lda L_e966 + $6
        bmi L_e68e
        dec L_e966 + $6
        jmp L_e74c
    L_e68e:
        ldy L_e966 + $8
        bpl L_e6aa
        lda L_e974 + $3a
        beq L_e6aa
        sta L_e974 + $37
        dec L_e974 + $3a
        lda L_e974 + $43
        sta L_e974 + $40
        dec L_e974 + $43
        jmp L_e6b5
    L_e6aa:
        lda L_e974 + $37
        beq L_e6b5
        jsr L_e86a
        jmp L_e704
    L_e6b5:
        lda L_e974 + $25
        beq L_e704
        bmi L_e6e1
        lda L_e974 + $10
        sta sVoc1FreqLo
        clc 
        lda L_e974 + $13
        adc L_e974 + $28
        sta L_e974 + $13
        sta sVoc1FreqHi
        dec L_e974 + $2e
        bpl L_e704
        lda L_e974 + $2b
        sta L_e974 + $2e
        lda #$ff
        sta L_e974 + $25
        bmi L_e704
    L_e6e1:
        lda L_e974 + $10
        sta sVoc1FreqLo
        sec 
        lda L_e974 + $13
        sbc L_e974 + $28
        sta L_e974 + $13
        sta sVoc1FreqHi
        dec L_e974 + $2e
        bpl L_e704
        lda L_e974 + $2b
        sta L_e974 + $2e
        lda #$1c
        sta L_e974 + $25
    L_e704:
        lda L_e966 + $8
        bmi L_e70c
        jmp L_e746
    L_e70c:
        dec L_e974 + $a
        bmi L_e714
        jmp L_e833
    L_e714:
        lda L_e974 + $7
        sta L_e974 + $a
        lda L_e974 + $d
        bne L_e725
        lda L_e974 + $1f
        jmp L_e734
    L_e725:
        lda L_e974 + $10
        sta sVoc1FreqLo
        lda L_e974 + $13
        sta sVoc1FreqHi
        lda L_e974 + $1c
    L_e734:
        sta sVoc1Control
        lda L_e974 + $16
        sta sVoc1AttDec
        lda L_e974 + $19
        sta sVoc1SusRel
    L_e743:
        jmp L_e833
    L_e746:
        ldx L_e974 + $a
        dex 
        bpl L_e743
    L_e74c:
        ldy L_e006
        lda L_eb58 + $2,y
        sta $fb
        lda $eb75,y
        sta $fc
    L_e759:
        ldy $e972
        lda ($fb),y
        cmp #$fd
        bne L_e76a
        lda #$00
        sta L_e006 + $2
        jmp L_e833
    L_e76a:
        tay 
        lda $ec33,y
        sta $fd
        lda L_ec46,y
        sta $fe
        ldy L_e974 + $1
        lda ($fd),y
        cmp #$ff
        bne L_e788
        lda #$00
        sta L_e974 + $1
        inc $e972
        bne L_e759
    L_e788:
        cmp #$fa
        bne L_e7cd
        inc L_e974 + $1
        iny 
        lda ($fd),y
        sta L_e974 + $4
        asl 
        asl 
        asl 
        tay 
        lda L_eae1 + $8,y
        sta L_e974 + $3a
        lda L_eae1 + $6,y
        sta L_e974 + $43
        lda L_eae1 + $2,y
        sta L_e974 + $1c
        lda L_eae1 + $7,y
        sta L_e974 + $1f
        lda L_eae1 + $3,y
        sta L_e974 + $16
        lda L_eae1 + $4,y
        sta L_e974 + $19
        lda #$00
        sta L_e974 + $25
        sta L_e974 + $49
        inc L_e974 + $1
        ldy L_e974 + $1
        lda ($fd),y
    L_e7cd:
        cmp #$f7
        bne L_e7f1
        inc L_e974 + $1
        iny 
        lda ($fd),y
        sta L_e974 + $28
        inc L_e974 + $1
        iny 
        lda ($fd),y
        sta L_e974 + $2b
        sta L_e974 + $2e
        lda #$01
        sta L_e974 + $25
        inc L_e974 + $1
        iny 
        lda ($fd),y
    L_e7f1:
        cmp #$f6
        bne L_e80d
        inc L_e974 + $1
        iny 
        lda ($fd),y
        sta sVoc1PWidthHi
        inc L_e974 + $1
        iny 
        lda ($fd),y
        sta sVoc1PWidthLo
        inc L_e974 + $1
        iny 
        lda ($fd),y
    L_e80d:
        cmp #$70
        bcc L_e81e
        sbc #$70
        sta L_e974 + $7
        inc L_e974 + $1
        ldy L_e974 + $1
        lda ($fd),y
    L_e81e:
        sta L_e974 + $d
        tay 
        beq L_e830
        lda L_e9cc,y
        sta L_e974 + $10
        lda $ea2c,y
        sta L_e974 + $13
    L_e830:
        inc L_e974 + $1
    L_e833:
        lda L_e966 + $8
        bpl L_e852
        lda #$00
        sta L_e966 + $8
        lda L_e911 + $6
        sta $fb
        lda L_e911 + $7
        sta $fc
        lda L_e919
        sta $fd
        lda $e91a
        sta $fe
        rts 


    L_e852:
        dec L_e966 + $8
        lda L_e911 + $6
        sta $fb
        lda L_e911 + $7
        sta $fc
        lda L_e919
        sta $fd
        lda $e91a
        sta $fe
        rts 


    L_e86a:
        ldy L_e974 + $40
        lda L_ea9b,y
        sta $fb
        lda L_eaa0,y
        sta $fc
        ldy L_e974 + $49
        lda ($fb),y
        beq L_e88e
        sta sVoc1Control
        inc L_e974 + $49
        iny 
        lda ($fb),y
        sta sVoc1FreqHi
        inc L_e974 + $49
        rts 


    L_e88e:
        sta L_e974 + $49
        sta L_e974 + $37
        rts 



    L_e895:
         .byte $00,$02

    L_e897:
        ora ($00,x)
    L_e899:
        cli 
    L_e89a:
        sbc ($01),y
    L_e89c:
        ora ($00,x)

    L_e89e:
         .byte $00,$00,$43,$f2

    L_e8a2:
        ora ($01,x)
    L_e8a4:
        cli 

        .byte $00,$01,$3f,$f4

    L_e8a9:
        ora ($11,x)

    L_e8ab:
         .byte $00,$00,$00

    L_e8ae:
        jsr $0101

    L_e8b1:
         .byte $06,$d1,$ff,$00
        .byte $38,$01,$01

    L_e8b8:
        .byte $0b,$30,$ff,$00,$00
        .byte $01,$01,$06,$d1

    L_e8c1:
        .byte $ff,$00,$00,$00,$00

    L_e8c6:
        php 
    L_e8c7:
        php 

    L_e8c8:
         .byte $00,$00,$00,$00,$00
        .byte $08,$08

    L_e8cf:
        .byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$07,$32

    L_e8db:
        php 

    L_e8dc:
         .byte $32,$00,$04,$00
        .byte $01,$29,$00,$29,$00

    L_e8e5:
        .byte $07,$00,$3f,$00,$00,$00,$00,$00,$00

    L_e8ee:
        ora ($05,x)

    L_e8f0:
         .byte $00,$00,$00,$00,$00,$00
        .byte $01,$00,$00,$00,$00,$01,$01,$05,$00

    L_e8ff:
        .byte $00,$00,$00,$00,$00,$10,$f6,$ff,$07,$00,$00,$00,$00
        .byte $f5,$ff,$0e,$02,$00

    L_e911:
        .byte $00,$10,$f3,$00,$00,$00,$fa,$ff

    L_e919:
        lda $c000
        ldy #$80
        rts 


        rti 

        .byte $30,$20,$20,$10,$10,$0e,$0e,$0e,$0e,$0a,$0a,$00

    L_e92c:
        rol $e9,x
        sec 
        sbc #$3f
        sbc #$46
        sbc #$4d
        sbc #$00

        .byte $ff,$00,$00,$03,$03,$05,$05,$ff,$00,$00,$05,$05,$07,$07,$ff,$00
        .byte $00,$03,$03,$07,$07,$ff,$00,$00,$02,$02,$05,$05,$ff

    L_e954:
        lsr $e9,x

        .byte $04,$04,$04,$04,$03,$03,$03,$03,$03,$03,$02,$02,$02,$02,$02,$02

    L_e966:
        .byte $00,$0f,$00,$ff,$00,$f2,$00,$00,$00,$00,$07
        .byte $0e,$00,$00

    L_e974:
        .fill $58, $0

    L_e9cc:
        .byte $0c,$1c
        .byte $2d,$3e,$51

    L_e9d1:
        ror $7b
        sta ($a9),y

        .byte $c3,$dd,$fa,$18,$38,$5a,$7d,$a3,$cc,$f6,$23,$53,$86,$bb,$f4,$30
        .byte $70,$b4,$fb,$47,$98,$ed,$47,$a7,$0c,$77,$e9,$61,$e1,$68,$f7,$8f
        .byte $30,$da,$8f,$4e,$18,$ef,$d2,$c3,$c3,$d1,$ef,$1f,$60,$b5,$1e,$9c
        .byte $31,$df,$a5,$87,$86,$a2,$df,$3e,$c1,$6b,$3c,$39,$63,$be,$4b,$0f
        .byte $0c,$45,$bf,$7d,$83,$d6,$79,$73,$c7,$7c,$97,$1e,$18,$8b,$7e,$fa
        .byte $06,$ac,$f3,$e6,$8f,$f8,$2e,$01,$01,$01,$01,$01,$01,$01,$01,$01
        .byte $01,$01,$01,$02,$02,$02,$02,$02,$02,$02,$03,$03,$03,$03,$03,$04
        .byte $04,$04,$04,$05,$05,$05,$06,$06,$07,$07,$07,$08,$08,$09,$09,$0a
        .byte $0b,$0b,$0c,$0d,$0e,$0e,$0f,$10,$11,$12,$13,$15,$16,$17,$19,$1a
        .byte $1c,$1d,$1f,$21,$23,$25,$27,$2a,$2c,$2f,$32,$35,$38,$3b,$3f,$43
        .byte $47,$4b,$4f,$54,$59,$5e,$64,$6a,$70,$77,$7e,$86,$8e,$96,$9f,$a8
        .byte $b3,$bd,$c8,$d4,$e1,$ee,$fd,$00,$00,$01,$00,$02,$03,$00,$00,$00
        .byte $00,$00,$04,$04,$04,$00

    L_ea9b:
        lda $ae

        .byte $b7,$c0,$d5

    L_eaa0:
        nop 
        nop 
        nop 
        nop 
        nop 
        sta ($10,x)
        eor ($03,x)

        .byte $10,$04,$10,$05,$00,$10,$0d,$10,$0d

    L_eab2:
        bpl L_eac0
        bpl L_eac2

        .byte $00,$81,$18,$41,$03

    L_eabb:
        .byte $10,$04,$10,$05,$00

    L_eac0:
        sta ($10,x)
    L_eac2:
        eor ($03,x)

        .byte $80,$54,$80,$58,$80,$54,$80,$58,$80,$54,$80,$58,$80,$54,$80,$58
        .byte $00,$81,$60,$41,$03,$10,$34,$80,$38,$80,$34,$80,$38

    L_eae1:
        .byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00
        .byte $11,$02,$38,$00,$01,$10,$01,$00,$41,$01,$24,$00,$00,$10,$01,$00

    L_eafb:
        eor ($0a,x)

        .byte $90,$00,$00,$40,$00,$08,$01,$08,$45,$00,$00,$00,$01,$08,$01,$09
        .byte $77,$00,$00,$00,$01,$01,$41,$00,$38,$10,$00

    L_eb18:
        rti 

        .byte $00,$08,$41,$08,$79,$00,$01,$40,$02,$00,$81,$03,$18,$00,$00,$80
        .byte $00,$08,$51,$08,$68,$10,$00

    L_eb30:
        .byte $50,$02
        .byte $08,$41,$06,$48,$ff,$00,$40,$02,$08,$01,$02,$28,$00,$00,$00,$01
        .byte $08,$01,$83,$29,$00,$00,$00,$01,$08,$01,$03,$29,$00,$00,$00,$01
        .byte $00,$81,$a0,$fd,$00,$00

    L_eb58:
        .byte $80,$00,$90,$96,$9c
        .byte $a2,$a8,$fe,$0a,$12,$1e,$92,$98,$9e,$a4,$b1,$02,$0d,$15,$21

    L_eb6c:
        sty $9a,x
        ldy #$a6
        ldy L_0ffe + $8,x
        clc 
        and $ebeb

        .byte $eb,$eb,$eb,$eb,$ec,$ec,$ec

    L_eb7e:
        .byte $eb,$eb,$eb,$eb,$eb
        .byte $ec,$ec,$ec,$ec,$eb,$eb,$eb,$eb,$eb,$ec,$ec,$ec,$ec,$01,$fd,$00
        .byte $fd,$00,$fd,$02,$fd,$00,$fd,$00,$fd,$03,$fd,$00,$fd,$00,$fd,$04
        .byte $fd,$00,$fd,$00,$fd,$5e,$07,$42,$09,$46,$00,$4d,$0c,$ff,$43,$08
        .byte $0d,$08,$0d,$4a,$08,$0d,$08,$08,$ff,$00,$00,$7e,$0b,$56,$0a,$44
        .byte $09,$00,$00,$4e,$07,$46,$09,$08,$08,$4e,$0a,$46,$09,$00,$00,$ff
        .byte $5e,$07,$42,$09,$46,$00,$4c,$0c,$ff,$43,$08,$0d,$08,$0d,$49,$08
        .byte $0d,$08,$08,$ff,$00,$00,$7e,$0b,$56,$0a,$44,$09,$00,$00,$4e,$07
        .byte $46,$09,$00,$00,$4e,$0a,$46,$09,$00,$00,$ff,$10,$00,$00,$fd,$12
        .byte $00,$00,$fd,$11,$00,$00,$fd,$05,$00,$fd,$06,$00,$fd,$00,$fd,$5e
        .byte $0a,$fd,$4e,$07,$fd,$0e,$fe,$0e,$0e,$0e,$fd,$5e,$09,$fd,$0e,$0e
        .byte $0e,$fe,$0e,$0e,$fd,$42,$07,$4e,$09,$fd,$0f,$0e,$0e,$0e,$0e,$fd
        .byte $59,$5e,$63,$68,$72,$b3,$c0,$ce,$d4,$bf,$14,$27,$2d,$42,$2d,$6a
        .byte $6f,$81,$93

    L_ec46:
        cpx L_ecec
        cpx L_ecec
        cpx L_ecec
        sbc $eeee
        inc L_efe0 + $e

        .byte $ef,$ef,$ef,$ef,$fa,$00,$af,$00,$ff,$fa,$01,$7f,$30,$ff,$fa,$02
        .byte $7f,$30,$ff,$fa,$03,$f7,$06,$00,$7b,$5c,$71,$00,$ff,$fa,$03,$f6
        .byte $02,$00,$70,$37,$f6,$02,$40,$72,$36,$f6,$02,$80,$72,$36,$f6,$02
        .byte $c0,$72,$36,$f6,$03,$00,$72,$36,$f6,$03,$40,$72,$36,$f6,$03,$80
        .byte $72,$36,$f6,$03,$c0,$72,$36,$f6,$04,$00,$72,$36,$f6,$04,$40,$72
        .byte $36,$f6,$04,$80,$72,$36,$f6,$04,$c0,$72,$36,$71,$00,$ff,$fa,$0e
        .byte $f6,$73,$fc,$08,$3c,$ef,$fb,$06,$00,$00,$ff,$fa,$0e,$f6,$73,$fc
        .byte $03,$11,$7f,$fb,$01,$00,$ef,$00,$ff,$f7,$77,$fa,$04,$32,$ff,$f7
        .byte $73,$fa,$07,$fd,$40,$1f,$fa,$0a,$fd,$42,$29,$71,$fa,$07,$fd,$40
        .byte $1f,$73,$fa,$0a,$fd,$41,$2b

    L_ecec:
        adc ($fa),y

        .byte $07,$fd,$40,$2b,$73,$fa,$0a,$fd,$41,$2b,$71,$fa,$07,$fd,$40,$1f
        .byte $73,$fa,$0a,$fd,$42,$29,$71,$fa,$07,$fd,$40,$13,$fa,$0a,$fd,$41
        .byte $2b,$2b,$73,$fa,$07,$fd,$40,$1d,$fa,$0a,$fd,$42,$35,$71,$fa,$07
        .byte $fd,$40,$1d,$fa,$0a,$fd,$41,$37,$37,$fa,$07,$fd,$40,$29,$73,$fa
        .byte $0a,$fd,$41,$37,$71,$fa,$07,$fd,$40,$1d,$73,$fa,$0a,$fd,$42,$35
        .byte $71,$fa,$07,$fd,$40,$11,$73,$fa,$0a,$fd,$41,$37,$fa,$07,$fd,$40
        .byte $18,$fa,$0a,$fd,$42,$41,$71,$fa,$07,$fd,$40,$18,$73,$fa,$0a,$fd
        .byte $41,$43,$71,$fa,$07,$fd,$40,$24,$73,$fa,$0a,$fd,$41,$43,$71,$fa
        .byte $07,$fd,$40,$18,$73,$fa,$0a,$fd,$42,$41,$71,$fa,$07,$fd,$40,$0c
        .byte $fa,$0a,$fd,$41,$43,$43,$73,$fa,$07,$fd,$40,$1b,$fa,$0a,$fd,$42
        .byte $35,$71,$fa,$07,$fd,$40,$1b,$fa,$0a,$fd,$41,$37,$37,$fa,$07,$fd
        .byte $40,$27,$73,$fa,$0a,$fd,$41,$37,$71,$fa,$07,$fd,$40,$1b,$73,$fa
        .byte $0a,$fd,$42,$35,$71,$fa,$07,$fd,$40,$0f,$73,$fa,$0a,$fd,$41,$37
        .byte $ff,$f7,$71,$fa,$04,$32,$fa,$08,$4a,$fa,$04,$32,$fa,$08,$4a,$73
        .byte $fa,$05,$32,$71,$fa,$05,$32,$fa,$04,$32,$fa,$08,$4a,$fa,$04,$32
        .byte $32,$fa,$08,$4a,$73,$fa,$05,$32,$71,$fa,$04,$32,$fa,$08,$4a,$fa
        .byte $04,$32,$fa,$08,$4a,$fa,$04,$32,$32,$73,$fa,$05,$32,$71,$fa,$05
        .byte $32,$32,$fa,$04,$32,$fa

    L_ee04:
        ora $32

        .byte $32,$32,$70,$fa,$04,$32,$32,$32,$32,$32,$32,$32,$32,$ff,$f7,$73
        .byte $fa,$0d,$32,$71,$32,$32,$32,$fa,$0d,$32,$fa,$0c,$32,$fa,$0d,$32
        .byte $ff,$f7,$71,$fa,$0b,$32,$ff,$f6,$8f,$fa,$06,$fd,$41,$32,$fd,$42
        .byte $30,$fd,$43,$30,$7f,$fd,$41,$30,$fd,$44,$30,$ff,$f7,$73,$fa,$07
        .byte $fd,$40,$1d,$71,$fa,$09,$fd,$42,$41,$41,$fa,$07,$fd,$40,$1d,$73
        .byte $fa,$09,$fd,$41,$43,$71,$fa,$07,$fd,$40,$29,$fa,$09,$fd,$41,$43
        .byte $43,$fa,$07,$fd,$40,$1d,$73,$fa,$09,$fd,$42,$41,$71,$fa,$07,$fd
        .byte $40,$11,$fa,$09,$fd,$41,$43,$43,$73,$fa,$07,$fd,$40,$1b,$fa,$09
        .byte $fd,$42,$35,$71,$fa,$07,$fd,$40,$1b,$fa,$09,$fd,$41,$37,$37,$fa
        .byte $07,$fd,$40,$27,$73,$fa,$09,$fd,$41,$37,$71,$fa,$07,$fd,$40,$1b
        .byte $73,$fa,$09,$fd,$42,$35,$71,$fa,$07,$fd,$40,$0f,$73,$fa,$09,$fd
        .byte $41,$37,$fa,$07,$fd,$40,$18,$71,$fa,$09,$fd,$42,$29,$29,$fa,$07
        .byte $fd,$40,$18,$73,$fa,$09,$fd,$41,$2b,$71,$fa,$07,$fd,$40,$24,$fa
        .byte $09,$fd,$41,$2b,$2b,$fa,$07,$fd,$40,$18,$73,$fa,$09,$fd,$42,$29
        .byte $71,$fa,$07,$fd,$40,$0c,$fa,$09,$fd,$41,$2b,$2b,$73,$fa,$07,$fd
        .byte $40,$1d,$fa,$09,$fd,$42,$35,$71,$fa,$07,$fd,$40,$1d,$fa,$09,$fd
        .byte $41,$37,$37,$fa,$07,$fd,$40,$29,$73,$fa,$09,$fd,$41,$37,$71,$fa
        .byte $07,$fd,$40,$1d,$73,$fa,$09,$fd,$42,$35,$71,$fa,$07,$fd,$40,$11
        .byte $73,$fa,$09,$fd,$41,$37,$ff,$f7,$73,$fa,$07,$fd,$40,$1d,$71,$fa
        .byte $09,$fd,$42,$41,$41,$fa,$07,$fd,$40,$29,$73,$fa,$09,$fd,$41,$43
        .byte $71,$fa,$07,$fd,$40,$1d,$fa,$09,$fd,$41,$43,$43,$fa,$07,$fd,$40
        .byte $1d,$73,$fa,$09,$fd,$42,$41,$71,$fa,$07,$fd,$40,$29,$fa,$09,$fd
        .byte $41,$43,$43,$ff,$fa,$00,$75,$00,$ff,$fa,$0e,$f6,$7f,$fc,$20,$48
        .byte $af,$60,$8f,$fb,$04,$60,$ef,$fb,$08,$00,$ff,$fa,$0e,$f6,$7f,$fc
        .byte $1c,$1c,$af,$60,$8f,$fb,$01,$60,$af,$fb,$02,$00,$ff,$fa,$0e,$f6
        .byte $7f,$fc,$10,$59,$af,$60,$8f,$fb,$02,$60,$ef,$00,$ff,$00,$00,$00
        .byte $ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00
        .byte $ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00
        .byte $ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00
        .byte $ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff

    L_efe0:
        .byte $ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff
        .byte $ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff
        .byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$3c,$3d,$3e,$3f,$00,$00,$00
        .byte $00,$00,$00,$00,$00,$00,$40,$41,$00,$00,$00,$00,$00,$00,$00,$00
        .byte $00,$00,$00,$00,$00,$00,$20,$20,$00,$00,$00,$00,$00,$00,$00,$00
        .byte $42,$43,$44,$45,$46

    L_f035:
        .byte $00,$00,$00,$00,$00,$00,$00,$00,$47
        .byte $48,$49,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
        .byte $20,$20,$00,$00,$00,$00,$00,$00,$00,$00,$4a,$4b,$4c,$4d,$4e,$4f
        .byte $50,$51,$52,$53,$54,$55,$00,$56,$57,$58,$59,$5a,$5b,$5c,$5d,$5e
        .byte $5f

    L_f06f:
        rts 



        .byte $61,$00,$00,$00,$00,$00,$20,$20,$00,$00,$00,$00,$00,$00,$00,$00
        .byte $62,$63,$64,$65,$66,$67,$68,$69,$6a,$6b,$6c,$6d,$6e,$6f,$70,$71
        .byte $72,$73,$74,$75,$76,$77,$78,$79,$7a,$00,$00,$00,$00,$00,$20,$20
        .byte $00,$00,$00,$7b,$7c,$7d,$7e,$7f,$80,$81,$82,$83,$84,$85,$86,$7b
        .byte $7c,$87,$88,$89,$8a,$8b,$8c,$8d,$8e

    L_f0b9:
        .byte $00,$00,$8f,$90,$86
        .byte $91,$8d,$92,$93,$94,$95,$96,$00,$20,$20,$00,$00,$00,$97,$98,$99
        .byte $8e,$9a,$9b,$9c,$9d,$9e,$9f,$a0,$a1,$97,$98,$a2,$97,$a3

    L_f0dc:
        ldy #$a4
        lda $a6
        stx.a $0000

        .byte $a7,$a8,$a2,$9a,$00,$8e,$97,$a9,$a5,$aa,$00,$20,$20,$00,$00,$00
        .byte $ab,$ac,$ad,$8e,$9a,$a2,$ae,$8e,$af,$b0,$a0,$a2

    L_f0ff:
        .byte $97
        .byte $98

    L_f101:
        lda ($b2),y

        .byte $b3,$a0,$b4,$9a,$9a,$b5,$b6,$00,$b7,$a0,$b1,$b8,$b9,$b5,$ba,$bb
        .byte $9a,$9a,$00,$20,$20,$00,$00,$00,$bc,$bd,$be,$be,$bf,$c0,$bd,$be
        .byte $c1,$c2,$c3,$c0,$c4,$c5,$c6,$c7,$c8,$c9,$c0,$bf,$bf,$c6,$be,$00
        .byte $ca,$cb,$cc,$cd,$ce,$cf,$d0,$c6,$bf,$bf,$00,$20,$20,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$00,$00,$ff
        .byte $ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff
        .byte $ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff
        .byte $ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff
        .byte $ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff
        .byte $ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff
        .byte $ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff
        .byte $ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff
        .byte $ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff
        .byte $ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff
        .byte $ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff
        .byte $ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff
        .byte $ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff
        .byte $ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff
        .byte $ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff
        .byte $ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff
        .byte $ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$00,$00,$ff
        .byte $ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff
        .byte $ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff
        .byte $ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff
        .byte $ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff
        .byte $ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff
        .byte $ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff
        .byte $ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff
        .byte $ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff
        .byte $ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff
        .byte $ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff
        .byte $ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff
        .byte $ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff
        .byte $ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff
        .byte $ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff
        .byte $ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff
        .byte $ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$00,$00,$ff
        .byte $ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff
        .byte $ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff
        .byte $ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff
        .byte $ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff
        .byte $ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff
        .byte $ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff
        .byte $ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff
        .byte $ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff
        .byte $ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff
        .byte $ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff
        .byte $ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff
        .byte $ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff
        .byte $ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00

    L_f6d1:
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00

    L_f8b1:
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff

    L_f961:
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff

    L_f9e1:
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff

    L_f9f1:
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00

    L_fa31:
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00

    L_fa51:
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00

    L_faa1:
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00

    L_faf1:
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00

    L_fcf1:
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$ff

    L_fd01:
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff

    L_fdf1:
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00

    L_fec1:
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00

    L_fef1:
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$ff

    L_ff01:
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff

    L_ff11:
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff

    L_ff21:
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff

    L_ff31:
        .byte $ff,$00,$00
        .byte $01,$00

    L_ff36:
        .byte $ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00

    L_ff46:
        .byte $ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00
        .byte $ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00
        .byte $ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00

    L_ff76:
        .byte $ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00
        .byte $ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00
        .byte $ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00
        .byte $ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00

    L_ffb6:
        .byte $ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00
        .byte $ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00
        .byte $ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00
        .byte $ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00
        .byte $ff,$ff,$ff,$ff

    L_fffa:
        ora $bf,x

        .byte $00,$67

    L_fffe:
        nop 
