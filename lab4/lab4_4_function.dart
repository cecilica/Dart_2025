/*
  Implement Map<String, dynamic> jsonSubJson(String jsonPath1, String jsonPath2),
  where jsonPath1 and jsonPath2 are paths to two JSON files. The subtraction operation
  between the two JSON files should result in a JSON without the common nodes.

  The function should be written in a separate library from the one where it will be called.
*/

import 'dart:convert';
import 'dart:io';

Map<String, dynamic> jsonSubJson(String jsonPath1, String jsonPath2) {
  // read the contents of the JSON files
  String jsonStr1 = File(jsonPath1).readAsStringSync();
  String jsonStr2 = File(jsonPath2).readAsStringSync();

  // decode the JSON strings into Map objects
  Map<String, dynamic> json1 = jsonDecode(jsonStr1);
  Map<String, dynamic> json2 = jsonDecode(jsonStr2);

  // remove the common nodes from the first JSON
  json2.forEach((key, value) {
    json1.remove(key);
  });

  return json1;
}