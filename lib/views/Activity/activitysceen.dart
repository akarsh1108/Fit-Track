import 'package:fittrack/Provider/excerciseprovider.dart';
import 'package:fittrack/Provider/homepageprovider.dart';
import 'package:fittrack/constants/AppPages.dart';
import 'package:fittrack/constants/uiconstants.dart';
import 'package:fittrack/model/activitymodel.dart';
import 'package:fittrack/services/apiservices.dart';
import 'package:fittrack/views/widget/searchwidget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';

class ActivityScreen extends StatefulWidget {
  const ActivityScreen({Key? key}) : super(key: key);

  @override
  _ActivityScreenState createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen> {
  var intensity = Get.arguments;
  final controller = TextEditingController();
  String query = '';
  final styleActive = TextStyle(color: Color(0xFF006484));
  final styleHint = TextStyle(color: Colors.black54);
  List<ActivityData> activityModelList = [];
  late BannerAd _bannerAd;
  bool _isAdLoaded = false;
  @override
  void initState() {
    super.initState();
    Provider.of<ActivityProvider>(context, listen: false)
        .getactivities('${intensity[0]['intensity']}', query);
    init();
    _initBannerAd();
  }

  Future init() async {
    activityModelList =
        await ApiServices.activities('${intensity[0]['intensity']}', query);
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
        appBar: AppBar(
          title: Text('Intensity Level ${intensity[0]['intensity']}'),
        ),
        body: Consumer<ActivityProvider>(builder: (context, provider, _) {
          if (provider.isLoading) {
            return Container(
                child: const Center(
              child: CircularProgressIndicator(),
            ));
          }

          void searchActivity(String query) {
            onChanged:
            (value) async {
              setState(() {
                query = value;
              });
              activityModelList = await ApiServices.activities(
                  '${intensity[0]['intensity']}', query);
              setState(() => this.activityModelList = activityModelList);
            };
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

                              activityModelList = await ApiServices.activities(
                                  '${intensity[0]['intensity']}', '');
                              setState(() =>
                                  this.activityModelList = activityModelList);
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
                    activityModelList = await ApiServices.activities(
                        '${intensity[0]['intensity']}', query);
                    setState(() => this.activityModelList = activityModelList);
                  },
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: activityModelList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ActivityContainer(activityModelList, index);
                  },
                ),
              ),
            ],
          );
        }));
  }

  Widget ActivityContainer(List<ActivityData> _activityModelList, int index) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: GestureDetector(
        onTap: () {
          Get.toNamed(AppPages.CountdownPage, arguments: [
            {'details': _activityModelList[index]}
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
                    text: '${_activityModelList[index].description}',
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
                      text: 'Activity: ',
                      style: Theme.of(context)
                          .primaryTextTheme
                          .subtitle1!
                          .copyWith(
                              color: const Color(0xFF006484),
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                      children: [
                        TextSpan(
                            text: '${_activityModelList[index].activity}',
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

class SearchWidget extends StatefulWidget {
  final String text;
  final ValueChanged<String> onChanged;
  final String hintText;
  SearchWidget(this.text, this.onChanged, this.hintText);
  @override
  _SearchWidgetState createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  final controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final styleActive = TextStyle(color: Color(0xFF006484));
    final styleHint = TextStyle(color: Colors.black54);
    final style = widget.text.isEmpty ? styleHint : styleActive;
    return Container(
      height: 40,
      margin: const EdgeInsets.fromLTRB(16, 16, 16, 16),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
          border: Border.all(color: Color(0xFF1FB5E4))),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          icon: Icon(Icons.search, color: style.color),
          suffixIcon: widget.text.isNotEmpty
              ? GestureDetector(
                  child: Icon(Icons.close, color: style.color),
                  onTap: () {
                    controller.clear();
                    widget.onChanged('');
                  })
              : null,
          hintText: widget.hintText,
          hintStyle: style,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
