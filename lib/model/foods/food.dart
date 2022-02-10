class AutoGenerate {
  AutoGenerate({
    required this.statusCode,
    required this.requestResult,
    required this.data,
  });
  late final int statusCode;
  late final String requestResult;
  late final FoodData1 data;
  
  AutoGenerate.fromJson(Map<String, dynamic> json){
    statusCode = json['status_code'];
    requestResult = json['request_result'];
    data = FoodData1.fromJson(json['data']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status_code'] = statusCode;
    _data['request_result'] = requestResult;
    _data['data'] = data.toJson();
    return _data;
  }
}

class FoodData1 {
  FoodData1({
    required this.foodid,
    required this.description,
    required this.portion,
    required this.portionUnit,
    required this.foodNutrients,
  });
  late final String foodid;
  late final String description;
  late final double portion;
  late final String portionUnit;
  late final FoodNutrients foodNutrients;
  
  FoodData1.fromJson(Map<String, dynamic> json){
    foodid = json['foodid'];
    description = json['description'];
    portion = json['portion'];
    portionUnit = json['portionUnit'];
    foodNutrients = FoodNutrients.fromJson(json['foodNutrients']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['foodid'] = foodid;
    _data['description'] = description;
    _data['portion'] = portion;
    _data['portionUnit'] = portionUnit;
    _data['foodNutrients'] = foodNutrients.toJson();
    return _data;
  }
}

class FoodNutrients {
  FoodNutrients({
    required this.protein,
    required this.fat,
    required this.carbonhydrate,
    required this.energy,
    required this.water,
  });
  late final Protein protein;
  late final Fat fat;
  late final Carbonhydrate carbonhydrate;
  late final Energy energy;
  late final Water water;
  
  FoodNutrients.fromJson(Map<String, dynamic> json){
    protein = Protein.fromJson(json['Protein']);
    fat = Fat.fromJson(json['Fat']);
    carbonhydrate = Carbonhydrate.fromJson(json['Carbonhydrate']);
    energy = Energy.fromJson(json['Energy']);
    water = Water.fromJson(json['Water']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['Protein'] = protein.toJson();
    _data['Fat'] = fat.toJson();
    _data['Carbonhydrate'] = carbonhydrate.toJson();
    _data['Energy'] = energy.toJson();
    _data['Water'] = water.toJson();
    return _data;
  }
}

class Protein {
  Protein({
    required this.unitname,
    required this.value,
  });
  late final String unitname;
  late final double value;
  
  Protein.fromJson(Map<String, dynamic> json){
    unitname = json['unitname'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['unitname'] = unitname;
    _data['value'] = value;
    return _data;
  }
}

class Fat {
  Fat({
    required this.fattyacidstotalsaturated,
    required this.totallipidfat,
    required this.fattyacidstotalmonounsaturated,
    required this.fattyacidstotalpolyunsaturated,
  });
  late final Fattyacidstotalsaturated fattyacidstotalsaturated;
  late final Totallipidfat totallipidfat;
  late final Fattyacidstotalmonounsaturated fattyacidstotalmonounsaturated;
  late final Fattyacidstotalpolyunsaturated fattyacidstotalpolyunsaturated;
  
  Fat.fromJson(Map<String, dynamic> json){
    fattyacidstotalsaturated = Fattyacidstotalsaturated.fromJson(json['Fatty acids, total saturated']);
    totallipidfat = Totallipidfat.fromJson(json['Total lipid (fat)']);
    fattyacidstotalmonounsaturated = Fattyacidstotalmonounsaturated.fromJson(json['Fatty acids, total monounsaturated']);
    fattyacidstotalpolyunsaturated = Fattyacidstotalpolyunsaturated.fromJson(json['Fatty acids, total polyunsaturated']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['Fatty acids, total saturated'] = fattyacidstotalsaturated.toJson();
    _data['Total lipid (fat)'] = totallipidfat.toJson();
    _data['Fatty acids, total monounsaturated'] = fattyacidstotalmonounsaturated.toJson();
    _data['Fatty acids, total polyunsaturated'] = fattyacidstotalpolyunsaturated.toJson();
    return _data;
  }
}

class Fattyacidstotalsaturated {
  Fattyacidstotalsaturated({
    required this.unitname,
    required this.value,
  });
  late final String unitname;
  late final double value;
  
  Fattyacidstotalsaturated.fromJson(Map<String, dynamic> json){
    unitname = json['unitname'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['unitname'] = unitname;
    _data['value'] = value;
    return _data;
  }
}

class Totallipidfat {
  Totallipidfat({
    required this.unitname,
    required this.value,
  });
  late final String unitname;
  late final double value;
  
  Totallipidfat.fromJson(Map<String, dynamic> json){
    unitname = json['unitname'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['unitname'] = unitname;
    _data['value'] = value;
    return _data;
  }
}

class Fattyacidstotalmonounsaturated {
  Fattyacidstotalmonounsaturated({
    required this.unitname,
    required this.value,
  });
  late final String unitname;
  late final double value;
  
  Fattyacidstotalmonounsaturated.fromJson(Map<String, dynamic> json){
    unitname = json['unitname'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['unitname'] = unitname;
    _data['value'] = value;
    return _data;
  }
}

class Fattyacidstotalpolyunsaturated {
  Fattyacidstotalpolyunsaturated({
    required this.unitname,
    required this.value,
  });
  late final String unitname;
  late final double value;
  
  Fattyacidstotalpolyunsaturated.fromJson(Map<String, dynamic> json){
    unitname = json['unitname'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['unitname'] = unitname;
    _data['value'] = value;
    return _data;
  }
}

class Carbonhydrate {
  Carbonhydrate({
    required this.unitname,
    required this.value,
  });
  late final String unitname;
  late final double value;
  
  Carbonhydrate.fromJson(Map<String, dynamic> json){
    unitname = json['unitname'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['unitname'] = unitname;
    _data['value'] = value;
    return _data;
  }
}

class Energy {
  Energy({
    required this.unitname,
    required this.value,
  });
  late final String unitname;
  late final int value;
  
  Energy.fromJson(Map<String, dynamic> json){
    unitname = json['unitname'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['unitname'] = unitname;
    _data['value'] = value;
    return _data;
  }
}

class Water {
  Water({
    required this.unitname,
    required this.value,
  });
  late final String unitname;
  late final double value;
  
  Water.fromJson(Map<String, dynamic> json){
    unitname = json['unitname'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['unitname'] = unitname;
    _data['value'] = value;
    return _data;
  }
}