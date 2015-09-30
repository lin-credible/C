#include <stdio.h>
#include <string.h>
#include "./lib/avg.h"
#include "./lib/input.h"

int main(int argc, char *argv[])
{
	// printf("argv is %d \n", argv);
	// int i;
	// for(i = 0; i < argv; i++){
	// 	printf("argc[%d] is %s\n", i, argc[i]);
	// }
	float s,n;

	if(2 != argc){
		fprintf(stderr, "Need one argc, and [input|avg] only!\n");
        return 1;
	}else{
        if(0 == strncmp("input", argv[1], 5)){
            input();
        }else if(0 == strncmp("avg", argv[1], 5)){
            scanf("%f, %f", &s, &n);
            printf("avg=%.2f\n", avg(s,n));
        }else{
		    fprintf(stderr, "Your input is %s, [input|avg] only!\n", argv[1]);
            return 1;
        }
    }

    return 0;
}
