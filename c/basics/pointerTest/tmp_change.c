#include <stdio.h>

void change(int *a, int *b)
{
    int tmp = *a;
    *a = *b;
    *b = tmp;
}

int main()
{
    int a = 2;
    int b = 6;
    change(&a, &b);
    printf("Num a is:%d\nNum b is:%d\n", a, b);
    return 0;
}
