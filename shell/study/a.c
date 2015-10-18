#include <stdio.h>
#include <unistd.h>
int main(void)
{
	printf("aa\n");
	int pid = fork();
	switch (pid) {
	case 0:
		printf("Child process\n");
		break;
	case -1:
		printf("Error!\n");
		break;
	default:
		printf("Child pid is %d\n", pid);
	}
	printf("bb\n");
	return 0;
}	
