import 'package:fittrack/Provider/foodprovider.dart';
import 'package:fittrack/constants/AppPages.dart';
import 'package:fittrack/model/foods/sub_tablemodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';

class SubtableScreen extends StatefulWidget {
  const SubtableScreen({Key? key}) : super(key: key);

  @override
  _SubtableScreenState createState() => _SubtableScreenState();
}

class _SubtableScreenState extends State<SubtableScreen> {
  var tables = Get.arguments;
  late BannerAd _bannerAd;
  bool _isAdLoaded = false;
  @override
  void initState() {
    super.initState();
    Provider.of<FoodProvider>(context, listen: false)
        .subtable('${tables[0]['tables']}');
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
      appBar: AppBar(
        title: Text('Tablename ${tables[0]['tables']}'),
      ),
      body: Consumer<FoodProvider>(builder: (context, provider, _) {
        List<SubData> subTableList = provider.subTableList;
        if (provider.isLoading) {
          return Container(
              child: const Center(
            child: CircularProgressIndicator(),
          ));
        }
        return Column(
          children: [
            Container(
              child: Expanded(
                child: ListView.builder(
                  itemCount: subTableList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return SubtableContainer(subTableList, index);
                  },
                ),
              ),
            ),
            SizedBox(height: 10),
          ],
        );
      }),
    );
  }

  Widget SubtableContainer(List<SubData> subTableList, int index) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: GestureDetector(
        onTap: () {
          Get.toNamed(AppPages.InfotablePage, arguments: [
            {'id': '${subTableList[index].id}'}
          ]);
        },
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Color(0xFF1FB5E4)),
            color: Colors.white,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Padding(
            padding: const EdgeInsets.all(13.0),
            child: Column(children: [
              Align(
                alignment: Alignment.topLeft,
                child: RichText(
                  text: TextSpan(
                    text: '${subTableList[index].subDataType}',
                    style: Theme.of(context)
                        .primaryTextTheme
                        .subtitle1!
                        .copyWith(color: const Color(0xFF006484), fontSize: 14),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: RichText(
                      text: TextSpan(
                          text: 'Resource: ',
                          style: Theme.of(context)
                              .primaryTextTheme
                              .subtitle1!
                              .copyWith(
                                  color: const Color(0xFF006484),
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                          children: [
                            TextSpan(
                                text: '${subTableList[index].dataType}',
                                style: Theme.of(context)
                                    .primaryTextTheme
                                    .subtitle1!
                                    .copyWith(
                                        color: const Color(0xFF006484),
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal)),
                          ]),
                    ),
                  ),
                  Spacer(),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: RichText(
                      text: TextSpan(
                          text: 'FoodCount: ',
                          style: Theme.of(context)
                              .primaryTextTheme
                              .subtitle1!
                              .copyWith(
                                  color: const Color(0xFF006484),
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                          children: [
                            TextSpan(
                                text: '${subTableList[index].foodCount}',
                                style: Theme.of(context)
                                    .primaryTextTheme
                                    .subtitle1!
                                    .copyWith(
                                        color: const Color(0xFF006484),
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal)),
                          ]),
                    ),
                  ),
                ],
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
