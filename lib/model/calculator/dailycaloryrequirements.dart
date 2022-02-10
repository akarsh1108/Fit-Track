class DailyCalorieRequirement {
  DailyCalorieRequirement({
    required this.statusCode,
    required this.requestResult,
    required this.data,
  });
  late final int statusCode;
  late final String requestResult;
  late final CalorieRequirementData data;
  
  DailyCalorieRequirement.fromJson(Map<String, dynamic> json){
    statusCode = json['status_code'];
    requestResult = json['request_result'];
    data = CalorieRequirementData.fromJson(json['data']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status_code'] = statusCode;
    _data['request_result'] = requestResult;
    _data['data'] = data.toJson();
    return _data;
  }
}

class CalorieRequirementData {
  CalorieRequirementData({
    required this.BMR,
    required this.goals,
  });
  late final int BMR;
  late final Goals goals;
  
  CalorieRequirementData.fromJson(Map<String, dynamic> json){
    BMR = json['BMR'];
    goals = Goals.fromJson(json['goals']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['BMR'] = BMR;
    _data['goals'] = goals.toJson();
    return _data;
  }
}

class Goals {
  Goals({
    required this.maintainweight,
    required this.mildweightloss,
    required this.weightloss,
    required this.extremeweightloss,
    required this.mildweightgain,
    required this.weightgain,
    required this.extremeweightgain,
  });
  late final double maintainweight;
  late final Mildweightloss mildweightloss;
  late final Weightloss weightloss;
  late final Extremeweightloss extremeweightloss;
  late final Mildweightgain mildweightgain;
  late final Weightgain weightgain;
  late final Extremeweightgain extremeweightgain;
  
  Goals.fromJson(Map<String, dynamic> json){
    maintainweight = json['maintain weight'];
    mildweightloss = Mildweightloss.fromJson(json['Mild weight loss']);
    weightloss = Weightloss.fromJson(json['Weight loss']);
    extremeweightloss = Extremeweightloss.fromJson(json['Extreme weight loss']);
    mildweightgain = Mildweightgain.fromJson(json['Mild weight gain']);
    weightgain = Weightgain.fromJson(json['Weight gain']);
    extremeweightgain = Extremeweightgain.fromJson(json['Extreme weight gain']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['maintain weight'] = maintainweight;
    _data['Mild weight loss'] = mildweightloss.toJson();
    _data['Weight loss'] = weightloss.toJson();
    _data['Extreme weight loss'] = extremeweightloss.toJson();
    _data['Mild weight gain'] = mildweightgain.toJson();
    _data['Weight gain'] = weightgain.toJson();
    _data['Extreme weight gain'] = extremeweightgain.toJson();
    return _data;
  }
}

class Mildweightloss {
  Mildweightloss({
    required this.lossweight,
    required this.calory,
  });
  late final String lossweight;
  late final double calory;
  
  Mildweightloss.fromJson(Map<String, dynamic> json){
    lossweight = json['loss weight'];
    calory = json['calory'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['loss weight'] = lossweight;
    _data['calory'] = calory;
    return _data;
  }
}

class Weightloss {
  Weightloss({
    required this.lossweight,
    required this.calory,
  });
  late final String lossweight;
  late final double calory;
  
  Weightloss.fromJson(Map<String, dynamic> json){
    lossweight = json['loss weight'];
    calory = json['calory'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['loss weight'] = lossweight;
    _data['calory'] = calory;
    return _data;
  }
}

class Extremeweightloss {
  Extremeweightloss({
    required this.lossweight,
    required this.calory,
  });
  late final String lossweight;
  late final double calory;
  
  Extremeweightloss.fromJson(Map<String, dynamic> json){
    lossweight = json['loss weight'];
    calory = json['calory'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['loss weight'] = lossweight;
    _data['calory'] = calory;
    return _data;
  }
}

class Mildweightgain {
  Mildweightgain({
    required this.gainweight,
    required this.calory,
  });
  late final String gainweight;
  late final double calory;
  
  Mildweightgain.fromJson(Map<String, dynamic> json){
    gainweight = json['gain weight'];
    calory = json['calory'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['gain weight'] = gainweight;
    _data['calory'] = calory;
    return _data;
  }
}

class Weightgain {
  Weightgain({
    required this.gainweight,
    required this.calory,
  });
  late final String gainweight;
  late final double calory;
  
  Weightgain.fromJson(Map<String, dynamic> json){
    gainweight = json['gain weight'];
    calory = json['calory'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['gain weight'] = gainweight;
    _data['calory'] = calory;
    return _data;
  }
}

class Extremeweightgain {
  Extremeweightgain({
    required this.gainweight,
    required this.calory,
  });
  late final String gainweight;
  late final double calory;
  
  Extremeweightgain.fromJson(Map<String, dynamic> json){
    gainweight = json['gain weight'];
    calory = json['calory'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['gain weight'] = gainweight;
    _data['calory'] = calory;
    return _data;
  }
}

enum CalorieRequirementResponseStates{
  SUCCESS,
  FAILURE,
  DUPLICATE,
  IGNORE,
}