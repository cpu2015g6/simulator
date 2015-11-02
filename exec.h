int exec(uint32_t inst,int pc,int execmode,FILE* fp,FILE *mystdin,FILE *mystdout);
void dumpreg(int hexmode,FILE* fp);
#define MEM_DATA 1000
extern uint32_t data[MEM_DATA]; 

#define HALTPC -1
#define INVALIDINSTPC -2
#define BADMEMORY -3
