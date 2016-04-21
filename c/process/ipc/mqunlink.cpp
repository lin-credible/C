#include "ctipc.h"
int main(int argc, char ** argv){
	if(argc != 2){
		printf("useage: mqunlink <ipcname>\n");
		return 0;
	}
	mq_unlink(argv[1]);
	printf("errorno is %s\n", strerror(errno));
	return 0;
}

