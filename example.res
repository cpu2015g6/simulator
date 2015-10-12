to binary and back to assembly
;0:sum 1:iter 2:one 3:eq
limm	1	10		
limm	2	1	
add 	0	0	1	;r0+=r1
sub	1	1	2	;r1-=1
neq	3	1	0xff	;r3=(r1!=0)
jz	3	-3		;jump if r3


          |
          v

limm	0x1	0xa
limm	0x2	0x1
add	0x0	0x0	0x1
sub	0x1	0x1	0x2
neq	0x3	0x1	0xff
jz	0x3	0xfffd


execution log
limm	0x1	0xa
limm	0x2	0x1
add	0x0	0x0	0x1
sub	0x1	0x1	0x2
neq	0x3	0x1	0xff
jz	0x3	0xfffd
add	0x0	0x0	0x1
sub	0x1	0x1	0x2
neq	0x3	0x1	0xff
jz	0x3	0xfffd
add	0x0	0x0	0x1
sub	0x1	0x1	0x2
neq	0x3	0x1	0xff
jz	0x3	0xfffd
add	0x0	0x0	0x1
sub	0x1	0x1	0x2
neq	0x3	0x1	0xff
jz	0x3	0xfffd
add	0x0	0x0	0x1
sub	0x1	0x1	0x2
neq	0x3	0x1	0xff
jz	0x3	0xfffd
add	0x0	0x0	0x1
sub	0x1	0x1	0x2
neq	0x3	0x1	0xff
jz	0x3	0xfffd
add	0x0	0x0	0x1
sub	0x1	0x1	0x2
neq	0x3	0x1	0xff
jz	0x3	0xfffd
add	0x0	0x0	0x1
sub	0x1	0x1	0x2
neq	0x3	0x1	0xff
jz	0x3	0xfffd
add	0x0	0x0	0x1
sub	0x1	0x1	0x2
neq	0x3	0x1	0xff
jz	0x3	0xfffd
add	0x0	0x0	0x1
sub	0x1	0x1	0x2
neq	0x3	0x1	0xff
jz	0x3	0xfffd
program reached the end without error.

register(signed decimal)
 0:      55        0        1 -889271554        0        0        0        0 
 8:       0        0        0        0        0        0        0        0 
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
 0:       0        0        0        0        0        0        0        0 
 8:       0        0        0        0        0        0        0        0 
10:       0        0        0        0        0        0        0        0 
18:       0        0        0        0        0        0        0        0 
20:       0        0        0        0        0        0        0        0 
28:       0        0        0        0        0        0        0        0 
30:       0        0        0        0        0        0        0        0 
38:       0        0        0        0        0        0        0        0 
