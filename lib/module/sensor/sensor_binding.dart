import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../../data/provider/sensor_provider.dart';
import '../../data/repository/sensor_repository.dart';
import 'controller/sensor_controller.dart';

class SensorBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SensorController>(
      () => SensorController(
        repository: SensorRepository(
          provider: SensorProvider(
            dio: Dio(),
          ),
        ),
      ),
    );
  }
}
