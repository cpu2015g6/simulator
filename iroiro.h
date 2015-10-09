FILE* openrb(const char* filename);
FILE* openw(const char* filename);
int read32(FILE* fp,uint32_t* inst);
uint32_t takebits(uint32_t inst,int from,int to);
char* asmname(char* orgname);//leaks memory
