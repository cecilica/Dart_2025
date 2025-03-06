int digitSum(int x) {
  int sum = 0;

  while(x > 0) {
    sum += x % 10;
    x = x ~/ 10;
  }

  return sum;
}

void main() {
  int n = 13;
  var myMap = <int, List<int>>{};
  int maxLen = 0;

  for(int i = 1; i <= n; i++) {
    int sum = digitSum(i);

    if(!myMap.containsKey(sum)) {
      myMap[sum] = [i];
    } else {
      myMap[sum]!.add(i);
    }

    if(maxLen < myMap[sum]!.length) {
      maxLen = myMap[sum]!.length;
    }
  }

  int countMaxGroup = 0;
  for(var value in myMap.values) {
    if(value.length == maxLen) {
      countMaxGroup += 1;
    }
  }

  print(myMap);
  print(countMaxGroup);
}