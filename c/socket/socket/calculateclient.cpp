#include "ct.h"
typedef struct sumblob
{
        char type;
        int num_a;
        int num_b;
} sumblob_t;
int main(int argc, char ** argv)
{
	int sockfd, n;
	char recvline[MAXLINE + 1], sendline[MAXLINE];
	struct sockaddr_in serveraddr;

	if(argc != 5)
	{
		printf("usage: dtclient <ipaddr> <num_a> <num_b> <type>\n");
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
	sumblob_t sentblob;
	char recvbuff[1024];
	bzero(&sentblob, sizeof(sentblob));
	sentblob.type = argv[4][0];
	sentblob.num_a = htonl(atoi(argv[2]));
	sentblob.num_b = htonl(atoi(argv[3]));
	write(sockfd, &sentblob, sizeof(sentblob));
	n = read(sockfd, &recvbuff, sizeof(recvbuff));
	recvbuff[n] = 0; 
	printf("%s", recvbuff);
	exit(0);
}
