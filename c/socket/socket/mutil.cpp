#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>
#include <sys/wait.h>
int main()
{
	printf("parent process\n");
	for(int i = 0; i < 10; i++)
	{
		int forkid = 0;
		if( (forkid = fork()) == 0)
		{
			printf("client process\n");
			sleep(10);
			return 0;
		}
	}
	int istat;
	while(1)
	{
		if((waitpid(-1, &istat, 0)) > 0 )
			printf("child process exits \n");
	}		
	sleep(100);
	return 0;
}



