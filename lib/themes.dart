import 'package:flutter/material.dart';

Color primaryColor = Color.fromARGB(255, 80, 200, 120);
Color darkColor = Color.fromARGB(255, 30, 30, 30);
Color lightColor = Color.fromARGB(255, 246, 246, 246);
Color lightGrey = Color.fromARGB(255, 192, 192, 192);
Color darkGrey = Color.fromARGB(255, 74, 74, 74);

class FitRepTheme {
  static ThemeData light() {
    return ThemeData(
      primaryColor: primaryColor,
      primaryColorLight: lightColor,
      primaryColorDark: darkColor,
      chipTheme: ChipThemeData(
        deleteIconColor: darkColor,
        labelStyle: TextStyle(color: darkColor),
        color: MaterialStateColor.resolveWith((states) => lightColor),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: darkColor),
        titleTextStyle: TextStyle(color: darkColor),
      ),
      dropdownMenuTheme: DropdownMenuThemeData(
        textStyle: TextStyle(color: darkColor),
        menuStyle: MenuStyle(
          backgroundColor:
              MaterialStateColor.resolveWith((states) => lightColor),
        ),
      ),
      cardTheme: CardTheme(
          color: lightColor,
          surfaceTintColor: lightColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            side: BorderSide(color: darkColor, width: 1),
          )),
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
          fontFamily: 'Roboto',
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: darkColor,
        ),
        headlineSmall: TextStyle(
          fontFamily: 'Roboto',
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: darkColor,
        ),
        bodyLarge: TextStyle(
          fontFamily: 'Roboto',
          fontSize: 16,
          color: darkColor,
        ),
        bodyMedium: TextStyle(
          fontFamily: 'Roboto',
          fontSize: 14,
          color: darkColor,
        ),
        bodySmall: TextStyle(
          fontFamily: 'Roboto',
          fontSize: 12,
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
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: lightColor),
        titleTextStyle: TextStyle(color: lightColor),
      ),
      chipTheme: ChipThemeData(
        deleteIconColor: lightColor,
        labelStyle: TextStyle(color: lightColor),
        color: MaterialStateColor.resolveWith((states) => darkColor),
      ),
      dropdownMenuTheme: DropdownMenuThemeData(
        textStyle: TextStyle(color: lightColor),
        inputDecorationTheme: InputDecorationTheme(
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
                color: primaryColor, style: BorderStyle.solid, width: 3),
          ),
          hintStyle: TextStyle(color: lightColor),
        ),
        menuStyle: MenuStyle(
          backgroundColor:
              MaterialStateColor.resolveWith((states) => darkColor),
        ),
      ),
      cardTheme: CardTheme(
          color: darkColor,
          surfaceTintColor: darkColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            side: BorderSide(color: lightColor, width: 1),
          )),
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
          fontFamily: 'Roboto',
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: lightColor,
        ),
        headlineMedium: TextStyle(
          fontFamily: 'Roboto',
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: lightColor,
        ),
        headlineSmall: TextStyle(
          fontFamily: 'Roboto',
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: lightColor,
        ),
        bodyLarge: TextStyle(
          fontFamily: 'Roboto',
          fontSize: 16,
          color: lightColor,
        ),
        bodyMedium: TextStyle(
          fontFamily: 'Roboto',
          fontSize: 14,
          color: lightColor,
        ),
        bodySmall: TextStyle(
          fontFamily: 'Roboto',
          fontSize: 12,
          color: lightColor,
        ),
      ),
    );
  }
}
