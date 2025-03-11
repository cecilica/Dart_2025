import 'dart:io';

void main() {
//   String input = "Hello,    this is a, test  phrase  !";
  print("Enter your phrase: ");
  String? input = stdin.readLineSync();
  
  if(input != null) {
    List<String> words = input.split(RegExp(r'\W+'));
    words.removeWhere((word) => word.isEmpty);
    print("Extracted words: $words");
  } else {
    print("The input is empty!");
  }
}