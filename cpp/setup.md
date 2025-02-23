## compile and run c++ code

```
echo "" > main.cpp
cat >> main.cpp << EOF
#include <iostream>
using namespace std;

int main() {
  cout << "Hello World!\r\n";
  return 0;
} 
EOF
g++ -o maincpp main.cpp
./maincpp
```