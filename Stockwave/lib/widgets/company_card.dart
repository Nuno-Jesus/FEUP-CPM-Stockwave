import 'package:flutter/material.dart';

import '../api.dart';

class CompanyCard extends StatelessWidget {
  const CompanyCard({
    super.key,
    required this.name,
    required this.nasdaq,
    required this.icon,
    required this.todaySeries,
    required this.cardColor,
    required this.textColor
  });

  final String name;
  final String nasdaq;
  final IconData icon;
  final Series todaySeries;
  final Color cardColor;
  final Color textColor;

  @override
  Widget build(BuildContext context){
    return Container(
      // color: Theme.of(context).colorScheme.error,
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
                ),              ),
              buildBottomRow(context)
            ],
          )
        ),
      ),
    );
  }

  Widget buildTopRow(BuildContext context){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
        // Company Logo
        children: [
          Container(
            padding: const EdgeInsets.all(7),
            decoration: BoxDecoration(
              color: const Color.fromRGBO(0, 0, 0, 0.17),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, size: 30, color: textColor),
          ),

          // Company name and NASDAQ symbol
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(left: 11),
                child: Text(
                  nasdaq,
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
                child: Text(
                  name,
                  style: TextStyle(
                      color: textColor.withOpacity(0.7),
                      fontSize: 14,
                      fontWeight: FontWeight.w400
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
            const Text(
              "(+7,01%) USD",
              style: TextStyle(
                  color: Color(0xFF42CFA2),
                  fontSize: 14,
                  fontWeight: FontWeight.w400
              ),
            ),

          ],
        )
    ]);
  }

  Widget buildBottomRow(BuildContext context){
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
              'Day Close',
              style: TextStyle(
                  color: textColor.withOpacity(0.6),
                  fontSize: 14,
                  fontWeight: FontWeight.bold
              ),
            ),
            Text(
              '\$ ${todaySeries.close.toStringAsFixed(2)}',
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