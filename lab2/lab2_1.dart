void main(List<String> arguments) {
  
  List<int> largeNumber = arguments.map((arg) => int.parse(arg)).toList();

  // Parse list in reverse order, keep track of carry using a flag
  bool carry = true; // Initially, carry is true because we are adding 1 to the number

  for(int i = largeNumber.length - 1; i >= 0; i--) {
    if(carry) {
        if(largeNumber[i] == 9) {
            largeNumber[i] = 0;
        } else {
            largeNumber[i] += 1;
            carry = false;
        }
    } else {
        break;
    }
  }

    // If carry is still true, we need to add a new digit to the number
    if(carry) {
        largeNumber.insert(0, 1);
    }

    print(largeNumber);
}

// to run: .\lab2_1.exe 9 9 9 9 