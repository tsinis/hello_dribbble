import 'package:flutter/material.dart'
    show MaterialApp, StatelessWidget, BuildContext, Widget, runApp;

import 'homepage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const HelloDribblePage(),
      );
}
