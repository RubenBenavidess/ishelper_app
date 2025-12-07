import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:ishelper_app/src/view/main_screen_handler.dart';
// import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      supportedLocales: [
        Locale('es', 'ES')
      ],
      localizationsDelegates: [
        CountryLocalizations.delegate,
      ],
      home: MainScreenHandler()
    );
  }
}
