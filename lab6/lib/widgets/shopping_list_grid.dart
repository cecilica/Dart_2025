import 'package:flutter/material.dart';
import '../widgets/shopping_list_item.dart';

class ShoppingListGrid extends StatelessWidget {
  final List<Map<String, String>> shoppingList;
  final Function(int) onRemoveItem;
  final Map<String, String> categoryImages; // Store category images

  const ShoppingListGrid({
    super.key,
    required this.shoppingList,
    required this.onRemoveItem,
    required this.categoryImages, // Pass category images map
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 2.0,
        mainAxisSpacing: 2.0,
      ),
      itemCount: shoppingList.length,
      itemBuilder: (context, index) {
        final item = shoppingList[index]['name']!;
        final category = shoppingList[index]['category']!;
        final imagePath = categoryImages[category] ?? 'assets/images/none.png';

        return ShoppingListItem(
          item: item,
          category: category,
          imagePath: imagePath,
          onRemove: () => onRemoveItem(index),
        );
      },
    );
  }
}
