#!/usr/bin/env python
# -*- coding: utf-8 -*-

import sys

opdict={"limm":0xD0,
        "j":0xD4,
        "jz":0xD5,
        "jr":0xD6,
        "stw":0xD8,
        "ldw":0xD9,
        "str":0xDA,
        "ldr":0xDB,
        "add":0xE0,
        "sub":0xE1,
        "and":0xE2,
        "or":0xE3,
        "xor":0xE4,
        "not":0xE5,
        "shl":0xE6,
        "shr":0xE7,
        "eq":0xF0,
        "neq":0xF1,
        "gt":0xF2,
        "gte":0xF3,
        "lt":0xF4,
        "lte":0xF5,
        "fadd":0xF8,
        "fmul":0xF9,
        "fdiv":0xFA,
        "fsin":0xFB,
        "fcos":0xFC,
        "fatan":0xFD,
        "fqrt":0xFE,
        }

arg1={"limm","j","jz"}

errorflag=False

def to_bin(s):
    parsed=(s.split(";")[0]).split()
    if parsed[0] in opdict:
        byte1=opdict[parsed[0]]
    else:
        print("!error\t:no such opcode:'{}'!".format(parsed[0]))
        errorflag=True
        return bytearray([0,0,0,0])
    if parsed[0] in arg1:
        if len(parsed)!=3:
            print("wrong number of args:")
            print("'"+s+"'")
            errorflag=True
            return bytearray([0,0,0,0])
        imm=int(parsed[2],0)%0x10000
        byte2=int(parsed[1],0)
        byte3=imm/0x100
        byte4=imm%0x100
    else:
        if len(parsed)!=4:
            print("wrong number of args:")
            print("'"+s+"'")
            errorflag=True
            return bytearray([0,0,0,0])
        byte2=int(parsed[1],0)
        byte3=int(parsed[2],0)
        byte4=int(parsed[3],0)
    return bytearray([byte1,byte2,byte3,byte4])

argv=sys.argv
file_in_name=sys.argv[1]
file_out_name=sys.argv[1].split(".")[0]+".dat"
file_in=open(file_in_name,"r")
file_out=open(file_out_name,"wb")
instnum=0

while True:
    line=file_in.readline()
    if line=="":
        break
    elif (line.split(";")[0]).split()==[]:
        continue
    else:
        file_out.write(to_bin(line))
        instnum+=1

if errorflag:
    print("Couldn't read some of the instructions correctly.")
    print("Assembling failed.")
    os.remove(file_out_name)
else:
    print("Assembling succeeded.")
    print("Dumped '{}' ({} instructions).".format(file_out_name,instnum))
