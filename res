	.text
	.globl  _min_caml_start
	.align 2
	limm	r06, _min_caml_start
	jr	r05, r06, rFF
	.data
	.literal8
	.align 3
l.1271:	 # 1000000000.000000
	.long	1000000000.000000d
	.align 3
l.1269:	 # 255.000000
	.long	255.000000d
	.align 3
l.1256:	 # 0.000000
	.long	0.000000d
	.text
	.align 2
mul_sub.1228:
	limm	r06, 65535
	limm	r05, 16
	sll	r06, r06, r05
	limm	r05, 65535
	or	r06, r06, r05
	cmp	r07, r0A, r06
	limm	r06, jreq_else.1309
	jrneq	r05, r07, r06
	limm	r08, 0
	jr	r05, r02, rFF
jreq_else.1309:
	limm	r0B, 1
	sll	r0B, r0B, r0A
	and	r0B, r09, r0B
	limm	r06, 0
	cmp	r07, r0B, r06
	limm	r06, jreq_else.1310
	jrneq	r05, r07, r06
	limm	r06, 1
	sub	r0A, r0A, r06
	limm	r06, mul_sub.1228
	jr	r05, r06, rFF
jreq_else.1310:
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
	limm	r06, mul_sub.1228
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
mul.563:
	limm	r0A, 30
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
	limm	r06, mul_sub.1228
	or	r05, r06, rFF
	jr	r02, r05, rFF
	limm	r06, 16
	sub	r03, r03, r06
	limm	r06, 12
	add	r05, r03, r06
	ldw	r05, r05, rFF
	or	r02, r05, rFF
	limm	r09, 32767
	limm	r05, 16
	sll	r09, r09, r05
	limm	r05, 65535
	or	r09, r09, r05
	and	r08, r08, r09
	limm	r09, 32768
	limm	r05, 16
	sll	r09, r09, r05
	limm	r05, 0
	or	r09, r09, r05
	limm	r06, 4
	add	r05, r03, r06
	ldw	r0A, r05, rFF
	and	r09, r0A, r09
	limm	r0A, 32768
	limm	r05, 16
	sll	r0A, r0A, r05
	limm	r05, 0
	or	r0A, r0A, r05
	limm	r06, 0
	add	r05, r03, r06
	ldw	r0B, r05, rFF
	and	r0A, r0B, r0A
	xor	r09, r09, r0A
	or	r08, r08, r09
	jr	r05, r02, rFF
div_sub.1203:
	limm	r06, 65535
	limm	r05, 16
	sll	r06, r06, r05
	limm	r05, 65535
	or	r06, r06, r05
	cmp	r07, r0A, r06
	limm	r06, jreq_else.1311
	jrneq	r05, r07, r06
	limm	r08, 0
	jr	r05, r02, rFF
jreq_else.1311:
	srl	r0B, r08, r0A
	cmp	r07, r09, r0B
	limm	r06, jrle_else.1312
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
	limm	r06, div_sub.1203
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
jrle_else.1312:
	limm	r06, 1
	sub	r0A, r0A, r06
	limm	r06, div_sub.1203
	jr	r05, r06, rFF
div.566:
	limm	r0A, 30
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
	limm	r06, div_sub.1203
	or	r05, r06, rFF
	jr	r02, r05, rFF
	limm	r06, 16
	sub	r03, r03, r06
	limm	r06, 12
	add	r05, r03, r06
	ldw	r05, r05, rFF
	or	r02, r05, rFF
	limm	r09, 32767
	limm	r05, 16
	sll	r09, r09, r05
	limm	r05, 65535
	or	r09, r09, r05
	and	r08, r08, r09
	limm	r09, 32768
	limm	r05, 16
	sll	r09, r09, r05
	limm	r05, 0
	or	r09, r09, r05
	limm	r06, 4
	add	r05, r03, r06
	ldw	r0A, r05, rFF
	and	r09, r0A, r09
	limm	r0A, 32768
	limm	r05, 16
	sll	r0A, r0A, r05
	limm	r05, 0
	or	r0A, r0A, r05
	limm	r06, 0
	add	r05, r03, r06
	ldw	r0B, r05, rFF
	and	r0A, r0B, r0A
	xor	r09, r09, r0A
	or	r08, r08, r09
	jr	r05, r02, rFF
print_byte.571:
	out	r08, 0
	jr	r05, r02, rFF
print_int_sub.1183:
	limm	r09, 10
	limm	r06, 10
	cmp	r07, r08, r06
	limm	r06, jrge_else.1313
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
	limm	r06, div.566
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
	limm	r06, print_int_sub.1183
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
	limm	r06, div.566
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
	limm	r06, mul.563
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
	limm	r06, print_byte.571
	jr	r05, r06, rFF
jrge_else.1313:
	limm	r06, 48
	add	r08, r08, r06
	limm	r06, print_byte.571
	jr	r05, r06, rFF
print_int_without_null.577:
	limm	r06, 0
	cmp	r07, r08, r06
	limm	r06, jrge_else.1314
	jrlt	r05, r07, r06
	limm	r06, print_int_sub.1183
	jr	r05, r06, rFF
jrge_else.1314:
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
	limm	r06, print_byte.571
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
	limm	r06, print_int_sub.1183
	jr	r05, r06, rFF
print_int.579:
	or	r05, r02, rFF
	limm	r06, 4
	add	r06, r03, r06
	stw	r06, r05, rFF
	limm	r06, 8
	add	r03, r03, r06
	limm	r06, print_int_without_null.577
	or	r05, r06, rFF
	jr	r02, r05, rFF
	limm	r06, 8
	sub	r03, r03, r06
	limm	r06, 4
	add	r05, r03, r06
	ldw	r05, r05, rFF
	or	r02, r05, rFF
	limm	r08, 0
	limm	r06, print_byte.571
	jr	r05, r06, rFF
create_array_sub.797:
	limm	r06, 0
	cmp	r07, r08, r06
	limm	r06, jreq_else.1315
	jrneq	r05, r07, r06
	jr	r05, r02, rFF
jreq_else.1315:
	or	r0A, r04, rFF
	or	r0A, r0A, rFF
	limm	r06, 0
	add	r06, r0A, r06
	stw	r06, r09, rFF
	limm	r06, 1
	sub	r08, r08, r06
	limm	r06, create_array_sub.797
	jr	r05, r06, rFF
create_array_base.633:
	or	r0A, r04, rFF
	limm	r06, 0
	add	r05, r03, r06
	stw	r05, r0A, rFF
	or	r05, r02, rFF
	limm	r06, 4
	add	r06, r03, r06
	stw	r06, r05, rFF
	limm	r06, 8
	add	r03, r03, r06
	limm	r06, create_array_sub.797
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
	ldw	r08, r05, rFF
	jr	r05, r02, rFF
create_array_sub.777:
	limm	r06, 0
	cmp	r07, r08, r06
	limm	r06, jreq_else.1317
	jrneq	r05, r07, r06
	jr	r05, r02, rFF
jreq_else.1317:
	or	r09, r04, rFF
	or	r09, r09, rFF
	or	r0A, r18, rFF
	limm	r06, 0
	add	r06, r09, r06
	stw	r06, r0A, rFF
	limm	r06, 1
	sub	r08, r08, r06
	limm	r06, create_array_sub.777
	jr	r05, r06, rFF
create_float_array_base.636:
	or	r09, r04, rFF
	limm	r06, 0
	add	r05, r03, r06
	stw	r05, r09, rFF
	or	r05, r02, rFF
	limm	r06, 4
	add	r06, r03, r06
	stw	r06, r05, rFF
	limm	r06, 8
	add	r03, r03, r06
	limm	r06, create_array_sub.777
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
	ldw	r08, r05, rFF
	jr	r05, r02, rFF
fib.764:
	limm	r06, 1
	cmp	r07, r08, r06
	limm	r06, jrle_else.1319
	jrgt	r05, r07, r06
	jr	r05, r02, rFF
jrle_else.1319:
	limm	r06, 1
	sub	r09, r08, r06
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
	limm	r06, fib.764
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
	limm	r06, 2
	sub	r09, r09, r06
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
	limm	r06, fib.764
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
	add	r08, r09, r08
	jr	r05, r02, rFF
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
	limm	r08, 1
	limm	r09, 0
	or	r05, r02, rFF
	limm	r06, 4
	add	r06, r03, r06
	stw	r06, r05, rFF
	limm	r06, 8
	add	r03, r03, r06
	limm	r06, create_array_base.633
	or	r05, r06, rFF
	jr	r02, r05, rFF
	limm	r06, 8
	sub	r03, r03, r06
	limm	r06, 4
	add	r05, r03, r06
	ldw	r05, r05, rFF
	or	r02, r05, rFF
	limm	r08, 0
	limm	r06, l.1256
	ldw	r18, r06, rFF
	or	r05, r02, rFF
	limm	r06, 4
	add	r06, r03, r06
	stw	r06, r05, rFF
	limm	r06, 8
	add	r03, r03, r06
	limm	r06, create_float_array_base.636
	or	r05, r06, rFF
	jr	r02, r05, rFF
	limm	r06, 8
	sub	r03, r03, r06
	limm	r06, 4
	add	r05, r03, r06
	ldw	r05, r05, rFF
	or	r02, r05, rFF
	limm	r09, 60
	limm	r0A, 0
	or	r0B, r04, rFF
	limm	r06, 48
	add	r04, r04, r06
	limm	r06, 40
	add	r06, r0B, r06
	stw	r06, r08, rFF
	limm	r06, 36
	add	r06, r0B, r06
	stw	r06, r08, rFF
	limm	r06, 32
	add	r06, r0B, r06
	stw	r06, r08, rFF
	limm	r06, 28
	add	r06, r0B, r06
	stw	r06, r08, rFF
	limm	r06, 24
	add	r06, r0B, r06
	stw	r06, r0A, rFF
	limm	r06, 20
	add	r06, r0B, r06
	stw	r06, r08, rFF
	limm	r06, 16
	add	r06, r0B, r06
	stw	r06, r08, rFF
	limm	r06, 12
	add	r06, r0B, r06
	stw	r06, r0A, rFF
	limm	r06, 8
	add	r06, r0B, r06
	stw	r06, r0A, rFF
	limm	r06, 4
	add	r06, r0B, r06
	stw	r06, r0A, rFF
	limm	r06, 0
	add	r06, r0B, r06
	stw	r06, r0A, rFF
	or	r08, r0B, rFF
	or	r05, r02, rFF
	or	r16, r09, rFF
	or	r09, r08, rFF
	or	r08, r16, rFF
	limm	r06, 4
	add	r06, r03, r06
	stw	r06, r05, rFF
	limm	r06, 8
	add	r03, r03, r06
	limm	r06, create_array_base.633
	or	r05, r06, rFF
	jr	r02, r05, rFF
	limm	r06, 8
	sub	r03, r03, r06
	limm	r06, 4
	add	r05, r03, r06
	ldw	r05, r05, rFF
	or	r02, r05, rFF
	limm	r08, 3
	limm	r06, l.1256
	ldw	r18, r06, rFF
	or	r05, r02, rFF
	limm	r06, 4
	add	r06, r03, r06
	stw	r06, r05, rFF
	limm	r06, 8
	add	r03, r03, r06
	limm	r06, create_float_array_base.636
	or	r05, r06, rFF
	jr	r02, r05, rFF
	limm	r06, 8
	sub	r03, r03, r06
	limm	r06, 4
	add	r05, r03, r06
	ldw	r05, r05, rFF
	or	r02, r05, rFF
	limm	r08, 3
	limm	r06, l.1256
	ldw	r18, r06, rFF
	or	r05, r02, rFF
	limm	r06, 4
	add	r06, r03, r06
	stw	r06, r05, rFF
	limm	r06, 8
	add	r03, r03, r06
	limm	r06, create_float_array_base.636
	or	r05, r06, rFF
	jr	r02, r05, rFF
	limm	r06, 8
	sub	r03, r03, r06
	limm	r06, 4
	add	r05, r03, r06
	ldw	r05, r05, rFF
	or	r02, r05, rFF
	limm	r08, 3
	limm	r06, l.1256
	ldw	r18, r06, rFF
	or	r05, r02, rFF
	limm	r06, 4
	add	r06, r03, r06
	stw	r06, r05, rFF
	limm	r06, 8
	add	r03, r03, r06
	limm	r06, create_float_array_base.636
	or	r05, r06, rFF
	jr	r02, r05, rFF
	limm	r06, 8
	sub	r03, r03, r06
	limm	r06, 4
	add	r05, r03, r06
	ldw	r05, r05, rFF
	or	r02, r05, rFF
	limm	r08, 1
	limm	r06, l.1269
	ldw	r18, r06, rFF
	or	r05, r02, rFF
	limm	r06, 4
	add	r06, r03, r06
	stw	r06, r05, rFF
	limm	r06, 8
	add	r03, r03, r06
	limm	r06, create_float_array_base.636
	or	r05, r06, rFF
	jr	r02, r05, rFF
	limm	r06, 8
	sub	r03, r03, r06
	limm	r06, 4
	add	r05, r03, r06
	ldw	r05, r05, rFF
	or	r02, r05, rFF
	limm	r08, 50
	limm	r09, 1
	limm	r0A, 65535
	limm	r05, 16
	sll	r0A, r0A, r05
	limm	r05, 65535
	or	r0A, r0A, r05
	limm	r06, 0
	add	r05, r03, r06
	stw	r05, r08, rFF
	or	r05, r02, rFF
	or	r08, r09, rFF
	or	r09, r0A, rFF
	limm	r06, 4
	add	r06, r03, r06
	stw	r06, r05, rFF
	limm	r06, 8
	add	r03, r03, r06
	limm	r06, create_array_base.633
	or	r05, r06, rFF
	jr	r02, r05, rFF
	limm	r06, 8
	sub	r03, r03, r06
	limm	r06, 4
	add	r05, r03, r06
	ldw	r05, r05, rFF
	or	r09, r08, rFF
	or	r02, r05, rFF
	limm	r06, 0
	add	r05, r03, r06
	ldw	r08, r05, rFF
	or	r05, r02, rFF
	limm	r06, 4
	add	r06, r03, r06
	stw	r06, r05, rFF
	limm	r06, 8
	add	r03, r03, r06
	limm	r06, create_array_base.633
	or	r05, r06, rFF
	jr	r02, r05, rFF
	limm	r06, 8
	sub	r03, r03, r06
	limm	r06, 4
	add	r05, r03, r06
	ldw	r05, r05, rFF
	or	r02, r05, rFF
	limm	r09, 1
	limm	r06, 0
	add	r06, r08, r06
	ldw	r08, r06, rFF
	limm	r06, 4
	add	r05, r03, r06
	stw	r05, r09, rFF
	or	r05, r02, rFF
	or	r16, r09, rFF
	or	r09, r08, rFF
	or	r08, r16, rFF
	limm	r06, 12
	add	r06, r03, r06
	stw	r06, r05, rFF
	limm	r06, 16
	add	r03, r03, r06
	limm	r06, create_array_base.633
	or	r05, r06, rFF
	jr	r02, r05, rFF
	limm	r06, 16
	sub	r03, r03, r06
	limm	r06, 12
	add	r05, r03, r06
	ldw	r05, r05, rFF
	or	r09, r08, rFF
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
	limm	r06, create_array_base.633
	or	r05, r06, rFF
	jr	r02, r05, rFF
	limm	r06, 16
	sub	r03, r03, r06
	limm	r06, 12
	add	r05, r03, r06
	ldw	r05, r05, rFF
	or	r02, r05, rFF
	limm	r08, 1
	limm	r06, l.1256
	ldw	r18, r06, rFF
	or	r05, r02, rFF
	limm	r06, 12
	add	r06, r03, r06
	stw	r06, r05, rFF
	limm	r06, 16
	add	r03, r03, r06
	limm	r06, create_float_array_base.636
	or	r05, r06, rFF
	jr	r02, r05, rFF
	limm	r06, 16
	sub	r03, r03, r06
	limm	r06, 12
	add	r05, r03, r06
	ldw	r05, r05, rFF
	or	r02, r05, rFF
	limm	r08, 1
	limm	r09, 0
	or	r05, r02, rFF
	limm	r06, 12
	add	r06, r03, r06
	stw	r06, r05, rFF
	limm	r06, 16
	add	r03, r03, r06
	limm	r06, create_array_base.633
	or	r05, r06, rFF
	jr	r02, r05, rFF
	limm	r06, 16
	sub	r03, r03, r06
	limm	r06, 12
	add	r05, r03, r06
	ldw	r05, r05, rFF
	or	r02, r05, rFF
	limm	r08, 1
	limm	r06, l.1271
	ldw	r18, r06, rFF
	or	r05, r02, rFF
	limm	r06, 12
	add	r06, r03, r06
	stw	r06, r05, rFF
	limm	r06, 16
	add	r03, r03, r06
	limm	r06, create_float_array_base.636
	or	r05, r06, rFF
	jr	r02, r05, rFF
	limm	r06, 16
	sub	r03, r03, r06
	limm	r06, 12
	add	r05, r03, r06
	ldw	r05, r05, rFF
	or	r02, r05, rFF
	limm	r08, 3
	limm	r06, l.1256
	ldw	r18, r06, rFF
	or	r05, r02, rFF
	limm	r06, 12
	add	r06, r03, r06
	stw	r06, r05, rFF
	limm	r06, 16
	add	r03, r03, r06
	limm	r06, create_float_array_base.636
	or	r05, r06, rFF
	jr	r02, r05, rFF
	limm	r06, 16
	sub	r03, r03, r06
	limm	r06, 12
	add	r05, r03, r06
	ldw	r05, r05, rFF
	or	r02, r05, rFF
	limm	r08, 1
	limm	r09, 0
	or	r05, r02, rFF
	limm	r06, 12
	add	r06, r03, r06
	stw	r06, r05, rFF
	limm	r06, 16
	add	r03, r03, r06
	limm	r06, create_array_base.633
	or	r05, r06, rFF
	jr	r02, r05, rFF
	limm	r06, 16
	sub	r03, r03, r06
	limm	r06, 12
	add	r05, r03, r06
	ldw	r05, r05, rFF
	or	r02, r05, rFF
	limm	r08, 3
	limm	r06, l.1256
	ldw	r18, r06, rFF
	or	r05, r02, rFF
	limm	r06, 12
	add	r06, r03, r06
	stw	r06, r05, rFF
	limm	r06, 16
	add	r03, r03, r06
	limm	r06, create_float_array_base.636
	or	r05, r06, rFF
	jr	r02, r05, rFF
	limm	r06, 16
	sub	r03, r03, r06
	limm	r06, 12
	add	r05, r03, r06
	ldw	r05, r05, rFF
	or	r02, r05, rFF
	limm	r08, 3
	limm	r06, l.1256
	ldw	r18, r06, rFF
	or	r05, r02, rFF
	limm	r06, 12
	add	r06, r03, r06
	stw	r06, r05, rFF
	limm	r06, 16
	add	r03, r03, r06
	limm	r06, create_float_array_base.636
	or	r05, r06, rFF
	jr	r02, r05, rFF
	limm	r06, 16
	sub	r03, r03, r06
	limm	r06, 12
	add	r05, r03, r06
	ldw	r05, r05, rFF
	or	r02, r05, rFF
	limm	r08, 3
	limm	r06, l.1256
	ldw	r18, r06, rFF
	or	r05, r02, rFF
	limm	r06, 12
	add	r06, r03, r06
	stw	r06, r05, rFF
	limm	r06, 16
	add	r03, r03, r06
	limm	r06, create_float_array_base.636
	or	r05, r06, rFF
	jr	r02, r05, rFF
	limm	r06, 16
	sub	r03, r03, r06
	limm	r06, 12
	add	r05, r03, r06
	ldw	r05, r05, rFF
	or	r02, r05, rFF
	limm	r08, 3
	limm	r06, l.1256
	ldw	r18, r06, rFF
	or	r05, r02, rFF
	limm	r06, 12
	add	r06, r03, r06
	stw	r06, r05, rFF
	limm	r06, 16
	add	r03, r03, r06
	limm	r06, create_float_array_base.636
	or	r05, r06, rFF
	jr	r02, r05, rFF
	limm	r06, 16
	sub	r03, r03, r06
	limm	r06, 12
	add	r05, r03, r06
	ldw	r05, r05, rFF
	or	r02, r05, rFF
	limm	r08, 2
	limm	r09, 0
	or	r05, r02, rFF
	limm	r06, 12
	add	r06, r03, r06
	stw	r06, r05, rFF
	limm	r06, 16
	add	r03, r03, r06
	limm	r06, create_array_base.633
	or	r05, r06, rFF
	jr	r02, r05, rFF
	limm	r06, 16
	sub	r03, r03, r06
	limm	r06, 12
	add	r05, r03, r06
	ldw	r05, r05, rFF
	or	r02, r05, rFF
	limm	r08, 2
	limm	r09, 0
	or	r05, r02, rFF
	limm	r06, 12
	add	r06, r03, r06
	stw	r06, r05, rFF
	limm	r06, 16
	add	r03, r03, r06
	limm	r06, create_array_base.633
	or	r05, r06, rFF
	jr	r02, r05, rFF
	limm	r06, 16
	sub	r03, r03, r06
	limm	r06, 12
	add	r05, r03, r06
	ldw	r05, r05, rFF
	or	r02, r05, rFF
	limm	r08, 1
	limm	r06, l.1256
	ldw	r18, r06, rFF
	or	r05, r02, rFF
	limm	r06, 12
	add	r06, r03, r06
	stw	r06, r05, rFF
	limm	r06, 16
	add	r03, r03, r06
	limm	r06, create_float_array_base.636
	or	r05, r06, rFF
	jr	r02, r05, rFF
	limm	r06, 16
	sub	r03, r03, r06
	limm	r06, 12
	add	r05, r03, r06
	ldw	r05, r05, rFF
	or	r02, r05, rFF
	limm	r08, 3
	limm	r06, l.1256
	ldw	r18, r06, rFF
	or	r05, r02, rFF
	limm	r06, 12
	add	r06, r03, r06
	stw	r06, r05, rFF
	limm	r06, 16
	add	r03, r03, r06
	limm	r06, create_float_array_base.636
	or	r05, r06, rFF
	jr	r02, r05, rFF
	limm	r06, 16
	sub	r03, r03, r06
	limm	r06, 12
	add	r05, r03, r06
	ldw	r05, r05, rFF
	or	r02, r05, rFF
	limm	r08, 3
	limm	r06, l.1256
	ldw	r18, r06, rFF
	or	r05, r02, rFF
	limm	r06, 12
	add	r06, r03, r06
	stw	r06, r05, rFF
	limm	r06, 16
	add	r03, r03, r06
	limm	r06, create_float_array_base.636
	or	r05, r06, rFF
	jr	r02, r05, rFF
	limm	r06, 16
	sub	r03, r03, r06
	limm	r06, 12
	add	r05, r03, r06
	ldw	r05, r05, rFF
	or	r02, r05, rFF
	limm	r08, 3
	limm	r06, l.1256
	ldw	r18, r06, rFF
	or	r05, r02, rFF
	limm	r06, 12
	add	r06, r03, r06
	stw	r06, r05, rFF
	limm	r06, 16
	add	r03, r03, r06
	limm	r06, create_float_array_base.636
	or	r05, r06, rFF
	jr	r02, r05, rFF
	limm	r06, 16
	sub	r03, r03, r06
	limm	r06, 12
	add	r05, r03, r06
	ldw	r05, r05, rFF
	or	r02, r05, rFF
	limm	r08, 3
	limm	r06, l.1256
	ldw	r18, r06, rFF
	or	r05, r02, rFF
	limm	r06, 12
	add	r06, r03, r06
	stw	r06, r05, rFF
	limm	r06, 16
	add	r03, r03, r06
	limm	r06, create_float_array_base.636
	or	r05, r06, rFF
	jr	r02, r05, rFF
	limm	r06, 16
	sub	r03, r03, r06
	limm	r06, 12
	add	r05, r03, r06
	ldw	r05, r05, rFF
	or	r02, r05, rFF
	limm	r08, 3
	limm	r06, l.1256
	ldw	r18, r06, rFF
	or	r05, r02, rFF
	limm	r06, 12
	add	r06, r03, r06
	stw	r06, r05, rFF
	limm	r06, 16
	add	r03, r03, r06
	limm	r06, create_float_array_base.636
	or	r05, r06, rFF
	jr	r02, r05, rFF
	limm	r06, 16
	sub	r03, r03, r06
	limm	r06, 12
	add	r05, r03, r06
	ldw	r05, r05, rFF
	or	r02, r05, rFF
	limm	r08, 3
	limm	r06, l.1256
	ldw	r18, r06, rFF
	or	r05, r02, rFF
	limm	r06, 12
	add	r06, r03, r06
	stw	r06, r05, rFF
	limm	r06, 16
	add	r03, r03, r06
	limm	r06, create_float_array_base.636
	or	r05, r06, rFF
	jr	r02, r05, rFF
	limm	r06, 16
	sub	r03, r03, r06
	limm	r06, 12
	add	r05, r03, r06
	ldw	r05, r05, rFF
	or	r02, r05, rFF
	limm	r08, 0
	limm	r06, l.1256
	ldw	r18, r06, rFF
	or	r05, r02, rFF
	limm	r06, 12
	add	r06, r03, r06
	stw	r06, r05, rFF
	limm	r06, 16
	add	r03, r03, r06
	limm	r06, create_float_array_base.636
	or	r05, r06, rFF
	jr	r02, r05, rFF
	limm	r06, 16
	sub	r03, r03, r06
	limm	r06, 12
	add	r05, r03, r06
	ldw	r05, r05, rFF
	or	r09, r08, rFF
	or	r02, r05, rFF
	limm	r08, 0
	limm	r06, 8
	add	r05, r03, r06
	stw	r05, r09, rFF
	or	r05, r02, rFF
	limm	r06, 12
	add	r06, r03, r06
	stw	r06, r05, rFF
	limm	r06, 16
	add	r03, r03, r06
	limm	r06, create_array_base.633
	or	r05, r06, rFF
	jr	r02, r05, rFF
	limm	r06, 16
	sub	r03, r03, r06
	limm	r06, 12
	add	r05, r03, r06
	ldw	r05, r05, rFF
	or	r02, r05, rFF
	limm	r09, 0
	or	r0A, r04, rFF
	limm	r06, 8
	add	r04, r04, r06
	limm	r06, 4
	add	r06, r0A, r06
	stw	r06, r08, rFF
	limm	r06, 8
	add	r05, r03, r06
	ldw	r08, r05, rFF
	limm	r06, 0
	add	r06, r0A, r06
	stw	r06, r08, rFF
	or	r08, r0A, rFF
	or	r05, r02, rFF
	or	r16, r09, rFF
	or	r09, r08, rFF
	or	r08, r16, rFF
	limm	r06, 12
	add	r06, r03, r06
	stw	r06, r05, rFF
	limm	r06, 16
	add	r03, r03, r06
	limm	r06, create_array_base.633
	or	r05, r06, rFF
	jr	r02, r05, rFF
	limm	r06, 16
	sub	r03, r03, r06
	limm	r06, 12
	add	r05, r03, r06
	ldw	r05, r05, rFF
	or	r09, r08, rFF
	or	r02, r05, rFF
	limm	r08, 5
	or	r05, r02, rFF
	limm	r06, 12
	add	r06, r03, r06
	stw	r06, r05, rFF
	limm	r06, 16
	add	r03, r03, r06
	limm	r06, create_array_base.633
	or	r05, r06, rFF
	jr	r02, r05, rFF
	limm	r06, 16
	sub	r03, r03, r06
	limm	r06, 12
	add	r05, r03, r06
	ldw	r05, r05, rFF
	or	r02, r05, rFF
	limm	r08, 0
	limm	r06, l.1256
	ldw	r18, r06, rFF
	or	r05, r02, rFF
	limm	r06, 12
	add	r06, r03, r06
	stw	r06, r05, rFF
	limm	r06, 16
	add	r03, r03, r06
	limm	r06, create_float_array_base.636
	or	r05, r06, rFF
	jr	r02, r05, rFF
	limm	r06, 16
	sub	r03, r03, r06
	limm	r06, 12
	add	r05, r03, r06
	ldw	r05, r05, rFF
	or	r02, r05, rFF
	limm	r09, 3
	limm	r06, l.1256
	ldw	r18, r06, rFF
	limm	r06, 12
	add	r05, r03, r06
	stw	r05, r08, rFF
	or	r05, r02, rFF
	or	r08, r09, rFF
	limm	r06, 20
	add	r06, r03, r06
	stw	r06, r05, rFF
	limm	r06, 24
	add	r03, r03, r06
	limm	r06, create_float_array_base.636
	or	r05, r06, rFF
	jr	r02, r05, rFF
	limm	r06, 24
	sub	r03, r03, r06
	limm	r06, 20
	add	r05, r03, r06
	ldw	r05, r05, rFF
	or	r02, r05, rFF
	limm	r08, 60
	limm	r06, 12
	add	r05, r03, r06
	ldw	r09, r05, rFF
	or	r05, r02, rFF
	limm	r06, 20
	add	r06, r03, r06
	stw	r06, r05, rFF
	limm	r06, 24
	add	r03, r03, r06
	limm	r06, create_array_base.633
	or	r05, r06, rFF
	jr	r02, r05, rFF
	limm	r06, 24
	sub	r03, r03, r06
	limm	r06, 20
	add	r05, r03, r06
	ldw	r05, r05, rFF
	or	r02, r05, rFF
	limm	r08, 0
	limm	r06, l.1256
	ldw	r18, r06, rFF
	or	r05, r02, rFF
	limm	r06, 20
	add	r06, r03, r06
	stw	r06, r05, rFF
	limm	r06, 24
	add	r03, r03, r06
	limm	r06, create_float_array_base.636
	or	r05, r06, rFF
	jr	r02, r05, rFF
	limm	r06, 24
	sub	r03, r03, r06
	limm	r06, 20
	add	r05, r03, r06
	ldw	r05, r05, rFF
	or	r09, r08, rFF
	or	r02, r05, rFF
	limm	r08, 0
	limm	r06, 16
	add	r05, r03, r06
	stw	r05, r09, rFF
	or	r05, r02, rFF
	limm	r06, 20
	add	r06, r03, r06
	stw	r06, r05, rFF
	limm	r06, 24
	add	r03, r03, r06
	limm	r06, create_array_base.633
	or	r05, r06, rFF
	jr	r02, r05, rFF
	limm	r06, 24
	sub	r03, r03, r06
	limm	r06, 20
	add	r05, r03, r06
	ldw	r05, r05, rFF
	or	r02, r05, rFF
	or	r09, r04, rFF
	limm	r06, 8
	add	r04, r04, r06
	limm	r06, 4
	add	r06, r09, r06
	stw	r06, r08, rFF
	limm	r06, 16
	add	r05, r03, r06
	ldw	r08, r05, rFF
	limm	r06, 0
	add	r06, r09, r06
	stw	r06, r08, rFF
	or	r08, r09, rFF
	limm	r09, 180
	limm	r0A, 0
	limm	r06, l.1256
	ldw	r18, r06, rFF
	or	r0B, r04, rFF
	limm	r06, 16
	add	r04, r04, r06
	limm	r06, 8
	add	r06, r0B, r06
	stw	r06, r18, rFF
	limm	r06, 4
	add	r06, r0B, r06
	stw	r06, r08, rFF
	limm	r06, 0
	add	r06, r0B, r06
	stw	r06, r0A, rFF
	or	r08, r0B, rFF
	or	r05, r02, rFF
	or	r16, r09, rFF
	or	r09, r08, rFF
	or	r08, r16, rFF
	limm	r06, 20
	add	r06, r03, r06
	stw	r06, r05, rFF
	limm	r06, 24
	add	r03, r03, r06
	limm	r06, create_array_base.633
	or	r05, r06, rFF
	jr	r02, r05, rFF
	limm	r06, 24
	sub	r03, r03, r06
	limm	r06, 20
	add	r05, r03, r06
	ldw	r05, r05, rFF
	or	r02, r05, rFF
	limm	r08, 1
	limm	r09, 0
	or	r05, r02, rFF
	limm	r06, 20
	add	r06, r03, r06
	stw	r06, r05, rFF
	limm	r06, 24
	add	r03, r03, r06
	limm	r06, create_array_base.633
	or	r05, r06, rFF
	jr	r02, r05, rFF
	limm	r06, 24
	sub	r03, r03, r06
	limm	r06, 20
	add	r05, r03, r06
	ldw	r05, r05, rFF
	or	r02, r05, rFF
	limm	r08, 20
	or	r05, r02, rFF
	limm	r06, 20
	add	r06, r03, r06
	stw	r06, r05, rFF
	limm	r06, 24
	add	r03, r03, r06
	limm	r06, fib.764
	or	r05, r06, rFF
	jr	r02, r05, rFF
	limm	r06, 24
	sub	r03, r03, r06
	limm	r06, 20
	add	r05, r03, r06
	ldw	r05, r05, rFF
	or	r02, r05, rFF
	or	r05, r02, rFF
	limm	r06, 20
	add	r06, r03, r06
	stw	r06, r05, rFF
	limm	r06, 24
	add	r03, r03, r06
	limm	r06, print_int.579
	or	r05, r06, rFF
	jr	r02, r05, rFF
	limm	r06, 24
	sub	r03, r03, r06
	limm	r06, 20
	add	r05, r03, r06
	ldw	r05, r05, rFF
	or	r02, r05, rFF
	hlt	rFF, 0
   # main program end
