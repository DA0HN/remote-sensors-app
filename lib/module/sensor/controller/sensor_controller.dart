import 'dart:async';

import 'package:fl_chart/fl_chart.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';

import '../../../data/model/sensor_model.dart';
import '../../../data/repository/sensor_repository.dart';
import '../widget/sensor_chart_config.dart';

class SensorController extends GetxController {
  final SensorRepository repository;

  final _data = <SensorModel>[];
  SensorModel _currentModel;
  bool _isInLoopUpdate = false;
  Timer _loopUpdateTask;
  final int _seconds = 10;

  final SensorChartConfig _chartConfig = SensorChartConfig(leftLabelsCount: 6);

  SensorController({@required this.repository});

  // TODO: implementar percepção de que resta apenas um elemento na API
  Future<void> updateChart() async {
    try {
      final model = await repository.currentTemperature();
      this._data.add(model);
      _currentModel = model;
      _updateChartBoundaries();
    } catch (e) {
      final tryGetCurrentTemperatureAgain =
          this.isInLoopUpdate ? 'Será realizada uma nova consulta em 20s' : '';

      Get.snackbar(
          'Erro',
          'Ocorreu um erro ao tentar consultar a '
                  'temperatura.' +
              tryGetCurrentTemperatureAgain);
      stopLoop();

      Timer(Duration(seconds: 20), () {
        startLoop();
      });
    } finally {
      update();
    }
  }

  _loopUpdate() {
    _loopUpdateTask = Timer.periodic(
      Duration(seconds: _seconds),
      (_) async => await updateChart(),
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

  SensorChartConfig get chartConfig => this._chartConfig;

  List<FlSpot> get spots => this._data.map(
        (data) {
          return FlSpot(data?.date?.millisecondsSinceEpoch?.toDouble(),
              data?.temperature);
        },
      ).toList();

  void _updateChartBoundaries() {
    double minY = double.maxFinite;
    double maxY = double.minPositive;

    data.forEach((data) {
      if (minY > data.temperature) minY = data.temperature;
      if (maxY < data.temperature) maxY = data.temperature;
    });

    this._chartConfig.maxX = spots.last.x;
    this._chartConfig.minX = spots.first.x;
    this._chartConfig.maxY = maxY + 1;
    this._chartConfig.minY = minY - 1;

    _debug();

    this._chartConfig.leftTitlesInterval =
        ((this._chartConfig.maxY - this._chartConfig.minY) /
                (this._chartConfig.leftLabelsCount - 0.5))
            .floorToDouble();
  }

  void _debug() {
    if (false) {
      print(
          'maxY: ${this._chartConfig.maxY.ceilToDouble()}, minY: ${this._chartConfig.minY}');

      print(
          'max: ${this._chartConfig.maxX.ceilToDouble()}, min: ${this._chartConfig.minX}');
      print((this._chartConfig.maxX - this._chartConfig.minX) / 6);
    }
  }
}
