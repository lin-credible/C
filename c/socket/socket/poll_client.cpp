#include "ct.h"
int main(int argc, char ** argv)
{
	int sockfd, n, maxfd;
	char recvline[MAXLINE], sendline[MAXLINE];
	struct sockaddr_in serveraddr;
	struct pollfd fdset[64];
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
	fdset[0].fd = sockfd;
	fdset[0].events = fdset[1].events = POLLRDNORM;
	fdset[1].fd = fileno(stdin); 
	maxfd = (sockfd > fileno(stdin) ? sockfd: fileno(stdin)) + 1;
	for(;;)
	{
		poll(fdset, maxfd, 1000000);
		if(fdset[1].revents & POLLRDNORM)
		{
			if(fgets(sendline, MAXLINE, stdin) == NULL)
				return 0;
			n = write(sockfd, sendline, strlen(sendline));
		}
		if(fdset[0].revents & POLLRDNORM)
		{
			if( (n = read(sockfd, recvline, MAXLINE)) == 0)
				return 0;
			recvline[n] = 0;
			printf("%s", recvline);
		}
	}
}
