#include <stdio.h>

struct data1 {
	int a;
	char b;
	int c;
	char d;
};

union data {
	int a;
	char b;
	int c;
};

int main()
{
	printf("Length of data1 is: %lu\n", sizeof(struct data1));
    union data data_1;
    data_1.b = 'c';
    data_1.c = 10;
    printf("data_1.a: %p, b: %p, c: %p\n",&data_1.a, &data_1.b, &data_1.c);

    return 0;
}
