	.text
	.globl  _min_caml_start
	.align 2
	limm	r06, _min_caml_start
	jr	r05, r06, rFF
	.text
	.align 2
testfun.48:
	halt    rff, 0
	add	r08, r08, r09
	jr	r05, r02, rFF
_min_caml_start: # main entry point
   # stack start from 16MB - 5MB (11534336)
	limm	r03, 176
	limm	r06, 16
	sll	r03, r03, r06
	limm	r06, 0
	or	r03, r03, r06
   # heap start from 16MB - 4MB (12582912)
	limm	r04, 192
	limm	r06, 16
	sll	r04, r04, r06
	limm	r06, 0
	or	r04, r04, r06
   # main program start
	limm	r08, 1
	limm	r09, 2
	or	r05, r02, rFF
	limm	r06, 4
	add	r06, r03, r06
	stw	r06, r05, rFF
	limm	r06, 8
	add	r03, r03, r06
	limm	r06, testfun.48
	or	r05, r06, rFF
	jr	r02, r05, rFF
	limm	r06, 8
	sub	r03, r03, r06
	limm	r06, 4
	add	r05, r03, r06
	ldw	r05, r05, rFF
	or	r02, r05, rFF
	or	r05, r02, rFF
	limm	r06, 4
	add	r06, r03, r06
	stw	r06, r05, rFF
	limm	r06, 8
	add	r03, r03, r06
	limm	r06, min_caml_print_int
	or	r05, r06, rFF
	jr	r02, r05, rFF
	limm	r06, 8
	sub	r03, r03, r06
	limm	r06, 4
	add	r05, r03, r06
	ldw	r05, r05, rFF
	or	r02, r05, rFF
   # main program end
	limm	r06, _min_caml_end
_min_caml_end: # infinite loop
	jr	r05, r06, rFF
