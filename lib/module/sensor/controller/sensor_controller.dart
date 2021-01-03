import 'dart:async';

import 'package:get/get.dart';
import 'package:meta/meta.dart';

import '../../../data/model/sensor_model.dart';
import '../../../data/repository/sensor_repository.dart';

class SensorController extends GetxController {
  final SensorRepository repository;

  // final RxList<SensorModel> _data = List<SensorModel>().obs;
  final _data = <SensorModel>[];
  SensorModel _currentModel = SensorModel(temperature: null, date: null);

  SensorController({@required this.repository}) {
    // Timer.periodic(Duration(seconds: 5), (timer) {
    //   updateChart();
    // });
  }

  // List<SensorModel> get data => _data.value;

  // set data(value) => this._data.assignAll(value);

  Future<void> updateChart() async {
    final model = repository.currentTemperature();
    this._data.add(model);
    _currentModel = model;
    update();
  }

  List<SensorModel> get data => _data;
  SensorModel get model => _currentModel;
}
