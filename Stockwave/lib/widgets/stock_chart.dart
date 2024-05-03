import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

import '../api.dart';

class StockChart extends StatefulWidget {
  const StockChart({
    super.key,
    required this.series
  });

  final List<Series> series;

  @override
  State<StockChart> createState() => _StockChartState();
}

class _StockChartState extends State<StockChart> {


  @override
  Widget build(BuildContext context) {

    //Change the current theme from light to dark

    return SfCartesianChart(
        margin: const EdgeInsets.symmetric(horizontal: 0),
        plotAreaBorderWidth: 0,
        primaryXAxis: const NumericAxis(
            isVisible: false,
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
                format: 'Value: point.y\nDate: point.x'
            )
        ),
        series: <CartesianSeries>[
          SplineSeries<Series, int>(
              dataSource: widget.series,
              splineType: SplineType.natural,
              color: Theme.of(context).colorScheme.primaryContainer,
              width: 6,
              xValueMapper: (Series data, _) => int.parse(data.date.split('-').last),
              yValueMapper: (Series data, _) => data.close,
              animationDuration: 500,
          ),
          SplineSeries<Series, int>(
              dataSource: widget.series,
              color: Theme.of(context).colorScheme.secondaryContainer,
              width: 6,
              xValueMapper: (Series data, _) => int.parse(data.date.split('-').last),
              yValueMapper: (Series data, _) => data.open,
              animationDuration: 500,
          )
        ]
    );
  }
}