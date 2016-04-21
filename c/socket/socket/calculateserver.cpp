#include <iostream>
#include "ct.h" 
using namespace std;
typedef struct sumblob
{
	char type;
	int num_a;
	int num_b;
} sumblob_t;
int main(int argc, char ** argv)
{
	int listenfd, connectfd, n;
	struct sockaddr_in serveraddr;
	
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
		sumblob_t rcv_blob;
		bzero(&rcv_blob, sizeof(sumblob_t));
		connectfd = accept(listenfd, NULL, NULL);
		read(connectfd, (sumblob*)&rcv_blob, sizeof(sumblob_t));
		
		rcv_blob.num_a = ntohl(rcv_blob.num_a);
		rcv_blob.num_b = ntohl(rcv_blob.num_b);
		printf("type is %c, num_a is %d, num_b is %d\n", rcv_blob.type, rcv_blob.num_a, rcv_blob.num_b);
		float result = 0;
		char sendbuff[1024];
		if(rcv_blob.type == '+')
			result = (float)(rcv_blob.num_a + rcv_blob.num_b); 
		else if(rcv_blob.type == '-')
			result = (float)(rcv_blob.num_a - rcv_blob.num_b); 
		else if(rcv_blob.type == 'x')
			result = (float)(rcv_blob.num_a * rcv_blob.num_b); 
		else if(rcv_blob.type == '/')
			result = ((float)rcv_blob.num_a / (float)rcv_blob.num_b); 
		else		
			result = 0;
		printf("result is %f\n", result);
		snprintf(sendbuff, sizeof(sendbuff) - 1,"the result is %f\n", result);
		write(connectfd, sendbuff, strlen(sendbuff));
		
		close(connectfd);
	}
	
}
