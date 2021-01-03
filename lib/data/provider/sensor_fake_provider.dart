import 'dart:math';

import '../model/sensor_model.dart';
import 'sensor_provider.dart';

class SensorFakeProvider implements AbstractSensorProvider {
  final _random = new Random();
  final _min = 15;
  final _max = 40;

  @override
  SensorModel currentTemperature() {
    final temperature = _random.nextDouble() * (_max - _min) + _min;
    return SensorModel(temperature: temperature, date: DateTime.now());
  }
}
