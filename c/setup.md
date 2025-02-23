## compile and run c code

```
echo "" > main.c
cat >> main.c << EOF
#include <stdio.h>

int main() {
printf("Hello World!\n");
return 0;
}
EOF
gcc -o main main.c
./main
```