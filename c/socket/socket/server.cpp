#include "ct.h"

int main(int argc, char ** argv)
{
	int listenfd, connectfd, n;
	struct sockaddr_in serveraddr;
	char readbuff[MAXLINE + 1];

	listenfd = socket(AF_INET, SOCK_STREAM, 0);
	bzero(&serveraddr, sizeof(serveraddr));

	serveraddr.sin_family = AF_INET;
	inet_pton(AF_INET, "127.0.0.1", &serveraddr.sin_addr);
	serveraddr.sin_port = htons(12001);

	bind(listenfd, (sockaddr*)&serveraddr, sizeof(serveraddr));
	printf("errorno is %s\n", strerror(errno));
	listen(listenfd, 1000);
	
	for(;;)
	{
		connectfd = accept(listenfd, NULL, NULL);
		while(n = read(connectfd, readbuff, sizeof(readbuff)))
		{
			readbuff[n] = 0;
			printf("%s", readbuff);
			write(connectfd, readbuff, strlen(readbuff));
		}
		close(connectfd);
	}
	
}
