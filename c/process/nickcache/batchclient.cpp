#include "ct.h"
#include "ctipc.h"
typedef struct cmdinfo_{
	char cmd;
        uint32_t uid;
        char uname[10];
}cmdinfo;

int main(int argc, char ** argv)
{
	int sockfd, n;
	cmdinfo receiveinfo, sendinfo;
	struct sockaddr_in serveraddr;
	if(argc != 3 )
	{
		printf("usage: nickclient <ip> <loop>\n");
		exit(0);
	}

	sockfd = socket(AF_INET, SOCK_STREAM,0); 
	bzero(&serveraddr, sizeof(serveraddr));
	serveraddr.sin_family = AF_INET;
	serveraddr.sin_port= htons(12001);
	
	if(inet_pton(AF_INET, argv[1], &serveraddr.sin_addr) <= 0)
	{
		printf("%s inet_pton error\n", argv[1]);
		exit(0);
	}

	if( connect(sockfd, (sockaddr*)&serveraddr, sizeof(serveraddr)) < 0)
	{
		printf("connect error \n");
		exit(0);
	}
	int iloop = atoi(argv[2]);
	printf("iloop is %d\n", iloop);
	for(int i = 0; i < iloop; i++){
		bzero(&sendinfo, sizeof(cmdinfo));
		bzero(&receiveinfo, sizeof(cmdinfo));
		sendinfo.cmd = 's';
		sendinfo.uid = htonl(i%10);
		snprintf(sendinfo.uname,sizeof(sendinfo.uname),"update%d", (i%10));
		write(sockfd, &sendinfo, sizeof(cmdinfo));
		n = read(sockfd, (cmdinfo*)&receiveinfo, sizeof(cmdinfo));
		printf("uid is %d, uname is %s, cmd is %c\n", ntohl(receiveinfo.uid), receiveinfo.uname, receiveinfo.cmd);
	}
	exit(0);
}
