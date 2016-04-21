#define READFD 0
#define WRITEFD 1
#include "ctipc.h"
int main(int argc, char ** argv){
        int pipe_fd[2], n, ret;
        if(pipe(pipe_fd) < 0){
                printf("create pipe error\n");
                return 0;
        }
        if((ret = fork()) < 0){
                printf("fork error \n");
                return 0;
        }
        if( ret > 0){  //parent process
                char buff[10240] = {0};
                close(pipe_fd[WRITEFD]);
                while(read(pipe_fd[READFD], buff, sizeof(buff))){
                        printf("<print from parent: %s> \n", buff);
                }
                printf("<print from parent: read end>\n");
                close(pipe_fd[READFD]);
                return 0;
        }
        else{ //child process
                close(pipe_fd[READFD]);
                char *info = "[printed in child process, hello world]";
                write(pipe_fd[WRITEFD], info, strlen(info));
                return 0;
        }
        return 0;
}

