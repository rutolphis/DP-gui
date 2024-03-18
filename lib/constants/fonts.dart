import 'package:flutter/material.dart';

class TextStyles {
  const TextStyles();


  TextStyle get h1 => const TextStyle(
    fontSize: 48,
    decoration: TextDecoration.none,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w700,
    height: 48 / 48,
    letterSpacing: 0,
  );

  TextStyle get h2 => const TextStyle(
    fontSize: 36,
    decoration: TextDecoration.none,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w700,
    height: 36 / 36,
    letterSpacing: 0,
  );

  TextStyle get bodyLarge => const TextStyle(
    fontSize: 28,
    decoration: TextDecoration.none,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w400,
    height: 28 / 28,
    letterSpacing: 0,
  );

  TextStyle get bodyBase => const TextStyle(
    fontSize: 18,
    decoration: TextDecoration.none,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w400,
    height: 18 / 18,
    letterSpacing: 0,
  );

  TextStyle get caption => const TextStyle(
    fontSize: 14,
    decoration: TextDecoration.none,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w400,
    height: 14 / 14,
    letterSpacing: 0,
  );

}