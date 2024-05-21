import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NoInternetViewClass extends StatelessWidget {
  const NoInternetViewClass({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          margin: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.wifi_off,
                size: 100,
                color: Theme.of(context).colorScheme.primaryContainer,
              ),
              SizedBox(height: 20),
              Text(
                'Hold on! You\'re offline.',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: GoogleFonts.fredoka().fontFamily,
                ),
              ),
              SizedBox(height: 5),
              Text(
                'Please check your internet connection and restart the application.',
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: GoogleFonts.fredoka().fontFamily,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}