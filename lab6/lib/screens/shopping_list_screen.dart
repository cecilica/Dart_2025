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
  Map<String, String> _categoryImages = {};
  final GlobalKey<CategoryDropdownState> _categoryDropdownKey =
      GlobalKey<CategoryDropdownState>();

  @override
  void initState() {
    super.initState();
    _loadCategories();
  }

  Future<void> _loadCategories() async {
    final categories = await CategoryService.loadCategories();
    setState(() {
      _categoryImages = {
        for (var category in categories) category['name']!: category['image']!,
      };
      _selectedCategory =
          categories.isNotEmpty ? categories.first['name']! : 'Groceries';
    });
  }

  void _addItem() {
    setState(() {
      if (_controller.text.isNotEmpty) {
        String itemName = _controller.text.trim();

        if (_shoppingList.any(
          (item) =>
              item['name'] == itemName && item['category'] == _selectedCategory,
        )) {
          _showDialog(
            'Duplicate Item',
            'The item "$itemName" already exists in "$_selectedCategory".',
          );
          return;
        }

        _shoppingList.add({'name': itemName, 'category': _selectedCategory});
        _controller.clear();

        // Reset the selected category to the first one in the list
        if (_categoryImages.isNotEmpty) {
          String firstCategory = _categoryImages.keys.first;
          setState(() {
            _selectedCategory = firstCategory;
          });
        }

        _categoryDropdownKey.currentState?.resetCategory(_selectedCategory);
      } else {
        _showDialog('Empty Field', 'Please enter an item.');
      }
    });
  }

  void _removeItemFromList(int index) {
    setState(() {
      _shoppingList.removeAt(index);
    });
  }

  void _removeItem(int index) {
    setState(() {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Remove Item'),
            content: Text(
              'Are you sure you want to remove "${_shoppingList[index]['name']}" from the list?',
            ),
            actions: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () {
                      _removeItemFromList(index);
                      Navigator.of(context).pop();
                    },
                    child: const Text('Remove'),
                  ),
                ],
              ),
            ],
          );
        },
      );
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
            Center(
              child: TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('OK'),
              ),
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
          Row(
            children: [
              SizedBox.fromSize(
                size: Size(220, 60),
                child: Padding(
                  padding: EdgeInsets.only(
                    left: 20.0,
                    right: 0.0,
                    top: 5.0,
                    bottom: 0.0,
                  ),
                  child: Column(
                    children: [
                      CategoryDropdown(
                        key: _categoryDropdownKey,
                        onCategorySelected: (category) {
                          setState(() {
                            _selectedCategory = category;
                          });
                        },
                      ),
                      _customDivider(),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 0.0,
                    right: 20.0,
                    top: 0.0,
                    bottom: 0.0,
                  ),
                  child: Column(
                    children: [
                      TextField(
                        controller: _controller,
                        decoration: InputDecoration(
                          labelText: 'Enter an item for your list',
                          border: InputBorder.none,
                          suffixIcon: buildTooltip(
                            message: 'Add Item',
                            child: IconButton(
                              icon: Icon(
                                Icons.add,
                                color: Colors.pinkAccent[100],
                                size: 20.0,
                              ),
                              onPressed: _addItem,
                            ),
                          ),
                        ),
                        onSubmitted: (_) => _addItem(),
                      ),
                      _customDivider(),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: ShoppingListGrid(
              shoppingList: _shoppingList,
              onRemoveItem: _removeItem,
              categoryImages: _categoryImages,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildTooltip({required Widget child, required String message}) {
    return Tooltip(
      message: message,
      padding: EdgeInsets.only(left: 8.0, right: 8.0, top: 4.0, bottom: 3.0),
      decoration: BoxDecoration(
        color: Colors.pink[300],
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: child,
    );
  }

  Widget _customDivider() {
    return Divider(height: 1.0, color: Colors.pinkAccent[100], thickness: 1.5);
  }
}
