import 'package:flutter/material.dart';
import 'screens/shopping_list_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'Comfortaa'),
      title: 'Shopping List',
      home: const ShoppingListHomePage(title: 'Your Shopping List'),
    );
  }
}
