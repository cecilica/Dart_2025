void main(List<String> arguments) {
  var myMap = <String, List<int>>{};
  
  // Get the word
  var numberSum = arguments[arguments.length - 1];

  // Create a map with the letter and the number
  for(int i = 0; i < arguments.length - 1; i += 2) {
    myMap[arguments[i]] = [int.parse(arguments[i + 1])];
  }

  // Parse word and count occurrences of letters
  for(int i = 0; i < numberSum.length; i++) {
    if(myMap[numberSum[i]]!.length == 1) {
      myMap[numberSum[i]]!.add(1);
    } else {
      myMap[numberSum[i]]![1] += 1;
    }
  }

  // Calculate the result
  var result = 0;
  for(var value in myMap.values) {
    result += value[0] * value[1];
  }

  print(result);
}