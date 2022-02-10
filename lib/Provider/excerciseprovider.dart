import 'package:fittrack/model/activitymodel.dart';
import 'package:fittrack/services/apiservices.dart';
import 'package:flutter/material.dart';

class ActivityProvider with ChangeNotifier {
  bool _isLoading = true;
  bool get isLoading => _isLoading;
  List<ActivityData> droplist = [];
  List<ActivityData> activitiesModelList = [];
  List<ActivityData> get ActivityModelList => activitiesModelList;
  
  final ApiServices _apiServices = ApiServices();
  void get() {
    notifyListeners();
  }

  Future<List<ActivityData>> getactivities(
      String intensitylevel, String query) async {
    activitiesModelList.clear();
    _isLoading = true;
    List<ActivityData> model =
        await ApiServices.activities(intensitylevel, query);
    activitiesModelList = model;
    
    print(activitiesModelList[0].description);
    _isLoading = false;
    notifyListeners();
    return activitiesModelList;
  }

  

  
}
