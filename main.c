#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <string.h>
#include "iroiro.h"
#include "exec.h"

int main(int argc,char *argv[]){
  FILE* in=openrb(argv[1]);
  FILE* out=openw(asmname(argv[1]));
  
  uint32_t inst;
  while(read32(in,&inst)){
    exec(inst,out);
  }
  
  return 0;
}
