#!/usr/bin/env python
# -*- coding: utf-8 -*-

import sys
import math
import os
from itertools import chain

op1={"limm":1,"in":2,"out":3,"hlt":4}
op2i={"stwi":1,"ldwi":2,"jif":3,"ci":4,"addi":5,"subi":6}
op2ic={"cmpic":1,"cmpaic":2,"jic":3,"fjic":4}
op3c={"cmpc":1,"fcmpc":2,"cmpac":3,"fcmpac":4,"jrc":5,"fjrc":6}
op3={"jrf":0,"cr":1,"stw":2,"ldw":3,"add":4,"sub":5,"and":6,"or":7,"xor":8,"sll":9,"srl":10,"fadd":11,"fsub":12,"fmul":13,"finv":14,"faba":15,"fsqrt":16}

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
            datalist.append(int_to_bytearray(int(inst[1])))
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

def cond(s,label):
    ret=imm(s,label)
    assert(0<=ret and ret<=6)
    return ret
        
def int_to_bytearray(a):
    return bytearray([a/0x1000000,(a/0x10000)%256 ,(a/0x100)%256 ,a%256])
    
def float_to_bytearray(a):
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


#=========================================================================--            
        elif inst[0] in op1:
            if not(len(inst)==3):
                print "wrong number of args in line {}.".format(line)
                print " ".join(inst)
                exit(1)
            else:
                vl=[op1[inst[0]] , reg(inst[1]) , imm(inst[2],labels) ,0]
                sl=[9,5,16,2]
                fp.write(concat(vl,sl))
                wrote_flag=True
                
        elif inst[0] in op2i:
            if not(len(inst)==4):
                print "wrong number of args in line {}.".format(line)
                print " ".join(inst)
                exit(1)
            else:
                vl=[op2i[inst[0]] , reg(inst[1]) , reg(inst[2]) , imm(inst[3],labels)]
                sl=[6,5,5,16]
                fp.write(concat(vl,sl))
                wrote_flag=True

        elif inst[0] in op2ic:
            if not(len(inst)==5):
                print "wrong number of args in line {}.".format(line)
                print " ".join(inst)
                exit(1)
            else:
                vl=[op2ic[inst[0]] ,cond(inst[4],labels) , reg(inst[1]) , reg(inst[2]) , imm(inst[3],labels)]
                sl=[3,3,5,5,16]
                fp.write(concat(vl,sl))
                wrote_flag=True

        elif inst[0] in op3c:
            if not(len(inst)==5):
                print "wrong number of args in line {}.".format(line)
                print " ".join(inst)
                exit(1)
            else:
                vl=[op3c[inst[0]] ,cond(inst[4],labels) , reg(inst[1]) , reg(inst[2]) , reg(inst[3]) , 0]
                sl=[12,3,5,5,5,2]
                fp.write(concat(vl,sl))
                wrote_flag=True

        elif inst[0] in op3:
            if not(len(inst)==4):
                print "wrong number of args in line {}.".format(line)
                print " ".join(inst)
                exit(1)
            else:
                vl=[op3[inst[0]] , reg(inst[1]) , reg(inst[2]) , reg(inst[3])]
                sl=[17,5,5,5]
                fp.write(concat(vl,sl))
                wrote_flag=True
#================================================================================        
        
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

        
def concat(vl,sl):
    l=[]
    for v,s in zip(vl,sl):
        a="0:0>{}b".format(s)
        a="{"+a+"}"
        a=a.format(v)
        assert(len(a)==s)
        l.append(a)
    return int_to_bytearray( int("".join(l),2) )
            
        
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
