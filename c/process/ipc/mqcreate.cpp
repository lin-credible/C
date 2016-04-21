#include "ctipc.h"
int main(int argc, char ** argv)
{
	int c, flags;
	mqd_t mqd;
	flags = O_RDWR|O_CREAT|O_EXCL;
	if(argc != 2){
		printf("usage: mqcreate < mq name>");
		exit(0);
	}
	mqd = mq_open(argv[optind], flags, FILE_MODE, NULL);
	printf("errorno is %s, mqdes is %d\n", strerror(errno), mqd);
	
	exit(0);
}
