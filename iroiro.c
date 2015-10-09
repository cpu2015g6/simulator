#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <string.h>
#include "iroiro.h"

FILE* openrb(const char* filename){
  FILE* fp=fopen(filename,"rb");
  if(fp==NULL){
    printf("!error in open\t: no such file.\n");
    exit(1);
  }
  return fp;
}

FILE* openw(const char* filename){
  FILE* fp=fopen(filename,"w");
  if(fp==NULL){
    printf("!error in open\t:\n");
    exit(1);
  }
  return fp;
}

int read32(FILE* fp,uint32_t* inst){
  size_t readlen;
  readlen=fread(inst,sizeof(uint32_t),1,fp);

  if(feof(fp)==1){
    return 0;
  }else if(readlen<1 && feof(fp)==0){
    printf("!error in read\t:");
    exit(1);
  }
  return 1;
}

uint32_t takebits(uint32_t inst,int from,int to){
  int bits=to-from;
  uint32_t ret=inst;
  int a=1;
  
  int i=0;
  for(i=0;i<32-to;i++)
    ret/=2;
  for(i=0;i<bits;i++)
    a*=2;

  ret%=a;
  return ret;
}

char* asmname(char* orgname){
  char* ret=malloc(sizeof(char)*100);
  strcpy(ret,"asm_");
  strcat(ret,orgname);
  char* ex=strstr(ret,".");
  if(ex!=NULL)
    strcpy(ex,"");
  strcat(ret,".txt");
  return ret;
}
