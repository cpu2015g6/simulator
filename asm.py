#!/usr/bin/env python
# -*- coding: utf-8 -*-

import sys
from itertools import chain
import math

opdict={"limm":0xD0,
        "cmp":0xD1,
        "in":0xD2,
        "out":0xD3,
        "j":0xD4,
        "jr":0xD5,
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
        "sll":0xE6,
        "srl":0xE7,
        "jreq":0xF0,
        "jrneq":0xF1,
        "jrgt":0xF2,
        "jrgte":0xF3,
        "jrlt":0xF4,
        "jrlte":0xF5,
        "fadd":0xF8,
        "fmul":0xF9,
        "fdiv":0xFA,
        "fsin":0xFB,
        "fcos":0xFC,
        "fatan":0xFD,
        "fqrt":0xFE,
        "fcmp":0xFF,
        }

ignore={".text",".globl",".align",".data",".literal8"}
nowrite=ignore
onereg={"limm","j","in","out"}

def get_labels(program):
    instnum=0
    labels={}
    for inst in program:
        if len(inst)==0 or (inst[0] in nowrite):#nowrite or empty
            continue
        elif ":" in inst[0]:#label
            labels[inst[0]]=instnum
        else:#inst & ".long"
            instnum+=1
    return labels,instnum

def reg(s):
    if not s.startswith("r"):
        print "'{}' is not a register".format(s)
    return int("0x"+s[1:],0)

def imm(s,label):
    if s+":" in label:
        return label[s+":"]
    else:
        return int(s)

def float_to_cfloat(a):
    if a>=0:
        sign=0
    else:
        sign=1
        
    a=abs(a)
    
    expo=int(math.log(a,2))+127
    man=int(a/(2**(expo-127-23))-2**23)
    ret="{0:1b}".format(sign)
    ret+="{0:0>8b}".format(expo)
    ret+="{0:0>23b}".format(man)
    byte=[0,0,0,0]
    for i in range(4):
        byte[i]=int(ret[i*8:(i+1)*8],2)
    return bytearray(byte)
        
def fimm(s):
    if s.endswith("d"):
        return float(s[:-1])#todo
    else:
        print("{} is not a float".format(s))
        exit(1)
        
        
def write_inst(fp,a,b,c,d):
    fp.write(bytearray([a,b,c,d]))


def write_binary(fp,program,labels):
    for line,inst in enumerate(program):
        print line
        if len(inst)==0:#nothing
            continue
        elif inst[0] in ignore:
            continue
        elif inst[0] in labels:
            continue
        elif inst[0]==".long":#long
            fp.write(float_to_cfloat(fimm(inst[1])))
        elif inst[0] in onereg:#one reg operation
            if not(len(inst)==3):
                print "wrong number of args in line {}.".format(line)
                print " ".join(inst)
                exit(1)
            else:
                write_inst(fp,\
                           opdict[inst[0]],\
                           reg(inst[1]),\
                           imm(inst[2],labels)/0x100,\
                           imm(inst[2],labels)%0x100,\
                )
        elif inst[0] in opdict:#three reg operation
            if not(len(inst)==4):
                print "wrong number of args in line {}.".format(line)
                print "'{}'".join(inst)
                exit(1)
            else:
                write_inst(fp,\
                           opdict[inst[0]],\
                           reg(inst[1]),\
                           reg(inst[2]),\
                           reg(inst[3]),\
                )
        else:
            print "undefined opcode in line {}".format(line)
            print " ".join(inst)
            exit(1)

#================main=================
argv=sys.argv
file_in_name=sys.argv[1]
file_out_name=sys.argv[1].split(".")[0]+".dat"
file_in=open(file_in_name,"r")
file_out=open(file_out_name,"wb")

#load program and parse
program=[list(chain.from_iterable([ss.split() for ss in s.split("#")[0].split(",")])) for s in file_in.read().split("\n")]

#get instnum & labels
labels,instnum=get_labels(program)

write_binary(file_out,program,labels)

print("Assembling succeeded.")
print("Dumped '{}' ({} instructions).".format(file_out_name,instnum))
