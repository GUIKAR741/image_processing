import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_processing/app/shared/util/converters.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Histograma extends StatefulWidget {
  final Uint8List imagem;

  const Histograma({
    Key? key,
    required this.imagem,
  }) : super(key: key);

  @override
  _HistogramaState createState() => _HistogramaState();
}

class _HistogramaState extends State<Histograma> {
  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      plotAreaBorderWidth: 0,
      primaryXAxis: NumericAxis(
        majorGridLines: const MajorGridLines(width: 0),
        minimum: 0,
        maximum: 255,
      ),
      primaryYAxis: NumericAxis(
        minimum: 0,
        // maximum: 255,
        majorTickLines: const MajorTickLines(size: 0),
      ),
      series: getSeries(
        values: widget.imagem,
      ),
      tooltipBehavior:
          TooltipBehavior(enable: true, header: '', canShowMarker: false),
    );
  }
}
