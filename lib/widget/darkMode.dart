import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.light;

  bool get isDarkMode => themeMode == ThemeMode.dark;

  void toggleTheme(bool isOn) {
    themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}

class ThemeManger {
  static final darkTheme = ThemeData(
    primaryColor: const Color.fromARGB(255, 33, 150, 243),
    useMaterial3: true,
    scaffoldBackgroundColor: Colors.grey[900],
    textTheme: const TextTheme(
      displayLarge: TextStyle(
          fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
      bodyLarge: TextStyle(fontSize: 16, color: Colors.white),
      bodyMedium: TextStyle(fontSize: 14, color: Colors.white),
    ),
    colorScheme: ColorScheme.fromSwatch().copyWith(
        primary: Color.fromARGB(255, 33, 150, 243),
        secondary: Color.fromARGB(255, 255, 193, 7)),
  );

  static final lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    useMaterial3: true,
    colorScheme: ColorScheme.fromSwatch().copyWith(
        brightness: Brightness.light,
        primary: Color.fromARGB(255, 13, 71, 161),
        secondary: Color.fromARGB(255, 255, 160, 0)),
  );
}
