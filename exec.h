int exec(uint32_t inst,int pc,int execmode,FILE* fp);
void dumpreg(int hexmode,FILE* fp);
void dumpmem(int num,int hexmode,FILE* fp);
extern int unassignedfound;
