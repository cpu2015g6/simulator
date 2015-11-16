int exec(uint32_t inst,int pc,int execmode,FILE* fp,FILE *mystdin,FILE *mystdout);
void dumpreg(int hexmode,FILE* fp);
uint32_t* memory(int no);

#define HEAP_START  0
#define STACK_START 0xc0000
#define DATA_START  0xfff00
#define MEM_END 0x100000

#define HEAP_SIZE (STACK_START-1)
#define STACK_SIZE (DATA_START-STACK_START-1)
#define DATA_SIZE (MEM_END-DATA_START-1)

extern uint32_t data[DATA_SIZE]; 

#define HALTPC -1
#define INVALIDINSTPC -2
#define BADMEMORY -3
