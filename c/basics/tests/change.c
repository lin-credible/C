#include <stdio.h>

void change(int* a, int* b);

int main(void) {
    int a = 5, b = 3;
    printf("a=%d,b=%d\n", a, b);
    change(&a, &b);
    printf("a=%d,b=%d\n", a, b);
    return 0;
}

void change(int* a, int* b){
    int temp;
    temp = *a;
    *a = *b;
    *b = temp;
}
