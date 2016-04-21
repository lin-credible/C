#include "ctipc.h"
int main(int argc, char ** argv){
	int fd;
	char * ptr;
	struct stat filestat;	
	fd = open(argv[1], O_RDONLY, FILE_MODE);
	
	fstat(fd, &filestat);
	ptr = (char*) mmap(NULL, filestat.st_size, PROT_READ, MAP_PRIVATE, fd, 0);
	printf("%s\n",  ptr);

	close(fd);	
	return 0;
}
