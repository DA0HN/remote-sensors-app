import '../model/sensor_model.dart';

abstract class AbstractSensorProvider {
  SensorModel currentTemperature();
}

class SensorProvider implements AbstractSensorProvider {
  @override
  SensorModel currentTemperature() {
    throw UnimplementedError();
  }
}
