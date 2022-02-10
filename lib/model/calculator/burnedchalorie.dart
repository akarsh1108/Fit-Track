class BurnedCalorieModel {
  BurnedCalorieModel({
    required this.statusCode,
    required this.requestResult,
    required this.data,
  });
  late final int statusCode;
  late final String requestResult;
  late final BurnedData data;

  BurnedCalorieModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    requestResult = json['request_result'];
    data = BurnedData.fromJson(json['data']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status_code'] = statusCode;
    _data['request_result'] = requestResult;
    _data['data'] = data.toJson();
    return _data;
  }
}

class BurnedData {
  BurnedData({
    required this.burnedCalorie,
    required this.unit,
  });
  late final String burnedCalorie;
  late final String unit;

  BurnedData.fromJson(Map<String, dynamic> json) {
    burnedCalorie = json['burnedCalorie'];
    unit = json['unit'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['burnedCalorie'] = burnedCalorie;
    _data['unit'] = unit;
    return _data;
  }
}

enum BurnedResponseStates{
  SUCCESS,
  FAILURE,
  DUPLICATE,
  IGNORE,
}