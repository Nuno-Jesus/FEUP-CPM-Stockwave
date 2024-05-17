import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';
import 'package:intl/intl.dart';


import '../api.dart';
import '../models/company.dart';
import '../models/series.dart';

class CompanyStockChart extends StatefulWidget {
  const CompanyStockChart({
    super.key,
    required this.firstSeries,
    required this.firstCompany,
    this.secondSeries = const [],
    this.secondCompany = const Company.empty(),
  });

  final List<Series> firstSeries;
  final List<Series> secondSeries;
  final Company firstCompany;
  final Company secondCompany;

  @override
  State<CompanyStockChart> createState() => _CompanyStockChartState();
}

class _CompanyStockChartState extends State<CompanyStockChart> {
  @override
  Widget build(BuildContext context) {
      return _buildCartesianChart(context);
  }

  Widget _buildCartesianChart(BuildContext context) {
    return SfCartesianChart(
      margin: const EdgeInsets.only(bottom: 10),
        plotAreaBorderWidth: 0,
        primaryXAxis: _buildXAxis(context),
        primaryYAxis: _buildYAxis(context),
        trackballBehavior: TrackballBehavior(
          enable: true,
          lineType: TrackballLineType.vertical,
          tooltipDisplayMode: TrackballDisplayMode.groupAllPoints,
          lineColor: Theme.of(context).colorScheme.onBackground,
          lineDashArray: <double>[5, 5],
          lineWidth: 1,
          activationMode: ActivationMode.singleTap,
          tooltipSettings: InteractiveTooltip(
            textStyle: TextStyle(
                fontSize: 14,
                fontFamily: GoogleFonts.fredoka().fontFamily,
                color: Theme.of(context).colorScheme.background
            ),
            borderWidth: 0,
          ),
        ),
        series: <CartesianSeries>[
          SplineSeries<Series, DateTime>(
            name: widget.firstCompany['symbol'],
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
              name: widget.secondCompany['symbol'],
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

  DateTimeAxis _buildXAxis(BuildContext context){
    return DateTimeAxis(
      isVisible: true,
      majorTickLines: const MajorTickLines(size: 0),
      // majorGridLines: const MajorGridLines(width: 0),
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

  NumericAxis _buildYAxis(BuildContext context){
    return const NumericAxis(
        isVisible: true,
        axisLine: AxisLine(width: 0),
        majorTickLines: MajorTickLines(size: 0),
        // majorGridLines: MajorGridLines(width: 0),
        maximumLabelWidth: 0,
        interactiveTooltip: InteractiveTooltip(enable: true)
    );
  }
}