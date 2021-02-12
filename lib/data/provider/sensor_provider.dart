import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../model/sensor_model.dart';
import '../model/sensor_response.dart';
import 'abstract_sensor_provider.dart';

// const api = 'http://192.168.0.32:5000/api/v1/remote-sensors';
const api = 'https://my-remote-sensors.herokuapp.com/api/v1/remote-sensors';

class SensorProvider implements AbstractSensorProvider {
  final Dio dio;

  SensorProvider({@required this.dio});

  @override
  Future<SensorModel> currentTemperature() async {
    final response = await dio.get('$api/temperature');

    final sensorResponse = SensorResponse.fromJson(response.data);

    if (response.statusCode == 200 && !sensorResponse.hasError) {
      return sensorResponse.data;
    } else {
      print('Erro método GET\n\tstatus: ${response.statusCode}\n\tmessage: '
          '${sensorResponse.message}');
      throw Exception(sensorResponse.message);
    }
  }
}
