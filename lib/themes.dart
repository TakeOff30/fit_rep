import 'package:flutter/material.dart';

Color primaryColor = Color.fromARGB(255, 9, 237, 17);
Color darkColor = Color(0xFF1E1E1E);
Color lightColor = Color.fromARGB(255, 241, 244, 240);

class FitRepTheme {
  static ThemeData light() {
    return ThemeData(
      primaryColor: primaryColor,
      primaryColorLight: lightColor,
      scaffoldBackgroundColor: lightColor,
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: lightColor,
        selectedItemColor: primaryColor,
        unselectedItemColor: darkColor,
      ),
      textTheme: TextTheme(
        displayLarge: TextStyle(
          fontFamily: 'Roboto',
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: darkColor,
        ),
        displayMedium: TextStyle(
          fontSize: 18,
          fontFamily: 'Roboto',
          fontWeight: FontWeight.bold,
          color: darkColor,
        ),
        displaySmall: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: darkColor,
        ),
      ),
    );
  }

  static ThemeData dark() {
    return ThemeData(
      primaryColor: primaryColor,
      primaryColorDark: darkColor,
      scaffoldBackgroundColor: darkColor,
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: darkColor,
        selectedItemColor: primaryColor,
        unselectedItemColor: lightColor,
      ),
      textTheme: TextTheme(
        displayLarge: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: lightColor,
        ),
        displayMedium: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: lightColor,
        ),
        displaySmall: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: lightColor,
        ),
      ),
    );
  }
}
