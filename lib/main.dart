import 'package:flutter/material.dart';

import 'package:playandroid_flutter/ui/main_page.dart';



void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "PlayAndroid-Flutter",
      theme: ThemeData(
        primaryColor: Colors.teal,
        backgroundColor: Colors.black87,
        accentColor: Color(0xFF26A64A),
        dividerColor: Colors.grey,
        textTheme: TextTheme(
          body1: TextStyle(
            color: Colors.black54,
            fontSize: 14
          )
        )
      ),
      home: MainPage(),
    );
  }

}


