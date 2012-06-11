#include <stdio.h>

int main() {
  int t=12;
  double sum=0.0;
  while(t--){    
    double n;
    scanf("%lf", &n);
    sum+=n;
  }
  sum/=12.00;
  printf("$%.2lf\n", sum);
  return 0;
}

