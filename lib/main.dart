import 'package:flutter/material.dart';
import 'View/reusable/themes.dart';
import 'View/screens/startScreen.dart'; // Assuming you have CustomThemes

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isDarkMode = false;
  void toggleTheme() {
    setState(() {
      isDarkMode = !isDarkMode;
    });
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: CustomThemes.lightTheme,
      darkTheme: CustomThemes.darkTheme,
      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
      home: StartScreen(toggleTheme: toggleTheme, isDarkMode: isDarkMode),
    );
  }
}
