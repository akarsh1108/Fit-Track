import 'dart:ui';

import 'package:fittrack/Provider/excerciseprovider.dart';
import 'package:fittrack/constants/AppPages.dart';
import 'package:fittrack/constants/uiconstants.dart';
import 'package:fittrack/model/activitymodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';

import '../widget/primaryScreen/calculatorCard.dart';

class ExerciseScreen extends StatefulWidget {
  const ExerciseScreen({Key? key}) : super(key: key);

  @override
  _ExerciseScreenState createState() => _ExerciseScreenState();
}

class _ExerciseScreenState extends State<ExerciseScreen> {
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
    return Scaffold(
      bottomNavigationBar: _isAdLoaded?Container(height: _bannerAd.size.height.toDouble(),width: _bannerAd.size.width.toDouble(),child: AdWidget(ad:_bannerAd,)):SizedBox(),
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Center(
              child: Text('FitTrack',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24))),
          backgroundColor: const Color(0xFF1FB5E4),
        ),
        body: ListView(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width - 150,
              decoration: const BoxDecoration(
                image:
                    DecorationImage(image: AssetImage("assets/activity.png")),
              ),
            ),
            Center(
              child: RichText(
                text: TextSpan(
                  text: 'Activities',
                  style: Theme.of(context)
                      .primaryTextTheme
                      .headline2!
                      .copyWith(color: Color(0xFF1FB5E4), fontSize: 28),
                ),
              ),
            ),
            const Divider(
              color: Color(0xFF006484),
            ),
            Center(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: RichText(
                  text: TextSpan(
                    text:
                        'Your daily activities are divided on basis of intensity level',
                    style: Theme.of(context)
                        .primaryTextTheme
                        .subtitle1!
                        .copyWith(color: Color(0xFF006484), fontSize: 16),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: MediaQuery.of(context).size.height,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.only(topLeft: Radius.circular(80.0)),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: GridView.count(
                    shrinkWrap: true,
                      crossAxisCount: 3,
                      childAspectRatio: 1.2,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                      children: [
                        CategoryCard2(
                          title: "1",
                          press: () {
                            Get.toNamed(AppPages.ActivityPage, arguments: [{"intensity":'1'}]);
                          },
                        ),
                        CategoryCard2(
                          title: "2",
                          press: () {
                             Get.toNamed(AppPages.ActivityPage, arguments: [{"intensity":'2'}]);
                          },
                        ),
                        CategoryCard2(
                          title: "3",
                          press: () {
                             Get.toNamed(AppPages.ActivityPage, arguments: [{"intensity":'3'}]);
                          },
                        ),
                        CategoryCard2(
                          title: "4",
                          press: () {
                             Get.toNamed(AppPages.ActivityPage, arguments: [{"intensity":'4'}]);
                          },
                        ),
                        CategoryCard2(
                          title: "5",
                          press: () {
                             Get.toNamed(AppPages.ActivityPage, arguments: [{"intensity":'5'}]);
                          },
                        ),
                        CategoryCard2(
                          title: "6",
                          press: () {
                             Get.toNamed(AppPages.ActivityPage, arguments: [{"intensity":'6'}]);
                          },
                        ),
                        CategoryCard2(
                          title: "7",
                          press: () {
                             Get.toNamed(AppPages.ActivityPage, arguments: [{"intensity":'7'}]);
                          },
                        ),
                        CategoryCard2(
                          title: "8",
                          press: () {
                             Get.toNamed(AppPages.ActivityPage, arguments: [{"intensity":'8'}]);
                          },
                        ),
                        CategoryCard2(
                          title: "9",
                          press: () {
                            Get.toNamed(AppPages.ActivityPage, arguments: [{"intensity":'9'}]);
                          },
                        ),
                      ]),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ));
  }
}



class CategoryCard2 extends StatelessWidget {
  final String title;
  final VoidCallback press;
  const CategoryCard2({
    required this.title,
    required this.press,
  });

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return ClipRRect(
      borderRadius: BorderRadius.circular(13),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Color(0xFF1FB5E4)),
          color: Colors.white,
          borderRadius: BorderRadius.circular(13),
          boxShadow: const [
            BoxShadow(
              offset: Offset(0, 17),
              blurRadius: 17,
              spreadRadius: 23,
              color: kShadowColor,
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: press,
            child: Center(
              child: Container(
                width: size.width,
                color: Color(0xFF1FB5E4),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Text(
                    title,
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .primaryTextTheme
                        .headline1!
                        .copyWith(fontSize: 36),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
