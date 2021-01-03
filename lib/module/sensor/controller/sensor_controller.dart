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
  bool _isInLoopUpdate = false;
  Timer _loopUpdateTask;
  final int _seconds = 10;

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

  _loopUpdate() {
    _loopUpdateTask = Timer.periodic(
      Duration(seconds: _seconds),
      (_) => updateChart(),
    );
  }

  startLoop() {
    this._isInLoopUpdate = true;
    _loopUpdate();
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
