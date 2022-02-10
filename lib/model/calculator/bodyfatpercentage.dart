class BodyfatModel {
  BodyfatModel({
    required this.statusCode,
    required this.requestResult,
    required this.data,
  });
  late final int statusCode;
  late final String requestResult;
  late final FatPerData data;
  
  BodyfatModel.fromJson(Map<String, dynamic> json){
    statusCode = json['status_code'];
    requestResult = json['request_result'];
    data = FatPerData.fromJson(json['data']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status_code'] = statusCode;
    _data['request_result'] = requestResult;
    _data['data'] = data.toJson();
    return _data;
  }
}

class FatPerData {
  FatPerData({
    required this.bodyfatUs,
    required this.bodyfatCategory,
    required this.bodyfatMass,
    required this.leanbodymass,
    required this.bodyfatmethod,
  });
  late final double bodyfatUs;
  late final String bodyfatCategory;
  late final double bodyfatMass;
  late final double leanbodymass;
  late final double bodyfatmethod;
  
  FatPerData.fromJson(Map<String, dynamic> json){
    bodyfatUs = json['Body Fat (U.S. Navy Method)'];
    bodyfatCategory = json['Body Fat Category'];
    bodyfatMass = json['Body Fat Mass'];
    leanbodymass = json['Lean Body Mass'];
    bodyfatmethod = json['Body Fat (BMI method)'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['Body Fat (U.S. Navy Method)'] = bodyfatUs;
    _data['Body Fat Category'] = bodyfatCategory ;
    _data['Body Fat Mass'] = bodyfatMass;
    _data['Lean Body Mass'] = leanbodymass;
    _data['Body Fat (BMI method)'] = bodyfatmethod;
    return _data;
  }
}

enum BodyFatResponseStates{
  SUCCESS,
  FAILURE,
  DUPLICATE,
  IGNORE,
}