typedef union{
  uint32_t u;
  int i;
  float f;
}Typechanger;

FILE* myopen(const char* filename,char* mode);
uint32_t takebits(uint32_t inst,int from,int to);
char* changeex(char* orgname,char* exname);//leaks memory
int read32(FILE* fp,uint32_t* inst);
int loadprog(FILE* in,uint32_t* program,int maxlength);
int u2i(uint32_t u);
uint32_t i2u(int i);
float u2f(uint32_t u);
uint32_t f2u(float f);
int u2i16(uint32_t u);
