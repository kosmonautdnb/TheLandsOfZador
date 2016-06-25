;------- MULTIPLY ----------------------
;8x8bits -> 16 bits, signed input and output
;x*y -> y(hi) & x(lo)
;
;warning: there are quite a few undeclared
;zero page addresses used by the mulgen subroutine
;
;the routine is based on this equation:
;
; a*b = ((a+b)/2)^2-((a-b)/2)^2
;
;Oswald/Resource
;
; 
;         JSR MULGEN    ;table setup
;         JSR MKABS
;
;         LDX #$10
;         LDY #$20
;         JSR MUL      ;a test call to the multiply subroutine
;         JMP *

        
mul8_genabstab SUBROUTINE    

		LDX #$00     ;generating a table to get the absolute value of signed numbers
.ABSLP	TXA
		BPL .POS
		EOR #$FF
		CLC
		ADC #$01
.POS	STA mul8_abs,X
		DEX
		BNE .ABSLP
		RTS



mul8_muls SUBROUTINE
		STX mul8_xtmp     ;storing X for later use
		TYA
		EOR mul8_xtmp     ;getting the sign of the final product
		BMI .neg      ;take another routine if the final product will be negative
		
		
		
		LDA mul8_abs,X    ;this is the (a+b) part, we strip a&b from their signs using the abs table.
		CLC          	  ;it is safe to force both numbers to be positive knowing the final sign of the product which we will set later
		ADC mul8_abs,Y    ;this is done to avoid overflows, and the extra code/tables needed to handle them.
		STA mul8_xtmp
		
		LDA mul8_abs,X    ;(abs(a)-abs(b)) 
		SEC
		SBC mul8_abs,Y
		TAY
		
		LDX mul8_abs,Y   ;((a-b)/2)^2 will be always positive so its safe to do abs(a-b)
		LDY mul8_xtmp    ;we do this since the sqr table can only handle positive numbers
		
		
		;now we have a+b in Y and a-b in X
		
		
		;low 8 bits of the product calculated here
		LDA mul8_sqrl,Y  ;((a+b)/2)^2
		SEC
		SBC mul8_sqrl,X  ;-((a-b)/2)^2
		STA mul8_rl

		;same as above for high 8 bits
		LDA mul8_sqrh,Y
		SBC mul8_sqrh,X
		TAX
		LDY mul8_rl
		RTS

;case for negative final product, all the same except inverting the result at the end.

.neg	LDA mul8_abs,X     
		CLC
		ADC mul8_abs,Y
		STA mul8_xtmp
		
		LDA mul8_abs,X
		SEC
		SBC mul8_abs,Y
		TAY
		
		LDX mul8_abs,Y
		LDY mul8_xtmp
		
		LDA mul8_sqrl,Y
		SEC
		SBC mul8_sqrl,X
		STA mul8_rl
		
		LDA mul8_sqrh,Y
		SBC mul8_sqrh,X
		STA mul8_rh
		
		;inverting the result's sign
		LDA mul8_rl
		EOR #$FF
		CLC
		ADC #$01
		STA mul8_rl
		LDA mul8_rh
		EOR #$FF
		ADC #$00
		STA mul8_rh
		
		LDX mul8_rh
		LDY mul8_rl
		RTS



mul8_mulu SUBROUTINE
;		dc.b $f2
		
		stx mul8_rl
		sty mul8_rh
		
		lda mul8_rl
		sta .apb_lo
		sta .apb_hi
		;ldy mul8_rh
		
		lda mul8_rl
		sec
		sbc mul8_rh
		bcs .ispositive
		
		eor #$ff
		adc #$01
.ispositive		
		tax
		
		;low 8 bits of the product calculated here
.apb_lo = .+1		
		LDA mul8_sqrl,Y  ;((a+b)/2)^2
		SEC
		SBC mul8_sqrl,X  ;-((a-b)/2)^2
		STA mul8_rl

		;same as above for high 8 bits
.apb_hi = .+1
		LDA mul8_sqrh,Y
		SBC mul8_sqrh,X
		TAX
		LDY mul8_rl
		RTS


;generating a 16 bit table with 512 entrys where x=(x*x)/4

mul8_gensqrtab SUBROUTINE
		 LDA #1
         STA $F0
         LDA #0
         STA $F1

         LDA #0
         STA $F4
         STA $F5
         STA $F6
         STA mul8_sqrl
         STA mul8_sqrh

         LDA #<mul8_sqrh
         STA $FE
         LDA #>mul8_sqrh
         STA $FF

         LDA #<mul8_sqrl
         STA $FA
         LDA #>mul8_sqrl
         STA $FB

         LDX #$01
         LDY #$01
.ffv2

.ffv
         LDA $F0
         CLC
         ADC $F4
         STA $F4

         LDA $F1
         ADC $F5
         STA $F5

         LDA $F6
         ADC #$00
         STA $F6

         LDA $F6
         STA $B2
         LDA $F5
         STA $B1
         LDA $F4
         STA $B0

         LSR $B2
         ROR $B1
         ROR $B0

         LSR $B2
         ROR $B1
         ROR $B0

         LDA $B0
         STA ($FA),Y
         LDA $B1
         STA ($FE),Y

         LDA $F0
         CLC
         ADC #2
         STA $F0
         BCC *+4
         INC $F1


         INY
         BNE .ffv

         LDY #$00
         INC $FF
         INC $FB
         DEX
         BPL .ffv2

         RTS
         
         
         