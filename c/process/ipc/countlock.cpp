#include "ctipc.h"
#define FILENAME "count_test_mutex.txt"
#define MUTEXNAME "/count_test_mutex"
sem_t *mutex;
int main(int argc, char ** argv){
	int fd, inum, iloop;
	if(argc != 2){
		printf("useage: countlock <loopnum>\n");
		return 0;
	}
	mutex = sem_open(MUTEXNAME, O_RDWR);
	iloop = atoi(argv[1]);
	fd = open(FILENAME, O_RDWR, FILE_MODE);
	for(int i = 0; i < iloop; i++){
		sem_wait(mutex);
		lseek(fd, 0, SEEK_SET);	
		read(fd, &inum, sizeof(int));
		usleep(1000);
		inum++;
		lseek(fd, 0, SEEK_SET);	
		write(fd, &inum, sizeof(int));
		sem_post(mutex);
	}
	printf("countlock down, pid is %d\n", getpid());
	return 0;
}
	 					
	
