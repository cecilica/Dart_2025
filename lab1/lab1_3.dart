import 'dart:io';

void main() {
//   String input = "Hello25,  5  th11is is a, 19  !";
  print("Enter your phrase: ");
  String? input = stdin.readLineSync();
  
  if(input != null) {
    // define the regular expression to find all numbers
    RegExp regex = RegExp(r'\d+');
    
    // find all matches
    Iterable<Match> matches = regex.allMatches(input);
    
    // create a list of all numbers found 
    List<int> numbers = matches.map((match) => int.parse(match.group(0)!)).toList();
    print("Extracted numbers: $numbers");
    
    // use fold for fancyer addition, 0 = initial value
    // total = total sum before that particular number, number = current number
    int sum = numbers.fold(0, (total, number) => total + number);
    
    print("The numbers' sum is: $sum");
  } else {
    print("The input is empty!");
  }
}