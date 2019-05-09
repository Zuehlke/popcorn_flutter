import 'package:PopcornMaker/screens/home.dart';
import 'package:flutter/material.dart';

void main() => runApp(PopcornApp());

class PopcornApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Popcorn Maker',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: HomePage(title: 'Popcorn Maker'),
      debugShowCheckedModeBanner: false,
    );
  }
}
