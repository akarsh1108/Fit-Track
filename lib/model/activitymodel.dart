class ActivitiesModel {
  ActivitiesModel({
    required this.statusCode,
    required this.requestResult,
    required this.data,
  });
  late final int statusCode;
  late final String requestResult;
  late final List<ActivityData> data;
  
  ActivitiesModel.fromJson(Map<String, dynamic> json){
    statusCode = json['status_code'];
    requestResult = json['request_result'];
    data = List.from(json['data']).map((e)=>ActivityData.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status_code'] = statusCode;
    _data['request_result'] = requestResult;
    _data['data'] = data.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class ActivityData {
  ActivityData({
    required this.sid,
    required this.id,
    required this.activity,
    required this.metValue,
    required this.description,
    required this.intensityLevel,
  });
  late final String sid;
  late final String id;
  late final String activity;
  late final String metValue;
  late final String description;
  late final int intensityLevel;
  
  ActivityData.fromJson(Map<String, dynamic> json){
    sid = json['_id'];
    id = json['id'];
    activity = json['activity'];
    metValue = json['metValue'];
    description = json['description'];
    intensityLevel = json['intensityLevel'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['_id'] = sid;
    _data['id'] = id;
    _data['activity'] = activity;
    _data['metValue'] = metValue;
    _data['description'] = description;
    _data['intensityLevel'] = intensityLevel;
    return _data;
  }
}


enum ActivityResponseStates{
  SUCCESS,
  FAILURE,
  DUPLICATE,
  IGNORE,
}