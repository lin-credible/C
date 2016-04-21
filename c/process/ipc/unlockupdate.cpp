#include "ctipc.h"
typedef struct myblob_t
{
        int num_a;
        int num_b;
}myblob;
#define MYFILE "testfile"
int main(int argc, char ** argv){
	int fd;
	myblob writeblob;
	bzero(&writeblob, sizeof(myblob));
	
	fd = open(MYFILE, O_RDWR, FILE_MODE);
	for(int i = 0; i < atoi(argv[1]); i++){
		lseek(fd, sizeof(myblob), SEEK_SET);
		read(fd, (myblob*)&writeblob, sizeof(myblob));
		usleep(1000);
		writeblob.num_a = writeblob.num_a + 1;
		writeblob.num_b = writeblob.num_b + 1;
		lseek(fd, sizeof(myblob), SEEK_SET);
		write(fd, &writeblob, sizeof(myblob));
	}
	close(fd);
	return 0;
}	
