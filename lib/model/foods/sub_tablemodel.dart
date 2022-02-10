class SubtableModel {
  SubtableModel({
    required this.statusCode,
    required this.requestResult,
    required this.data,
  });
  late final int statusCode;
  late final String requestResult;
  late final List<SubData> data;
  
  SubtableModel.fromJson(Map<String, dynamic> json){
    statusCode = json['status_code'];
    requestResult = json['request_result'];
    data = List.from(json['data']).map((e)=>SubData.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status_code'] = statusCode;
    _data['request_result'] = requestResult;
    _data['data'] = data.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class SubData {
  SubData({
    required this.sid,
    required this.dataType,
    required this.id,
    required this.subDataType,
    required this.foodCount,
  });
  late final String sid;
  late final String dataType;
  late final String id;
  late final String subDataType;
  late final int foodCount;
  
  SubData.fromJson(Map<String, dynamic> json){
    sid = json['_id'];
    dataType = json['dataType'];
    id = json['id'];
    subDataType = json['subDataType'];
    foodCount = json['foodCount'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['_id'] = sid;
    _data['dataType'] = dataType;
    _data['id'] = id;
    _data['subDataType'] = subDataType;
    _data['foodCount'] = foodCount;
    return _data;
  }
}

enum SubTableResponseStates{
  SUCCESS,
  FAILURE,
  DUPLICATE,
  IGNORE,
}