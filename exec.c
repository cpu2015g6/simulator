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
long int count[256];

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

  if(execmode){
    count[opcode]++;
  }
  
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
	printf("tried to write bad address 0x%x in r%x (pc is %x). aborting...\n",r[rt],rt,pc);
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
	printf("tried to read bad address 0x%x in r%x (pc is %x). aborting...\n",r[ra],ra,pc);
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
      //r[rt]=f2u(u2f(r[ra])+u2f(r[rb]));
      r[rt]=fadd(r[ra],r[rb]);
    }
    break;

  case 0xF9:
    opname="fmul";
    argnum=3;
    if(execmode){
      //r[rt]=f2u(u2f(r[ra])*u2f(r[rb])); 
      r[rt]=fmul(r[ra],r[rb]);
    }
    break;

  case 0xFA:
    opname="finv";
    argnum=3;
    if(execmode){
      //r[rt]=f2u(1/u2f(r[ra]));
      r[rt]=finv(r[ra]);
    }
    break;

  case 0xFE:
    opname="fsqrt";
    argnum=3;
    if(execmode){
      //r[rt]=f2u(sqrt(u2f(r[ra])));
      r[rt]=fsqrt(r[ra]);
    }
    break;

  case 0xFF:
    opname="fcmp";
    argnum=3;
    if(execmode){
      /*
      if(u2f(r[ra])>u2f(r[rb]))
	r[rt]=2;
      else if(u2f(r[ra])==u2f(r[rb]))
	r[rt]=1;
      else
	r[rt]=0;
      */
      r[rt]=fcmp(r[ra],r[rb]);      
    }
    break;

  case 0xD6:
    opname="halt";
    argnum=0;
    if(execmode){
      printf("you hit halt! pc:%x \n",pc);
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
  /*
  if(execmode){
#define mainfunc 0x5fea//temp
    if((pc>mainfunc && nextpc<mainfunc))
      printf("pc :%x -> %x \n",pc,nextpc);
  }
  */
  return nextpc;
}

uint32_t cmpc(uint32_t c,uint32_t a,uint32_t b){
  if(u2i(a)>u2i(b))
    return c & 4 ? 1 : 0;
  else if(u2i(a)==u2i(b))
    return c & 2 ? 1 : 0;
  else
    return c & 1 ? 1 : 0;
}

uint32_t cmpcimm(uint32_t c,uint32_t a,uint32_t b){
  if(u2i(a)>u2i(b))
    return c & 4 ? 1 : 0;
  else if(u2i(a)==u2i(b))
    return c & 2 ? 1 : 0;
  else
    return c & 1 ? 1 : 0;
}

uint32_t fcmpc(uint32_t c,uint32_t a,uint32_t b){
  if(fcmp(a,b)==1)
    return c & 4 ? 1 : 0;
  else if(fcmp(a,b)==0)
    return c & 2 ? 1 : 0;
  else
    return c & 1 ? 1 : 0;
}

int exec2(uint32_t inst,int pc,int execmode,FILE *fp,FILE *mystdin,FILE *mystdout){
  int nextpc=pc+1;
  
  int optype=-1;
  int opcode=-1;
  r[0x1f]=0;
  
  if(takebits(inst,0,3)!=0){
    optype=OP2IC;
    opcode=takebits(inst,0,3);
  }else if(takebits(inst,3,6)!=0){
    optype=OP2I;
    opcode=takebits(inst,3,6);
  }else if(takebits(inst,6,9)!=0){
    optype=OP1;
    opcode=takebits(inst,6,9);
  }else if(takebits(inst,9,12)!=0){
    optype=OP3C;
    opcode=takebits(inst,9,12);
  }else{
    optype=OP3;
    opcode=takebits(inst,12,17);
  }

  char* opname;

  if(execmode){
    count[opcode]++;
  }

  uint32_t cond=-1;
  uint32_t ra=-1;
  uint32_t rb=-1;
  uint32_t rc=-1;
  uint32_t imm=-1;
  
  switch(optype){
  case OP2IC:
    cond=takebits(inst,3,6);
    ra=takebits(inst,6,11);
    rb=takebits(inst,11,16);
    imm=takebits(inst,16,32);
    switch(opcode){
      
    case 1:
      opname="cmpic";
      if(execmode){
	r[ra]=cmpcimm(cond,r[rb],imm);
      }
      break;

    case 2:
      opname="cmpaic";
      if(execmode){
	r[ra]=r[ra]&cmpcimm(cond,r[rb],imm);
      }
      break;

    case 3:
      opname="jic";
      if(execmode){
	if(cmpc(cond,r[ra],r[rb])){
	  nextpc=imm;
	}else{
	  nextpc=pc+1;
	}
      }
      break;

    case 4:
      opname="fjic";
      if(execmode){
	if(fcmpc(cond,r[ra],r[rb]))
	  nextpc=imm;
	else
	  nextpc=pc+1;
      }
      break;

    default:
      opname="!unassigned opcode!";
      if(execmode){
	nextpc=INVALIDINSTPC;
      }
      break;
    }
    if(fp!=NULL){
      fprintf(fp,"%s\t",opname);
      fprintf(fp,"r%x\tr%x\t%d\t%d\t\t",ra,rb,imm,cond);
    }
    break;
    
  case OP2I:
    ra=takebits(inst,6,11);
    rb=takebits(inst,11,16);
    imm=takebits(inst,16,32);
    switch(opcode){
    case 1:
      opname="stwi";
      if(execmode){
	uint32_t* address=memory(u2i(r[ra])+u2i16(imm));
	if(address==NULL){
	  printf("tried to write bad address 0x%x  (pc is %x). aborting...\n",u2i(r[ra])+u2i16(imm),pc);
	  if(fp!=NULL)
	    fprintf(fp,"tried to write bad address 0x%x  (pc is %x). aborting...\n",u2i(r[ra])+u2i16(imm),pc);
	  return BADMEMORY;
	}
        if((407<=u2i(r[ra])+u2i16(imm)) & (u2i(r[ra])+u2i16(imm)<=409))
	  printf("writing %x to %d! pc:0x%x \n",r[rb],u2i(r[ra])+u2i16(imm),pc);
	*address=r[rb];
 
      }
      break;

    case 2:
      opname="ldwi";
      if(execmode){
	uint32_t* address=memory(u2i(r[rb])+u2i16(imm));
	if(address==NULL){
	  printf("tried to read bad address 0x%x  (pc is %x). aborting...\n",u2i(r[rb])+u2i16(imm),pc);
	  if(fp!=NULL)
	    fprintf(fp,"tried to read bad address 0x%x  (pc is %x). aborting...\n",u2i(r[rb])+u2i16(imm),pc);
	  return BADMEMORY;
	}
	if((407<=u2i(r[rb])+u2i16(imm)) & (u2i(r[rb])+u2i16(imm)<=409))
	  printf("reading %d to r%x!value is %x  pc:0x%x \n",u2i(r[rb])+u2i16(imm),ra,*address,pc);
	r[ra]=*address;
	
      }
      break;

    case 3:
      opname="jif";
      if(execmode){
	if(r[rb]==0){
	  nextpc=imm;
	  r[ra]=0;
	}
      }
      break;

    case 4:
      opname="ci";
      if(execmode){
	r[ra]=pc+1;
	nextpc=imm;
      }
      break;

    case 5:
      opname="addi";
      if(execmode){
	r[ra]=u2i(r[rb])+u2i16(imm);
      }
      break;

    case 6:
      opname="subi";
      if(execmode){
	r[ra]=u2i(r[rb])-u2i16(imm);
      }
      break;

    default:
      opname="!unassigned opcode!";
      if(execmode){
	nextpc=INVALIDINSTPC;
      }
      break;
    }
    if(fp!=NULL){
      fprintf(fp,"%s\t",opname);
      fprintf(fp,"r%x\tr%x\t%d\t\t",ra,rb,imm);
    }
    break;
    
  case OP1:
    ra=takebits(inst,9,14);
    imm=takebits(inst,14,30);
    switch(opcode){
    case 1:
      opname="limm";
      if(execmode){
	r[ra]=u2i16(imm);
	//anxious  *imm without u2i16
	//*r[ra] without u2i
	//*ra rb rc without r[]
	//fcmpc vs cmpc
	//when ra==rb ...etc
	//imm in cmpc
	//r1f heno dainyuuu
      }
      break;

    case 2:
      opname="in";
      if(execmode){
	unsigned char a;
	fread(&a,sizeof(unsigned char),1,mystdin);
	r[ra]=a;
      }
      break;

    case 3:
      opname="out";
      if(execmode){
	unsigned char a=r[ra]%0x100;
	//printf("out %d pc 0x%x\n",a,pc);
	fwrite(&a , sizeof(char) , 1 , mystdout);
      }
      break;

    case 4:
      opname="hlt";
      if(execmode){
	printf("you hit halt! pc:%x \n",pc);
	nextpc=HALTPC;
      }
      break;

    default:
      opname="!unassigned opcode!";
      if(execmode){
	nextpc=INVALIDINSTPC;
      }
      break;
    }
    if(fp!=NULL){
      fprintf(fp,"%s\t",opname);
      fprintf(fp,"r%x\t%d\t\t",ra,imm);
    }
    break;
    
  case OP3C:
    cond=takebits(inst,12,15);
    ra=takebits(inst,15,20);
    rb=takebits(inst,20,25);
    rc=takebits(inst,25,30);
    switch(opcode){
    case 1:
      opname="cmpc";
      if(execmode){
	r[ra]=cmpc(cond,r[rb],r[rc]);
      }
      break;

    case 2:
      opname="fcmpc";
      if(execmode){
	r[ra]=fcmpc(cond,r[rb],r[rc]);
      }
      break;

    case 3:
      opname="cmpac";
      if(execmode){
	r[ra]=r[ra]&cmpc(cond,r[rb],r[rc]);
      }
      break;

    case 4:
      opname="fcmpac";
      if(execmode){
	r[ra]=r[ra]&fcmpc(cond,r[rb],r[rc]);
      }
      break;

    case 5:
      opname="jrc";
      if(execmode){
	if(cmpc(cond,r[ra],r[rb]))
	  nextpc=r[rc];
	else
	  nextpc=pc+1;
      }
      break;

    case 6:
      opname="fjrc";
      if(execmode){
	if(fcmpc(cond,r[ra],r[rb]))
	  nextpc=r[rc];
	else
	  nextpc=pc+1;
      }
      break;

    default:
      opname="!unassigned opcode!";
      if(execmode){
	nextpc=INVALIDINSTPC;
      }
      break;
    }
    if(fp!=NULL){
      fprintf(fp,"%s\t",opname);
      fprintf(fp,"r%x\tr%x\tr%x\t%d\t\t",ra,rb,rc,cond);
    }
    break;

  case OP3:
    ra=takebits(inst,17,22);
    rb=takebits(inst,22,27);
    rc=takebits(inst,27,32);
    switch(opcode){

    case 0:
      opname="jrf";
      if(execmode){
	if(r[rb]==0){
	  nextpc=r[rc];
	  r[ra]=0;
	}
      }
      break;

    case 1:
      opname="cr";
      if(execmode){
	r[ra]=pc+1;
	nextpc=r[rc];
      }
      break;

    case 2:
      opname="stw";
      if(execmode){
	uint32_t* address=memory(u2i(r[ra])+u2i(r[rc]));
	if(address==NULL){
	  printf("tried to write bad address 0x%x  (pc is %x). aborting...\n",u2i(r[ra])+u2i(r[rc]),pc);
	  if(fp!=NULL)
	    fprintf(fp,"tried to write bad address 0x%x  (pc is %x). aborting...\n",u2i(r[ra])+u2i(r[rc]),pc);
	  return BADMEMORY;
	}
	if((407<= u2i(r[ra])+u2i(r[rc])) & (u2i(r[ra])+u2i(r[rc]) <= 409))
	  printf("writing %x to %d! pc:0x%x \n",r[rb],u2i(r[ra])+u2i(r[rc]),pc);
	*address=r[rb];
      }
      break;

    case 3:
      opname="ldw";
      if(execmode){
	uint32_t* address=memory(u2i(r[rb])+u2i(r[rc]));
	if(address==NULL){
	  printf("tried to read bad address 0x%x  (pc is %x). aborting...\n",u2i(r[rb])+u2i(r[rc]),pc);
	  if(fp!=NULL)
	    fprintf(fp,"tried to read bad address 0x%x  (pc is %x). aborting...\n",u2i(r[rb])+u2i(r[rc]),pc);
	  return BADMEMORY;
	}
	if((407<=u2i(r[rb])+u2i(r[rc])) & (u2i(r[rb])+u2i(r[rc])<=409))
	  printf("reading from %d to r%x! value is %x  pc:0x%x \n",u2i(r[rb])+u2i(r[rc]),ra,*address,pc);
	r[ra]=*address;
      }
      break;

    case 4:
      opname="add";
      if(execmode){
	r[ra]=u2i(r[rb])+u2i(r[rc]);
      }
      break;

    case 5:
      opname="sub";
      if(execmode){
	r[ra]=u2i(r[rb])-u2i(r[rc]);
      }
      break;

    case 6:
      opname="and";
      if(execmode){
	r[ra]=r[rb]&r[rc];
      }
      break;

    case 7:
      opname="or";
      if(execmode){
	r[ra]=r[rb]|r[rc];
      }
      break;

    case 8:
      opname="xor";
      if(execmode){
	r[ra]=r[rb]^r[rc];
      }
      break;

    case 9:
      opname="sll";
      if(execmode){
	if(r[rc]>=32)
	  r[ra]=0;
	else
	  r[ra]=r[rb] << r[rc];
      }
      break;

    case 10:
      opname="srl";
      if(execmode){
	if(r[rc]>=32)
	  r[ra]=0;
	else
	  r[ra]=r[rb] >> r[rc];
      }
      break;

    case 11:
      opname="fadd";
      if(execmode){
	r[ra]=fadd(r[rb],r[rc]);
      }
      break;

    case 12:
      opname="fsub";
      if(execmode){
	r[ra]=fadd(r[rb],fneg(r[rc]));
      }
      break;

    case 13:
      opname="fmul";
      if(execmode){
	r[ra]=fmul(r[rb],r[rc]);
      }
      break;

    case 14:
      opname="finv";
      if(execmode){
	r[ra]=finv(r[rb]);
      }
      break;

    case 15:
      opname="faba";
      if(execmode){
	if(r[rb]==0)
	  r[ra]=fabsol(r[rc]);
	else if(r[rc]==0)
	  r[ra]=fabsol(r[rb]);
	else
	  r[ra]=fabsol(r[rb]+r[rc]);
      }
      break;

    case 16:
      opname="fsqrt";
      if(execmode){
	r[ra]=fsqrt(r[rb]);
      }
      break;

    default:
      opname="!unassigned opcode!";
      if(execmode){
	nextpc=INVALIDINSTPC;
      }
      break;
    }
    if(fp!=NULL){
      fprintf(fp,"%s\t",opname);
      fprintf(fp,"r%x\tr%x\tr%x\t\t",ra,rb,rc);
    }
    break;
    
  default:
    opname="!unassigned opcode!";
    if(execmode){
      nextpc=INVALIDINSTPC;
    }
    if(fp!=NULL){
      fprintf(fp,"%s\t",opname);
      fprintf(fp,"%x",inst);
    }
    break;
  }
  
  //if((0x54DC<=pc) & (nextpc<=0x54DC))
  if((nextpc!=pc+1) & ((pc>0x4000) | (nextpc>0x4000)))
    printf("%x -> %x\n",pc,nextpc);
  if(nextpc==0x77 )
    printf("print int sub %d   pc 0x%x \n",r[7],pc);
  
  if(fp!=NULL){
    fprintf(fp,"#%03x",pc);
    
    if(execmode){
      printreg(fp,1,1);
      printreg(fp,2,1);
      printreg(fp,5,1);
      printreg(fp,6,1);
      printreg(fp,7,1);
      printreg(fp,8,1);
      printreg(fp,0xB,1);
      printreg(fp,0xC,1);
      printreg(fp,0x11,1);
      printreg(fp,0x12,1);
      printreg(fp,0x13,1);
      printmem(fp,407,1);
      printmem(fp,408,1);
      printmem(fp,409,1);
      //printreg(fp,9,1);
      //printreg(fp,0xa,1);
      //printreg(fp,0x18,1);
      //printreg(fp,0x19,1);
      //printmem(fp,0xae,1);
      
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

