#include "ctipc.h"
#define FILENAME "count_test_mutex.txt"
int main(int argc, char ** argv){
	int fd, inum, iloop;
	if(argc != 2){
		printf("useage: countlock <loopnum>\n");
		return 0;
	}
	iloop = atoi(argv[1]);
	fd = open(FILENAME, O_RDWR, FILE_MODE);
	for(int i = 0; i < iloop; i++){
		lseek(fd, 0, SEEK_SET);	
		read(fd, &inum, sizeof(int));
		usleep(1000);
		inum++;
		lseek(fd, 0, SEEK_SET);	
		write(fd, &inum, sizeof(int));
	}
	printf("countunlock down, pid is %d\n", getpid());
	return 0;
}
	 					
	
