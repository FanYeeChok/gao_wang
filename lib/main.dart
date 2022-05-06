import 'package:flutter/material.dart';

import 'home/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      // home: MyHomePage(title: '高王观世音经'),
      home: DefaultTabController(
              length: 3,
              child: MyHomePage(title: '高王观世音经'),
            ),
    );
  }
}
