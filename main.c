#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <string.h>
#include "iroiro.h"
#include "exec.h"

int mymain(int argc,char* argv[]){
  //open files
  FILE* in=openrb(argv[1]);
  FILE* out=openw(asmname(argv[1]));

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
  
  //simulate
  int pc=0;
  for(i=0;i<1000000;i++){
    pc=exec(program[pc],pc,1,NULL);
    if(pc<0){
      printf("!error in execution\t:program counter is negative!\n");
      printf("given pc:%d\tprogram range:0~%d\n",pc,proglength-1);
      exit(1);
    }else if(proglength<=pc){
      printf("!error in execution\t:program counter is out of range!\n");
      printf("given pc:%d\tprogram range:0~%d\n",pc,proglength-1);
      exit(1);
    }
  }
  
  return 0;
}


int main(int argc,char *argv[]){
  mymain(argc,argv);
  return 0;
}
