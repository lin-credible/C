#include <stdlib.h>
#include <stdio.h>
#include <poll.h>
#include <unistd.h>

int mselect_sleep(int usec)
{
	struct timeval tv;
        tv.tv_sec = 0;
        tv.tv_usec = usec * 1000;
	select(0, NULL, NULL, NULL, &tv);
	printf("mselect_sleep %d usec\n", usec);
	
	return 0;
}

int mpoll_sleep(int usec)
{
        poll(NULL, 0, usec);
        printf("mpoll_sleep %d usec\n", usec);

        return 0;
}


int main(int argc, char ** agrv)
{
	mselect_sleep(500);
	mselect_sleep(1500);
	mselect_sleep(5000);
	
	mpoll_sleep(5000);
	mpoll_sleep(2500);
	mpoll_sleep(500);

	usleep(5000000);
	printf("usleep 5000\n");	
	
	return 0;
}
