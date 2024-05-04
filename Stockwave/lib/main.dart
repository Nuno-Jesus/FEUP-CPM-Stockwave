import 'package:flutter/material.dart';
import 'package:stockwave/theme.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stockwave/views/two_company_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode themeMode = ThemeMode.light;
  
  void _toggleTheme() {
    setState(() {
      themeMode = themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: GoogleFonts.fredoka().fontFamily,
        colorScheme: lightColorTheme,
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        fontFamily: GoogleFonts.fredoka().fontFamily,
        colorScheme: darkColorTheme,
      ),
      themeMode: themeMode,
      home: TwoCompanyView(
        onToggleTheme: _toggleTheme,
        first: const {
          'symbol': 'AAPL',
          'icon': Icons.apple,
        },
        second: const {
          'symbol': 'MSFT',
          'icon': Icons.desktop_windows,
        },
      ),
    );
  }
}
