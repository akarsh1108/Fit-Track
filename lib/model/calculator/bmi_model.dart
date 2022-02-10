class BmiModel {
  BmiModel({
    required this.statusCode,
    required this.requestResult,
    required this.data,
  });
  late final int statusCode;
  late final String requestResult;
  late final BmiData data;

  BmiModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    requestResult = json['request_result'];
    data = BmiData.fromJson(json['data']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status_code'] = statusCode;
    _data['request_result'] = requestResult;
    _data['data'] = data.toJson();
    return _data;
  }
}

class BmiData {
  BmiData({
    required this.bmi,
    required this.health,
    required this.healthyBmiRange,
  });
  late final double bmi;
  late final String health;
  late final String healthyBmiRange;

  BmiData.fromJson(Map<String, dynamic> json) {
    bmi = json['bmi'];
    health = json['health'];
    healthyBmiRange = json['healthy_bmi_range'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['bmi'] = bmi;
    _data['health'] = health;
    _data['healthy_bmi_range'] = healthyBmiRange;
    return _data;
  }
}

enum BmiResponseStates{
  SUCCESS,
  FAILURE,
  DUPLICATE,
  IGNORE,
}