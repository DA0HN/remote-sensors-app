import 'dart:math';

import '../model/sensor_model.dart';
import 'abstract_sensor_provider.dart';

class SensorFakeProvider implements AbstractSensorProvider {
  final _random = new Random();
  final _min = 26;
  final _max = 28;

  @override
  Future<SensorModel> currentTemperature() async {
    final temperature = _random.nextDouble() * (_max - _min) + _min;
    return SensorModel(temperature: temperature, date: DateTime.now());
  }
}
