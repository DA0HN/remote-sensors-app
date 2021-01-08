import '../model/sensor_model.dart';

abstract class AbstractSensorProvider {
  Future<SensorModel> currentTemperature();
}
