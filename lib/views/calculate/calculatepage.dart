import 'package:fittrack/constants/AppPages.dart';
import 'package:fittrack/constants/uiconstants.dart';
import 'package:fittrack/views/widget/primaryScreen/calculatorCard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class CalculateScreen extends StatefulWidget {
  const CalculateScreen({Key? key}) : super(key: key);

  @override
  _CalculateScreenState createState() => _CalculateScreenState();
}

class _CalculateScreenState extends State<CalculateScreen> {
  late BannerAd _bannerAd;
  bool _isAdLoaded = false;
  @override
  void initState() {
    super.initState();
    _initBannerAd();
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
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0xFF1FB5E4),
      bottomNavigationBar: _isAdLoaded?Container(height: _bannerAd.size.height.toDouble(),width: _bannerAd.size.width.toDouble(),child: AdWidget(ad:_bannerAd,)):SizedBox(),
      body: Stack(
        children: [
          ListView(
            shrinkWrap: true,
            children: [
              Container(
                height: size.height * 0.30,
                color: Color(0xFF1FB5E4),
                child: SafeArea(
                  child: Row(
                    children: [
                      Expanded(
                        flex: 8,
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.topLeft,
                              child: IconButton(
                                icon: Icon(Icons.menu),
                                color: Colors.white,
                                onPressed: () {},
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 25, vertical: 10),
                                child: Text('Fit Track',
                                    style: Theme.of(context)
                                        .primaryTextTheme
                                        .headline1!
                                        .copyWith(fontSize: 32)),
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 30, vertical: 10),
                                child: Text.rich(TextSpan(
                                    text:
                                        'You Don\'t have to be Extreme Just Consistent',
                                    style: Theme.of(context)
                                        .primaryTextTheme
                                        .headline5!
                                        .copyWith(fontSize: 14))),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Expanded(
                        flex: 5,
                        child: Image(
                          alignment: Alignment.centerRight,
                          image: AssetImage(
                            "assets/calculator.png",
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.only(topLeft: Radius.circular(80.0)),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
                  child: GridView.count(
                      crossAxisCount: 2,
                      childAspectRatio: 1.2,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                      children: [
                        CategoryCard(
                          title: "Ideal Weight",
                          pngSrc: "assets/idealweight.png",
                          press: () {
                            Get.toNamed(AppPages.IdealPage);
                          },
                        ),
                        CategoryCard(
                          title: "BMI",
                          pngSrc: "assets/Bmi.png",
                          press: () {
                            Get.toNamed(AppPages.BmiPage);
                          },
                        ),
                        CategoryCard(
                          title: "Body Fat Percentage",
                          pngSrc: "assets/fatper.png",
                          press: () {
                            Get.toNamed(AppPages.BodyFat);
                          },
                        ),
                        CategoryCard(
                          title: "Calorie Burn",
                          pngSrc: "assets/calburn.png",
                          press: () {
                            Get.toNamed(AppPages.DailyChalorieBurn, arguments: [
                              {"details": "", "id": "", "intensity": "1"}
                            ]);
                          },
                        ),
                        CategoryCard(
                          title: "Daily Calorie Requirement",
                          pngSrc: "assets/calrequirement.png",
                          press: () {
                            Get.toNamed(AppPages.DailyChalorieRequirement);
                          },
                        ),
                        CategoryCard(
                          title: "Macros Amount",
                          pngSrc: "assets/macros.png",
                          press: () {
                            Get.toNamed(AppPages.MacrosPage);
                          },
                        ),
                      ]),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
