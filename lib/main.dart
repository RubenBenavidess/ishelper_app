import 'package:flutter/material.dart';
import 'package:ishelper_app/core/widgets/designed_button.dart';
import 'package:ishelper_app/core/widgets/is_navigation_bar.dart';
import 'package:ishelper_app/core/widgets/main_screen_handler.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: MainScreenHandler()
        ),
      ),
    );
  }
}
