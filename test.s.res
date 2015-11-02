to binary and back to assembly
	.text
	.globl  _min_caml_start
	.align 2
	limm	r06, _min_caml_start         	#000
	jr	r05, r06, rFF                  	#001
	.text
	.align 2
testfun.48:
	halt    rff, 0                    	#002
	add	r08, r08, r09                 	#003
	jr	r05, r02, rFF                  	#004
_min_caml_start: # main entry point
   # stack start from 16MB - 5MB (11534336)
	limm	r03, 176                     	#005
	limm	r06, 16                      	#006
	sll	r03, r03, r06                 	#007
	limm	r06, 0                       	#008
	or	r03, r03, r06                  	#009
   # heap start from 16MB - 4MB (12582912)
	limm	r04, 192                     	#00A
	limm	r06, 16                      	#00B
	sll	r04, r04, r06                 	#00C
	limm	r06, 0                       	#00D
	or	r04, r04, r06                  	#00E
   # main program start
	limm	r08, 1                       	#00F
	limm	r09, 2                       	#010
	or	r05, r02, rFF                  	#011
	limm	r06, 4                       	#012
	add	r06, r03, r06                 	#013
	stw	r06, r05, rFF                 	#014
	limm	r06, 8                       	#015
	add	r03, r03, r06                 	#016
	limm	r06, testfun.48              	#017
	or	r05, r06, rFF                  	#018
	jr	r02, r05, rFF                  	#019
	limm	r06, 8                       	#01A
	sub	r03, r03, r06                 	#01B
	limm	r06, 4                       	#01C
	add	r05, r03, r06                 	#01D
	ldw	r05, r05, rFF                 	#01E
	or	r02, r05, rFF                  	#01F
	or	r05, r02, rFF                  	#020
	limm	r06, 4                       	#021
	add	r06, r03, r06                 	#022
	stw	r06, r05, rFF                 	#023
	limm	r06, 8                       	#024
	add	r03, r03, r06                 	#025
	limm	r06, min_caml_print_int      	#026
	or	r05, r06, rFF                  	#027
	jr	r02, r05, rFF                  	#028
	limm	r06, 8                       	#029
	sub	r03, r03, r06                 	#02A
	limm	r06, 4                       	#02B
	add	r05, r03, r06                 	#02C
	ldw	r05, r05, rFF                 	#02D
	or	r02, r05, rFF                  	#02E
   # main program end
	limm	r06, _min_caml_end           	#02F
_min_caml_end: # infinite loop
	jr	r05, r06, rFF                  	#030
# print_newline
	.text
	.align	2
	.globl 	min_caml_print_newline
min_caml_print_newline: 
  limm r08, 10                     	#031
  out r08, 0                       	#032
  jr  r05, r02, rFF                	#033
#	print_int
#let rec print_int a =
#    let rec print_int_sub a =
#      if a < 10 then
#        print_byte (a + 48)
#      else
#        (print_int (div a 10)   ;
#         print_byte (a - (mul (div a 10) 10) + 48))
#    in
#    if a < 0 then
#      print_byte 45             ;
#      print_int_sub (-a)
#    else
#      print_int_sub a           ;
#    print_byte 0
#      in
#      print_int 15
	.text
	.align 	2
	.globl	min_caml_print_int
print_int_sub.print_int:
  limm  r09, 10                    	#034
  limm  r06, 10                    	#035
  cmp r07, r08, r06                	#036
  limm  r06, jrge_else.print_int54 	#037
  jrlt  r05, r07, r06              	#038
  limm  r06, 0                     	#039
  add r05, r03, r06                	#03A
  stw r05, r09, rFF                	#03B
  limm  r06, 4                     	#03C
  add r05, r03, r06                	#03D
  stw r05, r08, rFF                	#03E
  or  r05, r02, rFF                	#03F
  limm  r06, 12                    	#040
  add r06, r03, r06                	#041
  stw r06, r05, rFF                	#042
  limm  r06, 16                    	#043
  add r03, r03, r06                	#044
  limm  r06, min_caml_div          	#045
  or  r05, r06, rFF                	#046
  jr  r02, r05, rFF                	#047
  limm  r06, 16                    	#048
  sub r03, r03, r06                	#049
  limm  r06, 12                    	#04A
  add r05, r03, r06                	#04B
  ldw r05, r05, rFF                	#04C
  or  r02, r05, rFF                	#04D
  or  r05, r02, rFF                	#04E
  limm  r06, 12                    	#04F
  add r06, r03, r06                	#050
  stw r06, r05, rFF                	#051
  limm  r06, 16                    	#052
  add r03, r03, r06                	#053
  limm  r06, print_int_sub.print_int	#054
  or  r05, r06, rFF                	#055
  jr  r02, r05, rFF                	#056
  limm  r06, 16                    	#057
  sub r03, r03, r06                	#058
  limm  r06, 12                    	#059
  add r05, r03, r06                	#05A
  ldw r05, r05, rFF                	#05B
  or  r02, r05, rFF                	#05C
  limm  r06, 4                     	#05D
  add r05, r03, r06                	#05E
  ldw r08, r05, rFF                	#05F
  limm  r06, 0                     	#060
  add r05, r03, r06                	#061
  ldw r09, r05, rFF                	#062
  or  r05, r02, rFF                	#063
  limm  r06, 12                    	#064
  add r06, r03, r06                	#065
  stw r06, r05, rFF                	#066
  limm  r06, 16                    	#067
  add r03, r03, r06                	#068
  limm  r06, min_caml_div          	#069
  or  r05, r06, rFF                	#06A
  jr  r02, r05, rFF                	#06B
  limm  r06, 16                    	#06C
  sub r03, r03, r06                	#06D
  limm  r06, 12                    	#06E
  add r05, r03, r06                	#06F
  ldw r05, r05, rFF                	#070
  or  r02, r05, rFF                	#071
  limm  r06, 0                     	#072
  add r05, r03, r06                	#073
  ldw r09, r05, rFF                	#074
  or  r05, r02, rFF                	#075
  limm  r06, 12                    	#076
  add r06, r03, r06                	#077
  stw r06, r05, rFF                	#078
  limm  r06, 16                    	#079
  add r03, r03, r06                	#07A
  limm  r06, min_caml_mul          	#07B
  or  r05, r06, rFF                	#07C
  jr  r02, r05, rFF                	#07D
  limm  r06, 16                    	#07E
  sub r03, r03, r06                	#07F
  limm  r06, 12                    	#080
  add r05, r03, r06                	#081
  ldw r05, r05, rFF                	#082
  or  r02, r05, rFF                	#083
  limm  r06, 4                     	#084
  add r05, r03, r06                	#085
  ldw r09, r05, rFF                	#086
  sub r08, r09, r08                	#087
  limm  r06, 48                    	#088
  add r08, r08, r06                	#089
  limm  r06, min_caml_print_byte   	#08A
  jr  r05, r06, rFF                	#08B
jrge_else.print_int54:
  limm  r06, 48                    	#08C
  add r08, r08, r06                	#08D
  limm  r06, min_caml_print_byte   	#08E
  jr  r05, r06, rFF                	#08F
min_caml_print_int:
  limm  r06, 0                     	#090
  cmp r07, r08, r06                	#091
  limm  r06, jrge_else.print_int55 	#092
  jrlt  r05, r07, r06              	#093
  or  r05, r02, rFF                	#094
  limm  r06, 4                     	#095
  add r06, r03, r06                	#096
  stw r06, r05, rFF                	#097
  limm  r06, 8                     	#098
  add r03, r03, r06                	#099
  limm  r06, print_int_sub.print_int	#09A
  or  r05, r06, rFF                	#09B
  jr  r02, r05, rFF                	#09C
  limm  r06, 8                     	#09D
  sub r03, r03, r06                	#09E
  limm  r06, 4                     	#09F
  add r05, r03, r06                	#0A0
  ldw r05, r05, rFF                	#0A1
  or  r02, r05, rFF                	#0A2
  limm  r06, jrge_cont.print_int56 	#0A3
  jr  r05, r06, rFF                	#0A4
jrge_else.print_int55:
  limm  r09, 45                    	#0A5
  limm  r06, 0                     	#0A6
  add r05, r03, r06                	#0A7
  stw r05, r08, rFF                	#0A8
  or  r05, r02, rFF                	#0A9
  or  r08, r09, rFF                	#0AA
  limm  r06, 4                     	#0AB
  add r06, r03, r06                	#0AC
  stw r06, r05, rFF                	#0AD
  limm  r06, 8                     	#0AE
  add r03, r03, r06                	#0AF
  limm  r06, min_caml_print_byte   	#0B0
  or  r05, r06, rFF                	#0B1
  jr  r02, r05, rFF                	#0B2
  limm  r06, 8                     	#0B3
  sub r03, r03, r06                	#0B4
  limm  r06, 4                     	#0B5
  add r05, r03, r06                	#0B6
  ldw r05, r05, rFF                	#0B7
  or  r02, r05, rFF                	#0B8
  limm  r08, 0                     	#0B9
  limm  r06, 0                     	#0BA
  add r05, r03, r06                	#0BB
  ldw r09, r05, rFF                	#0BC
  sub r08, r08, r09                	#0BD
  or  r05, r02, rFF                	#0BE
  limm  r06, 4                     	#0BF
  add r06, r03, r06                	#0C0
  stw r06, r05, rFF                	#0C1
  limm  r06, 8                     	#0C2
  add r03, r03, r06                	#0C3
  limm  r06, print_int_sub.print_int	#0C4
  or  r05, r06, rFF                	#0C5
  jr  r02, r05, rFF                	#0C6
  limm  r06, 8                     	#0C7
  sub r03, r03, r06                	#0C8
  limm  r06, 4                     	#0C9
  add r05, r03, r06                	#0CA
  ldw r05, r05, rFF                	#0CB
  or  r02, r05, rFF                	#0CC
jrge_cont.print_int56:
  limm  r08, 0                     	#0CD
  limm  r06, min_caml_print_byte   	#0CE
  jr  r05, r06, rFF                	#0CF
#	print_byte
	.text
	.align 	2
  .globl	min_caml_print_byte
min_caml_print_byte:  
  out r08, 0                       	#0D0
  jr  r05, r02, rFF                	#0D1
#	read_byte
	.text
	.align 	2
  .globl	min_caml_read_byte
min_caml_read_byte:  
  in r08, 0                        	#0D2
  jr  r05, r02, rFF                	#0D3
#	prerr_int
#let rec print_int a =
#  if a < 10 then
#    print_byte (a + 48);
#    print_byte 0
#  else
#    (print_int (div a 10);
#     print_byte (a - (mul (div a 10) 10) + 48))
#    in
#    print_int 15
	.text
	.align 	2
	.globl	min_caml_prerr_int
min_caml_prerr_int:
  limm  r09, 10                    	#0D4
  limm  r06, 10                    	#0D5
  cmp r07, r08, r06                	#0D6
  limm  r06, jrge_else.prerr_int   	#0D7
  jrlt  r05, r07, r06              	#0D8
  limm  r06, 0                     	#0D9
  add r05, r03, r06                	#0DA
  stw r05, r09, rFF                	#0DB
  limm  r06, 4                     	#0DC
  add r05, r03, r06                	#0DD
  stw r05, r08, rFF                	#0DE
  or  r05, r02, rFF                	#0DF
  limm  r06, 12                    	#0E0
  add r06, r03, r06                	#0E1
  stw r06, r05, rFF                	#0E2
  limm  r06, 16                    	#0E3
  add r03, r03, r06                	#0E4
  limm  r06, min_caml_div          	#0E5
  or  r05, r06, rFF                	#0E6
  jr  r02, r05, rFF                	#0E7
  limm  r06, 16                    	#0E8
  sub r03, r03, r06                	#0E9
  limm  r06, 12                    	#0EA
  add r05, r03, r06                	#0EB
  ldw r05, r05, rFF                	#0EC
  or  r02, r05, rFF                	#0ED
  or  r05, r02, rFF                	#0EE
  limm  r06, 12                    	#0EF
  add r06, r03, r06                	#0F0
  stw r06, r05, rFF                	#0F1
  limm  r06, 16                    	#0F2
  add r03, r03, r06                	#0F3
  limm  r06, min_caml_prerr_int    	#0F4
  or  r05, r06, rFF                	#0F5
  jr  r02, r05, rFF                	#0F6
  limm  r06, 16                    	#0F7
  sub r03, r03, r06                	#0F8
  limm  r06, 12                    	#0F9
  add r05, r03, r06                	#0FA
  ldw r05, r05, rFF                	#0FB
  or  r02, r05, rFF                	#0FC
  limm  r06, 4                     	#0FD
  add r05, r03, r06                	#0FE
  ldw r08, r05, rFF                	#0FF
  limm  r06, 0                     	#100
  add r05, r03, r06                	#101
  ldw r09, r05, rFF                	#102
  or  r05, r02, rFF                	#103
  limm  r06, 12                    	#104
  add r06, r03, r06                	#105
  stw r06, r05, rFF                	#106
  limm  r06, 16                    	#107
  add r03, r03, r06                	#108
  limm  r06, min_caml_div          	#109
  or  r05, r06, rFF                	#10A
  jr  r02, r05, rFF                	#10B
  limm  r06, 16                    	#10C
  sub r03, r03, r06                	#10D
  limm  r06, 12                    	#10E
  add r05, r03, r06                	#10F
  ldw r05, r05, rFF                	#110
  or  r02, r05, rFF                	#111
  limm  r06, 0                     	#112
  add r05, r03, r06                	#113
  ldw r09, r05, rFF                	#114
  or  r05, r02, rFF                	#115
  limm  r06, 12                    	#116
  add r06, r03, r06                	#117
  stw r06, r05, rFF                	#118
  limm  r06, 16                    	#119
  add r03, r03, r06                	#11A
  limm  r06, min_caml_mul          	#11B
  or  r05, r06, rFF                	#11C
  jr  r02, r05, rFF                	#11D
  limm  r06, 16                    	#11E
  sub r03, r03, r06                	#11F
  limm  r06, 12                    	#120
  add r05, r03, r06                	#121
  ldw r05, r05, rFF                	#122
  or  r02, r05, rFF                	#123
  limm  r06, 4                     	#124
  add r05, r03, r06                	#125
  ldw r09, r05, rFF                	#126
  sub r08, r09, r08                	#127
  limm  r06, 48                    	#128
  add r08, r08, r06                	#129
  limm  r06, min_caml_prerr_byte   	#12A
  jr  r05, r06, rFF                	#12B
jrge_else.prerr_int:
  limm  r06, 48                    	#12C
  add r08, r08, r06                	#12D
  or  r05, r02, rFF                	#12E
  limm  r06, 12                    	#12F
  add r06, r03, r06                	#130
  stw r06, r05, rFF                	#131
  limm  r06, 16                    	#132
  add r03, r03, r06                	#133
  limm  r06, min_caml_prerr_byte   	#134
  or  r05, r06, rFF                	#135
  jr  r02, r05, rFF                	#136
  limm  r06, 16                    	#137
  sub r03, r03, r06                	#138
  limm  r06, 12                    	#139
  add r05, r03, r06                	#13A
  ldw r05, r05, rFF                	#13B
  or  r02, r05, rFF                	#13C
  limm  r08, 0                     	#13D
  limm  r06, min_caml_prerr_byte   	#13E
  jr  r05, r06, rFF                	#13F
#	prerr_byte
	.text
	.align 	2
	.globl	min_caml_prerr_byte
min_caml_prerr_byte:  
  out r08, 0                       	#140
  jr  r05, r02, rFF                	#141
#	prerr_float
	.text
	.align 	2
#	.globl 	min_caml_prerr_float
#	read_int
#let rec read_int x =
#  let b = read_byte ()
#  in
#  if b = 0 then
#    0
#  else
#    let i = b - 48 in
#    let j = if i >= 0 then
#              if i < 10 then
#                i
#              else
#                1
#            else
#              1
#    in
#    div j (read_int ())
#    in
#    print_int (read_int ())
	.text
	.align 	2
	.globl	min_caml_read_int
min_caml_read_int:  
  or  r05, r02, rFF                	#142
  limm  r06, 4                     	#143
  add r06, r03, r06                	#144
  stw r06, r05, rFF                	#145
  limm  r06, 8                     	#146
  add r03, r03, r06                	#147
  limm  r06, min_caml_read_byte    	#148
  or  r05, r06, rFF                	#149
  jr  r02, r05, rFF                	#14A
  limm  r06, 8                     	#14B
  sub r03, r03, r06                	#14C
  limm  r06, 4                     	#14D
  add r05, r03, r06                	#14E
  ldw r05, r05, rFF                	#14F
  or  r02, r05, rFF                	#150
  limm  r06, 0                     	#151
  cmp r07, r08, r06                	#152
  limm  r06, jreq_else.read_int0   	#153
  jrneq r05, r07, r06              	#154
  limm  r08, 0                     	#155
  jr  r05, r02, rFF                	#156
jreq_else.read_int0:
  limm  r06, 48                    	#157
  sub r08, r08, r06                	#158
  limm  r06, 0                     	#159
  cmp r07, r08, r06                	#15A
  limm  r06, jrge_else.read_int1   	#15B
  jrlt  r05, r07, r06              	#15C
  limm  r06, 10                    	#15D
  cmp r07, r08, r06                	#15E
  limm  r06, jrge_else.read_int3   	#15F
  jrlt  r05, r07, r06              	#160
  limm  r08, 1                     	#161
  limm  r06, jrge_cont.read_int4   	#162
  jr  r05, r06, rFF                	#163
jrge_else.read_int3:
jrge_cont.read_int4:
  limm  r06, jrge_cont.read_int2   	#164
  jr  r05, r06, rFF                	#165
jrge_else.read_int1:
  limm  r08, 1                     	#166
jrge_cont.read_int2:
  limm  r06, 0                     	#167
  add r05, r03, r06                	#168
  stw r05, r08, rFF                	#169
  or  r05, r02, rFF                	#16A
  limm  r06, 4                     	#16B
  add r06, r03, r06                	#16C
  stw r06, r05, rFF                	#16D
  limm  r06, 8                     	#16E
  add r03, r03, r06                	#16F
  limm  r06, min_caml_read_int     	#170
  or  r05, r06, rFF                	#171
  jr  r02, r05, rFF                	#172
  limm  r06, 8                     	#173
  sub r03, r03, r06                	#174
  limm  r06, 4                     	#175
  add r05, r03, r06                	#176
  ldw r05, r05, rFF                	#177
  or  r09, r08, rFF                	#178
  or  r02, r05, rFF                	#179
  limm  r06, 0                     	#17A
  add r05, r03, r06                	#17B
  ldw r08, r05, rFF                	#17C
  limm  r06, min_caml_div          	#17D
  jr  r05, r06, rFF                	#17E
# 	read_float
	.text
	.align	2
#	.globl	min_caml_read_float
#	create_array
	.text
	.align	2
	.globl	min_caml_create_array
min_caml_create_array:
  or	r09, r08, rFF                 	#17F
	or	r08, r04, rFF                  	#180
  limm  r06, 2                     	#181
  sll	r09, r09, r06                	#182
  add	r04, r04, r09                	#183
  jr	r05, r02, rFF                 	#184
#	create_float_array
	.text
	.align	2
	.globl	min_caml_create_float_array
min_caml_create_float_array:
  or	r09, r08, rFF                 	#185
	or	r08, r04, rFF                  	#186
  limm  r06, 2                     	#187
  sll	r09, r09, r06                	#188
  add	r04, r04, r09                	#189
  jr	r05, r02, rFF                 	#18A
#	abs_float
#let rec abs_float i =
#  i land 2147483647
#    in
#    print_int (abs_float 1091567616)
	.text
	.align	2
	.globl	min_caml_abs_float
min_caml_abs_float:
  limm  r09, 32767                 	#18B
  limm  r06, 16                    	#18C
  sll r09, r09, r06                	#18D
  limm  r06, 65535                 	#18E
  or  r09, r09, r06                	#18F
  and r08, r08, r09                	#190
  jr  r05, r02, rFF                	#191
# 	floor
#let rec floor i =
#    let exp = ((i lsr 23) land 255) - 127 in
#    (i lsr (23 - exp)) lsl (23 - exp)
#      in
#      print_int (floor 1075838976)
	.text
	.align 	2
	.globl 	min_caml_floor
min_caml_floor:
  limm  r06, 23                    	#192
  srl r09, r08, r06                	#193
  limm  r0A, 255                   	#194
  and r09, r09, r0A                	#195
  limm  r06, 127                   	#196
  sub r09, r09, r06                	#197
  limm  r0A, 23                    	#198
  sub r0A, r0A, r09                	#199
  srl r08, r08, r0A                	#19A
  limm  r0A, 23                    	#19B
  sub r09, r0A, r09                	#19C
  sll r08, r08, r09                	#19D
  jr  r05, r02, rFF                	#19E
# int_of_float, truncate
#let rec int_of_float i =
#    let exp = ((i lsr 23) land 255) - 127 in
#    let rval = (((i lor 8388608) land 16777215) lsr (23 - exp)) in
#    rval lor (i land 2147483648)
#      in
#      print_int (int_of_float 1091567616)
	.text
	.align	2
	.globl	min_caml_int_of_float
  .globl  min_caml_truncate
min_caml_truncate:  
min_caml_int_of_float:
  limm  r06, 23                    	#19F
  srl r09, r08, r06                	#1A0
  limm  r0A, 255                   	#1A1
  and r09, r09, r0A                	#1A2
  limm  r06, 127                   	#1A3
  sub r09, r09, r06                	#1A4
  limm  r0A, 128                   	#1A5
  limm  r06, 16                    	#1A6
  sll r0A, r0A, r06                	#1A7
  limm  r06, 0                     	#1A8
  or  r0A, r0A, r06                	#1A9
  or  r0A, r08, r0A                	#1AA
  limm  r0B, 255                   	#1AB
  limm  r06, 16                    	#1AC
  sll r0B, r0B, r06                	#1AD
  limm  r06, 65535                 	#1AE
  or  r0B, r0B, r06                	#1AF
  and r0A, r0A, r0B                	#1B0
  limm  r0B, 23                    	#1B1
  sub r09, r0B, r09                	#1B2
  srl r09, r0A, r09                	#1B3
  limm  r0A, 32768                 	#1B4
  limm  r06, 16                    	#1B5
  sll r0A, r0A, r06                	#1B6
  limm  r06, 0                     	#1B7
  or  r0A, r0A, r06                	#1B8
  and r08, r08, r0A                	#1B9
  or  r08, r09, r08                	#1BA
  jr  r05, r02, rFF                	#1BB
#	float_of_int
#let rec float_of_int i =
#  let rec search_top i = 
#    if i = 1 then
#      0
#    else
#      (search_top (i lsr 1)) + 1
#  in
#  if i = 0 then 0 else
#    let sign = if i > 0 then 0 else 1 in
#    let top = search_top i in
#    (sign lsl 31) + ((top + 127) lsl 23) + ((i lxor (1 lsl top)) lsl (23 - top))
#    in
#    print_int (float_of_int 9)
	.text
	.align	2
	.globl	min_caml_float_of_int
search_top.min_caml_float_of_int:
  limm  r06, 1                     	#1BC
  cmp r07, r08, r06                	#1BD
  limm  r06, jreq_else.search_top  	#1BE
  jrneq r05, r07, r06              	#1BF
  limm  r08, 0                     	#1C0
  jr  r05, r02, rFF                	#1C1
jreq_else.search_top:
  limm  r06, 1                     	#1C2
  srl r08, r08, r06                	#1C3
  or  r05, r02, rFF                	#1C4
  limm  r06, 4                     	#1C5
  add r06, r03, r06                	#1C6
  stw r06, r05, rFF                	#1C7
  limm  r06, 8                     	#1C8
  add r03, r03, r06                	#1C9
  limm  r06, search_top.min_caml_float_of_int	#1CA
  or  r05, r06, rFF                	#1CB
  jr  r02, r05, rFF                	#1CC
  limm  r06, 8                     	#1CD
  sub r03, r03, r06                	#1CE
  limm  r06, 4                     	#1CF
  add r05, r03, r06                	#1D0
  ldw r05, r05, rFF                	#1D1
  or  r02, r05, rFF                	#1D2
  limm  r06, 1                     	#1D3
  add r08, r08, r06                	#1D4
  jr  r05, r02, rFF                	#1D5
min_caml_float_of_int:
  limm  r06, 0                     	#1D6
  cmp r07, r08, r06                	#1D7
  limm  r06, jreq_else.min_caml_float_of_int0	#1D8
  jrneq r05, r07, r06              	#1D9
  limm  r08, 0                     	#1DA
  jr  r05, r02, rFF                	#1DB
jreq_else.min_caml_float_of_int0:
  limm  r06, 0                     	#1DC
  cmp r07, r08, r06                	#1DD
  limm  r06, jrle_else.min_caml_float_of_int1	#1DE
  jrgt  r05, r07, r06              	#1DF
  limm  r09, 1                     	#1E0
  limm  r06, jrle_cont.min_caml_float_of_int2	#1E1
  jr  r05, r06, rFF                	#1E2
jrle_else.min_caml_float_of_int1:
  limm  r09, 0                     	#1E3
jrle_cont.min_caml_float_of_int2:
  limm  r06, 0                     	#1E4
  add r05, r03, r06                	#1E5
  stw r05, r08, rFF                	#1E6
  limm  r06, 4                     	#1E7
  add r05, r03, r06                	#1E8
  stw r05, r09, rFF                	#1E9
  or  r05, r02, rFF                	#1EA
  limm  r06, 12                    	#1EB
  add r06, r03, r06                	#1EC
  stw r06, r05, rFF                	#1ED
  limm  r06, 16                    	#1EE
  add r03, r03, r06                	#1EF
  limm  r06, search_top.min_caml_float_of_int	#1F0
  or  r05, r06, rFF                	#1F1
  jr  r02, r05, rFF                	#1F2
  limm  r06, 16                    	#1F3
  sub r03, r03, r06                	#1F4
  limm  r06, 12                    	#1F5
  add r05, r03, r06                	#1F6
  ldw r05, r05, rFF                	#1F7
  or  r02, r05, rFF                	#1F8
  limm  r06, 4                     	#1F9
  add r05, r03, r06                	#1FA
  ldw r09, r05, rFF                	#1FB
  limm  r06, 31                    	#1FC
  sll r09, r09, r06                	#1FD
  limm  r06, 127                   	#1FE
  add r0A, r08, r06                	#1FF
  limm  r06, 23                    	#200
  sll r0A, r0A, r06                	#201
  add r09, r09, r0A                	#202
  limm  r0A, 1                     	#203
  sll r0A, r0A, r08                	#204
  limm  r06, 0                     	#205
  add r05, r03, r06                	#206
  ldw r0B, r05, rFF                	#207
  xor r0A, r0B, r0A                	#208
  limm  r0B, 23                    	#209
  sub r08, r0B, r08                	#20A
  sll r08, r0A, r08                	#20B
  add r08, r09, r08                	#20C
  jr  r05, r02, rFF                	#20D
# div  
#let rec div a b =
#    let rec div_sub a b i =
#      if i = -1 then
#        0
#      else
#        if (a lsr i) >= b then
#          (1 lsl i) + div_sub (a - (b lsl i)) b (i - 1)
#        else
#          div_sub a b (i - 1)
#      in
#      div_sub a b 31
#      in
#      print_int (div 15 2)
	.text
	.align	2
  .globl min_caml_div
div_sub.min_caml_div:
  limm  r06, -1                    	#20E
  cmp r07, r0A, r06                	#20F
  limm  r06, jreq_else.min_caml_div0	#210
  jrneq r05, r07, r06              	#211
  limm  r08, 0                     	#212
  jr  r05, r02, rFF                	#213
jreq_else.min_caml_div0:
  srl r0B, r08, r0A                	#214
  cmp r07, r09, r0B                	#215
  limm  r06, jrle_else.min_caml_div1	#216
  jrgt  r05, r07, r06              	#217
  limm  r0B, 1                     	#218
  sll r0B, r0B, r0A                	#219
  sll r0C, r09, r0A                	#21A
  sub r08, r08, r0C                	#21B
  limm  r06, 1                     	#21C
  sub r0A, r0A, r06                	#21D
  limm  r06, 0                     	#21E
  add r05, r03, r06                	#21F
  stw r05, r0B, rFF                	#220
  or  r05, r02, rFF                	#221
  limm  r06, 4                     	#222
  add r06, r03, r06                	#223
  stw r06, r05, rFF                	#224
  limm  r06, 8                     	#225
  add r03, r03, r06                	#226
  limm  r06, div_sub.min_caml_div  	#227
  or  r05, r06, rFF                	#228
  jr  r02, r05, rFF                	#229
  limm  r06, 8                     	#22A
  sub r03, r03, r06                	#22B
  limm  r06, 4                     	#22C
  add r05, r03, r06                	#22D
  ldw r05, r05, rFF                	#22E
  or  r02, r05, rFF                	#22F
  limm  r06, 0                     	#230
  add r05, r03, r06                	#231
  ldw r09, r05, rFF                	#232
  add r08, r09, r08                	#233
  jr  r05, r02, rFF                	#234
jrle_else.min_caml_div1:
  limm  r06, 1                     	#235
  sub r0A, r0A, r06                	#236
  limm  r06, div_sub.min_caml_div  	#237
  jr  r05, r06, rFF                	#238
min_caml_div:
  limm  r0A, 31                    	#239
  limm  r06, div_sub.min_caml_div  	#23A
  jr  r05, r06, rFF                	#23B
# mul
#let rec mul a b =
#  let rec mul_sub a b i =
#    if i = -1 then 
#      0
#    else
#      if (b land (1 lsl i)) = 0 then
#        mul_sub a b (i - 1)
#      else
#        (a lsl i) + (mul_sub a b (i - 1))
#    in
#    mul_sub a b 31
#    in
#    print_int (mul 15 9)
	.text
	.align	2
  .globl min_caml_mul
mul_sub.min_caml_mul:
  limm  r06, -1                    	#23C
  cmp r07, r0A, r06                	#23D
  limm  r06, jreq_else.min_caml_mul0	#23E
  jrneq r05, r07, r06              	#23F
  limm  r08, 0                     	#240
  jr  r05, r02, rFF                	#241
jreq_else.min_caml_mul0:
  limm  r0B, 1                     	#242
  sll r0B, r0B, r0A                	#243
  and r0B, r09, r0B                	#244
  limm  r06, 0                     	#245
  cmp r07, r0B, r06                	#246
  limm  r06, jreq_else.min_caml_mul1	#247
  jrneq r05, r07, r06              	#248
  limm  r06, 1                     	#249
  sub r0A, r0A, r06                	#24A
  limm  r06, mul_sub.min_caml_mul  	#24B
  jr  r05, r06, rFF                	#24C
jreq_else.min_caml_mul1:
  sll r0B, r08, r0A                	#24D
  limm  r06, 1                     	#24E
  sub r0A, r0A, r06                	#24F
  limm  r06, 0                     	#250
  add r05, r03, r06                	#251
  stw r05, r0B, rFF                	#252
  or  r05, r02, rFF                	#253
  limm  r06, 4                     	#254
  add r06, r03, r06                	#255
  stw r06, r05, rFF                	#256
  limm  r06, 8                     	#257
  add r03, r03, r06                	#258
  limm  r06, mul_sub.min_caml_mul  	#259
  or  r05, r06, rFF                	#25A
  jr  r02, r05, rFF                	#25B
  limm  r06, 8                     	#25C
  sub r03, r03, r06                	#25D
  limm  r06, 4                     	#25E
  add r05, r03, r06                	#25F
  ldw r05, r05, rFF                	#260
  or  r02, r05, rFF                	#261
  limm  r06, 0                     	#262
  add r05, r03, r06                	#263
  ldw r09, r05, rFF                	#264
  add r08, r09, r08                	#265
  jr  r05, r02, rFF                	#266
min_caml_mul:
  limm  r0A, 31                    	#267
  limm  r06, mul_sub.min_caml_mul  	#268
  jr  r05, r06, rFF                	#269



          |
          v

limm	0x6	0x5		#000
jr	0x5	0x6	0xff	#001
halt	invalid instruction:10ff0000#002
add	0x8	0x8	0x9	#003
jr	0x5	0x2	0xff	#004
limm	0x3	0xb0		#005
limm	0x6	0x10		#006
sll	0x3	0x3	0x6	#007
limm	0x6	0x0		#008
or	0x3	0x3	0x6	#009
limm	0x4	0xc0		#00a
limm	0x6	0x10		#00b
sll	0x4	0x4	0x6	#00c
limm	0x6	0x0		#00d
or	0x4	0x4	0x6	#00e
limm	0x8	0x1		#00f
limm	0x9	0x2		#010
or	0x5	0x2	0xff	#011
limm	0x6	0x4		#012
add	0x6	0x3	0x6	#013
stw	0x6	0x5	0xff	#014
limm	0x6	0x8		#015
add	0x3	0x3	0x6	#016
limm	0x6	0x2		#017
or	0x5	0x6	0xff	#018
jr	0x2	0x5	0xff	#019
limm	0x6	0x8		#01a
sub	0x3	0x3	0x6	#01b
limm	0x6	0x4		#01c
add	0x5	0x3	0x6	#01d
ldw	0x5	0x5	0xff	#01e
or	0x2	0x5	0xff	#01f
or	0x5	0x2	0xff	#020
limm	0x6	0x4		#021
add	0x6	0x3	0x6	#022
stw	0x6	0x5	0xff	#023
limm	0x6	0x8		#024
add	0x3	0x3	0x6	#025
limm	0x6	0x90		#026
or	0x5	0x6	0xff	#027
jr	0x2	0x5	0xff	#028
limm	0x6	0x8		#029
sub	0x3	0x3	0x6	#02a
limm	0x6	0x4		#02b
add	0x5	0x3	0x6	#02c
ldw	0x5	0x5	0xff	#02d
or	0x2	0x5	0xff	#02e
limm	0x6	0x30		#02f
jr	0x5	0x6	0xff	#030
limm	0x8	0xa		#031
out	0x8	0x0		#032
jr	0x5	0x2	0xff	#033
limm	0x9	0xa		#034
limm	0x6	0xa		#035
cmp	0x7	0x8	0x6	#036
limm	0x6	0x8c		#037
jrlt	0x5	0x7	0x6	#038
limm	0x6	0x0		#039
add	0x5	0x3	0x6	#03a
stw	0x5	0x9	0xff	#03b
limm	0x6	0x4		#03c
add	0x5	0x3	0x6	#03d
stw	0x5	0x8	0xff	#03e
or	0x5	0x2	0xff	#03f
limm	0x6	0xc		#040
add	0x6	0x3	0x6	#041
stw	0x6	0x5	0xff	#042
limm	0x6	0x10		#043
add	0x3	0x3	0x6	#044
limm	0x6	0x239		#045
or	0x5	0x6	0xff	#046
jr	0x2	0x5	0xff	#047
limm	0x6	0x10		#048
sub	0x3	0x3	0x6	#049
limm	0x6	0xc		#04a
add	0x5	0x3	0x6	#04b
ldw	0x5	0x5	0xff	#04c
or	0x2	0x5	0xff	#04d
or	0x5	0x2	0xff	#04e
limm	0x6	0xc		#04f
add	0x6	0x3	0x6	#050
stw	0x6	0x5	0xff	#051
limm	0x6	0x10		#052
add	0x3	0x3	0x6	#053
limm	0x6	0x34		#054
or	0x5	0x6	0xff	#055
jr	0x2	0x5	0xff	#056
limm	0x6	0x10		#057
sub	0x3	0x3	0x6	#058
limm	0x6	0xc		#059
add	0x5	0x3	0x6	#05a
ldw	0x5	0x5	0xff	#05b
or	0x2	0x5	0xff	#05c
limm	0x6	0x4		#05d
add	0x5	0x3	0x6	#05e
ldw	0x8	0x5	0xff	#05f
limm	0x6	0x0		#060
add	0x5	0x3	0x6	#061
ldw	0x9	0x5	0xff	#062
or	0x5	0x2	0xff	#063
limm	0x6	0xc		#064
add	0x6	0x3	0x6	#065
stw	0x6	0x5	0xff	#066
limm	0x6	0x10		#067
add	0x3	0x3	0x6	#068
limm	0x6	0x239		#069
or	0x5	0x6	0xff	#06a
jr	0x2	0x5	0xff	#06b
limm	0x6	0x10		#06c
sub	0x3	0x3	0x6	#06d
limm	0x6	0xc		#06e
add	0x5	0x3	0x6	#06f
ldw	0x5	0x5	0xff	#070
or	0x2	0x5	0xff	#071
limm	0x6	0x0		#072
add	0x5	0x3	0x6	#073
ldw	0x9	0x5	0xff	#074
or	0x5	0x2	0xff	#075
limm	0x6	0xc		#076
add	0x6	0x3	0x6	#077
stw	0x6	0x5	0xff	#078
limm	0x6	0x10		#079
add	0x3	0x3	0x6	#07a
limm	0x6	0x267		#07b
or	0x5	0x6	0xff	#07c
jr	0x2	0x5	0xff	#07d
limm	0x6	0x10		#07e
sub	0x3	0x3	0x6	#07f
limm	0x6	0xc		#080
add	0x5	0x3	0x6	#081
ldw	0x5	0x5	0xff	#082
or	0x2	0x5	0xff	#083
limm	0x6	0x4		#084
add	0x5	0x3	0x6	#085
ldw	0x9	0x5	0xff	#086
sub	0x8	0x9	0x8	#087
limm	0x6	0x30		#088
add	0x8	0x8	0x6	#089
limm	0x6	0xd0		#08a
jr	0x5	0x6	0xff	#08b
limm	0x6	0x30		#08c
add	0x8	0x8	0x6	#08d
limm	0x6	0xd0		#08e
jr	0x5	0x6	0xff	#08f
limm	0x6	0x0		#090
cmp	0x7	0x8	0x6	#091
limm	0x6	0xa5		#092
jrlt	0x5	0x7	0x6	#093
or	0x5	0x2	0xff	#094
limm	0x6	0x4		#095
add	0x6	0x3	0x6	#096
stw	0x6	0x5	0xff	#097
limm	0x6	0x8		#098
add	0x3	0x3	0x6	#099
limm	0x6	0x34		#09a
or	0x5	0x6	0xff	#09b
jr	0x2	0x5	0xff	#09c
limm	0x6	0x8		#09d
sub	0x3	0x3	0x6	#09e
limm	0x6	0x4		#09f
add	0x5	0x3	0x6	#0a0
ldw	0x5	0x5	0xff	#0a1
or	0x2	0x5	0xff	#0a2
limm	0x6	0xcd		#0a3
jr	0x5	0x6	0xff	#0a4
limm	0x9	0x2d		#0a5
limm	0x6	0x0		#0a6
add	0x5	0x3	0x6	#0a7
stw	0x5	0x8	0xff	#0a8
or	0x5	0x2	0xff	#0a9
or	0x8	0x9	0xff	#0aa
limm	0x6	0x4		#0ab
add	0x6	0x3	0x6	#0ac
stw	0x6	0x5	0xff	#0ad
limm	0x6	0x8		#0ae
add	0x3	0x3	0x6	#0af
limm	0x6	0xd0		#0b0
or	0x5	0x6	0xff	#0b1
jr	0x2	0x5	0xff	#0b2
limm	0x6	0x8		#0b3
sub	0x3	0x3	0x6	#0b4
limm	0x6	0x4		#0b5
add	0x5	0x3	0x6	#0b6
ldw	0x5	0x5	0xff	#0b7
or	0x2	0x5	0xff	#0b8
limm	0x8	0x0		#0b9
limm	0x6	0x0		#0ba
add	0x5	0x3	0x6	#0bb
ldw	0x9	0x5	0xff	#0bc
sub	0x8	0x8	0x9	#0bd
or	0x5	0x2	0xff	#0be
limm	0x6	0x4		#0bf
add	0x6	0x3	0x6	#0c0
stw	0x6	0x5	0xff	#0c1
limm	0x6	0x8		#0c2
add	0x3	0x3	0x6	#0c3
limm	0x6	0x34		#0c4
or	0x5	0x6	0xff	#0c5
jr	0x2	0x5	0xff	#0c6
limm	0x6	0x8		#0c7
sub	0x3	0x3	0x6	#0c8
limm	0x6	0x4		#0c9
add	0x5	0x3	0x6	#0ca
ldw	0x5	0x5	0xff	#0cb
or	0x2	0x5	0xff	#0cc
limm	0x8	0x0		#0cd
limm	0x6	0xd0		#0ce
jr	0x5	0x6	0xff	#0cf
out	0x8	0x0		#0d0
jr	0x5	0x2	0xff	#0d1
in	0x8	0x0		#0d2
jr	0x5	0x2	0xff	#0d3
limm	0x9	0xa		#0d4
limm	0x6	0xa		#0d5
cmp	0x7	0x8	0x6	#0d6
limm	0x6	0x12c		#0d7
jrlt	0x5	0x7	0x6	#0d8
limm	0x6	0x0		#0d9
add	0x5	0x3	0x6	#0da
stw	0x5	0x9	0xff	#0db
limm	0x6	0x4		#0dc
add	0x5	0x3	0x6	#0dd
stw	0x5	0x8	0xff	#0de
or	0x5	0x2	0xff	#0df
limm	0x6	0xc		#0e0
add	0x6	0x3	0x6	#0e1
stw	0x6	0x5	0xff	#0e2
limm	0x6	0x10		#0e3
add	0x3	0x3	0x6	#0e4
limm	0x6	0x239		#0e5
or	0x5	0x6	0xff	#0e6
jr	0x2	0x5	0xff	#0e7
limm	0x6	0x10		#0e8
sub	0x3	0x3	0x6	#0e9
limm	0x6	0xc		#0ea
add	0x5	0x3	0x6	#0eb
ldw	0x5	0x5	0xff	#0ec
or	0x2	0x5	0xff	#0ed
or	0x5	0x2	0xff	#0ee
limm	0x6	0xc		#0ef
add	0x6	0x3	0x6	#0f0
stw	0x6	0x5	0xff	#0f1
limm	0x6	0x10		#0f2
add	0x3	0x3	0x6	#0f3
limm	0x6	0xd4		#0f4
or	0x5	0x6	0xff	#0f5
jr	0x2	0x5	0xff	#0f6
limm	0x6	0x10		#0f7
sub	0x3	0x3	0x6	#0f8
limm	0x6	0xc		#0f9
add	0x5	0x3	0x6	#0fa
ldw	0x5	0x5	0xff	#0fb
or	0x2	0x5	0xff	#0fc
limm	0x6	0x4		#0fd
add	0x5	0x3	0x6	#0fe
ldw	0x8	0x5	0xff	#0ff
limm	0x6	0x0		#100
add	0x5	0x3	0x6	#101
ldw	0x9	0x5	0xff	#102
or	0x5	0x2	0xff	#103
limm	0x6	0xc		#104
add	0x6	0x3	0x6	#105
stw	0x6	0x5	0xff	#106
limm	0x6	0x10		#107
add	0x3	0x3	0x6	#108
limm	0x6	0x239		#109
or	0x5	0x6	0xff	#10a
jr	0x2	0x5	0xff	#10b
limm	0x6	0x10		#10c
sub	0x3	0x3	0x6	#10d
limm	0x6	0xc		#10e
add	0x5	0x3	0x6	#10f
ldw	0x5	0x5	0xff	#110
or	0x2	0x5	0xff	#111
limm	0x6	0x0		#112
add	0x5	0x3	0x6	#113
ldw	0x9	0x5	0xff	#114
or	0x5	0x2	0xff	#115
limm	0x6	0xc		#116
add	0x6	0x3	0x6	#117
stw	0x6	0x5	0xff	#118
limm	0x6	0x10		#119
add	0x3	0x3	0x6	#11a
limm	0x6	0x267		#11b
or	0x5	0x6	0xff	#11c
jr	0x2	0x5	0xff	#11d
limm	0x6	0x10		#11e
sub	0x3	0x3	0x6	#11f
limm	0x6	0xc		#120
add	0x5	0x3	0x6	#121
ldw	0x5	0x5	0xff	#122
or	0x2	0x5	0xff	#123
limm	0x6	0x4		#124
add	0x5	0x3	0x6	#125
ldw	0x9	0x5	0xff	#126
sub	0x8	0x9	0x8	#127
limm	0x6	0x30		#128
add	0x8	0x8	0x6	#129
limm	0x6	0x140		#12a
jr	0x5	0x6	0xff	#12b
limm	0x6	0x30		#12c
add	0x8	0x8	0x6	#12d
or	0x5	0x2	0xff	#12e
limm	0x6	0xc		#12f
add	0x6	0x3	0x6	#130
stw	0x6	0x5	0xff	#131
limm	0x6	0x10		#132
add	0x3	0x3	0x6	#133
limm	0x6	0x140		#134
or	0x5	0x6	0xff	#135
jr	0x2	0x5	0xff	#136
limm	0x6	0x10		#137
sub	0x3	0x3	0x6	#138
limm	0x6	0xc		#139
add	0x5	0x3	0x6	#13a
ldw	0x5	0x5	0xff	#13b
or	0x2	0x5	0xff	#13c
limm	0x8	0x0		#13d
limm	0x6	0x140		#13e
jr	0x5	0x6	0xff	#13f
out	0x8	0x0		#140
jr	0x5	0x2	0xff	#141
or	0x5	0x2	0xff	#142
limm	0x6	0x4		#143
add	0x6	0x3	0x6	#144
stw	0x6	0x5	0xff	#145
limm	0x6	0x8		#146
add	0x3	0x3	0x6	#147
limm	0x6	0xd2		#148
or	0x5	0x6	0xff	#149
jr	0x2	0x5	0xff	#14a
limm	0x6	0x8		#14b
sub	0x3	0x3	0x6	#14c
limm	0x6	0x4		#14d
add	0x5	0x3	0x6	#14e
ldw	0x5	0x5	0xff	#14f
or	0x2	0x5	0xff	#150
limm	0x6	0x0		#151
cmp	0x7	0x8	0x6	#152
limm	0x6	0x157		#153
jrneq	0x5	0x7	0x6	#154
limm	0x8	0x0		#155
jr	0x5	0x2	0xff	#156
limm	0x6	0x30		#157
sub	0x8	0x8	0x6	#158
limm	0x6	0x0		#159
cmp	0x7	0x8	0x6	#15a
limm	0x6	0x166		#15b
jrlt	0x5	0x7	0x6	#15c
limm	0x6	0xa		#15d
cmp	0x7	0x8	0x6	#15e
limm	0x6	0x164		#15f
jrlt	0x5	0x7	0x6	#160
limm	0x8	0x1		#161
limm	0x6	0x164		#162
jr	0x5	0x6	0xff	#163
limm	0x6	0x167		#164
jr	0x5	0x6	0xff	#165
limm	0x8	0x1		#166
limm	0x6	0x0		#167
add	0x5	0x3	0x6	#168
stw	0x5	0x8	0xff	#169
or	0x5	0x2	0xff	#16a
limm	0x6	0x4		#16b
add	0x6	0x3	0x6	#16c
stw	0x6	0x5	0xff	#16d
limm	0x6	0x8		#16e
add	0x3	0x3	0x6	#16f
limm	0x6	0x142		#170
or	0x5	0x6	0xff	#171
jr	0x2	0x5	0xff	#172
limm	0x6	0x8		#173
sub	0x3	0x3	0x6	#174
limm	0x6	0x4		#175
add	0x5	0x3	0x6	#176
ldw	0x5	0x5	0xff	#177
or	0x9	0x8	0xff	#178
or	0x2	0x5	0xff	#179
limm	0x6	0x0		#17a
add	0x5	0x3	0x6	#17b
ldw	0x8	0x5	0xff	#17c
limm	0x6	0x239		#17d
jr	0x5	0x6	0xff	#17e
or	0x9	0x8	0xff	#17f
or	0x8	0x4	0xff	#180
limm	0x6	0x2		#181
sll	0x9	0x9	0x6	#182
add	0x4	0x4	0x9	#183
jr	0x5	0x2	0xff	#184
or	0x9	0x8	0xff	#185
or	0x8	0x4	0xff	#186
limm	0x6	0x2		#187
sll	0x9	0x9	0x6	#188
add	0x4	0x4	0x9	#189
jr	0x5	0x2	0xff	#18a
limm	0x9	0x7fff		#18b
limm	0x6	0x10		#18c
sll	0x9	0x9	0x6	#18d
limm	0x6	0xffff		#18e
or	0x9	0x9	0x6	#18f
and	0x8	0x8	0x9	#190
jr	0x5	0x2	0xff	#191
limm	0x6	0x17		#192
srl	0x9	0x8	0x6	#193
limm	0xa	0xff		#194
and	0x9	0x9	0xa	#195
limm	0x6	0x7f		#196
sub	0x9	0x9	0x6	#197
limm	0xa	0x17		#198
sub	0xa	0xa	0x9	#199
srl	0x8	0x8	0xa	#19a
limm	0xa	0x17		#19b
sub	0x9	0xa	0x9	#19c
sll	0x8	0x8	0x9	#19d
jr	0x5	0x2	0xff	#19e
limm	0x6	0x17		#19f
srl	0x9	0x8	0x6	#1a0
limm	0xa	0xff		#1a1
and	0x9	0x9	0xa	#1a2
limm	0x6	0x7f		#1a3
sub	0x9	0x9	0x6	#1a4
limm	0xa	0x80		#1a5
limm	0x6	0x10		#1a6
sll	0xa	0xa	0x6	#1a7
limm	0x6	0x0		#1a8
or	0xa	0xa	0x6	#1a9
or	0xa	0x8	0xa	#1aa
limm	0xb	0xff		#1ab
limm	0x6	0x10		#1ac
sll	0xb	0xb	0x6	#1ad
limm	0x6	0xffff		#1ae
or	0xb	0xb	0x6	#1af
and	0xa	0xa	0xb	#1b0
limm	0xb	0x17		#1b1
sub	0x9	0xb	0x9	#1b2
srl	0x9	0xa	0x9	#1b3
limm	0xa	0x8000		#1b4
limm	0x6	0x10		#1b5
sll	0xa	0xa	0x6	#1b6
limm	0x6	0x0		#1b7
or	0xa	0xa	0x6	#1b8
and	0x8	0x8	0xa	#1b9
or	0x8	0x9	0x8	#1ba
jr	0x5	0x2	0xff	#1bb
limm	0x6	0x1		#1bc
cmp	0x7	0x8	0x6	#1bd
limm	0x6	0x1c2		#1be
jrneq	0x5	0x7	0x6	#1bf
limm	0x8	0x0		#1c0
jr	0x5	0x2	0xff	#1c1
limm	0x6	0x1		#1c2
srl	0x8	0x8	0x6	#1c3
or	0x5	0x2	0xff	#1c4
limm	0x6	0x4		#1c5
add	0x6	0x3	0x6	#1c6
stw	0x6	0x5	0xff	#1c7
limm	0x6	0x8		#1c8
add	0x3	0x3	0x6	#1c9
limm	0x6	0x1bc		#1ca
or	0x5	0x6	0xff	#1cb
jr	0x2	0x5	0xff	#1cc
limm	0x6	0x8		#1cd
sub	0x3	0x3	0x6	#1ce
limm	0x6	0x4		#1cf
add	0x5	0x3	0x6	#1d0
ldw	0x5	0x5	0xff	#1d1
or	0x2	0x5	0xff	#1d2
limm	0x6	0x1		#1d3
add	0x8	0x8	0x6	#1d4
jr	0x5	0x2	0xff	#1d5
limm	0x6	0x0		#1d6
cmp	0x7	0x8	0x6	#1d7
limm	0x6	0x1dc		#1d8
jrneq	0x5	0x7	0x6	#1d9
limm	0x8	0x0		#1da
jr	0x5	0x2	0xff	#1db
limm	0x6	0x0		#1dc
cmp	0x7	0x8	0x6	#1dd
limm	0x6	0x1e3		#1de
jrgt	0x5	0x7	0x6	#1df
limm	0x9	0x1		#1e0
limm	0x6	0x1e4		#1e1
jr	0x5	0x6	0xff	#1e2
limm	0x9	0x0		#1e3
limm	0x6	0x0		#1e4
add	0x5	0x3	0x6	#1e5
stw	0x5	0x8	0xff	#1e6
limm	0x6	0x4		#1e7
add	0x5	0x3	0x6	#1e8
stw	0x5	0x9	0xff	#1e9
or	0x5	0x2	0xff	#1ea
limm	0x6	0xc		#1eb
add	0x6	0x3	0x6	#1ec
stw	0x6	0x5	0xff	#1ed
limm	0x6	0x10		#1ee
add	0x3	0x3	0x6	#1ef
limm	0x6	0x1bc		#1f0
or	0x5	0x6	0xff	#1f1
jr	0x2	0x5	0xff	#1f2
limm	0x6	0x10		#1f3
sub	0x3	0x3	0x6	#1f4
limm	0x6	0xc		#1f5
add	0x5	0x3	0x6	#1f6
ldw	0x5	0x5	0xff	#1f7
or	0x2	0x5	0xff	#1f8
limm	0x6	0x4		#1f9
add	0x5	0x3	0x6	#1fa
ldw	0x9	0x5	0xff	#1fb
limm	0x6	0x1f		#1fc
sll	0x9	0x9	0x6	#1fd
limm	0x6	0x7f		#1fe
add	0xa	0x8	0x6	#1ff
limm	0x6	0x17		#200
sll	0xa	0xa	0x6	#201
add	0x9	0x9	0xa	#202
limm	0xa	0x1		#203
sll	0xa	0xa	0x8	#204
limm	0x6	0x0		#205
add	0x5	0x3	0x6	#206
ldw	0xb	0x5	0xff	#207
xor	0xa	0xb	0xa	#208
limm	0xb	0x17		#209
sub	0x8	0xb	0x8	#20a
sll	0x8	0xa	0x8	#20b
add	0x8	0x9	0x8	#20c
jr	0x5	0x2	0xff	#20d
limm	0x6	0xffff		#20e
cmp	0x7	0xa	0x6	#20f
limm	0x6	0x214		#210
jrneq	0x5	0x7	0x6	#211
limm	0x8	0x0		#212
jr	0x5	0x2	0xff	#213
srl	0xb	0x8	0xa	#214
cmp	0x7	0x9	0xb	#215
limm	0x6	0x235		#216
jrgt	0x5	0x7	0x6	#217
limm	0xb	0x1		#218
sll	0xb	0xb	0xa	#219
sll	0xc	0x9	0xa	#21a
sub	0x8	0x8	0xc	#21b
limm	0x6	0x1		#21c
sub	0xa	0xa	0x6	#21d
limm	0x6	0x0		#21e
add	0x5	0x3	0x6	#21f
stw	0x5	0xb	0xff	#220
or	0x5	0x2	0xff	#221
limm	0x6	0x4		#222
add	0x6	0x3	0x6	#223
stw	0x6	0x5	0xff	#224
limm	0x6	0x8		#225
add	0x3	0x3	0x6	#226
limm	0x6	0x20e		#227
or	0x5	0x6	0xff	#228
jr	0x2	0x5	0xff	#229
limm	0x6	0x8		#22a
sub	0x3	0x3	0x6	#22b
limm	0x6	0x4		#22c
add	0x5	0x3	0x6	#22d
ldw	0x5	0x5	0xff	#22e
or	0x2	0x5	0xff	#22f
limm	0x6	0x0		#230
add	0x5	0x3	0x6	#231
ldw	0x9	0x5	0xff	#232
add	0x8	0x9	0x8	#233
jr	0x5	0x2	0xff	#234
limm	0x6	0x1		#235
sub	0xa	0xa	0x6	#236
limm	0x6	0x20e		#237
jr	0x5	0x6	0xff	#238
limm	0xa	0x1f		#239
limm	0x6	0x20e		#23a
jr	0x5	0x6	0xff	#23b
limm	0x6	0xffff		#23c
cmp	0x7	0xa	0x6	#23d
limm	0x6	0x242		#23e
jrneq	0x5	0x7	0x6	#23f
limm	0x8	0x0		#240
jr	0x5	0x2	0xff	#241
limm	0xb	0x1		#242
sll	0xb	0xb	0xa	#243
and	0xb	0x9	0xb	#244
limm	0x6	0x0		#245
cmp	0x7	0xb	0x6	#246
limm	0x6	0x24d		#247
jrneq	0x5	0x7	0x6	#248
limm	0x6	0x1		#249
sub	0xa	0xa	0x6	#24a
limm	0x6	0x23c		#24b
jr	0x5	0x6	0xff	#24c
sll	0xb	0x8	0xa	#24d
limm	0x6	0x1		#24e
sub	0xa	0xa	0x6	#24f
limm	0x6	0x0		#250
add	0x5	0x3	0x6	#251
stw	0x5	0xb	0xff	#252
or	0x5	0x2	0xff	#253
limm	0x6	0x4		#254
add	0x6	0x3	0x6	#255
stw	0x6	0x5	0xff	#256
limm	0x6	0x8		#257
add	0x3	0x3	0x6	#258
limm	0x6	0x23c		#259
or	0x5	0x6	0xff	#25a
jr	0x2	0x5	0xff	#25b
limm	0x6	0x8		#25c
sub	0x3	0x3	0x6	#25d
limm	0x6	0x4		#25e
add	0x5	0x3	0x6	#25f
ldw	0x5	0x5	0xff	#260
or	0x2	0x5	0xff	#261
limm	0x6	0x0		#262
add	0x5	0x3	0x6	#263
ldw	0x9	0x5	0xff	#264
add	0x8	0x9	0x8	#265
jr	0x5	0x2	0xff	#266
limm	0xa	0x1f		#267
limm	0x6	0x23c		#268
jr	0x5	0x6	0xff	#269


execution log
limm	0x6	0x5		#000  0A:0  06:5  07:0 08:0
jr	0x5	0x6	0xff	#001  0A:0  06:5  07:0 08:0
limm	0x3	0xb0		#005  0A:0  06:5  07:0 08:0
limm	0x6	0x10		#006  0A:0  06:16  07:0 08:0
sll	0x3	0x3	0x6	#007  0A:0  06:16  07:0 08:0
limm	0x6	0x0		#008  0A:0  06:0  07:0 08:0
or	0x3	0x3	0x6	#009  0A:0  06:0  07:0 08:0
limm	0x4	0xc0		#00a  0A:0  06:0  07:0 08:0
limm	0x6	0x10		#00b  0A:0  06:16  07:0 08:0
sll	0x4	0x4	0x6	#00c  0A:0  06:16  07:0 08:0
limm	0x6	0x0		#00d  0A:0  06:0  07:0 08:0
or	0x4	0x4	0x6	#00e  0A:0  06:0  07:0 08:0
limm	0x8	0x1		#00f  0A:0  06:0  07:0 08:1
limm	0x9	0x2		#010  0A:0  06:0  07:0 08:1
or	0x5	0x2	0xff	#011  0A:0  06:0  07:0 08:1
limm	0x6	0x4		#012  0A:0  06:4  07:0 08:1
add	0x6	0x3	0x6	#013  0A:0  06:11534340  07:0 08:1
stw	0x6	0x5	0xff	#014  0A:0  06:11534340  07:0 08:1
limm	0x6	0x8		#015  0A:0  06:8  07:0 08:1
add	0x3	0x3	0x6	#016  0A:0  06:8  07:0 08:1
limm	0x6	0x2		#017  0A:0  06:2  07:0 08:1
or	0x5	0x6	0xff	#018  0A:0  06:2  07:0 08:1
jr	0x2	0x5	0xff	#019  0A:0  06:2  07:0 08:1
halt	invalid instruction:10ff0000#002  0A:0  06:2  07:0 08:1
halt!
program executed 23 instructions without error,and hit halt.
aborting...

register(signed decimal)
 0:       0        0       26 11534344 12582912        2        2        0 
 8:       1        2        0        0        0        0        0        0 
10:       0        0        0        0        0        0        0        0 
18:       0        0        0        0        0        0        0        0 
20:       0        0        0        0        0        0        0        0 
28:       0        0        0        0        0        0        0        0 
30:       0        0        0        0        0        0        0        0 
38:       0        0        0        0        0        0        0        0 
40:       0        0        0        0        0        0        0        0 
48:       0        0        0        0        0        0        0        0 
50:       0        0        0        0        0        0        0        0 
58:       0        0        0        0        0        0        0        0 
60:       0        0        0        0        0        0        0        0 
68:       0        0        0        0        0        0        0        0 
70:       0        0        0        0        0        0        0        0 
78:       0        0        0        0        0        0        0        0 
80:       0        0        0        0        0        0        0        0 
88:       0        0        0        0        0        0        0        0 
90:       0        0        0        0        0        0        0        0 
98:       0        0        0        0        0        0        0        0 
a0:       0        0        0        0        0        0        0        0 
a8:       0        0        0        0        0        0        0        0 
b0:       0        0        0        0        0        0        0        0 
b8:       0        0        0        0        0        0        0        0 
c0:       0        0        0        0        0        0        0        0 
c8:       0        0        0        0        0        0        0        0 
d0:       0        0        0        0        0        0        0        0 
d8:       0        0        0        0        0        0        0        0 
e0:       0        0        0        0        0        0        0        0 
e8:       0        0        0        0        0        0        0        0 
f0:       0        0        0        0        0        0        0        0 
f8:       0        0        0        0        0        0        0        0 

memory(signed decimal)
 0:-804913147 -721090817 285147136 -536344567 -721091841 -805109584 -804913136 -436010234 
 8:-804913152 -486341882 -805044032 -804913136 -435944442 -804913152 -486276090 -804782079 
10:-804716542 -486210817 -804913148 -536476922 -670693889 -804913144 -536673530 -804913150 
18:-486209793 -721287681 -804913144 -519896314 -804913148 -536542458 -653982209 -486406657 
20:-486210817 -804913148 -536476922 -670693889 -804913144 -536673530 -804913008 -486209793 
28:-721287681 -804913144 -519896314 -804913148 -536542458 -653982209 -486406657 -804913104 
30:-721090817 -804782070 -754450432 -721091841 -804716534 -804913142 -788068346 -804913012 
38:-200997114 -804913152 -536542458 -670758401 -804913148 -536542458 -670758657 -486210817 
