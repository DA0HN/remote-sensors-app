import 'dart:async';
import 'dart:math';

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

  double _minimumTemperature = 100000;
  double _maximumTemperature = 0;

  SensorController({@required this.repository});

  Future<void> updateChart() async {
    final model = repository.currentTemperature();
    this._data.add(model);
    _currentModel = model;
    _updateChartBoundaries();
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

  double get minimumTemperature => this._minimumTemperature;

  double get maximumTemperature => this._maximumTemperature;

  void _updateChartBoundaries() {
    this._minimumTemperature =
        this._data.map((data) => data.temperature).toList().reduce(min);
    this._maximumTemperature =
        this._data.map((data) => data.temperature).toList().reduce(max);
  }
}
