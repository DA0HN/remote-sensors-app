import 'package:meta/meta.dart';

class SensorModel {
  double temperature;
  DateTime date;

  SensorModel({@required this.temperature, @required this.date});

  SensorModel.fromJson(Map<String, dynamic> json) {
    temperature = json['temperature'];
    date = DateTime.tryParse(json['date']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['temperature'] = this.temperature;
    data['date'] = this.date;
    return data;
  }

  @override
  String toString() {
    return 'SensorModel{temperature: $temperature, date: $date}';
  }
}
