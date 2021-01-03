import 'dart:async';

import 'package:get/get.dart';
import 'package:meta/meta.dart';

import '../../../data/model/sensor_model.dart';
import '../../../data/repository/sensor_repository.dart';

class SensorController extends GetxController {
  final SensorRepository repository;

  final _data = <SensorModel>[];
  SensorModel _currentModel = SensorModel(temperature: null, date: null);
  bool _isInLoopUpdate = false;
  Timer _loopUpdateTask;
  final int _seconds = 10;

  SensorController({@required this.repository});

  Future<void> updateChart() async {
    final model = repository.currentTemperature();
    this._data.add(model);
    _currentModel = model;
    update();
  }

  _loopUpdate() {
    _loopUpdateTask = Timer.periodic(
      Duration(seconds: _seconds),
      (_) => updateChart(),
    );
  }

  startLoop() {
    this._isInLoopUpdate = true;
    _loopUpdate();
    Get.snackbar(
      'Iniciando loop...',
      'A cada $_seconds segundos a temperatura será atualizada',
    );
    update();
  }

  stopLoop() {
    this._isInLoopUpdate = false;
    _loopUpdateTask?.cancel();
    update();
  }

  List<SensorModel> get data => this._data;

  SensorModel get model => this._currentModel;

  bool get isInLoopUpdate => this._isInLoopUpdate;
}
