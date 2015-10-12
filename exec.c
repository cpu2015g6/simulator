#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include "iroiro.h"
#include "exec.h"
#include "fpu.h"

uint32_t memory[100000];
uint32_t r[256];
int unassignedfound=0;

int exec(uint32_t inst,int pc,int execmode,FILE *fp){
  int nextpc=pc+1;
  uint32_t opcode=takebits(inst,0,8);
  uint32_t rt=takebits(inst,8,16);
  uint32_t ra=takebits(inst,16,24);
  uint32_t rb=takebits(inst,24,32);
  uint32_t imm=takebits(inst,16,32);
  //  printf("%x:%x %x %x %x\n",inst,opcode,reg1,reg2,reg3);

  char* opname;
  int argnum;
  
  switch(opcode){
  case 0xD0:
    opname="limm";
    argnum=1;
    if(execmode){
      r[rt]=imm;
    }
    break;

  case 0xD4:
    opname="j";
    argnum=1;
    if(execmode){
      nextpc=pc+u2i16(imm);
      r[rt]=pc+1;
    }
    break;

  case 0xD5:
    opname="jz";
    argnum=1;
    if(execmode){
      if(r[rt]==0){
	nextpc=pc+u2i16(imm);
      } 
    }
    break;
    
  case 0xD6:
    opname="jr";
    argnum=3;
    if(execmode){
      nextpc=ra;
      r[rt]=pc+1;
    }
    break;

  case 0xD8:
    opname="stw";
    argnum=3;
    if(execmode){
      memory[rt]=ra;
    }
    break;

  case 0xD9:
    opname="ldw";
    argnum=3;
    if(execmode){
      rt=memory[ra];
    }
    break;

  case 0xDA:
    opname="str";
    argnum=3;
    if(execmode){
      int i=0;
      for(i=0;i<=rb-ra;i++){
	memory[rt+i]=r[i+ra];
      }
    }
    break;

  case 0xDB:
    opname="ldr";
    argnum=3;
    if(execmode){
      int i=0;
      for(i=0;i<=rb-ra;i++){
	r[i+ra]=memory[rt+i];
      }
    }
    break;

  case 0xE0:
    opname="add";
    argnum=3;
    if(execmode){
      r[rt]=r[ra]+r[rb];
    }
    break;

  case 0xE1:
    opname="sub";
    argnum=3;
    if(execmode){
      r[rt]=r[ra]-r[rb];
    }
    break;

  case 0xE2:
    opname="and";
    argnum=3;
    if(execmode){
      r[rt]=r[ra]&r[rb];
    }
    break;

  case 0xE3:
    opname="or";
    argnum=3;
    if(execmode){
      r[rt]=r[ra]|r[rb];
    }
    break;

  case 0xE4:
    opname="xor";
    argnum=3;
    if(execmode){
      r[rt]=r[ra]^r[rb];
    }
    break;

  case 0xE5:
    opname="not";
    argnum=3;
    if(execmode){
      r[rt]=~r[ra];
    }
    break;

  case 0xE6:
    opname="shl";
    argnum=3;
    if(execmode){
      r[rt]=r[ra]<<r[rb];
    }
    break;

  case 0xE7:
    opname="shr";
    argnum=3;
    if(execmode){
      r[rt]=r[ra]>>r[rb];
    }
    break;

  case 0xF0:
    opname="eq";
    argnum=3;
    if(execmode){
      if(r[ra]==r[rb])
	r[rt]=0;
      else
	r[rt]=1;
    }
    break;

  case 0xF1:
    opname="neq";
    argnum=3;
    if(execmode){
      if(r[ra]!=r[rb])
	r[rt]=0;
      else
	r[rt]=1;
    }
    break;

  case 0xF2:
    opname="gt";
    argnum=3;
    if(execmode){
      if(r[ra]>r[rb])
	r[rt]=0;
      else
	r[rt]=1;
    }
    break;

  case 0xF3:
    opname="gte";
    argnum=3;
    if(execmode){
      if(r[ra]>=r[rb])
	r[rt]=0;
      else
	r[rt]=1;
    }
    break;
    
  case 0xF4:
    opname="lt";
    argnum=3;
    if(execmode){
      if(r[ra]<r[rb])
	r[rt]=0;
      else
	r[rt]=1;
    }
    break;

  case 0xF5:
    opname="lte";
    argnum=3;
    if(execmode){
      if(r[ra]<=r[rb])
	r[rt]=0;
      else
	r[rt]=1;
    }
    break;

  case 0xF8:
    opname="fadd";
    argnum=3;
    if(execmode){
      r[rt]=fadd(r[ra],r[rb]);
    }
    break;

  case 0xF9:
    opname="fmul";
    argnum=3;
    if(execmode){
      r[rt]=fmul(r[ra],r[rb]);
    }
    break;

  case 0xFA:
    opname="fdiv";
    argnum=3;
    if(execmode){
      r[rt]=fdiv(r[ra],r[rb]);
    }
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
    if(execmode){
      r[rt]=fsqrt(r[ra]);
    }
    break;

  default:
    opname="!unassigned opcode!";
    argnum=0;
    unassignedfound=1;
    break;
    
  }

  if(fp!=NULL){
    fprintf(fp,"%s\t",opname);
    if(argnum==1)
      fprintf(fp,"0x%x\t0x%x",rt,imm);
    else if(argnum==3)
      fprintf(fp,"0x%x\t0x%x\t0x%x",rt,ra,rb);
    else
      fprintf(fp,"instruction:%x",inst);
    fprintf(fp,"\n");
  }
  
  return nextpc;
}


void dumpreg(int hexmode,FILE* fp){
  if(hexmode)
    fprintf(fp,"register(hex)");
  else
    fprintf(fp,"register(signed decimal)");
  int i=0;
  for(i=0;i<256;i++){
    if(i%8==0){
      if(hexmode)
	fprintf(fp,"\n%2x:",i);
      else
	fprintf(fp,"\n%2x:",i);
    }
    if(hexmode)
      fprintf(fp,"%08x ",r[i]);
    else
      fprintf(fp,"%8d ",r[i]);
  }
  fprintf(fp,"\n");
}


void dumpmem(int num,int hexmode,FILE* fp){
  if(hexmode)
    fprintf(fp,"memory(hex)");
  else
    fprintf(fp,"memory(signed decimal)");
  int i=0;
  for(i=0;i<num;i++){
    if(i%8==0){
      if(hexmode)
	fprintf(fp,"\n%2x:",i);
      else
	fprintf(fp,"\n%2x:",i);
    }
    if(hexmode)
      fprintf(fp,"%08x ",memory[i]);
    else
      fprintf(fp,"%8d ",memory[i]);
  }
  fprintf(fp,"\n");
}
