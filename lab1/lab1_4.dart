import 'dart:io';

void main() {
  // String input = "UpperCamelCase";
  print("Enter your phrase: ");
  String? input = stdin.readLineSync();
  
  if(input != null) {
    print("String in UpperCamelCase: $input");
    // assuming it is a valid UpperCamelCase string
    StringBuffer output = StringBuffer();
    
    for(int i = 0; i < input.length; i++) {
      String current = input[i];
      
      if(i != 0 && current.toUpperCase() == current) {
        output.write('_');
      }
      
      output.write(current.toLowerCase());
    }
    print("String in lowercase_with_underscore: $output");
  } else {
    print("The input is empty!");
  }
}