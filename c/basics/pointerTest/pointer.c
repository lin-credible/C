#include <stdio.h>

int global = 0;

int rect(int a, int b)
{
	static int count = 0;
	count++;
	global++;
	int s = a * b;
	return s;
}

int square(int a)
{
	static int count = 0;
	count++;
	global++;
	int s = rect(a, a);
	return s;
}

int main()
{
	int a = 2;
	int b = 6;
	int *pa = &a;
	int *pb = &b;
	int *pglobal = &global;
	int (*psquare)(int a) = &square;
	int s1 = square(a);
	int s2 = rect(a, b);
	printf("s1=%d\ns2=%d\n", s1, s2);
	return 0;
}