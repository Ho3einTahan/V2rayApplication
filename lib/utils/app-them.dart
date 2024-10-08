import 'package:flutter/material.dart';

ThemeData AppTheme() {
  return ThemeData(
    inputDecorationTheme: InputDecorationTheme(border: OutlineInputBorder(borderRadius: BorderRadius.circular(16))),
    textTheme: const TextTheme(
      displaySmall: TextStyle(fontFamily: "PTH", fontWeight: FontWeight.w100, fontSize: 16),
      displayMedium: TextStyle(fontFamily: "PR", fontWeight: FontWeight.w200, color: Colors.white, fontSize: 25),
      bodyMedium: TextStyle(fontFamily: "PM", fontWeight: FontWeight.w300, color: Colors.black, fontSize: 48),
      bodyLarge: TextStyle(fontFamily: "PL", fontWeight: FontWeight.w400, color: Colors.white, fontSize: 40),
      headlineLarge: TextStyle(fontFamily: "PB", fontWeight: FontWeight.w500),
      labelLarge: TextStyle(fontFamily: "PXL", fontWeight: FontWeight.w600),
      titleLarge: TextStyle(fontFamily: "PXB", fontWeight: FontWeight.w800),
      displayLarge: TextStyle(fontFamily: "PBOLD", fontWeight: FontWeight.w900),
    ),
    // useMaterial3: true,
    brightness: Brightness.dark,
  );
}
