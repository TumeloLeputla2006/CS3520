#include <iostream>
using namespace std;
int main() {
 int arr[] = {3, 4, 7, 8, 10, 15, 22, 1};
 int n = 8;
 int count = 0;
 for (int i = 0; i < n; i++) {
 if ((arr[i] & 1) == 0) { // even if lowest bit is 0
 count++;
 }
 }
 cout << count << endl;
 return 0;
}
