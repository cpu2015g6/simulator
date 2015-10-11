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
  unsigned char a[4]={};
  readlen=fread(a,sizeof(unsigned char),4,fp);
  //printf("%x,%x,%x,%x\n",a[0],a[1],a[2],a[3]);
  *inst=(uint32_t)a[0]*0x1000000+(uint32_t)a[1]*0x10000+(uint32_t)a[2]*0x100+(uint32_t)a[3];
  
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

char* changeex(char* orgname,char* exname){
  char* ret=malloc(sizeof(char)*100);
  strcpy(ret,"");
  strcat(ret,orgname);
  char* ex=strstr(ret,".");
  if(ex!=NULL)
    strcpy(ex,"");
  strcat(ret,exname);
  return ret;
}

int loadprog(FILE* in,uint32_t* program,int maxlength){
  int i=0;
  for(i=0;i<maxlength;i++){
    uint32_t inst;
    if(read32(in,&inst))
      program[i]=inst;
    else
      break;
  }
  int proglength=i;
  if(feof(in)==0){
    printf("program too long! change settings in 'loadprog'\n");
    exit(1);
  }
  return proglength;
}

int u2i(uint32_t u){
  Typechanger uni;
  uni.u=u;
  return uni.i;
}

uint32_t i2u(int i){
  Typechanger uni;
  uni.i=i;
  return uni.u;
}

int u2i16(uint32_t u){
  u*=0x10000;
  int i=u2i(u);
  i/=0x10000;
  return i;
}
