#include "ctipc.h"
typedef struct myblob_t
{
        int num_a;
        int num_b;
}myblob;
#define MYFILE "test_record_lock.txt"
void my_lock(int fd, off_t start, off_t len);
void my_unlock(int fd, off_t start, off_t len);
int main(int argc, char ** argv){
	int fd;
	myblob writeblob;
	bzero(&writeblob, sizeof(myblob));
	if(argc != 2){
		printf("useage: flockupdate <loopnum>\n");
		return 0;
	}
	fd = open(MYFILE, O_RDWR, FILE_MODE);
	for(int i = 0; i < atoi(argv[1]); i++){
		lseek(fd, 0, SEEK_SET);
		my_lock(fd, 0, sizeof(myblob));
		read(fd, (myblob*)&writeblob, sizeof(myblob));
		usleep(1000);
		writeblob.num_a = writeblob.num_a + 1;
		writeblob.num_b = writeblob.num_b + 1;
		lseek(fd, 0, SEEK_SET);
		write(fd, &writeblob, sizeof(myblob));
		my_unlock(fd, 0, sizeof(myblob));
	}
	close(fd);
	return 0;
}

void my_lock(int fd, off_t start, off_t len){
	struct flock lock;
	lock.l_type = F_WRLCK;
	lock.l_whence = SEEK_SET;
	lock.l_start = start;
	lock.l_len = len;
	fcntl(fd, F_SETLKW, &lock);
}

void my_unlock(int fd, off_t start, off_t len){
        struct flock lock;
        lock.l_type = F_UNLCK;
        lock.l_whence = SEEK_SET;
        lock.l_start = start;
        lock.l_len = len;
        fcntl(fd, F_SETLK, &lock);
}
	

