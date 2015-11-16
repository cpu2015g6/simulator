#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include "iroiro.h"
#include "exec.h"
#include "fpu.h"

#define MEM_STACK 0x0b00000
#define MEM_HEAP  0x0c00000
#define MEM_END   0x1000000
uint32_t data[MEM_DATA];
uint32_t stack[MEM_END-MEM_HEAP];
uint32_t heap[MEM_HEAP-MEM_STACK];
uint32_t r[256];

#define PATLEN 3
uint32_t last[PATLEN];
int patterncount=0;

uint32_t* memory(int no){
  if(0<=no && no<MEM_DATA)
    return data+(no);
  else if(MEM_STACK<=no && no<MEM_HEAP)
    return stack+(no-MEM_STACK);
  else if(MEM_HEAP<= no && no<MEM_END)
    return heap+(no-MEM_HEAP);
  else
    return NULL;
}

void printreg(FILE *fp,int reg,int hexmode){
  fprintf(fp,"\tr%x:",reg);
  if(hexmode)
    fprintf(fp,"0x%x",r[reg]);
  else
    fprintf(fp,"%d",r[reg]);
}

void printstack(FILE *fp,int no,int hexmode){
  fprintf(fp,"\tS%x:",no);
  if(hexmode)
    fprintf(fp,"0x%x",stack[no]);
  else
    fprintf(fp,"%d",stack[no]);
}

void printheap(FILE *fp,int no,int hexmode){
  fprintf(fp,"\tH%x:",no);
  if(hexmode)
    fprintf(fp,"0x%x",heap[no]);
  else
    fprintf(fp,"%d",heap[no]);
}

int exec(uint32_t inst,int pc,int execmode,FILE *fp,FILE *mystdin,FILE *mystdout){
  int nextpc=pc+1;
  uint32_t opcode=takebits(inst,0,8);
  uint32_t rt=takebits(inst,8,16);
  uint32_t ra=takebits(inst,16,24);
  uint32_t rb=takebits(inst,24,32);
  uint32_t imm=takebits(inst,16,32);

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
    
  case 0xD1:
    opname="cmp";
    argnum=3;
    if(execmode){
      if (u2i(r[ra])>u2i(r[rb]))
	r[rt]=2;
      else if (u2i(r[ra])==u2i(r[rb]))
	r[rt]=1;
      else
	r[rt]=0;
    }
    break;

  case 0xD2:
    opname="in";
    argnum=1;
    if(execmode){
      unsigned char a;
      fread(&a,sizeof(unsigned char),1,mystdin);
      r[rt]=a;
      //printf("in! %d\n",r[rt]);
    }
    break;

  case 0xD3:
    opname="out";
    argnum=1;
    if(execmode){
      unsigned char a=r[rt]%0x100;
      //printf("out! %d\n",a);
      fwrite(&a , sizeof(char) , 1 , mystdout);
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
    opname="jr";
    argnum=3;
    if(execmode){
      nextpc=r[ra];
      r[rt]=pc+1;
    }
    break;

  case 0xD8:
    opname="stw";
    argnum=3;
    if(execmode){
      uint32_t* address=memory(r[rt]);
      if(address==NULL){
	printf("tried to write bad address 0x%x in r%x. aborting...\n",r[rt],rt);
	fprintf(fp,"tried to write bad address 0x%x in r%x. aborting...\n",r[rt],rt);
        return BADMEMORY;
      }
      *address=r[ra];
    }
    break;

  case 0xD9:
    opname="ldw";
    argnum=3;
    if(execmode){
      uint32_t* address=memory(r[ra]);
      if(address==NULL){
	printf("tried to read bad address 0x%x in r%x. aborting...\n",r[ra],ra);
	fprintf(fp,"tried to read bad address 0x%x in r%x. aborting...\n",r[ra],ra);
        return BADMEMORY;
      }
      r[rt]=*address;
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
    opname="sll";
    argnum=3;
    if(execmode){
      if(r[rb]>=32)
	r[rt]=0;
      else
        r[rt]=r[ra] << r[rb];
    }
    break;

  case 0xE7:
    opname="srl";
    argnum=3;
    if(execmode){
      if(r[rb]>=32)
	r[rt]=0;
      else
        r[rt]=r[ra] >> r[rb];
    }
    break;

  case 0xF0:
    opname="jreq";//kono siri-zu zenbu
    argnum=3;
    if(execmode){
      if(r[ra]==1){
	nextpc=r[rb];
      }
      r[rt]=pc+1;
    }
    break;

  case 0xF1:
    opname="jrneq";
    argnum=3;
    if(execmode){
      if(r[ra]!=1){
	nextpc=r[rb];
      }
      r[rt]=pc+1;
    }
    break;

  case 0xF2:
    opname="jrgt";
    argnum=3;
    if(execmode){
      if(r[ra]==2){
	nextpc=r[rb];
      }
      r[rt]=pc+1;
    }
    break;

  case 0xF3:
    opname="jrgte";
    argnum=3;
    if(execmode){
      if(r[ra]!=0){
	nextpc=r[rb];
      }
      r[rt]=pc+1;
    }
    break;
    
  case 0xF4:
    opname="jrlt";
    argnum=3;
    if(execmode){
      if(r[ra]==0){
	nextpc=r[rb];
      }
      r[rt]=pc+1;
    }
    break;

  case 0xF5:
    opname="jrlte";
    argnum=3;
    if(execmode){
      if(r[ra]!=2){
	nextpc=r[rb];
      }
      r[rt]=pc+1;
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

  case 0xFF:
    opname="fcmp";
    argnum=3;
    if(execmode){
      if(fcmp(r[ra],r[rb])==1)
	r[rt]=2;
      else if(fcmp(r[ra],r[rb])==0)
	r[rt]=1;
      else
	r[rt]=0;
    }
    break;

  case 0xD6:
    opname="halt";
    argnum=0;
    if(execmode){
      nextpc=HALTPC;
    }
    break;
    
  default:
    opname="!unassigned opcode!";
    argnum=0;
    if(execmode){
      nextpc=INVALIDINSTPC;
    }
    break;
    
  }

  if(fp!=NULL){
    fprintf(fp,"%s\t",opname);
    if(argnum==1)
      fprintf(fp,"0x%x\t0x%x\t\t",rt,imm);
    else if(argnum==3)
      fprintf(fp,"0x%x\t0x%x\t0x%x\t",rt,ra,rb);
    else
      fprintf(fp,"invalid instruction:%x",inst);
    fprintf(fp,"#%03x",pc);
    if(execmode){
      /*
      printreg(fp,2,1);
      printreg(fp,5,1);
      printreg(fp,6,1);
      printreg(fp,7,1);
      printreg(fp,8,1);
      printreg(fp,9,1);
      printreg(fp,0xa,1);
      printreg(fp,0x18,1);
      printreg(fp,0x19,1);
      printstack(fp,0xf0,1);
      printstack(fp,0xfc,1);
      printheap(fp,0x30,1);
      */
      int i=0;
      for(i=0;i<PATLEN-1;i++){
	last[i]=last[i+1];
      }
      last[PATLEN-1]=opcode;
      if(last[0]==0xE6 && last[1]==0xD0 && last[2]==0xE3)
	patterncount++;
      
    }
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
  for(i=0;i<32;i++){
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

