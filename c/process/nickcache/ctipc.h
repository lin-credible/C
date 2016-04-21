#include <stdlib.h>
#include <stdio.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <unistd.h>
#include <fcntl.h>
#include <semaphore.h>
#include <sys/mman.h>
#include <mqueue.h>
#include <string.h>
#include <errno.h>
#include <pthread.h>
#include <arpa/inet.h>
#define FILE_MODE S_IRUSR|S_IWUSR|S_IRGRP|S_IRGRP|S_IROTH|S_IROTH
#define MAXLINE 1024


ssize_t                         /* Read "n" bytes from a descriptor */  
readn(int fd, void *ptr, size_t n) {   
    size_t  nleft;   
    ssize_t nread;   
    nleft = n;  
    char * cptr = (char*)ptr; 
    while(nleft > 0) {   
        if ((nread = read(fd, cptr, nleft)) < 0) {   
            if ( nleft == n)    
                return (-1);    /* error, return -1 */  
            else  
                break;          /* error, return amount read so far */  
        } else if (nread == 0) {   
            break;              /* EOF */  
        }   
        nleft -= nread;   
        cptr   += nread;   
    }   
    return (n - nleft);         /*return >= 0*/  
}  

ssize_t                        
writen(int fd, const void *vptr, size_t n)
{
    size_t         nleft;
     ssize_t         nwritten;
    const char    *ptr;

     ptr = (const char *)vptr;
     nleft = n;
    while (nleft > 0) {                                        
        if ( (nwritten = write(fd, ptr, nleft)) <= 0) {        //当write出错返回－1或者返回0时，

            if (nwritten < 0 && errno == EINTR)
                 nwritten = 0;                                /*若出错返回－1是因为被信号中断，继续写 */
            else
                return(-1);                                    //若不是因为被信号中断而出错返回－1或者 返回0时，则不再写writen返回－1

        }

         nleft -= nwritten;                                    //当write返回值>0但不等于n时，继续写

         ptr += nwritten;
    }
    return(n);
}
 
 


