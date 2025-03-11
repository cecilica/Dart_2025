void main() {
  List<int> sieve = List.filled(1001, 0);
  
  for(int i = 2; i * i <= 1000; i++) {
    if(sieve[i] == 0) {
      for(int j = i * i; j <= 1000; j += i) {
        sieve[j] = 1;
      }
    }
  }
  
  int counter = 1;
  for(int i = 2; i <= 1000 && counter <= 100; i++) {
    if(sieve[i] == 0) {
      print("prime number at index $counter is: $i");
      counter += 1;
    }
  }
  print(counter);
}