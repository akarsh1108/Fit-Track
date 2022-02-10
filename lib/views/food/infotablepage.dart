import 'package:fittrack/Provider/foodprovider.dart';
import 'package:fittrack/constants/AppPages.dart';
import 'package:fittrack/model/foods/foodinfo.dart';
import 'package:fittrack/services/apiservices.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';

class InfoScreen extends StatefulWidget {
  const InfoScreen({Key? key}) : super(key: key);

  @override
  _InfoScreenState createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  var info = Get.arguments;
  final styleActive = TextStyle(color: Color(0xFF006484));
  final styleHint = TextStyle(color: Colors.black54);
  final controller = TextEditingController();
  String query = '';
  List<InfoData> infoList = [];
  late BannerAd _bannerAd;
  bool _isAdLoaded = false;
  @override
  void initState() {
    super.initState();
    Provider.of<FoodProvider>(context, listen: false)
        .infotable('${info[0]['id']}', query);
    init();
    _initBannerAd();
  }

  Future init() async {
    infoList = await ApiServices.infotableData('${info[0]['id']}', query);
    setState(() => this.infoList = infoList);
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
        title: Text('Details'),
      ),
      body: Consumer<FoodProvider>(builder: (context, provider, _) {
        if (provider.isLoading) {
          return Container(
              child: const Center(
            child: CircularProgressIndicator(),
          ));
        }
        return Column(
          children: [
            Container(
              height: 40,
              margin: const EdgeInsets.fromLTRB(16, 16, 16, 16),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white,
                  border: Border.all(color: Color(0xFF1FB5E4))),
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: TextFormField(
                controller: controller,
                decoration: InputDecoration(
                  icon: Icon(Icons.search, color: Color(0xFF006484)),
                  suffixIcon: query.isNotEmpty
                      ? GestureDetector(
                          child: Icon(Icons.close, color: Color(0xFF006484)),
                          onTap: () async {
                            controller.clear();
                            infoList = await ApiServices.infotableData(
                                '${info[0]['id']}', '');
                            setState(() => this.infoList = infoList);
                          })
                      : null,
                  hintText: 'Description or Activity',
                  hintStyle: (query.isEmpty) ? styleHint : styleActive,
                  border: InputBorder.none,
                ),
                onChanged: (value) async {
                  setState(() {
                    query = value;
                  });
                  infoList = await ApiServices.infotableData(
                      '${info[0]['id']}', query);
                  setState(() => this.infoList = infoList);
                },
              ),
            ),
            Container(
              child: Expanded(
                child: ListView.builder(
                  itemCount: infoList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return InfoContainer(infoList, index);
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

  Widget InfoContainer(List<InfoData> infoTableList, int index) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: GestureDetector(
        onTap: () {
          print('${infoTableList[index].id}');

          Get.toNamed(AppPages.foodDetalsPage, arguments: [
            {'id': '${infoTableList[index].id}'}
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
                    text: '${infoTableList[index].foodType}',
                    style: Theme.of(context)
                        .primaryTextTheme
                        .subtitle1!
                        .copyWith(color: const Color(0xFF006484), fontSize: 14),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Align(
                alignment: Alignment.bottomRight,
                child: RichText(
                  text: TextSpan(
                      text: 'Subdata : ',
                      style: Theme.of(context)
                          .primaryTextTheme
                          .subtitle1!
                          .copyWith(
                              color: const Color(0xFF006484),
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                      children: [
                        TextSpan(
                            text: '${infoTableList[index].subDataType}',
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
            ]),
          ),
        ),
      ),
    );
  }
}
