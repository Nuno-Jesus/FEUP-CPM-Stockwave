import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NotAvailableView extends StatelessWidget {
  const NotAvailableView({Key? key}) : super(key: key);

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
                Icons.search_off_outlined,
                size: 100,
                color: Theme.of(context).colorScheme.primaryContainer,
              ),
              SizedBox(height: 20),
              Text(
                'Oops! You can\'t access this.',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: GoogleFonts.fredoka().fontFamily,
                ),
              ),
              SizedBox(height: 5),
              Text(
                'It looks like this resource is not available for now. Please try again later!',
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