import 'package:fittrack/Provider/excerciseprovider.dart';
import 'package:fittrack/Provider/foodprovider.dart';
import 'package:fittrack/Provider/homepageprovider.dart';
import 'package:fittrack/constants/AppPages.dart';
import 'package:fittrack/constants/theme.dart';
import 'package:fittrack/views/Activity/activitysceen.dart';
import 'package:fittrack/views/Activity/countdownscreen.dart';
import 'package:fittrack/views/calculate/bmiscreen.dart';
import 'package:fittrack/views/calculate/bodyfatscreen.dart';
import 'package:fittrack/views/calculate/calculatepage.dart';
import 'package:fittrack/views/calculate/calculatepage.dart';
import 'package:fittrack/views/calculate/dailyactivity.dart';
import 'package:fittrack/views/calculate/dailycalorieburn.dart';
import 'package:fittrack/views/calculate/dailychalorierequirement.dart';
import 'package:fittrack/views/calculate/idealscreen.dart';
import 'package:fittrack/views/Activity/excercisepage.dart';
import 'package:fittrack/views/calculate/macrosscreen.dart';
import 'package:fittrack/views/food/fooddetails.dart';
import 'package:fittrack/views/food/foodpage.dart';
import 'package:fittrack/views/food/infotablepage.dart';
import 'package:fittrack/views/food/subtablepage.dart';
import 'package:fittrack/views/landing/landingscreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => HomePageProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => ActivityProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => FoodProvider(),
        )
      ],
      child: GetMaterialApp(
        title: 'Fit Track',
        debugShowCheckedModeBanner: false,
        initialRoute: AppPages.LandingPage,
        theme: ThemeClass.buildTheme(context),
        getPages: [
          GetPage(
            name: AppPages.LandingPage,
            page: () => const LandingScreen(
              selectedIndex: 0,
            ),
          ),
          GetPage(
            name: AppPages.CalculatePage,
            page: () => const CalculateScreen(),
          ),
          GetPage(
            name: AppPages.WorkoutPage,
            page: () => const ExerciseScreen(),
          ),
          GetPage(
            name: AppPages.FoodPage,
            page: () => const FoodScreen(),
          ),
          GetPage(
            name: AppPages.IdealPage,
            page: () => IdealScreen(),
          ),
          GetPage(
            name: AppPages.BmiPage,
            page: () => const BmiScreen(),
          ),
          GetPage(
            name: AppPages.BodyFat,
            page: () => BodyFatScreen(),
          ),
          GetPage(
            name: AppPages.DailyChalorieRequirement,
            page: () => CaloryRequirement(),
          ),
          GetPage(
            name: AppPages.MacrosPage,
            page: () => MacrosScreen(),
          ),
          GetPage(
            name: AppPages.DailyChalorieBurn,
            page: () => BurnedCalorieScreen(),
          ),
          GetPage(
            name: AppPages.ActivityPage,
            page: () => ActivityScreen(),
          ),
          GetPage(
            name: AppPages.CountdownPage,
            page: () => CountdownScreen(),
          ),
          GetPage(
            name: AppPages.subtablePage,
            page: () => SubtableScreen(),
          ),
          GetPage(
            name: AppPages.InfotablePage,
            page: () => InfoScreen(),
          ),
          GetPage(
            name: AppPages.foodDetalsPage,
            page: () => FoodDetailScreen(),
          ),
          GetPage(
            name: AppPages.ActivityPage2,
            page: () => ActivityScreen2(),
          ),
          
        ],
      ),
    );
  }
}
