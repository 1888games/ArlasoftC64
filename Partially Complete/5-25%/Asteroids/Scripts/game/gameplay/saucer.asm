
	SaucerReset: {

			L702D:  lda ScrTmrReload        //Reset saucer timer.
			L7030:  sta ScrTimer            //

			L7033:  lda #$00                //
			L7035:  sta ScrStatus           //
			L7038:  sta SaucerXSpeed        //Clear other saucer variables.
			L703B:  sta SaucerYSpeed        //
			L703E:  rts    


	}                 //
