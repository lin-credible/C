#include "ctipc.h"
typedef struct store_t{
	int inumstored, inumused;
	char name[20];
} store;
#define NUM_OF_STOREHOST 20
int countnum = 0;
struct shared_t{
	store storehose[NUM_OF_STOREHOST];
	sem_t *mutex, *unused, *used;
}shared;

 
void * produce(void *), *consume(void *);

int main(int argc, char ** argv){
	pthread_t ptid, ctid;
	if(argc != 2){
		printf("useage: namesem <countnum>\n");
		return 0;
	}
	bzero(&shared, sizeof(shared)); 
	countnum = atoi(argv[1]);
	shared.mutex = sem_open("/mutex.1", O_CREAT|O_EXCL, FILE_MODE, 1);
	shared.unused = sem_open("/unused.1", O_CREAT|O_EXCL, FILE_MODE, NUM_OF_STOREHOST);
	shared.used = sem_open("/used.1", O_CREAT|O_EXCL, FILE_MODE, 0);
	
	pthread_setconcurrency(2);
	pthread_create(&ptid, NULL, produce, NULL);
	pthread_create(&ctid, NULL, consume, NULL);
		
	pthread_join(ptid, NULL);	
	pthread_join(ctid, NULL);
	
	sem_unlink("/mutex.1");	
	sem_unlink("/unused.1");	
	sem_unlink("/used.1");
	sleep(3);	
	for(int i = 0; i < NUM_OF_STOREHOST; i++)
		printf("storehose %d put %d apples and get %d apples\n",i%NUM_OF_STOREHOST,shared.storehose[i % NUM_OF_STOREHOST ].inumstored, shared.storehose[i % NUM_OF_STOREHOST ].inumused);

	return 0;
}	

void * produce(void * arg){
	for(int i = 0; i < countnum; i++){
//		sem_wait(shared.unused);
//		sem_wait(shared.mutex);
                sprintf(shared.storehose[i % NUM_OF_STOREHOST ].name, "apple");
		shared.storehose[i % NUM_OF_STOREHOST ].inumstored++ ;
//		sem_post(shared.mutex);
//		sem_post(shared.used);
	}
} 

void * consume(void * arg){
        for(int i = 0; i < countnum; i++){
//		sem_wait(shared.used);
//		sem_wait(shared.mutex);
		if(strcmp(shared.storehose[i % NUM_OF_STOREHOST ].name, "apple") != 0){
			printf("error founds, the are no apple in the store\n");
		}else{
                	sprintf(shared.storehose[i % NUM_OF_STOREHOST ].name, "");
			shared.storehose[i % NUM_OF_STOREHOST ].inumused++ ;
		}
//		sem_post(shared.mutex);
//		sem_post(shared.unused);
        }
}
