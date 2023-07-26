import 'package:flutter/material.dart';

const kColors = <Color>[
  Color(0xFFFFFFFF),
  Color(0xffF28B83),
  Color(0xFFFCBC05),
  Color(0xFFFFF476),
  Color(0xFFCBFF90),
  Color(0xFFA7FEEA),
  Color(0xFFE6C9A9),
  Color(0xFFE8EAEE),
  Color(0xFFA7FEEA),
  Color(0xFFCAF0F8)
];

final kTheme = ThemeData(
  primarySwatch: Colors.deepPurple,
  textTheme: const TextTheme(
    headlineSmall: TextStyle(
      fontFamily: 'Sans',
      fontWeight: FontWeight.bold,
      color: Colors.black,
      fontSize: 24,
    ),
    bodyMedium: TextStyle(
      fontFamily: 'Sans',
      fontWeight: FontWeight.bold,
      color: Colors.black,
      fontSize: 20,
    ),
    bodyLarge: TextStyle(
      fontFamily: 'Sans',
      fontWeight: FontWeight.normal,
      color: Colors.black,
      fontSize: 18,
    ),
    titleSmall: TextStyle(
      fontFamily: 'Sans',
      fontWeight: FontWeight.normal,
      color: Colors.black,
      fontSize: 14,
    ),
  ),
);
