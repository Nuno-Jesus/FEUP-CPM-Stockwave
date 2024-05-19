import 'package:flutter/material.dart';
import 'package:Stockwave/theme.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Stockwave/views/company_list_view.dart';
import 'package:Stockwave/views/two_company_view.dart';

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
      home: CompanyListView(onToggleTheme: _toggleTheme),
    );
  }
}
