#include "ctipc.h"
int main(int argc, char** argv){
	int fd;
	long i, seqno;
	pid_t pid;
	ssize_t n;
	char line[MAXLINE+1];
	pid = getpid();
	
	fd = open("testfile", O_RDWR, FILE_MODE);
	for(i = 0; i < 10000; i++){
		lseek(fd, 0L, SEEK_SET);
		n = read(fd, line, MAXLINE);
		line[n] = '\0';
		n = sscanf(line, "%ld\n", &seqno);
	//	printf("%s: pid = %ld, seq# = %ld\n", argv[0], (long)pid, seqno);
	
		seqno++;
		snprintf(line, sizeof(line), "%ld\n", seqno);
		lseek(fd, 0L, SEEK_SET);
		write(fd, line, strlen(line));
		
	}
	return 0;
}



