import 'sensor_model.dart';

class SensorResponse {
  SensorModel data;
  int queueSize;
  String message;
  bool hasError;

  SensorResponse(
      {SensorModel data, int queueSize, String message, bool hasError}) {
    this.data = data;
    this.queueSize = queueSize;
    this.message = message;
    this.hasError = hasError;
  }

  SensorResponse.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new SensorModel.fromJson(json['data']) : null;
    queueSize = json['queueSize'];
    message = json['message'];
    hasError = json['hasError'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    data['queueSize'] = this.queueSize;
    data['message'] = this.message;
    data['hasError'] = this.hasError;
    return data;
  }
}
