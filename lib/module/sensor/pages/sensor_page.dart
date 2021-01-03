import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/sensor_controller.dart';
import '../widget/sensor_chart.dart';

class SensorPage extends GetView<SensorController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Remote sensors app'),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        // onPressed: () {
        //   Get.find<SensorController>().updateChart();
        // },
      ),
      body: PageView(
        children: [
          Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(32),
            ),
            color: const Color(0xff020227),
            child: Padding(
              padding: const EdgeInsets.only(top: 16),
              child: SensorChart(),
            ),
          )
        ],
      ),
    );
  }
}

// GetX<SensorController>(
// initState: (state) => Get.find<SensorController>().updateChart(),
// builder: (controller) {
