#include "ctipc.h"
#define SHM_FROM_MEM "/shm_from_mem.txt.1"
int main(int argc, char ** argv){
	int fd, *ptr;
	struct stat stat;
	fd = shm_open(SHM_FROM_MEM,O_RDWR, FILE_MODE);
	fstat(fd, &stat);
	ptr = (int*) mmap(NULL, stat.st_size, PROT_READ|PROT_WRITE,MAP_SHARED,fd,0);
	close(fd);
	for(int i = 0; i < (stat.st_size/sizeof(int)); i++)
		printf("array[%d] is %d\n", i, *(ptr++));
	return 0;		
}	
	

