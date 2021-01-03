import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../controller/sensor_controller.dart';
import '../widget/sensor_chart_google.dart';

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
      floatingActionButton: FloatingActionButton(
        onPressed: () => controller.updateChart(),
        child: Icon(Icons.update),
        mini: true,
      ),
      body: _body(),
    );
  }

  GetBuilder<SensorController> _body() {
    return GetBuilder(
      init: controller,
      initState: (_) => controller.updateChart(),
      builder: (controller) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: SensorChartGoogle(controller.data),
            ),
            Divider(height: 20, color: Colors.deepOrange),
            ..._details(controller.model),
          ],
        );
      },
    );
  }

  List<Widget> _details(model) {
    return [
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
      ),
    ];
  }
}
