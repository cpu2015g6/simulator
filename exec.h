int exec(uint32_t inst,int pc,int execmode,FILE* fp,FILE *mystdin,FILE *mystdout);
void dumpreg(int hexmode,FILE* fp);
void dumpmem(int num,int hexmode,FILE* fp);
extern int unassignedfound;
extern uint32_t memory[16777216];

#define HALTPC -1
#define INVALIDINSTPC -2
