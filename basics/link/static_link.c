#include <stdio.h>
#include <string.h>

struct member {
    int age;
    char name[10];
    struct member * next;
};

int main()
{
    struct member a, b, c, *head;
    a.age = 24;
    strcpy(a.name, "colinA");
    b.age = 25;
    //b.name = "colinB";
    strcpy(b.name, "colinB");
    c.age = 18;
    //c.name = "colinC";
    strcpy(c.name, "colinC");

    head = &a;
    a.next = &b;
    b.next = &c;
    c.next = NULL;

    struct member *p;
    p = head;
    while(NULL != p){
        printf("Name:%s (age:%d)\n", p->name, p->age);
        p = p->next;
    };

    return 0;
}

