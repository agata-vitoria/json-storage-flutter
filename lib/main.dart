import 'package:flutter/material.dart';

import 'home-page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'File Manager',
      theme: ThemeData.dark(),
      home: MyHomePage(),
    );
  }
}
