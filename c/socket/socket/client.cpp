#include "ct.h"

int main(int argc, char ** argv)
{
	int sockfd, n;
	char recvline[MAXLINE + 1], sendline[MAXLINE];
	struct sockaddr_in serveraddr;

	if(argc != 2)
	{
		printf("usage: dtclient <ipaddr>\n");
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
	while(fgets(sendline, MAXLINE, stdin))
	{
		n = write(sockfd, sendline, strlen(sendline));
		n = read(sockfd, recvline, MAXLINE); 
		recvline[n] = 0;
		printf("%s", recvline);
	}
	exit(0);
}
