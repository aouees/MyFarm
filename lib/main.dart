import 'package:flutter/material.dart';
import 'package:myfarm/screens/activitiesScreen.dart';
import 'package:myfarm/screens/assessmentScreen.dart';
import 'package:myfarm/screens/farmDetailsScreen.dart';
import 'package:myfarm/screens/homeScreen.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'مزرعتي',
      home:assessmentScreen(  'شيسشيسيشس '  )
    );
  }
}
