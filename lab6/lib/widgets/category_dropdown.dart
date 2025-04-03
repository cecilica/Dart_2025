import 'package:flutter/material.dart';
import '../services/category_service.dart';

class CategoryDropdown extends StatefulWidget {
  final Function(String) onCategorySelected;

  const CategoryDropdown({super.key, required this.onCategorySelected});

  @override
  CategoryDropdownState createState() => CategoryDropdownState();
}

class CategoryDropdownState extends State<CategoryDropdown> {
  List<Map<String, String>> _categories = [];
  String? _selectedCategory;

  @override
  void initState() {
    super.initState();
    _loadCategories();
  }

  Future<void> _loadCategories() async {
    final categories = await CategoryService.loadCategories();
    setState(() {
      _categories = categories;
      _selectedCategory =
          categories.isNotEmpty ? categories.first['name'] : null;
    });
    widget.onCategorySelected(_selectedCategory!);
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: _selectedCategory,
      items:
          _categories.map((category) {
            return DropdownMenuItem(
              value: category['name'],
              child: Row(
                children: [
                  Image.asset(category['image']!, width: 24, height: 24),
                  const SizedBox(width: 10),
                  Text(category['name']!),
                ],
              ),
            );
          }).toList(),
      underline: Container(height: 0),
      onChanged: (newCategory) {
        setState(() {
          _selectedCategory = newCategory;
        });
        widget.onCategorySelected(newCategory!);
      },
    );
  }

  void resetCategory(String category) {
    setState(() {
      _selectedCategory = category;
    });
  }
}
