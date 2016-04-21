#include "ctipc.h"
#define SHM_FROM_MEM "/shm_from_mem.txt.1"
#define ARRAY_SIZE 1000
int main(int argc, char ** argv){
	int fd, *ptr, *wptr;
	fd = shm_open(SHM_FROM_MEM,O_CREAT|O_RDWR, FILE_MODE);
	ftruncate(fd, sizeof(int[ARRAY_SIZE]));
	ptr = (int*) mmap(NULL, sizeof(int[ARRAY_SIZE]), PROT_READ|PROT_WRITE,MAP_SHARED,fd,0);
	wptr = ptr;
	close(fd);
	for(int i = 0; i < ARRAY_SIZE; i++)
		*(wptr++) = i * 10;
		
	for(int i = 0; i < ARRAY_SIZE; i++)
		printf("array[%d] is %d\n", i, *(ptr++));
	return 0;		
}	
	

