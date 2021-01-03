import 'package:charts_flutter/flutter.dart';
import 'package:flutter/material.dart';

import '../../../data/model/sensor_model.dart';
import '../../../data/provider/sensor_fake_provider.dart';
import '../../../data/repository/sensor_repository.dart';

class SensorChart extends StatelessWidget {
  final List<SensorModel> data;

  SensorChart(this.data);

  final SensorRepository repository = SensorRepository(
    provider: SensorFakeProvider(),
  );

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
