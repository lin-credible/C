#include "ct.h"
int main(int argc, char ** argv)
{
	int sockfd, n;
	struct sockaddr_in serveraddr;
	char sendline[MAXLINE], recvline[MAXLINE+1];

	if(argc != 2)
	{
		printf("please input udpclient <ip addr>\n");
		return 0;
	}

	bzero(&serveraddr, sizeof(serveraddr));
	serveraddr.sin_family = AF_INET;
	serveraddr.sin_port = htons(12001);
	inet_pton(AF_INET, argv[1], &serveraddr.sin_addr);

	sockfd = socket(AF_INET, SOCK_DGRAM, 0);
	while(fgets(sendline, MAXLINE, stdin))
	{
		sendto(sockfd, sendline, strlen(sendline),0, (sockaddr*)&serveraddr, sizeof(serveraddr));
		if((n = recvfrom(sockfd, recvline, MAXLINE, 0, NULL, NULL)))
		{
			recvline[n] = 0;
			printf("%s", recvline);
		}
	}
}

