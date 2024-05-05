import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyDivider extends StatelessWidget {
  final EdgeInsets margin;
  final double height;
  final double width;

  const MyDivider({
    super.key,
    this.margin = EdgeInsets.zero,
    this.height = 1,
    this.width = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      height: height,
      width: width,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [
                Theme.of(context).colorScheme.onBackground.withOpacity(0),
                Theme.of(context).colorScheme.onBackground.withOpacity(0.4),
                Theme.of(context).colorScheme.onBackground.withOpacity(0),
              ]
          )
      ),
    );
  }
}