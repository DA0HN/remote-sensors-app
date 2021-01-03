import 'package:charts_flutter/flutter.dart';
import 'package:flutter/material.dart';

import '../../../data/model/sensor_model.dart';

class SensorChart extends StatelessWidget {
  final List<Series> seriesList = _createSampleData();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TimeSeriesChart(
        seriesList,
        customSeriesRenderers: [
          LineRendererConfig(
            // ID used to link series to this renderer.
            customRendererId: 'customArea',
            includeArea: true,
            stacked: true,
          ),
        ],
      ),
    );
  }

  /// Create one series with sample hard coded data.
  static List<Series<SensorModel, DateTime>> _createSampleData() {
    final sensorModelData = [
      new SensorModel(
        temperature: 32.5,
        date: DateTime.now().subtract(
          Duration(hours: 2, minutes: 30),
        ),
      ),
      new SensorModel(
        temperature: 25.2,
        date: DateTime.now().subtract(
          Duration(hours: 3, minutes: 2),
        ),
      ),
      new SensorModel(
        temperature: 27.1,
        date: DateTime.now().subtract(
          Duration(minutes: 45),
        ),
      ),
      new SensorModel(
        temperature: 20.7,
        date: DateTime.now().subtract(
          Duration(hours: 1, minutes: 15),
        ),
      ),
    ];

    sensorModelData.sort((a, b) => a.date.isAfter(b.date) ? 1 : -1);

    return [
      Series<SensorModel, DateTime>(
        id: 'Desktop',
        colorFn: (_, __) => MaterialPalette.blue.shadeDefault,
        domainFn: (SensorModel model, _) => model.date,
        measureFn: (SensorModel model, _) => model.temperature,
        data: sensorModelData,
      ),
    ];
  }
}
