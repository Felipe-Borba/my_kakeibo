import 'package:flutter/material.dart';

final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.green,
    brightness: Brightness.light,
    secondary: Colors.blueAccent,
  ),
  scaffoldBackgroundColor: Colors.white,
  cardColor: Colors.grey[100],
  textTheme: TextTheme(
    displayLarge: TextStyle(
      color: Colors.grey[900],
      fontSize: 24,
      fontWeight: FontWeight.bold,
    ),
    bodyLarge: TextStyle(
      color: Colors.grey[800],
      fontSize: 16,
    ),
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.white,
    iconTheme: IconThemeData(color: Colors.grey[900]),
    titleTextStyle: TextStyle(color: Colors.grey[900], fontSize: 20),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: WidgetStateProperty.all(Colors.green[600]),
      foregroundColor: WidgetStateProperty.all(Colors.black),
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      textStyle: WidgetStateProperty.all(
        const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  ),
  iconTheme: IconThemeData(color: Colors.grey[700]),
);

final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.green,
    brightness: Brightness.dark,
    secondary: Colors.blueAccent,
  ),
  scaffoldBackgroundColor: Colors.grey[900],
  cardColor: Colors.grey[800],
  textTheme: TextTheme(
    displayLarge: const TextStyle(
      color: Colors.white,
      fontSize: 24,
      fontWeight: FontWeight.bold,
    ),
    bodyLarge: TextStyle(
      color: Colors.grey[300],
      fontSize: 16,
    ),
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.grey[850],
    iconTheme: const IconThemeData(color: Colors.white),
    titleTextStyle: const TextStyle(color: Colors.white, fontSize: 20),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: WidgetStateProperty.all(Colors.green[300]),
      foregroundColor: WidgetStateProperty.all(Colors.black),
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      textStyle: WidgetStateProperty.all(
        const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  ),
  iconTheme: IconThemeData(color: Colors.grey[300]),
);
