import 'package:fittrack/Provider/foodprovider.dart';
import 'package:fittrack/model/foods/food.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';

class FoodDetailScreen extends StatefulWidget {
  const FoodDetailScreen({Key? key}) : super(key: key);

  @override
  _FoodDetailScreenState createState() => _FoodDetailScreenState();
}

class _FoodDetailScreenState extends State<FoodDetailScreen> {
  var d = Get.arguments;
  late BannerAd _bannerAd;
  bool _isAdLoaded = false;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((duration) {
      Provider.of<FoodProvider>(context, listen: false)
          .foodinfo('${d[0]['id']}');
    });
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
        title: Text('Food Details'),
      ),
      body: Consumer<FoodProvider>(
        builder: (context, provider, _) {
          var k = provider.foodInfoData;
          if (provider.isLoading ||
              k['description'] == null ||
              k['description'] == null ||
              k['portion'] == null ||
              k['foodNutrients']['Protein']['value'] == null) {
            return Container(
                child: const Center(
              child: CircularProgressIndicator(),
            ));
          }
          return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: const Color(0xFF1FB5E4)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: [
                          SizedBox(height: 10),
                          Center(
                            child: Text.rich(TextSpan(
                                text: '${k['description']}',
                                style: Theme.of(context)
                                    .primaryTextTheme
                                    .subtitle1!
                                    .copyWith(
                                        fontSize: 22,
                                        color: const Color(0xFF006484),
                                        fontWeight: FontWeight.bold))),
                          ),
                          const Divider(
                            color: Color(0xFF006484),
                            thickness: 2,
                          ),
                          const SizedBox(height: 20),
                          optionContainer(context, 'Portion', '${k['portion']}',
                              '${k['portionUnit']}'),
                          const SizedBox(height: 10),
                          const Divider(
                            color: Color(0xFF006484),
                            thickness: 1,
                          ),
                          Center(
                            child: Text.rich(TextSpan(
                                text: 'Food Nutrients\n',
                                style: Theme.of(context)
                                    .primaryTextTheme
                                    .subtitle1!
                                    .copyWith(
                                        fontSize: 22,
                                        color: const Color(0xFF006484),
                                        fontWeight: FontWeight.bold))),
                          ),
                          optionContainer(
                              context,
                              'Protein',
                              '${k['foodNutrients']['Protein']['value']}',
                              '${k['foodNutrients']['Protein']['unitname']}'),
                          const SizedBox(height: 7.5),
                          const Divider(
                            color: Color(0xFF006484),
                            thickness: 1,
                          ),
                          const SizedBox(height: 7.5),
                          optionContainer(
                              context,
                              'Carbonhydrate',
                              '${k['foodNutrients']['Carbonhydrate']['value']}',
                              '${k['foodNutrients']['Carbonhydrate']['unitname']}'),
                          const SizedBox(height: 7.5),
                          const Divider(
                            color: Color(0xFF006484),
                            thickness: 1,
                          ),
                          const SizedBox(height: 7.5),
                          optionContainer(
                              context,
                              'Energy',
                              '${k['foodNutrients']['Energy']['value']}',
                              '${k['foodNutrients']['Energy']['unitname']}'),
                          const SizedBox(height: 7.5),
                          const Divider(
                            color: Color(0xFF006484),
                            thickness: 1,
                          ),
                          const SizedBox(height: 7.5),
                          optionContainer(
                              context,
                              'Water',
                              '${k['foodNutrients']['Water']['value']}',
                              '${k['foodNutrients']['Water']['unitname']}'),
                          const SizedBox(height: 7.5),
                          const Divider(
                            color: Color(0xFF006484),
                            thickness: 1,
                          ),
                          const SizedBox(height: 7.5),
                          Text.rich(TextSpan(
                              text: 'Fat\n',
                              style: Theme.of(context)
                                  .primaryTextTheme
                                  .subtitle1!
                                  .copyWith(
                                      fontSize: 18,
                                      color: const Color(0xFF006484),
                                      fontWeight: FontWeight.bold))),
                          optionContainer(
                              context,
                              'Fatty acids,\n Total saturated',
                              '${k['foodNutrients']['Fat']['Fatty acids, total saturated']['value']}',
                              '${k['foodNutrients']['Fat']['Fatty acids, total saturated']['unitname']}'),
                          const SizedBox(height: 7.5),
                          const Divider(
                            color: Color(0xFF006484),
                            thickness: 1,
                          ),
                          const SizedBox(height: 7.5),
                          optionContainer(
                              context,
                              ' Total lipid',
                              '${k['foodNutrients']['Fat']['Total lipid (fat)']['value']}',
                              '${k['foodNutrients']['Fat']['Total lipid (fat)']['unitname']}'),
                          const SizedBox(height: 7.5),
                          const Divider(
                            color: Color(0xFF006484),
                            thickness: 1,
                          ),
                          const SizedBox(height: 7.5),
                          optionContainer(
                              context,
                              'Fatty acids,\n Total monounsaturated',
                              '${k['foodNutrients']['Fat']['Fatty acids, total monounsaturated']['value']}',
                              '${k['foodNutrients']['Fat']['Fatty acids, total monounsaturated']['unitname']}'),
                          const SizedBox(height: 7.5),
                          const Divider(
                            color: Color(0xFF006484),
                            thickness: 1,
                          ),
                          optionContainer(
                              context,
                              'Fatty acids,\n Total polyunsaturated',
                              '${k['foodNutrients']['Fat']['Fatty acids, total polyunsaturated']['value']}',
                              '${k['foodNutrients']['Fat']['Fatty acids, total polyunsaturated']['unitname']}'),
                          const SizedBox(height: 7.5),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              ));
        },
      ),
    );
  }

  Row optionContainer(
      BuildContext context, String title, String value, String unit) {
    return Row(
      children: [
        Text.rich(
          TextSpan(
            text: title,
            style: Theme.of(context).primaryTextTheme.subtitle1!.copyWith(
                fontSize: 18,
                color: const Color(0xFF006484),
                fontWeight: FontWeight.bold),
          ),
        ),
        Spacer(),
        Text.rich(
          TextSpan(
            text: '${value} ${unit}',
            style: Theme.of(context).primaryTextTheme.subtitle1!.copyWith(
                fontSize: 16,
                color: const Color(0xFF006484),
                fontWeight: FontWeight.normal),
          ),
        ),
      ],
    );
  }
}
