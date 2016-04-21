#include "ctipc.h" 
int iCount = 1;
void dealSignal(int sigNum){
	switch(sigNum){
		case SIGHUP:
		printf("signal SIGHUP cached\n");
		break;
		case SIGINT:
		printf("signal SIGINT cached\n");
		break;
		case SIGQUIT:
		printf("signal SIGQUIT cached\n");
		break;
		case SIGUSR1:
		printf("Signal USR1 cached,iCount now is %d\n", iCount);
		break;
		case SIGUSR2:
		printf("Signal USR2 cached,iCount now is %d\n", iCount);
		break;
	}
	return;
}	
int main(int argc, char** argv){
	signal(SIGHUP,dealSignal);
	signal(SIGINT,dealSignal);
	signal(SIGQUIT,dealSignal);
	signal(SIGUSR1,dealSignal);
	signal(SIGUSR2,dealSignal);
	signal(4,SIG_IGN);
	signal(11,SIG_DFL);
	while(iCount++)
		sleep(1);
	return 0;	
}
