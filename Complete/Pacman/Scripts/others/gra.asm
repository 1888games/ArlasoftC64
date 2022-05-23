//Standard imports
#import "./syslabels.asm"

//Potential screen buffer locations
.label SCREEN_BUFFER_0 = $0400
.label SCREEN_BUFFER_1 = $0800

    

        BasicUpstart2(Setup)



       // * = $5

    * = $500
    Setup:
  

      lda #$37
        sta $01
       // cli

        .break
    jmp $8000

  //  Setup:

   // lda #$37
    //sta $01
   // cli

   // jmp $8000
//Start of disassembled code
//* = $0800 "Base Address"

       // .byte $00,$00,$00,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
   
    * = $810

        .byte $78,$ad,$11,$d0,$48,$a0,$00,$8c,$11,$d0,$ad,$02,$dd,$29,$fb,$8d
        .byte $02,$dd,$a9,$78,$8d,$0e,$09,$a9,$08,$8d,$0f,$09,$20,$79,$08,$8d
        .byte $8c,$08

    * = $0832

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
        dec SCREEN_BUFFER_1 + $8c
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



        .byte $00,$8d,$13,$d4,$a2,$f0,$8e,$14,$d4,$a2,$81,$8e,$12,$d4,$a0,$8f
        .byte $8c,$18,$d4,$a0,$02,$a9,$ff

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
        sta SCREEN_BUFFER_1 + $83
        pha 
        jsr $902c
        pla 
        jsr L_8eca

        .byte $24,$80,$a9,$0a,$00,$00,$00,$00,$00,$af,$b0,$b2

    L_0908:
        lda ($00),y

        .byte $00,$00,$ca

    L_090d:
        .byte $cb,$00,$80,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
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
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
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

    L_0cfd:
        .byte $ff,$00,$00,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00

    L_0d0d:
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00

    L_0d1d:
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

    L_0d9d:
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00

    L_0dbd:
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00

    L_0ddd:
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
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

    L_0e9d:
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff

    L_0efd:
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
        .byte $00

    L_0ffe:
        .fill $52, $ff
        .byte $b5,$b4,$b4,$b4,$b4,$c5,$c6,$c7,$c7,$c8,$c9,$ca,$c6,$cb,$c7,$cc
        .byte $b4,$b4,$c4,$b4,$b4,$b4,$cd,$b4,$ca,$b4,$c5,$ce,$cf,$c7,$b4,$b4
        .byte $b4,$b4,$8a,$89,$89,$89,$89,$89,$89,$89,$89,$89,$89,$8b,$c4,$b4
        .byte $b4,$d0,$cc,$ca,$d1,$cb,$c7,$d1,$c5,$d2,$c7,$ce,$d1,$b4,$b4,$c4
        .byte $b4,$c9,$d3,$cc,$c6,$d4,$b4,$d5,$cc,$ce,$d5,$cb,$c7,$d2,$b4,$b8
        .byte $b4,$b9,$ba,$ba,$ba

    L_10a5:
        tsx 
        tsx 
        tsx 
        tsx 
    L_10a9:
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
        .byte $58,$58,$58,$58,$58,$58,$58

    L_11a2:
        cli 
        cli 
        eor L_5856 + $2,y
        cli 
        cli 
        cli 
        cli 
        cli 
        cli 
        cli 
        eor L_5856 + $2,y
        cli 
        sta $aba7

        .byte $ab,$ab,$ab,$ab,$ab,$ab,$ab,$ab,$aa,$ab,$ab,$a3,$59,$58,$58,$58
        .byte $58,$58,$58,$58,$58,$58,$59,$58,$58,$58,$58,$58,$58,$58,$58,$58
        .byte $58,$58,$58,$58,$19,$58,$16,$85,$56,$bd,$b4,$b4,$c1,$56,$56,$08
        .byte $15,$56,$56,$56,$56,$56,$56,$56,$56,$56,$56,$56,$56,$56,$56,$57
        .byte $56,$56,$56,$56,$56,$56,$56,$56,$56,$57,$56,$56,$56,$56,$56,$56
        .byte $a6,$c2,$c2,$c2,$c2,$c2,$c2,$c2,$c2,$c2,$c2,$a5,$57,$56,$56,$56
        .byte $56,$56,$56,$56,$56,$56,$57,$56,$56,$56,$56,$56,$56,$56,$56,$56
        .byte $56,$56,$56,$56,$1b,$1a,$1c,$56,$56,$bd,$b4,$b4,$c1,$56,$56,$57
        .byte $56,$56,$56,$56,$56,$56,$56,$56,$56,$56,$56,$56,$56,$56,$56,$57
        .byte $56,$56,$56,$56,$56,$56,$56,$56,$56,$57
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
        .byte $05,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$03,$ff,$ff,$ff,$ff,$ff
        .byte $ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$03,$ff,$ff,$bc,$b8,$b4
        .byte $c0,$ff,$ff,$03,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff
        .byte $ff,$ff,$ff,$03
        .fill $26, $ff
        .byte $03,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff
        .byte $03,$ff,$ff,$bc,$b4,$b5,$c0,$ff

    L_1373:
        .byte $ff,$03,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff
        .byte $ff,$03
        .fill $26, $ff
        .byte $03,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff
        .byte $03,$ff,$ff,$bc,$b4,$b4,$c0,$ff,$ff,$03,$ff,$ff,$ff,$ff,$ff,$ff
        .byte $ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$03
        .fill $12, $ff
        .byte $11,$12

    L_13e9:
        .fill $12, $ff
        .byte $03,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff
        .byte $03,$ff,$ff,$bc,$b4,$b4,$c1,$56,$56,$57,$56,$56,$56,$56,$56,$56
        .byte $56,$56,$56,$56,$56,$56,$56,$56,$56,$57
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

    L_1555:
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
        .byte $57,$56,$56,$56,$56,$b4,$c1,$56,$56

    L_1c84:
        php 
        adc ($61,x)
        adc ($61,x)
        adc ($61,x)
        adc ($61,x)
        adc ($61,x)
        adc ($61,x)
        adc ($61,x)
        adc ($61,x)
        adc ($61,x)
        adc ($61,x)
        adc ($61,x)
        adc ($61,x)
        adc ($61,x)
        rol $61
        adc ($61,x)
        adc ($61,x)
        adc ($61,x)

        .byte $0c,$0d,$61,$61,$61,$61,$61,$61,$61,$27
        .fill $1a, $61
        .byte $0a,$56,$56,$56,$56,$b5,$c0,$ff,$ff,$09
        .fill $1a, $6
        .byte $29,$06,$06,$06,$06,$06,$06,$06,$0e,$0f,$06,$06,$06,$06,$06,$06
        .byte $06,$28
        .fill $1a, $6
        .byte $0b,$ff,$ff,$ff,$ff,$b4,$c0,$ff,$ff,$03
        .fill $1a, $ff
        .byte $50,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff
        .byte $ff,$3e
        .fill $1a, $ff
        .byte $03,$ff,$ff,$ff,$ff,$b4,$c0,$ff,$ff,$03
        .fill $1a, $ff
        .byte $51,$4f,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff
        .byte $40,$3f

    L_1da1:
        .fill $1a, $ff
        .byte $03,$ff,$ff,$ff,$ff,$b4,$c0,$ff,$ff,$03
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
        .fill $16, $56

    L_1ea3:
        lsr $56,x
        lsr $56,x
        lsr $56,x
        lsr $56,x

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

    L_1fa5:
        .fill $46, $ff
        .byte $03,$ff,$ff,$bc,$b4,$b5,$c0,$ff,$ff,$03

    L_1ff5:
        .fill $46, $ff
        .byte $03,$ff,$ff,$bc,$b4,$b4,$c0,$ff,$ff,$03

    L_2045:
        .fill $46, $ff
        .byte $03,$ff,$ff,$bc,$b8,$b4,$c1,$56,$56,$57
        .fill $46, $56
        .byte $57,$56,$56,$bd,$b4,$b4,$c1,$56,$56,$57
        .fill $46, $56
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
        lda L_b4b4,x
        cpy #$ff

        .byte $ff,$03,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff
        .byte $ff,$03,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$03
        .fill $12, $ff
        .byte $03,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$03,$ff,$ff,$ff,$ff,$ff
        .byte $ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$03,$ff,$ff,$bc,$b4,$b4
        .byte $c0,$ff,$ff,$03,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff
        .byte $ff,$ff,$ff,$03,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$03,$ff,$ff
        .byte $ff,$95,$92,$92,$92,$92,$92,$92,$92,$92,$92,$92,$97,$ff,$ff,$ff
        .byte $03,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$03,$ff,$ff,$ff,$ff,$ff
        .byte $ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$03,$ff,$ff,$bc,$b4,$b4
        .byte $c0,$ff,$ff,$17,$1e,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff
        .byte $ff,$ff,$ff,$03,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$03,$ff,$ff
        .byte $ff,$96,$8f,$8f,$8f,$8f,$8f,$8f,$8f,$8f,$8f,$8f,$98,$ff,$ff,$ff
        .byte $03,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$03,$ff,$ff,$ff,$ff,$ff
        .byte $ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$24,$23,$17,$ff,$ff,$bc,$b4,$b4
        .byte $c0,$ff,$ff,$1f,$20,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01
        .byte $01,$01,$01,$13,$01,$01,$01,$01,$01,$01,$01,$01,$01,$13,$01,$01
        .byte $01,$99,$93,$93,$93,$93,$93,$93,$93,$93,$93,$93,$9b,$af,$b0,$01
        .byte $13

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
        .fill $18, $56

    L_28a9:
        lsr $56,x
        lsr $56,x
        lsr $bd,x
        ldy $b6,x
        dec $be,x
        ldx L_bebe,y
        ldx L_bebe,y
        ldx L_bebe,y
        ldx L_bebe,y
        ldx L_bebe,y
        ldx L_bebe,y
        ldx L_bebe,y
        ldx L_bebe,y
        ldx L_bebe,y
        ldx L_bebe,y
        ldx L_bebe,y
        ldx L_a2b1,y
        ldx #$a2
        ldx #$a2
        ldx #$a2
        ldx #$a2
        ldx #$be
        ldx L_bebe,y
        ldx L_bebe,y
        ldx L_bebe,y
        ldx L_bebe,y
        ldx L_bebe,y
        ldx L_bebe,y
        ldx L_bebe,y
        ldx L_bebe,y
        ldx L_bebe,y
        ldx L_bfbe,y

        .byte $b7,$b4,$b4,$d7,$d8,$d9,$b4,$da,$db,$dc,$b4,$dd,$d3,$b4,$db,$de
        .byte $dc,$d8,$c9,$b4,$b4,$c4,$b4,$b4,$d7,$df,$e0,$d1,$e1,$b4,$d9,$e2
        .byte $e1,$d3,$e3,$b4,$b4,$c4,$b4,$b4,$e0,$e4,$ce,$e2,$dc,$c5,$da,$e1
        .byte $e3,$b4,$c9,$d8,$da,$dc,$b4,$e0,$d8,$dc,$b4,$b4,$c4,$b4,$b4,$b4
        .byte $b4,$b4,$d7,$da,$e5,$de,$d3,$db,$b4,$da,$de,$ce,$b4,$b4,$b4,$b4
        .byte $b4,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff
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
        .byte $ff,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00
        .byte $00

    L_2a20:
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

    L_2b00:
        .byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$3c
        .byte $3d,$3e,$3f,$00,$00,$00,$00,$00,$00,$00,$00,$00,$40,$41,$00,$00
        .byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$20,$20,$00,$00
        .byte $00,$00,$00,$00,$00,$00,$42,$43,$44,$45,$46,$00,$00,$00,$00,$00
        .byte $00,$00,$00,$47,$48,$49,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
        .byte $00,$00,$00,$00,$20,$20,$00,$00,$00,$00,$00,$00,$00,$00,$4a,$4b
        .byte $4c,$4d,$4e,$4f,$50,$51,$52,$53,$54,$55,$00,$56,$57,$58,$59,$5a
        .byte $5b,$5c,$5d,$5e,$5f,$60,$61,$00,$00,$00,$00,$00,$20,$20,$00,$00
        .byte $00,$00,$00,$00,$00,$00,$62,$63,$64,$65,$66,$67,$68,$69,$6a,$6b
        .byte $6c,$6d,$6e,$6f,$70,$71,$72,$73,$74,$75,$76,$77,$78,$79,$7a,$00
        .byte $00,$00,$00,$00,$20,$20,$00,$00,$00,$7b,$7c,$7d,$7e,$7f,$80,$81
        .byte $82,$83,$84,$85,$86,$7b,$7c,$87,$88,$89,$8a,$8b,$8c,$8d,$8e,$00
        .byte $00,$8f,$90,$86,$91,$8d,$92,$93,$94,$95,$96,$00,$20,$20,$00,$00
        .byte $00,$97,$98,$99,$8e,$9a,$9b,$9c,$9d,$9e,$9f,$a0,$a1,$97,$98,$a2
        .byte $97,$a3,$a0,$a4,$a5,$a6,$8e,$00,$00,$a7,$a8,$a2,$9a,$00,$8e,$97
        .byte $a9,$a5,$aa,$00,$20,$20,$00,$00,$00,$ab,$ac,$ad,$8e,$9a,$a2,$ae
        .byte $8e,$af,$b0,$a0,$a2,$97

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
        .byte $ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00

    L_2ca1:
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

    L_3031:
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00

    L_3061:
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

    L_3121:
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
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00

    L_3251:
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
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff

    L_3571:
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
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff

    L_37b1:
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00

    L_3841:
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

    L_3ed1:
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00

    L_3ef1:
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

    L_3fa1:
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff

    L_3fd1:
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
    L_4144:
        clc 
        clc 

    L_4146:
         .byte $0c,$00,$00,$30,$18
        .byte $18,$18

    L_414d:
        clc 

    L_414e:
         .byte $30,$00,$00,$00

    L_4152:
        bit $18
    L_4154:
        clc 
        bit $00

    L_4157:
         .byte $00,$00
        .byte $18,$18,$7e,$18,$18,$00,$00,$00,$00,$00,$00,$00,$30,$30,$40,$00
        .byte $00,$00,$7e,$7e,$00,$00,$00,$00,$00,$00,$00,$00,$30,$30,$00,$00
        .byte $02,$06,$0c,$18,$30,$60,$00,$00,$7c,$ce,$de,$f6,$e6,$7c,$00,$00
        .byte $30,$70,$30,$30,$30,$fc,$00,$00,$fc,$06,$7c,$c0,$c0,$fe,$00,$00
        .byte $fc,$06,$3c,$06,$06,$fc,$00,$00,$cc,$cc,$cc,$fe,$0c,$0c,$00,$00
        .byte $fe,$c0,$7c,$06,$c6,$7c,$00,$00,$7c,$c0,$fc,$c6,$c6,$7c,$00,$00
        .byte $fe,$0c,$18,$30,$60,$c0,$00,$00,$7c,$c6,$7c,$c6,$c6,$7c,$00,$00
        .byte $7c,$c6,$7e,$06,$c6,$7c,$00,$00,$18,$18,$00,$18,$18,$00,$00,$00
        .byte $18,$18,$00,$18,$08,$10,$00,$00,$00,$00,$00,$00,$00,$00,$01,$00
        .byte $00,$00,$00,$01,$15,$56,$6a,$00,$00,$00,$14,$55,$69,$aa,$aa,$00
        .byte $00,$00,$00,$00,$00,$40,$40,$00,$00,$00,$00,$01,$05,$16,$5a

    L_4208:
        .byte $00,$00,$00
        .byte $40,$50,$90,$a4,$a4,$00,$00,$00,$01,$01,$05,$06,$16,$05,$16,$5a
        .byte $6a,$a9,$a5

    L_421e:
        sty $50,x
    L_4220:
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
        .byte $40

    L_43d2:
        .byte $00,$00,$00,$00,$00,$00
        .byte $2a,$2a,$2a,$2a,$02,$02,$02,$02,$a8,$a8,$a8,$a8,$80,$80,$80,$80
        .byte $a0,$a0,$a0,$a0,$a8,$a8,$a8,$a8,$a2,$a2,$a2,$a2,$a0,$a0,$a0,$a0
        .byte $aa,$aa,$aa,$aa,$28,$28,$28,$28,$89,$89,$85,$86,$16,$1a,$5a,$6a
        .byte $69,$a9,$a4,$a4,$90,$90,$90,$40,$aa,$aa,$aa,$aa,$a0,$a0,$a0,$a0
        .byte $82,$82,$a2,$a2,$a2,$a2,$a2,$a2

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

    L_4544:
        txa 
        txa 
        txa 
        txa 

        .byte $80,$80,$a8,$a8

    L_454c:
        tay 
    L_454d:
        tay 

    L_454e:
         .byte $80,$80

    L_4550:
        plp 
        plp 
    L_4552:
        ldy #$a0
        ldy #$a0
    L_4556:
        ldy #$a0

        .byte $02,$02,$02,$02,$2a,$2a,$2a,$2a,$80,$80,$80,$80,$a8,$a8,$a8,$a8
        .byte $a2,$a2,$a0,$a0,$a0,$a0,$a0,$a0,$00,$00,$00,$00,$a8,$a8,$a8,$a8
        .byte $a2,$a2,$a2,$a2,$a2,$a2,$a2,$a2,$8a,$8a,$82,$82,$82,$82,$82,$82
        .byte $0a,$0a,$0a,$0a,$aa,$aa,$aa,$aa,$02,$02,$02,$02,$a2,$a2,$a2,$a2
        .byte $82,$82,$82,$82,$aa,$aa,$aa,$aa,$2a,$2a,$0a,$0a,$0a,$0a,$0a,$0a
        .byte $a0,$a0,$a0,$a0,$aa,$aa,$aa,$aa,$00,$00,$00,$00,$a0,$a0,$a0,$a0
        .byte $a2,$a2,$a2,$a2,$aa,$aa,$aa,$aa,$28,$28,$28,$28,$2a,$2a,$2a,$2a
        .byte $00,$00,$28,$28,$a8,$a8,$a8,$a8,$02,$02,$a2,$a2,$a2,$a2,$a2,$a2
        .byte $80,$80,$80,$80,$aa,$aa,$aa,$aa,$2a,$2a,$2a,$2a,$2a,$2a,$00,$00
        .byte $a8,$a8,$a8,$a8,$a8,$a8,$00,$00,$a0,$a0,$a0,$a0,$a0,$a0,$00,$00
        .byte $28,$28,$28,$28,$28,$28,$00,$00,$0a,$0a,$0a,$0a,$0a,$0a,$00,$00
        .byte $a2,$a2,$a2,$a2,$a2,$a2,$00,$00,$82,$82,$82,$82,$82,$82,$00,$00
        .byte $8a,$8a,$8a,$8a,$8a,$8a,$00,$00,$02,$02,$02,$02,$02,$02,$00,$00
        .byte $80,$80,$80,$80,$80,$80,$00,$00,$aa,$aa,$aa,$aa,$aa,$aa,$00,$00
        .byte $a2,$a2,$a0,$a0,$a0,$a0,$00,$00,$aa,$aa,$aa,$aa,$28,$28,$00,$00
        .byte $8a,$8a,$0a,$0a,$0a,$0a

    L_464e:
        .byte $00,$00
        .byte $aa,$aa,$aa,$aa,$2a,$2a,$00,$00,$8a,$8a,$82,$82,$00,$00,$00,$00
        .byte $aa,$aa,$a8,$a8,$a0,$a0,$00,$00,$2a,$2a,$0a,$0a,$02,$02,$00,$00
        .byte $a8,$a8,$a0,$a0,$80,$80,$00,$00,$aa,$aa,$2a,$2a,$0a,$0a,$00,$00
        .byte $a2,$a2,$82,$82,$02,$02

    L_4686:
        .fill $17a, $0

    L_4800:
        .fill $78, $ff

    L_4878:
        .byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$3c
        .byte $3d,$3e,$3f,$00,$00,$00,$00,$00,$00,$00,$00,$00,$40,$41,$00,$00
        .byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$20,$20,$00,$00
        .byte $00,$00,$00,$00,$00,$00,$42,$43,$44,$45,$46,$00,$00,$00,$00,$00
        .byte $00,$00,$00,$47,$48,$49,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
        .byte $00,$00,$00,$00,$20,$20,$00,$00,$00,$00,$00,$00,$00,$00,$4a,$4b
        .byte $4c,$4d,$4e,$4f,$50,$51,$52,$53,$54,$55,$00,$56,$57,$58,$59,$5a
        .byte $5b,$5c,$5d,$5e,$5f,$60,$61,$00,$00,$00,$00,$00,$20,$20,$00,$00
        .byte $00,$00,$00,$00,$00,$00,$62,$63,$64,$65,$66,$67,$68,$69,$6a,$6b
        .byte $6c,$6d,$6e,$6f,$70,$71,$72,$73,$74,$75,$76,$77,$78,$79,$7a,$00
        .byte $00,$00,$00,$00,$20,$20,$00,$00,$00,$7b,$7c,$7d,$7e,$7f,$80,$81
        .byte $82,$83,$84,$85,$86,$7b,$7c,$87,$88,$89,$8a,$8b,$8c,$8d,$8e,$00
        .byte $00,$8f,$90,$86,$91,$8d,$92,$93,$94,$95,$96,$00,$20,$20,$00,$00
        .byte $00,$97

    L_4944:
        tya 
        sta L_9a8e,y

    L_4948:
         .byte $9b,$9c
        .byte $9d,$9e,$9f

    L_494d:
        ldy #$a1

        .byte $97,$98,$a2,$97,$a3,$a0,$a4,$a5,$a6,$8e,$00,$00,$a7,$a8,$a2,$9a
        .byte $00,$8e,$97,$a9,$a5,$aa,$00,$20,$20,$00,$00,$00,$ab,$ac,$ad,$8e
        .byte $9a,$a2,$ae,$8e,$af,$b0,$a0,$a2,$97

    L_4978:
        tya 
    L_4979:
        lda ($b2),y

        .byte $b3,$a0,$b4,$9a,$9a,$b5,$b6,$00,$b7,$a0,$b1,$b8,$b9,$b5,$ba,$bb
        .byte $9a,$9a,$00,$20,$20,$00,$00,$00,$bc,$bd,$be,$be,$bf,$c0,$bd,$be
        .byte $c1,$c2,$c3,$c0,$c4,$c5,$c6,$c7,$c8,$c9,$c0,$bf,$bf,$c6,$be,$00
        .byte $ca,$cb,$cc,$cd,$ce,$cf,$d0,$c6,$bf,$bf,$00,$20,$20,$ff

    L_49b9:
        .fill $84, $ff
        .byte $08,$01,$0c,$06,$ff,$0c,$05,$0e,$07,$14,$08

    L_4a48:
        .byte $ff,$3a,$ff,$32
        .byte $2e,$30,$30,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff
        .byte $ff,$ff,$ff,$0e,$15,$0d,$02,$05,$12,$ff,$0f,$06,$ff,$10,$0c,$01
        .byte $19,$05,$12,$13,$ff,$3a,$ff,$0f,$0e,$05
        .fill $13, $ff
        .byte $10,$0c,$01,$19,$05,$12,$ff,$31,$ff,$03,$0f,$0c,$0f,$15,$12,$ff
        .byte $3a,$ff,$19,$05,$0c,$0c,$0f,$17,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff
        .byte $ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$10,$0c,$01,$19,$05,$12,$ff,$32
        .byte $ff,$03,$0f,$0c,$0f,$15,$12,$ff,$3a,$ff,$17,$08,$09,$14,$05,$ff

    L_4ac9:
        .fill $67, $ff
        .byte $0b,$09,$03,$0b,$ff,$0f,$06,$06

    L_4b38:
        .fill $60, $ff

    L_4b98:
        .byte $12
        .byte $01,$10,$08,$09,$03,$13,$20,$02,$19,$20,$0e,$05,$09,$0c,$20,$08
        .byte $09,$13,$0c,$0f,$10,$2c,$20,$20,$0d,$15,$13,$09,$03,$20,$26,$20
        .byte $06,$18,$20,$02,$19,$20,$01
        .fill $38, $ff

    L_4bf8:
        lda.a $00b9,y

    L_4bfb:
         .byte $00,$00,$00,$ff,$00
        .fill $50, $56

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
        .fill $22, $ff
        .byte $36,$35,$34,$06,$ff,$ff,$06,$2a,$33,$32
        .fill $1c, $ff
        .byte $38,$37,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$31,$30,$ff,$ff
        .byte $ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$56,$56,$56,$56
        .byte $56,$56,$56,$56,$56,$56,$56,$77,$78,$56,$56,$56,$56,$56,$56,$56
        .byte $56

    L_4d55:
        lsr $56,x
        lsr $56,x

        .byte $7c,$7d
        .fill $17, $56
        .byte $79,$7a,$56,$56,$56,$56,$56,$56,$56,$56,$56,$56,$56,$56,$56,$56
        .byte $7e,$7f
        .fill $16, $56
        .byte $7b,$56,$56,$56,$56,$56,$56,$56,$56,$56,$56,$56,$56,$56,$56,$56
        .byte $56,$80,$56,$56,$56,$56,$56,$56,$56,$56,$56,$56,$56,$56,$61,$61
        .byte $61,$61,$61,$61,$61,$61,$61,$61,$26,$61,$61,$61,$61,$61,$61,$61
        .byte $0c,$0d,$61,$61,$61,$61,$61,$61,$61,$27,$61,$61,$61,$61,$61,$61
        .byte $61,$61,$61,$61,$61,$61,$06,$06,$06,$06,$06,$06,$06,$06,$06,$06
        .byte $29,$06,$06,$06,$06,$06,$06,$06,$0e,$0f,$06,$06,$06,$06,$06,$06
        .byte $06,$28,$06,$06,$06,$06,$06,$06,$06,$06,$06,$06,$06,$06,$ff,$ff
        .byte $ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$50,$ff,$ff,$ff,$ff,$ff,$ff,$ff
        .byte $ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$3e
        .fill $16, $ff
        .byte $51,$4f

    L_4e3c:
        .byte $ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff
        .byte $40,$3f

    L_4e4c:
        .fill $17, $ff
        .byte $4e,$4d,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$42,$41
        .byte $ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$56,$56,$56
        .byte $56,$56,$56,$56,$56,$56,$56,$56,$56,$72,$73,$56,$56,$56,$56,$56
        .byte $56,$56,$56,$56,$56,$70,$71
        .fill $1c, $56
        .byte $74,$75,$76,$61,$56,$56,$61,$6d,$6e,$6f
        .fill $22, $56
        .byte $62,$62
        .fill $3c, $56

    L_4f20:
        .fill $53, $ff

    L_4f73:
        .byte $ef,$ef

    L_4f75:
        inc L_f0ef

        .fill $18, $ff

    L_4f90:
        .byte $ef,$f0,$ed,$f4,$f4
        .fill $2b, $ff
        .fill $16, $56

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
        .byte $00,$0c,$00,$00,$00,$00,$ff,$00,$00,$00,$00,$0f,$00,$00,$0f,$00
        .byte $00,$0f,$00,$00,$3a,$c0,$00,$2a,$80,$00,$0a,$40,$00,$0a,$40,$00
        .byte $0a,$00,$00,$0f,$00,$00,$0d,$00,$00,$0d,$00,$00,$0d,$00,$00,$02
        .byte $00,$00,$03

    L_502b:
        cpy #$00

        .byte $00,$f3,$00,$00,$ff,$00,$00,$3f,$c0,$00,$03,$c0,$00,$00,$00,$00
        .byte $00,$00,$00,$0f,$00,$00,$0f,$00,$00,$0f,$00,$00,$3a,$c0,$00,$2a

    L_504d:
        .byte $80,$00,$1a
        .byte $40,$00,$0a,$00,$00,$0a,$00,$00,$0f,$00,$00,$05,$00,$00,$05,$00

    L_5060:
        .byte $00,$0b,$00,$00,$0f,$00,$00,$00,$00,$00,$00,$c3,$00,$00,$f3,$00
        .byte $00,$3f,$c0,$00,$3f,$f0,$00,$00,$f0,$00,$00,$00,$00,$00,$00,$00
        .byte $00,$00,$00,$0f,$00,$00,$0f,$00,$00,$0f,$00,$00,$3a,$c0,$00,$2a
        .byte $80,$00,$1a,$00,$00,$1a,$00,$00,$0a,$00,$00,$0f,$00,$00,$07,$00
        .byte $00,$07,$00,$00,$07,$00,$00,$08,$00,$00,$0c,$30,$00,$03,$f3,$00
        .byte $00,$ff,$00,$00,$3f,$c0,$00,$0f,$c0,$00,$00,$00,$00,$00,$00,$00
        .byte $0f,$00,$00,$0f,$00,$00,$0f,$00,$00,$3a,$c0,$00,$2a,$80,$00,$1a
        .byte $40,$00,$0a,$00,$00,$0a,$00,$00,$0f,$00,$00,$05,$00,$00,$06,$00

    L_50e0:
        .byte $00,$0f,$00,$00,$0c,$00,$00,$00,$00,$00,$00,$30,$00,$00,$f0,$00
        .byte $00,$ff

    L_50f2:
        cpy #$00

    L_50f4:
         .byte $3f,$f0,$00,$03,$f0,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$0f
        .byte $00,$00,$0f,$00,$00,$0f,$00,$00,$0b,$00,$00,$0a,$80,$00,$09,$40
        .byte $00,$09,$40,$00,$0e,$00,$00,$0f,$40,$00,$34,$40,$00,$34,$b0,$00

    L_5124:
        .byte $30,$c0,$00,$00,$00,$00,$00,$3c,$00,$00,$ff,$00,$03,$ff
        .byte $c0,$00,$03,$c0,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$0f,$00
        .byte $00,$0f,$00,$00,$0f,$00,$00,$0b,$00,$00,$1a,$80,$00,$1a,$40,$00
        .byte $0a,$40,$00,$0e,$00,$00,$0f,$00,$00,$05,$00,$00,$39,$00,$00,$31
        .byte $00,$00,$02,$c0,$00,$03,$00,$00,$03,$c0,$00,$00,$ff,$00,$00,$3f
        .byte $f0,$00,$00,$f0,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$0f,$00
        .byte $00,$0f,$00,$00,$0f,$00,$00,$0b,$00,$00,$1a,$80,$00,$1a,$40,$00
        .byte $1a,$00,$00,$1e,$00,$00,$0f,$00,$00,$07,$00,$00,$07,$c0,$00,$04
        .byte $00,$00,$08,$00,$00,$30,$30,$00,$0c,$0c,$00,$0c,$3c,$00,$03,$ff
        .byte $f0,$00,$0f,$f0,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
        .byte $00,$0f,$00,$00,$0f,$00,$00,$0f,$00,$00,$0b,$00,$00,$1a,$80,$00
        .byte $1a,$40,$00,$0a,$40,$00,$0e,$00,$00,$0f,$00,$00,$37,$00,$00,$37
        .byte $c0,$00,$33,$00,$00,$00,$00,$00,$00,$0c,$00,$00,$3f,$00,$03,$ff
        .byte $c0,$00,$03,$c0,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$0f,$00
        .byte $00,$0f,$00,$00,$0f,$00,$00,$0b,$00,$00,$0a,$80,$00,$09,$40,$00
        .byte $09,$40,$00,$0e,$00,$00,$0f,$00,$00,$0d,$00,$00,$0e,$00,$00,$0f
        .byte $00,$00,$0c,$00,$00,$03,$00,$00,$03,$f0,$00,$00,$ff,$00,$00,$3f
        .byte $f0,$00,$00,$f0,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$0f

    L_5241:
        .byte $00,$00,$0f,$00,$00,$0f,$00,$00,$0b,$00,$00,$1a,$80,$00,$1a

    L_5250:
        rti 

        .byte $00,$0a,$40,$00,$0e,$00,$00,$0f,$00,$00,$06,$40,$00,$07,$40,$00
        .byte $04,$c0,$00,$08,$00,$00,$30,$00,$00,$0c,$3c,$00,$0f,$ff,$00,$00
        .byte $ff,$f0,$00,$00,$f0,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
        .byte $00,$00,$03,$00,$00,$0d,$00,$00,$0d,$00,$00,$0d,$00,$00,$2b,$00
        .byte $00,$5a,$f0,$00

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
        .byte $03,$00,$00,$03,$c0,$00,$03,$f0,$00,$00,$ff,$00,$00,$3f,$c0,$00
        .byte $03,$c0,$00,$00,$00,$00,$00,$00,$00,$03,$00,$00,$0d,$00,$00,$0d
        .byte $00,$00,$0d,$00,$00,$0b,$00,$00,$16,$00,$00,$1a,$c0,$00,$0a,$00
        .byte $00,$0f,$00,$00,$0d,$40,$00,$0c,$40,$00,$0c,$80,$00,$30,$f0,$00
        .byte $30,$00,$00,$0c,$0f,$00,$0f,$fc,$00,$00,$ff,$00,$00,$3f,$c0,$00
        .byte $03,$c0,$00,$00,$00,$00,$00,$00,$00,$03,$00,$00,$0f,$00,$00,$0d
        .byte $00,$00,$0d,$00,$00,$09,$00,$00,$2a,$00,$00,$1a,$40,$00,$16,$00
        .byte $00,$07,$00,$00,$0f,$40,$00,$04,$40,$00,$06,$00,$00,$07,$00,$00
        .byte $08,$00,$00,$0c,$c0,$00,$03,$30,$00,$03,$fc,$00,$00,$ff,$00,$00
        .byte $0f,$00,$00,$00,$00,$00

    L_543d:
        .byte $00,$00,$00,$00,$00,$00,$03,$00,$00,$0f,$00,$00
        .byte $0d,$00,$00

    L_544c:
        ora.a $0000
    L_544f:
        and.a $0000,y

    L_5452:
         .byte $3a,$00,$00
        .byte $06,$00,$00,$06,$00,$00,$09,$00,$00,$0f,$40,$00,$04,$40,$00,$04
        .byte $80,$00,$34,$f0,$00

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
        .byte $00,$00,$00,$00,$00,$00,$03,$00,$00,$0f,$00,$00

    L_5546:
        ora.a $0000
        ora.a $0000
        and #$00

        .byte $00

    L_554f:
        ror 
    L_5550:
        cpy #$00

    L_5552:
         .byte $5a

    L_5553:
        rti 

        .byte $00,$1a,$50,$00,$0b,$00,$00,$0f,$00,$00,$0d,$00,$00,$0d,$00,$00
        .byte $01,$00,$00,$01,$00,$00,$02,$00,$00,$03,$00,$00,$03,$ff,$00,$03
        .byte $ff,$00,$00,$0f,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$0f
        .byte $00,$00,$0f,$00,$00,$05,$00,$00,$35,$c0,$00,$2b,$80,$00,$3a,$40
        .byte $00,$1a,$40,$00,$0a,$00,$00,$0f,$00,$00,$0d,$00,$00,$0d,$00,$00
        .byte $0d,$00,$00,$02,$00,$00,$03,$cc,$00,$00,$f3,$00,$00,$ff,$00,$00
        .byte $3f,$c0,$00,$03,$c0,$00,$00,$00,$00,$00,$00,$00,$0f,$00,$00,$0f
        .byte $00,$00,$05,$00,$00,$35,$c0,$00,$2b,$90,$00,$1a,$10,$00

    L_55d2:
        asl $00,x

        .byte $00,$0a,$00,$00,$0f,$00,$00,$05,$00,$00,$05,$00,$00,$0d,$00,$00
        .byte $02,$00,$00,$03,$00,$00,$00,$c3,$00,$00,$f3,$00,$00,$3f,$c0,$00
        .byte $3f,$f0,$00,$00,$f0,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$0f
        .byte $00,$00,$0f,$00,$00,$05,$00,$00,$35,$80,$00,$2b,$c0,$00,$1a,$40
        .byte $00,$1a,$00,$00,$0a,$00,$00,$0f,$00,$00,$07,$00,$00,$07,$00,$00
        .byte $07,$00,$00,$08,$00,$00,$0c,$30,$00,$03,$f3,$00,$00,$ff,$00,$00
        .byte $3f,$c0,$00,$0f,$c0,$00,$00,$00,$00,$00,$00,$00,$0f,$00,$00,$0f
        .byte $00,$00,$05,$00,$00,$35,$c0,$00,$6b,$80,$00

    L_564f:
        lsr 
        rti 

        .byte $00,$09,$40,$00,$0a

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

    L_5720:
         .byte $00
        .byte $11,$30,$00,$20,$00,$00,$30,$00,$00,$c0,$00,$00,$0c,$0c,$00,$0f
        .byte $ff,$00,$00,$ff,$f0,$00,$0c,$f0,$00,$00,$00,$00,$00,$00,$00,$0c
        .byte $00,$00,$0f,$00,$00,$07,$00,$00,$07,$00,$00,$06,$c0,$00

    L_574f:
        asl 
        cpy #$00
        ora #$00

        .byte $00,$09,$00,$00,$06,$00,$00,$0f,$00,$00,$05,$00,$00,$09,$c0,$00
        .byte $03,$c0,$00,$0c,$00,$00,$03,$0c,$00,$00,$fc,$00,$00,$3f,$00,$00
        .byte $0f,$f0,$00,$00,$f0,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$0c
        .byte $00,$00,$0f,$00,$00,$07,$00,$00,$07,$00,$00,$06,$c0,$00,$0a,$80
        .byte $00,$1a,$40,$00,$09,$40,$00,$0d,$00,$00,$0f,$00,$00,$07

    L_57a2:
        cpy #$00

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
        .byte $00

    L_583a:
        .byte $00,$00,$00,$00,$00,$00,$0c,$00,$00,$07,$00,$00,$07,$00,$00,$07
        .byte $00,$00,$0e,$00,$00,$09,$40,$00,$3a,$40,$00,$0a

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
        .byte $00,$0c,$00,$00,$0c,$00,$00,$03,$30,$00,$00,$fc,$00,$00,$3f,$f0
        .byte $00,$00,$f0,$00,$00,$00,$00,$00,$00,$00,$0f,$00,$00,$0f,$00,$00
        .byte $0f,$00,$00,$0e,$00,$00,$2a,$40,$00,$1a,$40,$00,$0a,$40,$00,$0b
        .byte $40,$00,$0f,$00,$00,$0d,$00,$00,$3d,$00,$00,$01,$00,$00,$02,$00
        .byte $00,$00,$c0,$00,$03,$00,$00,$03,$cc,$00,$00,$ff,$00,$00,$3f,$f0
        .byte $00,$00,$f0,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$0f,$00,$00
        .byte $0f,$00,$00,$0f,$00,$00,$0e,$00,$00,$2a,$40,$00,$1a,$40,$00,$1a
        .byte $00,$00,$0b,$00,$00,$0f,$00,$00,$0d,$c0,$00,$3d,$c0,$00,$0c,$c0
        .byte $00,$00,$00,$00,$00,$00,$00,$0f,$30,$00,$03,$fc,$00,$00,$3f,$c0
        .byte $00,$03,$c0,$00,$00,$00,$00,$00,$00,$00,$0f,$00,$00,$0f,$00,$00
        .byte $0f,$00,$00,$0e,$00,$00,$2a,$00,$00,$16,$00,$00,$16,$00

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
        .byte $0f,$40,$00,$0f,$00,$00,$0f,$00,$00,$0a,$80,$00,$06,$80,$00,$05
        .byte $70,$00,$03,$f4,$00,$01,$4b

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
        .byte $00,$00,$e9,$00,$01,$f1,$00,$05,$f1,$00,$e7,$70,$00,$ff,$ff,$c0
        .byte $00,$ff,$f0,$00,$03,$c0
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
        .byte $00,$00,$0a,$00,$00,$0a,$00,$00,$0a,$00,$00,$0f,$00,$00,$07,$00
        .byte $00,$05,$00,$00,$05,$00,$00,$05,$00,$00,$0a,$00,$00,$0f,$c0,$00
        .byte $03,$ff,$00,$00,$3f,$c0,$00,$0f,$f0,$00,$00,$fc,$00,$10,$00,$00
        .byte $10,$40,$00,$1f,$40,$00,$1f,$40,$00,$2f,$40,$00,$2b,$80,$00,$0a
        .byte $80,$00,$0a,$00,$00,$0a,$00,$00,$0e,$00,$00,$0f,$00,$00,$07,$00
        .byte $00,$05,$00,$00,$05,$00,$00,$09,$00,$00,$0e,$c0,$00,$03,$f0,$00
        .byte $00,$fc,$00,$00,$3f,$00,$00,$0f,$f0,$00,$00,$f0,$00,$00,$00,$00
        .byte $04,$00,$00,$0f,$10,$00,$0f,$10,$00,$2f,$10,$00,$2b,$80,$00,$0a
        .byte $80,$00,$0a,$00,$00,$0a,$00,$00,$0e,$00,$00,$0f,$00,$00,$07,$00
        .byte $00,$05,$00,$00,$05,$00,$00,$09,$00,$00,$0e,$c0,$00,$03,$f0,$00
        .byte $00,$fc,$00,$00,$3f,$00,$00,$0f,$f0,$00,$00,$f0,$00,$04,$00,$00
        .byte $04,$00,$00,$07,$00,$00,$05,$00,$00,$05,$00,$00,$09,$00,$00,$0b
        .byte $00,$00,$0a,$00,$00,$0a,$00,$00,$0a,$00,$00,$0f,$00,$00,$0f,$00
        .byte $00,$07,$00,$00,$07,$00,$00,$07,$00,$00,$0b,$00,$00,$0f,$00,$00
        .byte $03,$fc,$00,$00,$ff,$c0,$00,$3f,$f0,$00,$00,$f0,$00,$00,$00,$00
        .byte $00,$00,$00,$03,$40,$00,$0d,$40,$00,$0d,$00,$00,$0a,$00,$00,$0b
        .byte $00,$00,$0a,$00,$00,$0a

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
        .byte $00,$03,$ff,$00,$00,$ff,$c0,$00,$3f,$f0,$00,$03,$f0,$00,$00,$00
        .byte $00,$00,$00,$00,$0f,$00,$00,$4f,$00,$00,$4f,$40,$00,$1e,$80,$00
        .byte $2a,$00,$00,$0a,$00,$00,$0a,$00,$00,$0b,$00,$00,$0f,$00,$00,$0d
        .byte $00,$00,$05,$00,$00,$05,$00,$00,$06,$00,$00,$3b,$00,$00,$0f,$c0
        .byte $00,$03,$ff,$00,$00,$ff,$c0,$00,$3f,$f0,$00,$03,$f0
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
        .byte $aa,$9c,$aa,$aa,$af,$aa,$aa,$af,$aa,$aa,$af,$aa,$aa,$af,$aa,$aa
        .byte $af,$aa,$aa,$af,$6a,$aa,$9f,$6a,$aa,$9f,$2a,$aa,$bf,$1a,$aa,$7f
        .byte $06,$a9,$fc,$01,$57,$fc,$00,$ff,$f0,$00,$3f,$c0,$00,$00,$00,$00
        .byte $01,$54,$00,$06,$a9,$00,$1a,$aa

    L_7048:
        rti 

        .byte $1a,$aa,$70,$6a,$aa,$9c,$6a,$aa,$9c,$aa,$aa,$af,$aa,$aa,$af,$aa
        .byte $aa,$af,$aa,$aa,$af,$aa,$aa,$af,$aa,$aa,$af,$6a,$aa,$9f,$6a,$aa
        .byte $9f,$2a,$aa,$bf,$1a,$aa,$7f

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

        .byte $00,$00,$0a

    L_7456:
        rti 

        .byte $00,$0f,$6c,$00,$04,$30,$00,$04,$00,$00,$04,$00,$00,$08,$00,$00
        .byte $0c,$00,$00,$00,$00,$00,$00,$c3,$c0,$00,$3f,$00,$00,$3f,$f0,$00
        .byte $0f,$fc,$00,$00,$fc,$00,$00,$c0,$00,$00,$00,$00,$0f,$10,$00,$0f
        .byte $10,$00

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
        .byte $00,$07,$00,$00,$07,$00,$00,$08,$00,$00,$0c,$30,$00,$03,$f3,$00
        .byte $00,$ff,$00,$00,$3f,$c0,$00,$0f,$c0,$00,$00,$00,$00,$00,$00,$00
        .byte $0f,$00,$00,$4f,$10,$00,$4f,$10,$00

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

    L_7e31:
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
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff

    L_8000:
        cld 
        sei 
    L_8002:
        ldx #$ff
        txs 
        lda #$15
        sta $01
        cli 
        jmp $be71
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
        jsr L_bab7 + $7
    L_802c:
        lda #$00
        sta $ec
        jsr L_853c
        lda #$00
        sta $e008
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
        jsr L_bb93
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
        jsr $b15c
        ldx #$06
        ldy #$07
        jsr L_959e
        jsr $99a3
        jsr $b861
        jsr $bba7
    L_80ab:
        lda #$00
        sta $bd77
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
        sta L_b7c8
        sta $b7c9
        sta $992c
        lda #$1e
        sta L_bd78
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
        sta L_b524
        sta $b7ae
        sta L_b523
        sta L_b7ad
        sta $af7d
        sta $af7a
        sta L_af7b
        sta L_af79
        sta $af78
        sta L_b7b0
        sta L_b7b2
        sta $b7af
        sta $b7b1
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
        sta $a42f
        sta L_a42e
        sta $a632
        sta L_a631
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
        jsr $bd07
        jsr $bba7
        jsr L_9870
        lda $26
        sta $27
        lda $29
        sta $2a
        lda $23
        sta $28
        jsr $acd9
        jsr L_ab8f
        jsr L_aa2c
        jsr $aa8f
        jsr $a7b6
        jsr L_a430
        jsr $bd12
        jsr L_9f8a
        jsr $9caf
        lda $bd77
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
        lda $a42f
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
        jsr $bd07
        jsr L_b18a
        jsr $b10d
        jsr $b0a9
        jsr L_b138
        lda L_880d + $1
        beq L_8236
        jsr $b298
        jsr $b525
        jmp L_8246
    L_8236:
        jsr L_8277
        lda $e5
        bne L_8243
        jsr $b298
        jmp L_8246
    L_8243:
        jsr $b525
    L_8246:
        jsr L_af7e
        jsr L_afd1
        jsr $a9a4
        jsr L_a635
        jsr L_a467
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
        sta L_b7b2
        sta L_c31d + $1
        lda #$05
        sta L_af7b
        lda #$33
        sta $af7a
        jsr L_83d7
        ldy $b7c9
        lda $ab79,y
        sta $af7c
        lda $ab84,y
        sta $af7d
        lda #$01
        sta L_af79
        sta $b7ae
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
        sta L_b7cc
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
        sta L_b7b0
        sta L_c31d + $1
        lda #$05
        sta L_af7b
        lda #$33
        sta $af7a
        jsr L_841d
        ldy L_b7c8
        lda $ab79,y
        sta $af7c
        lda $ab84,y
        sta $af7d
        lda #$01
        sta L_af79
        sta L_b524
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
        sta $b7c9
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
        sta $b7c9
        rts 


    L_83fe:
        lda $b7c9
        ora #$08
        sta $b7c9
        rts 


    L_8407:
        lda $c336
        cmp #$28
        bcc L_8414
        lda #$04
        sta $b7c9
        rts 


    L_8414:
        lda $b7c9
        ora #$04
        sta $b7c9
        rts 


    L_841d:
        lda #$01
        sta L_b7c8
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
        sta L_b7c8
        rts 


    L_8444:
        lda L_b7c8
        ora #$08
        sta L_b7c8
        rts 


    L_844d:
        lda $c336
        cmp #$28
        bcc L_845a
        lda #$04
        sta L_b7c8
        rts 


    L_845a:
        lda L_b7c8
        ora #$04
        sta L_b7c8
        rts 


    L_8463:
        lda #$02
        sta $b7c9
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
        lda $b7c9
        ora #$04
        sta $b7c9
        rts 


    L_8495:
        cmp #$01
        bne L_84ab
        lda L_c31f
        beq L_8485
        cmp #$01
        beq L_84b2
    L_84a2:
        lda $b7c9
        ora #$08
        sta $b7c9
        rts 


    L_84ab:
        lda L_c31f
        cmp #$02
        bne L_84a2
    L_84b2:
        rts 


    L_84b3:
        lda #$01
        sta L_b7c8
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
        lda L_b7c8
        ora #$04
        sta L_b7c8
        rts 


    L_84e7:
        cmp #$01
        bne L_84fd
        lda L_c31f
        beq L_84d7
        cmp #$01
        beq L_8504
    L_84f4:
        lda L_b7c8
        ora #$08
        sta L_b7c8
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
        sta $e006
        sta L_e007
        jsr L_e000
        rts 


    L_8521:
        lda #$02
        sta $e006
        lda #$01
        sta L_e007
        jsr L_e000
        rts 



    L_852f:
         .byte $01,$c6,$00,$6f

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
        sta $8679
        lda #$00
        sta $867a
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
        sta $e006
        lda #$00
        sta L_e007
        jsr L_e009
    L_85d1:
        lda #$c8
        ldx #$cd
        jsr $bd07
        jsr $8811
        jsr $8811
        jsr L_882b
        lda $26
    L_85e3:
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
        lda $867a
        beq L_860b
        dec $867a
        rts 


    L_860b:
        lda #$02
        sta $867a
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
        lda $8679
        clc 
        adc $8676
        sta $8679
        inc L_867b
        rts 



    L_8642:
         .byte $f5,$f6,$f7
        .byte $f8,$f9,$f9,$f9,$fa,$fa,$fb,$fb,$fc,$fc,$fd,$fd,$fd,$fe,$fe,$fe
        .byte $fe,$ff,$ff,$ff,$ff,$ff,$00,$01,$01,$01,$01,$01,$02,$02,$02,$02
        .byte $03,$03,$03,$04,$04,$05,$05,$06,$06,$07,$07,$07,$08,$09,$0a,$0b
        .byte $99,$05,$00

    L_8678:
        lda.a $0072,y
    L_867b:
        and #$ad

        .byte $77,$86,$f0,$04,$ce,$77,$86,$60,$a9,$03,$8d,$77,$86,$ee,$78,$86
        .byte $ad,$78,$86,$c9,$bc,$d0,$05,$a9,$b8,$8d,$78,$86

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
        sta L_4878,y
        lda #$0a
        sta vColorRam + $78,y
        dey 
        bne L_8771
        ldy #$3f
    L_8781:
        lda L_2c00,y
        sta L_4978,y
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
         .byte $01,$01,$04,$30,$da
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

        .byte $07,$85,$26,$85,$26,$e6,$21

    L_881d:
        ldx $21
        lda L_8847,x
        cmp #$ff
        bne L_882a
        lda #$00
        sta $21
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
        sta L_4b98,y
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
        sta L_4800,y
        sta $4900,y
        sta L_49b9 + $47,y
        sta L_4ac9 + $37,y
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
        lda $ff00,y
        pha 
        lda $ff00,y
        sta $ff00,y
        pla 
        sta $ff00,y
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
        jsr $a6df
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
        lda $be5a
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
        jsr $a441
        lda #$99
        sta $c6
        sta $d0
        lda #$04
        sta $cd
        jsr $a7c1
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
        jsr L_a2fb + $2
        jsr L_a313 + $1
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
        sta $af7d
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
        sta $af7d
        lda #$00
        sta $e006
        lda #$01
        sta L_e007
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
        jsr $a6df
        jsr $a736
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
        sta L_bf3d + $3,y
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
        jsr $a441
        lda #$99
        sta $c6
        sta $d0
        lda #$07
        sta $cd
        jsr $a7c1
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
        jsr L_a2fb + $2
        jsr L_a313 + $1
        jsr L_a635
        jsr L_9358
        jsr L_9340
        lda L_939e
        beq L_92ea
        lda #$01
        sta $af7d
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
        sta $af7d
        lda #$00
        sta $e006
        lda #$01
        sta L_e007
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
        sta $e006
        lda #$01
        sta L_e007
        jsr L_e000
        jsr L_96e1
        lda $e5
        bne L_9613
        lda #$07
        sta $e006
        lda #$00
        sta L_e007
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
        sta $e006
        lda #$00
        sta L_e007
        jsr L_e009
    L_962f:
        lda #$00
        jsr $bd07
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
        jsr $bd07
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
        jsr $bd07
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
        jsr $a441
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
        jsr L_a2fb + $2
        jsr L_a313 + $1
        jsr L_984f
        jsr L_984f
        jsr L_984f
        jsr L_984f
        jsr L_984f
        jsr L_a635
        jsr L_a635
        lda $a794
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
        jsr L_a2fb + $2
        jsr L_a313 + $1
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
        jsr $a441
        jsr L_9775
        lda #$00
        sta $e008
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
        jsr $b7e7
        jmp L_9860
    L_985d:
        jsr L_b7cf
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
        sta $be6b
        lda $ea
        sta L_be6a
        jsr $bd79
        lda $be6f
        sta L_4b38 + $3b
        sta L_4f73
        lda L_be70
        sta L_4b38 + $3c
        sta L_4f73 + $1
        lda $eb
        sta L_be6a
        jsr $bd79
        lda $be6f
        sta L_4b38 + $3e
        sta $4f76
        lda L_be70
        sta L_4b38 + $3f
        sta $4f77
        lda #$ee
        sta L_4b38 + $3d
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
        sta L_4b38 + $5a
        sta L_4f90 + $2
        lda $992b
        clc 
        adc #$ef
        sta L_4b38 + $58
        sta L_4f90
        lda L_992a
        clc 
        adc #$ef
        sta L_4b38 + $59
        sta L_4f90 + $1
        lda $9929
        clc 
        adc #$ef
        sta L_4b38 + $5b
        sta L_4f90 + $3
        lda L_9928
        clc 
        adc #$ef
        sta L_4b38 + $5c
        sta L_4f90 + $4
        rts 


    L_9928:
        lda #$3c
    L_992a:
        sta L_aac2
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
        sta $a461
        ldy #$0d
    L_9983:
        lda $99a2
        sta L_c37b,y
        iny 
        cpy #$17
        bne L_9983
        sta $a463
        lda #$01
        sta L_c37b
        lda #$0e
        sta $c37c
        sta $c387
        rts 



    L_999f:
         .byte $d0,$ce

    L_99a1:
        lda $a9b0

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
        jsr $a441
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
        jsr L_a2fb + $2
        jsr L_a313 + $1
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
        jsr L_a2fb + $2
        jsr L_a313 + $1
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
        sta $af7d
        lda $c34d
        bne L_9b07
        lda L_c364
        cmp #$ac
        bcs L_9b07
        lda #$00
        sta $af7d
    L_9b07:
        rts 


    L_9b08:
        lda L_9ca4
        cmp #$01
        bne L_9b2c
        lda #$01
        sta $9ca5
        lda #$02
        sta $af7d
        lda $c34d
        cmp #$02
        bne L_9b2c
        lda L_c364
        cmp #$2d
        bcc L_9b2c
        lda #$00
        sta $af7d
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
        jsr L_a2fb + $2
        jsr L_a313 + $1
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
        sta L_b524
        sta L_c31d
        rts 


    L_9bb5:
        lda #$01
        sta $b7ae
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
        sta $af7d
        jmp L_9bfa
    L_9bd7:
        lda $25
        and #$02
        bne L_9bea
        lda #$a6
        sta L_9ca8
        lda #$02
        sta $af7d
        jmp L_9bfa
    L_9bea:
        lda $25
        and #$08
        bne L_9bfa
        lda #$a4
        sta L_9ca8
        lda #$00
        sta $af7d
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
        sta $af7d
        jmp L_9c40
    L_9c1d:
        lda $25
        and #$02
        bne L_9c30
        lda #$aa
        sta L_9ca8
        lda #$02
        sta $af7d
        jmp L_9c40
    L_9c30:
        lda $25
        and #$04
        bne L_9c40
        lda #$ac
        sta L_9ca8
        lda #$00
        sta $af7d
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
        jsr L_d699 + $c
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
        jsr L_ae55 + $1
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
        jsr $a441
        lda $c6
        pha 
        lda $d0
        pha 
        lda #$99
        sta $c6
        sta $d0
        lda $a42f
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
    L_9d24:
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
        sta $af7d
        jsr L_8515
        lda #$00
        sta L_c31d + $1
        sta L_a42e
        sta $a42f
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
        jsr $a7c1
        lda #$00
        sta L_c31f
        sta $c34d
        lda #$39
        sta $c336
        lda #$37
        sta L_c364
    L_9d7f:
        jsr L_a2fb + $2
        jsr L_a313 + $1
        jsr L_b7fb
        jsr L_b7fb
        jsr L_b7cf
        jsr L_b7cf
        jsr L_b7cf
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
        jsr $a7c1
        lda #$00
        sta L_c31f
        lda #$02
        sta $c34d
        lda #$39
        sta $c336
        lda #$62
        sta L_c364
    L_9ded:
        jsr L_a2fb + $2
        jsr L_a313 + $1
        jsr L_b813
        jsr L_b813
        jsr L_b7cf
        jsr L_b7cf
        jsr L_b7cf
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
    L_9e1f:
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
        jsr L_a2fb + $2
        jsr L_a313 + $1
        ldy $c9
        lda $c336,y
        clc 
        adc #$01
        sta $c336,y
        lda #$08
        sta $a7b4
        jsr $a79a
        jsr $a690
        dec L_a2de
        lda L_a2de
        bne L_9e50
        rts 


    L_9e75:
        lda #$0d
        sta $cd
        jsr $a7c1
        lda #$02
        sta L_c31f
        lda #$00
        sta $c34d
        lda #$6e
        sta $c336
        lda #$37
        sta L_c364
    L_9e90:
        jsr L_a2fb + $2
        jsr L_a313 + $1
        jsr L_b7fb
        jsr L_b7fb
        jsr $b7e7
        jsr $b7e7
        jsr $b7e7
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
        jsr $a7c1
        lda #$02
        sta L_c31f
        lda #$02
        sta $c34d
        lda #$6e
        sta $c336
        lda #$62
        sta L_c364
    L_9f00:
        jsr L_a2fb + $2
        jsr L_a313 + $1
        jsr L_b813
        jsr L_b813
        jsr $b7e7
        jsr $b7e7
        jsr $b7e7
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
        jsr L_a2fb + $2
        jsr L_a313 + $1
        ldy $c9
        lda $c336,y
        sec 
        sbc #$01
        sta $c336,y
        lda #$04
        sta $a7b4
        jsr $a79a
        jsr $a690
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
        .byte $ad,$c2,$9f,$d0,$01,$60

    L_9fe1:
        jsr L_9fe7
        jmp $a036
    L_9fe7:
        lda $a632
    L_9fea:
        bne L_9ff1
        lda L_c526 + $a
        beq L_9ff2
    L_9ff1:
        rts 



    L_9ff2:
         .byte $a4,$c6,$ad,$61,$a4,$99,$7b,$c3,$a9,$02,$8d,$25,$a1,$a9,$94,$e3

    L_a002:
        .byte $7b,$e3,$43,$42
        .byte $4d,$42,$41,$53,$49,$43

    L_a00c:
        .byte $30,$a8
        .byte $41,$a7,$1d,$ad,$f7,$a8,$a4,$ab,$be,$ab,$80,$b0,$05,$ac,$a4,$a9
        .byte $9f,$a8

    L_a020:
        .byte $70,$a8,$27
        .byte $a9,$1c,$a8,$82,$a8,$d1,$a8,$3a,$a9,$2e,$a8,$4a,$a9,$2c,$b8,$67
        .byte $e1,$55,$e1,$64,$e1,$b2,$b3,$23,$b8,$7f,$aa,$9f,$aa,$56,$a8,$9b
        .byte $a6,$5d,$a6,$85

    L_a047:
        tax 
        and #$e1
        lda L_c6e1,x
        sbc ($7a,x)

        .byte $ab,$41,$a6,$39,$bc,$cc,$bc,$58,$bc,$10,$03,$7d,$b3,$9e,$b3,$71
        .byte $bf,$97,$e0,$ea,$b9,$ed,$bf,$64,$e2,$6b,$e2,$b4,$e2,$0e,$e3,$0d
        .byte $b8,$7c,$b7,$65,$b4,$ad,$b7,$8b,$b7

    L_a078:
        cpx.a $00b6

        .byte $b7,$2c,$b7,$37,$b7

    L_a080:
        adc $b869,y
        adc $b852,y

        .byte $7b,$2a,$ba,$7b,$11,$bb,$7f,$7a,$bf,$50,$e8,$af,$46,$e5,$af,$7d
        .byte $b3,$bf,$5a,$d3,$ae,$64,$15

    L_a09d:
        bcs L_a0e4
    L_a09f:
        lsr L_4686 + $3e

        .byte $4f,$d2,$4e,$45,$58,$d4,$44,$41,$54,$c1,$49,$4e,$50,$55,$54,$a3
        .byte $49,$4e

    L_a0b4:
        bvc L_a10b

        .byte $d4,$44,$49,$cd,$52,$45,$41,$c4,$4c

    L_a0bf:
        eor $d4

        .byte $47,$4f,$54,$cf,$52,$55,$ce,$49,$c6,$52,$45,$53,$54,$4f,$52,$c5
        .byte $47,$4f,$53,$55,$c2,$52,$45,$54,$55,$52,$ce,$52,$45,$cd,$53,$54
        .byte $4f,$d0,$4f

    L_a0e4:
        dec L_4157
        eor #$d4
        jmp L_414e + $1

        .byte $c4,$53,$41,$56,$c5,$56,$45,$52,$49,$46,$d9,$44,$45,$c6,$50,$4f
        .byte $4b,$c5,$50,$52,$49,$4e,$54,$a3,$50,$52,$49,$4e,$d4,$43,$4f

    L_a10b:
        lsr L_4ca0 + $34
        eor #$53

        .byte $d4,$43,$4c,$d2,$43,$4d,$c4,$53,$59,$d3,$4f,$50,$45,$ce,$43,$4c
        .byte $4f,$53,$c5,$47,$45,$d4,$4e,$45,$d7,$54,$41,$42,$a8,$54,$cf,$46
        .byte $ce,$53,$50,$43,$a8,$54,$48,$45,$ce

    L_a139:
        lsr $d44f

        .byte $53,$54,$45,$d0,$ab,$ad,$aa,$af,$de,$41,$4e,$c4,$4f,$d2,$be,$bd
        .byte $bc,$53,$47,$ce,$49,$4e,$d4,$41,$42,$d3,$55,$53,$d2,$46,$52,$c5
        .byte $50,$4f,$d3,$53,$51,$d2,$52,$4e,$c4,$4c,$4f,$c7,$45,$58,$d0,$43
        .byte $4f,$d3,$53,$49,$ce,$54,$41,$ce,$41,$54,$ce,$50,$45,$45,$cb,$4c
        .byte $45,$ce,$53,$54,$52,$a4,$56,$41,$cc,$41,$53,$c3,$43,$48,$52,$a4
        .byte $4c,$45,$46,$54,$a4,$52,$49,$47,$48,$54,$a4,$4d,$49,$44,$a4,$47
        .byte $cf,$00,$54,$4f,$4f,$20,$4d,$41,$4e,$59,$20,$46,$49,$4c,$45,$d3
        .byte $46,$49,$4c,$45,$20,$4f,$50,$45,$ce,$46,$49,$4c,$45,$20,$4e,$4f
        .byte $54,$20,$4f,$50,$45,$ce,$46,$49,$4c,$45,$20,$4e,$4f,$54,$20,$46
        .byte $4f,$55,$4e,$c4,$44,$45,$56,$49,$43,$45,$20,$4e,$4f,$54,$20,$50
        .byte $52,$45,$53,$45,$4e,$d4,$4e,$4f,$54,$20,$49,$4e,$50,$55,$54,$20
        .byte $46,$49,$4c,$c5,$4e,$4f,$54,$20,$4f,$55,$54,$50,$55,$54,$20,$46
        .byte $49,$4c,$c5,$4d,$49,$53,$53,$49,$4e,$47,$20,$46,$49,$4c,$45,$20
        .byte $4e,$41,$4d,$c5,$49,$4c,$4c,$45,$47,$41,$4c,$20,$44,$45,$56,$49
        .byte $43,$45,$20,$4e,$55,$4d,$42,$45,$d2,$4e,$45,$58,$54

    L_a229:
        jsr $4957

        .byte $54,$48,$4f,$55,$54,$20,$46,$4f,$d2,$53,$59,$4e,$54,$41,$d8,$52
        .byte $45,$54,$55,$52,$4e,$20,$57,$49,$54,$48,$4f,$55,$54,$20,$47,$4f
        .byte $53,$55,$c2,$4f,$55,$54,$20,$4f,$46,$20,$44,$41,$54,$c1,$49,$4c
        .byte $4c,$45,$47,$41,$4c,$20,$51,$55,$41,$4e,$54,$49,$54,$d9,$4f,$56
        .byte $45,$52,$46,$4c,$4f,$d7,$4f,$55,$54,$20,$4f,$46,$20,$4d,$45,$4d
        .byte $4f,$52,$d9,$55,$4e,$44,$45,$46,$27,$44,$20,$53,$54,$41,$54,$45
        .byte $4d,$45,$4e,$d4,$42,$41,$44,$20,$53,$55,$42,$53,$43,$52,$49,$50
        .byte $d4,$52,$45,$44,$49,$4d,$27,$44,$20,$41,$52,$52,$41,$d9,$44,$49
        .byte $56,$49,$53,$49,$4f

    L_a2b1:
        lsr L_4220
        eor $5a20,y
        eor $52

        .byte $cf,$49,$4c,$4c,$45,$47,$41,$4c,$20,$44,$49,$52,$45,$43,$d4,$54
        .byte $59,$50,$45,$20,$4d,$49,$53,$4d,$41,$54,$43,$c8,$53,$54,$52,$49
        .byte $4e,$47,$20,$54,$4f

    L_a2de:
        .byte $4f
        .byte $20,$4c,$4f,$4e,$c7,$46,$49,$4c,$45,$20,$44,$41,$54,$c1,$46,$4f
        .byte $52,$4d,$55,$4c,$41,$20,$54,$4f,$4f,$20,$43,$4f

    L_a2fb:
        .byte $4d,$50,$4c,$45,$d8,$43
        .byte $41,$4e,$27,$54,$20,$43,$4f,$4e,$54,$49,$4e,$55,$c5,$55,$4e,$44
        .byte $45,$46

    L_a313:
        .byte $27,$44
        .byte $20,$46,$55,$4e,$43,$54,$49,$4f,$ce,$56,$45,$52,$49,$46,$d9,$4c
        .byte $4f

    L_a326:
        eor ($c4,x)

        .byte $9e,$a1,$ac,$a1,$b5,$a1,$c2,$a1,$d0,$a1,$e2,$a1,$f0,$a1,$ff,$a1
        .byte $10,$a2,$25,$a2,$35,$a2,$3b,$a2,$4f,$a2,$5a,$a2,$6a,$a2,$72,$a2
        .byte $7f,$a2,$90,$a2,$9d,$a2,$aa,$a2,$ba,$a2,$c8,$a2,$d5,$a2,$e4,$a2
        .byte $ed,$a2,$00,$a3,$0e,$a3,$1e,$a3,$24,$a3,$83,$a3,$0d,$4f,$4b,$0d
        .byte $00,$20,$20,$45,$52,$52,$4f,$52,$00,$20,$49,$4e,$20,$00,$0d,$0a
        .byte $52,$45,$41,$44,$59,$2e,$0d,$0a,$00,$0d,$0a,$42,$52,$45,$41,$4b
        .byte $00,$a0,$ba,$e8,$e8,$e8,$e8

    L_a38f:
        lda $0101,x
        cmp #$81
        bne L_a3b7
        lda $4a
        bne L_a3a4
        lda $0102,x
        sta $49
        lda $0103,x
        sta $4a
    L_a3a4:
        cmp $0103,x
        bne L_a3b0
        lda $49
        cmp $0102,x
        beq L_a3b7
    L_a3b0:
        txa 
        clc 
        adc #$12
        tax 
        bne L_a38f
    L_a3b7:
        rts 


    L_a3b8:
        jsr L_a408
        sta $31
        sty $32
    L_a3bf:
        sec 
        lda $5a
        sbc $5f
        sta $22
        tay 
        lda $5b
        sbc $60
        tax 
        inx 
        tya 
        beq L_a3f3
        lda $5a
        sec 
        sbc $22
        sta $5a
        bcs L_a3dc
        dec $5b
        sec 
    L_a3dc:
        lda $58
        sbc $22
        sta $58
        bcs L_a3ec
        dec $59
        bcc L_a3ec
    L_a3e8:
        lda ($5a),y
        sta ($58),y
    L_a3ec:
        dey 
        bne L_a3e8
        lda ($5a),y
        sta ($58),y
    L_a3f3:
        dec $5b
        dec $59
        dex 
        bne L_a3ec
        rts 


    L_a3fb:
        asl 
        adc #$3e
        bcs L_a435
        sta $22
        tsx 
        cpx $22
        bcc L_a435
        rts 


    L_a408:
        cpy $34
        bcc L_a434
        bne L_a412
        cmp $33
        bcc L_a434
    L_a412:
        pha 
        ldx #$09
        tya 
    L_a416:
        pha 
        lda $57,x
        dex 
        bpl L_a416
        jsr L_b526
        ldx #$f7
    L_a421:
        pla 
        sta $61,x
        inx 
        bmi L_a421
        pla 
        tay 
        pla 
        cpy $34
        bcc L_a434
    L_a42e:
        bne L_a435
    L_a430:
        cmp $33
        bcs L_a435
    L_a434:
        rts 


    L_a435:
        ldx #$10
    L_a437:
        jmp ($0300)
    L_a43a:
        txa 
        asl 
        tax 
        lda L_a326,x
        sta $22
        lda $a327,x
        sta $23
        jsr L_ffcc
        lda #$00
        sta $13
        jsr L_aad7
        jsr $ab45
        ldy #$00
    L_a456:
        lda ($22),y
        pha 
        and #$7f
    L_a45b:
        jsr L_ab47
        iny 
        pla 
        bpl L_a456
        jsr L_a67a
    L_a465:
        lda #$69
    L_a467:
        ldy #$a3
    L_a469:
        jsr L_ab1e
        ldy $3a
        iny 
        beq L_a474
        jsr L_bdc2
    L_a474:
        lda #$76
        ldy #$a3
        jsr L_ab1e
        lda #$80
        jsr L_ff90
    L_a480:
        jmp ($0302)
        jsr L_a560
        stx $7a
        sty $7b
        jsr.a $0073
        tax 
        beq L_a480
        ldx #$ff
        stx $3a
        bcc L_a49c
        jsr L_a579
        jmp L_a7e1
    L_a49c:
        jsr L_a96b
        jsr L_a579
        sty $0b
        jsr L_a613
        bcc L_a4ed
        ldy #$01
        lda ($5f),y
        sta $23
        lda $2d
        sta $22
        lda $60
        sta $25
        lda $5f
        dey 
        sbc ($5f),y
        clc 
        adc $2d
        sta $2d
        sta $24
        lda $2e
        adc #$ff
        sta $2e
        sbc $60
        tax 
        sec 
        lda $5f
        sbc $2d
        tay 
        bcs L_a4d7
        inx 
        dec $25
    L_a4d7:
        clc 
        adc $22
        bcc L_a4df
        dec $23
        clc 
    L_a4df:
        lda ($22),y
        sta ($24),y
        iny 
        bne L_a4df
        inc $23
        inc $25
        dex 
        bne L_a4df
    L_a4ed:
        jsr L_a659
        jsr L_a533
        lda $0200
        beq L_a480
        clc 
        lda $2d
        sta $5a
        adc $0b
        sta $58
        ldy $2e
        sty $5b
        bcc L_a508
        iny 
    L_a508:
        sty $59
        jsr L_a3b8
        lda $14
        ldy $15
        sta $01fe
        sty $01ff
        lda $31
        ldy $32
        sta $2d
        sty $2e
        ldy $0b
        dey 
    L_a522:
        lda $01fc,y
        sta ($5f),y
        dey 
        bpl L_a522
    L_a52a:
        jsr L_a659
        jsr L_a533
        jmp L_a480
    L_a533:
        lda $2b
        ldy $2c
        sta $22
        sty $23
        clc 
    L_a53c:
        ldy #$01
        lda ($22),y
        beq L_a55f
        ldy #$04
    L_a544:
        iny 
        lda ($22),y
        bne L_a544
        iny 
        tya 
        adc $22
        tax 
        ldy #$00
        sta ($22),y
        lda $23
        adc #$00
        iny 
        sta ($22),y
        stx $22
        sta $23
        bcc L_a53c
    L_a55f:
        rts 


    L_a560:
        ldx #$00
    L_a562:
        jsr L_e112
        cmp #$0d
        beq L_a576
        sta $0200,x
        inx 
        cpx #$59
        bcc L_a562
        ldx #$17
        jmp L_a437
    L_a576:
        jmp L_aaca
    L_a579:
        jmp ($0304)
        ldx $7a
        ldy #$04
        sty $0f
    L_a582:
        lda $0200,x
        bpl L_a58e
        cmp #$ff
        beq L_a5c9
        inx 
        bne L_a582
    L_a58e:
        cmp #$20
        beq L_a5c9
        sta $08
        cmp #$22
        beq L_a5ee
        bit $0f
        bvs L_a5c9
        cmp #$3f
        bne L_a5a4
        lda #$99
        bne L_a5c9
    L_a5a4:
        cmp #$30
        bcc L_a5ac
        cmp #$3c
        bcc L_a5c9
    L_a5ac:
        sty $71
        ldy #$00
        sty $0b
        dey 
        stx $7a
        dex 
    L_a5b6:
        iny 
        inx 
    L_a5b8:
        lda $0200,x
        sec 
        sbc $a09e,y
        beq L_a5b6
        cmp #$80
        bne L_a5f5
        ora $0b
    L_a5c7:
        ldy $71
    L_a5c9:
        inx 
        iny 
        sta $01fb,y
        lda $01fb,y
        beq L_a609
        sec 
        sbc #$3a
        beq L_a5dc
        cmp #$49
        bne L_a5de
    L_a5dc:
        sta $0f
    L_a5de:
        sec 
        sbc #$55
        bne L_a582
        sta $08
    L_a5e5:
        lda $0200,x
        beq L_a5c9
        cmp $08
        beq L_a5c9
    L_a5ee:
        iny 
        sta $01fb,y
        inx 
        bne L_a5e5
    L_a5f5:
        ldx $7a
        inc $0b
    L_a5f9:
        iny 
        lda L_a09d,y
        bpl L_a5f9
        lda $a09e,y
        bne L_a5b8
        lda $0200,x
        bpl L_a5c7
    L_a609:
        sta $01fd,y
        dec $7b
        lda #$ff
        sta $7a
        rts 


    L_a613:
        lda $2b
        ldx $2c
    L_a617:
        ldy #$01
        sta $5f
        stx $60
        lda ($5f),y
        beq L_a640
        iny 
        iny 
        lda $15
        cmp ($5f),y
        bcc L_a641
        beq L_a62e
        dey 
        bne L_a637
    L_a62e:
        lda $14
        dey 
    L_a631:
        cmp ($5f),y
    L_a633:
        bcc L_a641
    L_a635:
        beq L_a641
    L_a637:
        dey 
        lda ($5f),y
        tax 
        dey 
        lda ($5f),y
        bcs L_a617
    L_a640:
        clc 
    L_a641:
        rts 


        bne L_a641
    L_a644:
        lda #$00
        tay 
        sta ($2b),y
        iny 
        sta ($2b),y
        lda $2b
        clc 
        adc #$02
        sta $2d
        lda $2c
        adc #$00
        sta $2e
    L_a659:
        jsr L_a68e
        lda #$00
        bne L_a68d
    L_a660:
        jsr L_ffe7
    L_a663:
        lda $37
        ldy $38
        sta $33
        sty $34
        lda $2d
        ldy $2e
        sta $2f
        sty $30
        sta $31
        sty $32
    L_a677:
        jsr L_a81d
    L_a67a:
        ldx #$19
        stx $16
        pla 
        tay 
        pla 
        ldx #$fa
        txs 
        pha 
        tya 
        pha 
        lda #$00
        sta $3e
        sta $10
    L_a68d:
        rts 


    L_a68e:
        clc 
        lda $2b
        adc #$ff
        sta $7a
        lda $2c
        adc #$ff
        sta $7b
        rts 


        bcc L_a6a4
        beq L_a6a4
        cmp #$ab
        bne L_a68d
    L_a6a4:
        jsr L_a96b
        jsr L_a613
        jsr.a $0079
        beq L_a6bb
        cmp #$ab
        bne L_a641
        jsr.a $0073
        jsr L_a96b
        bne L_a641
    L_a6bb:
        pla 
        pla 
        lda $14
        ora $15
        bne L_a6c9
        lda #$ff
        sta $14
        sta $15
    L_a6c9:
        ldy #$01
        sty $0f
        lda ($5f),y
        beq L_a714
        jsr L_a82c
        jsr L_aad7
        iny 
        lda ($5f),y
        tax 
        iny 
        lda ($5f),y
        cmp $15
        bne L_a6e6
        cpx $14
        beq L_a6e8
    L_a6e6:
        bcs L_a714
    L_a6e8:
        sty $49
        jsr L_bdcd
        lda #$20
    L_a6ef:
        ldy $49
        and #$7f
    L_a6f3:
        jsr L_ab47
        cmp #$22
        bne L_a700
        lda $0f
        eor #$ff
        sta $0f
    L_a700:
        iny 
        beq L_a714
        lda ($5f),y
        bne L_a717
        tay 
        lda ($5f),y
        tax 
        iny 
        lda ($5f),y
        stx $5f
        sta $60
        bne L_a6c9
    L_a714:
        jmp L_e386
    L_a717:
        jmp ($0306)
        bpl L_a6f3
        cmp #$ff
        beq L_a6f3
        bit $0f
        bmi L_a6f3
        sec 
        sbc #$7f
        tax 
        sty $49
        ldy #$ff
    L_a72c:
        dex 
        beq L_a737
    L_a72f:
        iny 
        lda $a09e,y
        bpl L_a72f
        bmi L_a72c
    L_a737:
        iny 
        lda $a09e,y
        bmi L_a6ef
        jsr L_ab47
        bne L_a737
        lda #$80
        sta $10
        jsr L_a9a5
        jsr $a38a
        bne L_a753
        txa 
        adc #$0f
        tax 
        txs 
    L_a753:
        pla 
        pla 
        lda #$09
        jsr L_a3fb
        jsr L_a906
        clc 
        tya 
        adc $7a
        pha 
        lda $7b
        adc #$00
        pha 
        lda $3a
        pha 
        lda $39
        pha 
        lda #$a4
        jsr L_aeff
        jsr L_ad8d
        jsr L_ad8a
        lda $66
        ora #$7f
        and $62
        sta $62
        lda #$8b
        ldy #$a7
        sta $22
        sty $23
        jmp L_ae43
        lda #$bc
        ldy #$b9
        jsr L_bba2
        jsr.a $0079
        cmp #$a9
        bne L_a79f
        jsr.a $0073
        jsr L_ad8a
    L_a79f:
        jsr L_bc2b
        jsr L_ae38
        lda $4a
        pha 
        lda $49
        pha 
        lda #$81
        pha 
    L_a7ae:
        jsr L_a82c
        lda $7a
        ldy $7b
        cpy #$02
        nop 
        beq L_a7be
        sta $3d
        sty $3e
    L_a7be:
        ldy #$00
        lda ($7a),y
        bne L_a807
        ldy #$02
        lda ($7a),y
        clc 
        bne L_a7ce
        jmp L_a84b
    L_a7ce:
        iny 
        lda ($7a),y
        sta $39
        iny 
        lda ($7a),y
        sta $3a
        tya 
        adc $7a
        sta $7a
        bcc L_a7e1
        inc $7b
    L_a7e1:
        jmp ($0308)
        jsr.a $0073
        jsr L_a7ed
        jmp L_a7ae
    L_a7ed:
        beq L_a82b
    L_a7ef:
        sbc #$80
        bcc L_a804
        cmp #$23
        bcs L_a80e
        asl 
        tay 
        lda L_a00c + $1,y
        pha 
        lda L_a00c,y
        pha 
        jmp.a $0073
    L_a804:
        jmp L_a9a5
    L_a807:
        cmp #$3a
        beq L_a7e1
    L_a80b:
        jmp L_af08
    L_a80e:
        cmp #$4b
        bne L_a80b
        jsr.a $0073
        lda #$a4
        jsr L_aeff
        jmp L_a8a0
    L_a81d:
        sec 
        lda $2b
        sbc #$01
        ldy $2c
        bcs L_a827
        dey 
    L_a827:
        sta $41
        sty $42
    L_a82b:
        rts 


    L_a82c:
        jsr L_ffe1
        bcs L_a832
        clc 
    L_a832:
        bne L_a870
        lda $7a
        ldy $7b
        ldx $3a
        inx 
        beq L_a849
        sta $3d
        sty $3e
        lda $39
        ldy $3a
        sta $3b
        sty $3c
    L_a849:
        pla 
        pla 
    L_a84b:
        lda #$81
        ldy #$a3
        bcc L_a854
        jmp L_a469
    L_a854:
        jmp L_e386
        bne L_a870
        ldx #$1a
        ldy $3e
        bne L_a862
        jmp L_a437
    L_a862:
        lda $3d
        sta $7a
        sty $7b
        lda $3b
        ldy $3c
        sta $39
        sty $3a
    L_a870:
        rts 


        php 
        lda #$00
        jsr L_ff90
        plp 
        bne L_a87d
        jmp L_a659
    L_a87d:
        jsr L_a660
        jmp L_a897
        lda #$03
        jsr L_a3fb
        lda $7b
        pha 
        lda $7a
        pha 
        lda $3a
        pha 
        lda $39
        pha 
        lda #$8d
        pha 
    L_a897:
        jsr.a $0079
        jsr L_a8a0
        jmp L_a7ae
    L_a8a0:
        jsr L_a96b
        jsr $a909
        sec 
        lda $39
        sbc $14
        lda $3a
        sbc $15
        bcs L_a8bc
        tya 
        sec 
        adc $7a
        ldx $7b
        bcc L_a8c0
        inx 
        bcs L_a8c0
    L_a8bc:
        lda $2b
        ldx $2c
    L_a8c0:
        jsr L_a617

        .byte $90,$1e,$a5,$5f,$e9,$01,$85,$7a,$a5,$60,$e9,$00,$85,$7b

    L_a8d1:
        rts 


        bne L_a8d1
        lda #$ff
        sta $4a
        jsr $a38a
        txs 
        cmp #$8d
        beq L_a8eb
        ldx #$0c
        bit L_11a2
        jmp L_a437
    L_a8e8:
        jmp L_af08
    L_a8eb:
        pla 
        pla 
        sta $39
        pla 
        sta $3a
        pla 
        sta $7a
        pla 
        sta $7b
    L_a8f8:
        jsr L_a906
    L_a8fb:
        tya 
        clc 
        adc $7a
        sta $7a
        bcc L_a905
        inc $7b
    L_a905:
        rts 


    L_a906:
        ldx #$3a
        bit.a $00a2
        stx $07
        ldy #$00
        sty $08
    L_a911:
        lda $08
        ldx $07
        sta $07
        stx $08
    L_a919:
        lda ($7a),y
        beq L_a905
        cmp $08
        beq L_a905
        iny 
        cmp #$22
        bne L_a919
        beq L_a911
        jsr L_ad9e
        jsr.a $0079
        cmp #$89
        beq L_a937
        lda #$a7
        jsr L_aeff
    L_a937:
        lda $61
        bne L_a940
        jsr $a909
        beq L_a8fb
    L_a940:
        jsr.a $0079
        bcs L_a948
        jmp L_a8a0
    L_a948:
        jmp L_a7ed
        jsr L_b79e
        pha 
        cmp #$8d
        beq L_a957
    L_a953:
        cmp #$89
        bne L_a8e8
    L_a957:
        dec $65
        bne L_a95f
        pla 
        jmp L_a7ef
    L_a95f:
        jsr.a $0073
        jsr L_a96b
        cmp #$2c
        beq L_a957
        pla 
    L_a96a:
        rts 


    L_a96b:
        ldx #$00
        stx $14
        stx $15
    L_a971:
        bcs L_a96a
        sbc #$2f
        sta $07
        lda $15
        sta $22
        cmp #$19
        bcs L_a953
        lda $14
        asl 
        rol $22
        asl 
        rol $22
        adc $14
        sta $14
        lda $22
        adc $15
        sta $15
        asl $14
        rol $15
        lda $14
    L_a997:
        adc $07
        sta $14
        bcc L_a99f
        inc $15
    L_a99f:
        jsr.a $0073
        jmp L_a971
    L_a9a5:
        jsr L_b08b
        sta $49
        sty $4a
    L_a9ac:
        lda #$b2
        jsr L_aeff
        lda $0e
        pha 
        lda $0d
        pha 
    L_a9b7:
        jsr L_ad9e
        pla 
        rol 
        jsr L_ad90
        bne L_a9d9
        pla 
    L_a9c2:
        bpl L_a9d6
        jsr L_bc1b
        jsr L_b1bf
        ldy #$00
        lda $64
        sta ($49),y
        iny 
        lda $65
        sta ($49),y
        rts 


    L_a9d6:
        jmp L_bbd0
    L_a9d9:
        pla 
    L_a9da:
        ldy $4a
        cpy #$bf
        bne L_aa2c
        jsr L_b6a6
        cmp #$06
        bne L_aa24
        ldy #$00
        sty $61
        sty $66
    L_a9ed:
        sty $71
        jsr L_aa1d
        jsr L_bae2
    L_a9f5:
        inc $71
        ldy $71
    L_a9f9:
        jsr L_aa1d
        jsr L_bc0c
        tax 
    L_aa00:
        beq L_aa07
        inx 
        txa 
        jsr L_baed
    L_aa07:
        ldy $71
        iny 
        cpy #$06
        bne L_a9ed
        jsr L_bae2
        jsr L_bc9b
        ldx $64
        ldy $63
        lda $65
        jmp L_ffdb
    L_aa1d:
        lda ($22),y
        jsr.a $0080
        bcc L_aa27
    L_aa24:
        jmp $b248
    L_aa27:
        sbc #$2f
        jmp L_bd7e
    L_aa2c:
        ldy #$02
        lda ($64),y
        cmp $34
        bcc L_aa4b
        bne L_aa3d
        dey 
        lda ($64),y
        cmp $33
        bcc L_aa4b
    L_aa3d:
        ldy $65
        cpy $2e
        bcc L_aa4b
        bne L_aa52
        lda $64
        cmp $2d
        bcs L_aa52
    L_aa4b:
        lda $64
        ldy $65
        jmp L_aa68
    L_aa52:
        ldy #$00
        lda ($64),y
        jsr L_b475
        lda $50
        ldy $51
        sta $6f
        sty $70
        jsr L_b67a
        lda #$61
        ldy #$00
    L_aa68:
        sta $50
        sty $51
        jsr L_b6db
    L_aa6f:
        ldy #$00
        lda ($50),y
        sta ($49),y
        iny 
        lda ($50),y
        sta ($49),y
        iny 
        lda ($50),y
        sta ($49),y
        rts 


        jsr L_aa86
        jmp L_abb5
    L_aa86:
        jsr L_b79e
        beq L_aa90
        lda #$2c
    L_aa8d:
        jsr L_aeff
    L_aa90:
        php 
        stx $13
        jsr L_e118
    L_aa96:
        plp 
        jmp L_aaa0
    L_aa9a:
        jsr L_ab21
    L_aa9d:
        jsr.a $0079
    L_aaa0:
        beq L_aad7
    L_aaa2:
        beq L_aae7
        cmp #$a3
        beq L_aaf8
        cmp #$a6
    L_aaaa:
        clc 
        beq L_aaf8
        cmp #$2c
    L_aaaf:
        beq L_aae8
        cmp #$3b
        beq L_ab13
        jsr L_ad9e
        bit $0d
        bmi L_aa9a
        jsr L_bddd
        jsr L_b487
    L_aac2:
        jsr L_ab21
        jsr L_ab3b
        bne L_aa9d
    L_aaca:
        lda #$00
        sta $0200,x
        ldx #$ff
        ldy #$01
        lda $13
        bne L_aae7
    L_aad7:
        lda #$0d
        jsr L_ab47
        bit $13
        bpl L_aae5
        lda #$0a
        jsr L_ab47
    L_aae5:
        eor #$ff
    L_aae7:
        rts 


    L_aae8:
        sec 
        jsr L_fff0
        tya 
        sec 
    L_aaee:
        sbc #$0a
        bcs L_aaee
        eor #$ff
        adc #$01
        bne L_ab0e
    L_aaf8:
        php 
        sec 
        jsr L_fff0
        sty $09
        jsr L_b79b
        cmp #$29
        bne L_ab5f
        plp 
        bcc L_ab0f
        txa 
        sbc $09
        bcc L_ab13
    L_ab0e:
        tax 
    L_ab0f:
        inx 
    L_ab10:
        dex 
        bne L_ab19
    L_ab13:
        jsr.a $0073
        jmp L_aaa2
    L_ab19:
        jsr L_ab3b
        bne L_ab10
    L_ab1e:
        jsr L_b487
    L_ab21:
        jsr L_b6a6
        tax 
        ldy #$00
        inx 
    L_ab28:
        dex 
        beq L_aae7
        lda ($22),y
        jsr L_ab47
        iny 
        cmp #$0d
        bne L_ab28
        jsr L_aae5
        jmp L_ab28

    L_ab3b:
         .byte $a5,$13,$f0,$03
        .byte $a9,$20,$2c,$a9,$1d,$2c,$a9,$3f

    L_ab47:
        jsr L_e10c
        and #$ff
        rts 


    L_ab4d:
        lda $11
        beq L_ab62
        bmi L_ab57
        ldy #$ff
        bne L_ab5b
    L_ab57:
        lda $3f
        ldy $40
    L_ab5b:
        sta $39
        sty $3a
    L_ab5f:
        jmp L_af08
    L_ab62:
        lda $13
        beq L_ab6b
        ldx #$18
        jmp L_a437
    L_ab6b:
        lda #$0c
        ldy #$ad
        jsr L_ab1e
        lda $3d
        ldy $3e
        sta $7a
        sty $7b
        rts 


        jsr L_b3a6
        cmp #$23
        bne L_ab92
        jsr.a $0073
        jsr L_b79e
        lda #$2c
        jsr L_aeff
        stx $13
    L_ab8f:
        jsr L_e11e
    L_ab92:
        ldx #$01
        ldy #$02
        lda #$00
        sta $0201
        lda #$40
        jsr L_ac0f
        ldx $13
        bne L_abb7
        rts 


        jsr L_b79e
        lda #$2c
        jsr L_aeff
        stx $13
        jsr L_e11e
        jsr L_abce
    L_abb5:
        lda $13
    L_abb7:
        jsr L_ffcc
        ldx #$00
        stx $13
        rts 


        cmp #$22
        bne L_abce
        jsr L_aebd
        lda #$3b
        jsr L_aeff
        jsr L_ab21
    L_abce:
        jsr L_b3a6
        lda #$2c
        sta $01ff
    L_abd6:
        jsr L_abf9
        lda $13
        beq L_abea
        jsr L_ffb7
        and #$02
        beq L_abea
        jsr L_abb5
        jmp L_a8f8

    L_abea:
         .byte $ad,$00,$02,$d0,$1e
        .byte $a5,$13,$d0,$e3,$20,$06,$a9,$4c,$fb,$a8

    L_abf9:
        lda $13
        bne L_ac03
        jsr $ab45
        jsr L_ab3b
    L_ac03:
        jmp L_a560
        ldx $41
        ldy $42
        lda #$98
        bit.a $00a9
    L_ac0f:
        sta $11
        stx $43
        sty $44
    L_ac15:
        jsr L_b08b
        sta $49
        sty $4a
        lda $7a
        ldy $7b
        sta $4b
        sty $4c
        ldx $43
        ldy $44
        stx $7a
        sty $7b
        jsr.a $0079
        bne L_ac51
        bit $11
        bvc L_ac41
        jsr L_e124
        sta $0200
        ldx #$ff
        ldy #$01
        bne L_ac4d
    L_ac41:
        bmi L_acb8
        lda $13
        bne L_ac4a
        jsr $ab45
    L_ac4a:
        jsr L_abf9
    L_ac4d:
        stx $7a
        sty $7b
    L_ac51:
        jsr.a $0073
        bit $0d
        bpl L_ac89
        bit $11
        bvc L_ac65
        inx 
        stx $7a
        lda #$00
        sta $07
        beq L_ac71
    L_ac65:
        sta $07
        cmp #$22
        beq L_ac72
        lda #$3a
        sta $07
        lda #$2c
    L_ac71:
        clc 
    L_ac72:
        sta $08
        lda $7a
        ldy $7b
        adc #$00
        bcc L_ac7d
        iny 
    L_ac7d:
        jsr L_b48d
        jsr L_b7e2
        jsr L_a9da
        jmp L_ac91
    L_ac89:
        jsr L_bcf3
        lda $0e
        jsr L_a9c2
    L_ac91:
        jsr.a $0079
        beq L_ac9d
        cmp #$2c
        beq L_ac9d
        jmp L_ab4d
    L_ac9d:
        lda $7a
        ldy $7b
        sta $43
        sty $44
        lda $4b
        ldy $4c
        sta $7a
        sty $7b
        jsr.a $0079
        beq L_acdf
        jsr $aefd
        jmp L_ac15
    L_acb8:
        jsr L_a906
        iny 
        tax 
        bne L_acd1
        ldx #$0d
        iny 
        lda ($7a),y
        beq L_ad32
        iny 
        lda ($7a),y
        sta $3f
        iny 
        lda ($7a),y
        iny 
        sta $40
    L_acd1:
        jsr L_a8fb
        jsr.a $0079
        tax 
        cpx #$83
        bne L_acb8
        jmp L_ac51
    L_acdf:
        lda $43
        ldy $44
        ldx $11
        bpl L_acea
        jmp L_a827
    L_acea:
        ldy #$00
        lda ($43),y
        beq L_acfb
        lda $13
        bne L_acfb
        lda #$fc
        ldy #$ac
        jmp L_ab1e
    L_acfb:
        rts 



        .byte $3f,$45,$58,$54,$52,$41,$20,$49,$47,$4e,$4f,$52,$45,$44,$0d,$00
        .byte $3f,$52,$45,$44,$4f,$20,$46,$52,$4f,$4d,$20,$53,$54,$41,$52,$54
        .byte $0d,$00,$d0,$04,$a0,$00,$f0,$03

    L_ad24:
        jsr L_b08b
    L_ad27:
        sta $49
        sty $4a
        jsr $a38a
        beq L_ad35
        ldx #$0a
    L_ad32:
        jmp L_a437
    L_ad35:
        txs 
        txa 
        clc 
        adc #$04
        pha 
        adc #$06
        sta $24
        pla 
        ldy #$01
        jsr L_bba2
        tsx 
        lda $0109,x
        sta $66
        lda $49
        ldy $4a
        jsr L_b867
        jsr L_bbd0
        ldy #$01
        jsr L_bc5d
        tsx 
        sec 
        sbc $0109,x
        beq L_ad78
        lda $010f,x
        sta $39
        lda $0110,x
        sta $3a
        lda $0112,x
        sta $7a
        lda $0111,x
        sta $7b
    L_ad75:
        jmp L_a7ae
    L_ad78:
        txa 
        adc #$11
        tax 
        txs 
        jsr.a $0079
        cmp #$2c
        bne L_ad75
        jsr.a $0073
        jsr L_ad24
    L_ad8a:
        jsr L_ad9e
    L_ad8d:
        clc 
        bit $38
    L_ad90:
        bit $0d
        bmi L_ad97
        bcs L_ad99
    L_ad96:
        rts 


    L_ad97:
        bcs L_ad96
    L_ad99:
        ldx #$16
        jmp L_a437
    L_ad9e:
        ldx $7a
        bne L_ada4
        dec $7b
    L_ada4:
        dec $7a
        ldx #$00
        bit $48
        txa 
        pha 
        lda #$01
        jsr L_a3fb
        jsr L_ae83
        lda #$00
        sta $4d
    L_adb8:
        jsr.a $0079
    L_adbb:
        sec 
        sbc #$b1
        bcc L_add7
        cmp #$03
        bcs L_add7
        cmp #$01
        rol 
        eor #$01
        eor $4d
        cmp $4d
        bcc L_ae30
        sta $4d
        jsr.a $0073
        jmp L_adbb
    L_add7:
        ldx $4d
        bne L_ae07
        bcs L_ae58
        adc #$07
        bcc L_ae58
        adc $0d
        bne L_ade8
        jmp L_b63d
    L_ade8:
        adc #$ff
        sta $22
        asl 
        adc $22
        tay 
    L_adf0:
        pla 
        cmp L_a080,y
        bcs L_ae5d
        jsr L_ad8d
    L_adf9:
        pha 
    L_adfa:
        jsr L_ae20
        pla 
        ldy $4b
        bpl L_ae19
        tax 
        beq L_ae5b
        bne L_ae66
    L_ae07:
        lsr $0d
        txa 
        rol 
        ldx $7a
        bne L_ae11
        dec $7b
    L_ae11:
        dec $7a
        ldy #$1b
        sta $4d
        bne L_adf0
    L_ae19:
        cmp L_a080,y
        bcs L_ae66
        bcc L_adf9
    L_ae20:
        lda $a082,y
        pha 
        lda $a081,y
        pha 
        jsr L_ae33
        lda $4d
        jmp $ada9
    L_ae30:
        jmp L_af08
    L_ae33:
        lda $66
        ldx L_a080,y
    L_ae38:
        tay 
        pla 
        sta $22
        inc $22
        pla 
        sta $23
        tya 
        pha 
    L_ae43:
        jsr L_bc1b
        lda $65
        pha 
        lda $64
        pha 
        lda $63
        pha 
        lda $62
        pha 
        lda $61
        pha 

    L_ae55:
         .byte $6c,$22,$00

    L_ae58:
        ldy #$ff
        pla 
    L_ae5b:
        beq L_ae80
    L_ae5d:
        cmp #$64
        beq L_ae64
        jsr L_ad8d
    L_ae64:
        sty $4b
    L_ae66:
        pla 
        lsr 
        sta $12
        pla 
        sta $69
        pla 
        sta $6a
        pla 
        sta $6b
        pla 
        sta $6c
        pla 
        sta $6d
        pla 
        sta $6e
        eor $66
        sta $6f
    L_ae80:
        lda $61
        rts 


    L_ae83:
        jmp ($030a)
        lda #$00
        sta $0d
    L_ae8a:
        jsr.a $0073
        bcs L_ae92
        jmp L_bcf3
    L_ae92:
        jsr L_b113
        bcc L_ae9a
        jmp L_af28

    L_ae9a:
         .byte $c9,$ff,$d0,$0f
        .byte $a9,$a8,$a0,$ae,$20,$a2,$bb,$4c,$73,$00,$82,$49,$0f,$da,$a1,$c9
        .byte $2e,$f0,$de,$c9,$ab,$f0,$58,$c9,$aa,$f0,$d1,$c9,$22,$d0,$0f

    L_aebd:
        lda $7a
        ldy $7b
        adc #$00
        bcc L_aec6
        iny 
    L_aec6:
        jsr L_b487
        jmp L_b7e2
    L_aecc:
        cmp #$a8
        bne L_aee3
        ldy #$18
        bne L_af0f
        jsr L_b1bf
        lda $65
        eor #$ff
        tay 
        lda $64
        eor #$ff
        jmp L_b391
    L_aee3:
        cmp #$a5
        bne L_aeea
        jmp L_b3f4
    L_aeea:
        cmp #$b4
        bcc L_aef1
        jmp L_afa7
    L_aef1:
        jsr $aefa
        jsr L_ad9e
    L_aef7:
        lda #$29
        bit L_28a9
        bit L_2ca1 + $8
    L_aeff:
        ldy #$00
        cmp ($7a),y
        bne L_af08
        jmp.a $0073
    L_af08:
        ldx #$0b
        jmp L_a437
    L_af0d:
        ldy #$15
    L_af0f:
        pla 
        pla 
        jmp L_adfa
    L_af14:
        sec 
        lda $64
        sbc #$00
        lda $65
        sbc #$a0
        bcc L_af27
        lda #$a2
        sbc $64
        lda #$e3
        sbc $65
    L_af27:
        rts 


    L_af28:
        jsr L_b08b
        sta $64
        sty $65
        ldx $45
        ldy $46
        lda $0d
        beq L_af5d
        lda #$00
        sta $70
        jsr L_af14
        bcc L_af5c
        cpx #$54
        bne L_af5c
        cpy #$c9
        bne L_af5c
        jsr L_af84
        sty $5e
        dey 
        sty $71
        ldy #$06
        sty $5d
        ldy #$24
        jsr L_be68
        jmp L_b46f
    L_af5c:
        rts 


    L_af5d:
        bit $0e
        bpl L_af6e
        ldy #$00
        lda ($64),y
        tax 
        iny 
        lda ($64),y
        tay 
        txa 
        jmp L_b391
    L_af6e:
        jsr L_af14
        bcc L_afa0
        cpx #$54
        bne L_af92
        cpy #$49
    L_af79:
        bne L_afa0
    L_af7b:
        jsr L_af84
    L_af7e:
        tya 
        ldx #$a0
        jmp L_bc4f
    L_af84:
        jsr L_ffde
        stx $64
        sty $63
        sta $65
        ldy #$00
        sty $62
        rts 


    L_af92:
        cpx #$53
        bne L_afa0
        cpy #$54
        bne L_afa0
        jsr L_ffb7
        jmp L_bc3c
    L_afa0:
        lda $64
        ldy $65
        jmp L_bba2
    L_afa7:
        asl 
        pha 
        tax 
    L_afaa:
        jsr.a $0073
        cpx #$8f
        bcc L_afd1
        jsr $aefa
        jsr L_ad9e
        jsr $aefd
        jsr $ad8f
        pla 
        tax 
        lda $65
        pha 
        lda $64
        pha 
        txa 
        pha 
        jsr L_b79e
        pla 
        tay 
        txa 
        pha 
        jmp L_afd6
    L_afd1:
        jsr L_aef1
        pla 
        tay 
    L_afd6:
        lda L_9fea,y
        sta $55
        lda $9feb,y
        sta $56
        jsr.a $0054
        jmp L_ad8d
        ldy #$ff
        bit.a $00a0
        sty $0b
        jsr L_b1bf
        lda $64
        eor $0b
        sta $07
        lda $65
        eor $0b
        sta $08
        jsr L_bbfc
        jsr L_b1bf
        lda $65
        eor $0b
        and $08
        eor $0b
        tay 
        lda $64
        eor $0b
        and $07
        eor $0b
        jmp L_b391
        jsr L_ad90
        bcs L_b02e
        lda $6e
        ora #$7f
        and $6a
        sta $6a
        lda #$69
        ldy #$00
        jsr L_bc5b
        tax 
        jmp L_b061
    L_b02e:
        lda #$00
        sta $0d
        dec $4d
        jsr L_b6a6
        sta $61
        stx $62
        sty $63
        lda $6c
        ldy $6d
        jsr L_b6aa
        stx $6c
        sty $6d
        tax 
        sec 
        sbc $61
        beq L_b056
        lda #$01
        bcc L_b056
        ldx $61
        lda #$ff
    L_b056:
        sta $66
        ldy #$ff
        inx 
    L_b05b:
        iny 
        dex 
        bne L_b066
        ldx $66
    L_b061:
        bmi L_b072
        clc 
        bcc L_b072
    L_b066:
        lda ($6c),y
        cmp ($62),y
    L_b06a:
        beq L_b05b
        ldx #$ff
        bcs L_b072
        ldx #$01
    L_b072:
        inx 
        txa 
        rol 
        and $12
        beq L_b07b
        lda #$ff
    L_b07b:
        jmp L_bc3c
    L_b07e:
        jsr $aefd
        tax 
        jsr L_b090
        jsr.a $0079
        bne L_b07e
        rts 


    L_b08b:
        ldx #$00
        jsr.a $0079
    L_b090:
        stx $0c
    L_b092:
        sta $45
        jsr.a $0079
        jsr L_b113
        bcs L_b09f
    L_b09c:
        jmp L_af08
    L_b09f:
        ldx #$00
        stx $0d
        stx $0e
        jsr.a $0073
        bcc L_b0af
        jsr L_b113
        bcc L_b0ba
    L_b0af:
        tax 
    L_b0b0:
        jsr.a $0073
        bcc L_b0b0
        jsr L_b113
        bcs L_b0b0
    L_b0ba:
        cmp #$24
        bne L_b0c4
        lda #$ff
        sta $0d
        bne L_b0d4
    L_b0c4:
        cmp #$25
        bne L_b0db
        lda $10
        bne L_b09c
        lda #$80
        sta $0e
        ora $45
        sta $45
    L_b0d4:
        txa 
        ora #$80
        tax 
        jsr.a $0073
    L_b0db:
        stx $46
        sec 
        ora $10
        sbc #$28
        bne L_b0e7
        jmp L_b1d1
    L_b0e7:
        ldy #$00
        sty $10
        lda $2d
        ldx $2e
    L_b0ef:
        stx $60
    L_b0f1:
        sta $5f
        cpx $30
        bne L_b0fb
        cmp $2f
        beq L_b11d
    L_b0fb:
        lda $45
        cmp ($5f),y
        bne L_b109
        lda $46
        iny 
        cmp ($5f),y
        beq L_b185
        dey 
    L_b109:
        clc 
        lda $5f
        adc #$07
        bcc L_b0f1
        inx 
        bne L_b0ef
    L_b113:
        cmp #$41
        bcc L_b11c
        sbc #$5b
        sec 
        sbc #$a5
    L_b11c:
        rts 


    L_b11d:
        pla 
        pha 
        cmp #$2a
        bne L_b128
    L_b123:
        lda #$13
        ldy #$bf
        rts 


    L_b128:
        lda $45
        ldy $46
        cmp #$54
        bne L_b13b
        cpy #$c9
        beq L_b123
        cpy #$49
        bne L_b13b
    L_b138:
        jmp L_af08
    L_b13b:
        cmp #$53
        bne L_b143
        cpy #$54
        beq L_b138
    L_b143:
        lda $2f
        ldy $30
        sta $5f
        sty $60
        lda $31
        ldy $32
        sta $5a
        sty $5b
        clc 
        adc #$07
        bcc L_b159
        iny 
    L_b159:
        sta $58
        sty $59
        jsr L_a3b8
        lda $58
        ldy $59
        iny 
        sta $2f
        sty $30
        ldy #$00
        lda $45
        sta ($5f),y
        iny 
        lda $46
        sta ($5f),y
        lda #$00
        iny 
        sta ($5f),y
        iny 
        sta ($5f),y
        iny 
        sta ($5f),y
        iny 
        sta ($5f),y
        iny 
        sta ($5f),y
    L_b185:
        lda $5f
        clc 
        adc #$02
    L_b18a:
        ldy $60
        bcc L_b18f
        iny 
    L_b18f:
        sta $47
        sty $48
        rts 


    L_b194:
        lda $0b
        asl 
        adc #$05
        adc $5f
        ldy $60
        bcc L_b1a0
        iny 
    L_b1a0:
        sta $58
        sty $59
        rts 



        .byte $90,$80,$00,$00,$00,$20,$bf,$b1,$a5,$64,$a4,$65,$60

    L_b1b2:
        jsr.a $0073
        jsr L_ad9e
    L_b1b8:
        jsr L_ad8d
        lda $66
        bmi L_b1cc
    L_b1bf:
        lda $61
        cmp #$90
        bcc L_b1ce
        lda #$a5
        ldy #$b1
        jsr L_bc5b

    L_b1cc:
         .byte $d0,$7a

    L_b1ce:
        jmp L_bc9b
    L_b1d1:
        lda $0c
        ora $0e
        pha 
        lda $0d
        pha 
        ldy #$00
    L_b1db:
        tya 
        pha 
        lda $46
        pha 
        lda $45
        pha 
        jsr L_b1b2
        pla 
        sta $45
        pla 
        sta $46
        pla 
        tay 
        tsx 
        lda $0102,x
        pha 
        lda $0101,x
        pha 
        lda $64
        sta $0102,x
        lda $65
        sta $0101,x
        iny 
        jsr.a $0079
        cmp #$2c
        beq L_b1db
        sty $0b
        jsr L_aef7
        pla 
        sta $0d
        pla 
        sta $0e
        and #$7f
        sta $0c
        ldx $2f
        lda $30
    L_b21c:
        stx $5f
        sta $60
        cmp $32
        bne L_b228
        cpx $31
        beq L_b261
    L_b228:
        ldy #$00
        lda ($5f),y
        iny 
        cmp $45
        bne L_b237
        lda $46
        cmp ($5f),y
        beq L_b24d
    L_b237:
        iny 
        lda ($5f),y
        clc 
        adc $5f
        tax 
        iny 
        lda ($5f),y
        adc $60
        bcc L_b21c
    L_b245:
        ldx #$12
        bit L_0e9d + $5
    L_b24a:
        jmp L_a437
    L_b24d:
        ldx #$13
        lda $0c
        bne L_b24a
        jsr L_b194
        lda $0b
        ldy #$04
        cmp ($5f),y
        bne L_b245
        jmp L_b2ea
    L_b261:
        jsr L_b194
        jsr L_a408
        ldy #$00
        sty $72
        ldx #$05
        lda $45
        sta ($5f),y
        bpl L_b274
        dex 
    L_b274:
        iny 
        lda $46
        sta ($5f),y
        bpl L_b27d
        dex 
        dex 
    L_b27d:
        stx $71
        lda $0b
        iny 
        iny 
        iny 
        sta ($5f),y
    L_b286:
        ldx #$0b
        lda #$00
        bit $0c
        bvc L_b296
        pla 
        clc 
        adc #$01
        tax 
        pla 
        adc #$00
    L_b296:
        iny 
        sta ($5f),y
        iny 
        txa 
        sta ($5f),y
        jsr L_b34c
        stx $71
        sta $72
        ldy $22
        dec $0b
        bne L_b286
        adc $59
        bcs L_b30b
        sta $59
        tay 
        txa 
        adc $58
        bcc L_b2b9
        iny 
        beq L_b30b
    L_b2b9:
        jsr L_a408
        sta $31
        sty $32
        lda #$00
        inc $72
        ldy $71
        beq L_b2cd
    L_b2c8:
        dey 
        sta ($58),y
        bne L_b2c8
    L_b2cd:
        dec $59
        dec $72
        bne L_b2c8
        inc $59
        sec 
        lda $31
        sbc $5f
        ldy #$02
        sta ($5f),y
        lda $32
        iny 
        sbc $60
        sta ($5f),y
        lda $0c
        bne L_b34b
        iny 
    L_b2ea:
        lda ($5f),y
        sta $0b
        lda #$00
        sta $71
    L_b2f2:
        sta $72
        iny 
        pla 
        tax 
        sta $64
        pla 
        sta $65
        cmp ($5f),y
        bcc L_b30e
        bne L_b308
        iny 
        txa 
        cmp ($5f),y
        bcc L_b30f
    L_b308:
        jmp L_b245
    L_b30b:
        jmp L_a435
    L_b30e:
        iny 
    L_b30f:
        lda $72
        ora $71
        clc 
        beq L_b320
        jsr L_b34c
        txa 
        adc $64
        tax 
        tya 
        ldy $22
    L_b320:
        adc $65
        stx $71
        dec $0b
        bne L_b2f2
        sta $72
        ldx #$05
        lda $45
        bpl L_b331
        dex 
    L_b331:
        lda $46
        bpl L_b337
        dex 
        dex 
    L_b337:
        stx $28
        lda #$00
        jsr L_b355
        txa 
        adc $58
        sta $47
        tya 
        adc $59
        sta $48
        tay 
        lda $47
    L_b34b:
        rts 


    L_b34c:
        sty $22
        lda ($5f),y
        sta $28
        dey 
        lda ($5f),y
    L_b355:
        sta $29
        lda #$10
        sta $5d
        ldx #$00
        ldy #$00
    L_b35f:
        txa 
        asl 
        tax 
        tya 
        rol 
        tay 
        bcs L_b30b
        asl $71
        rol $72
        bcc L_b378
        clc 
        txa 
        adc $28
        tax 
        tya 
        adc $29
        tay 
        bcs L_b30b
    L_b378:
        dec $5d
        bne L_b35f
        rts 


        lda $0d
        beq L_b384
        jsr L_b6a6
    L_b384:
        jsr L_b526
        sec 
        lda $33
        sbc $31
        tay 
        lda $34
        sbc $32
    L_b391:
        ldx #$00
        stx $0d
        sta $62
        sty $63
        ldx #$90
        jmp L_bc44
        sec 
        jsr L_fff0
    L_b3a2:
        lda #$00
        beq L_b391
    L_b3a6:
        ldx $3a
        inx 
        bne L_b34b
        ldx #$15
        bit $1ba2
        jmp L_a437
        jsr L_b3e1
        jsr L_b3a6
        jsr $aefa
        lda #$80
        sta $10
        jsr L_b08b
        jsr L_ad8d
        jsr L_aef7
        lda #$b2
        jsr L_aeff
        pha 
        lda $48
        pha 
        lda $47
        pha 
        lda $7b
        pha 
        lda $7a
        pha 
        jsr L_a8f8
        jmp L_b44f
    L_b3e1:
        lda #$a5
        jsr L_aeff
        ora #$80
        sta $10
        jsr L_b092
        sta $4e
        sty $4f
        jmp L_ad8d
    L_b3f4:
        jsr L_b3e1
        lda $4f
        pha 
        lda $4e
        pha 
        jsr L_aef1
        jsr L_ad8d

        .byte $68,$85,$4e,$68,$85,$4f,$a0,$02,$b1,$4e,$85,$47,$aa,$c8,$b1,$4e
        .byte $f0,$99,$85,$48,$c8

    L_b418:
        lda ($47),y
        pha 
        dey 
        bpl L_b418
        ldy $48
        jsr L_bbd4
        lda $7b
        pha 
        lda $7a
        pha 
        lda ($4e),y
        sta $7a
        iny 
        lda ($4e),y
        sta $7b
        lda $48
        pha 
        lda $47
        pha 
        jsr L_ad8a
        pla 
        sta $4e
        pla 
        sta $4f
        jsr.a $0079
        beq L_b449
        jmp L_af08
    L_b449:
        pla 
        sta $7a
        pla 
        sta $7b
    L_b44f:
        ldy #$00
        pla 
        sta ($4e),y
        pla 
        iny 
        sta ($4e),y
        pla 
        iny 
    L_b45a:
        sta ($4e),y
        pla 
        iny 
        sta ($4e),y
        pla 
        iny 
        sta ($4e),y
        rts 


        jsr L_ad8d
        ldy #$00
        jsr L_bddf
        pla 
        pla 
    L_b46f:
        lda #$ff
        ldy #$00
        beq L_b487
    L_b475:
        ldx $64
        ldy $65
        stx $50
        sty $51
    L_b47d:
        jsr L_b4f4
        stx $62
        sty $63
        sta $61
        rts 


    L_b487:
        ldx #$22
        stx $07
        stx $08
    L_b48d:
        sta $6f
        sty $70
        sta $62
        sty $63
        ldy #$ff
    L_b497:
        iny 
        lda ($6f),y
        beq L_b4a8
        cmp $07
        beq L_b4a4
        cmp $08
        bne L_b497
    L_b4a4:
        cmp #$22
        beq L_b4a9
    L_b4a8:
        clc 
    L_b4a9:
        sty $61
        tya 
        adc $6f
        sta $71
        ldx $70
        bcc L_b4b5
    L_b4b4:
        inx 
    L_b4b5:
        stx $72
    L_b4b7:
        lda $70
        beq L_b4bf
        cmp #$02
        bne L_b4ca
    L_b4bf:
        tya 
        jsr L_b475
        ldx $6f
        ldy $70
        jsr L_b688
    L_b4ca:
        ldx $16
        cpx #$22
    L_b4ce:
        bne L_b4d5
        ldx #$19
    L_b4d2:
        jmp L_a437
    L_b4d5:
        lda $61
        sta $00,x
        lda $62
        sta $01,x
        lda $63
        sta $02,x
        ldy #$00
        stx $64
        sty $65
        sty $70
        dey 
        sty $0d
        stx $17
        inx 
        inx 
        inx 
        stx $16
        rts 


    L_b4f4:
        lsr $0f
    L_b4f6:
        pha 
        eor #$ff
        sec 
        adc $33
        ldy $34
        bcs L_b501
        dey 
    L_b501:
        cpy $32
        bcc L_b516
        bne L_b50b
        cmp $31
        bcc L_b516
    L_b50b:
        sta $33
        sty $34
        sta $35
        sty $36
        tax 
        pla 
        rts 


    L_b516:
        ldx #$10
        lda $0f
        bmi L_b4d2
        jsr L_b526
        lda #$80
        sta $0f
    L_b523:
        pla 
    L_b524:
        bne L_b4f6
    L_b526:
        ldx $37
        lda $38
    L_b52a:
        stx $33
        sta $34
        ldy #$00
        sty $4f
        sty $4e
        lda $31
        ldx $32
        sta $5f
        stx $60
        lda #$19
        ldx #$00
        sta $22
        stx $23
    L_b544:
        cmp $16
        beq L_b54d
        jsr L_b5c7
        beq L_b544
    L_b54d:
        lda #$07
        sta $53
        lda $2d
        ldx $2e
        sta $22
        stx $23
    L_b559:
        cpx $30
        bne L_b561
        cmp $2f
        beq L_b566
    L_b561:
        jsr L_b5bd
        beq L_b559
    L_b566:
        sta $58
        stx $59
        lda #$03
        sta $53
    L_b56e:
        lda $58
        ldx $59
    L_b572:
        cpx $32
        bne L_b57d
        cmp $31
        bne L_b57d
        jmp L_b606
    L_b57d:
        sta $22
        stx $23
        ldy #$00
        lda ($22),y
        tax 
        iny 
        lda ($22),y
        php 
        iny 
        lda ($22),y
        adc $58
        sta $58
        iny 
        lda ($22),y
        adc $59
        sta $59
        plp 
        bpl L_b56e
        txa 
        bmi L_b56e
        iny 
        lda ($22),y
        ldy #$00
        asl 
        adc #$05
        adc $22
        sta $22
        bcc L_b5ae
        inc $23
    L_b5ae:
        ldx $23
    L_b5b0:
        cpx $59
        bne L_b5b8
    L_b5b4:
        cmp $58
        beq L_b572
    L_b5b8:
        jsr L_b5c7
        beq L_b5b0
    L_b5bd:
        lda ($22),y
        bmi L_b5f6
        iny 
        lda ($22),y
        bpl L_b5f6
        iny 
    L_b5c7:
        lda ($22),y
        beq L_b5f6
        iny 
        lda ($22),y
        tax 
        iny 
        lda ($22),y
        cmp $34
        bcc L_b5dc
        bne L_b5f6
        cpx $33
        bcs L_b5f6
    L_b5dc:
        cmp $60
        bcc L_b5f6
        bne L_b5e6
        cpx $5f
        bcc L_b5f6
    L_b5e6:
        stx $5f
        sta $60
        lda $22
        ldx $23
        sta $4e
        stx $4f
        lda $53
        sta $55
    L_b5f6:
        lda $53
        clc 
        adc $22
        sta $22
        bcc L_b601
        inc $23
    L_b601:
        ldx $23
        ldy #$00
        rts 


    L_b606:
        lda $4f
        ora $4e
        beq L_b601
        lda $55
        and #$04
        lsr 
        tay 
        sta $55
        lda ($4e),y
        adc $5f
        sta $5a
        lda $60
        adc #$00
        sta $5b
        lda $33
        ldx $34
        sta $58
        stx $59
        jsr L_a3bf
        ldy $55
        iny 
        lda $58
        sta ($4e),y
        tax 
        inc $59
        lda $59
        iny 
        sta ($4e),y
        jmp L_b52a
    L_b63d:
        lda $65
        pha 
        lda $64
        pha 
        jsr L_ae83
        jsr $ad8f
        pla 
        sta $6f
        pla 
        sta $70
        ldy #$00
        lda ($6f),y
        clc 
        adc ($64),y
        bcc L_b65d
        ldx #$17
        jmp L_a437
    L_b65d:
        jsr L_b475
        jsr L_b67a
        lda $50
        ldy $51
        jsr L_b6aa
        jsr L_b68c
        lda $6f
        ldy $70
        jsr L_b6aa
        jsr L_b4ca
        jmp L_adb8
    L_b67a:
        ldy #$00
        lda ($6f),y
        pha 
        iny 
        lda ($6f),y
        tax 
        iny 
        lda ($6f),y
        tay 
        pla 
    L_b688:
        stx $22
        sty $23
    L_b68c:
        tay 
        beq L_b699
        pha 
    L_b690:
        dey 
        lda ($22),y
        sta ($35),y
        tya 
        bne L_b690
        pla 
    L_b699:
        clc 
        adc $35
        sta $35
        bcc L_b6a2
        inc $36
    L_b6a2:
        rts 


    L_b6a3:
        jsr $ad8f
    L_b6a6:
        lda $64
        ldy $65
    L_b6aa:
        sta $22
        sty $23
        jsr L_b6db
        php 
        ldy #$00
        lda ($22),y
        pha 
        iny 
        lda ($22),y
        tax 
        iny 
        lda ($22),y
    L_b6be:
        tay 
        pla 
        plp 
        bne L_b6d6
        cpy $34
        bne L_b6d6
        cpx $33
        bne L_b6d6
        pha 
        clc 
        adc $33
        sta $33
        bcc L_b6d5
        inc $34
    L_b6d5:
        pla 
    L_b6d6:
        stx $22
        sty $23
        rts 


    L_b6db:
        cpy $18
        bne L_b6eb
        cmp $17
        bne L_b6eb
        sta $16
        sbc #$03
        sta $17
        ldy #$00
    L_b6eb:
        rts 


        jsr L_b7a1
        txa 
        pha 
        lda #$01
        jsr L_b47d
        pla 
        ldy #$00
        sta ($62),y
        pla 
        pla 
        jmp L_b4ca
        jsr L_b761
        cmp ($50),y
        tya 
    L_b706:
        bcc L_b70c
        lda ($50),y
        tax 
        tya 
    L_b70c:
        pha 
    L_b70d:
        txa 
    L_b70e:
        pha 
        jsr L_b47d
        lda $50
        ldy $51
        jsr L_b6aa
        pla 
        tay 
        pla 
        clc 
        adc $22
        sta $22
        bcc L_b725
        inc $23
    L_b725:
        tya 
        jsr L_b68c
        jmp L_b4ca
        jsr L_b761
        clc 
        sbc ($50),y
        eor #$ff
        jmp L_b706
        lda #$ff
        sta $65
        jsr.a $0079
        cmp #$29
        beq L_b748
        jsr $aefd
        jsr L_b79e
    L_b748:
        jsr L_b761
        beq L_b798
        dex 
        txa 
        pha 
        clc 
        ldx #$00
        sbc ($50),y
        bcs L_b70d
        eor #$ff
        cmp $65
        bcc L_b70e
        lda $65
        bcs L_b70e
    L_b761:
        jsr L_aef7
        pla 
        tay 
        pla 
        sta $55
        pla 
        pla 
        pla 
        tax 
        pla 
        sta $50
        pla 
        sta $51
        lda $55
        pha 
        tya 
        pha 
        ldy #$00
        txa 
        rts 


        jsr L_b782
        jmp L_b3a2
    L_b782:
        jsr L_b6a3
        ldx #$00
        stx $0d
        tay 
        rts 


        jsr L_b782
        beq L_b798
        ldy #$00
        lda ($22),y
        tay 
        jmp L_b3a2
    L_b798:
        jmp $b248
    L_b79b:
        jsr.a $0073
    L_b79e:
        jsr L_ad8a
    L_b7a1:
        jsr L_b1b8
        ldx $64
        bne L_b798
        ldx $65
        jmp.a $0079
    L_b7ad:
        jsr L_b782
    L_b7b0:
        bne L_b7b5
    L_b7b2:
        jmp L_b8f7
    L_b7b5:
        ldx $7a
        ldy $7b
        stx $71
        sty $72
        ldx $22
        stx $7a
        clc 
        adc $22
        sta $24
    L_b7c6:
        ldx $23
    L_b7c8:
        stx $7b
        bcc L_b7cd
    L_b7cc:
        inx 
    L_b7cd:
        stx $25
    L_b7cf:
        ldy #$00
        lda ($24),y
        pha 
        tya 
        sta ($24),y
        jsr.a $0079
        jsr L_bcf3
        pla 
        ldy #$00
        sta ($24),y
    L_b7e2:
        ldx $71
        ldy $72
        stx $7a
        sty $7b
        rts 


    L_b7eb:
        jsr L_ad8a
        jsr L_b7f7
    L_b7f1:
        jsr $aefd
        jmp L_b79e
    L_b7f7:
        lda $66
        bmi L_b798
    L_b7fb:
        lda $61
        cmp #$91
        bcs L_b798
        jsr L_bc9b
        lda $64
        ldy $65
        sty $14
        sta $15
        rts 


        lda $15
        pha 
        lda $14
        pha 
    L_b813:
        jsr L_b7f7
        ldy #$00
        lda ($14),y
        tay 
        pla 
        sta $14
        pla 
        sta $15
        jmp L_b3a2
        jsr L_b7eb
        txa 
        ldy #$00
        sta ($14),y
        rts 


        jsr L_b7eb
        stx $49
        ldx #$00
        jsr.a $0079
        beq L_b83c
        jsr L_b7f1
    L_b83c:
        stx $4a
        ldy #$00
    L_b840:
        lda ($14),y
        eor $4a
        and $49
        beq L_b840
    L_b848:
        rts 


    L_b849:
        lda #$11
        ldy #$bf
        jmp L_b867
    L_b850:
        jsr L_ba8c
    L_b853:
        lda $66
        eor #$ff
        sta $66
        eor $6e
        sta $6f
        lda $61
        jmp L_b86a
    L_b862:
        jsr L_b999
        bcc L_b8a3
    L_b867:
        jsr L_ba8c
    L_b86a:
        bne L_b86f
        jmp L_bbfc
    L_b86f:
        ldx $70
        stx $56
        ldx #$69
        lda $69
    L_b877:
        tay 
        beq L_b848
        sec 
        sbc $61
        beq L_b8a3
        bcc L_b893
        sty $61
        ldy $6e
        sty $66
        eor #$ff
        adc #$00
        ldy #$00
        sty $56
        ldx #$61
        bne L_b897
    L_b893:
        ldy #$00
        sty $70
    L_b897:
        cmp #$f9
        bmi L_b862
        tay 
        lda $70
        lsr $01,x
        jsr L_b9b0
    L_b8a3:
        bit $6f
        bpl L_b8fe
        ldy #$61
        cpx #$69
        beq L_b8af
        ldy #$69
    L_b8af:
        sec 
        eor #$ff
        adc $56
        sta $70
        lda.a $0004,y
        sbc $04,x
        sta $65
        lda.a $0003,y
        sbc $03,x
        sta $64
        lda.a $0002,y
        sbc $02,x
        sta $63
        lda.a $0001,y
        sbc $01,x
        sta $62
    L_b8d2:
        bcs L_b8d7
        jsr L_b947
    L_b8d7:
        ldy #$00
        tya 
        clc 
    L_b8db:
        ldx $62
        bne L_b929
        ldx $63
        stx $62
        ldx $64
        stx $63
        ldx $65
        stx $64
        ldx $70
        stx $65
        sty $70
        adc #$08
        cmp #$20
        bne L_b8db
    L_b8f7:
        lda #$00
    L_b8f9:
        sta $61
    L_b8fb:
        sta $66
        rts 


    L_b8fe:
        adc $56
        sta $70
        lda $65
        adc $6d
        sta $65
        lda $64
        adc $6c
        sta $64
        lda $63
        adc $6b
        sta $63
        lda $62
        adc $6a
        sta $62
        jmp L_b936
    L_b91d:
        adc #$01
        asl $70
        rol $65
        rol $64
        rol $63
        rol $62
    L_b929:
        bpl L_b91d
        sec 
        sbc $61
        bcs L_b8f7
        eor #$ff
        adc #$01
        sta $61
    L_b936:
        bcc L_b946
    L_b938:
        inc $61
        beq L_b97e
        ror $62
        ror $63
        ror $64
        ror $65
        ror $70
    L_b946:
        rts 


    L_b947:
        lda $66
        eor #$ff
        sta $66
    L_b94d:
        lda $62
        eor #$ff
        sta $62
        lda $63
        eor #$ff
        sta $63
        lda $64
        eor #$ff
        sta $64
        lda $65
        eor #$ff
        sta $65
        lda $70
        eor #$ff
        sta $70
        inc $70
        bne L_b97d
    L_b96f:
        inc $65
        bne L_b97d
        inc $64
        bne L_b97d
        inc $63
        bne L_b97d
        inc $62
    L_b97d:
        rts 


    L_b97e:
        ldx #$0f
        jmp L_a437
    L_b983:
        ldx #$25
    L_b985:
        ldy $04,x
        sty $70
        ldy $03,x
        sty $04,x
        ldy $02,x
        sty $03,x
        ldy $01,x
        sty $02,x
        ldy $68
        sty $01,x
    L_b999:
        adc #$08
        bmi L_b985
        beq L_b985
        sbc #$08
        tay 
        lda $70
        bcs L_b9ba
    L_b9a6:
        asl $01,x
        bcc L_b9ac
        inc $01,x
    L_b9ac:
        ror $01,x
        ror $01,x
    L_b9b0:
        ror $02,x
        ror $03,x
        ror $04,x
        ror 
        iny 
        bne L_b9a6
    L_b9ba:
        clc 
        rts 



        .byte $81,$00,$00,$00,$00,$03,$7f,$5e,$56,$cb,$79,$80,$13,$9b,$0b,$64
        .byte $80,$76,$38,$93,$16,$82,$38,$aa,$3b,$20,$80,$35,$04,$f3,$34,$81
        .byte $35,$04,$f3,$34,$80,$80,$00,$00,$00,$80,$31,$72,$17,$f8

    L_b9ea:
        jsr L_bc2b
        beq L_b9f1
        bpl L_b9f4
    L_b9f1:
        jmp $b248
    L_b9f4:
        lda $61
        sbc #$7f
        pha 
        lda #$80
        sta $61
        lda #$d6
        ldy #$b9
        jsr L_b867
        lda #$db
        ldy #$b9
        jsr L_bb0f
        lda #$bc
        ldy #$b9
        jsr L_b850
        lda #$c1
        ldy #$b9
        jsr L_e043
        lda #$e0
        ldy #$b9
        jsr L_b867
        pla 
        jsr L_bd7e
        lda #$e5
        ldy #$b9
    L_ba28:
        jsr L_ba8c
        bne L_ba30
        jmp L_ba8b
    L_ba30:
        jsr L_bab7
        lda #$00
        sta $26
        sta $27
        sta $28
        sta $29
        lda $70
        jsr L_ba59
        lda $65
        jsr L_ba59
        lda $64
        jsr L_ba59
        lda $63
        jsr L_ba59
        lda $62
        jsr L_ba5e
        jmp L_bb8f
    L_ba59:
        bne L_ba5e
        jmp L_b983
    L_ba5e:
        lsr 
        ora #$80
    L_ba61:
        tay 
        bcc L_ba7d
        clc 
        lda $29
        adc $6d
        sta $29
        lda $28
        adc $6c
        sta $28
        lda $27
        adc $6b
        sta $27
        lda $26
        adc $6a
        sta $26
    L_ba7d:
        ror $26
        ror $27
        ror $28
        ror $29
        ror $70
        tya 
        lsr 
        bne L_ba61
    L_ba8b:
        rts 


    L_ba8c:
        sta $22
        sty $23
        ldy #$04
        lda ($22),y
        sta $6d
        dey 
        lda ($22),y
        sta $6c
        dey 
        lda ($22),y
        sta $6b
        dey 
        lda ($22),y
        sta $6e
        eor $66
        sta $6f
        lda $6e
        ora #$80
        sta $6a
        dey 
        lda ($22),y
        sta $69
        lda $61
        rts 



    L_bab7:
         .byte $a5,$69,$f0,$1f,$18,$65,$61,$90,$04
        .byte $30,$1d,$18,$2c,$10,$14,$69,$80,$85,$61,$d0,$03,$4c,$fb,$b8

    L_bacf:
        lda $6f
        sta $66
        rts 


    L_bad4:
        lda $66
        eor #$ff
        bmi L_badf
        pla 
        pla 
        jmp L_b8f7
    L_badf:
        jmp L_b97e
    L_bae2:
        jsr L_bc0c
        tax 
        beq L_baf8
        clc 
        adc #$02
        bcs L_badf
    L_baed:
        ldx #$00
        stx $6f
        jsr L_b877
        inc $61
        beq L_badf
    L_baf8:
        rts 



        .byte $84,$20,$00,$00,$00

    L_bafe:
        jsr L_bc0c
        lda #$f9
        ldy #$ba
        ldx #$00
    L_bb07:
        stx $6f
        jsr L_bba2
        jmp L_bb12
    L_bb0f:
        jsr L_ba8c
    L_bb12:
        beq L_bb8a
        jsr L_bc1b
        lda #$00
        sec 
        sbc $61
        sta $61
        jsr L_bab7
        inc $61
        beq L_badf
        ldx #$fc
        lda #$01
    L_bb29:
        ldy $6a
        cpy $62
        bne L_bb3f
        ldy $6b
        cpy $63
        bne L_bb3f
        ldy $6c
        cpy $64
        bne L_bb3f
        ldy $6d
        cpy $65
    L_bb3f:
        php 
        rol 
        bcc L_bb4c
        inx 
        sta $29,x
        beq L_bb7a
        bpl L_bb7e
        lda #$01
    L_bb4c:
        plp 
        bcs L_bb5d
    L_bb4f:
        asl $6d
        rol $6c
        rol $6b
        rol $6a
        bcs L_bb3f
        bmi L_bb29
        bpl L_bb3f
    L_bb5d:
        tay 
        lda $6d
        sbc $65
        sta $6d
        lda $6c
        sbc $64
        sta $6c
        lda $6b
        sbc $63
        sta $6b
        lda $6a
        sbc $62
        sta $6a
        tya 
        jmp L_bb4f
    L_bb7a:
        lda #$40
        bne L_bb4c
    L_bb7e:
        asl 
        asl 
        asl 
        asl 
        asl 
        asl 
        sta $70
        plp 
        jmp L_bb8f
    L_bb8a:
        ldx #$14
        jmp L_a437
    L_bb8f:
        lda $26
        sta $62
    L_bb93:
        lda $27
        sta $63
        lda $28
        sta $64
        lda $29
        sta $65
        jmp L_b8d7
    L_bba2:
        sta $22
        sty $23
        ldy #$04
        lda ($22),y
        sta $65
        dey 
        lda ($22),y
        sta $64
        dey 
        lda ($22),y
        sta $63
        dey 
        lda ($22),y
        sta $66
        ora #$80
        sta $62
        dey 
        lda ($22),y
        sta $61
        sty $70
        rts 


    L_bbc7:
        ldx #$5c
        bit L_57a2
        ldy #$00
        beq L_bbd4
    L_bbd0:
        ldx $49
        ldy $4a
    L_bbd4:
        jsr L_bc1b
        stx $22
        sty $23
        ldy #$04
        lda $65
        sta ($22),y
        dey 
        lda $64
        sta ($22),y
        dey 
        lda $63
        sta ($22),y
        dey 
        lda $66
        ora #$7f
        and $62
        sta ($22),y
        dey 
        lda $61
        sta ($22),y
        sty $70
        rts 


    L_bbfc:
        lda $6e
    L_bbfe:
        sta $66
        ldx #$05
    L_bc02:
        lda $68,x
        sta $60,x
        dex 
        bne L_bc02
        stx $70
        rts 


    L_bc0c:
        jsr L_bc1b
    L_bc0f:
        ldx #$06
    L_bc11:
        lda $60,x
        sta $68,x
        dex 
        bne L_bc11
        stx $70
    L_bc1a:
        rts 


    L_bc1b:
        lda $61
        beq L_bc1a
        asl $70
        bcc L_bc1a
    L_bc23:
        jsr L_b96f
        bne L_bc1a
        jmp L_b938
    L_bc2b:
        lda $61
        beq L_bc38
    L_bc2f:
        lda $66
    L_bc31:
        rol 
        lda #$ff
        bcs L_bc38
        lda #$01
    L_bc38:
        rts 


        jsr L_bc2b
    L_bc3c:
        sta $62
        lda #$00
        sta $63
        ldx #$88
    L_bc44:
        lda $62
        eor #$ff
        rol 
    L_bc49:
        lda #$00
        sta $65
        sta $64
    L_bc4f:
        stx $61
        sta $70
        sta $66
        jmp L_b8d2
    L_bc58:
        lsr $66
        rts 


    L_bc5b:
        sta $24
    L_bc5d:
        sty $25
        ldy #$00
        lda ($24),y
        iny 
        tax 
        beq L_bc2b
        lda ($24),y
        eor $66
        bmi L_bc2f
        cpx $61
        bne L_bc92
        lda ($24),y
        ora #$80
        cmp $62
        bne L_bc92
        iny 
        lda ($24),y
        cmp $63
        bne L_bc92
        iny 
        lda ($24),y
        cmp $64
        bne L_bc92
        iny 
        lda #$7f
        cmp $70
        lda ($24),y
        sbc $65
        beq L_bcba
    L_bc92:
        lda $66
        bcc L_bc98
        eor #$ff
    L_bc98:
        jmp L_bc31
    L_bc9b:
        lda $61
        beq L_bce9
        sec 
        sbc #$a0
        bit $66
        bpl L_bcaf
        tax 
        lda #$ff
        sta $68
        jsr L_b94d
        txa 
    L_bcaf:
        ldx #$61
        cmp #$f9
        bpl L_bcbb
        jsr L_b999
        sty $68
    L_bcba:
        rts 


    L_bcbb:
        tay 
        lda $66
        and #$80
        lsr $62
        ora $62
        sta $62
        jsr L_b9b0
        sty $68
        rts 


    L_bccc:
        lda $61
        cmp #$a0
        bcs L_bcf2
        jsr L_bc9b
        sty $70
        lda $66
        sty $66
        eor #$80
        rol 
        lda #$a0
        sta $61
        lda $65
        sta $07
        jmp L_b8d2
    L_bce9:
        sta $62
        sta $63
        sta $64
        sta $65
        tay 
    L_bcf2:
        rts 


    L_bcf3:
        ldy #$00
        ldx #$0a
    L_bcf7:
        sty $5d,x
        dex 
        bpl L_bcf7
        bcc L_bd0d
        cmp #$2d
        bne L_bd06
        stx $67
        beq L_bd0a
    L_bd06:
        cmp #$2b
        bne L_bd0f
    L_bd0a:
        jsr.a $0073
    L_bd0d:
        bcc L_bd6a
    L_bd0f:
        cmp #$2e
        beq L_bd41
        cmp #$45
        bne L_bd47
        jsr.a $0073
        bcc L_bd33
        cmp #$ab
        beq L_bd2e
        cmp #$2d
        beq L_bd2e
        cmp #$aa
        beq L_bd30
        cmp #$2b
        beq L_bd30
        bne L_bd35
    L_bd2e:
        ror $60
    L_bd30:
        jsr.a $0073
    L_bd33:
        bcc L_bd91
    L_bd35:
        bit $60
        bpl L_bd47
        lda #$00
        sec 
        sbc $5e
        jmp L_bd49
    L_bd41:
        ror $5f
        bit $5f
        bvc L_bd0a
    L_bd47:
        lda $5e
    L_bd49:
        sec 
        sbc $5d
        sta $5e
        beq L_bd62
        bpl L_bd5b
    L_bd52:
        jsr L_bafe
        inc $5e
        bne L_bd52
        beq L_bd62
    L_bd5b:
        jsr L_bae2
        dec $5e
        bne L_bd5b
    L_bd62:
        lda $67
        bmi L_bd67
        rts 


    L_bd67:
        jmp L_bfb4
    L_bd6a:
        pha 
        bit $5f
        bpl L_bd71
        inc $5d
    L_bd71:
        jsr L_bae2
        pla 
        sec 
        sbc #$30
    L_bd78:
        jsr L_bd7e
        jmp L_bd0a
    L_bd7e:
        pha 
        jsr L_bc0c
        pla 
        jsr L_bc3c
        lda $6e
        eor $66
        sta $6f
        ldx $61
        jmp L_b86a
    L_bd91:
        lda $5e
        cmp #$0a
        bcc L_bda0
        lda #$64
        bit $60
        bmi L_bdae
        jmp L_b97e
    L_bda0:
        asl 
        asl 
        clc 
        adc $5e
        asl 
        clc 
        ldy #$00
        adc ($7a),y
        sec 
        sbc #$30
    L_bdae:
        sta $5e
        jmp L_bd30

        .byte $9b,$3e,$bc,$1f,$fd,$9e,$6e,$6b,$27,$fd,$9e,$6e,$6b,$28,$00

    L_bdc2:
        lda #$71
        ldy #$a3
        jsr L_bdda
        lda $3a
        ldx $39
    L_bdcd:
        sta $62
        stx $63
        ldx #$90
        sec 
        jsr L_bc49
        jsr L_bddf
    L_bdda:
        jmp L_ab1e
    L_bddd:
        ldy #$01
    L_bddf:
        lda #$20
        bit $66
        bpl L_bde7
        lda #$2d
    L_bde7:
        sta.a $00ff,y
        sta $66
        sty $71
        iny 
        lda #$30
        ldx $61
        bne L_bdf8
        jmp L_bf04
    L_bdf8:
        lda #$00
        cpx #$80
        beq L_be00
        bcs L_be09
    L_be00:
        lda #$bd
        ldy #$bd
        jsr L_ba28
        lda #$f7
    L_be09:
        sta $5d
    L_be0b:
        lda #$b8
    L_be0d:
        ldy #$bd
        jsr L_bc5b
        beq L_be32
        bpl L_be28
    L_be16:
        lda #$b3
        ldy #$bd
        jsr L_bc5b
        beq L_be21
        bpl L_be2f
    L_be21:
        jsr L_bae2
        dec $5d
        bne L_be16
    L_be28:
        jsr L_bafe
        inc $5d
        bne L_be0b
    L_be2f:
        jsr L_b849
    L_be32:
        jsr L_bc9b
        ldx #$01
        lda $5d
        clc 
        adc #$0a
        bmi L_be47
        cmp #$0b
        bcs L_be48
        adc #$ff
        tax 
        lda #$02
    L_be47:
        sec 
    L_be48:
        sbc #$02
        sta $5e
        stx $5d
        txa 
    L_be4f:
        beq L_be53
        bpl L_be66
    L_be53:
        ldy $71
        lda #$2e
        iny 
        sta.a $00ff,y
        txa 
        beq L_be64
        lda #$30
        iny 
        sta.a $00ff,y
    L_be64:
        sty $71
    L_be66:
        ldy #$00
    L_be68:
        ldx #$80
    L_be6a:
        lda $65
        clc 
        adc L_bf18 + $1,y
    L_be70:
        sta $65
        lda $64
        adc L_bf18,y
        sta $64
        lda $63
        adc L_bf17,y
        sta $63
        lda $62
        adc L_bf11 + $5,y
        sta $62
        inx 
        bcs L_be8e
        bpl L_be6a
        bmi L_be90
    L_be8e:
        bmi L_be6a
    L_be90:
        txa 
        bcc L_be97
        eor #$ff
        adc #$0a
    L_be97:
        adc #$2f
        iny 
        iny 
        iny 
        iny 
        sty $47
        ldy $71
        iny 
        tax 
        and #$7f
        sta.a $00ff,y
        dec $5d
        bne L_beb2
        lda #$2e
        iny 
        sta.a $00ff,y
    L_beb2:
        sty $71
        ldy $47
        txa 
        eor #$ff
        and #$80
        tax 
        cpy #$24
    L_bebe:
        beq L_bec4
        cpy #$3c
        bne L_be6a
    L_bec4:
        ldy $71
    L_bec6:
        lda.a $00ff,y
        dey 
        cmp #$30
        beq L_bec6
        cmp #$2e
        beq L_bed3
        iny 
    L_bed3:
        lda #$2b
        ldx $5e
        beq L_bf07
        bpl L_bee3
        lda #$00
        sec 
    L_bede:
        sbc $5e
        tax 
        lda #$2d
    L_bee3:
        sta $0101,y
        lda #$45
        sta $0100,y
        txa 
        ldx #$2f
        sec 
    L_beef:
        inx 
        sbc #$0a
        bcs L_beef
        adc #$3a
        sta $0103,y
        txa 
        sta $0102,y
        lda #$00
        sta $0104,y
        beq L_bf0c
    L_bf04:
        sta.a $00ff,y
    L_bf07:
        lda #$00
        sta $0100,y
    L_bf0c:
        lda #$00
        ldy #$01
        rts 



    L_bf11:
         .byte $80,$00,$00,$00,$00,$fa

    L_bf17:
        asl 

    L_bf18:
         .byte $1f,$00,$00
        .byte $98,$96,$80,$ff,$f0,$bd,$c0,$00,$01,$86,$a0,$ff,$ff,$d8,$f0,$00
        .byte $00,$03,$e8,$ff,$ff,$ff,$9c,$00,$00,$00,$0a,$ff,$ff,$ff,$ff,$ff
        .byte $df,$0a

    L_bf3d:
        .byte $80,$00,$03,$4b
        .byte $c0,$ff,$ff,$73,$60,$00,$00,$0e,$10,$ff,$ff,$fd,$a8,$00,$00,$00
        .byte $3c,$ec
        .fill $17, $aa

    L_bf6a:
        tax 
        tax 
        tax 
        tax 
        tax 
        tax 
        tax 
        jsr L_bc0c
        lda #$11
        ldy #$bf
        jsr L_bba2
        beq L_bfed
        lda $69
        bne L_bf84
        jmp L_b8f9
    L_bf84:
        ldx #$4e
        ldy #$00
        jsr L_bbd4
        lda $6e
        bpl L_bf9e
        jsr L_bccc
        lda #$4e
        ldy #$00
        jsr L_bc5b
        bne L_bf9e
        tya 
        ldy $07
    L_bf9e:
        jsr L_bbfe
        tya 
        pha 
        jsr L_b9ea
        lda #$4e
        ldy #$00
        jsr L_ba28
        jsr L_bfed
        pla 
        lsr 
        bcc L_bfbe
    L_bfb4:
        lda $61
        beq L_bfbe
        lda $66
        eor #$ff
        sta $66
    L_bfbe:
        rts 



        .byte $81,$38,$aa,$3b,$29,$07,$71,$34,$58,$3e,$56,$74,$16,$7e,$b3,$1b
        .byte $77,$2f,$ee,$e3,$85,$7a,$1d,$84,$1c,$2a,$7c,$63,$59,$58,$0a,$7e
        .byte $75,$fd,$e7,$c6,$80,$31,$72,$18,$10,$81,$00,$00,$00,$00

    L_bfed:
        lda #$bf
        ldy #$bf
        jsr L_ba28
        lda $70
        adc #$50
        bcc L_bffd
        jsr L_bc23
    L_bffd:
        jmp L_e000

        .byte $d0,$8d,$17,$d0,$a2,$07

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
        jmp $bf06
        lda #$02
        sta vSpriteXMSB
        lda #$32
        sta vSprite0X
        lda #$23
        sta vSprite1X
        lda $8679
        sta vSprite0Y
        sta vSprite1Y
        lda L_8678
        sta L_4bf8
        sta $4bf9
        lda #$01
        sta vSpr0Col
        sta vSpr1Col
        lda #$00
        sta vSprExpandY
        lda #$e6
        ldx #$ee
        ldy #$c2
        jmp $bf06
    L_c06c:
        lda #$00
        ldx #$54
        ldy #$bf
        jmp $bf06
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
        sta L_4bfb + $4
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
        jmp $bf06
    L_c0c3:
        lda #$00
        ldx #$54
        ldy #$bf
        jmp $bf06
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
        sta L_4bfb + $3
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
        jmp $bf06
    L_c11a:
        lda #$00
        ldx #$54
        ldy #$bf
        jmp $bf06
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
        sta L_4bfb + $2
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
        jmp $bf06
    L_c171:
        lda #$00
        ldx #$54
        ldy #$bf
        jmp $bf06
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
        sta L_4bfb + $1
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
        jmp $bf06
    L_c1c8:
        lda #$00
        ldx #$54
        ldy #$bf
        jmp $bf06
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
        sta L_4bfb
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
        jmp $bf06
    L_c21f:
        lda #$00
        ldx #$54
        ldy #$bf
        jmp $bf06
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
        sta $4bfa
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
        sta $4bf9
    L_c2ae:
        sta L_4ff8 + $1
        lda L_968f + $2
        sta $4bfa
        sta L_4ff8 + $2
        lda #$c6
        sta L_4bfb
        sta L_4ff8 + $3
        lda #$c7
        sta L_4bfb + $1
        sta L_4ff8 + $4
        lda #$c8
        sta L_4bfb + $2
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
        jmp $bf06
        lda vScreenControl2
        and #$f8
        sta vScreenControl2
        lda #$00
        ldx #$54
        ldy #$bf
        jmp $bf06
        lda cCia2PortA
        and #$04
        beq L_c31c
        jmp L_bf11 + $4
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
        ldx SCREEN_BUFFER_1 + $305,y
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
        .byte $02,$01,$01,$01,$02,$02,$02,$02,$02,$02,$02,$01,$01,$01,$01,$02
        .byte $02,$01,$01,$01,$01,$01,$02,$01,$01,$02,$02,$01,$01,$01,$01,$01
        .byte $01,$01,$01,$02,$01,$01,$02,$01,$01,$02,$02,$01,$01,$00,$01,$01
        .byte $01,$01

    L_c3ef:
        .byte $00
        .byte $01,$01,$01,$01,$01,$01,$01,$01

    L_c3f8:
        .fill $15, $0
        .byte $01,$00

    L_c40f:
        .byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00
        .byte $01,$01,$01,$00,$01,$01,$01,$00,$00,$01,$01,$00,$00,$01,$01

    L_c428:
        ora ($01,x)
        ora ($01,x)
        ora ($02,x)
        ora ($01,x)
        ora ($01,x)
        ora ($01,x)
        ora ($01,x)
        ora ($01,x)

    L_c438:
         .byte $02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02
        .byte $00,$00

    L_c44a:
        ora ($00,x)
        ora ($00,x)

        .byte $00,$00,$01,$01,$00,$01,$00,$00,$00,$00,$00,$00,$00,$01,$01,$01
        .byte $00,$01,$01,$01,$01,$01,$00,$00,$01,$01,$01,$02,$02,$02,$02,$02
        .byte $02,$02,$02,$02,$02,$02,$01,$01,$01,$01,$01,$02,$02,$01,$02,$01
        .byte $02,$02,$02,$01,$02,$02,$01,$01,$02,$02,$00,$01,$01,$01,$00,$01
        .byte $00,$01,$00,$00,$00,$01,$00,$00,$00,$00,$01,$01,$01,$02,$01,$01
        .byte $01,$01,$01,$00,$01,$01,$00,$00,$01,$01,$02,$02,$02,$02,$02,$02
        .byte $02,$02,$02,$01,$01,$02,$01,$01,$02,$02,$dd,$00,$60,$45,$64,$a1
        .byte $23,$b3,$a0,$0d,$5c,$82,$d2,$d2,$d2,$d2,$81,$b3,$bf,$39,$fc,$4f
        .byte $d6,$fe,$02,$a9,$5b,$4b,$c5,$c5,$5c,$5c,$79,$5a,$b4,$a0,$c8,$bf
        .byte $c1,$ef,$a0,$dd,$bf,$c7,$a0,$a0,$0d,$0d,$be,$be,$b4,$a0,$c8,$00
        .byte $84,$6f,$a0,$9f,$bf,$64,$59,$59,$7c,$7c,$ef,$60,$16,$bf,$aa,$47
        .byte $96,$35,$98,$0f,$15,$02,$01,$01,$31,$31,$8b,$b3,$be,$79,$11,$00
        .byte $d6,$3c,$3b,$9f,$98,$5b,$d2,$d2,$52,$52,$e8,$65,$15,$db,$a0,$bf
        .byte $72,$ab,$00,$db,$fc,$19,$70,$70

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
        lsr $fa58

        .byte $5a,$a0,$fa,$32,$32,$5a,$fa,$a0,$a0,$6f,$82,$d2,$1f,$9c,$9c,$e6
        .byte $1f,$82,$d2,$1f,$01,$07,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01
        .byte $07,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$7c,$6c,$9c,$9c,$9c
        .byte $9c,$9c,$9c,$9c,$9c,$9c,$9c,$74,$98,$98,$98,$98,$98,$98,$98,$98
        .byte $98,$98,$98,$00,$00,$01,$00,$00,$00,$00,$01,$00,$02,$00,$01,$00
        .byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$01,$01,$00,$00,$01,$00
        .byte $00,$01,$01,$00,$00,$00,$01,$01,$01,$01,$01,$01,$01,$00,$01,$00
        .byte $00,$00,$00,$02,$02,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$00
        .byte $00,$00,$02,$00,$00,$00,$00,$00,$01,$00,$00,$01,$00,$00,$00,$00
        .byte $00,$00,$00,$02,$01,$01,$01,$01,$01,$01,$01,$02,$01,$01,$01,$01
        .byte $01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$02,$02,$02,$01
        .byte $01,$01,$01,$01,$02,$02,$01,$02,$02,$01,$01,$01,$02,$01,$01,$01
        .byte $01,$01,$01,$01,$01,$02,$02,$02,$02,$01,$01,$02,$01,$02,$01,$01
        .byte $01,$01,$01,$00,$01
        .fill $14, $0
        .byte $01,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$01,$00
        .byte $00,$00,$00,$00,$00,$00,$01,$01,$00,$00,$00,$00,$00,$00,$00,$00
        .byte $00,$00,$00,$00,$00,$01,$00,$00,$00,$00,$01,$01,$01,$01,$00,$00
        .byte $01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$00
        .byte $01,$01,$02,$02,$01,$02,$00,$02,$01,$01,$01,$01,$01,$01,$01,$01
        .byte $01,$01,$01,$01,$01,$01,$02,$02,$00,$00,$00,$00,$00,$00,$00,$00
        .byte $00,$01,$01

    L_c6c6:
        .byte $00
        .byte $01,$01,$02,$02,$01,$01,$01,$02,$01,$02,$02,$01,$02,$02,$01,$02
        .byte $02,$01,$01,$01,$02,$02,$01,$01,$02,$02

    L_c6e1:
        ora ($01,x)
        ora ($01,x)
        ora ($01,x)
        ora ($01,x)

        .byte $02,$02,$01,$01,$01,$02,$02,$02,$02,$01,$01,$02,$02,$01,$01,$01
        .byte $00,$00,$01,$01,$b4,$8c,$28,$a0,$64

    L_c702:
        sei 
        tax 

        .byte $14,$8c,$0a,$9f,$c8,$be,$be,$83,$83,$64,$50,$be,$be,$64,$82,$5a
        .byte $6e,$29,$5a,$9e,$3d,$84,$84,$32,$32,$de,$64,$f0,$05,$0a,$50,$14
        .byte $0b,$14,$0a,$c8

    L_c728:
        .byte $00
        .byte $f1,$f1,$64,$64,$0a,$32,$78,$8c,$7d,$78,$50,$85,$be,$64,$a0,$63
        .byte $b3,$b3,$30,$88,$f0,$c8,$64,$be,$f0,$0a,$f0,$6f,$a0,$fa,$fa,$be
        .byte $dd,$dd,$f9,$f9,$1e,$64,$c8,$3d,$2a,$64,$be,$8d,$01,$9f,$64,$78
        .byte $c7,$c7,$83,$83,$c0,$f0

    L_c75f:
        ldy $8c,x
        ldx $f03d,y
        inc $e6

        .byte $14,$1e,$28,$c7,$c7,$b3,$b3,$65,$00,$3c,$c8,$0a,$0a

    L_c773:
        iny 
        bcs L_c702

        .byte $02,$f0,$be,$b3,$b3,$77,$77,$c8,$c3,$0a,$3c,$0a,$0a,$a0,$64,$02
        .byte $f0,$28,$e6,$a0,$a0,$c8,$c8,$81,$15,$82,$5a,$96,$64,$c7,$8c,$5a
        .byte $78,$6e,$6f,$aa,$aa,$b3,$b3,$c8,$70,$be,$b4,$aa,$be,$3d,$be,$6f
        .byte $be,$be,$6e,$e6,$e6,$c8,$c8,$be,$bf,$a0,$d2,$14,$8c,$96,$aa,$de
        .byte $78,$a0,$be,$14,$14,$bf,$bf,$64,$64,$82,$6e,$dc,$be,$78,$64,$5a
        .byte $64,$6f,$69,$c8,$c8,$8e,$8e,$3e,$02

    L_c7cf:
        rol 

        .byte $82,$f0,$8c,$82,$64,$6f,$78,$32,$63,$8d,$8d,$aa,$aa,$be,$e6,$6c
        .byte $96,$82,$c8,$d2,$be,$02,$1f,$96,$16,$30,$88

    L_c7eb:
        ldy $b4,x
        iny 
        iny 
        sty L_c86d + $2

        .byte $64,$aa,$82,$5a,$78,$5b,$96,$3d,$3d,$fa,$fa,$be,$aa,$fa,$fa,$98
        .byte $fe,$f0,$3c,$02,$e6,$7f,$45,$29,$29,$50,$50,$82,$0a,$e6,$0b,$05
        .byte $e6,$1e,$02,$dc,$00,$00,$f0,$be,$be,$29,$29,$aa,$be,$05,$0b,$f0
        .byte $c8,$fa,$dc,$be,$bf,$dc,$97,$29,$29,$c9,$c9,$fa,$14,$05,$32,$3d
        .byte $dc,$f0,$3c,$02,$6f,$f0,$dc,$c8,$c8,$78,$78,$00,$01,$01,$01,$01
        .byte $01,$01,$01,$01,$01,$01,$01,$00,$00,$01,$01,$01,$01,$01,$02,$01
        .byte $02,$01,$01,$02,$01,$02,$02,$01,$01,$02,$02,$00,$00,$00,$00,$00
        .byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$01,$01

    L_c86d:
        .byte $00,$00,$00,$00,$00
        .byte $01,$00,$00,$00,$00,$00,$00,$01,$01,$02,$02,$01,$01,$01,$01,$01
        .byte $02,$01,$01,$01,$02,$02,$02,$02,$02,$02,$02,$01,$01,$01,$01,$02
        .byte $02,$01,$01,$01,$01,$01,$02,$01,$01,$02,$02,$01,$01,$01,$01,$01
        .byte $01,$01,$01,$02,$01,$01,$02,$01,$01,$02,$02,$01,$01,$00,$01,$01
        .byte $01,$01,$00,$01,$01,$01,$01,$01,$01,$01,$01
        .fill $15, $0
        .byte $01,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$01,$01,$01,$00
        .byte $01,$01,$01,$00,$00,$01,$01,$00,$00,$01,$01,$01,$01,$01,$01,$01
        .byte $02,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$02,$02,$02,$02,$02
        .byte $02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$00,$00,$01,$00,$01
        .byte $00,$00,$00,$01,$01,$00,$01,$00,$00,$00,$00,$00,$00,$00,$01,$01
        .byte $01,$00,$01,$01,$01,$01,$01,$00,$00,$01,$01,$01,$02,$02,$02,$02
        .byte $02,$02,$02,$02,$02,$02,$02,$01,$01,$01,$01,$01,$02,$02,$01,$02
        .byte $01,$02,$02,$02,$01,$02,$02,$01,$01,$02,$02,$00,$01,$01,$01,$00
        .byte $01,$00,$01,$00,$00,$00,$01,$00,$00,$00,$00,$01,$01,$01,$02,$01
        .byte $01,$01,$01,$01,$00,$01,$01,$00,$00,$01,$01,$02,$02,$02,$02,$02
        .byte $02,$02,$02,$02,$01,$01,$02,$01,$01,$02,$02,$dd,$00,$60,$45,$64
        .byte $a1,$23,$b3,$a0,$0d,$5c,$82,$d2,$d2,$d2,$d2,$81,$b3,$bf,$39,$fc
        .byte $4f,$d6,$fe,$02,$a9,$5b,$4b,$c5,$c5,$5c,$5c,$79,$5a,$b4,$a0,$c8
        .byte $bf,$c1,$ef,$a0,$dd,$bf,$c7,$a0,$a0,$0d,$0d,$be,$be,$b4,$a0,$c8
        .byte $00,$84,$6f,$a0,$9f,$bf,$64,$59,$59,$7c,$7c,$ef,$60,$16,$bf,$aa
        .byte $47,$96,$35,$98,$0f,$15,$02,$01,$01,$31,$31,$8b,$b3,$be,$79,$11
        .byte $00,$d6,$3c,$3b,$9f,$98,$5b,$d2,$d2,$52,$52,$e8,$65,$15,$db,$a0
        .byte $bf,$72,$ab,$00,$db,$fc,$19,$70,$70,$14,$14,$27,$00,$f0,$5c,$5b
        .byte $83,$00,$e7,$00,$15,$27,$38,$00,$00,$7b,$7b,$77,$a9,$a0,$c9,$64
        .byte $9f,$79,$96,$66,$5b,$9a,$d2,$6f,$6f,$dd,$dd,$85,$9f,$a0,$c7,$64
        .byte $01,$81,$70,$66,$65,$aa,$5c,$5c,$5c,$9f,$9f,$98,$2a,$45,$02,$d2
        .byte $bf,$1a,$1d,$c8,$e6,$1d,$3e,$64,$64,$00,$00,$4c,$bf,$a0,$b4,$fb
        .byte $01,$97,$ab,$ab,$4c,$be,$b6,$61,$61,$fa,$fa,$63,$4f,$19,$3b,$5b
        .byte $5b,$5a,$15,$64,$3d,$41,$3f,$1e,$1e,$47,$47,$c7,$c0,$84,$b5,$76
        .byte $bf,$97,$dd,$4f,$be,$dd,$02,$a0,$a0,$8d,$8d,$97,$61,$c9,$bf,$3d
        .byte $4f,$be,$16,$3b,$85,$5b,$22,$50,$50,$3b,$3b,$ec,$02,$19,$44,$02
        .byte $5b,$02,$15,$5b,$45,$23,$4f,$3d,$3d,$9f,$9f,$ec,$03,$5b,$fa,$03
        .byte $47,$03,$5a,$19,$d6,$4f,$0f,$f1,$f1,$51,$51,$e7,$02,$20,$20,$dc
        .byte $01,$6f,$be,$bf,$97,$c8,$5c,$6f,$6f,$d2,$d2,$45,$81,$ab,$09,$c0
        .byte $97,$97,$c8,$e0,$e6,$a9,$d3,$d4,$d4,$d2,$d2,$64,$5a,$65,$63

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
        .byte $ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00

    L_cb44:
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00

    L_cb54:
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

    L_ccb4:
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
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff,$00,$00,$ff,$ff
        .byte $ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff
        .byte $ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff
        .byte $ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff
        .byte $ff,$ff,$00,$00,$00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff

    L_ce44:
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

    L_cff4:
        .byte $00,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$00,$ff,$ff
        .fill $11, $0
        .byte $1b,$9a,$d1,$00,$00,$c8,$00,$15,$79,$f0,$00,$00,$00,$00,$00,$fe
        .byte $f6,$f1,$f2,$f3,$f4,$f0,$f1,$f2,$f3,$f4,$f5,$f6,$f7,$fc
        .fill $11, $ff
        .fill $11, $0
        .byte $1b,$9a,$d1,$00,$00,$c8,$00,$15,$79,$f0,$00,$00,$00,$00,$00,$fe
        .byte $f6,$f1,$f2,$f3,$f4,$f0,$f1,$f2,$f3,$f4,$f5,$f6,$f7,$fc
        .fill $11, $ff
        .fill $11, $0
        .byte $1b,$9a,$d1,$00,$00,$c8,$00,$15,$79,$f0,$00,$00,$00,$00,$00,$fe
        .byte $f6,$f1,$f2,$f3,$f4,$f0,$f1,$f2,$f3,$f4,$f5,$f6,$f7,$fc
        .fill $11, $ff

    L_d0c0:
        .fill $11, $0
        .byte $1b,$9a,$d1,$00,$00,$c8,$00,$15,$79

    L_d0da:
        .byte $f0,$00,$00,$00,$00,$00
        .byte $fe,$f6,$f1,$f2,$f3,$f4,$f0,$f1,$f2,$f3,$f4,$f5,$f6,$f7,$fc
        .fill $11, $ff
        .fill $11, $0
        .byte $1b,$9a,$d1,$00,$00,$c8,$00,$15,$79,$f0,$00,$00,$00,$00,$00,$fe
        .byte $f6,$f1,$f2,$f3,$f4,$f0,$f1,$f2,$f3,$f4,$f5,$f6,$f7,$fc
        .fill $11, $ff
        .fill $11, $0
        .byte $1b,$9a,$d1,$00,$00,$c8,$00,$15,$79,$f0,$00,$00,$00,$00,$00,$fe
        .byte $f6,$f1,$f2,$f3,$f4,$f0,$f1,$f2,$f3,$f4,$f5,$f6,$f7,$fc
        .fill $11, $ff
        .fill $11, $0
        .byte $1b,$9a,$d1,$00,$00,$c8,$00,$15,$79,$f0,$00,$00,$00,$00,$00,$fe
        .byte $f6,$f1,$f2,$f3,$f4,$f0,$f1,$f2,$f3,$f4,$f5,$f6,$f7,$fc
        .fill $11, $ff

    L_d1c0:
        .fill $11, $0
        .byte $1b,$9a,$d1,$00,$00,$c8,$00,$15,$79,$f0,$00,$00,$00,$00,$00,$fe
        .byte $f6,$f1,$f2,$f3,$f4,$f0,$f1,$f2,$f3,$f4,$f5,$f6,$f7,$fc
        .fill $11, $ff
        .fill $11, $0
        .byte $1b,$9a,$d1,$00,$00,$c8,$00,$15,$79,$f0,$00,$00,$00,$00,$00,$fe
        .byte $f6,$f1,$f2,$f3,$f4,$f0,$f1,$f2,$f3,$f4,$f5,$f6,$f7,$fc
        .fill $11, $ff
        .fill $11, $0
        .byte $1b,$9a,$d1,$00,$00,$c8,$00,$15,$79,$f0,$00,$00,$00,$00,$00,$fe
        .byte $f6,$f1,$f2,$f3,$f4,$f0,$f1,$f2,$f3,$f4,$f5,$f6,$f7,$fc
        .fill $11, $ff
        .fill $11, $0
        .byte $1b,$9a,$d1,$00,$00,$c8,$00,$15,$79,$f0,$00,$00,$00,$00,$00,$fe
        .byte $f6,$f1,$f2,$f3,$f4,$f0,$f1,$f2,$f3,$f4,$f5,$f6,$f7,$fc
        .fill $11, $ff
        .fill $11, $0
        .byte $1b,$9a,$d1,$00,$00,$c8,$00,$15,$79,$f0,$00,$00,$00,$00,$00,$fe
        .byte $f6,$f1,$f2,$f3,$f4,$f0,$f1,$f2,$f3,$f4,$f5,$f6,$f7,$fc
        .fill $11, $ff
        .fill $11, $0
        .byte $1b,$9a,$d1,$00,$00,$c8,$00,$15,$79,$f0,$00,$00,$00,$00,$00,$fe
        .byte $f6,$f1,$f2,$f3,$f4,$f0,$f1,$f2,$f3,$f4,$f5,$f6,$f7,$fc
        .fill $11, $ff

    L_d340:
        .fill $11, $0
        .byte $1b,$9a,$d1,$00,$00,$c8,$00,$15,$79,$f0,$00,$00,$00,$00,$00,$fe
        .byte $f6,$f1,$f2,$f3,$f4,$f0,$f1,$f2,$f3,$f4,$f5,$f6,$f7,$fc
        .fill $11, $ff
        .fill $11, $0
        .byte $1b,$9a,$d1,$00,$00,$c8,$00,$15,$79,$f0,$00,$00,$00,$00,$00,$fe
        .byte $f6,$f1,$f2,$f3,$f4,$f0,$f1,$f2,$f3,$f4,$f5,$f6,$f7,$fc
        .fill $11, $ff
        .fill $11, $0
        .byte $1b,$9a,$d1,$00,$00,$c8,$00,$15,$79,$f0,$00,$00,$00,$00,$00,$fe
        .byte $f6,$f1,$f2,$f3,$f4,$f0,$f1,$f2,$f3,$f4,$f5,$f6,$f7,$fc
        .fill $11, $ff
        .byte $d0,$0d,$00,$00,$10,$0e,$e9,$96,$02,$00,$00,$00,$f0,$f0,$96,$02
        .byte $00,$00,$00,$f0,$f0,$00,$5c,$f1,$00,$00,$00,$00,$00,$00,$00,$00
        .byte $d0,$0d,$00,$00,$10,$0e,$e9,$96,$02,$00,$00,$00,$f0,$f0,$96,$02
        .byte $00,$00,$00,$f0,$f0,$00,$5c,$f1,$00,$00,$00,$00,$00,$00,$00,$00
        .byte $d0,$0d,$00,$00,$10,$0e,$e9,$96,$02,$00,$00,$00,$f0,$f0,$96,$02
        .byte $00,$00,$00,$f0,$f0,$00,$5c,$f1,$00,$00,$00,$00,$00,$00,$00,$00
        .byte $d0,$0d,$00,$00,$10,$0e,$e9,$96,$02,$00,$00,$00,$f0,$f0,$96,$02
        .byte $00,$00,$00,$f0,$f0,$00,$5c,$f1,$00,$00,$00,$00,$00,$00,$00,$00
        .byte $d0,$0d,$00,$00,$10,$0e,$e9,$96,$02,$00,$00,$00,$f0,$f0,$96,$02
        .byte $00,$00,$00,$f0,$f0,$00,$5c,$f1,$00,$00,$00,$00,$00,$00,$00,$00
        .byte $d0,$0d,$00,$00,$10,$0e,$e9,$96,$02,$00,$00,$00,$f0,$f0,$96,$02
        .byte $00,$00,$00,$f0,$f0,$00,$5c,$f1,$00,$00,$00,$00,$00,$00,$00,$00
        .byte $d0,$0d,$00,$00,$10,$0e

    L_d4c6:
        sbc #$96

        .byte $02,$00,$00,$00,$f0,$f0,$96,$02,$00,$00,$00,$f0,$f0,$00,$5c,$f1
        .byte $00,$00,$00,$00,$00,$00,$00,$00,$d0,$0d,$00,$00,$10,$0e,$e9,$96
        .byte $02,$00,$00,$00,$f0,$f0,$96,$02,$00,$00,$00,$f0,$f0,$00,$5c,$f1
        .byte $00,$00,$00,$00,$00,$00,$00,$00,$d0,$0d,$00,$00,$10,$0e,$e9,$96
        .byte $02,$00,$00,$00,$f0,$f0,$96,$02,$00,$00,$00,$f0,$f0,$00,$5c,$f1
        .byte $00,$00,$00,$00,$00,$00,$00,$00,$d0,$0d,$00,$00,$10,$0e,$e9,$96
        .byte $02,$00,$00,$00,$f0,$f0,$96,$02,$00,$00,$00,$f0,$f0,$00,$5c,$f1
        .byte $00,$00,$00,$00,$00,$00,$00,$00,$d0,$0d,$00,$00,$10,$0e,$e9,$96
        .byte $02,$00,$00,$00,$f0,$f0,$96,$02,$00,$00,$00,$f0,$f0,$00,$5c,$f1
        .byte $00,$00,$00,$00,$00,$00,$00,$00,$d0,$0d,$00,$00,$10,$0e,$e9,$96
        .byte $02,$00,$00,$00,$f0,$f0,$96,$02,$00,$00,$00,$f0,$f0,$00,$5c,$f1
        .byte $00,$00,$00,$00,$00,$00,$00,$00,$d0,$0d,$00,$00,$10,$0e,$e9,$96
        .byte $02,$00,$00,$00,$f0,$f0,$96,$02,$00,$00,$00,$f0,$f0,$00,$5c,$f1
        .byte $00,$00,$00,$00,$00,$00,$00,$00,$d0,$0d,$00,$00,$10,$0e,$e9,$96
        .byte $02,$00,$00,$00,$f0,$f0,$96,$02,$00,$00,$00,$f0,$f0,$00,$5c,$f1
        .byte $00,$00,$00,$00,$00,$00,$00,$00,$d0,$0d,$00,$00,$10,$0e,$e9,$96
        .byte $02,$00,$00,$00,$f0,$f0

    L_d5ce:
        stx $02,y

        .byte $00,$00,$00,$f0,$f0,$00,$5c,$f1,$00,$00,$00,$00,$00,$00,$00,$00
        .byte $d0,$0d,$00,$00,$10,$0e,$e9,$96,$02,$00,$00,$00,$f0,$f0,$96,$02
        .byte $00,$00,$00,$f0,$f0,$00,$5c,$f1,$00,$00,$00,$00,$00,$00,$00,$00
        .byte $d0,$0d,$00,$00,$10,$0e,$e9,$96,$02,$00,$00,$00,$f0,$f0,$96,$02
        .byte $00,$00,$00,$f0,$f0,$00,$5c,$f1,$00,$00,$00,$00,$00,$00,$00,$00
        .byte $d0,$0d,$00,$00,$10,$0e,$e9,$96,$02,$00,$00,$00,$f0,$f0,$96,$02
        .byte $00,$00,$00,$f0,$f0,$00,$5c,$f1,$00,$00,$00,$00,$00,$00,$00,$00
        .byte $d0,$0d,$00,$00,$10,$0e,$e9,$96,$02,$00,$00,$00,$f0,$f0,$96,$02
        .byte $00,$00,$00,$f0,$f0,$00,$5c,$f1,$00,$00,$00,$00,$00,$00,$00,$00
        .byte $d0,$0d,$00,$00,$10,$0e,$e9,$96,$02,$00,$00,$00,$f0,$f0,$96,$02
        .byte $00,$00,$00,$f0,$f0,$00,$5c,$f1,$00,$00,$00,$00,$00,$00,$00,$00
        .byte $d0,$0d,$00,$00,$10,$0e,$e9,$96,$02,$00,$00,$00,$f0,$f0,$96,$02
        .byte $00,$00,$00,$f0,$f0,$00,$5c,$f1,$00

    L_d699:
        .byte $00,$00,$00,$00,$00,$00,$00,$d0,$0d,$00,$00,$10,$0e
        .byte $e9,$96,$02,$00,$00,$00,$f0,$f0,$96,$02,$00,$00,$00,$f0,$f0,$00
        .byte $5c,$f1,$00,$00,$00,$00,$00,$00,$00,$00,$d0,$0d,$00,$00,$10,$0e
        .byte $e9,$96,$02,$00,$00,$00,$f0,$f0,$96,$02,$00,$00,$00,$f0,$f0,$00
        .byte $5c,$f1,$00,$00,$00,$00,$00,$00,$00,$00,$d0,$0d,$00,$00,$10,$0e
        .byte $e9,$96,$02,$00,$00,$00,$f0,$f0,$96,$02,$00,$00,$00,$f0,$f0,$00
        .byte $5c,$f1,$00,$00,$00,$00,$00,$00,$00,$00,$d0,$0d,$00,$00,$10,$0e
        .byte $e9,$96,$02,$00,$00,$00,$f0,$f0,$96,$02,$00,$00,$00,$f0,$f0,$00
        .byte $5c,$f1,$00,$00,$00,$00,$00,$00,$00,$00,$d0,$0d,$00,$00,$10,$0e
        .byte $e9,$96,$02,$00,$00,$00,$f0,$f0,$96,$02,$00,$00,$00,$f0,$f0,$00
        .byte $5c,$f1,$00

    L_d739:
        .byte $00,$00,$00,$00,$00,$00,$00,$d0,$0d,$00,$00,$10,$0e
        .byte $e9,$96,$02,$00,$00,$00,$f0,$f0,$96,$02,$00,$00,$00,$f0,$f0,$00
        .byte $5c,$f1,$00,$00,$00,$00,$00,$00,$00,$00,$d0,$0d,$00,$00,$10,$0e
        .byte $e9,$96,$02,$00,$00,$00,$f0,$f0,$96,$02,$00,$00,$00,$f0,$f0,$00
        .byte $5c,$f1,$00,$00,$00,$00,$00,$00,$00,$00,$d0,$0d,$00,$00,$10,$0e
        .byte $e9,$96,$02,$00,$00,$00,$f0,$f0,$96,$02,$00,$00,$00,$f0,$f0,$00
        .byte $5c,$f1,$00,$00,$00,$00,$00,$00,$00,$00,$d0,$0d,$00,$00,$10,$0e
        .byte $e9,$96,$02,$00,$00,$00,$f0,$f0,$96,$02,$00,$00,$00,$f0,$f0,$00
        .byte $5c,$f1,$00,$00,$00,$00,$00,$00,$00,$00,$d0,$0d,$00,$00,$10,$0e
        .byte $e9,$96,$02,$00,$00,$00,$f0,$f0,$96,$02,$00,$00,$00,$f0,$f0,$00
        .byte $5c,$f1,$00,$00,$00,$00,$00,$00,$00,$00,$d0,$0d,$00,$00,$10,$0e
        .byte $e9,$96,$02,$00,$00,$00,$f0,$f0,$96,$02,$00,$00,$00,$f0,$f0,$00
        .byte $5c,$f1,$00,$00,$00,$00,$00,$00,$00,$00
        .fill $3de, $fe

    L_dbde:
        inc L_fefe,x
        inc L_fefe,x
    L_dbe4:
        inc L_fefe,x
        inc L_f0f0,x

        .byte $f0,$f0

    L_dbec:
        beq L_dbde

        .fill $12, $f0
        .byte $7f,$ff,$ff,$00,$a7,$03,$ff,$ff,$00,$00,$00,$01,$00,$00,$01,$08
        .byte $7f,$ff,$ff,$00,$a7,$03,$ff,$ff,$00,$00,$00,$01,$00,$00,$01,$08

    L_dc20:
        .byte $7f,$ff,$ff,$00,$a7,$03,$ff,$ff,$00,$00,$00
        .byte $01,$00,$00,$01,$08,$7f,$ff,$ff,$00,$a7,$03,$ff,$ff,$00,$00,$00
        .byte $01,$00,$00,$01,$08,$7f,$ff,$ff,$00,$a7,$03,$ff,$ff,$00,$00,$00
        .byte $01,$00,$00,$01,$08,$7f,$ff,$ff,$00,$a7,$03,$ff,$ff,$00,$00,$00
        .byte $01,$00,$00,$01,$08,$7f,$ff,$ff,$00,$a7,$03,$ff,$ff,$00,$00,$00
        .byte $01,$00,$00,$01,$08,$7f,$ff,$ff,$00,$a7,$03,$ff,$ff,$00,$00,$00
        .byte $01,$00,$00,$01,$08,$7f,$ff,$ff,$00,$a7,$03,$ff,$ff,$00,$00,$00
        .byte $01,$00,$00,$01,$08,$7f,$ff,$ff,$00,$a7,$03,$ff,$ff,$00,$00,$00
        .byte $01,$00,$00,$01,$08,$7f,$ff,$ff,$00,$a7,$03,$ff,$ff,$00,$00,$00
        .byte $01,$00,$00,$01,$08,$7f,$ff,$ff,$00,$a7,$03,$ff,$ff,$00,$00,$00
        .byte $01,$00,$00,$01,$08,$7f,$ff,$ff,$00,$a7,$03,$ff,$ff,$00,$00,$00
        .byte $01,$00,$00,$01,$08,$7f,$ff,$ff,$00,$a7,$03,$ff,$ff,$00,$00,$00
        .byte $01,$00,$00,$01,$08,$7f,$ff,$ff,$00,$a7,$03,$ff,$ff,$00,$00,$00
        .byte $01,$00,$00,$01,$08,$7f,$ff,$ff,$00,$a7,$03,$ff,$ff,$00,$00,$00
        .byte $01,$00,$00,$01,$08,$97,$ff,$3f,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $01,$00,$00,$08,$08,$97,$ff,$3f,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $01,$00,$00,$08,$08,$97,$ff,$3f,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $01,$00,$00,$08,$08,$97,$ff,$3f,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $01,$00,$00,$08,$08,$97,$ff,$3f,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $01,$00,$00,$08,$08,$97,$ff,$3f,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $01,$00,$00,$08,$08,$97,$ff,$3f,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $01,$00,$00,$08,$08,$97,$ff,$3f,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $01,$00,$00,$08,$08,$97,$ff,$3f,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $01,$00,$00,$08,$08,$97,$ff,$3f,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $01,$00,$00,$08,$08,$97,$ff,$3f,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $01,$00,$00,$08,$08,$97,$ff,$3f,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $01,$00,$00,$08,$08,$97,$ff,$3f,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $01,$00,$00,$08,$08,$97,$ff,$3f,$00,$ff,$ff,$ff,$ff,$00,$00,$00
        .byte $01,$00

    L_dddd:
        .byte $00
        .byte $08,$08,$97,$ff,$3f,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$01,$00,$00
        .byte $08,$08,$97,$ff,$3f,$00,$ff,$ff,$ff,$ff,$00,$00,$00,$01,$00,$00
        .byte $08,$08

    L_de00:
        .fill $200, $ff

    L_e000:
        sta $56
        jsr L_bc0f
        lda $61
    L_e007:
        cmp #$88
    L_e009:
        bcc L_e00e
    L_e00b:
        jsr L_bad4
    L_e00e:
        jsr L_bccc
        lda $07
        clc 
        adc #$81
        beq L_e00b
        sec 
        sbc #$01
        pha 
        ldx #$05
    L_e01e:
        lda $69,x
        ldy $61,x
        sta $61,x
        sty $69,x
        dex 
        bpl L_e01e
        lda $56
        sta $70
        jsr L_b853
        jsr L_bfb4
        lda #$c4
        ldy #$bf
        jsr L_e059
        lda #$00
        sta $6f
        pla 
        jsr L_bab7 + $2
        rts 


    L_e043:
        sta $71
        sty $72
        jsr $bbca
        lda #$57
        jsr L_ba28
        jsr L_e05d
        lda #$57
        ldy #$00
        jmp L_ba28
    L_e059:
        sta $71
        sty $72
    L_e05d:
        jsr L_bbc7
        lda ($71),y
        sta $67
        ldy $71
        iny 
        tya 
        bne L_e06c
        inc $72
    L_e06c:
        sta $71
        ldy $72
    L_e070:
        jsr L_ba28
        lda $71
        ldy $72
        clc 
        adc #$05
        bcc L_e07d
        iny 
    L_e07d:
        sta $71
        sty $72
        jsr L_b867
        lda #$5c
        ldy #$00
        dec $67
        bne L_e070
        rts 



        .byte $98,$35,$44,$7a,$00,$68,$28,$b1,$46,$00,$20,$2b,$bc,$30,$37,$d0
        .byte $20,$20,$f3,$ff,$86,$22,$84,$23,$a0,$04,$b1,$22,$85,$62,$c8,$b1
        .byte $22,$85,$64,$a0,$08,$b1,$22,$85,$63,$c8,$b1,$22,$85,$65,$4c,$e3
        .byte $e0

    L_e0be:
        lda #$8b
        ldy #$00
        jsr L_bba2
        lda #$8d
        ldy #$e0
        jsr L_ba28
        lda #$92
        ldy #$e0
        jsr L_b867
    L_e0d3:
        ldx $65
        lda $62
        sta $65
        stx $62
        ldx $63
        lda $64
        sta $63
        stx $64
    L_e0e3:
        lda #$00
        sta $66
        lda $61
        sta $70
        lda #$80
        sta $61
        jsr L_b8d7
        ldx #$8b
        ldy #$00
    L_e0f6:
        jmp L_bbd4
    L_e0f9:
        cmp #$f0
        bne L_e104
        sty $38
        stx $37
        jmp L_a663
    L_e104:
        tax 
        bne L_e109
        ldx #$1e
    L_e109:
        jmp L_a437
    L_e10c:
        jsr L_ffd2
        bcs L_e0f9
        rts 


    L_e112:
        jsr L_ffcf
        bcs L_e0f9
        rts 


    L_e118:
        jsr $e4ad
        bcs L_e0f9
        rts 


    L_e11e:
        jsr L_ffc6
        bcs L_e0f9
        rts 


    L_e124:
        jsr L_ffe4
        bcs L_e0f9
        rts 


        jsr L_ad8a
        jsr L_b7f7
        lda #$e1
        pha 
        lda #$46
        pha 
        lda $030f
        pha 
        lda $030c
        ldx $030d
        ldy $030e
        plp 

        .byte $6c,$14,$00,$08,$8d,$0c,$03,$8e,$0d,$03,$8c,$0e,$03,$68,$8d,$0f
        .byte $03,$60,$20,$d4,$e1,$a6,$2d,$a4,$2e,$a9,$2b,$20,$d8,$ff,$b0,$95
        .byte $60,$a9,$01,$2c,$a9,$00,$85,$0a,$20,$d4,$e1,$a5,$0a,$a6,$2b,$a4
        .byte $2c,$20,$d5,$ff,$b0,$57,$a5,$0a,$f0,$17,$a2,$1c,$20,$b7,$ff,$29
        .byte $10,$d0,$17,$a5,$7a,$c9,$02,$f0,$07,$a9,$64,$a0,$a3,$4c,$1e,$ab

    L_e194:
        rts 


    L_e195:
        jsr L_ffb7
        and #$bf
        beq L_e1a1
        ldx #$1d
    L_e19e:
        jmp L_a437
    L_e1a1:
        lda $7b
        cmp #$02
        bne L_e1b5
        stx $2d
        sty $2e
        lda #$76
        ldy #$a3
        jsr L_ab1e
        jmp L_a52a
    L_e1b5:
        jsr L_a68e
        jsr L_a533
        jmp L_a677
        jsr L_e219
        jsr L_ffc0
        bcs L_e1d1
        rts 


        jsr L_e219
        lda $49
        jsr L_ffc3
        bcc L_e194
    L_e1d1:
        jmp L_e0f9
    L_e1d4:
        lda #$00
        jsr L_ffbd
        ldx #$01
        ldy #$00
        jsr L_ffba
        jsr L_e206
        jsr L_e257
        jsr L_e206
        jsr L_e200
        ldy #$00
        stx $49
        jsr L_ffba
        jsr L_e206
        jsr L_e200
        txa 
        tay 
        ldx $49
        jmp L_ffba
    L_e200:
        jsr L_e20e
        jmp L_b79e
    L_e206:
        jsr.a $0079
        bne L_e20d
        pla 
        pla 
    L_e20d:
        rts 


    L_e20e:
        jsr $aefd
    L_e211:
        jsr.a $0079
        bne L_e20d
        jmp L_af08
    L_e219:
        lda #$00
        jsr L_ffbd
        jsr L_e211
        jsr L_b79e
        stx $49
        txa 
        ldx #$01
        ldy #$00
        jsr L_ffba
        jsr L_e206
        jsr L_e200
        stx $4a
        ldy #$00
        lda $49
        cpx #$03
        bcc L_e23f
        dey 
    L_e23f:
        jsr L_ffba
        jsr L_e206
        jsr L_e200
        txa 
        tay 
        ldx $4a
        lda $49
        jsr L_ffba
        jsr L_e206
        jsr L_e20e
    L_e257:
        jsr L_ad9e
        jsr L_b6a3
        ldx $22
        ldy $23
        jmp L_ffbd
        lda #$e0
        ldy #$e2
        jsr L_b867
    L_e26b:
        jsr L_bc0c
        lda #$e5
        ldy #$e2
        ldx $6e
        jsr L_bb07
        jsr L_bc0c
        jsr L_bccc
        lda #$00
        sta $6f
        jsr L_b853
        lda #$ea
        ldy #$e2
        jsr L_b850
        lda $66
        pha 
        bpl L_e29d
        jsr L_b849
        lda $66
        bmi L_e2a0
        lda $12
        eor #$ff
        sta $12
    L_e29d:
        jsr L_bfb4
    L_e2a0:
        lda #$ea
        ldy #$e2
        jsr L_b867
        pla 
        bpl L_e2ad
        jsr L_bfb4
    L_e2ad:
        lda #$ef
        ldy #$e2
        jmp L_e043
        jsr $bbca
        lda #$00
        sta $12
        jsr L_e26b
        ldx #$4e
        ldy #$00
        jsr L_e0f6
        lda #$57
        ldy #$00
        jsr L_bba2
        lda #$00
        sta $66
        lda $12
        jsr L_e2dc
        lda #$4e
        ldy #$00
        jmp L_bb0f
    L_e2dc:
        pha 
        jmp L_e29d

        .byte $81,$49,$0f,$da,$a2,$83,$49,$0f,$da,$a2,$7f,$00,$00,$00,$00,$05
        .byte $84,$e6,$1a,$2d,$1b,$86,$28,$07,$fb,$f8,$87,$99,$68,$89,$01,$87
        .byte $23,$35,$df,$e1,$86,$a5,$5d,$e7,$28,$83,$49,$0f,$da,$a2,$a5,$66
        .byte $48,$10,$03,$20,$b4,$bf

    L_e316:
        lda $61
        pha 
        cmp #$81
        bcc L_e324
        lda #$bc
        ldy #$b9
        jsr L_bb0f
    L_e324:
        lda #$3e
        ldy #$e3
        jsr L_e043
        pla 
        cmp #$81
        bcc L_e337
        lda #$e0
        ldy #$e2
        jsr L_b850
    L_e337:
        pla 
        bpl L_e33d
        jmp L_bfb4
    L_e33d:
        rts 



        .byte $0b,$76,$b3,$83,$bd,$d3,$79,$1e,$f4,$a6,$f5,$7b,$83,$fc,$b0,$10
        .byte $7c,$0c,$1f,$67,$ca,$7c,$de,$53,$cb,$c1,$7d,$14,$64,$70,$4c,$7d
        .byte $b7,$ea,$51,$7a,$7d,$63,$30,$88,$7e,$7e,$92,$44,$99,$3a,$7e,$4c
        .byte $cc,$91,$c7,$7f,$aa,$aa,$aa,$13,$81,$00,$00,$00,$00,$20,$cc,$ff
        .byte $a9,$00,$85,$13,$20,$7a,$a6,$58

    L_e386:
        ldx #$80
        jmp ($0300)
        txa 
        bmi L_e391
        jmp L_a43a
    L_e391:
        jmp L_a474
        jsr L_e453
        jsr L_e3bf
        jsr L_e422
        ldx #$fb
        txs 
        bne L_e386
    L_e3a2:
        inc $7a
        bne L_e3a8
        inc $7b
    L_e3a8:
        lda $ea60
        cmp #$3a
        bcs L_e3b9
        cmp #$20
        beq L_e3a2
        sec 
        sbc #$30
        sec 
        sbc #$d0
    L_e3b9:
        rts 



        .byte $80,$4f,$c7,$52,$58

    L_e3bf:
        lda #$4c
        sta $54
        sta $0310
        lda #$48
        ldy #$b2
        sta $0311
        sty $0312
        lda #$91
        ldy #$b3
        sta $05
        sty $06
        lda #$aa
        ldy #$b1
        sta $03
        sty $04
        ldx #$1c
    L_e3e2:
        lda L_e3a2,x
        sta $73,x
        dex 
        bpl L_e3e2
        lda #$03
        sta $53
        lda #$00
        sta $68
        sta $13
        sta $18
        ldx #$01
        stx $01fd
        stx $01fc
        ldx #$19
        stx $16
        sec 
        jsr L_ff9c
        stx $2b
        sty $2c
        sec 
        jsr L_ff99
        stx $37
        sty $38
        stx $33
        sty $34
        ldy #$00
        tya 
        sta ($2b),y
        inc $2b
        bne L_e421
        inc $2c
    L_e421:
        rts 


    L_e422:
        lda $2b
        ldy $2c
        jsr L_a408
        lda #$73
        ldy #$e4
        jsr L_ab1e
        lda $37
        sec 
        sbc $2b
        tax 
        lda $38
        sbc $2c
        jsr L_bdcd
        lda #$60
        ldy #$e4
        jsr L_ab1e
        jmp L_a644

    L_e447:
         .byte $8b,$e3,$83
        .byte $a4,$7c,$a5,$1a,$a7,$e4,$a7,$86,$ae

    L_e453:
        ldx #$0b
    L_e455:
        lda L_e447,x
        sta $0300,x
        dex 
        bpl L_e455
        rts 



        .byte $00,$20,$42,$41,$53,$49,$43,$20,$42,$59,$54,$45,$53,$20,$46,$52
        .byte $45,$45,$0d,$00,$93,$0d,$20,$20,$20,$20,$2a,$2a,$2a,$2a,$20,$43
        .byte $4f,$4d,$4d,$4f,$44,$4f,$52,$45,$20,$36,$34,$20,$42,$41,$53,$49
        .byte $43,$20,$56,$32,$20,$2a,$2a,$2a,$2a,$0d,$0d,$20,$36,$34,$4b,$20
        .byte $52,$41,$4d,$20,$53,$59,$53,$54,$45,$4d,$20,$20,$00,$81,$48,$20
        .byte $c9,$ff,$aa,$68,$90,$01,$8a

    L_e4b6:
        rts 


        tax 
        tax 
        tax 
        tax 
        tax 
        tax 
        tax 
        tax 
        tax 
        tax 
        tax 
        tax 
        tax 
        tax 
        tax 
        tax 
        tax 
        tax 
        tax 
        tax 
        tax 
        tax 
        tax 
        tax 
        tax 
        tax 
        tax 
        tax 
    L_e4d3:
        sta $a9
        lda #$01
        sta $ab
        rts 


    L_e4da:
        lda $0286
        sta ($f3),y
        rts 


    L_e4e0:
        adc #$02
    L_e4e2:
        ldy $91
        iny 
        bne L_e4eb
        cmp $a1
        bne L_e4e2
    L_e4eb:
        rts 



        .byte $19,$26,$44,$19,$1a,$11,$e8,$0d,$70,$0c,$06,$06,$d1,$02,$37,$01
        .byte $ae,$00,$69,$00

    L_e500:
        ldx #$00
        ldy #$dc
        rts 


    L_e505:
        ldx #$28
        ldy #$19
        rts 


    L_e50a:
        bcs L_e513
        stx $d6
        sty $d3
        jsr L_e56c
    L_e513:
        ldx $d6
        ldy $d3
        rts 


    L_e518:
        jsr L_e5a0
        lda #$00
        sta $0291
        sta $cf
        lda #$48
        sta $028f
        lda #$eb
        sta $0290
        lda #$0a
        sta $0289
        sta $028c
        lda #$0e
        sta $0286
        lda #$04
        sta $028b
        lda #$0c
        sta $cd
        sta $cc
    L_e544:
        lda $0288
        ora #$80
        tay 
        lda #$00
        tax 
    L_e54d:
        sty $d9,x
        clc 
        adc #$28
        bcc L_e555
        iny 
    L_e555:
        inx 
        cpx #$1a
        bne L_e54d
        lda #$ff
        sta $d9,x
        ldx #$18
    L_e560:
        jsr L_e9ff
        dex 
        bpl L_e560
    L_e566:
        ldy #$00
        sty $d3
        sty $d6
    L_e56c:
        ldx $d6
        lda $d3
    L_e570:
        ldy $d9,x
        bmi L_e57c
        clc 
        adc #$28
        sta $d3
        dex 
        bpl L_e570
    L_e57c:
        jsr L_e9f0
        lda #$27
        inx 
    L_e582:
        ldy $d9,x
        bmi L_e58c
        clc 
        adc #$28
        inx 
        bpl L_e582
    L_e58c:
        sta $d5
        jmp L_ea24
    L_e591:
        cpx $c9
        beq L_e598
        jmp L_e6ed
    L_e598:
        rts 


        nop 
        jsr L_e5a0
        jmp L_e566
    L_e5a0:
        lda #$03
        sta $9a
        lda #$00
        sta $99
        ldx #$2f
    L_e5aa:
        lda L_ecb8,x
        sta L_cff4 + $b,x
        dex 
        bne L_e5aa
        rts 


    L_e5b4:
        ldy $0277
        ldx #$00
    L_e5b9:
        lda $0278,x
        sta $0277,x
        inx 
        cpx $c6
        bne L_e5b9
        dec $c6
        tya 
        cli 
        clc 
        rts 


    L_e5ca:
        jsr L_e716
    L_e5cd:
        lda $c6
        sta $cc
        sta $0292
        beq L_e5cd
        sei 
        lda $cf
        beq L_e5e7
        lda $ce
        ldx $0287
        ldy #$00
        sty $cf
        jsr L_ea13
    L_e5e7:
        jsr L_e5b4
        cmp #$83
        bne L_e5fe
        ldx #$09
        sei 
        stx $c6
    L_e5f3:
        lda L_ece6,x
        sta $0276,x
        dex 
        bne L_e5f3
        beq L_e5cd
    L_e5fe:
        cmp #$0d
        bne L_e5ca
        ldy $d5
        sty $d0
    L_e606:
        lda ($d1),y
        cmp #$20
        bne L_e60f
        dey 
        bne L_e606
    L_e60f:
        iny 
        sty $c8
        ldy #$00
        sty $0292
        sty $d3
        sty $d4
        lda $c9
        bmi L_e63a
        ldx $d6
        jsr L_e591
        cpx $c9
        bne L_e63a
        lda $ca
        sta $d3
        cmp $c8
        bcc L_e63a
        bcs L_e65d
    L_e632:
        tya 
        pha 
        txa 
        pha 
        lda $d0
        beq L_e5cd
    L_e63a:
        ldy $d3
        lda ($d1),y
        sta $d7
        and #$3f
        asl $d7
        bit $d7
        bpl L_e64a
        ora #$80
    L_e64a:
        bcc L_e650
        ldx $d4
        bne L_e654
    L_e650:
        bvs L_e654
        ora #$40
    L_e654:
        inc $d3
        jsr L_e684
        cpy $c8
        bne L_e674
    L_e65d:
        lda #$00
        sta $d0
        lda #$0d
        ldx $99
        cpx #$03
        beq L_e66f
        ldx $9a
        cpx #$03
        beq L_e672
    L_e66f:
        jsr L_e716
    L_e672:
        lda #$0d
    L_e674:
        sta $d7
        pla 
        tax 
        pla 
        tay 
        lda $d7
        cmp #$de
        bne L_e682
        lda #$ff
    L_e682:
        clc 
        rts 


    L_e684:
        cmp #$22
        bne L_e690
        lda $d4
        eor #$01
        sta $d4
        lda #$22
    L_e690:
        rts 


    L_e691:
        ora #$40
    L_e693:
        ldx $c7
        beq L_e699
    L_e697:
        ora #$80
    L_e699:
        ldx $d8
        beq L_e69f
        dec $d8
    L_e69f:
        ldx $0286
        jsr L_ea13
        jsr L_e6b6
    L_e6a8:
        pla 
        tay 
        lda $d8
        beq L_e6b0
        lsr $d4
    L_e6b0:
        pla 
        tax 
        pla 
        clc 
        cli 
        rts 


    L_e6b6:
        jsr L_e8b3
        inc $d3
        lda $d5
        cmp $d3
        bcs L_e700
        cmp #$4f
        beq L_e6f7
        lda $0292
    L_e6c8:
        beq L_e6cd
        jmp L_e967
    L_e6cd:
        ldx $d6
        cpx #$19
        bcc L_e6da
        jsr L_e8ea
        dec $d6
        ldx $d6
    L_e6da:
        asl $d9,x
        lsr $d9,x
        inx 
        lda $d9,x
        ora #$80
        sta $d9,x
        dex 
        lda $d5
        clc 
        adc #$28
        sta $d5
    L_e6ed:
        lda $d9,x
        bmi L_e6f4
        dex 
        bne L_e6ed
    L_e6f4:
        jmp L_e9f0
    L_e6f7:
        dec $d6
        jsr L_e87c
        lda #$00
        sta $d3
    L_e700:
        rts 


    L_e701:
        ldx $d6
        bne L_e70b
        stx $d3
        pla 
        pla 
        bne L_e6a8
    L_e70b:
        dex 
        stx $d6
        jsr L_e56c
        ldy $d5
        sty $d3
        rts 


    L_e716:
        pha 
        sta $d7
        txa 
        pha 
        tya 
        pha 
        lda #$00
        sta $d0
        ldy $d3
        lda $d7
        bpl L_e72a
        jmp L_e7d4
    L_e72a:
        cmp #$0d
        bne L_e731
        jmp L_e891
    L_e731:
        cmp #$20
        bcc L_e745
        cmp #$60
        bcc L_e73d
        and #$df
        bne L_e73f
    L_e73d:
        and #$3f
    L_e73f:
        jsr L_e684
        jmp L_e693
    L_e745:
        ldx $d8
        beq L_e74c
        jmp L_e697
    L_e74c:
        cmp #$14
        bne L_e77e
        tya 
        bne L_e759
        jsr L_e701
        jmp L_e773
    L_e759:
        jsr L_e8a1
        dey 
        sty $d3
        jsr L_ea24
    L_e762:
        iny 
        lda ($d1),y
        dey 
        sta ($d1),y
        iny 
        lda ($f3),y
        dey 
        sta ($f3),y
        iny 
        cpy $d5
        bne L_e762
    L_e773:
        lda #$20
        sta ($d1),y
        lda $0286
        sta ($f3),y
        bpl L_e7cb
    L_e77e:
        ldx $d4
        beq L_e785
        jmp L_e697
    L_e785:
        cmp #$12
        bne L_e78b
        sta $c7
    L_e78b:
        cmp #$13
        bne L_e792
        jsr L_e566
    L_e792:
        cmp #$1d
        bne L_e7ad
        iny 
        jsr L_e8b3
        sty $d3
        dey 
        cpy $d5
        bcc L_e7aa
        dec $d6
        jsr L_e87c
        ldy #$00
    L_e7a8:
        sty $d3
    L_e7aa:
        jmp L_e6a8
    L_e7ad:
        cmp #$11
        bne L_e7ce
        clc 
        tya 
        adc #$28
        tay 
        inc $d6
        cmp $d5
        bcc L_e7a8
        beq L_e7a8
        dec $d6
    L_e7c0:
        sbc #$28
        bcc L_e7c8
        sta $d3
        bne L_e7c0
    L_e7c8:
        jsr L_e87c
    L_e7cb:
        jmp L_e6a8
    L_e7ce:
        jsr L_e8cb
        jmp L_ec44
    L_e7d4:
        and #$7f
        cmp #$7f
        bne L_e7dc
        lda #$5e
    L_e7dc:
        cmp #$20
        bcc L_e7e3
        jmp L_e691
    L_e7e3:
        cmp #$0d
        bne L_e7ea
        jmp L_e891
    L_e7ea:
        ldx $d4
        bne L_e82d
        cmp #$14
        bne L_e829
        ldy $d5
        lda ($d1),y
        cmp #$20
        bne L_e7fe
        cpy $d3
        bne L_e805
    L_e7fe:
        cpy #$4f
    L_e800:
        beq L_e826
        jsr L_e965
    L_e805:
        ldy $d5
        jsr L_ea24
    L_e80a:
        dey 
        lda ($d1),y
        iny 
        sta ($d1),y
        dey 
        lda ($f3),y
        iny 
        sta ($f3),y
        dey 
        cpy $d3
        bne L_e80a
        lda #$20
        sta ($d1),y
        lda $0286
        sta ($f3),y
        inc $d8
    L_e826:
        jmp L_e6a8
    L_e829:
        ldx $d8
        beq L_e832
    L_e82d:
        ora #$40
        jmp L_e697
    L_e832:
        cmp #$11
        bne L_e84c
        ldx $d6
        beq L_e871
        dec $d6
        lda $d3
        sec 
        sbc #$28
        bcc L_e847
        sta $d3
        bpl L_e871
    L_e847:
        jsr L_e56c
        bne L_e871
    L_e84c:
        cmp #$12
        bne L_e854
        lda #$00
        sta $c7
    L_e854:
        cmp #$1d
        bne L_e86a
        tya 
        beq L_e864
        jsr L_e8a1
        dey 
        sty $d3
        jmp L_e6a8
    L_e864:
        jsr L_e701
        jmp L_e6a8
    L_e86a:
        cmp #$13
        bne L_e874
        jsr L_e544
    L_e871:
        jmp L_e6a8
    L_e874:
        ora #$80
        jsr L_e8cb
        jmp L_ec4f
    L_e87c:
        lsr $c9
        ldx $d6
    L_e880:
        inx 
        cpx #$19
        bne L_e888
        jsr L_e8ea
    L_e888:
        lda $d9,x
        bpl L_e880
        stx $d6
        jmp L_e56c
    L_e891:
        ldx #$00
        stx $d8
        stx $c7
        stx $d4
        stx $d3
        jsr L_e87c
        jmp L_e6a8
    L_e8a1:
        ldx #$02
        lda #$00
    L_e8a5:
        cmp $d3
        beq L_e8b0
        clc 
        adc #$28
        dex 
        bne L_e8a5
        rts 


    L_e8b0:
        dec $d6
        rts 


    L_e8b3:
        ldx #$02
        lda #$27
    L_e8b7:
        cmp $d3
        beq L_e8c2
        clc 
        adc #$28
        dex 
        bne L_e8b7
        rts 


    L_e8c2:
        ldx $d6
        cpx #$19
        beq L_e8ca
        inc $d6
    L_e8ca:
        rts 


    L_e8cb:
        ldx #$0f
    L_e8cd:
        cmp L_e8da,x
        beq L_e8d6
        dex 
        bpl L_e8cd
        rts 


    L_e8d6:
        stx $0286
        rts 



    L_e8da:
         .byte $90,$05,$1c,$9f,$9c
        .byte $1e,$1f,$9e,$81,$95,$96,$97,$98,$99,$9a,$9b

    L_e8ea:
        lda $ac
        pha 
        lda $ad
        pha 
        lda $ae
        pha 
        lda $af
        pha 
    L_e8f6:
        ldx #$ff
        dec $d6
        dec $c9
        dec $02a5
    L_e8ff:
        inx 
        jsr L_e9f0
        cpx #$18
        bcs L_e913
        lda L_ecf1,x
        sta $ac
        lda $da,x
        jsr L_e9c8
        bmi L_e8ff
    L_e913:
        jsr L_e9ff
        ldx #$00
    L_e918:
        lda $d9,x
        and #$7f
        ldy $da,x
        bpl L_e922
        ora #$80
    L_e922:
        sta $d9,x
        inx 
        cpx #$18
        bne L_e918
        lda $f1
        ora #$80
        sta $f1
        lda $d9
        bpl L_e8f6
        inc $d6
        inc $02a5
        lda #$7f
        sta cCia1PortA
        lda cCia1PortB
        cmp #$fb
        php 
        lda #$7f
        sta cCia1PortA
        plp 
        bne L_e956
        ldy #$00
    L_e94d:
        nop 
        dex 
        bne L_e94d
        dey 
        bne L_e94d
        sty $c6
    L_e956:
        ldx $d6
    L_e958:
        pla 
        sta $af
        pla 
        sta $ae
        pla 
        sta $ad
        pla 
        sta $ac
        rts 


    L_e965:
        ldx $d6
    L_e967:
        inx 
        lda $d9,x
        bpl L_e967
        stx $02a5
        cpx #$18
        beq L_e981
        bcc L_e981
        jsr L_e8ea
        ldx $02a5
        dex 
        dec $d6
        jmp L_e6da
    L_e981:
        lda $ac
        pha 
        lda $ad
        pha 
        lda $ae
        pha 
        lda $af
        pha 
        ldx #$19
    L_e98f:
        dex 
        jsr L_e9f0
        cpx $02a5
        bcc L_e9a6
        beq L_e9a6
        lda $ecef,x
        sta $ac
        lda $d8,x
        jsr L_e9c8
        bmi L_e98f
    L_e9a6:
        jsr L_e9ff
        ldx #$17
    L_e9ab:
        cpx $02a5
        bcc L_e9bf
        lda $da,x
        and #$7f
        ldy $d9,x
        bpl L_e9ba
        ora #$80
    L_e9ba:
        sta $da,x
        dex 
        bne L_e9ab
    L_e9bf:
        ldx $02a5
        jsr L_e6da
        jmp L_e958
    L_e9c8:
        and #$03
        ora $0288
        sta $ad
        jsr L_e9e0
        ldy #$27
    L_e9d4:
        lda ($ac),y
        sta ($d1),y
        lda ($ae),y
        sta ($f3),y
        dey 
        bpl L_e9d4
        rts 


    L_e9e0:
        jsr L_ea24
        lda $ac
        sta $ae
        lda $ad
        and #$03
        ora #$d8
        sta $af
        rts 


    L_e9f0:
        lda $ecf0,x
        sta $d1
        lda $d9,x
        and #$03
        ora $0288
        sta $d2
        rts 


    L_e9ff:
        ldy #$27
        jsr L_e9f0
        jsr L_ea24
    L_ea07:
        jsr L_e4da
        lda #$20
        sta ($d1),y
        dey 
        bpl L_ea07
        rts 


        nop 
    L_ea13:
        tay 
        lda #$02
        sta $cd
        jsr L_ea24
        tya 
    L_ea1c:
        ldy $d3
        sta ($d1),y
        txa 
        sta ($f3),y
        rts 


    L_ea24:
        lda $d1
        sta $f3
        lda $d2
        and #$03
        ora #$d8
        sta $f4
        rts 


        jsr L_ffea
        lda $cc
        bne L_ea61
        dec $cd
        bne L_ea61
        lda #$14
        sta $cd
        ldy $d3
        lsr $cf
        ldx $0287
        lda ($d1),y
        bcs L_ea5c
        inc $cf
        sta $ce
        jsr L_ea24
        lda ($f3),y
        sta $0287
        ldx $0286
        lda $ce
    L_ea5c:
        eor #$80
        jsr L_ea1c
    L_ea61:
        lda $01
        and #$10
        beq L_ea71
        ldy #$00
        sty $c0
        lda $01
        ora #$20
        bne L_ea79
    L_ea71:
        lda $c0
        bne L_ea7b
        lda $01
        and #$1f
    L_ea79:
        sta $01
    L_ea7b:
        jsr L_ea87
        lda cCia1IntControl
        pla 
        tay 
        pla 
        tax 
        pla 
        rti 
    L_ea87:
        lda #$00
        sta $028d
        ldy #$40
        sty $cb
        sta cCia1PortA
        ldx cCia1PortB
        cpx #$ff
        beq L_eafb
        tay 
        lda #$81
        sta $f5
        lda #$eb
        sta $f6
        lda #$fe
        sta cCia1PortA
    L_eaa8:
        ldx #$08
        pha 
    L_eaab:
        lda cCia1PortB
        cmp cCia1PortB
        bne L_eaab
    L_eab3:
        lsr 
        bcs L_eacc
        pha 
    L_eab7:
        lda ($f5),y
        cmp #$05
        bcs L_eac9
        cmp #$03
        beq L_eac9
        ora $028d
        sta $028d
        bpl L_eacb
    L_eac9:
        sty $cb
    L_eacb:
        pla 
    L_eacc:
        iny 
        cpy #$41
        bcs L_eadc
        dex 
        bne L_eab3
        sec 
        pla 
        rol 
        sta cCia1PortA
        bne L_eaa8
    L_eadc:
        pla 
        jmp ($028f)
    L_eae0:
        ldy $cb
        lda ($f5),y
        tax 
        cpy $c5
        beq L_eaf0
        ldy #$10
        sty $028c
        bne L_eb26
    L_eaf0:
        and #$7f
        bit $028a
        bmi L_eb0d
        bvs L_eb42
        cmp #$7f
    L_eafb:
        beq L_eb26
        cmp #$14
        beq L_eb0d
        cmp #$20
        beq L_eb0d
        cmp #$1d
        beq L_eb0d
        cmp #$11
        bne L_eb42
    L_eb0d:
        ldy $028c
        beq L_eb17
        dec $028c
        bne L_eb42
    L_eb17:
        dec $028b
        bne L_eb42
        ldy #$04
        sty $028b
        ldy $c6
        dey 
        bpl L_eb42
    L_eb26:
        ldy $cb
        sty $c5
        ldy $028d
        sty $028e
        cpx #$ff
        beq L_eb42
        txa 
        ldx $c6
        cpx $0289
        bcs L_eb42
        sta $0277,x
        inx 
        stx $c6
    L_eb42:
        lda #$7f
        sta cCia1PortA
        rts 


        lda $028d
        cmp #$03
        bne L_eb64
        cmp $028e
        beq L_eb42
        lda $0291
        bmi L_eb76
        lda vMemControl
        eor #$02
        sta vMemControl
        jmp L_eb76
    L_eb64:
        asl 
        cmp #$08
        bcc L_eb6b
        lda #$06
    L_eb6b:
        tax 
        lda L_eb79,x
        sta $f5
        lda L_eb79 + $1,x
        sta $f6
    L_eb76:
        jmp L_eae0

    L_eb79:
         .byte $81,$eb,$c2,$eb,$03
        .byte $ec,$78,$ec,$14,$0d,$1d,$88,$85,$86,$87,$11,$33,$57,$41,$34,$5a
        .byte $53,$45,$01,$35,$52,$44,$36,$43,$46,$54,$58,$37,$59,$47,$38,$42
        .byte $48,$55,$56,$39,$49,$4a,$30,$4d,$4b,$4f,$4e,$2b,$50,$4c,$2d,$2e
        .byte $3a,$40,$2c,$5c,$2a,$3b,$13,$01,$3d,$5e,$2f,$31,$5f,$04,$32,$20
        .byte $02,$51,$03,$ff,$94,$8d,$9d,$8c,$89,$8a,$8b,$91,$23,$d7,$c1,$24
        .byte $da,$d3,$c5,$01,$25,$d2,$c4,$26,$c3,$c6,$d4,$d8,$27,$d9,$c7,$28
        .byte $c2,$c8,$d5,$d6,$29,$c9,$ca,$30,$cd,$cb,$cf,$ce,$db,$d0,$cc,$dd
        .byte $3e,$5b,$ba,$3c,$a9,$c0,$5d,$93,$01,$3d,$de,$3f,$21,$5f,$04,$22
        .byte $a0,$02,$d1,$83,$ff,$94,$8d,$9d,$8c,$89,$8a,$8b,$91,$96,$b3,$b0
        .byte $97,$ad,$ae,$b1,$01,$98,$b2,$ac,$99,$bc,$bb,$a3,$bd,$9a,$b7,$a5
        .byte $9b,$bf,$b4,$b8,$be,$29,$a2,$b5,$30,$a7,$a1,$b9,$aa,$a6,$af,$b6
        .byte $dc,$3e,$5b,$a4,$3c,$a8,$df,$5d,$93,$01,$3d,$de,$3f,$81,$5f,$04
        .byte $95,$a0,$02,$ab,$83,$ff

    L_ec44:
        cmp #$0e
        bne L_ec4f
        lda vMemControl
        ora #$02
        bne L_ec58
    L_ec4f:
        cmp #$8e
        bne L_ec5e
        lda vMemControl
        and #$fd
    L_ec58:
        sta vMemControl
    L_ec5b:
        jmp L_e6a8
    L_ec5e:
        cmp #$08
        bne L_ec69
        lda #$80
        ora $0291
        bmi L_ec72
    L_ec69:
        cmp #$09
        bne L_ec5b
        lda #$7f
        and $0291
    L_ec72:
        sta $0291
        jmp L_e6a8

    L_ec78:
         .byte $ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$1c,$17
        .byte $01,$9f,$1a,$13,$05,$ff,$9c,$12,$04,$1e,$03,$06,$14,$18,$1f,$19
        .byte $07,$9e,$02,$08,$15,$16,$12,$09,$0a,$92,$0d,$0b,$0f,$0e,$ff,$10
        .byte $0c,$ff,$ff,$1b,$00,$ff,$1c,$ff,$1d,$ff,$ff,$1f,$1e,$ff,$90,$06
        .byte $ff,$05,$ff,$ff,$11,$ff

    L_ecb8:
        .byte $ff
        .fill $11, $0
        .byte $9b,$37,$00,$00,$00,$08,$00,$14,$0f,$00,$00,$00,$00,$00,$00,$0e
        .byte $06,$01,$02,$03,$04,$00,$01,$02,$03,$04,$05,$06

    L_ece6:
        .byte $07
        .byte $4c,$4f,$41,$44,$0d,$52,$55,$4e,$0d,$00

    L_ecf1:
        plp 
        bvc L_ed62 + $a
        ldy #$c8

        .byte $f0,$18,$40,$68,$90,$b8

    L_ecfc:
        cpx #$08
        bmi L_ed58

        .byte $80,$a8,$d0,$f8,$20,$48,$70,$98,$c0,$09,$40,$2c,$09,$20,$20,$a4
        .byte $f0

    L_ed11:
        pha 
        bit $94
        bpl L_ed20
        sec 
        ror $a3
        jsr L_ed40
        lsr $94
        lsr $a3
    L_ed20:
        pla 
        sta $95
        sei 
        jsr L_ee97
        cmp #$3f
        bne L_ed2e
        jsr L_ee85
    L_ed2e:
        lda cCia2PortA
        ora #$08
        sta cCia2PortA
    L_ed36:
        sei 
        jsr L_ee8e
        jsr L_ee97
        jsr L_eeb3
    L_ed40:
        sei 
        jsr L_ee97
        jsr L_eea9
        bcs L_edad
        jsr L_ee85
        bit $a3
        bpl L_ed5a
    L_ed50:
        jsr L_eea9
        bcc L_ed50
    L_ed55:
        jsr L_eea9
    L_ed58:
        bcs L_ed55
    L_ed5a:
        jsr L_eea9
        bcc L_ed5a
        jsr L_ee8e

    L_ed62:
         .byte $a9,$08,$85,$a5,$ad,$00,$dd,$cd,$00,$dd,$d0,$f8,$0a,$90,$3f
        .byte $66,$95,$b0,$05,$20,$a0,$ee,$d0,$03

    L_ed7a:
        jsr L_ee97
    L_ed7d:
        jsr L_ee85

        .byte $ea,$ea,$ea,$ea,$ad,$00,$dd,$29,$df,$09,$10,$8d,$00,$dd,$c6,$a5

    L_ed90:
        .byte $d0,$d4,$a9,$04,$8d,$07,$dc,$a9,$19,$8d,$0f,$dc,$ad,$0d,$dc,$ad
        .byte $0d,$dc,$29,$02,$d0,$0a,$20,$a9,$ee,$b0,$f4,$58,$60

    L_edad:
        lda #$80
        bit $03a9
    L_edb2:
        jsr L_fe1c
        cli 
        clc 
        bcc L_ee03
    L_edb9:
        sta $95
        jsr L_ed36
    L_edbe:
        lda cCia2PortA
        and #$f7
        sta cCia2PortA
        rts 


    L_edc7:
        sta $95
        jsr L_ed36
    L_edcc:
        sei 
        jsr L_eea0
        jsr L_edbe
        jsr L_ee85
    L_edd6:
        jsr L_eea9
        bmi L_edd6
        cli 
        rts 


    L_eddd:
        bit $94
        bmi L_ede6
        sec 
        ror $94
        bne L_edeb
    L_ede6:
        pha 
        jsr L_ed40
        pla 
    L_edeb:
        sta $95
        clc 
        rts 


    L_edef:
        sei 
        jsr L_ee8e
        lda cCia2PortA
        ora #$08
        sta cCia2PortA
        lda #$5f
        bit L_3fa1 + $8
        jsr L_ed11
    L_ee03:
        jsr L_edbe
    L_ee06:
        txa 
        ldx #$0a
    L_ee09:
        dex 
        bne L_ee09
        tax 
        jsr L_ee85
        jmp L_ee97
    L_ee13:
        sei 
        lda #$00
        sta $a5
        jsr L_ee85
    L_ee1b:
        jsr L_eea9
        bpl L_ee1b
    L_ee20:
        lda #$01
        sta cCia1TimerBHi
        lda #$19
        sta cCia1TimerbControl
        jsr L_ee97
        lda cCia1IntControl
    L_ee30:
        lda cCia1IntControl
        and #$02
        bne L_ee3e
        jsr L_eea9
        bmi L_ee30
        bpl L_ee56
    L_ee3e:
        lda $a5
        beq L_ee47
        lda #$02
        jmp L_edb2
    L_ee47:
        jsr L_eea0
        jsr L_ee85
        lda #$40
        jsr L_fe1c
        inc $a5
        bne L_ee20
    L_ee56:
        lda #$08
        sta $a5
    L_ee5a:
        lda cCia2PortA
        cmp cCia2PortA
        bne L_ee5a
        asl 
        bpl L_ee5a
        ror $a4
    L_ee67:
        lda cCia2PortA
        cmp cCia2PortA
        bne L_ee67
        asl 
        bmi L_ee67
        dec $a5
        bne L_ee5a
        jsr L_eea0
        bit $90
        bvc L_ee80
        jsr L_ee06
    L_ee80:
        lda $a4
        cli 
        clc 
        rts 


    L_ee85:
        lda cCia2PortA
        and #$ef
        sta cCia2PortA
        rts 


    L_ee8e:
        lda cCia2PortA
        ora #$10
        sta cCia2PortA
        rts 


    L_ee97:
        lda cCia2PortA
        and #$df
        sta cCia2PortA
        rts 


    L_eea0:
        lda cCia2PortA
        ora #$20
        sta cCia2PortA
        rts 


    L_eea9:
        lda cCia2PortA
        cmp cCia2PortA
        bne L_eea9
        asl 
        rts 


    L_eeb3:
        txa 
        ldx #$b8
    L_eeb6:
        dex 
        bne L_eeb6
        tax 
        rts 


    L_eebb:
        lda $b4
        beq L_eef7 + $f
        bmi L_eef7 + $9
        lsr $b6
        ldx #$00
        bcc L_eec8
        dex 
    L_eec8:
        txa 
        eor $bd
        sta $bd
        dec $b4
        beq L_eed7
        txa 
        and #$04
        sta $b5
        rts 



    L_eed7:
         .byte $a9,$20,$2c,$94,$02,$f0,$14,$30,$1c,$70,$14,$a5,$bd,$d0,$01,$ca
        .byte $c6,$b4,$ad,$93,$02,$10,$e3,$c6,$b4,$d0,$df,$e6,$b4,$d0,$f0,$a5

    L_eef7:
        .byte $bd,$f0,$ed,$d0,$ea,$70,$e9,$50,$e6,$e6,$b4,$a2,$ff,$d0,$cb,$ad
        .byte $94,$02,$4a,$90,$07,$2c,$01,$dd,$10,$1d,$50,$1e,$a9,$00,$85,$bd
        .byte $85,$b5,$ae,$98,$02,$86,$b4,$ac,$9d,$02,$cc,$9e,$02,$f0,$13,$b1
        .byte $f9,$85,$b6,$ee,$9d,$02,$60,$a9,$40,$2c,$a9,$10,$0d,$97,$02,$8d
        .byte $97,$02

    L_ef39:
        lda #$01
    L_ef3b:
        sta cCia2IntControl
        eor $02a1
        ora #$80
        sta $02a1
        sta cCia2IntControl
        rts 


    L_ef4a:
        ldx #$09
        lda #$20
        bit $0293
        beq L_ef54
        dex 
    L_ef54:
        bvc L_ef58
        dex 
        dex 
    L_ef58:
        rts 


    L_ef59:
        ldx $a9
        bne L_ef90
        dec $a8
        beq L_ef97
        bmi L_ef70
        lda $a7
        eor $ab
        sta $ab
        lsr $a7
        ror $aa
    L_ef6d:
        rts 


    L_ef6e:
        dec $a8
    L_ef70:
        lda $a7
        beq L_efdb
        lda $0293
        asl 
        lda #$01
        adc $a8
        bne L_ef6d
    L_ef7e:
        lda #$90
        sta cCia2IntControl
        ora $02a1
        sta $02a1
        sta $a9
        lda #$02
        jmp L_ef3b
    L_ef90:
        lda $a7
        bne L_ef7e
        jmp L_e4d3

    L_ef97:
         .byte $ac,$9b,$02,$c8,$cc,$9c,$02,$f0,$2a
        .byte $8c,$9b,$02,$88,$a5,$aa,$ae,$98,$02

    L_efa9:
        cpx #$09
        beq L_efb1
        lsr 
        inx 
        bne L_efa9
    L_efb1:
        sta ($f7),y
        lda #$20
        bit $0294
        beq L_ef6e
        bmi L_ef6d
        lda $a7
        eor $ab

        .byte $f0,$03,$70,$a9,$2c,$50,$a6,$a9,$01,$2c,$a9,$04,$2c,$a9,$80,$2c
        .byte $a9,$02,$0d,$97,$02,$8d,$97,$02,$4c,$7e,$ef

    L_efdb:
        .byte $a5,$aa,$d0,$f1,$f0,$ec

    L_efe1:
        sta $9a
        lda $0294
        lsr 
        bcc L_f012
        lda #$02
        bit cCia2PortB
        bpl L_f00d
        bne L_f012
    L_eff2:
        lda $02a1
        and #$02
        bne L_eff2
    L_eff9:
        bit cCia2PortB
        bvs L_eff9
        lda cCia2PortB
        ora #$02
        sta cCia2PortB
    L_f006:
        bit cCia2PortB
        bvs L_f012
        bmi L_f006
    L_f00d:
        lda #$40
        sta $0297
    L_f012:
        clc 
        rts 


    L_f014:
        jsr L_f028
    L_f017:
        ldy $029e
        iny 
        cpy $029d
        beq L_f014
        sty $029e
        dey 
        lda $9e
        sta ($f9),y
    L_f028:
        lda $02a1
        lsr 
        bcs L_f04c
        lda #$10
        sta cCia2TimerAControl
        lda $0299
        sta cCia2TimerALo
        lda $029a
        sta cCia2TimerAHi
        lda #$81
        jsr L_ef3b
        jsr L_eef7 + $f
        lda #$11
        sta cCia2TimerAControl
    L_f04c:
        rts 


    L_f04d:
        sta $99
        lda $0294
        lsr 
        bcc L_f07d
        and #$08
        beq L_f07d
        lda #$02
        bit cCia2PortB
        bpl L_f00d
        beq L_f084
    L_f062:
        lda $02a1
        lsr 
        bcs L_f062
        lda cCia2PortB
        and #$fd
        sta cCia2PortB
    L_f070:
        lda cCia2PortB
        and #$04
        beq L_f070
    L_f077:
        lda #$90
        clc 
        jmp L_ef3b
    L_f07d:
        lda $02a1
        and #$12
        beq L_f077
    L_f084:
        clc 
        rts 


    L_f086:
        lda $0297
        ldy $029c
        cpy $029b
        beq L_f09c
        and #$f7
        sta $0297
        lda ($f7),y
        inc $029c
        rts 


    L_f09c:
        ora #$08
        sta $0297
        lda #$00
        rts 


    L_f0a4:
        pha 
        lda $02a1
        beq L_f0bb
    L_f0aa:
        lda $02a1
        and #$03
        bne L_f0aa
        lda #$10
        sta cCia2IntControl
        lda #$00
        sta $02a1
    L_f0bb:
        pla 
        rts 



    L_f0bd:
         .byte $0d,$49,$2f,$4f
        .byte $20,$45,$52,$52,$4f,$52,$20,$a3,$0d,$53,$45,$41,$52,$43,$48,$49
        .byte $4e,$47,$a0,$46,$4f,$52,$a0,$0d,$50,$52,$45,$53,$53,$20,$50,$4c
        .byte $41,$59,$20,$4f,$4e,$20,$54,$41,$50,$c5,$50,$52,$45,$53

    L_f0ef:
        .byte $53

    L_f0f0:
        jsr L_4552

        .byte $43,$4f,$52,$44,$20,$26,$20,$50,$4c,$41,$59,$20,$4f,$4e,$20,$54
        .byte $41,$50,$c5,$0d,$4c,$4f,$41,$44,$49,$4e,$c7,$0d,$53,$41,$56,$49
        .byte $4e,$47,$a0,$0d,$56,$45,$52,$49,$46,$59,$49,$4e,$c7,$0d,$46,$4f
        .byte $55,$4e,$44,$a0,$0d,$4f,$4b,$8d,$24,$9d

    L_f12d:
        bpl L_f13c
    L_f12f:
        lda L_f0bd,y
        php 
        and #$7f
        jsr L_ffd2
        iny 
        plp 
        bpl L_f12f
    L_f13c:
        clc 
        rts 


        lda $99
        bne L_f14a
        lda $c6
        beq L_f155
        sei 
        jmp L_e5b4
    L_f14a:
        cmp #$02
        bne L_f166
    L_f14e:
        sty $97
        jsr L_f086
        ldy $97
    L_f155:
        clc 
        rts 


        lda $99
        bne L_f166
        lda $d3
        sta $ca
        lda $d6
        sta $c9
        jmp L_e632
    L_f166:
        cmp #$03
        bne L_f173
        sta $d0
        lda $d5
        sta $c8
        jmp L_e632
    L_f173:
        bcs L_f1ad
        cmp #$02
        beq L_f1b8
        stx $97
        jsr L_f199
        bcs L_f196
        pha 
        jsr L_f199
        bcs L_f193
        bne L_f18d
        lda #$40
        jsr L_fe1c
    L_f18d:
        dec $a6
        ldx $97
        pla 
        rts 


    L_f193:
        tax 
        pla 
        txa 
    L_f196:
        ldx $97
        rts 


    L_f199:
        jsr L_f80d
        bne L_f1a9
        jsr L_f841
        bcs L_f1b4
        lda #$00
        sta $a6
        beq L_f199
    L_f1a9:
        lda ($b2),y
        clc 
        rts 


    L_f1ad:
        lda $90
        beq L_f1b5
    L_f1b1:
        lda #$0d
    L_f1b3:
        clc 
    L_f1b4:
        rts 


    L_f1b5:
        jmp L_ee13
    L_f1b8:
        jsr L_f14e
        bcs L_f1b4
        cmp #$00
        bne L_f1b3
        lda $0297
        and #$60
        bne L_f1b1
        beq L_f1b8
        pha 
        lda $9a
        cmp #$03
        bne L_f1d5
        pla 
        jmp L_e716
    L_f1d5:
        bcc L_f1db
        pla 
        jmp L_eddd
    L_f1db:
        lsr 
        pla 
    L_f1dd:
        sta $9e
        txa 
        pha 
        tya 
        pha 
        bcc L_f208
        jsr L_f80d
        bne L_f1f8
        jsr L_f864
        bcs L_f1fd
        lda #$02
        ldy #$00
        sta ($b2),y
        iny 
    L_f1f6:
        sty $a6
    L_f1f8:
        lda $9e
        sta ($b2),y
    L_f1fc:
        clc 
    L_f1fd:
        pla 
        tay 
        pla 
        tax 
        lda $9e
        bcc L_f207
        lda #$00
    L_f207:
        rts 


    L_f208:
        jsr L_f017
        jmp L_f1fc
        jsr L_f30f
        beq L_f216
        jmp $f701
    L_f216:
        jsr L_f31f
        lda $ba
        beq L_f233
        cmp #$03
        beq L_f233
        bcs L_f237
        cmp #$02
        bne L_f22a
        jmp L_f04d
    L_f22a:
        ldx $b9
        cpx #$60
        beq L_f233
        jmp $f70a
    L_f233:
        sta $99
        clc 
        rts 


    L_f237:
        tax 
        jsr $ed09
        lda $b9
        bpl L_f245
        jsr L_edcc
        jmp L_f248
    L_f245:
        jsr L_edc7
    L_f248:
        txa 
        bit $90
        bpl L_f233
        jmp $f707
        jsr L_f30f
        beq L_f258
        jmp $f701
    L_f258:
        jsr L_f31f
        lda $ba
        bne L_f262
    L_f25f:
        jmp $f70d
    L_f262:
        cmp #$03
        beq L_f275
        bcs L_f279
        cmp #$02
        bne L_f26f
        jmp L_efe1
    L_f26f:
        ldx $b9
        cpx #$60
        beq L_f25f
    L_f275:
        sta $9a
        clc 
        rts 


    L_f279:
        tax 
        jsr $ed0c
        lda $b9
        bpl L_f286
        jsr L_edbe
        bne L_f289
    L_f286:
        jsr L_edb9
    L_f289:
        txa 
        bit $90
        bpl L_f275
        jmp $f707
        jsr L_f314
        beq L_f298
        clc 
        rts 


    L_f298:
        jsr L_f31f
        txa 
        pha 
        lda $ba
        beq L_f2f1
        cmp #$03
        beq L_f2f1
        bcs L_f2ee
        cmp #$02
        bne L_f2c8
        pla 
        jsr L_f2f2
        jsr L_f483
        jsr L_fe27
        lda $f8
        beq L_f2ba
        iny 
    L_f2ba:
        lda $fa
        beq L_f2bf
        iny 
    L_f2bf:
        lda #$00
        sta $f8
        sta $fa
        jmp L_f47d
    L_f2c8:
        lda $b9
        and #$0f
        beq L_f2f1
        jsr L_f7d0
        lda #$00
        sec 
        jsr L_f1dd
        jsr L_f864
        bcc L_f2e0
        pla 
        lda #$00
        rts 


    L_f2e0:
        lda $b9
        cmp #$62
        bne L_f2f1
        lda #$05
        jsr L_f76a
        jmp L_f2f1
    L_f2ee:
        jsr L_f642
    L_f2f1:
        pla 
    L_f2f2:
        tax 
        dec $98
        cpx $98
        beq L_f30d
        ldy $98
        lda $0259,y
        sta $0259,x
        lda $0263,y
        sta $0263,x
        lda $026d,y
        sta $026d,x
    L_f30d:
        clc 
        rts 


    L_f30f:
        lda #$00
        sta $90
        txa 
    L_f314:
        ldx $98
    L_f316:
        dex 
        bmi L_f32e
        cmp $0259,x
        bne L_f316
        rts 


    L_f31f:
        lda $0259,x
        sta $b8
        lda $0263,x
        sta $ba
        lda $026d,x
        sta $b9
    L_f32e:
        rts 


        lda #$00
        sta $98
        ldx #$03
        cpx $9a
        bcs L_f33c
        jsr $edfe
    L_f33c:
        cpx $99
        bcs L_f343
        jsr L_edef
    L_f343:
        stx $9a
        lda #$00
        sta $99
        rts 


    L_f34a:
        ldx $b8
        bne L_f351
        jmp $f70a
    L_f351:
        jsr L_f30f
        bne L_f359
        jmp $f6fe
    L_f359:
        ldx $98
        cpx #$0a
        bcc L_f362
        jmp L_f6fb
    L_f362:
        inc $98
        lda $b8
        sta $0259,x
        lda $b9
        ora #$60
        sta $b9
        sta $026d,x
        lda $ba
        sta $0263,x
        beq L_f3d3
        cmp #$03
        beq L_f3d3
        bcc L_f384
        jsr L_f3d5
        bcc L_f3d3
    L_f384:
        cmp #$02
        bne L_f38b
        jmp L_f409
    L_f38b:
        jsr L_f7d0
        bcs L_f393
        jmp $f713
    L_f393:
        lda $b9
        and #$0f
        bne L_f3b8
        jsr L_f817
        bcs L_f3d4
        jsr L_f5af
        lda $b7
        beq L_f3af
        jsr L_f7ea
        bcc L_f3c2
        beq L_f3d4
    L_f3ac:
        jmp $f704
    L_f3af:
        jsr L_f72c
        beq L_f3d4
        bcc L_f3c2
        bcs L_f3ac
    L_f3b8:
        jsr L_f838
        bcs L_f3d4
        lda #$04
        jsr L_f76a
    L_f3c2:
        lda #$bf
        ldy $b9
        cpy #$60
        beq L_f3d1
        ldy #$00
        lda #$02
        sta ($b2),y
        tya 
    L_f3d1:
        sta $a6
    L_f3d3:
        clc 
    L_f3d4:
        rts 


    L_f3d5:
        lda $b9
        bmi L_f3d3
        ldy $b7
        beq L_f3d3
        lda #$00
        sta $90
        lda $ba
        jsr $ed0c
        lda $b9
        ora #$f0
        jsr L_edb9
        lda $90
        bpl L_f3f6
        pla 
        pla 
        jmp $f707
    L_f3f6:
        lda $b7
        beq L_f406
        ldy #$00
    L_f3fc:
        lda ($bb),y
        jsr L_eddd
        iny 
        cpy $b7
        bne L_f3fc
    L_f406:
        jmp L_f654
    L_f409:
        jsr L_f483
        sty $0297
    L_f40f:
        cpy $b7
        beq L_f41d
        lda ($bb),y
        sta $0293,y
        iny 
        cpy #$04
        bne L_f40f
    L_f41d:
        jsr L_ef4a
        stx $0298
        lda $0293
        and #$0f
        beq L_f446
        asl 
        tax 
        lda $02a6
        bne L_f43a
        ldy L_fec1,x
        lda L_fec0,x
        jmp L_f440
    L_f43a:
        ldy L_e4eb,x
        lda $e4ea,x
    L_f440:
        sty $0296
        sta $0295
    L_f446:
        lda $0295
        asl 
        jsr L_ff2e
        lda $0294
        lsr 
        bcc L_f45c
        lda cCia2PortB
        asl 
        bcs L_f45c
        jsr L_f00d
    L_f45c:
        lda $029b
        sta $029c
        lda $029e
        sta $029d
        jsr L_fe27
        lda $f8
        bne L_f474
        dey 
        sty $f8
        stx $f7
    L_f474:
        lda $fa
        bne L_f47d
        dey 
        sty $fa
        stx $f9
    L_f47d:
        sec 
        lda #$f0
        jmp L_fe2d
    L_f483:
        lda #$7f
        sta cCia2IntControl
        lda #$06
        sta cCia2DDRB
        sta cCia2PortB
        lda #$04
        ora cCia2PortA
        sta cCia2PortA
        ldy #$00
        sty $02a1
        rts 


    L_f49e:
        stx $c3
        sty $c4
        jmp ($0330)
        sta $93
        lda #$00
        sta $90
        lda $ba
        bne L_f4b2
    L_f4af:
        jmp $f713
    L_f4b2:
        cmp #$03
        beq L_f4af
        bcc L_f533
        ldy $b7
        bne L_f4bf
        jmp $f710
    L_f4bf:
        ldx $b9
        jsr L_f5af
        lda #$60
        sta $b9
        jsr L_f3d5
        lda $ba
        jsr $ed09
        lda $b9
        jsr L_edc7
        jsr L_ee13
        sta $ae
        lda $90
        lsr 
        lsr 
        bcs L_f530
        jsr L_ee13
        sta $af
        txa 
        bne L_f4f0
        lda $c3
        sta $ae
        lda $c4
        sta $af
    L_f4f0:
        jsr L_f5d2
    L_f4f3:
        lda #$fd
        and $90
        sta $90
        jsr L_ffe1
        bne L_f501
        jmp L_f633
    L_f501:
        jsr L_ee13

        .byte $aa,$a5,$90,$4a,$4a,$b0,$e8,$8a,$a4,$93,$f0,$0c,$a0,$00,$d1,$ae
        .byte $f0,$08,$a9,$10,$20,$1c,$fe,$2c,$91,$ae

    L_f51e:
        inc $ae
        bne L_f524
        inc $af
    L_f524:
        bit $90
        bvc L_f4f3
        jsr L_edef
        jsr L_f642

        .byte $90,$79

    L_f530:
        jmp $f704
    L_f533:
        lsr 
        bcs L_f539
        jmp $f713
    L_f539:
        jsr L_f7d0
        bcs L_f541
        jmp $f713
    L_f541:
        jsr L_f817
        bcs L_f5ae
        jsr L_f5af
    L_f549:
        lda $b7
        beq L_f556
        jsr L_f7ea
        bcc L_f55d
        beq L_f5ae
        bcs L_f530
    L_f556:
        jsr L_f72c
        beq L_f5ae
        bcs L_f530
    L_f55d:
        lda $90
        and #$10
        sec 
        bne L_f5ae
        cpx #$01
        beq L_f579
        cpx #$03
        bne L_f549
    L_f56c:
        ldy #$01
        lda ($b2),y
        sta $c3
        iny 
        lda ($b2),y
        sta $c4
        bcs L_f57d
    L_f579:
        lda $b9
        bne L_f56c
    L_f57d:
        ldy #$03
        lda ($b2),y
        ldy #$01
        sbc ($b2),y
        tax 
        ldy #$04
        lda ($b2),y
        ldy #$02
        sbc ($b2),y
        tay 
        clc 
        txa 
        adc $c3
        sta $ae
        tya 
        adc $c4
        sta $af
        lda $c3
        sta $c1
        lda $c4
        sta $c2
        jsr L_f5d2
        jsr L_f84a
        bit $18
        ldx $ae
        ldy $af
    L_f5ae:
        rts 


    L_f5af:
        lda $9d
        bpl L_f5d1
        ldy #$0c
        jsr L_f12f
        lda $b7
        beq L_f5d1
        ldy #$17
        jsr L_f12f
    L_f5c1:
        ldy $b7
        beq L_f5d1
        ldy #$00
    L_f5c7:
        lda ($bb),y
        jsr L_ffd2
        iny 
        cpy $b7
        bne L_f5c7
    L_f5d1:
        rts 


    L_f5d2:
        ldy #$49
        lda $93
        beq L_f5da
        ldy #$59
    L_f5da:
        jmp $f12b
    L_f5dd:
        stx $ae
        sty $af
        tax 
        lda $00,x
        sta $c1
        lda $01,x
        sta $c2
        jmp ($0332)
        lda $ba
        bne L_f5f4
    L_f5f1:
        jmp $f713
    L_f5f4:
        cmp #$03
        beq L_f5f1
        bcc L_f659
        lda #$61
        sta $b9
        ldy $b7
        bne L_f605
        jmp $f710
    L_f605:
        jsr L_f3d5
        jsr L_f68f
        lda $ba
        jsr $ed0c
        lda $b9
        jsr L_edb9
        ldy #$00
        jsr L_fb8e
        lda $ac
        jsr L_eddd
        lda $ad
        jsr L_eddd
    L_f624:
        jsr L_fcd1
        bcs L_f63f
        lda ($ac),y
        jsr L_eddd
        jsr L_ffe1
        bne L_f63a
    L_f633:
        jsr L_f642
        lda #$00
        sec 
        rts 


    L_f63a:
        jsr L_fcdb
        bne L_f624
    L_f63f:
        jsr $edfe
    L_f642:
        bit $b9
        bmi L_f657
        lda $ba
        jsr $ed0c
        lda $b9
        and #$ef
        ora #$e0
        jsr L_edb9
    L_f654:
        jsr $edfe
    L_f657:
        clc 
        rts 


    L_f659:
        lsr 
        bcs L_f65f
        jmp $f713
    L_f65f:
        jsr L_f7d0
        bcc L_f5f1
        jsr L_f838
        bcs L_f68e
        jsr L_f68f
        ldx #$03
        lda $b9
        and #$01
        bne L_f676
        ldx #$01
    L_f676:
        txa 
        jsr L_f76a
        bcs L_f68e
        jsr L_f867

        .byte $b0,$0d,$a5,$b9,$29,$02,$f0,$06,$a9,$05,$20,$6a,$f7,$24,$18

    L_f68e:
        rts 


    L_f68f:
        lda $9d
        bpl L_f68e
        ldy #$51
        jsr L_f12f
        jmp L_f5c1
    L_f69b:
        ldx #$00
        inc $a2
        bne L_f6a7
        inc $a1
        bne L_f6a7
        inc $a0
    L_f6a7:
        sec 
        lda $a2
        sbc #$01
        lda $a1
        sbc #$1a
        lda $a0
        sbc #$4f
        bcc L_f6bc
        stx $a0
        stx $a1
        stx $a2
    L_f6bc:
        lda cCia1PortB
        cmp cCia1PortB
        bne L_f6bc
        tax 
        bmi L_f6da
        ldx #$bd
        stx cCia1PortA
    L_f6cc:
        ldx cCia1PortB
        cpx cCia1PortB
        bne L_f6cc
        sta cCia1PortA
        inx 
        bne L_f6dc
    L_f6da:
        sta $91
    L_f6dc:
        rts 


    L_f6dd:
        sei 
    L_f6de:
        lda $a2
        ldx $a1
        ldy $a0
    L_f6e4:
        sei 
        sta $a2
        stx $a1
        sty $a0
        cli 
        rts 


        lda $91
        cmp #$7f
        bne L_f6fa
        php 
        jsr L_ffcc
        sta $c6
        plp 
    L_f6fa:
        rts 


    L_f6fb:
        lda #$01
        bit $02a9
        bit $03a9
        bit SCREEN_BUFFER_0 + $a9
        bit SCREEN_BUFFER_0 + $1a9
        bit SCREEN_BUFFER_0 + $2a9
        bit SCREEN_BUFFER_0 + $3a9
        bit SCREEN_BUFFER_1 + $a9
        bit SCREEN_BUFFER_1 + $1a9
        pha 
        jsr L_ffcc
        ldy #$00
        bit $9d
        bvc L_f729
        jsr L_f12f
        pla 
        pha 
        ora #$30
        jsr L_ffd2
    L_f729:
        pla 
        sec 
        rts 


    L_f72c:
        lda $93
        pha 
        jsr L_f841
        pla 
        sta $93
        bcs L_f769
        ldy #$00
        lda ($b2),y
        cmp #$05
        beq L_f769
        cmp #$01
        beq L_f74b
        cmp #$03
        beq L_f74b
        cmp #$04
        bne L_f72c
    L_f74b:
        tax 
        bit $9d
        bpl L_f767
        ldy #$63
        jsr L_f12f
        ldy #$05
    L_f757:
        lda ($b2),y
        jsr L_ffd2
        iny 
        cpy #$15
        bne L_f757
        lda $a1
        jsr L_e4e0
        nop 
    L_f767:
        clc 
        dey 
    L_f769:
        rts 


    L_f76a:
        sta $9e
        jsr L_f7d0
        bcc L_f7cf
        lda $c2
        pha 
        lda $c1
        pha 
        lda $af
        pha 
        lda $ae
        pha 
        ldy #$bf
        lda #$20
    L_f781:
        sta ($b2),y
        dey 
        bne L_f781
        lda $9e
        sta ($b2),y
        iny 
        lda $c1
        sta ($b2),y
        iny 
        lda $c2
        sta ($b2),y
        iny 
        lda $ae
        sta ($b2),y
        iny 
        lda $af
        sta ($b2),y
        iny 
        sty $9f
        ldy #$00
        sty $9e
    L_f7a5:
        ldy $9e
        cpy $b7
        beq L_f7b7
        lda ($bb),y
    L_f7ad:
        ldy $9f
        sta ($b2),y
        inc $9e
        inc $9f
        bne L_f7a5
    L_f7b7:
        jsr L_f7d7
        lda #$69
        sta $ab
        jsr L_f86b
        tay 
        pla 
        sta $ae
        pla 
        sta $af
        pla 
        sta $c1
        pla 
        sta $c2
        tya 
    L_f7cf:
        rts 


    L_f7d0:
        ldx $b2
        ldy $b3
        cpy #$02
        rts 


    L_f7d7:
        jsr L_f7d0
        txa 
        sta $c1
        clc 
        adc #$c0
        sta $ae
        tya 
        sta $c2
        adc #$00
        sta $af
        rts 


    L_f7ea:
        jsr L_f72c
        bcs L_f80c
        ldy #$05
        sty $9f
        ldy #$00
        sty $9e
    L_f7f7:
        cpy $b7
        beq L_f80b
        lda ($bb),y
        ldy $9f
        cmp ($b2),y
        bne L_f7ea
        inc $9e
        inc $9f
        ldy $9e
        bne L_f7f7
    L_f80b:
        clc 
    L_f80c:
        rts 


    L_f80d:
        jsr L_f7d0
        inc $a6
        ldy $a6
        cpy #$c0
        rts 


    L_f817:
        jsr L_f82e
        beq L_f836
        ldy #$1b
    L_f81e:
        jsr L_f12f
    L_f821:
        jsr L_f8d0
        jsr L_f82e
        bne L_f821
        ldy #$6a
        jmp L_f12f
    L_f82e:
        lda #$10
        bit $01
        bne L_f836
        bit $01
    L_f836:
        clc 
        rts 


    L_f838:
        jsr L_f82e
        beq L_f836
        ldy #$2e
        bne L_f81e
    L_f841:
        lda #$00
        sta $90
        sta $93
        jsr L_f7d7
    L_f84a:
        jsr L_f817
        bcs L_f86e
        sei 
        lda #$00
        sta $aa
        sta $b4
        sta $b0
        sta $9e
        sta $9f
        sta $9c
        lda #$90
        ldx #$0e
        bne L_f875
    L_f864:
        jsr L_f7d7
    L_f867:
        lda #$14
        sta $ab
    L_f86b:
        jsr L_f838
    L_f86e:
        bcs L_f8dc
        sei 
        lda #$82
        ldx #$08
    L_f875:
        ldy #$7f
        sty cCia1IntControl
        sta cCia1IntControl
        lda cCia1TimerAControl
        ora #$19
        sta cCia1TimerbControl
        and #$91
        sta $02a2
        jsr L_f0a4
        lda vScreenControl1
        and #$ef
        sta vScreenControl1
        lda $0314
        sta $029f
        lda $0315
        sta $02a0
        jsr L_fcbd
        lda #$02
        sta $be
        jsr L_fb97
        lda $01
        and #$1f
        sta $01
        sta $c0
        ldx #$ff
    L_f8b5:
        ldy #$ff
    L_f8b7:
        dey 
        bne L_f8b7
        dex 
        bne L_f8b5
        cli 
    L_f8be:
        lda $02a0
        cmp $0315
        clc 
        beq L_f8dc
        jsr L_f8d0
        jsr L_f6bc
        jmp L_f8be
    L_f8d0:
        jsr L_ffe1
        clc 
        bne L_f8e1
        jsr L_fc93
        sec 
        pla 
        pla 
    L_f8dc:
        lda #$00
        sta $02a0
    L_f8e1:
        rts 


    L_f8e2:
        stx $b1
        lda $b0
        asl 
        asl 
        clc 
        adc $b0
        clc 
        adc $b1
        sta $b1
        lda #$00
        bit $b0
        bmi L_f8f7
        rol 
    L_f8f7:
        asl $b1
        rol 
        asl $b1
        rol 
        tax 
    L_f8fe:
        lda cCia1TimerBLo
        cmp #$16
        bcc L_f8fe
        adc $b1
        sta cCia1TimerALo
        txa 
        adc cCia1TimerBHi
        sta cCia1TimerAHi
        lda $02a2
        sta cCia1TimerAControl
        sta $02a4
        lda cCia1IntControl
        and #$10
        beq L_f92a
        lda #$f9
        pha 
        lda #$2a
        pha 
        jmp L_ff43
    L_f92a:
        cli 
        rts 


    L_f92c:
        ldx cCia1TimerBHi
        ldy #$ff
        tya 
        sbc cCia1TimerBLo
        cpx cCia1TimerBHi
        bne L_f92c
        stx $b1
        tax 
        sty cCia1TimerBLo
        sty cCia1TimerBHi
        lda #$19
        sta cCia1TimerbControl
        lda cCia1IntControl
        sta $02a3
        tya 
        sbc $b1
        stx $b1
        lsr 
        ror $b1
        lsr 
        ror $b1
        lda $b0
        clc 
        adc #$3c
        cmp $b1
        bcs L_f9ac
        ldx $9c
        beq L_f969
        jmp L_fa60
    L_f969:
        ldx $a3
        bmi L_f988
        ldx #$00
    L_f96f:
        adc #$30
        adc $b0
        cmp $b1
        bcs L_f993
        inx 
        adc #$26
        adc $b0
        cmp $b1
        bcs L_f997
        adc #$2c
        adc $b0
        cmp $b1
        bcc L_f98b
    L_f988:
        jmp L_fa10
    L_f98b:
        lda $b4
        beq L_f9ac
        sta $a8
        bne L_f9ac
    L_f993:
        inc $a9
        bcs L_f999
    L_f997:
        dec $a9
    L_f999:
        sec 
        sbc #$13
        sbc $b1
        adc $92
        sta $92
        lda $a4
        eor #$01
        sta $a4
        beq L_f9d5
        stx $d7
    L_f9ac:
        lda $b4
        beq L_f9d2
        lda $02a3
        and #$01
        bne L_f9bc
        lda $02a4
        bne L_f9d2
    L_f9bc:
        lda #$00
        sta $a4
        sta $02a4
        lda $a3
        bpl L_f9f7
        bmi L_f988
    L_f9c9:
        ldx #$a6
        jsr L_f8e2
        lda $9b
        bne L_f98b
    L_f9d2:
        jmp L_febc

    L_f9d5:
         .byte $a5,$92,$f0,$07,$30,$03
        .byte $c6,$b0,$2c,$e6,$b0,$a9,$00,$85,$92,$e4,$d7,$d0,$0f,$8a

    L_f9e9:
        bne L_f98b
        lda $a9
        bmi L_f9ac
        cmp #$10
        bcc L_f9ac
        sta $96
        bcs L_f9ac
    L_f9f7:
        txa 
        eor $9b
        sta $9b
        lda $b4
        beq L_f9d2
    L_fa00:
        dec $a3
        bmi L_f9c9
        lsr $d7
        ror $bf
        ldx #$da
        jsr L_f8e2
        jmp L_febc
    L_fa10:
        lda $96
        beq L_fa18
        lda $b4
        beq L_fa1f
    L_fa18:
        lda $a3
        bmi L_fa1f
        jmp L_f997
    L_fa1f:
        lsr $b1
        lda #$93
        sec 
        sbc $b1
        adc $b0
        asl 
        tax 
        jsr L_f8e2
        inc $9c
        lda $b4
        bne L_fa44
        lda $96
        beq L_fa5d
        sta $a8
        lda #$00
        sta $96
        lda #$81
        sta cCia1IntControl
        sta $b4
    L_fa44:
        lda $96
        sta $b5
        beq L_fa53
        lda #$00
        sta $b4
        lda #$01
        sta cCia1IntControl
    L_fa53:
        lda $bf
        sta $bd
        lda $a8
        ora $a9
        sta $b6
    L_fa5d:
        jmp L_febc
    L_fa60:
        jsr L_fb97
        sta $9c
        ldx #$da
        jsr L_f8e2
        lda $be
        beq L_fa70
        sta $a7
    L_fa70:
        lda #$0f
        bit $aa
        bpl L_fa8d
        lda $b5
        bne L_fa86
        ldx $be
        dex 
        bne L_fa8a
        lda #$08
        jsr L_fe1c
        bne L_fa8a
    L_fa86:
        lda #$00
        sta $aa
    L_fa8a:
        jmp L_febc
    L_fa8d:
        bvs L_fac0
        bne L_faa9
        lda $b5
        bne L_fa8a
        lda $b6
        bne L_fa8a
        lda $a7
        lsr 
        lda $bd
        bmi L_faa3
        bcc L_faba
        clc 
    L_faa3:
        bcs L_faba
        and #$0f
        sta $aa
    L_faa9:
        dec $aa
        bne L_fa8a
        lda #$40
        sta $aa
        jsr L_fb8e
        lda #$00
        sta $ab
        beq L_fa8a
    L_faba:
        lda #$80
        sta $aa
        bne L_fa8a
    L_fac0:
        lda $b5
        beq L_face
        lda #$04
        jsr L_fe1c
        lda #$00
        jmp L_fb4a
    L_face:
        jsr L_fcd1
        bcc L_fad6
        jmp L_fb48
    L_fad6:
        ldx $a7
        dex 
        beq L_fb08
        lda $93
        beq L_faeb
        ldy #$00
        lda $bd
        cmp ($ac),y
        beq L_faeb
        lda #$01
        sta $b6
    L_faeb:
        lda $b6
        beq L_fb3a
        ldx #$3d
        cpx $9e
        bcc L_fb33
        ldx $9e
        lda $ad
        sta $0101,x
        lda $ac
        sta $0100,x
        inx 
        inx 
        stx $9e
        jmp L_fb3a
    L_fb08:
        ldx $9f
        cpx $9e
        beq L_fb43
        lda $ac
        cmp $0100,x
        bne L_fb43
        lda $ad
        cmp $0101,x
        bne L_fb43
        inc $9f
        inc $9f
        lda $93
        beq L_fb2f
        lda $bd
        ldy #$00
        cmp ($ac),y
        beq L_fb43
        iny 
        sty $b6
    L_fb2f:
        lda $b6
        beq L_fb3a
    L_fb33:
        lda #$10
        jsr L_fe1c
        bne L_fb43
    L_fb3a:
        lda $93
        bne L_fb43
        tay 
        lda $bd
        sta ($ac),y
    L_fb43:
        jsr L_fcdb
        bne L_fb8b
    L_fb48:
        lda #$80
    L_fb4a:
        sta $aa
        sei 
        ldx #$01
        stx cCia1IntControl
        ldx cCia1IntControl
        ldx $be
        dex 
        bmi L_fb5c
        stx $be
    L_fb5c:
        dec $a7
        beq L_fb68
        lda $9e
        bne L_fb8b
        sta $be
        beq L_fb8b
    L_fb68:
        jsr L_fc93
        jsr L_fb8e
        ldy #$00
        sty $ab
    L_fb72:
        lda ($ac),y
        eor $ab
        sta $ab
        jsr L_fcdb
        jsr L_fcd1
        bcc L_fb72
        lda $ab
        eor $bd
        beq L_fb8b
        lda #$20
        jsr L_fe1c
    L_fb8b:
        jmp L_febc
    L_fb8e:
        lda $c2
        sta $ad
        lda $c1
        sta $ac
        rts 


    L_fb97:
        lda #$08
        sta $a3
        lda #$00
        sta $a4
        sta $a8
        sta $9b
        sta $a9
        rts 


    L_fba6:
        lda $bd
        lsr 
        lda #$60
        bcc L_fbaf
    L_fbad:
        lda #$b0
    L_fbaf:
        ldx #$00
    L_fbb1:
        sta cCia1TimerBLo
        stx cCia1TimerBHi
        lda cCia1IntControl
        lda #$19
        sta cCia1TimerbControl
        lda $01
        eor #$08
        sta $01
        and #$08
        rts 


    L_fbc8:
        sec 
        ror $b6
        bmi L_fc09
        lda $a8
        bne L_fbe3
        lda #$10
        ldx #$01
        jsr L_fbb1
        bne L_fc09
        inc $a8
        lda $b6
        bpl L_fc09
        jmp L_fc57
    L_fbe3:
        lda $a9
        bne L_fbf0
        jsr L_fbad
        bne L_fc09
        inc $a9
        bne L_fc09
    L_fbf0:
        jsr L_fba6
        bne L_fc09
        lda $a4
        eor #$01
        sta $a4
        beq L_fc0c
        lda $bd
        eor #$01
        sta $bd
        and #$01
        eor $9b
        sta $9b
    L_fc09:
        jmp L_febc
    L_fc0c:
        lsr $bd
        dec $a3
        lda $a3
        beq L_fc4e
        bpl L_fc09
    L_fc16:
        jsr L_fb97
        cli 
        lda $a5
        beq L_fc30
        ldx #$00
        stx $d7
        dec $a5
        ldx $be
        cpx #$02
        bne L_fc2c
        ora #$80
    L_fc2c:
        sta $bd
        bne L_fc09
    L_fc30:
        jsr L_fcd1
        bcc L_fc3f
        bne L_fbc8
        inc $ad
        lda $d7
        sta $bd
        bcs L_fc09
    L_fc3f:
        ldy #$00
        lda ($ac),y
        sta $bd
        eor $d7
        sta $d7
        jsr L_fcdb
        bne L_fc09
    L_fc4e:
        lda $9b
        eor #$01
        sta $bd
    L_fc54:
        jmp L_febc
    L_fc57:
        dec $be
        bne L_fc5e
        jsr L_fcca
    L_fc5e:
        lda #$50
        sta $a7
        ldx #$08
        sei 
        jsr L_fcbd
        bne L_fc54
        lda #$78
        jsr L_fbaf
        bne L_fc54
        dec $a7
        bne L_fc54
        jsr L_fb97
        dec $ab
        bpl L_fc54
        ldx #$0a
        jsr L_fcbd
        cli 
        inc $ab
        lda $be
        beq L_fcb8
        jsr L_fb8e
        ldx #$09
        stx $a5
        stx $b6
        bne L_fc16
    L_fc93:
        php 
        sei 
        lda vScreenControl1
        ora #$10
        sta vScreenControl1
        jsr L_fcca
        lda #$7f
        sta cCia1IntControl
        jsr L_fddd
        lda $02a0
        beq L_fcb6
        sta $0315
        lda $029f
        sta $0314
    L_fcb6:
        plp 
        rts 


    L_fcb8:
        jsr L_fc93
        beq L_fc54
    L_fcbd:
        lda $fd93,x
        sta $0314
        lda $fd94,x
        sta $0315
        rts 


    L_fcca:
        lda $01
        ora #$20
        sta $01
        rts 


    L_fcd1:
        sec 
        lda $ac
        sbc $ae
        lda $ad
        sbc $af
        rts 


    L_fcdb:
        inc $ac
        bne L_fce1
        inc $ad
    L_fce1:
        rts 


        ldx #$ff
        sei 
        txs 
        cld 
        jsr L_fd02
        bne L_fcef
        jmp (L_8000)
    L_fcef:
        stx vScreenControl2
        jsr $fda3
        jsr $fd50
        jsr L_fd15
        jsr L_ff5b
        cli 
        jmp (L_9ff2 + $e)
    L_fd02:
        ldx #$05
    L_fd04:
        lda L_fd0f,x
        cmp $8003,x
        bne L_fd0f
        dex 
        bne L_fd04
    L_fd0f:
        rts 



        .byte $c3,$c2,$cd,$38,$30

    L_fd15:
        ldx #$30
        ldy #$fd
        clc 
    L_fd1a:
        stx $c3
        sty $c4
        ldy #$1f
    L_fd20:
        lda $0314,y
        bcs L_fd27
        lda ($c3),y
    L_fd27:
        sta ($c3),y
        sta $0314,y
        dey 
        bpl L_fd20
        rts 



        .byte $31,$ea,$66,$fe,$47,$fe,$4a,$f3,$91,$f2,$0e,$f2,$50,$f2,$33,$f3
        .byte $57,$f1,$ca,$f1,$ed,$f6,$3e,$f1,$2f,$f3,$66,$fe,$a5,$f4,$ed,$f5
        .byte $a9,$00,$a8

    L_fd53:
        sta.a $0002,y
        sta $0200,y
        sta $0300,y
        iny 
        bne L_fd53
        ldx #$3c
        ldy #$03
        stx $b2
        sty $b3
        tay 
        lda #$03
        sta $c2
    L_fd6c:
        inc $c2
    L_fd6e:
        lda ($c1),y
        tax 
        lda #$55
        sta ($c1),y
    L_fd75:
        cmp ($c1),y
        bne L_fd88
        rol 
        sta ($c1),y
        cmp ($c1),y
        bne L_fd88
        txa 
        sta ($c1),y
        iny 
        bne L_fd6e
        beq L_fd6c
    L_fd88:
        tya 
        tax 
        ldy $c2
        clc 
        jsr L_fe2d
        lda #$08
        sta $0282
        lda #$04
        sta $0288
        rts 



        .byte $6a,$fc,$cd,$fb,$31,$ea,$2c,$f9,$a9,$7f,$8d,$0d,$dc,$8d,$0d,$dd
        .byte $8d,$00,$dc,$a9,$08,$8d,$0e,$dc,$8d,$0e,$dd,$8d,$0f,$dc,$8d,$0f
        .byte $dd,$a2,$00,$8e,$03,$dc,$8e,$03,$dd,$8e,$18,$d4,$ca,$8e,$02,$dc
        .byte $a9,$07,$8d,$00,$dd,$a9,$3f,$8d,$02,$dd,$a9,$e7,$85,$01,$a9,$2f
        .byte $85,$00

    L_fddd:
        lda $02a6
        beq L_fdec
        lda #$25
        sta cCia1TimerALo
        lda #$40
        jmp L_fdf3
    L_fdec:
        lda #$95
        sta cCia1TimerALo
        lda #$42
    L_fdf3:
        sta cCia1TimerAHi
        jmp L_ff6e
    L_fdf9:
        sta $b7
        stx $bb
    L_fdfd:
        sty $bc
        rts 


    L_fe00:
        sta $b8
        stx $ba
        sty $b9
        rts 


    L_fe07:
        lda $ba
        cmp #$02
        bne L_fe1a
        lda $0297
        pha 
        lda #$00
        sta $0297
        pla 
        rts 


    L_fe18:
        sta $9d
    L_fe1a:
        lda $90
    L_fe1c:
        ora $90
        sta $90
        rts 


    L_fe21:
        sta $0285
        rts 


    L_fe25:
        bcc L_fe2d
    L_fe27:
        ldx $0283
        ldy $0284
    L_fe2d:
        stx $0283
        sty $0284
        rts 


    L_fe34:
        bcc L_fe3c
        ldx $0281
        ldy $0282
    L_fe3c:
        stx $0281
        sty $0282
        rts 


    L_fe43:
        sei 
        jmp ($0318)
        pha 
        txa 
        pha 
        tya 
        pha 
        lda #$7f
        sta cCia2IntControl
        ldy cCia2IntControl
        bmi L_fe72
        jsr L_fd02
        bne L_fe5e
        jmp (L_8002)
    L_fe5e:
        jsr L_f6bc
        jsr L_ffe1
        bne L_fe72
        jsr L_fd15
        jsr $fda3
        jsr L_e518
        jmp (L_a002)
    L_fe72:
        tya 
        and $02a1
        tax 
        and #$01
        beq L_fea3
        lda cCia2PortA
        and #$fb
        ora $b5
        sta cCia2PortA
        lda $02a1
        sta cCia2IntControl
        txa 
        and #$12
        beq L_fe9d
        and #$02
        beq L_fe9a
        jsr L_fed6
        jmp L_fe9d
    L_fe9a:
        jsr L_ff07
    L_fe9d:
        jsr L_eebb
        jmp L_feb6
    L_fea3:
        txa 
        and #$02
        beq L_feae
        jsr L_fed6
        jmp L_feb6
    L_feae:
        txa 
        and #$10
        beq L_feb6
        jsr L_ff07
    L_feb6:
        lda $02a1
        sta cCia2IntControl
    L_febc:
        pla 
        tay 
        pla 
        tax 
    L_fec0:
        pla 
    L_fec1:
        rti 

    L_fec2:
         .byte $c1,$27,$3e,$1a,$c5,$11,$74,$0e,$ed,$0c,$45,$06,$f0,$02,$46,$01
        .byte $b8,$00,$71,$00

    L_fed6:
        lda cCia2PortB
        and #$01
        sta $a7
        lda cCia2TimerBLo
        sbc #$1c
        adc $0299
        sta cCia2TimerBLo
        lda cCia2TimerBHi
        adc $029a
        sta cCia2TimerBHi
        lda #$11
        sta cCia2TimerbControl
        lda $02a1
        sta cCia2IntControl
        lda #$ff
    L_fefe:
        sta cCia2TimerBLo
    L_ff01:
        sta cCia2TimerBHi
        jmp L_ef59
    L_ff07:
        lda $0295
        sta cCia2TimerBLo
        lda $0296
    L_ff10:
        sta cCia2TimerBHi
        lda #$11
        sta cCia2TimerbControl
        lda #$12
        eor $02a1
        sta $02a1
    L_ff20:
        lda #$ff
        sta cCia2TimerBLo
        sta cCia2TimerBHi
        ldx $0298
        stx $a8
        rts 


    L_ff2e:
        tax 
    L_ff2f:
        lda $0296
        rol 
        tay 
        txa 
        adc #$c8
        sta $0299
        tya 
        adc #$00
        sta $029a
        rts 


        nop 
        nop 
    L_ff43:
        php 
        pla 
    L_ff45:
        and #$ef
        pha 
        pha 
        txa 
        pha 
    L_ff4b:
        tya 
        pha 
    L_ff4d:
        tsx 
        lda $0104,x
        and #$10
        beq L_ff58
        jmp ($0316)
    L_ff58:
        jmp ($0314)
    L_ff5b:
        jsr L_e518
    L_ff5e:
        lda vRaster
        bne L_ff5e
        lda vIRQFlags
        and #$01
        sta $02a6
        jmp L_fddd
    L_ff6e:
        lda #$81
        sta cCia1IntControl
        lda cCia1TimerAControl
        and #$80
        ora #$11
        sta cCia1TimerAControl
        jmp L_ee8e

        .byte $03,$4c,$5b,$ff,$4c,$a3,$fd,$4c,$50,$fd,$4c,$15,$fd,$4c,$1a,$fd

    L_ff90:
        jmp L_fe18
        jmp L_edb9
        jmp L_edc7
    L_ff99:
        jmp L_fe25
    L_ff9c:
        jmp L_fe34
        jmp L_ea87
        jmp L_fe21
        jmp L_ee13
        jmp L_eddd
        jmp L_edef
        jmp $edfe
        jmp $ed0c
        jmp $ed09
    L_ffb7:
        jmp L_fe07
    L_ffba:
        jmp L_fe00
    L_ffbd:
        jmp L_fdf9
    L_ffc0:
        jmp ($031a)
    L_ffc3:
        jmp ($031c)
    L_ffc6:
        jmp ($031e)
    L_ffc9:
        jmp ($0320)
    L_ffcc:
        jmp ($0322)
    L_ffcf:
        jmp ($0324)
    L_ffd2:
        jmp ($0326)
    L_ffd5:
        jmp L_f49e
    L_ffd8:
        jmp L_f5dd
    L_ffdb:
        jmp L_f6e4
    L_ffde:
        jmp L_f6dd
    L_ffe1:
        jmp ($0328)
    L_ffe4:
        jmp ($032a)
    L_ffe7:
        jmp ($032c)
    L_ffea:
        jmp L_f69b
        jmp L_e505
    L_fff0:
        jmp L_e50a
    L_fff3:
        jmp L_e500

        .byte $52,$52,$42
