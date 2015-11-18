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
        "hlt":0xD6,#simlator senyou
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
        "finv":0xFA,
        "fsqrt":0xFE,
        "fcmp":0xFF,
        }

ignore={".text",".globl",".align",".data",".literal8"}
nowrite=ignore
onereg={"limm","j","in","out","hlt"}

def get_labels(program):
    instnum=0
    labels={}
    datalist=[]
    longmem=0x0
    for inst in program:
        if len(inst)==0 or (inst[0] in nowrite):#nowrite or empty
            continue
        elif inst[0]==".long":
            datalist.append(float_to_cfloat(fimm(inst[1])))
        elif ":" in inst[0]:#label
            if inst[0].startswith("l."):
                labels[inst[0]]=longmem
                longmem+=1
            else:
                labels[inst[0]]=instnum
        else:#inst 
            instnum+=1
    for l in labels.iteritems():
        print l
    return instnum,len(datalist),labels,datalist
    
def reg(s):
    if not s.startswith("r"):
        print "'{}' is not a register".format(s)
    return int("0x"+s[1:],0)

def imm(s,label):
    if s+":" in label:
        return label[s+":"]
    else:
        return int(s,0)

def int_to_bytearray(a):
    return bytearray([a/0x1000000,(a/0x10000)%256 ,(a/0x100)%256 ,a%256])
        
def float_to_cfloat(a):
    if a>=0:
        sign=0
    else:
        sign=1
    
    a=abs(a)

    if a!=0:
        m,e=math.frexp(a)
        expo=int(e+126)
        man=int((m-0.5)*pow(2,24))
    else:
        expo=0
        man=0
    
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


def write_binary(fp,fp_comment,program,program_org,labels):
    instno=0
    for line,inst in enumerate(program):
        wrote_flag=False
        #print line
        #print inst
        if len(inst)==0:#nothing
            pass
        elif inst[0] in ignore:
            pass
        elif inst[0] in labels:
            pass
        elif inst[0]==".long":#long
            pass
            #fp.write(float_to_cfloat(fimm(inst[1])))
            #wrote_flag=True
        elif inst[0] in onereg:#one reg operation
            if not(len(inst)==3):
                print "wrong number of args in line {}.".format(line)
                print " ".join(inst)
                exit(1)
            else:
                write_inst(fp,\
                           opdict[inst[0]],\
                           reg(inst[1]),\
                           (imm(inst[2],labels)/0x100)%0x100,\
                           imm(inst[2],labels)%0x100,\
                )
                wrote_flag=True
        elif inst[0] in opdict:#three reg operation
            if not(len(inst)==4 or len(inst)==3):#delete!
                print "wrong number of args in line {}.".format(line)
                print " ".join(inst)
                exit(1)
            else:
                write_inst(fp,\
                           opdict[inst[0]],\
                           reg(inst[1]),\
                           reg(inst[2]),\
                           reg(inst[3]),\
                )
                wrote_flag=True
        else:
            print "undefined opcode in line {}".format(line)
            print " ".join(inst)
            exit(1)
        if wrote_flag==True:
            fp_comment.write(program_org[line].ljust(35)+"\t#{0:03X}\n".format(instno))
            instno+=1
        else:
            fp_comment.write(program_org[line]+"\n")

def write_datasection(fp,datalist):
    for d in datalist:
        fp.write(d)
    
#================main=================
def main():
    argv=sys.argv
    file_in_name=sys.argv[1]
    file_out_name=sys.argv[1].split(".")[0]+".dat"
    file_comment_name=sys.argv[1].split(".")[0]+".com"
    file_in=open(file_in_name,"r")
    file_out=open(file_out_name,"wb")
    file_comment=open(file_comment_name,"w")

    #load program and parse
    program_org= file_in.read().split("\n")
    program=[list(chain.from_iterable([ss.split() for ss in s.split("#")[0].split(",")])) for s in program_org]

    #get instnum & labels
    textlen,datalen,labels,datalist=get_labels(program)

    file_out.write(int_to_bytearray(textlen))#header
    file_out.write(int_to_bytearray(datalen))#header
    write_binary(file_out,file_comment,program,program_org,labels)#text
    write_datasection(file_out,datalist)#data
    
    print("Assembling succeeded.")
    print("Dumped '{}' ({} instructions).".format(file_out_name,textlen+datalen))
    print("textlen:{} datalen:{}".format(textlen,datalen))
    print("Dumped '{}'.".format(file_out_name))
    print("Dumped '{}'.".format(file_comment_name))


if __name__ =="__main__":
    main()

#kuso code ni nattekita node ituka naosu
