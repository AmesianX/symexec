#include <stdio.h>
#include <stdlib.h>

int factorial(int X) {
  if (X == 0) return 1;
  return X*factorial(X-1);
}

int main(int argc, char **argv) {
  printf("%d\n", factorial(atoi(argv[1])));
}

