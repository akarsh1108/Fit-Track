import 'dart:async';

import 'package:fittrack/Provider/homepageprovider.dart';
import 'package:fittrack/model/calculator/burnedchalorie.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';

class CountdownScreen extends StatefulWidget {
  const CountdownScreen({Key? key}) : super(key: key);

  @override
  _CountdownScreenState createState() => _CountdownScreenState();
}

class _CountdownScreenState extends State<CountdownScreen> {
  var d = Get.arguments;
  Duration duration = Duration(minutes: 10);
  static const countdownDuration = Duration(minutes: 10);
  bool Stimer = false;
  bool showResult = false;
  bool showForm = false;
  Timer? timer;
  bool isCountdown = false;
  double wt = 100;
  int min = 0;
  int sec = 0;
  late BurnedData data;
  late BannerAd _bannerAd;
  bool _isAdLoaded = false;
  @override
  void initState() {
    super.initState();
    this.data = BurnedData(burnedCalorie: "0", unit: "0");
    // startTimer();
    reset();
    _initBannerAd();
  }

  void reset() {
    if (isCountdown) {
      setState(() => duration = countdownDuration);
    } else {
      setState(() => duration = Duration());
    }
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

  void addTime() {
    final addSeconds = isCountdown ? -1 : 1;
    setState(() {
      final seconds = duration.inSeconds + addSeconds;
      if (seconds < 0) {
        timer?.cancel();
      } else {
        duration = Duration(seconds: seconds);
      }
    });
  }

  void startTimer({bool resets = true}) {
    if (resets) {
      reset();
    }
    timer = Timer.periodic(Duration(seconds: 1), (_) => addTime());
  }

  void stopTimer({bool resets = true}) {
    if (resets) {
      reset();
    }
    setState(() => timer?.cancel());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _isAdLoaded?Container(height: _bannerAd.size.height.toDouble(),width: _bannerAd.size.width.toDouble(),child: AdWidget(ad:_bannerAd,)):SizedBox(),
      appBar: AppBar(
        title: Text('Details'),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xFF1FB5E4)),
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      RichText(
                        text: TextSpan(
                            text: 'Description: ',
                            style: Theme.of(context)
                                .primaryTextTheme
                                .subtitle1!
                                .copyWith(
                                    color: const Color(0xFF006484),
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold),
                            children: [
                              TextSpan(
                                  text: '${d[0]['details'].description}',
                                  style: Theme.of(context)
                                      .primaryTextTheme
                                      .subtitle1!
                                      .copyWith(
                                          color: const Color(0xFF006484),
                                          fontSize: 14,
                                          fontWeight: FontWeight.normal)),
                            ]),
                      ),
                      SizedBox(height: 10.0),
                      Row(
                        children: [
                          RichText(
                            text: TextSpan(
                                text: 'MetValue: ',
                                style: Theme.of(context)
                                    .primaryTextTheme
                                    .subtitle1!
                                    .copyWith(
                                        color: const Color(0xFF006484),
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                children: [
                                  TextSpan(
                                      text: '${d[0]['details'].metValue}',
                                      style: Theme.of(context)
                                          .primaryTextTheme
                                          .subtitle1!
                                          .copyWith(
                                              color: const Color(0xFF006484),
                                              fontSize: 14,
                                              fontWeight: FontWeight.normal)),
                                ]),
                          ),
                          Spacer(),
                          RichText(
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
                                      text: '${d[0]['details'].activity}',
                                      style: Theme.of(context)
                                          .primaryTextTheme
                                          .subtitle1!
                                          .copyWith(
                                              color: const Color(0xFF006484),
                                              fontSize: 14,
                                              fontWeight: FontWeight.normal)),
                                ]),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Center(
                        child: RichText(
                          text: TextSpan(
                              text: 'IntensityLevel: ',
                              style: Theme.of(context)
                                  .primaryTextTheme
                                  .subtitle1!
                                  .copyWith(
                                      color: const Color(0xFF006484),
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                              children: [
                                TextSpan(
                                    text: '${d[0]['details'].intensityLevel}',
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
                )),
          ),
          (Stimer == false)
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        onPressed: () async {
                          setState(() {
                            Stimer = true;
                          });
                        },
                        child: Text('Start Button'),
                        style: ElevatedButton.styleFrom(
                            primary: const Color(0xFF1FB5E4))),
                  ],
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    buildTime(),
                    SizedBox(height: 10),
                    (showForm == false) ? buildButton() : makeform(),
                    (showResult == true)
                        ? Padding(
                            padding: const EdgeInsets.all(14.0),
                            child: Container(
                                width: MediaQuery.of(context).size.width - 80,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                      color: const Color(0xFF1FB5E4)),
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
                                                    color: const Color(
                                                        0xFF1FB5E4))),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text.rich(TextSpan(
                                            text:
                                                'These estimated chalorie burned by this excercise ',
                                            style: Theme.of(context)
                                                .primaryTextTheme
                                                .subtitle1!
                                                .copyWith(
                                                    fontSize: 14,
                                                    color:
                                                        const Color(0xFF006484),
                                                    fontWeight:
                                                        FontWeight.normal))),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 20.0, horizontal: 20),
                                        child: Column(
                                          children: [
                                            optionWidget(
                                                context,
                                                'BurnedChalorie',
                                                '${data.burnedCalorie} ${data.unit}'),
                                          ],
                                        ),
                                      ),
                                    ])),
                          )
                        : SizedBox(height: 0),
                  ],
                ),
        ],
      ),
    );
  }

  Widget buildTime() {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        buildThemeCard(time: hours, header: 'Hours'),
        const SizedBox(
          width: 5,
        ),
        buildThemeCard(time: minutes, header: 'Minutes'),
        const SizedBox(
          width: 5,
        ),
        buildThemeCard(time: seconds, header: 'Seconds'),
      ],
    );
  }

  Widget buildThemeCard({required String time, required String header}) {
    (header == "Hours")
        ? min = int.parse(time) * 60
        : (header == "Minutes")
            ? min = min + int.parse(time)
            : sec = int.parse(time);
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
              color: Color(0xFF1FB5E4),
              borderRadius: BorderRadius.circular(20)),
          child: Text(
            time,
            style: Theme.of(context).primaryTextTheme.headline1,
          ),
        ),
        const SizedBox(height: 5),
        Text(header, style: Theme.of(context).primaryTextTheme.subtitle1)
      ],
    );
  }

  Widget buildButton() {
    final isRunning = timer == null ? false : timer!.isActive;
    final isCompleted = duration.inSeconds == 0;
    return isRunning || !isCompleted
        ? Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: () {
                    if (isRunning) {
                      stopTimer(resets: false);
                    } else {
                      startTimer(resets: false);
                    }
                  },
                  child: isRunning ? Text('Pause') : Text('Resume'),
                  style: ElevatedButton.styleFrom(
                      primary: const Color(0xFF1FB5E4))),
              SizedBox(width: 10),
              ElevatedButton(
                  onPressed: () {
                    stopTimer(resets: false);

                    showForm = true;
                  },
                  child: Text('Stop'),
                  style: ElevatedButton.styleFrom(
                      primary: const Color(0xFF1FB5E4))),
            ],
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: () async {
                    startTimer();
                  },
                  child: Text('Start Timer'),
                  style: ElevatedButton.styleFrom(
                      primary: const Color(0xFF1FB5E4))),
            ],
          );
  }

  Widget makeform() {
    return Consumer<HomePageProvider>(builder: (context, HomePageProvider, _) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
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
                style: Theme.of(context).primaryTextTheme.subtitle1!.copyWith(
                    fontSize: 14,
                    color: Color(0xFF006484),
                    fontWeight: FontWeight.normal),
              ),
              Text(
                'kg',
                style: Theme.of(context).primaryTextTheme.subtitle1!.copyWith(
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
                thumbShape: RoundSliderThumbShape(enabledThumbRadius: 12.0),
                overlayShape: RoundSliderOverlayShape(overlayRadius: 24.0),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: () async {
                    showResult = false;
                    showForm = false;
                    stopTimer(resets: true);
                  },
                  child: Text('Reset'),
                  style: ElevatedButton.styleFrom(
                      primary: const Color(0xFF1FB5E4))),
              SizedBox(width: 10),
              ElevatedButton(
                  onPressed: () async {
                    double v = sec / 60.0;
                    data = await HomePageProvider.burnedData(
                        "${d[0]['details'].id}",
                        "${min.toString()}${v.toString()}",
                        wt.toStringAsFixed(2));
                    setState(() {
                      showResult = true;
                    });
                  },
                  child: Text('Calculate'),
                  style: ElevatedButton.styleFrom(
                      primary: const Color(0xFF1FB5E4))),
            ],
          ),
        ],
      );
    });
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
