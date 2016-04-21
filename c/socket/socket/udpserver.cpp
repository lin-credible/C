#include "ct.h"
int main(int argc, char ** argv)
{
	int sockfd, n;
	struct sockaddr_in serveraddr, clientaddr;
	char recvline[MAXLINE];
	socklen_t len = sizeof(clientaddr);
		
	bzero(&serveraddr, sizeof(serveraddr));
	serveraddr.sin_family = AF_INET;
	serveraddr.sin_port = htons(12001);
	inet_pton(AF_INET, "127.0.0.1", &serveraddr.sin_addr);

	sockfd = socket(AF_INET, SOCK_DGRAM, 0);
	bind(sockfd, (sockaddr*)&serveraddr, sizeof(serveraddr));
	
	while( (n = recvfrom(sockfd, recvline, sizeof(recvline), 0, (sockaddr*)&clientaddr,&len)) > 0)
	{
		recvline[n] = 0;
		printf("%s", recvline);
		sendto(sockfd, recvline, strlen(recvline), 0, (sockaddr*)&clientaddr, len);
		len = sizeof(clientaddr);
	}
}


