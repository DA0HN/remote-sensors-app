import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../controller/sensor_controller.dart';
import '../widget/sensor_chart_fl.dart';

class SensorPage extends GetView<SensorController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Remote sensors app'),
        // TODO: adicionar switch para alternar a apresentação de pontos no gráfico
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniStartDocked,
      floatingActionButton: GetBuilder(
        init: controller,
        builder: (controller) {
          return InkWell(
            splashColor: Colors.deepOrange,
            onLongPress: () => controller.startLoop(),
            child: FloatingActionButton(
              splashColor: Colors.deepOrange,
              onPressed: () async => controller.isInLoopUpdate
                  ? controller.stopLoop()
                  : await controller.updateChart(),
              child: controller.isInLoopUpdate
                  ? Icon(Icons.stop)
                  : Icon(Icons.update),
              mini: true,
            ),
          );
        },
      ),
      body: _body(),
    );
  }

  GetBuilder<SensorController> _body() {
    return GetBuilder(
      init: controller,
      initState: (_) async => await controller.updateChart(),
      builder: (controller) {
        return Container(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: controller.model == null
                    ? _currentModelIsNotLoaded()
                    : _chart(controller),
              ),
              Divider(height: 20, color: Colors.deepOrange),
              _details(controller.model),
            ],
          ),
        );
      },
    );
  }

  Card _chart(SensorController controller) {
    return Card(
      child: SensorChartFl(
        data: controller.spots,
        config: controller.chartConfig,
      ),
    );
  }

  Column _currentModelIsNotLoaded() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
          child: CircularProgressIndicator(),
        ),
        SizedBox(height: 20),
        Text(
          'Não foi possível consultar a temperatura :(',
          style: TextStyle(fontSize: 20, color: Colors.deepOrange),
        )
      ],
    );
  }

  Widget _details(model) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        model == null
            ? Text('')
            : Text(
                '${model?.temperature?.toStringAsFixed(2)} ºC',
                style: TextStyle(
                  fontSize: 25,
                  color: Colors.deepOrange,
                ),
              ),
        model == null
            ? Text('')
            : Text(
                '${DateFormat(DateFormat.HOUR24_MINUTE_SECOND, 'pt_BR').format(model?.date)}',
                style: TextStyle(
                  fontSize: 25,
                  color: Colors.deepOrange,
                ),
              )
      ],
    );
  }
}
