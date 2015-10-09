#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include "iroiro.h"
#include "exec.h"

void exec(uint32_t inst,FILE *fp){
  uint32_t opcode=takebits(inst,0,8);
  uint32_t reg1=takebits(inst,8,16);
  uint32_t reg2=takebits(inst,16,24);
  uint32_t reg3=takebits(inst,24,32);
  uint32_t imm=takebits(inst,8,32);
  //  printf("%x:%x %x %x %x\n",inst,opcode,reg1,reg2,reg3);

  char* opname="!unassigned opcode!";
  int argnum=0;
  
  switch(opcode){
  case 0xD0:
    opname="limm";
    argnum=1;
    break;

  case 0xD4:
    opname="j";
    argnum=1;
    break;

  case 0xD5:
    opname="jz";
    argnum=1;
    break;

  case 0xD6:
    opname="jr";
    argnum=3;
    break;

  case 0xD8:
    opname="stw";
    argnum=3;
    break;

  case 0xD9:
    opname="ldw";
    argnum=3;
    break;

  case 0xDA:
    opname="str";
    argnum=3;
    break;

  case 0xDB:
    opname="ldr";
    argnum=3;
    break;

  case 0xE0:
    opname="add";
    argnum=3;
    break;

  case 0xE1:
    opname="sub";
    argnum=3;
    break;

  case 0xE2:
    opname="and";
    argnum=3;
    break;

  case 0xE3:
    opname="or";
    argnum=3;
    break;

  case 0xE4:
    opname="xor";
    argnum=3;
    break;

  case 0xE5:
    opname="not";
    argnum=3;
    break;

  case 0xE6:
    opname="shl";
    argnum=3;
    break;

  case 0xE7:
    opname="shr";
    argnum=3;
    break;

  case 0xF0:
    opname="eq";
    argnum=3;
    break;

  case 0xF1:
    opname="neq";
    argnum=3;
    break;

  case 0xF2:
    opname="gt";
    argnum=3;
    break;

  case 0xF3:
    opname="gte";
    argnum=3;
    break;
    
  case 0xF4:
    opname="lt";
    argnum=3;
    break;

  case 0xF5:
    opname="lte";
    argnum=3;
    break;

  case 0xF8:
    opname="fadd";
    argnum=3;
    break;

  case 0xF9:
    opname="fmul";
    argnum=3;
    break;

  case 0xFA:
    opname="fdiv";
    argnum=3;
    break;

  case 0xFB:
    opname="fsin";
    argnum=3;
    break;

  case 0xFC:
    opname="fcos";
    argnum=3;
    break;

  case 0xFD:
    opname="fatan";
    argnum=3;
    break;

  case 0xFE:
    opname="fsqrt";
    argnum=3;
    break;
  }

  fprintf(fp,"%s\t",opname);
  if(argnum==1)
    fprintf(fp,"r%x\t%x",reg1,imm);
  else if(argnum==3)
    fprintf(fp,"r%x\tr%x\tr%x",reg1,reg2,reg3);
  fprintf(fp,"\n");
  
}


