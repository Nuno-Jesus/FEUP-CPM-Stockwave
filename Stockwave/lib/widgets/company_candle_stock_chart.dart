import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../models/company.dart';
import '../models/series.dart';

class CompanyCandleStockChart extends StatelessWidget{
  const CompanyCandleStockChart({
    super.key,
    required this.series,
    required this.company,
  });

  final List<Series> series;
  final Company company;

  @override
  Widget build(BuildContext context){
    return SfCartesianChart(
      margin: const EdgeInsets.only(bottom: 10),
      plotAreaBorderWidth: 0,
      primaryXAxis: _buildXAxis(context),
      primaryYAxis: _buildYAxis(context),
      tooltipBehavior: TooltipBehavior(
        enable: true,
        animationDuration: 200,
        duration: 3500,
        activationMode: ActivationMode.singleTap,
        textStyle: TextStyle(
          fontSize: 14,
          fontFamily: GoogleFonts.fredoka().fontFamily,
          color: Theme.of(context).colorScheme.background,
        ),
        borderWidth: 0,
      ),
      series: <CandleSeries<Series, DateTime>>[
        CandleSeries<Series, DateTime>(
          name: company['symbol'],
          dataSource: series,
          lowValueMapper: (Series sales, _) => sales.low,
          highValueMapper: (Series sales, _) => sales.high,
          openValueMapper: (Series sales, _) => sales.open,
          closeValueMapper: (Series sales, _) => sales.close,
          xValueMapper: (Series sales, _) => DateTime(
            int.parse(sales.date.substring(0, 4)),
            int.parse(sales.date.substring(5, 7)),
            int.parse(sales.date.substring(8, 10)),
          ),
          animationDuration: 500,
        )
      ],
    );
  }

  ChartAxis _buildXAxis(BuildContext context) {
    return DateTimeAxis(
      isVisible: true,
      majorTickLines: const MajorTickLines(size: 0),
      edgeLabelPlacement: EdgeLabelPlacement.shift,
      labelStyle: TextStyle(
        fontSize: 10,
        fontFamily: GoogleFonts.fredoka().fontFamily,
        color: Theme.of(context).colorScheme.onBackground,
      ),
      interactiveTooltip: InteractiveTooltip(
        enable: true,
        textStyle: TextStyle(fontSize: 14, fontFamily: GoogleFonts.fredoka().fontFamily),
        borderWidth: 0,
        color: Theme.of(context).colorScheme.onBackground,
      ),
      dateFormat: DateFormat.MMMd(),
    );
  }

  ChartAxis _buildYAxis(BuildContext context) {
    return const NumericAxis(
        isVisible: true,
        axisLine: AxisLine(width: 0),
        majorTickLines: MajorTickLines(size: 0),
        maximumLabelWidth: 0,
        interactiveTooltip: InteractiveTooltip(enable: true)
    );
  }
}