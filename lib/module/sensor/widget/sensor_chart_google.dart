import 'package:charts_flutter/flutter.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../../../data/model/sensor_model.dart';

class SensorChartGoogle extends StatelessWidget {
  final List<SensorModel> data;
  final double minimum, maximum;

  SensorChartGoogle({
    @required this.data,
    @required this.minimum,
    @required this.maximum,
  });

  @override
  Widget build(BuildContext context) {
    return TimeSeriesChart(
      [
        Series<SensorModel, DateTime>(
          id: 'Data',
          colorFn: (_, __) => MaterialPalette.pink.shadeDefault,
          domainFn: (SensorModel model, _) => model.date,
          measureFn: (SensorModel model, _) => model.temperature,
          data: this.data,
        ),
      ],
      dateTimeFactory: const LocalDateTimeFactory(),
      animate: true,
      domainAxis: DateTimeAxisSpec(
        tickFormatterSpec: AutoDateTimeTickFormatterSpec(
          minute: TimeFormatterSpec(format: 'ms', transitionFormat: 'jms'),
        ),
        renderSpec: GridlineRendererSpec(
          labelStyle: TextStyleSpec(
            fontSize: 16,
            color: MaterialPalette.deepOrange.shadeDefault,
          ),
        ),
      ),
      primaryMeasureAxis: NumericAxisSpec(
        renderSpec: GridlineRendererSpec(
          labelStyle: TextStyleSpec(
            fontSize: 18,
            color: MaterialPalette.deepOrange.shadeDefault,
          ),
        ),
        viewport: NumericExtents(this.minimum, this.maximum),
      ),
      behaviors: [
        ChartTitle(
          'Tempo (minutos)',
          behaviorPosition: BehaviorPosition.bottom,
          titleStyleSpec: TextStyleSpec(
            fontSize: 16,
            color: MaterialPalette.deepOrange.shadeDefault,
          ),
        ),
        ChartTitle(
          'Temperatura ºC',
          behaviorPosition: BehaviorPosition.start,
          titleStyleSpec: TextStyleSpec(
            fontSize: 16,
            color: MaterialPalette.deepOrange.shadeDefault,
          ),
        )
      ],
    );
  }
}
