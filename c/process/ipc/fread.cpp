#include "ctipc.h"
typedef struct myblob_t
{
	int num_a;
	int num_b;
}myblob;
#define MYFILE "test_record_lock.txt"
int main(int argc, char ** argv){
	int fd;
	myblob read_blob;
	bzero(&read_blob, sizeof(myblob));

	fd = open(MYFILE, O_RDWR, FILE_MODE);
	
	lseek(fd, 0, SEEK_SET);
	read(fd, (myblob*)&read_blob, sizeof(myblob));
	printf("read_blob.num_a is %d, read_blob.num_b is %d\n", read_blob.num_a, read_blob.num_b);
	read(fd, (myblob*)&read_blob, sizeof(myblob));
	printf("read_blob.num_a is %d, read_blob.num_b is %d\n", read_blob.num_a, read_blob.num_b);
	close(fd);
	return 0;
} 
	

