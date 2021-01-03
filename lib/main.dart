import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:remote_sensors_app/module/sensor/sensor_binding.dart';

import 'module/sensor/pages/sensor_page.dart';

void main() {
  runApp(RemoteSensorApp());
}

class RemoteSensorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Remote Sensor App',
      debugShowCheckedModeBanner: false,
      initialBinding: SensorBinding(),
      theme: ThemeData.dark(),
      home: SensorPage(),
    );
  }
}
