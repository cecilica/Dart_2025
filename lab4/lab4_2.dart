/* 
  Implement a Stack using files as storage.
*/

import 'dart:io';

class MyStack {
  late File file;

  MyStack(String fileName) {
    // create a file object
    file = File(fileName);

    // if the file doesn't exist, create it
    if (!file.existsSync()) {
      file.createSync();
    }
  }

  void push(String data) {
    // append the data to the file
    file.writeAsStringSync("$data\n", mode: FileMode.append);
  }

  String pop() {
    // read the file line by line
    List<String> lines = file.readAsLinesSync();

    // if the stack is empty, throw an exception
    if (lines.isEmpty) {
      throw Exception("The stack is empty!");
    }

    // remove the last line from the file
    String lastLine = lines.removeLast();

    // write the remaining lines back to the file
    file.writeAsStringSync(lines.join('\n'));

    return lastLine;
  }

  String back() {
    // read the file line by line
    List<String> lines = file.readAsLinesSync();

    // if the stack is empty, throw an exception
    if (lines.isEmpty) {
      throw Exception("The stack is empty!");
    }

    // return the last line from the file
    return lines.last;
  }

  bool isEmpty() {
    // read the file line by line
    List<String> lines = file.readAsLinesSync();

    if (lines.length == 0) {
      return true;
    }

    return false;
  }

  @override
  String toString() {
    // read the file line by line
    List<String> lines = file.readAsLinesSync();

    return "Stack: $lines";
  }
}

void main() {
  MyStack stack = MyStack("lab4_2_stack.txt");
  print("Check if my stack is empty: ${stack.isEmpty()}");
  stack.push("1");
  stack.push("2");
  stack.push("3");
  print(stack);
  print("Pop: ${stack.pop()}");
  print(stack);
  print("Back: ${stack.back()}");
  print(stack);
  print("Check if my stack is empty: ${stack.isEmpty()}");

  // clear the file
  stack.file.writeAsStringSync("");
  print("Check if my stack is empty: ${stack.isEmpty()}");
}