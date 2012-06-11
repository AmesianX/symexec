#include <stdio.h>

int main() {
  int t;
  scanf("%d", &t);
  while(t--){    
    int a, b;
    scanf("%d:%d", &a, &b);
    if(b!=0) {a=0;}
    else {
      if(a>12) a-=12;
      else a+=12;
    }
    printf("%d\n", a);
  }
  return 0;
}

