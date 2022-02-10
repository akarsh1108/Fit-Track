class FoodinfoModel {
  FoodinfoModel({
    required this.statusCode,
    required this.requestResult,
    required this.data,
  });
  late final int statusCode;
  late final String requestResult;
  late final List<InfoData> data;
  
  FoodinfoModel.fromJson(Map<String, dynamic> json){
    statusCode = json['status_code'];
    requestResult = json['request_result'];
    data = List.from(json['data']).map((e)=>InfoData.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status_code'] = statusCode;
    _data['request_result'] = requestResult;
    _data['data'] = data.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class InfoData {
  InfoData({
    required this.sid,
    required this.dataType,
    required this.subDataType,
    required this.id,
    required this.foodType,
  });
  late final String sid;
  late final String dataType;
  late final String subDataType;
  late final String id;
  late final String foodType;
  
  InfoData.fromJson(Map<String, dynamic> json){
    sid = json['_id'];
    dataType = json['dataType'];
    subDataType = json['subDataType'];
    id = json['id'];
    foodType = json['foodType'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['_id'] = sid;
    _data['dataType'] = dataType;
    _data['subDataType'] = subDataType;
    _data['id'] = id;
    _data['foodType'] = foodType;
    return _data;
  }
}

enum FoodInfoResponseStates{
  SUCCESS,
  FAILURE,
  DUPLICATE,
  IGNORE,
}