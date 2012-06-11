#include <stdio.h>

int branch(int n){
  if (n>0) printf("Positive\n");
  else if (n==0) printf("Zero\n");
  else if (n<0) printf("Negative\n");
  return 0;
}

int main() {
  branch(-4);
  branch(0);
  branch(6);
  return 0;
}

