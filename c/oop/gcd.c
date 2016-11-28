#include <stdio.h>

int gcd(int a, int b) {
  while (a != b) {
    (a > b) ? (a -= b) : (b -= a);
  }
  return a;
}

int gcd_v2(int a, int b) {
  return (b != 0) ? gcd(b, a % b) : a;
}

int main(void) {
  int a = 9, b = 6;
  printf("The gcd of a and b are: %d \n", gcd(a, b));
  printf("The gcd_v2 of a and b are: %d \n", gcd_v2(a, b));
}
