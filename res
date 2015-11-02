	.text
	.globl  _min_caml_start
	.align 2
	limm	r06, _min_caml_start
	jr	r05, r06, rFF
	.data
	.literal8
	.align 3
l.915:	 # -1.100000
	.long	-1.100000d
	.align 3
l.910:	 # 10.000000
	.long	10.000000d
	.align 3
l.907:	 # 0.000000
	.long	0.000000d
	.text
	.align 2
mul_sub.889:
	limm	r06, 65535
	limm	r05, 16
	sll	r06, r06, r05
	limm	r05, 65535
	or	r06, r06, r05
	cmp	r07, r0A, r06
	limm	r06, jreq_else.935
	jrneq	r05, r07, r06
	limm	r08, 0
	jr	r05, r02, rFF
jreq_else.935:
	limm	r0B, 1
	sll	r0B, r0B, r0A
	and	r0B, r09, r0B
	limm	r06, 0
	cmp	r07, r0B, r06
	limm	r06, jreq_else.936
	jrneq	r05, r07, r06
	limm	r06, 1
	sub	r0A, r0A, r06
	limm	r06, mul_sub.889
	jr	r05, r06, rFF
jreq_else.936:
	sll	r0B, r08, r0A
	limm	r06, 1
	sub	r0A, r0A, r06
	limm	r06, 0
	add	r05, r03, r06
	stw	r05, r0B, rFF
	or	r05, r02, rFF
	limm	r06, 4
	add	r06, r03, r06
	stw	r06, r05, rFF
	limm	r06, 8
	add	r03, r03, r06
	limm	r06, mul_sub.889
	or	r05, r06, rFF
	jr	r02, r05, rFF
	limm	r06, 8
	sub	r03, r03, r06
	limm	r06, 4
	add	r05, r03, r06
	ldw	r05, r05, rFF
	or	r02, r05, rFF
	limm	r06, 0
	add	r05, r03, r06
	ldw	r09, r05, rFF
	add	r08, r09, r08
	jr	r05, r02, rFF
mul.399:
	limm	r0A, 31
	limm	r06, mul_sub.889
	jr	r05, r06, rFF
div_sub.872:
	limm	r06, 65535
	limm	r05, 16
	sll	r06, r06, r05
	limm	r05, 65535
	or	r06, r06, r05
	cmp	r07, r0A, r06
	limm	r06, jreq_else.937
	jrneq	r05, r07, r06
	limm	r08, 0
	jr	r05, r02, rFF
jreq_else.937:
	srl	r0B, r08, r0A
	cmp	r07, r09, r0B
	limm	r06, jrle_else.938
	jrgt	r05, r07, r06
	limm	r0B, 1
	sll	r0B, r0B, r0A
	sll	r0C, r09, r0A
	sub	r08, r08, r0C
	limm	r06, 1
	sub	r0A, r0A, r06
	limm	r06, 0
	add	r05, r03, r06
	stw	r05, r0B, rFF
	or	r05, r02, rFF
	limm	r06, 4
	add	r06, r03, r06
	stw	r06, r05, rFF
	limm	r06, 8
	add	r03, r03, r06
	limm	r06, div_sub.872
	or	r05, r06, rFF
	jr	r02, r05, rFF
	limm	r06, 8
	sub	r03, r03, r06
	limm	r06, 4
	add	r05, r03, r06
	ldw	r05, r05, rFF
	or	r02, r05, rFF
	limm	r06, 0
	add	r05, r03, r06
	ldw	r09, r05, rFF
	add	r08, r09, r08
	jr	r05, r02, rFF
jrle_else.938:
	limm	r06, 1
	sub	r0A, r0A, r06
	limm	r06, div_sub.872
	jr	r05, r06, rFF
div.402:
	limm	r0A, 31
	limm	r06, div_sub.872
	jr	r05, r06, rFF
print_byte.407:
	out	r08, 0
	jr	r05, r02, rFF
print_int_sub.852:
	limm	r09, 10
	limm	r06, 10
	cmp	r07, r08, r06
	limm	r06, jrge_else.939
	jrlt	r05, r07, r06
	limm	r06, 0
	add	r05, r03, r06
	stw	r05, r09, rFF
	limm	r06, 4
	add	r05, r03, r06
	stw	r05, r08, rFF
	or	r05, r02, rFF
	limm	r06, 12
	add	r06, r03, r06
	stw	r06, r05, rFF
	limm	r06, 16
	add	r03, r03, r06
	limm	r06, div.402
	or	r05, r06, rFF
	jr	r02, r05, rFF
	limm	r06, 16
	sub	r03, r03, r06
	limm	r06, 12
	add	r05, r03, r06
	ldw	r05, r05, rFF
	or	r02, r05, rFF
	or	r05, r02, rFF
	limm	r06, 12
	add	r06, r03, r06
	stw	r06, r05, rFF
	limm	r06, 16
	add	r03, r03, r06
	limm	r06, print_int_sub.852
	or	r05, r06, rFF
	jr	r02, r05, rFF
	limm	r06, 16
	sub	r03, r03, r06
	limm	r06, 12
	add	r05, r03, r06
	ldw	r05, r05, rFF
	or	r02, r05, rFF
	limm	r06, 4
	add	r05, r03, r06
	ldw	r08, r05, rFF
	limm	r06, 0
	add	r05, r03, r06
	ldw	r09, r05, rFF
	or	r05, r02, rFF
	limm	r06, 12
	add	r06, r03, r06
	stw	r06, r05, rFF
	limm	r06, 16
	add	r03, r03, r06
	limm	r06, div.402
	or	r05, r06, rFF
	jr	r02, r05, rFF
	limm	r06, 16
	sub	r03, r03, r06
	limm	r06, 12
	add	r05, r03, r06
	ldw	r05, r05, rFF
	or	r02, r05, rFF
	limm	r06, 0
	add	r05, r03, r06
	ldw	r09, r05, rFF
	or	r05, r02, rFF
	limm	r06, 12
	add	r06, r03, r06
	stw	r06, r05, rFF
	limm	r06, 16
	add	r03, r03, r06
	limm	r06, mul.399
	or	r05, r06, rFF
	jr	r02, r05, rFF
	limm	r06, 16
	sub	r03, r03, r06
	limm	r06, 12
	add	r05, r03, r06
	ldw	r05, r05, rFF
	or	r02, r05, rFF
	limm	r06, 4
	add	r05, r03, r06
	ldw	r09, r05, rFF
	sub	r08, r09, r08
	limm	r06, 48
	add	r08, r08, r06
	limm	r06, print_byte.407
	jr	r05, r06, rFF
jrge_else.939:
	limm	r06, 48
	add	r08, r08, r06
	limm	r06, print_byte.407
	jr	r05, r06, rFF
print_int_without_null.413:
	limm	r06, 0
	cmp	r07, r08, r06
	limm	r06, jrge_else.940
	jrlt	r05, r07, r06
	limm	r06, print_int_sub.852
	jr	r05, r06, rFF
jrge_else.940:
	limm	r09, 45
	limm	r06, 0
	add	r05, r03, r06
	stw	r05, r08, rFF
	or	r05, r02, rFF
	or	r08, r09, rFF
	limm	r06, 4
	add	r06, r03, r06
	stw	r06, r05, rFF
	limm	r06, 8
	add	r03, r03, r06
	limm	r06, print_byte.407
	or	r05, r06, rFF
	jr	r02, r05, rFF
	limm	r06, 8
	sub	r03, r03, r06
	limm	r06, 4
	add	r05, r03, r06
	ldw	r05, r05, rFF
	or	r02, r05, rFF
	limm	r08, 0
	limm	r06, 0
	add	r05, r03, r06
	ldw	r09, r05, rFF
	sub	r08, r08, r09
	limm	r06, print_int_sub.852
	jr	r05, r06, rFF
int_of_float_sub.778:
	or	r08, r18, rFF
	limm	r06, 23
	srl	r08, r08, r06
	limm	r09, 255
	and	r08, r08, r09
	limm	r06, 127
	sub	r08, r08, r06
	or	r09, r18, rFF
	limm	r0A, 128
	limm	r05, 16
	sll	r0A, r0A, r05
	limm	r05, 0
	or	r0A, r0A, r05
	or	r09, r09, r0A
	limm	r0A, 255
	limm	r05, 16
	sll	r0A, r0A, r05
	limm	r05, 65535
	or	r0A, r0A, r05
	and	r09, r09, r0A
	limm	r0A, 23
	sub	r08, r0A, r08
	srl	r08, r09, r08
	or	r09, r18, rFF
	limm	r0A, 32768
	limm	r05, 16
	sll	r0A, r0A, r05
	limm	r05, 0
	or	r0A, r0A, r05
	and	r09, r09, r0A
	or	r08, r08, r09
	jr	r05, r02, rFF
int_of_float.427:
	limm	r06, l.907
	ldw	r19, r06, rFF
	fcmp	r07, r19, r18
	limm	r06, jrle_else.941
	jrgt	r05, r07, r06
	limm	r06, int_of_float_sub.778
	jr	r05, r06, rFF
jrle_else.941:
	limm	r19, 32768
	limm	r05, 16
	sll	r19, r19, r05
	limm	r05, 0
	or	r19, r19, r05
	xor	r18, r18, r19
	or	r05, r02, rFF
	limm	r06, 4
	add	r06, r03, r06
	stw	r06, r05, rFF
	limm	r06, 8
	add	r03, r03, r06
	limm	r06, int_of_float_sub.778
	or	r05, r06, rFF
	jr	r02, r05, rFF
	limm	r06, 8
	sub	r03, r03, r06
	limm	r06, 4
	add	r05, r03, r06
	ldw	r05, r05, rFF
	or	r02, r05, rFF
	limm	r09, 0
	sub	r08, r09, r08
	jr	r05, r02, rFF
search_top.752:
	limm	r06, 1
	cmp	r07, r08, r06
	limm	r06, jreq_else.942
	jrneq	r05, r07, r06
	limm	r08, 0
	jr	r05, r02, rFF
jreq_else.942:
	limm	r06, 1
	srl	r08, r08, r06
	or	r05, r02, rFF
	limm	r06, 4
	add	r06, r03, r06
	stw	r06, r05, rFF
	limm	r06, 8
	add	r03, r03, r06
	limm	r06, search_top.752
	or	r05, r06, rFF
	jr	r02, r05, rFF
	limm	r06, 8
	sub	r03, r03, r06
	limm	r06, 4
	add	r05, r03, r06
	ldw	r05, r05, rFF
	or	r02, r05, rFF
	limm	r06, 1
	add	r08, r08, r06
	jr	r05, r02, rFF
float_of_int.431:
	limm	r09, 0
	limm	r06, 0
	cmp	r07, r08, r06
	limm	r06, jreq_else.943
	jrneq	r05, r07, r06
	or	r18, r09, rFF
	jr	r05, r02, rFF
jreq_else.943:
	limm	r06, 0
	cmp	r07, r08, r06
	limm	r06, jrle_else.944
	jrgt	r05, r07, r06
	limm	r09, 1
	limm	r06, jrle_cont.945
	jr	r05, r06, rFF
jrle_else.944:
	limm	r09, 0
jrle_cont.945:
	limm	r06, 0
	add	r05, r03, r06
	stw	r05, r08, rFF
	limm	r06, 4
	add	r05, r03, r06
	stw	r05, r09, rFF
	or	r05, r02, rFF
	limm	r06, 12
	add	r06, r03, r06
	stw	r06, r05, rFF
	limm	r06, 16
	add	r03, r03, r06
	limm	r06, search_top.752
	or	r05, r06, rFF
	jr	r02, r05, rFF
	limm	r06, 16
	sub	r03, r03, r06
	limm	r06, 12
	add	r05, r03, r06
	ldw	r05, r05, rFF
	or	r02, r05, rFF
	limm	r06, 4
	add	r05, r03, r06
	ldw	r09, r05, rFF
	limm	r06, 31
	sll	r09, r09, r06
	limm	r06, 127
	add	r0A, r08, r06
	limm	r06, 23
	sll	r0A, r0A, r06
	add	r09, r09, r0A
	limm	r0A, 1
	sll	r0A, r0A, r08
	limm	r06, 0
	add	r05, r03, r06
	ldw	r0B, r05, rFF
	xor	r0A, r0B, r0A
	limm	r0B, 23
	sub	r08, r0B, r08
	sll	r08, r0A, r08
	add	r08, r09, r08
	or	r18, r08, rFF
	jr	r05, r02, rFF
print_float_sub.732:
	limm	r06, l.907
	ldw	r19, r06, rFF
	fcmp	r07, r18, r19
	limm	r06, jreq_else.946
	jrneq	r05, r07, r06
	limm	r08, 48
	limm	r06, print_byte.407
	jr	r05, r06, rFF
jreq_else.946:
	limm	r06, l.910
	ldw	r19, r06, rFF
	fmul	r18, r18, r19
	limm	r06, 0
	add	r05, r03, r06
	stw	r05, r18, rFF
	or	r05, r02, rFF
	limm	r06, 4
	add	r06, r03, r06
	stw	r06, r05, rFF
	limm	r06, 8
	add	r03, r03, r06
	limm	r06, int_of_float.427
	or	r05, r06, rFF
	jr	r02, r05, rFF
	limm	r06, 8
	sub	r03, r03, r06
	limm	r06, 4
	add	r05, r03, r06
	ldw	r05, r05, rFF
	or	r02, r05, rFF
	limm	r06, 48
	add	r09, r08, r06
	limm	r06, 4
	add	r05, r03, r06
	stw	r05, r08, rFF
	or	r05, r02, rFF
	or	r08, r09, rFF
	limm	r06, 12
	add	r06, r03, r06
	stw	r06, r05, rFF
	limm	r06, 16
	add	r03, r03, r06
	limm	r06, print_byte.407
	or	r05, r06, rFF
	jr	r02, r05, rFF
	limm	r06, 16
	sub	r03, r03, r06
	limm	r06, 12
	add	r05, r03, r06
	ldw	r05, r05, rFF
	or	r02, r05, rFF
	limm	r06, 4
	add	r05, r03, r06
	ldw	r08, r05, rFF
	or	r05, r02, rFF
	limm	r06, 12
	add	r06, r03, r06
	stw	r06, r05, rFF
	limm	r06, 16
	add	r03, r03, r06
	limm	r06, float_of_int.431
	or	r05, r06, rFF
	jr	r02, r05, rFF
	limm	r06, 16
	sub	r03, r03, r06
	limm	r06, 12
	add	r05, r03, r06
	ldw	r05, r05, rFF
	or	r02, r05, rFF
	limm	r19, 32768
	limm	r05, 16
	sll	r19, r19, r05
	limm	r05, 0
	or	r19, r19, r05
	xor	r18, r18, r19
	limm	r06, 0
	add	r05, r03, r06
	ldw	r19, r05, rFF
	fadd	r18, r19, r18
	limm	r06, print_float_sub.732
	jr	r05, r06, rFF
print_float.433:
	limm	r06, 0
	add	r05, r03, r06
	stw	r05, r18, rFF
	or	r05, r02, rFF
	limm	r06, 4
	add	r06, r03, r06
	stw	r06, r05, rFF
	limm	r06, 8
	add	r03, r03, r06
	limm	r06, int_of_float.427
	or	r05, r06, rFF
	jr	r02, r05, rFF
	limm	r06, 8
	sub	r03, r03, r06
	limm	r06, 4
	add	r05, r03, r06
	ldw	r05, r05, rFF
	or	r02, r05, rFF
	limm	r06, 4
	add	r05, r03, r06
	stw	r05, r08, rFF
	or	r05, r02, rFF
	limm	r06, 12
	add	r06, r03, r06
	stw	r06, r05, rFF
	limm	r06, 16
	add	r03, r03, r06
	limm	r06, print_int_without_null.413
	or	r05, r06, rFF
	jr	r02, r05, rFF
	limm	r06, 16
	sub	r03, r03, r06
	limm	r06, 12
	add	r05, r03, r06
	ldw	r05, r05, rFF
	or	r02, r05, rFF
	limm	r08, 46
	or	r05, r02, rFF
	limm	r06, 12
	add	r06, r03, r06
	stw	r06, r05, rFF
	limm	r06, 16
	add	r03, r03, r06
	limm	r06, print_byte.407
	or	r05, r06, rFF
	jr	r02, r05, rFF
	limm	r06, 16
	sub	r03, r03, r06
	limm	r06, 12
	add	r05, r03, r06
	ldw	r05, r05, rFF
	or	r02, r05, rFF
	limm	r06, 4
	add	r05, r03, r06
	ldw	r08, r05, rFF
	or	r05, r02, rFF
	limm	r06, 12
	add	r06, r03, r06
	stw	r06, r05, rFF
	limm	r06, 16
	add	r03, r03, r06
	limm	r06, float_of_int.431
	or	r05, r06, rFF
	jr	r02, r05, rFF
	limm	r06, 16
	sub	r03, r03, r06
	limm	r06, 12
	add	r05, r03, r06
	ldw	r05, r05, rFF
	or	r02, r05, rFF
	limm	r19, 32768
	limm	r05, 16
	sll	r19, r19, r05
	limm	r05, 0
	or	r19, r19, r05
	xor	r18, r18, r19
	limm	r06, 0
	add	r05, r03, r06
	ldw	r19, r05, rFF
	fadd	r18, r19, r18
	or	r05, r02, rFF
	limm	r06, 12
	add	r06, r03, r06
	stw	r06, r05, rFF
	limm	r06, 16
	add	r03, r03, r06
	limm	r06, print_float_sub.732
	or	r05, r06, rFF
	jr	r02, r05, rFF
	limm	r06, 16
	sub	r03, r03, r06
	limm	r06, 12
	add	r05, r03, r06
	ldw	r05, r05, rFF
	or	r02, r05, rFF
	limm	r08, 0
	limm	r06, print_byte.407
	jr	r05, r06, rFF
_min_caml_start: # main entry point
   # stack start from 16MB - 5MB (11534336)
	limm	r03, 176
	limm	r05, 16
	sll	r03, r03, r05
	limm	r05, 0
	or	r03, r03, r05
   # heap start from 16MB - 4MB (12582912)
	limm	r04, 192
	limm	r05, 16
	sll	r04, r04, r05
	limm	r05, 0
	or	r04, r04, r05
   # main program start
	limm	r06, l.915
	ldw	r18, r06, rFF
	or	r05, r02, rFF
	limm	r06, 4
	add	r06, r03, r06
	stw	r06, r05, rFF
	limm	r06, 8
	add	r03, r03, r06
	limm	r06, print_float.433
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
