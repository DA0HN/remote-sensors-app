import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:remote_sensors_app/module/sensor/widget/sensor_chart_fl.dart';

import '../controller/sensor_controller.dart';

class SensorPage extends GetView<SensorController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Remote sensors app'),
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
              onPressed: () => controller.isInLoopUpdate
                  ? controller.stopLoop()
                  : controller.updateChart(),
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
                child: Card(
                  child: SensorChartFl(
                    data: controller.spots,
                    config: controller.chartConfig,
                  ),
                ),
              ),
              Divider(height: 20, color: Colors.deepOrange),
              _details(controller.model),
            ],
          ),
        );
      },
    );
  }

  Widget _details(model) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          '${model.temperature.toStringAsFixed(2)} ºC',
          style: TextStyle(fontSize: 25, color: Colors.deepOrange),
        ),
        Text(
          '${DateFormat(DateFormat.HOUR24_MINUTE_SECOND, 'pt_BR').format(model.date)}',
          style: TextStyle(
            fontSize: 25,
            color: Colors.deepOrange,
          ),
        )
      ],
    );
  }
}
