import 'dart:convert';

import 'package:fittrack/model/activitymodel.dart';
import 'package:fittrack/model/calculator/bmi_model.dart';
import 'package:fittrack/model/calculator/bodyfatpercentage.dart';
import 'package:fittrack/model/calculator/burnedchalorie.dart';
import 'package:fittrack/model/calculator/dailycaloryrequirements.dart';
import 'package:fittrack/model/calculator/idealweight.dart';
import 'package:fittrack/model/calculator/macrosamounts.dart';
import 'package:fittrack/model/foods/food.dart';
import 'package:fittrack/model/foods/foodinfo.dart';
import 'package:fittrack/model/foods/sub_tablemodel.dart';
import 'package:fittrack/model/foods/tablenames.dart';
import 'package:http/http.dart' as http;

class ApiServices {
  final String baseUrl = "https://fitness-calculator.p.rapidapi.com";

  Future<Data> idealWeight(String? Gender, String? Height) async {
    var url =
        Uri.parse('$baseUrl/idealweight?gender=${Gender}&height=${Height}');
    var response = await http.get(url, headers: <String, String>{
      'x-rapidapi-host': 'fitness-calculator.p.rapidapi.com',
      'x-rapidapi-key': '198ef57dd0msh928fd7edcb84f67p1bfa9ejsn97b8e901f2e7'
    });
    print(response.statusCode);

    var body = response.body;

    Map<String, dynamic> jsonData = jsonDecode(body)["data"];

    print(jsonData);
    Data data = Data.fromJson(jsonData);
    return data;
  }

  Future<BmiData> bmiService(
      String? age, String? weight, String? height) async {
    var url =
        Uri.parse("$baseUrl/bmi?age=${age}&weight=${weight}&height=${height}");
    var response = await http.get(url, headers: <String, String>{
      'x-rapidapi-host': 'fitness-calculator.p.rapidapi.com',
      'x-rapidapi-key': '198ef57dd0msh928fd7edcb84f67p1bfa9ejsn97b8e901f2e7'
    });
    var body = response.body;
    Map<String, dynamic> jsonData = jsonDecode(body)["data"];
    BmiData data = BmiData.fromJson(jsonData);
    return data;
  }

  Future<FatPerData> FatPerService(String? age, String? weight, String? height,
      String? gender, String? neck, String? waist, String? hip) async {
    var url = Uri.parse(
        '$baseUrl/bodyfat?age=${age}&weight=${weight}&height=${height}&gender=${gender}&neck=${neck}&waist=${waist}&hip=${hip}');
    var response = await http.get(url, headers: <String, String>{
      'x-rapidapi-host': 'fitness-calculator.p.rapidapi.com',
      'x-rapidapi-key': '198ef57dd0msh928fd7edcb84f67p1bfa9ejsn97b8e901f2e7'
    });
    var body = response.body;
    Map<String, dynamic> jsonnData = jsonDecode(body)["data"];
    FatPerData data = FatPerData.fromJson(jsonnData);
    return data;
  }

  Future<BurnedData> CalorieBurn(
      String? activity, String? activitymin, String? weight) async {
    var url = Uri.parse(
        '$baseUrl/burnedcalorie?activityid=${activity}&activitymin=${activitymin}&weight=${weight}');
    var response = await http.get(url, headers: <String, String>{
      'x-rapidapi-host': 'fitness-calculator.p.rapidapi.com',
      'x-rapidapi-key': '198ef57dd0msh928fd7edcb84f67p1bfa9ejsn97b8e901f2e7'
    });
    var body = response.body;
    Map<String, dynamic> jsonnData = jsonDecode(body)["data"];
    BurnedData data = BurnedData.fromJson(jsonnData);
    return data;
  }

  Future<MacrosData> MacrosAmount(String? age, String? gender, String? height,
      String? weight, String? activitylevel, String? goal) async {
    var url = Uri.parse(
      '$baseUrl/macrocalculator?age=${age}&gender=${gender}&height=${height}&weight=${weight}&activitylevel=${activitylevel}&goal=${goal}',
    );
    var response = await http.get(url, headers: <String, String>{
      'x-rapidapi-host': 'fitness-calculator.p.rapidapi.com',
      'x-rapidapi-key': '198ef57dd0msh928fd7edcb84f67p1bfa9ejsn97b8e901f2e7'
    });
    var body = response.body;
    Map<String, dynamic> jsonnData = jsonDecode(body)["data"];
    MacrosData data = MacrosData.fromJson(jsonnData);
    return data;
  }

  Future<CalorieRequirementData> Calorierequirement(String? age, String? gender,
      String? height, String? weight, String? activitylevel) async {
    var url = Uri.parse(
        "$baseUrl/dailycalorie?age=${age}&gender=${gender}&height=${height}&weight=${weight}&activitylevel=level_${activitylevel}");

    var response = await http.get(url, headers: <String, String>{
      'x-rapidapi-host': 'fitness-calculator.p.rapidapi.com',
      'x-rapidapi-key': '198ef57dd0msh928fd7edcb84f67p1bfa9ejsn97b8e901f2e7'
    });
    var body = response.body;
    Map<String, dynamic> jsonnData = jsonDecode(body)["data"];
    CalorieRequirementData data = CalorieRequirementData.fromJson(jsonnData);
    return data;
  }

  static Future<List<ActivityData>> activities(
      String intensitylevel, String query) async {
    var url = Uri.parse(
        "https://fitness-calculator.p.rapidapi.com/activities?intensitylevel=${intensitylevel}");
    var response = await http.get(url, headers: <String, String>{
      'x-rapidapi-host': 'fitness-calculator.p.rapidapi.com',
      'x-rapidapi-key': '198ef57dd0msh928fd7edcb84f67p1bfa9ejsn97b8e901f2e7'
    });

    var body = response.body;
    List jsonData = jsonDecode(body)["data"] as List;
    List<ActivityData> activitylist = [];
    activitylist = jsonData.map((e) {
      return ActivityData.fromJson(e);
    }).where((activity1) {
      final description = activity1.description.toLowerCase();
      final act = activity1.activity.toLowerCase();
      final seachLower = query.toLowerCase();
      return description.contains(seachLower) || act.contains(seachLower);
    }).toList();
    return activitylist;
  }

  Future<List> tableList() async {
    var url = Uri.parse('${baseUrl}/foodids/tablenames');
    var response = await http.get(url, headers: <String, String>{
      'x-rapidapi-host': 'fitness-calculator.p.rapidapi.com',
      'x-rapidapi-key': '198ef57dd0msh928fd7edcb84f67p1bfa9ejsn97b8e901f2e7'
    });
    var body = response.body;
    List jsonData = jsonDecode(body)['table_names'];
    print(jsonData);
    List tablelist = jsonData;
    return tablelist;
  }

  Future<List<SubData>> getSubtableData(String text) async {
    var url = Uri.parse("$baseUrl/foodids/subtablenames?tablename=${text}");
    var response = await http.get(url, headers: <String, String>{
      'x-rapidapi-host': 'fitness-calculator.p.rapidapi.com',
      'x-rapidapi-key': '198ef57dd0msh928fd7edcb84f67p1bfa9ejsn97b8e901f2e7'
    });
    var body = response.body;
    var jsonData = jsonDecode(body)['data'] as List;
    List<SubData> subTableList = jsonData.map((e) {
      return SubData.fromJson(e);
    }).toList();

    return subTableList;
  }

  static Future<List<InfoData>> infotableData(String text, String query) async {
    var url = Uri.parse(
        "https://fitness-calculator.p.rapidapi.com/foodids?subtablename=${text}");
    var response = await http.get(url, headers: <String, String>{
      'x-rapidapi-host': 'fitness-calculator.p.rapidapi.com',
      'x-rapidapi-key': '198ef57dd0msh928fd7edcb84f67p1bfa9ejsn97b8e901f2e7'
    });
    var body = response.body;
    var jsonData = jsonDecode(body)['data'] as List;
    List<InfoData> infoTableList = jsonData.map((e) {
      return InfoData.fromJson(e);
    }).where((activity) {
      final description = activity.foodType.toLowerCase();
      final act = activity.subDataType.toLowerCase();
      final seachLower = query.toLowerCase();
      return description.contains(seachLower) || act.contains(seachLower);
    }).toList();

    return infoTableList;
  }

  Future foodDetails(String? id) async {
    var url = Uri.parse(
        "https://fitness-calculator.p.rapidapi.com/food/?foodid=${id}");
    var response = await http.get(url, headers: <String, String>{
      'x-rapidapi-host': 'fitness-calculator.p.rapidapi.com',
      'x-rapidapi-key': '198ef57dd0msh928fd7edcb84f67p1bfa9ejsn97b8e901f2e7'
    });
    var body = response.body;

    Map<String, dynamic> jsonData = jsonDecode(body)['data'];

    return jsonData;
  }

  Future<FoodData1> fooddetails(String? id) async {
    var url = Uri.parse(
        "https://fitness-calculator.p.rapidapi.com/food/?foodid=${id}");
    var response = await http.get(url, headers: <String, String>{
      'x-rapidapi-host': 'fitness-calculator.p.rapidapi.com',
      'x-rapidapi-key': '198ef57dd0msh928fd7edcb84f67p1bfa9ejsn97b8e901f2e7'
    });
    var body = response.body;
    Map<String, dynamic> jsonData = jsonDecode(body)['data'];
    FoodData1 foodTableList = FoodData1.fromJson(jsonData);
    print(foodTableList);
    return foodTableList;
  }
}
