#include "ctipc.h"
int main(int argc, char ** argv){
	struct mq_attr attr;
	mqd_t mqd;
	int flags = O_RDWR|O_CREAT|O_EXCL;
	
	if(argc != 4){
		printf("useage mqsetattr <ipcname> <maxmsg> <msgsize>\n");
		return 0;
	}
	
	attr.mq_maxmsg = atoi(argv[2]);
	attr.mq_msgsize = atoi(argv[3]);
	
	mqd = mq_open(argv[1], flags, FILE_MODE, &attr);
	printf("errorno is %s, mqdes = %d\n", strerror(errno), mqd);
	
	return 0;
}
	
