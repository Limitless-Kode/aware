import 'package:aware/screens/Home.screen.dart';
import 'package:aware/screens/Loading.screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
      MaterialApp(
        theme: ThemeData(
            primaryColor: Color(0xff150A42)
        ),
        initialRoute: "/home",
        routes: {
          "/": (context)=> Loading(),
          "/home": (context)=> Home(),
        },
      )
  );
}