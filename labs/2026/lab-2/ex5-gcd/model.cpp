#include <iostream>
using namespace std;
int gcd(int a, int b) {
 while (b != 0) {
 int temp = b;
 b = a % b;
 a = temp;
 }
 return a;
}
int main() {
 int x = 48, y = 18;
 int result = gcd(x, y);
 cout << result << endl;
 return 0;
}
