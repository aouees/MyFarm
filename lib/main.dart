import 'package:flutter/material.dart';
import 'package:myfarm/screens/homeScreen.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'مزرعتي',
      debugShowCheckedModeBanner: false,
      home:HomesScreen()
    );
  }
}

