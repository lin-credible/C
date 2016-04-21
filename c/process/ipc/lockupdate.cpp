#include "ctipc.h"
typedef struct myblob_t
{
        int num_a;
        int num_b;
}myblob;
#define MYFILE "testfile"
void my_lock(int fd);
void my_unlock(int fd);
int main(int argc, char ** argv){
	int fd;
	myblob writeblob;
	bzero(&writeblob, sizeof(myblob));
	
	fd = open(MYFILE, O_RDWR, FILE_MODE);
	for(int i = 0; i < atoi(argv[1]); i++){
		lseek(fd, 0, SEEK_SET);
		my_lock(fd);
		read(fd, (myblob*)&writeblob, sizeof(myblob));
		usleep(1000);
		writeblob.num_a = writeblob.num_a + 1;
		writeblob.num_b = writeblob.num_b + 1;
		lseek(fd, 0, SEEK_SET);
		write(fd, &writeblob, sizeof(myblob));
		my_unlock(fd);
	}
	close(fd);
	return 0;
}

void my_lock(int fd){
	struct flock lock;
	lock.l_type = F_WRLCK;
	lock.l_whence = SEEK_SET;
	lock.l_start = 0;
	lock.l_len = 0;
	fcntl(fd, F_SETLKW, &lock);
}

void my_unlock(int fd){
        struct flock lock;
        lock.l_type = F_UNLCK;
        lock.l_whence = SEEK_SET;
        lock.l_start = 0;
        lock.l_len = 0;
        fcntl(fd, F_SETLK, &lock);
}
	

