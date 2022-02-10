
import 'package:fittrack/views/Activity/excercisepage.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:fittrack/views/calculate/calculatepage.dart';
import 'package:fittrack/views/food/foodpage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
class LandingScreen extends StatefulWidget {
  final int selectedIndex;
  
  const LandingScreen({required this.selectedIndex});

  @override
  _LandingScreenState createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  int _selectedIndex = 0;
  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.selectedIndex;
    
  }

  static final List<Widget> _widgetOptions = <Widget>[
    const CalculateScreen(),
    const ExerciseScreen(),
    const FoodScreen(),
  ];

  void onItemTapped(int index) {
    setState(() {

      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _widgetOptions.elementAt(_selectedIndex),
        backgroundColor: Colors.blue.shade700,
        bottomNavigationBar: BottomNavyBar(
          backgroundColor: Color(0xFF1FB5E4),
          selectedIndex: _selectedIndex,
          onItemSelected: (index) => onItemTapped(index),
          items: <BottomNavyBarItem>[
            BottomNavyBarItem(
              inactiveColor: Colors.white,
              activeColor: Colors.white,
                icon: Icon(Icons.add_chart),
                title: Text('Calculate', textAlign: TextAlign.center)),
            BottomNavyBarItem(
              inactiveColor: Colors.white,
               activeColor: Colors.white,
                icon: Icon(Icons.fitness_center),
                title: Text('Activities', textAlign: TextAlign.center)),
            BottomNavyBarItem(
              inactiveColor: Colors.white,
               activeColor: Colors.white,
                icon: Icon(Icons.food_bank_outlined),
                title: Text('Food', textAlign: TextAlign.center)),
          ],
        ));
  }
}


