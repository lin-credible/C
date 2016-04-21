#include <stdlib.h>
#include <stdio.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <unistd.h>
#include <fcntl.h>
#include <semaphore.h>
#include <sys/mman.h>
/* #include <mqueue.h> */
#include <sys/fcntl.h>
#include <string.h>
#include <errno.h>
#include <pthread.h>
#include <signal.h>
#define FILE_MODE S_IRUSR|S_IWUSR|S_IRGRP|S_IROTH
#define MAXLINE 1024
