#include "ct.h"
#include <sys/epoll.h>

int main(int argc, char ** argv)
{
	int listenfd, connectfd,epfd, n, nfds;
	struct sockaddr_in serveraddr;
	struct epoll_event ev,events[1000];
	
	char readbuff[MAXLINE + 1];

	
	listenfd = socket(AF_INET, SOCK_STREAM, 0);
	bzero(&serveraddr, sizeof(serveraddr));
        int reuseAddr = 1;
        setsockopt(listenfd, SOL_SOCKET, SO_REUSEADDR, &reuseAddr, sizeof(reuseAddr));
	
	epfd=epoll_create(1000);
	ev.data.fd = listenfd;
	ev.events = EPOLLIN;
	epoll_ctl(epfd, EPOLL_CTL_ADD, listenfd, &ev);


	serveraddr.sin_family = AF_INET;
	inet_pton(AF_INET, "127.0.0.1", &serveraddr.sin_addr);
	serveraddr.sin_port = htons(12001);

	bind(listenfd, (sockaddr*)&serveraddr, sizeof(serveraddr));
	printf("errorno is %s\n", strerror(errno));
	listen(listenfd, 1000);

	for(;;)
	{
		nfds = epoll_wait(epfd, events,1000, 500);
		for(int i = 0; i < nfds; i++)
		{
			if(events[i].data.fd == listenfd)
			{
				connectfd = accept(listenfd, NULL, NULL);
				ev.data.fd = connectfd;
				ev.events = EPOLLIN;
				epoll_ctl(epfd, EPOLL_CTL_ADD, connectfd, &ev);
			}
			else if(events[i].events & EPOLLIN)
			{
				n = read(events[i].data.fd, readbuff, sizeof(readbuff));
				ev.data.fd = events[i].data.fd;
				if(n <= 0)
				{
					epoll_ctl(epfd, EPOLL_CTL_DEL, events[i].data.fd, &ev);
					close(events[i].data.fd);
					continue;
				}
				readbuff[n] = 0;
				printf("fd is %d, string is :%s", events[i].data.fd, readbuff);
				write(events[i].data.fd, readbuff, strlen(readbuff));
				ev.events = EPOLLIN;
				epoll_ctl(epfd, EPOLL_CTL_MOD, events[i].data.fd, &ev);
			}
		}	
	} 
	close(epfd);
	close(listenfd);	
}

