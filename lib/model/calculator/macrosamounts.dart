class MacrosAmountModel {
  MacrosAmountModel({
    required this.statusCode,
    required this.requestResult,
    required this.data,
  });
  late final int statusCode;
  late final String requestResult;
  late final MacrosData data;

  MacrosAmountModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    requestResult = json['request_result'];
    data = MacrosData.fromJson(json['data']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status_code'] = statusCode;
    _data['request_result'] = requestResult;
    _data['data'] = data.toJson();
    return _data;
  }
}

class MacrosData {
  MacrosData({
    required this.calorie,
    required this.balanced,
    required this.lowfat,
    required this.lowcarbs,
    required this.highprotein,
  });
  late final double calorie;
  late final Balanced balanced;
  late final Lowfat lowfat;
  late final Lowcarbs lowcarbs;
  late final Highprotein highprotein;

  MacrosData.fromJson(Map<String, dynamic> json) {
    calorie = json['calorie'];
    balanced = Balanced.fromJson(json['balanced']);
    lowfat = Lowfat.fromJson(json['lowfat']);
    lowcarbs = Lowcarbs.fromJson(json['lowcarbs']);
    highprotein = Highprotein.fromJson(json['highprotein']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['calorie'] = calorie;
    _data['balanced'] = balanced.toJson();
    _data['lowfat'] = lowfat.toJson();
    _data['lowcarbs'] = lowcarbs.toJson();
    _data['highprotein'] = highprotein.toJson();
    return _data;
  }
}

class Balanced {
  Balanced({
    required this.protein,
    required this.fat,
    required this.carbs,
  });
  late final double protein;
  late final double fat;
  late final double carbs;

  Balanced.fromJson(Map<String, dynamic> json) {
    protein = json['protein'];
    fat = json['fat'];
    carbs = json['carbs'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['protein'] = protein;
    _data['fat'] = fat;
    _data['carbs'] = carbs;
    return _data;
  }
}

class Lowfat {
  Lowfat({
    required this.protein,
    required this.fat,
    required this.carbs,
  });
  late final double protein;
  late final double fat;
  late final double carbs;

  Lowfat.fromJson(Map<String, dynamic> json) {
    protein = json['protein'];
    fat = json['fat'];
    carbs = json['carbs'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['protein'] = protein;
    _data['fat'] = fat;
    _data['carbs'] = carbs;
    return _data;
  }
}

class Lowcarbs {
  Lowcarbs({
    required this.protein,
    required this.fat,
    required this.carbs,
  });
  late final double protein;
  late final double fat;
  late final double carbs;

  Lowcarbs.fromJson(Map<String, dynamic> json) {
    protein = json['protein'];
    fat = json['fat'];
    carbs = json['carbs'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['protein'] = protein;
    _data['fat'] = fat;
    _data['carbs'] = carbs;
    return _data;
  }
}

class Highprotein {
  Highprotein({
    required this.protein,
    required this.fat,
    required this.carbs,
  });
  late final double protein;
  late final double fat;
  late final double carbs;

  Highprotein.fromJson(Map<String, dynamic> json) {
    protein = json['protein'];
    fat = json['fat'];
    carbs = json['carbs'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['protein'] = protein;
    _data['fat'] = fat;
    _data['carbs'] = carbs;
    return _data;
  }
}

enum MacrosAmountResponseStates{
  SUCCESS,
  FAILURE,
  DUPLICATE,
  IGNORE,
}