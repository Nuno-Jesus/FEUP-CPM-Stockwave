import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NoRequestsLeftView extends StatelessWidget {
  const NoRequestsLeftView({Key? key}) : super(key: key);

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
                Icons.http_rounded,
                size: 100,
                color: Theme.of(context).colorScheme.primaryContainer,
              ),
              SizedBox(height: 20),
              Text(
                'You run out of requests.',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: GoogleFonts.fredoka().fontFamily,
                ),
              ),
              SizedBox(height: 5),
              Text(
                'Our API has a 25 requests limit per router. Consider upgrading your plan or try again later!',
                style: TextStyle(
                  fontSize: 15,
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