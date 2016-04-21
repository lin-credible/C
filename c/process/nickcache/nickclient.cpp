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
	bzero(&receiveinfo, sizeof(cmdinfo));
	bzero(&sendinfo, sizeof(cmdinfo));
	struct sockaddr_in serveraddr;
	if(argc < 4)
	{
		printf("usage: nickclient <ip> <uid> <cmd: g or s> <newname>\n");
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
	sendinfo.uid = htonl(atoi(argv[2]));
	sendinfo.cmd = argv[3][0];
	snprintf(sendinfo.uname, sizeof(sendinfo.uname), argv[4]);
	write(sockfd, &sendinfo, sizeof(cmdinfo));
	n = read(sockfd, (cmdinfo*)&receiveinfo, sizeof(cmdinfo));
	printf("uid is %d, uname is %s, cmd is %c\n", ntohl(receiveinfo.uid), receiveinfo.uname, receiveinfo.cmd);
	exit(0);
}
