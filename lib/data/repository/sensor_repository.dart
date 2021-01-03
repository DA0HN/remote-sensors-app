import 'package:meta/meta.dart';

import '../model/sensor_model.dart';
import '../provider/sensor_provider.dart';

class SensorRepository {
  final AbstractSensorProvider provider;

  SensorRepository({@required this.provider});

  SensorModel currentTemperature() {
    return this.provider.currentTemperature();
  }
}
