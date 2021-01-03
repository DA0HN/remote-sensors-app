import 'package:charts_flutter/flutter.dart';
import 'package:flutter/material.dart';

import '../../../data/model/sensor_model.dart';

class SensorChartGoogle extends StatelessWidget {
  final List<SensorModel> data;

  SensorChartGoogle(this.data);

  @override
  Widget build(BuildContext context) {
    return TimeSeriesChart(
      [
        Series<SensorModel, DateTime>(
          id: 'Data',
          colorFn: (_, __) => MaterialPalette.blue.shadeDefault,
          domainFn: (SensorModel model, _) => model.date,
          measureFn: (SensorModel model, _) => model.temperature,
          data: this.data,
        ),
      ],
      dateTimeFactory: const LocalDateTimeFactory(),
      animate: true,
      domainAxis: DateTimeAxisSpec(
        tickProviderSpec: DayTickProviderSpec(increments: [1]),
        tickFormatterSpec: AutoDateTimeTickFormatterSpec(
          day: TimeFormatterSpec(
              format: 'jms', transitionFormat: 'EEEE', noonFormat: 'jms'),
        ),
      ),
      customSeriesRenderers: [
        LineRendererConfig(
          customRendererId: 'customArea',
          includeArea: true,
          stacked: true,
          includePoints: true,
          includeLine: true,
        ),
      ],
    );
  }
}