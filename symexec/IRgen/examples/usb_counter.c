#include <stdio.h>

int main() {
  int t;
  scanf("%d", &t);
  while(t--){    
    int n;
    scanf("%d", &n);
    int sum=-n+1;
    while(n--){
      int tmp;
      scanf("%d", &tmp);
      sum+=tmp;
    }
    printf("%d\n", sum);
  }
  return 0;
}

