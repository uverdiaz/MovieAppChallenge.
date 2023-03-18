import 'package:flutter/material.dart';
import 'package:untitled1/src/ui/homeScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie app',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        canvasColor: const Color(0xFF161616),
        backgroundColor:  const Color(0xFF161616),
        primaryTextTheme: Typography().white,
        textTheme: Typography().white,
      ),
      home: HomeScreen(),
    );
  }
}

