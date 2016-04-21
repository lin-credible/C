#include "ct.h"
#include "ctipc.h"
#define NICK_TEST_FILE "nick_test_file"
#define WRITE_MUTEX "/mutex_nick"
typedef struct uinfo_{
        uint32_t uid;
        char uname[10];
}uinfo;

typedef struct cmdinfo_{
        char cmd;
        uint32_t uid;
        char uname[10];
}cmdinfo;

sem_t * mutex; //write lock
void doit(int connfd, uinfo* ptr);

int main(int argc, char ** argv)
{
	int listenfd, connectfd ;
	struct sockaddr_in serveraddr;
	uinfo * ptr;
	pid_t pid;
	int fd;
	struct stat filestat;	
	fd = open(NICK_TEST_FILE, O_RDWR, FILE_MODE);	
	fstat(fd, &filestat);
	ptr = (uinfo*)mmap(NULL, filestat.st_size, PROT_READ|PROT_WRITE, MAP_SHARED, fd, 0);
	printf("mmap errorno is %s\n", strerror(errno));
	close(fd);
	listenfd = socket(AF_INET, SOCK_STREAM, 0);
	bzero(&serveraddr, sizeof(serveraddr));

	serveraddr.sin_family = AF_INET;
	inet_pton(AF_INET, "127.0.0.1", &serveraddr.sin_addr);
	serveraddr.sin_port = htons(12001);

	bind(listenfd, (sockaddr*)&serveraddr, sizeof(serveraddr));
	printf("bind errorno is %s\n", strerror(errno));
	listen(listenfd, 1000);
	printf("listen errorno is %s\n", strerror(errno));
	
	sem_unlink(WRITE_MUTEX);
	mutex = sem_open(WRITE_MUTEX, O_CREAT|O_RDWR, FILE_MODE, 1);	
	printf("sem_open errorno is %s\n", strerror(errno));
	for(;;)
	{
		connectfd = accept(listenfd, NULL, NULL);
		if( fork() == 0)
		{
			close(listenfd);
			doit(connectfd, ptr);
			close(connectfd);
			exit(0);
		}
		close(connectfd);
	}
	while(1)
		waitpid(-1, &pid, 0);	
	sem_unlink(WRITE_MUTEX);
}

void doit(int connfd, uinfo* ptr){
	int fd;
	uint32_t uid;
	cmdinfo reciveinfo, sendinfo;
	bzero(&reciveinfo, sizeof(cmdinfo));	
	bzero(&sendinfo, sizeof(cmdinfo));
	uinfo* uinfoptr = NULL;
	
	while(read(connfd, (cmdinfo*)&reciveinfo, sizeof(cmdinfo)))
	{
		uid = ntohl(reciveinfo.uid);
		uinfoptr = ptr + uid;
		sendinfo.cmd = reciveinfo.cmd;
		sendinfo.uid = reciveinfo.uid;
		snprintf(sendinfo.uname, sizeof(sendinfo.uname), uinfoptr->uname);
		if(reciveinfo.cmd == 'g')
		{
			//printf("send uid is %ld, send uname is %s\n",ntohl(sendinfo.uid), sendinfo.uname);
			write(connfd, &sendinfo, sizeof(cmdinfo));
		}
		else if(reciveinfo.cmd == 's')
		{
			int semvalue = 0;
			printf("uid is %ld, uname is %s\n",ntohl(reciveinfo.uid), reciveinfo.uname);
			sem_getvalue(mutex, &semvalue);
			printf("out mutex num is %d pid is %d\n",semvalue, getpid());
			sem_wait(mutex);
			sem_getvalue(mutex, &semvalue);
			printf("in mutex num is %d, pid is %d\n",semvalue, getpid());
			sleep(1);
			snprintf(uinfoptr->uname, sizeof(reciveinfo.uname), reciveinfo.uname);
			sem_post(mutex);
			sem_getvalue(mutex, &semvalue);
			printf("end mutex num is %d, pid is %d\n",semvalue, getpid());
			write(connfd, &reciveinfo, sizeof(cmdinfo));
		}
		else
		{
			//error request
			sendinfo.cmd = 'e';
			snprintf(sendinfo.uname, sizeof(sendinfo.uname), "bad req");
			write(connfd, &sendinfo, sizeof(cmdinfo));
		}	
	}
}
