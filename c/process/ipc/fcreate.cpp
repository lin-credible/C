#include "ctipc.h"
typedef struct myblob_t
{
	int num_a;
	int num_b;
}myblob;
#define MYFILE "test_record_lock.txt"
int main(int argc, char ** argv){
	int fd;
	myblob blob_a, read_blob;
	myblob blob_b;
        if(argc != 5){
                printf("useage: fcreate <numa> <numb> <numc> <numd>\n");
                return 0;
        }
	blob_a.num_a = atoi(argv[1]);
	blob_a.num_b = atoi(argv[2]);
	blob_b.num_a = atoi(argv[3]);
	blob_b.num_b = atoi(argv[4]);
	bzero(&read_blob, sizeof(myblob));

	fd = open(MYFILE, O_RDWR|O_APPEND|O_CREAT|O_TRUNC, FILE_MODE);
	
	lseek(fd, 0, SEEK_SET);
	write(fd, &blob_a, sizeof(myblob));
	write(fd, &blob_b, sizeof(myblob));

	lseek(fd, 0, SEEK_SET);
	read(fd, (myblob*)&read_blob, sizeof(myblob));
	printf("read_blob.num_a is %d, read_blob.num_b is %d\n", read_blob.num_a, read_blob.num_b);
	read(fd, (myblob*)&read_blob, sizeof(myblob));
	printf("read_blob.num_a is %d, read_blob.num_b is %d\n", read_blob.num_a, read_blob.num_b);
	close(fd);
	return 0;
} 
	

