import 'package:flutter/material.dart';

import '../models/company.dart';
import '../models/series.dart';

class CompanyCard extends StatelessWidget {
  const CompanyCard({
    super.key,
    required this.company,
    required this.todaySeries,
    this.isSecondary = false,
  });

  final Company company;
  final Series todaySeries;
  final bool isSecondary;

  @override
  Widget build(BuildContext context){
    final Color cardColor = isSecondary
        ? Theme.of(context).colorScheme.secondaryContainer
        : Theme.of(context).colorScheme.primaryContainer;

    final Color textColor = isSecondary
        ? Theme.of(context).colorScheme.onSecondaryContainer
        : Theme.of(context).colorScheme.onPrimaryContainer;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Card(
        color: cardColor,
        child: Container(
          padding: const EdgeInsets.all(13),
          child: Column(
            children: [
              buildTopRow(context),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                height: 1,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [
                          textColor.withOpacity(0),
                          textColor.withOpacity(1),
                          textColor.withOpacity(0),
                        ]
                    )
                ),
              ),
              buildBottomRow(context)
            ],
          )
        ),
      ),
    );
  }

  Widget buildTopRow(BuildContext context){
    final Color textColor = isSecondary
        ? Theme.of(context).colorScheme.onSecondaryContainer
        : Theme.of(context).colorScheme.onPrimaryContainer;

    final double differential = (todaySeries.close - todaySeries.open) / todaySeries.open * 100;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          // Company Logo
          children: [
            SizedBox(
              width: 50,
              height: 50,
              child: Container(
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(0, 0, 0, 0.17),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Image(
                  image: AssetImage('assets/logos/${company['symbol']}.png'),
                ),
              ),
            ),

            // Company name and NASDAQ symbol
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 11),
                  child: Text(
                    company['symbol'],
                    style: TextStyle(
                        color: textColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w600
                    ),
                  ),
                ),

                // Company name
                Container(
                  margin: const EdgeInsets.only(left: 11),
                  child: SizedBox(
                    width: 150,
                    child: Text(
                      company['name'],
                      style: TextStyle(
                          color: textColor.withOpacity(0.7),
                          fontSize: 12,
                          fontWeight: FontWeight.w400
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                )
              ],
            )
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              '\$${todaySeries.close.toStringAsFixed(2)}',
              style: TextStyle(
                  color: textColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold
              ),
            ),
            Text(
              "(${differential > 0 ? "+" : ""}${differential.toStringAsFixed(2)}%) USD",
              style: TextStyle(
                  color: (differential > 0 ? const Color(0xFF42CFA2) : const Color(0xFFD32F2F)),
                  fontSize: 14,
                  fontWeight: FontWeight.w400
              ),
            ),

          ],
        )
    ]);
  }

  Widget buildBottomRow(BuildContext context){
    final Color textColor = isSecondary
        ? Theme.of(context).colorScheme.onSecondaryContainer
        : Theme.of(context).colorScheme.onPrimaryContainer;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Day Open',
              style: TextStyle(
                  color: textColor.withOpacity(0.6),
                  fontSize: 14,
                  fontWeight: FontWeight.bold
              ),
            ),
            Text(
              '\$ ${todaySeries.open.toStringAsFixed(2)}',
              style: TextStyle(
                  color: textColor,
                  fontSize: 22,
                  fontWeight: FontWeight.bold
              ),
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Day High',
              style: TextStyle(
                  color: textColor.withOpacity(0.6),
                  fontSize: 14,
                  fontWeight: FontWeight.bold
              ),
            ),
            Text(
              '\$ ${todaySeries.high.toStringAsFixed(2)}',
              style: TextStyle(
                  color: textColor,
                  fontSize: 22,
                  fontWeight: FontWeight.bold
              ),
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Day Low',
              style: TextStyle(
                  color: textColor.withOpacity(0.6),
                  fontSize: 14,
                  fontWeight: FontWeight.bold
              ),
            ),
            Text(
              '\$ ${todaySeries.low.toStringAsFixed(2)}',
              style: TextStyle(
                  color: textColor,
                  fontSize: 22,
                  fontWeight: FontWeight.bold
              ),
            ),
          ],
        ),
      ],
    );
  }
}