import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';
import 'package:intl/intl.dart';


import '../api.dart';
import '../models/series.dart';

class StockChart extends StatefulWidget {
  const StockChart({
    super.key,
    required this.firstSeries,
    this.secondSeries = const [],
  });

  final List<Series> firstSeries;
  final List<Series> secondSeries;

  @override
  State<StockChart> createState() => _StockChartState();
}

class _StockChartState extends State<StockChart> {


  @override
  Widget build(BuildContext context) {
    debugPrint('Using series: ${widget.firstSeries.length}');
    return SfCartesianChart(
        margin: const EdgeInsets.symmetric(horizontal: 0),
        plotAreaBorderWidth: 0,
        primaryXAxis: DateTimeAxis(
          dateFormat: DateFormat.MMMd(),
        ),
        primaryYAxis: const NumericAxis(isVisible: false),
        trackballBehavior: TrackballBehavior(
            enable: true,
            activationMode: ActivationMode.singleTap,
            lineType: TrackballLineType.vertical,
            tooltipSettings: InteractiveTooltip(
                enable: true,
                color: Theme.of(context).colorScheme.inversePrimary,
                textStyle: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 12,
                    fontFamily: GoogleFonts.fredoka().fontFamily,
                ),
                borderWidth: 0,
                format: 'Close: point.y \$',
            )
        ),
        series: <CartesianSeries>[
          SplineSeries<Series, DateTime>(
              dataSource: widget.firstSeries,
              splineType: SplineType.natural,
              color: Theme.of(context).colorScheme.primaryContainer,
              width: 6,
              xValueMapper: (Series data, _) => DateTime(
                  int.parse(data.date.substring(0, 4)),
                  int.parse(data.date.substring(5, 7)),
                  int.parse(data.date.substring(8, 10)),
              ),
              yValueMapper: (Series data, _) => data.close,
              animationDuration: 500,
          ),
          if (widget.secondSeries.isNotEmpty)
            SplineSeries<Series, DateTime>(
              dataSource: widget.secondSeries,
              splineType: SplineType.natural,
              color: Theme.of(context).colorScheme.secondaryContainer,
              width: 6,
              xValueMapper: (Series data, _) => DateTime(
                  int.parse(data.date.substring(0, 4)),
                  int.parse(data.date.substring(5, 7)),
                  int.parse(data.date.substring(8, 10)),
              ),
              yValueMapper: (Series data, _) => data.close,
              animationDuration: 500,
          ),

        ]
    );
  }
}