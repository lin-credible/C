#include <stdio.h>
#include <unistd.h>
#include <pthread.h>
static void * doit(void *);
int main(int argc, char ** argv)
{
	pthread_t tid[10];
	pthread_setconcurrency(10);
	for(int i = 0; i < 10; i++){
		pthread_create(&tid[i], NULL, doit, (void *)i);
	}
	for(int i = 0; i < 10; i++)
	{
		pthread_join(tid[i], NULL);
	}

}

static void * doit(void * arg)
{
	sleep(10);
	printf("im thread %d\n", (int*)arg);
}
