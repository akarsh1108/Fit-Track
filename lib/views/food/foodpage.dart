import 'package:fittrack/Provider/foodprovider.dart';
import 'package:fittrack/constants/AppPages.dart';
import 'package:fittrack/constants/uiconstants.dart';
import 'package:fittrack/model/foods/tablenames.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';

class FoodScreen extends StatefulWidget {
  const FoodScreen({Key? key}) : super(key: key);

  @override
  _FoodScreenState createState() => _FoodScreenState();
}

class _FoodScreenState extends State<FoodScreen> {
  late BannerAd _bannerAd;
  bool _isAdLoaded = false;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback(
      (duration) {
        Provider.of<FoodProvider>(context, listen: false).tablelist();
      },
    );
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
            height: MediaQuery.of(context).size.width - 200,
            decoration: const BoxDecoration(
              image: DecorationImage(image: AssetImage("assets/food.png")),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: RichText(
                text: TextSpan(
                  text: 'Food Tables',
                  style: Theme.of(context)
                      .primaryTextTheme
                      .headline2!
                      .copyWith(color: const Color(0xFF1FB5E4), fontSize: 28),
                ),
              ),
            ),
          ),
          const Divider(
            color: Color(0xFF006484),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                children: [
                  RichText(
                    text: TextSpan(
                      text:
                          'Each table provides a separate food list to assist you in sticking to your diet.',
                      style: Theme.of(context)
                          .primaryTextTheme
                          .subtitle1!
                          .copyWith(
                              color: const Color(0xFF006484), fontSize: 16),
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                        text: 'SR -',
                        style: Theme.of(context)
                            .primaryTextTheme
                            .subtitle1!
                            .copyWith(
                                color: const Color(0xFF006484),
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                        children: [
                          TextSpan(
                            text: ' Standard Reference Legacy',
                            style: Theme.of(context)
                                .primaryTextTheme
                                .subtitle1!
                                .copyWith(
                                    color: const Color(0xFF006484),
                                    fontSize: 15),
                          )
                        ]),
                  ),
                  RichText(
                    text: TextSpan(
                        text: 'SU -',
                        style: Theme.of(context)
                            .primaryTextTheme
                            .subtitle1!
                            .copyWith(
                                color: const Color(0xFF006484),
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                        children: [
                          TextSpan(
                            text: ' FNDDS Survey',
                            style: Theme.of(context)
                                .primaryTextTheme
                                .subtitle1!
                                .copyWith(
                                    color: const Color(0xFF006484),
                                    fontSize: 15),
                          )
                        ]),
                  ),
                ],
              ),
            ),
          ),
          Consumer<FoodProvider>(
            builder: (context, provider, _) {
              List tablelist = provider.TableModelList;
              if (provider.isLoading) {
                return Container(
                    child: const Center(
                  child: CircularProgressIndicator(),
                ));
              }

              return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.only(topLeft: Radius.circular(80.0)),
                    ),
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(20, 10, 20, 50),
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          crossAxisSpacing: 15.0,
                          mainAxisSpacing: 15.0,
                        ),
                        itemCount: tablelist.length,
                        itemBuilder: (BuildContext context, int index) {
                          return CategoryCard(
                            press: () {
                              Get.toNamed(AppPages.subtablePage, arguments: [
                                {"tables": '${tablelist[index]}'}
                              ]);
                            },
                            title: '${tablelist[index]}',
                          );
                        },
                      ),
                    ),
                  ));
            },
          ),
        ],
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  final String title;
  final VoidCallback press;
  const CategoryCard({
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
                        .copyWith(fontSize: 24),
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
