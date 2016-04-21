#include "ctipc.h"
int main(int argc, char ** argv){
	mqd_t mqd;
	uint n, prio;
	struct mq_attr attr;
	if(argc != 2){
		printf("useage: mqreceive <ipcname>\n");
		return 0;
	}
	
	mqd = mq_open(argv[1], O_RDONLY);
	printf("open errorno is %s, mqdes is %d\n", strerror(errno), mqd);
	mq_getattr(mqd, &attr);
	char buff[8192];
	n = mq_receive(mqd, buff, attr.mq_msgsize, &prio);
	printf("read from mq's msg is : %s\n", buff);
	
	return 0;
}	

