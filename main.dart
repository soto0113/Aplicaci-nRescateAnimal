import 'package:animalrescue/root_page.dart';
import 'package:flutter/material.dart';
import 'package:animalrescue/authentication.dart';

void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        title: 'ANIMAL RESCUE',
        theme: new ThemeData(
          brightness: Brightness.dark,
        ),
        home: new RootPage(auth: new Auth()));
  }
}
