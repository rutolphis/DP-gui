import 'package:flutter/material.dart';
class TextStylesConstants {
  static const TextStyle h1 = TextStyle(
    fontSize: 48,
    decoration: TextDecoration.none,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w700,
    height: 48 / 48,
    letterSpacing: 0,
  );

  static const TextStyle h2 = TextStyle(
    fontSize: 36,
    decoration: TextDecoration.none,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w700,
    height: 36 / 36,
    letterSpacing: 0,
  );

  static const TextStyle bodyLarge = TextStyle(
    fontSize: 28,
    decoration: TextDecoration.none,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w400,
    height: 28 / 28,
    letterSpacing: 0,
  );

  static const TextStyle bodyBase = TextStyle(
    fontSize: 18,
    decoration: TextDecoration.none,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w400,
    height: 18 / 18,
    letterSpacing: 0,
  );

  static const TextStyle caption = TextStyle(
    fontSize: 14,
    decoration: TextDecoration.none,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w400,
    height: 14 / 14,
    letterSpacing: 0,
  );

  // Prevent class instantiation.
  TextStylesConstants._();
}
