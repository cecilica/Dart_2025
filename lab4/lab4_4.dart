/*
  Implement Map<String, dynamic> jsonSubJson(String jsonPath1, String jsonPath2),
  where jsonPath1 and jsonPath2 are paths to two JSON files. The subtraction operation
  between the two JSON files should result in a JSON without the common nodes.

  The function should be written in a separate library from the one where it will be called.
*/

import 'dart:io';
import 'lab4_4_function.dart'; // import the function from the separate library

void main() {
  // call the function with the paths to the JSON files
  var current = Directory.current.path;
  var json1 = "$current\\lab4jsons\\json1.json";
  var json2 = "$current\\lab4jsons\\json2.json";

  Map<String, dynamic> result = jsonSubJson(json1, json2);
  print(result);

  result = jsonSubJson(json2, json1);
  print(result);
}