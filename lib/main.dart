import 'package:flutter/material.dart';
import 'DataTableDemo.dart';

void main() {
  runApp(
    new HomeApp());
}

class HomeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SmartRun',
      home: new DataTableDemo()
    );
    
  }
}