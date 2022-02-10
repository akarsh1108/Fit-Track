import 'package:fittrack/model/activitymodel.dart';
import 'package:fittrack/model/calculator/bmi_model.dart';
import 'package:fittrack/model/calculator/bodyfatpercentage.dart';
import 'package:fittrack/model/calculator/burnedchalorie.dart';
import 'package:fittrack/model/calculator/dailycaloryrequirements.dart';
import 'package:fittrack/model/calculator/idealweight.dart';
import 'package:fittrack/model/calculator/macrosamounts.dart';
import 'package:fittrack/services/apiservices.dart';
import 'package:flutter/widgets.dart';

class HomePageProvider with ChangeNotifier {
  bool _isLoading = true;
  bool get isLoading => _isLoading;
  String _gender = "";
  String _height = "";
  String get gender => _gender;
  String get height => _height;
  List<ActivityData> activitiesList = [];
  List<ActivityData> get ActivityList => activitiesList;
  List<Map<String, String>> _activities = [];
  List<Map<String, String>> get activityList2 => _activityList;
  List<Map<String, String>> _activityList = [];

  final ApiServices _apiServices = ApiServices();
  void get() {
    notifyListeners();
  }

  Future<Data> idealweight(String? Gender, String? Height) async {
    Data data;
    data = await _apiServices.idealWeight(Gender, Height);

    print(data.Hamwi);
    _isLoading = false;
    notifyListeners();
    return data;
  }

  Future<BmiData> bmiweight(String? age, String? weight, String? height) async {
    BmiData data;
    data = await _apiServices.bmiService(age, weight, height);
    _isLoading = false;
    notifyListeners();
    return data;
  }

  Future<FatPerData> fatPerData(String? age, String? weight, String? height,
      String? gender, String? neck, String? waist, String? hip) async {
    FatPerData data;
    data = await _apiServices.FatPerService(
        age, weight, height, gender, neck, waist, hip);
    _isLoading = false;
    notifyListeners();
    return data;
  }

  Future<BurnedData> burnedData(
      String? activity, String? activitymin, String? weight) async {
    BurnedData data;
    data = await _apiServices.CalorieBurn(activity, activitymin, weight);
    _isLoading = false;
    notifyListeners();
    return data;
  }

  Future<MacrosData> macrosdata(String? age, String? gender, String? height,
      String? weight, String? activitylevel, String? goal) async {
    MacrosData data;
    data = await _apiServices.MacrosAmount(
        age, gender, height, weight, activitylevel, goal);
    _isLoading = false;
    notifyListeners();
    return data;
  }

  Future<CalorieRequirementData> calorieRequirementData(
      String? age,
      String? gender,
      String? height,
      String? weight,
      String? activitylevel) async {
    CalorieRequirementData data;
    data = await _apiServices.Calorierequirement(
        age, gender, height, weight, activitylevel);
    _isLoading = false;
    notifyListeners();
    return data;
  }

  Future<List<ActivityData>> getactivities(
      String intensitylevel, String query) async {
    activitiesList.clear();
    _isLoading = true;
    getallactivities();
    List<ActivityData> model =
        await ApiServices.activities(intensitylevel, query);
    activitiesList = model;

    print(activitiesList[0].description);
    _isLoading = false;
    notifyListeners();
    return activitiesList;
  }

  void getallactivities() {
    List<String> activitydescription = [];
    List<String> activityid = [];
    _activityList.clear();
    for (var act in activitiesList) {
      String? name = act.description;
      String? id = act.id;
      activitydescription.add(name);
      activityid.add(id);
    }
    var description = activitydescription.toSet().toList();
    var idno = activityid.toSet().toList();
    for (int i = 0; i < description.length; i++) {
      _activityList.add({
        "description":description[i].toString(),
        "id":idno[i].toString(),
      });
    }
    notifyListeners();
  }
}
