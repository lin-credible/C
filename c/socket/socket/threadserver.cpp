#include "ct.h"
#include <pthread.h>
static void * doit(void *);
int main(int argc, char ** argv)
{
	int listenfd, connectfd ;
	struct sockaddr_in serveraddr;
	pid_t pid;

	listenfd = socket(AF_INET, SOCK_STREAM, 0);
	bzero(&serveraddr, sizeof(serveraddr));

	serveraddr.sin_family = AF_INET;
	inet_pton(AF_INET, "127.0.0.1", &serveraddr.sin_addr);
	serveraddr.sin_port = htons(12001);

	bind(listenfd, (sockaddr*)&serveraddr, sizeof(serveraddr));
	printf("errorno is %s\n", strerror(errno));
	listen(listenfd, 1000);
	pthread_setconcurrency(1000);
	for(;;)
	{
		pthread_t ptid;	
		connectfd = accept(listenfd, NULL, NULL);
		pthread_create(&ptid, NULL, doit, (void *) &connectfd);
	}
	return 0;
}
static void * doit(void * arg)
{
	int n;
	int connectfd = *(int*)arg;
	char readbuff[MAXLINE + 1];
	while( n = read(connectfd, readbuff, sizeof(readbuff)))
	{
		readbuff[n] = 0;
		printf("%s", readbuff);
		write(connectfd, readbuff, strlen(readbuff));
	}
	close(connectfd);
	return NULL;
} 
