#include "ctipc.h"
int main(int argc, char ** argv){
	mqd_t mqd;
	size_t len;
	int iprio;
	if(argc != 4){
		printf("useage: mqsend <ipcname> <message> <priority>\n");
		return 0;
	}
	iprio = atoi(argv[3]);
	mqd = mq_open(argv[1], O_WRONLY);
	printf("open errorno is %s, mqdes is %d\n", strerror(errno), mqd);
	mq_send(mqd, argv[2], strlen(argv[2]), iprio);
	printf("send errorno is %s\n", strerror(errno));
	return 0;
}
