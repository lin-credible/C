#include "ct.h"
int main(int argc, char ** argv)
{
	int sockfd, n, maxfd;
	fd_set rset;
	char recvline[MAXLINE], sendline[MAXLINE];
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
	FD_ZERO(&rset);
	for(;;)
	{
		FD_SET(fileno(stdin), &rset);
		FD_SET(sockfd, &rset);
		maxfd = (sockfd > fileno(stdin) ? sockfd: fileno(stdin)) + 1;
		select(maxfd, &rset, NULL, NULL, NULL);
		if(FD_ISSET(fileno(stdin), &rset))
		{
			if(fgets(sendline, MAXLINE, stdin) == NULL)
				return 0;
			n = write(sockfd, sendline, strlen(sendline));
		}
		if(FD_ISSET(sockfd, &rset))
		{
			if( (n = read(sockfd, recvline, MAXLINE)) == 0)
				return 0;
			recvline[n] = 0;
			printf("%s", recvline);
		}
	}
}
