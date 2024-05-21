import 'dart:io';

import 'package:Stockwave/views/no_internet_view.dart';
import 'package:flutter/material.dart';
import 'package:Stockwave/theme.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Stockwave/views/company_list_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode themeMode = ThemeMode.light;
  bool hasInternet = false;

  @override
  void initState() {
    super.initState();
    assertInternetConnection();
  }

  void assertInternetConnection() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        setState(() {
          hasInternet = true;
        });
      }
    } on SocketException catch (_) {
      setState(() {
        hasInternet = false;
      });
    }
  }
  
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
      home: hasInternet
            ? CompanyListView(onToggleTheme: _toggleTheme)
            : const NoInternetViewClass()
      );
  }
}
