int exec(uint32_t inst,int pc,int execmode,FILE* fp,FILE *mystdin,FILE *mystdout);
void dumpreg(int hexmode,FILE* fp);
uint32_t* memory(int no);

#define DATA_START  0
#define HEAP_START  0x100
#define STACK_START 0x80000
#define MEM_END 0x100000

#define DATA_SIZE (HEAP_START-DATA_START-1)
#define HEAP_SIZE (STACK_START-HEAP_START-1)
#define STACK_SIZE (MEM_END-STACK_START-1)

extern uint32_t data[DATA_SIZE]; 

#define HALTPC -1
#define INVALIDINSTPC -2
#define BADMEMORY -3
