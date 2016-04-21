#include "ctipc.h"

#define NICK_TEST_FILE "nick_test_file"

typedef struct uinfo_{
	uint32_t uid;
	char uname[10];
}uinfo;

int main(int argc, char ** argv){

	int fd;
	uinfo userinfo, readuinfo;	
	char user[10][10] = {"nameA","nameB","nameC","coatiD","nameE","nameF","nameG","nameH","nameI","nameJ"};
	
	fd = open(NICK_TEST_FILE, O_RDWR|O_CREAT|O_TRUNC, FILE_MODE);
	lseek(fd, 0, SEEK_SET);
	
	for(int i = 0; i < 10; i++){
		userinfo.uid = i;
		snprintf(userinfo.uname, sizeof(userinfo.uname), "%s", user[i]);
		write(fd, &userinfo, sizeof(uinfo));
	}
	lseek(fd, 0, SEEK_SET);
	for(int i = 0; i < 10; i++){
		read(fd, (uinfo*)&readuinfo, sizeof(uinfo));
		printf("uid is %d\n", readuinfo.uid);
		printf("uname is %s\n", readuinfo.uname);
	}
	
	close(fd);
	return 0;
}	
