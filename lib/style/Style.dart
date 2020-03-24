import 'package:flutter/material.dart';

class Style{
  Style._();

  static const String fontName = 'WorkSans';

  static const TextStyle welcomeText = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.bold,
    fontSize: 16.0,
    color: Colors.white,
  );

  static const TextStyle subCoinName = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.w600,
    fontSize: 12.0,
    color: Colors.grey,
  );

  static const TextStyle coinName = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.bold,
    fontSize: 14.0,
    color: Colors.purple,
  );

  static const TextStyle positiveValue = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.bold,
    fontSize: 12.0,
    color: Colors.green,
  );
  static const TextStyle negativeValue = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.bold,
    fontSize: 12.0,
    color: Colors.red,
  );

}