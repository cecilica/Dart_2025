import 'dart:async';
import 'package:flutter/material.dart';

class ShoppingListItem extends StatefulWidget {
  final String item;
  final String category;
  final String imagePath;
  final VoidCallback onRemove;

  const ShoppingListItem({
    super.key,
    required this.item,
    required this.category,
    required this.imagePath,
    required this.onRemove,
  });

  @override
  State<ShoppingListItem> createState() => _ShoppingListItemState();
}

class _ShoppingListItemState extends State<ShoppingListItem> {
  final List<Color> _colors = [
    Colors.redAccent,
    Colors.blueAccent,
    Colors.greenAccent,
    Colors.purpleAccent,
    Colors.orangeAccent,
  ];
  int _colorIndex = 0;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _startColorChange();
  }

  void _startColorChange() {
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      setState(() {
        _colorIndex = (_colorIndex + 1) % _colors.length;
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(5.0),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ColorFiltered(
                  colorFilter: ColorFilter.mode(_colors[_colorIndex], BlendMode.modulate),
                  child: Image.asset(widget.imagePath, width: 40, height: 40),
                ),
                const SizedBox(height: 5),
                Text(
                  widget.item,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                Text(
                  widget.category,
                  style: TextStyle(color: Colors.grey[700]),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: IconButton(
              icon: const Icon(Icons.close, color: Colors.pinkAccent, size: 18),
              onPressed: widget.onRemove,
            ),
          ),
        ],
      ),
    );
  }
}
