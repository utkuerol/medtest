import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medtest/pages/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'MedTest',
      theme: ThemeData(
          colorScheme: const ColorScheme.light()
              .copyWith(primary: Colors.black, secondary: Colors.white)),
      home: const Home(),
    );
  }
}
