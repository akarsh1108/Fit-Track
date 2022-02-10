import 'package:fittrack/Provider/homepageprovider.dart';
import 'package:fittrack/constants/AppPages.dart';
import 'package:fittrack/model/activitymodel.dart';
import 'package:fittrack/model/calculator/burnedchalorie.dart';
import 'package:fittrack/model/calculator/idealweight.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:fittrack/services/apiservices.dart';

class BurnedCalorieScreen extends StatefulWidget {
  @override
  _BurnedCalorieScreenState createState() => _BurnedCalorieScreenState();
}

class _BurnedCalorieScreenState extends State<BurnedCalorieScreen> {
  var d = Get.arguments;
  String act = '';
  double wt = 100;
  int min = 150;
  int seconds = 30;
  double? sec;
  late BurnedData data;
  List<String> intensity = ['1', '2', '3', '4', '5', '6', '7', '8', '9'];
  String _selectedintensity ='1';
  List<ActivityData> activityModelList = [];
  _BurnedCalorieScreenState() {
    act = d[0]['details'];
    _selectedintensity = d[0]['intensity'];
  }
   late BannerAd _bannerAd;
  bool _isAdLoaded = false;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((duration) {
      Provider.of<HomePageProvider>(context, listen: false).get();
    });
    this.data = BurnedData(burnedCalorie: "0", unit: "0");
  _initBannerAd();
  }

  Future init() async {
    activityModelList =
        await ApiServices.activities('${_selectedintensity}', '');
    setState(() => this.activityModelList = activityModelList);
  }
    _initBannerAd() {
    _bannerAd = BannerAd(
        size: AdSize.banner,
        adUnitId: BannerAd.testAdUnitId,
        listener: BannerAdListener(
          onAdLoaded: (ad) {
            setState(() {
              _isAdLoaded = true;
            });
          },
          onAdFailedToLoad: (ad, error) {},
        ),
        request: AdRequest());
    _bannerAd.load();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _isAdLoaded?Container(height: _bannerAd.size.height.toDouble(),width: _bannerAd.size.width.toDouble(),child: AdWidget(ad:_bannerAd,)):SizedBox(),
      backgroundColor: Color(0xFF1FB5E4),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.toNamed(AppPages.LandingPage, arguments: {0});
          },
          icon: const Icon(Icons.arrow_back_ios),
          color: Colors.white,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: Text(
          'Calculate',
          style: Theme.of(context).primaryTextTheme.headline3,
        ),
        centerTitle: true,
      ),
      body: Consumer<HomePageProvider>(builder: (context, HomePageProvider, _) {
        return ListView(
          children: [
            Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height -
                      MediaQuery.of(context).size.height / 2,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.transparent,
                ),
                Positioned(
                  top: 100.0,
                  child: Container(
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(45.0),
                          topRight: Radius.circular(45.0),
                        ),
                        color: Colors.white),
                    height: MediaQuery.of(context).size.height - 280.0,
                    width: MediaQuery.of(context).size.width,
                  ),
                ),
                Positioned(
                    top: 20,
                    left: (MediaQuery.of(context).size.width / 2) - 100.0,
                    child: Hero(
                      tag: "assets/calburn.png",
                      child: Container(
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                            image: DecorationImage(
                                image: AssetImage("assets/calburn.png"),
                                fit: BoxFit.fitWidth)),
                        height: 200.0,
                        width: 200.0,
                      ),
                    )),
                Positioned(
                  top: 230,
                  left: 25,
                  right: 25,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                          child: Text(
                        'Calorie Burn',
                        style: Theme.of(context)
                            .primaryTextTheme
                            .headline2!
                            .copyWith(
                              fontSize: 22,
                            ),
                      )),
                      Center(
                        child: Text.rich(TextSpan(
                            text:
                                'The amount of calories you need each day is unique to your body, lifestyle habits, and health goals.',
                            style: Theme.of(context)
                                .primaryTextTheme
                                .subtitle1!
                                .copyWith(
                                    fontSize: 14,
                                    color: Color(0xFF006484),
                                    fontWeight: FontWeight.normal))),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Container(
              color: Colors.white,
              child: Column(
                children: [
                  DropdownButton(
                      hint: Text(
                          'Please choose an Intensity'), // Not necessary for Option 1
                      value: _selectedintensity,
                      onChanged: (String? newValue) {
                        setState(() async {
                          _selectedintensity = newValue!;
                          activityModelList = await ApiServices.activities(
                              '${_selectedintensity}', '');
                          setState(
                              () => this.activityModelList = activityModelList);
                        });
                      },
                      items: intensity.map((location) {
                        return DropdownMenuItem(
                          child: Text(
                            'Intensity Level ${location}',
                            style: Theme.of(context)
                                .primaryTextTheme
                                .headline6!
                                .copyWith(
                                    color: Color(0xFF1FB5E4),
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                          ),
                          value: location,
                        );
                      }).toList()),
                  const SizedBox(
                    height: 5,
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        Get.toNamed(AppPages.ActivityPage2, arguments: [
                          {"intensity": '${_selectedintensity}'}
                        ]);
                      },
                      child: Text('Select Activity'),
                      style: ElevatedButton.styleFrom(
                          primary: const Color(0xFF1FB5E4))),
                  const SizedBox(
                    height: 5,
                  ),
                 (act!="")? Column(
                   children: [
                     Center(child: Text('Details', style: Theme.of(context)
                              .primaryTextTheme
                              .headline5!
                              .copyWith(color: Color(0xFF028AB5)))),
                     Padding(
                       padding: const EdgeInsets.symmetric(horizontal:18,vertical: 10),
                       child: Center(
                         child: Container(
                           decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: const Color(0xFF1FB5E4)),
                          ),
                           child: Padding(
                             padding: const EdgeInsets.all(8.0),
                             child: Text.rich(TextSpan(
                                        text:
                                            '${act}',
                                        style: Theme.of(context)
                                            .primaryTextTheme
                                            .subtitle1!
                                            .copyWith(
                                                fontSize: 14,
                                                color: Color(0xFF006484),
                                                fontWeight: FontWeight.normal))),
                           ),
                         ),
                       ),
                     ),
                   ],
                 ):SizedBox(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Text("Minutes : ",
                          style: Theme.of(context)
                              .primaryTextTheme
                              .headline5!
                              .copyWith(color: Color(0xFF028AB5))),
                      Text(
                        min.toString(),
                        style: Theme.of(context)
                            .primaryTextTheme
                            .subtitle1!
                            .copyWith(
                                fontSize: 14,
                                color: const Color(0xFF006484),
                                fontWeight: FontWeight.normal),
                      ),
                      Text(
                        'minutes',
                        style: Theme.of(context)
                            .primaryTextTheme
                            .subtitle1!
                            .copyWith(
                                fontSize: 14,
                                color: const Color(0xFF006484),
                                fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                  SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        activeTrackColor: Color(0XFF94E0F8),
                        thumbColor: Color(0xFF1FB5E4),
                        overlayColor: Color(0x291FB5E4),
                        thumbShape:
                            RoundSliderThumbShape(enabledThumbRadius: 12.0),
                        overlayShape:
                            RoundSliderOverlayShape(overlayRadius: 24.0),
                      ),
                      child: Slider(
                          value: min.toDouble(),
                          min: 0,
                          max: 300,
                          inactiveColor: Color(0xFF8D8E98),
                          onChanged: (double value) {
                            setState(() {
                              min = value.round();
                            });
                          })),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Text("Second : ",
                          style: Theme.of(context)
                              .primaryTextTheme
                              .headline5!
                              .copyWith(color: Color(0xFF028AB5))),
                      Text(
                        seconds.toString(),
                        style: Theme.of(context)
                            .primaryTextTheme
                            .subtitle1!
                            .copyWith(
                                fontSize: 14,
                                color: Color(0xFF006484),
                                fontWeight: FontWeight.normal),
                      ),
                      Text(
                        'seconds',
                        style: Theme.of(context)
                            .primaryTextTheme
                            .subtitle1!
                            .copyWith(
                                fontSize: 14,
                                color: Color(0xFF006484),
                                fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                  SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        activeTrackColor: Color(0XFF94E0F8),
                        thumbColor: Color(0xFF1FB5E4),
                        overlayColor: Color(0x291FB5E4),
                        thumbShape:
                            RoundSliderThumbShape(enabledThumbRadius: 12.0),
                        overlayShape:
                            RoundSliderOverlayShape(overlayRadius: 24.0),
                      ),
                      child: Slider(
                          value: seconds.toDouble(),
                          min: 0,
                          max: 59,
                          inactiveColor: Color(0xFF8D8E98),
                          onChanged: (double value) {
                            setState(() {
                              seconds = value.round();
                            });
                          })),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Text("Weight : ",
                          style: Theme.of(context)
                              .primaryTextTheme
                              .headline5!
                              .copyWith(color: Color(0xFF028AB5))),
                      Text(
                        wt.toStringAsFixed(2),
                        style: Theme.of(context)
                            .primaryTextTheme
                            .subtitle1!
                            .copyWith(
                                fontSize: 14,
                                color: Color(0xFF006484),
                                fontWeight: FontWeight.normal),
                      ),
                      Text(
                        'kg',
                        style: Theme.of(context)
                            .primaryTextTheme
                            .subtitle1!
                            .copyWith(
                                fontSize: 14,
                                color: Color(0xFF006484),
                                fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                  SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        activeTrackColor: Color(0XFF94E0F8),
                        thumbColor: Color(0xFF1FB5E4),
                        overlayColor: Color(0x291FB5E4),
                        thumbShape:
                            RoundSliderThumbShape(enabledThumbRadius: 12.0),
                        overlayShape:
                            RoundSliderOverlayShape(overlayRadius: 24.0),
                      ),
                      child: Slider(
                          value: wt.toDouble(),
                          min: 40,
                          max: 160,
                          inactiveColor: Color(0xFF8D8E98),
                          onChanged: (double value) {
                            setState(() {
                              wt = value;
                            });
                          })),
                  (act!="")?ElevatedButton(
                      onPressed: () async {
                        sec = seconds / 60.0;

                        data = await HomePageProvider.burnedData(
                            "${d[0]['id']}",
                            "${min.toString()}${sec.toString()}",
                            wt.toStringAsFixed(2));
                      },
                      child: Text('Calculate'),
                      style: ElevatedButton.styleFrom(
                          primary: const Color(0xFF1FB5E4))):SizedBox(),
                  const SizedBox(
                    height: 15,
                  ),
                  (data.unit == "0")
                      ? const SizedBox(height: 40)
                      : Container(
                          width: MediaQuery.of(context).size.width - 80,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: const Color(0xFF1FB5E4)),
                          ),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text('Result',
                                      style: Theme.of(context)
                                          .primaryTextTheme
                                          .headline3!
                                          .copyWith(
                                              color: const Color(0xFF1FB5E4))),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text.rich(TextSpan(
                                      text:
                                          'These estimated calorie burned by this excercise ',
                                      style: Theme.of(context)
                                          .primaryTextTheme
                                          .subtitle1!
                                          .copyWith(
                                              fontSize: 14,
                                              color: const Color(0xFF006484),
                                              fontWeight: FontWeight.normal))),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 20.0, horizontal: 20),
                                  child: Column(
                                    children: [
                                      optionWidget(context, 'BurnedCalorie',
                                          '${data.burnedCalorie} ${data.unit}'),
                                    ],
                                  ),
                                ),
                              ])),
                  const SizedBox(
                    height: 40,
                  )
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}

Widget optionWidget(BuildContext context, String name, String name1) {
  return Row(
    children: [
      Text(
        name,
        style: Theme.of(context).primaryTextTheme.subtitle1,
      ),
      Spacer(),
      Flexible(
          child: Align(
              alignment: Alignment.centerRight,
              child: Text(name1,
                  style: Theme.of(context).primaryTextTheme.subtitle1))),
    ],
  );
}
