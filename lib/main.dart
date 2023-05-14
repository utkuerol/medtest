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
        colorScheme: const ColorScheme.light().copyWith(
            primary: Colors.blue[800],
            secondary: Colors.white), // Change primary color to dark blue
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.blue[
                800]), // Change ElevatedButton background color to dark blue
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10), // Round corners
            )),
          ),
        ),
      ),
      home: const Home(),
    );
  }
}
