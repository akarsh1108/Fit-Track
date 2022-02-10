class IdealWeight {
  IdealWeight({
    required this.statusCode,
    required this.requestResult,
    required this.data,
  });
  late final int statusCode;
  late final String requestResult;
  late final Data data;
  
  IdealWeight.fromJson(Map<String, dynamic> json){
    statusCode = json['status_code'];
    requestResult = json['request_result'];
    data = Data.fromJson(json['data']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status_code'] = statusCode;
    _data['request_result'] = requestResult;
    _data['data'] = data.toJson();
    return _data;
  }
}

class Data {
  Data({
    required this.Hamwi,
    required this.Devine,
    required this.Miller,
    required this.Robinson,
  });
  late final double Hamwi;
  late final double Devine;
  late final double Miller;
  late final double Robinson;
  
  Data.fromJson(Map<String, dynamic> json){
    Hamwi = json['Hamwi'];
    Devine = json['Devine'];
    Miller = json['Miller'];
    Robinson = json['Robinson'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['Hamwi'] = Hamwi;
    _data['Devine'] = Devine;
    _data['Miller'] = Miller;
    _data['Robinson'] = Robinson;
    return _data;
  }
}

enum IdealResponseStates{
  SUCCESS,
  FAILURE,
  DUPLICATE,
  IGNORE,
}