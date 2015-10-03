#include <stdio.h>
#define R 20
#define M int main(
#define N(n) n * 10
#define ADD(a, b) (a + b)

int add(int a, int b)
{
	return a + b;
}

typedef struct weapon {
    char name[20];
    int atk;
    int price;
} w;

M)
{
	int a = R;
	// float b = 0.0;
	printf("a=%d\n", a);
	int b = N(a); // int b = a * 10;
	printf("b=%d\n", b);

	int c = add(10.0, 10.5);
	printf("c=%d\n", c);

	float d = ADD(10.5, 6.2);
	printf("d=%.2f\n", d);

	w weapon_1 = {"weapon_name", 1, 2};
	printf("name=%s, price=%d\n", weapon_1.name, weapon_1.price);

	w *weapon_p;
	weapon_p = &weapon_1;
	printf("name=%s, name=%s, name=%s\n", (*weapon_p).name, weapon_p->name, weapon_1.name);

	w weapon_2[2] = {
		{"weapon_name1", 11, 12},
		{"weapon_name2", 21, 22}
	};
	printf("name=%s, atk=%d\n", weapon_2[0].name, weapon_2[1].atk);

	w *weapon_p2;
	weapon_p2 = weapon_2;
	printf("p2_name=%s\n", weapon_p2->name); // weapon_p2-name weapon_2[0].name
	weapon_p2++; //weapon_2 + 1 weapon_2[1]
	printf("p2_name2=%s\n", weapon_p2->name);
}
