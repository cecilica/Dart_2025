import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shopping List',
      home: const ShoppingListHomePage(title: 'Your Shopping List'),
    );
  }
}

class ShoppingListHomePage extends StatefulWidget {
  const ShoppingListHomePage({super.key, required this.title});
  final String title;

  @override
  State<ShoppingListHomePage> createState() => _ShoppingListState();
}

class _ShoppingListState extends State<ShoppingListHomePage> {
  final TextEditingController _controller = TextEditingController();
  final List<String> _shoppingList = [];
  int _counter = 0;

  void _addItems() {
    setState(() {
      if (_controller.text.isNotEmpty) {
        // Check if the item is already in the list
        if (_shoppingList.contains(_controller.text)) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Duplicate Item'),
                content: Text('The item ${_controller.text} is already in the list.'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Center(
                      child: const Text('OK'),
                    ),
                  ),
                ],
              );
            },
          );
          return;
        }
        _shoppingList.add(_controller.text);
        _controller.clear();
        _counter++;
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Empty Text Field'),
              content: const Text('Please enter an item to add to the list.'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Center(
                    child: const Text('OK')
                  ),
                ),
              ],
            );
          },
        );
      }
    });
  }

  void _removeItem(int index) {
    setState(() {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Remove Item'),
            content: Text('Are you sure you want to remove ${_shoppingList[index]} from the list?'),
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
              )
            ],
          );
        },
      );
    });
  }

  void _removeItemFromList(int index) {
    setState(() {
      _shoppingList.removeAt(index);
      _counter--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink[100],
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Text field to add items to the list
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Enter an item for your list',
                contentPadding: EdgeInsets.only(left: 20.0, right: 10.0, top: 15.0, bottom: 10.0),
                suffixIcon: Tooltip(
                  message: "Add item",
                  padding: EdgeInsets.only(left: 8.0, right: 8.0, top: 3.0, bottom: 4.5),
                  decoration: BoxDecoration(
                    color: Colors.pink[900],
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: IconButton(
                    onPressed: _addItems,
                    icon: Icon(
                      Icons.add,
                      color: Colors.pinkAccent[100],
                      size: 20.0,
                    ),
                  )
                ),
              ),
              onSubmitted: (text) {
                _addItems();
              },
            ),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 2.0,
                ),
                itemCount: _counter, // Number of items to display
                itemBuilder: (context, index) {
                  return Card(
                    margin: EdgeInsets.only(top: 5.0, left: 10.0, right: 10.0, bottom: 5.0),
                    child: Stack(
                      children: [
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(_shoppingList[index]),
                          ),
                        ),
                        Positioned(
                          top: 0,
                          right: 0,
                          child: Tooltip(
                            message: "Remove item",
                            padding: EdgeInsets.only(left: 8.0, right: 8.0, top: 3.0, bottom: 4.5),
                            decoration: BoxDecoration(
                              color: Colors.pink[900],
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                            child: IconButton(
                              icon: Icon(
                                  Icons.close,
                                  color: Colors.pinkAccent[100],
                                  size: 15.0,
                                ),
                              onPressed: () => _removeItem(index),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
