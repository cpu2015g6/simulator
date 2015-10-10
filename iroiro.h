typedef union{
  uint32_t u;
  int i;
}Typechanger;

FILE* openrb(const char* filename);
FILE* openw(const char* filename);
int read32(FILE* fp,uint32_t* inst);
uint32_t takebits(uint32_t inst,int from,int to);
char* asmname(char* orgname);//leaks memory
int loadprog(FILE* in,uint32_t* program,int maxlength);
int u2i(uint32_t u);
uint32_t i2u(int i);
int u2i16(uint32_t u);
