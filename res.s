	.text
	.globl  _min_caml_start
	.align 2
	limm	r06, _min_caml_start
	jr	r05, r06, rFF
	.text
	.align 2
print_int_sub.308:
	limm	r09, 10
	limm	r06, 10
	cmp	r07, r08, r06
	limm	r06, jrge_else.338
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
	limm	r06, min_caml_div
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
	limm	r06, print_int_sub.308
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
	limm	r06, min_caml_div
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
	limm	r06, min_caml_mul
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
	limm	r06, min_caml_print_byte
	jr	r05, r06, rFF
jrge_else.338:
	limm	r06, 48
	add	r08, r08, r06
	limm	r06, min_caml_print_byte
	jr	r05, r06, rFF
print_int.146:
	limm	r06, 0
	cmp	r07, r08, r06
	limm	r06, jrge_else.339
	jrlt	r05, r07, r06
	or	r05, r02, rFF
	limm	r06, 4
	add	r06, r03, r06
	stw	r06, r05, rFF
	limm	r06, 8
	add	r03, r03, r06
	limm	r06, print_int_sub.308
	or	r05, r06, rFF
	jr	r02, r05, rFF
	limm	r06, 8
	sub	r03, r03, r06
	limm	r06, 4
	add	r05, r03, r06
	ldw	r05, r05, rFF
	or	r02, r05, rFF
	limm	r06, jrge_cont.340
	jr	r05, r06, rFF
jrge_else.339:
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
	limm	r06, min_caml_print_byte
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
	or	r05, r02, rFF
	limm	r06, 4
	add	r06, r03, r06
	stw	r06, r05, rFF
	limm	r06, 8
	add	r03, r03, r06
	limm	r06, print_int_sub.308
	or	r05, r06, rFF
	jr	r02, r05, rFF
	limm	r06, 8
	sub	r03, r03, r06
	limm	r06, 4
	add	r05, r03, r06
	ldw	r05, r05, rFF
	or	r02, r05, rFF
jrge_cont.340:
	limm	r08, 0
	limm	r06, min_caml_print_byte
	jr	r05, r06, rFF
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
	limm	r08, 1234
	or	r05, r02, rFF
	limm	r06, 4
	add	r06, r03, r06
	stw	r06, r05, rFF
	limm	r06, 8
	add	r03, r03, r06
	limm	r06, print_int.146
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
# print_newline
	.text
	.align	2
	.globl 	min_caml_print_newline
min_caml_print_newline: 
  limm r08, 10
  out r08, 0
  jr  r05, r02, rFF
#	print_byte
	.text
	.align 	2
  .globl	min_caml_print_byte
min_caml_print_byte:  
  out r08, 0
  jr  r05, r02, rFF
#	read_byte
	.text
	.align 	2
  .globl	min_caml_read_byte
min_caml_read_byte:  
  in r08, 0
  jr  r05, r02, rFF
#	prerr_byte
	.text
	.align 	2
	.globl	min_caml_prerr_byte
min_caml_prerr_byte:  
  out r08, 0
  jr  r05, r02, rFF
#	prerr_float
	.text
	.align 	2
#	.globl 	min_caml_prerr_float
#	create_array
	.text
	.align	2
	.globl	min_caml_create_array
min_caml_create_array:
  or	r0A, r08, rFF
	or	r08, r04, rFF
loop.min_caml_create_array:
  cmp	r07, r0A, rFF
  limm	r06, cont.min_caml_create_array
  jrneq	r05, r07, r06
  jr	r05, r02, rFF
cont.min_caml_create_array
  stw	r04, r09
  limm	r06, 1
  sub	r0A, r0A, r06
  limm r06, 4
  add r04, r04, r06
  limm	r06, loop.min_caml_create_array
  jr r05, r06, rFF
#	create_float_array
	.text
	.align	2
	.globl	min_caml_create_float_array
min_caml_create_float_array:
  or	r0A, r08, rFF
	or	r08, r04, rFF
loop.min_caml_create_float_array:
  cmp	r07, r0A, rFF
  limm	r06, cont.min_caml_create_float_array
  jrneq	r05, r07, r06
  jr	r05, r02, rFF
cont.min_caml_create_float_array
  stw	r04, r18
  limm	r06, 1
  sub	r0A, r0A, r06
  limm r06, 4
  add r04, r04, r06
  limm	r06, loop.min_caml_create_float_array
  jr r05, r06, rFF
#	mul
#let rec min_caml_mul a b =
#   let rec mul_sub a b i =
#     if i = -1 then 
#       0
#     else
#       if (b land (1 lsl i)) = 0 then
#         mul_sub a b (i - 1)
#       else
#         (a lsl i) + (mul_sub a b (i - 1))
#   in
#   mul_sub a b 31
	.text
	.align	2
	.globl	min_caml_mul
mul_sub.min_caml_mul32:
  limm  r06, 65535
  limm  r06, 16
  sll r06, r06, r06
  limm  r06, 65535
  or  r06, r06, r06
  cmp r07, r0A, r06
  limm  r06, jreq_else.min_caml_mul72
  jrneq r05, r07, r06
  limm  r08, 0
  jr  r05, r02, rFF
jreq_else.min_caml_mul72:
  limm  r0B, 1
  sll r0B, r0B, r0A
  and r0B, r09, r0B
  limm  r06, 0
  cmp r07, r0B, r06
  limm  r06, jreq_else.min_caml_mul73
  jrneq r05, r07, r06
  limm  r06, 1
  sub r0A, r0A, r06
  limm  r06, mul_sub.min_caml_mul32
  jr  r05, r06, rFF
jreq_else.min_caml_mul73:
  sll r0B, r08, r0A
  limm  r06, 1
  sub r0A, r0A, r06
  limm  r06, 0
  add r05, r03, r06
  stw r05, r0B, rFF
  or  r05, r02, rFF
  limm  r06, 4
  add r06, r03, r06
  stw r06, r05, rFF
  limm  r06, 8
  add r03, r03, r06
  limm  r06, mul_sub.min_caml_mul32
  or  r05, r06, rFF
  jr  r02, r05, rFF
  limm  r06, 8
  sub r03, r03, r06
  limm  r06, 4
  add r05, r03, r06
  ldw r05, r05, rFF
  or  r02, r05, rFF
  limm  r06, 0
  add r05, r03, r06
  ldw r09, r05, rFF
  add r08, r09, r08
  jr  r05, r02, rFF
min_caml_mul:
  limm  r0A, 31
  limm  r06, mul_sub.min_caml_mul32
  jr  r05, r06, rFF
#	div
#let rec min_caml_div a b =
#   let rec div_sub a b i =
#     if i = -1 then
#       0
#     else
#       if (a lsr i) >= b then
#         (1 lsl i) + div_sub (a - (b lsl i)) b (i - 1)
#       else
#         div_sub a b (i - 1)
#   in
#   div_sub a b 31
	.text
	.align	2
	.globl	min_caml_div
div_sub.min_caml_div52:
  limm  r06, 65535
  limm  r06, 16
  sll r06, r06, r06
  limm  r06, 65535
  or  r06, r06, r06
  cmp r07, r0A, r06
  limm  r06, jreq_else.min_caml_div74
  jrneq r05, r07, r06
  limm  r08, 0
  jr  r05, r02, rFF
jreq_else.min_caml_div74:
  srl r0B, r08, r0A
  cmp r07, r09, r0B
  limm  r06, jrle_else.min_caml_div75
  jrgt  r05, r07, r06
  limm  r0B, 1
  sll r0B, r0B, r0A
  sll r0C, r09, r0A
  sub r08, r08, r0C
  limm  r06, 1
  sub r0A, r0A, r06
  limm  r06, 0
  add r05, r03, r06
  stw r05, r0B, rFF
  or  r05, r02, rFF
  limm  r06, 4
  add r06, r03, r06
  stw r06, r05, rFF
  limm  r06, 8
  add r03, r03, r06
  limm  r06, div_sub.min_caml_div52
  or  r05, r06, rFF
  jr  r02, r05, rFF
  limm  r06, 8
  sub r03, r03, r06
  limm  r06, 4
  add r05, r03, r06
  ldw r05, r05, rFF
  or  r02, r05, rFF
  limm  r06, 0
  add r05, r03, r06
  ldw r09, r05, rFF
  add r08, r09, r08
  jr  r05, r02, rFF
jrle_else.min_caml_div75:
  limm  r06, 1
  sub r0A, r0A, r06
  limm  r06, div_sub.min_caml_div52
  jr  r05, r06, rFF
min_caml_div:
  limm  r0A, 31
  limm  r06, div_sub.min_caml_div52
  jr  r05, r06, rFF
  
