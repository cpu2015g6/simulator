#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <string.h>
#include "iroiro.h"
#include "exec.h"

int mymain(int argc,char* argv[]){
  //open files
  FILE* in=myopen(argv[1],"rb");
  FILE* out=myopen(changeex(argv[1],".myasm"),"w");
  FILE* log=myopen(changeex(argv[1],".log"),"w");
  FILE* mystdin=myopen("stdin","rb");
  FILE* mystdout=myopen("stdout","wb");
  
  //load program 
  #define PROGMAXLENGTH 100000
  uint32_t program[PROGMAXLENGTH];
  uint32_t textlen,datalen;
  read32(in,&textlen);
  read32(in,&datalen);
  printf("%u %u\n",textlen,datalen);
  int proglength=loadprog(in,program,PROGMAXLENGTH);
  fclose(in);
  
  //copy datasection to memory
  int j=0;
  for(j=0;j<datalen;j++){
    data[j]=program[j+textlen];
  }

  //write out assembly
  long i=0;
  for(i=0;i<proglength;i++){
    exec2(program[i],i,0,out,NULL,NULL);
  }
  fclose(out);
  printf("Disassembling succeeded without error.\n");
  printf("Dumped '%s' (%d instructions)\n",changeex(argv[1],".myasm"),proglength);
  
  //simulate
  int pc=0;
  fprintf(log,"execution log\n");
  for(i=0;;i++){
    uint32_t oldpc=pc;
    pc=exec2(program[pc],pc,1,NULL,mystdin,mystdout);
#define MAXEXELENGTH -1
    if(pc==proglength){
      printf("program reached the end without error.\n");
      printf("program executed %ld instructions.\n",i);
      fprintf(log,"program reached the end without error.\n");
      fprintf(log,"program executed %ld instructions.\n",i);
      break;
    }if(pc==HALTPC){
      printf("halt!\n");
      printf("program executed %ld instructions without error,and hit halt.\n",i);
      printf("aborting...\n");
      fprintf(log,"halt!\n");
      fprintf(log,"program executed %ld instructions without error,and hit halt.\n",i);
      fprintf(log,"aborting...\n");
      break;
    }else if(pc==INVALIDINSTPC){
      printf("invalid instruction!:%x \n",program[oldpc]);
      printf("program executed %ld instructions, and hit an invalid instruction.\n",i);
      printf("aborting...\n");
      fprintf(log,"invalid instruction!:%x \n",program[oldpc]);
      fprintf(log,"program executed %ld instructions, and hit an invalid instruction.\n",i);
      fprintf(log,"aborting...\n");
      break;
    }else if(pc==BADMEMORY){
      //messege already sent from exec 
      break;
    }else if(pc<0){
      printf("!error in execution\t:program counter is negative!\n");
      printf("given pc:%d\tprogram range:0~%d\n",pc,proglength-1);
      printf("aborting...\n");
      fprintf(log,"!error in execution\t:program counter is negative!\n");
      fprintf(log,"given pc:%d\tprogram range:0~%d\n",pc,proglength-1);
      fprintf(log,"aborting...\n");
      break;
    }else if(proglength<=pc){
      printf("!error in execution\t:program counter is out of range!\n");
      printf("given pc:%d\tprogram range:0~%d\n",pc,proglength-1);
      printf("aborting...\n");
      fprintf(log,"!error in execution\t:program counter is out of range!\n");
      fprintf(log,"given pc:%d\tprogram range:0~%d\n",pc,proglength-1);
      fprintf(log,"aborting...\n");
      break;
    }
    if(i%1000000==0)
      printf("execution:%ld\tpc:%x\n",i,pc);
    if(i==MAXEXELENGTH){//i==MAXEXELENGTH
      printf("program executed %d instructions without error.\n",MAXEXELENGTH);
      printf("aborting...\n");
      fprintf(log,"program executed %d instructions without error.\n",MAXEXELENGTH);
      fprintf(log,"aborting...\n");
      break;
    }
  }
  long int simulationlength=i+1;
  extern int patterncount;
  printf("patterncount %d\n",patterncount);
 
  fprintf(log,"\n");
  dumpreg(0,log);
  printf("Dumped '%s' (executed %ld instructions)\n",changeex(argv[1],".log"),simulationlength);

  int ii=0;
  for(ii=0;ii<256;ii++){
    if(count[ii])
      printf("opcode %x :executed %ld times\n",ii,count[ii]);
  }
  
  
  return 0;
}


int main(int argc,char *argv[]){
  //printf("%d %d\n",u2i(0xffff),u2i16(0xffff));
  mymain(argc,argv);
  return 0;
}
