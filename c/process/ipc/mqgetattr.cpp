#include "ctipc.h"

int main(int argc, char ** argv){
	mqd_t mqd;
	struct mq_attr attr;
	
	if(argc != 2){
		printf("plase input ./mqgetattr <mq name>\n");
		exit(0);
	}
	
	mqd = mq_open(argv[1], O_RDONLY);
	printf("errorno is %s\n", strerror(errno));
	mq_getattr(mqd, &attr);
	
	printf("max msgs is %ld, max bytes = %ld, currently on queue = %ld\n", attr.mq_maxmsg, attr.mq_msgsize, attr.mq_curmsgs);

	mq_close(mqd);
	exit(0);
} 

