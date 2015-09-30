#include <stdio.h>

void input()
{
	int flag = 1, i, count = 0, sum = 0;
	while(flag){
		scanf("%d", &i);
		if(0 == i) break;
		count++;
		sum+=i;
	}
	printf("%d, %d\n", sum, count);
}
