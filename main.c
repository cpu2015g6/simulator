#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <string.h>
#include "iroiro.h"
#include "exec.h"

int mymain(int argc,char* argv[]){
  //open files
  FILE* in=openrb(argv[1]);
  FILE* out=openw(changeex(argv[1],".myasm"));
  FILE* log=openw(changeex(argv[1],".log"));
  
  //load program
  uint32_t program[10000];
  int proglength=loadprog(in,program,10000);
  fclose(in);

  //write out assembly
  int i=0;
  for(i=0;i<proglength;i++){
    exec(program[i],i,0,out);
  }
  fclose(out);
  if(unassignedfound){
    printf("Found some unassigned opcodes!\n");
    printf("Simulator will tread them as NOP.\n");
    printf("Disassembling failed.\n");
  }else{
    printf("Disassembling succeeded without error.\n");
  }
  printf("Dumped '%s' (%d instructions)\n",changeex(argv[1],".myasm"),proglength);
  
  //simulate
  int pc=0;
  fprintf(log,"execution log\n");
  for(i=0;;i++){
    pc=exec(program[pc],pc,1,log);
    if(pc==proglength){
      printf("program reached the end without error.\n");
      fprintf(log,"program reached the end without error.\n");
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
    if(i==10000){
      printf("program executed 10000 instructions without error.\n");
      printf("aborting...\n");
      fprintf(log,"program executed 10000 instructions without error.\n");
      fprintf(log,"aborting...\n");
      break;
    }
  }
  int simulationlength=i+1;
  
  fprintf(log,"\n");
  dumpreg(0,log);
  fprintf(log,"\n");
  dumpmem(64,0,log);
  printf("Dumped '%s' (executed %d instructions)\n",changeex(argv[1],".log"),simulationlength);
  
  return 0;
}


int main(int argc,char *argv[]){
  mymain(argc,argv);
  return 0;
}
