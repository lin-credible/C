#include <stdio.h>

int main()
{
	 int a = 3;
	 int b = 8;
	 int array[3];
	 array[0] = 1;
	 array[1] = 10;
	 array[2] = 100;
	 int *p = &b;
	 int i = 0;
	 for(i = 0; i < 6; i++){
	 	printf("*p=%d\n", *p);
	 	p++;
	 }
	 printf("--------------\n");
	 p = &b;
	 for(i = 0; i < 6; i++){
	 	printf("p[%d]=%d\n", i, p[i]);
	 }
	 return 0;
}
