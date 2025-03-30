import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

class CategoryService {
  static Future<List<Map<String, String>>> loadCategories() async {
    final String jsonString = await rootBundle.loadString('assets/categories.json');
    final List<dynamic> jsonList = json.decode(jsonString);
    return jsonList.map((item) => {
      'name': item['name'] as String,
      'image': item['image'] as String,
    }).toList();
  }
}
