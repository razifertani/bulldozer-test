import 'package:bulldozer_test/shift_offers_screen.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ShiftOffersScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
