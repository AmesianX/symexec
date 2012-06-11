#include <stdio.h>

int branch(int n, int m){
  printf("%d %d\n", n, m);
  return 0;
}

int main() {
  branch(4, 3);
  branch(0, 6);
  return 0;
}

