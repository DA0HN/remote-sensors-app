import 'package:meta/meta.dart';

import '../model/sensor_model.dart';
import '../provider/abstract_sensor_provider.dart';

class SensorRepository {
  final AbstractSensorProvider provider;

  SensorRepository({@required this.provider});

  Future<SensorModel> currentTemperature() async {
    return await this.provider.currentTemperature();
  }
}
