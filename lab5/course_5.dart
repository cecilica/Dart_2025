 import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  Widget getBody() {
    return Center(
      child: Container(
        color: Colors.blue,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 200,
              height: 100,
              child: ElevatedButton(
                child: Text("Press me"),
                onPressed: () => {print("Button pressed!")},
              )
            ),
            Text("Hello, world!")
          ],
        )
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
              appBar: AppBar(title: Text("My first app!")),
              body: getBody()
      ) 
    );
  }
}
