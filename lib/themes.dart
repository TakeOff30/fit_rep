import 'package:flutter/material.dart';

Color primaryColor = Color.fromARGB(255, 9, 237, 17);
Color darkColor = Color(0xFF1E1E1E);
Color lightColor = Color.fromARGB(255, 241, 244, 240);

class FitRepTheme {
  static ThemeData light() {
    return ThemeData(
      primaryColor: primaryColor,
      primaryColorLight: lightColor,
      primaryColorDark: darkColor,
      scaffoldBackgroundColor: lightColor,
      buttonTheme: ButtonThemeData(
        buttonColor: lightColor,
      ),
      iconButtonTheme: IconButtonThemeData(
          style: ButtonStyle(iconColor: MaterialStateProperty.all(darkColor))),
      iconTheme: IconThemeData(color: darkColor),
      inputDecorationTheme: InputDecorationTheme(
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
              color: primaryColor, style: BorderStyle.solid, width: 3),
        ),
        hintStyle: TextStyle(color: darkColor),
        labelStyle: TextStyle(color: darkColor),
      ),
      navigationBarTheme: NavigationBarThemeData(
        indicatorShape: CircleBorder(),
        backgroundColor: lightColor,
        iconTheme: MaterialStateProperty.all(IconThemeData(color: darkColor)),
        indicatorColor: Colors.transparent,
      ),
      textTheme: TextTheme(
        headlineLarge: TextStyle(
          fontFamily: 'Roboto',
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: darkColor,
        ),
        headlineMedium: TextStyle(
          fontSize: 18,
          fontFamily: 'Roboto',
          fontWeight: FontWeight.bold,
          color: darkColor,
        ),
        headlineSmall: TextStyle(
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
      primaryColorLight: lightColor,
      primaryColorDark: darkColor,
      scaffoldBackgroundColor: darkColor,
      buttonTheme: ButtonThemeData(
        buttonColor: darkColor,
      ),
      iconButtonTheme: IconButtonThemeData(
          style: ButtonStyle(iconColor: MaterialStateProperty.all(lightColor))),
      iconTheme: IconThemeData(color: lightColor),
      inputDecorationTheme: InputDecorationTheme(
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
              color: primaryColor, style: BorderStyle.solid, width: 3),
        ),
        hintStyle: TextStyle(color: lightColor),
        labelStyle: TextStyle(color: lightColor),
      ),
      navigationBarTheme: NavigationBarThemeData(
        indicatorShape: CircleBorder(),
        backgroundColor: darkColor,
        iconTheme: MaterialStateProperty.all(IconThemeData(color: lightColor)),
        indicatorColor: Colors.transparent,
      ),
      textTheme: TextTheme(
        headlineLarge: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: lightColor,
        ),
        headlineMedium: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: lightColor,
        ),
        headlineSmall: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: lightColor,
        ),
        bodyLarge: TextStyle(
          fontSize: 16,
          color: lightColor,
        ),
        bodyMedium: TextStyle(
          fontSize: 14,
          color: lightColor,
        ),
        bodySmall: TextStyle(
          fontSize: 12,
          color: lightColor,
        ),
      ),
    );
  }
}
