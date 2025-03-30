import 'package:flutter/material.dart';
import '../widgets/category_dropdown.dart';
import '../widgets/shopping_list_grid.dart';
import '../services/category_service.dart';

class ShoppingListHomePage extends StatefulWidget {
  const ShoppingListHomePage({super.key, required this.title});
  final String title;

  @override
  State<ShoppingListHomePage> createState() => _ShoppingListState();
}

class _ShoppingListState extends State<ShoppingListHomePage> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, String>> _shoppingList = [];
  String _selectedCategory = 'Groceries';
  Map<String, String> _categoryImages = {}; // Store category images

  @override
  void initState() {
    super.initState();
    _loadCategories();
  }

  Future<void> _loadCategories() async {
    final categories = await CategoryService.loadCategories();
    setState(() {
      _categoryImages = {
        for (var category in categories) category['name']!: category['image']!
      };
      _selectedCategory = categories.isNotEmpty ? categories.first['name']! : 'Groceries';
    });
  }

  void _addItem() {
    setState(() {
      if (_controller.text.isNotEmpty) {
        String itemName = _controller.text.trim();

        if (_shoppingList.any((item) => item['name'] == itemName && item['category'] == _selectedCategory)) {
          _showDialog('Duplicate Item', 'The item "$itemName" already exists in "$_selectedCategory".');
          return;
        }

        _shoppingList.add({'name': itemName, 'category': _selectedCategory});
        _controller.clear();
      } else {
        _showDialog('Empty Field', 'Please enter an item.');
      }
    });
  }

  void _removeItem(int index) {
    setState(() {
      _shoppingList.removeAt(index);
    });
  }

  void _showDialog(String title, String content) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink[100],
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          CategoryDropdown(
            onCategorySelected: (category) {
              setState(() {
                _selectedCategory = category;
              });
            },
          ),
          TextField(
            controller: _controller,
            decoration: InputDecoration(
              labelText: 'Enter an item',
              suffixIcon: IconButton(
                icon: const Icon(Icons.add, color: Colors.pinkAccent),
                onPressed: _addItem,
              ),
            ),
            onSubmitted: (_) => _addItem(),
          ),
          Expanded(
            child: ShoppingListGrid(
              shoppingList: _shoppingList,
              onRemoveItem: _removeItem,
              categoryImages: _categoryImages, // Pass category images
            ),
          ),
        ],
      ),
    );
  }
}
