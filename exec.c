#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "iroiro.h"
#include "exec.h"
#include "fpu.h"

uint32_t data[DATA_SIZE];
uint32_t stack[STACK_SIZE];
uint32_t heap[HEAP_SIZE];
uint32_t r[256];

#define PATLEN 3//gomi atode kesu
uint32_t last[PATLEN];
int patterncount=0;

uint32_t* memory(int no){
  if(HEAP_START<=no && no<HEAP_START+HEAP_SIZE)
    return heap+(no-HEAP_START);
  if(STACK_START<=no && no<STACK_START+STACK_SIZE)
    return stack+(no-STACK_START);
  if(DATA_START<=no && no<DATA_START+DATA_SIZE)
    return data+(no-DATA_START);
  else
    return NULL;
}


void printmem(FILE *fp,int mem,int hexmode){
  fprintf(fp,"\tmem %x:",mem);
  if(hexmode)
    fprintf(fp,"0x%x",*memory(mem));
  else
    fprintf(fp,"%d",*memory(mem));
}

void printreg(FILE *fp,int reg,int hexmode){
  fprintf(fp,"\tr%x:",reg);
  if(hexmode)
    fprintf(fp,"0x%x",r[reg]);
  else
    fprintf(fp,"%d",r[reg]);
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
	if(fp!=NULL)
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
	if(fp!=NULL)
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
      r[rt]=f2u(u2f(r[ra])+u2f(r[rb]));
      //r[rt]=fadd(r[ra],r[rb]);
    }
    break;

  case 0xF9:
    opname="fmul";
    argnum=3;
    if(execmode){
      r[rt]=f2u(u2f(r[ra])*u2f(r[rb])); 
      //r[rt]=fmul(r[ra],r[rb]);
    }
    break;

  case 0xFA:
    opname="finv";
    argnum=3;
    if(execmode){
      r[rt]=f2u(1/u2f(r[ra]));
      //r[rt]=fdiv(r[ra],r[rb]);
    }
    break;

  case 0xFE:
    opname="fsqrt";
    argnum=3;
    if(execmode){
      r[rt]=f2u(sqrt(u2f(r[ra])));
      //r[rt]=fsqrt(r[ra]);
    }
    break;

  case 0xFF:
    opname="fcmp";
    argnum=3;
    if(execmode){
      if(u2f(r[ra])>u2f(r[rb]))
	r[rt]=2;
      else if(u2f(r[ra])==u2f(r[rb]))
	r[rt]=1;
      else
	r[rt]=0;
      /*
      if(fcmp(r[ra],r[rb])==1)  <= kawatta
	r[rt]=2;
      else if(fcmp(r[ra],r[rb])==0)
	r[rt]=1;
      else
	r[rt]=0;
      */
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
      
      printreg(fp,2,1);
      printreg(fp,5,1);
      printreg(fp,6,1);
      printreg(fp,7,1);
      printreg(fp,8,1);
      printreg(fp,9,1);
      printreg(fp,0xa,1);
      printreg(fp,0x18,1);
      printreg(fp,0x19,1);
      printmem(fp,0xae,1);
      int i=0;
      for(i=0;i<PATLEN-1;i++){//log ni haittenai 
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

