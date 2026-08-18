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

```
echo "" > game.cpp
cat >> game.cpp << EOF
#include <iostream>
#include <random>

int main() {
    // Initialize random number engine and uniform distribution [1, 100]
    std::random_device rd;
    std::mt19937 gen(rd());
    std::uniform_int_distribution<int> dist(1, 100);

    const int targetNumber = dist(gen);
    int userGuess = 0;
    int attempts = 0;

    std::cout << "=== Number Guessing Game ===\n";
    std::cout << "I have selected a number between 1 and 100. Can you guess it?\n\n";

    while (true) {
        std::cout << "Enter your guess: ";
        
        // Handle invalid input (e.g., non-numeric entries)
        if (!(std::cin >> userGuess)) {
            std::cout << "Invalid input. Please enter a valid integer.\n";
            std::cin.clear();
            std::cin.ignore(std::numeric_limits<std::streamsize>::max(), '\n');
            continue;
        }

        attempts++;

        if (userGuess < 1 || userGuess > 100) {
            std::cout << "Please keep your guess within the range of 1 to 100.\n";
        } else if (userGuess > targetNumber) {
            std::cout << "Too high! Try again.\n";
        } else if (userGuess < targetNumber) {
            std::cout << "Too low! Try again.\n";
        } else {
            std::cout << "\nCongratulations! You guessed the number " 
                      << targetNumber << " in " << attempts << " attempts!\n";
            break;
        }
    }

    return 0;
}
EOF
g++ -o gamecpp game.cpp
./gamecpp
```
