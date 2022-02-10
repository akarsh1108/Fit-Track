import 'dart:convert';

import 'package:fittrack/model/foods/food.dart';
import 'package:fittrack/model/foods/foodinfo.dart';
import 'package:fittrack/model/foods/sub_tablemodel.dart';
import 'package:fittrack/model/foods/tablenames.dart';
import 'package:fittrack/services/apiservices.dart';
import 'package:flutter/material.dart';

class FoodProvider with ChangeNotifier {
  bool _isLoading = true;
  bool get isLoading => _isLoading;
  List tableModelList = [];
  List get TableModelList => tableModelList;

  List<SubData> subtableList = [];
  List<SubData> get subTableList => subtableList;

  List<InfoData> infotableList = [];
  List<InfoData> get InfoList => infotableList;
  var foodInfoData = {};
  get foodinfoData => foodInfoData;
  FoodData1? foodInfoData1;
  FoodData1? get FoodInfoData1 => foodInfoData1;
  final ApiServices _apiServices = ApiServices();
  void get() {
    notifyListeners();
  }

  Future<List> tablelist() async {
    tableModelList.clear();
    _isLoading = true;
    List model = await _apiServices.tableList();
    tableModelList = model;
    _isLoading = false;
    notifyListeners();
    return tableModelList;
  }

  void subtable(String id) async {
    subtableList.clear();
    _isLoading = true;
    List<SubData> model = await _apiServices.getSubtableData(id);
    subtableList = model;
    _isLoading = false;
    notifyListeners();
  }

  Future<List<InfoData>> infotable(String id, String query) async {
    infotableList.clear();
    _isLoading = true;

    List<InfoData> model = await ApiServices.infotableData(id, query);
    infotableList = model;
    _isLoading = false;
    notifyListeners();
    return infotableList;
  }

  Future foodinfo(String id) async {
    foodInfoData.clear();
    _isLoading = true;

    var data = await _apiServices.foodDetails(id);
    print(data);
    foodInfoData = data;
    _isLoading = false;
    notifyListeners();
    return data;
  }

  void foodinfo1(String id) async {
    _isLoading = true;
    FoodData1 data = await _apiServices.fooddetails(id);
    print(data);
    foodInfoData1 = data;
    _isLoading = false;
    notifyListeners();
  }
}
