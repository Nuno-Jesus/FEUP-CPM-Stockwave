import 'package:flutter/material.dart';

const ColorScheme lightColorTheme = ColorScheme(
  primary: Color(0xFFFEFAF6),
  onPrimary: Colors.black,
  secondary: Color(0xFFEADBC8),
  onSecondary: Colors.black,
  error: Colors.redAccent,
  onError: Colors.white,
  background: Color(0xFFFEFAF6),
  onBackground: Colors.black,
  surface: Color(0xFFDAC0A3),
  onSurface: Colors.black,
  brightness: Brightness.light,
  inversePrimary: Color(0xFF121212),
);

const ColorScheme darkColorTheme = ColorScheme(
  primary: Color(0xFF121212),
  onPrimary: Colors.white,
  secondary: Color(0xFF1F1F1F),
  onSecondary: Colors.white,
  error: Colors.redAccent,
  onError: Colors.white,
  background: Color(0xFF121212),
  onBackground: Colors.white,
  surface: Color(0xFF1F1F1F),
  onSurface: Colors.white,
  brightness: Brightness.dark
);