#include "ctipc.h"
#define FILENAME "count_test_mutex.txt"
#define MUTEXNAME "/count_test_mutex"
sem_t * mutex;
int main(int argc, char ** argv){
	int fd, inum = 0;
	sem_unlink(MUTEXNAME);
	mutex = sem_open(MUTEXNAME, O_CREAT|O_EXCL, FILE_MODE, 1);
	fd = open(FILENAME, O_RDWR|O_CREAT|O_TRUNC, FILE_MODE);
	write(fd, &inum, sizeof(int));
	return 0;
}
	 					
	
