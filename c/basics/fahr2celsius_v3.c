#include <stdio.h>

#define LOWER 0    /* the lowest temp */
#define UPPER 300  /* the highest temp */
#define STEP 20    /* the step of temp increasing */

int main() {
  int fahr;

  for (fahr = LOWER; fahr <= UPPER; fahr += STEP) {
    printf("%3d %6.1f\n", fahr, (5.0 / 9.0) * (fahr - 32.0));
  }

  return 0;
}
