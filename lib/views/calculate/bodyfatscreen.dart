import 'package:fittrack/Provider/homepageprovider.dart';
import 'package:fittrack/constants/AppPages.dart';
import 'package:fittrack/constants/uiconstants.dart';
import 'package:fittrack/model/calculator/bodyfatpercentage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';

class BodyFatScreen extends StatefulWidget {
  const BodyFatScreen({Key? key}) : super(key: key);

  @override
  _BodyFatScreenState createState() => _BodyFatScreenState();
}

class _BodyFatScreenState extends State<BodyFatScreen> {
  Gender selectedGender = Gender.male;
  String? gender = "male";
  int height = 180;
  int age = 40;
  double neck = 40;
  double waist = 85;
  double hip = 85;
  double wt = 100;
  late FatPerData data;
   late BannerAd _bannerAd;
  bool _isAdLoaded = false;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((duration) {
      Provider.of<HomePageProvider>(context, listen: false).get();
    });
    _initBannerAd();
    this.data = FatPerData(
      bodyfatUs: 1,
      bodyfatCategory: "no",
      bodyfatMass: 0,
      bodyfatmethod: 0,
      leanbodymass: 0,
    );
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

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1FB5E4),
      bottomNavigationBar: _isAdLoaded?Container(height: _bannerAd.size.height.toDouble(),width: _bannerAd.size.width.toDouble(),child: AdWidget(ad:_bannerAd,)):SizedBox(),
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
                      tag: "assets/fatper.png",
                      child: Container(
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                            image: DecorationImage(
                                image: AssetImage("assets/fatper.png"),
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
                        'Body Fat Percentage',
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
                                'The body fat percentage is a measure of fitness level, since it is the only body measurement which directly calculates a person\'s relative body composition without regard to height or weight',
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 100,
                        width: 100,
                        child: ReuseableCard(
                          onPress: () {
                            setState(() {
                              selectedGender = Gender.male;
                              gender = "male";
                            });
                          },
                          colour: (selectedGender == Gender.male)
                              ? kactiveboxcolor
                              : kinactiveboxcolor,
                          cardChild: symbolGender(
                            gender: 'MALE',
                            icon: FontAwesomeIcons.mars,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 30,
                      ),
                      Container(
                          height: 100,
                          width: 100,
                          child: ReuseableCard(
                            onPress: () {
                              setState(() {
                                selectedGender = Gender.female;
                                gender = "female";
                              });
                            },
                            colour: (selectedGender == Gender.female)
                                ? kactiveboxcolor
                                : kinactiveboxcolor,
                            cardChild: symbolGender(
                              gender: 'FEMALE',
                              icon: FontAwesomeIcons.venus,
                            ),
                          )),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Text("Age : ",
                          style: Theme.of(context)
                              .primaryTextTheme
                              .headline5!
                              .copyWith(color: Color(0xFF028AB5))),
                      Text(
                        age.toString(),
                        style: Theme.of(context)
                            .primaryTextTheme
                            .subtitle1!
                            .copyWith(
                                fontSize: 14,
                                color: Color(0xFF006484),
                                fontWeight: FontWeight.normal),
                      ),
                      Text(
                        'years',
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
                          value: age.toDouble(),
                          min: 0,
                          max: 80,
                          inactiveColor: Color(0xFF8D8E98),
                          onChanged: (double value) {
                            setState(() {
                              age = value.round();
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Text("Height : ",
                          style: Theme.of(context)
                              .primaryTextTheme
                              .headline5!
                              .copyWith(color: Color(0xFF028AB5))),
                      Text(
                        height.toString(),
                        style: Theme.of(context)
                            .primaryTextTheme
                            .subtitle1!
                            .copyWith(
                                fontSize: 14,
                                color: Color(0xFF006484),
                                fontWeight: FontWeight.normal),
                      ),
                      Text(
                        'cm',
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
                          value: height.toDouble(),
                          min: 130,
                          max: 230,
                          inactiveColor: Color(0xFF8D8E98),
                          onChanged: (double value) {
                            setState(() {
                              height = value.round();
                            });
                          })),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Text("Neck : ",
                          style: Theme.of(context)
                              .primaryTextTheme
                              .headline5!
                              .copyWith(color: Color(0xFF028AB5))),
                      Text(
                        neck.toStringAsFixed(2),
                        style: Theme.of(context)
                            .primaryTextTheme
                            .subtitle1!
                            .copyWith(
                                fontSize: 14,
                                color: Color(0xFF006484),
                                fontWeight: FontWeight.normal),
                      ),
                      Text(
                        'cm',
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
                          value: neck.toDouble(),
                          min: 20,
                          max: 80,
                          inactiveColor: Color(0xFF8D8E98),
                          onChanged: (double value) {
                            setState(() {
                              neck = value;
                            });
                          })),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Text("Waist : ",
                          style: Theme.of(context)
                              .primaryTextTheme
                              .headline5!
                              .copyWith(color: Color(0xFF028AB5))),
                      Text(
                        waist.toStringAsFixed(2),
                        style: Theme.of(context)
                            .primaryTextTheme
                            .subtitle1!
                            .copyWith(
                                fontSize: 14,
                                color: Color(0xFF006484),
                                fontWeight: FontWeight.normal),
                      ),
                      Text(
                        'cm',
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
                          value: waist.toDouble(),
                          min: 40,
                          max: 130,
                          inactiveColor: Color(0xFF8D8E98),
                          onChanged: (double value) {
                            setState(() {
                              waist = value;
                            });
                          })),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Text("Hip : ",
                          style: Theme.of(context)
                              .primaryTextTheme
                              .headline5!
                              .copyWith(color: Color(0xFF028AB5))),
                      Text(
                        hip.toStringAsFixed(2),
                        style: Theme.of(context)
                            .primaryTextTheme
                            .subtitle1!
                            .copyWith(
                                fontSize: 14,
                                color: Color(0xFF006484),
                                fontWeight: FontWeight.normal),
                      ),
                      Text(
                        'cm',
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
                          value: hip.toDouble(),
                          min: 40,
                          max: 130,
                          inactiveColor: Color(0xFF8D8E98),
                          onChanged: (double value) {
                            setState(() {
                              hip = value;
                            });
                          })),
                  ElevatedButton(
                      onPressed: () async {
                        data = await HomePageProvider.fatPerData(
                      age.toString(), wt.toString(), height.toString(), gender, neck.toString(), waist.toString(), hip.toString());
               
                      },
                      child: Text('Calculate'),
                      style: ElevatedButton.styleFrom(
                          primary: const Color(0xFF1FB5E4))),
                  const SizedBox(
                    height: 15,
                  ),
                  (data.bodyfatUs < 6)
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
                                          'The percentage result of the following details Input',
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
                                  child: Container(
                                    child: Column(
                                      children: [
                                        optionWidget(
                                            context, 'Body Fat (Us Navy Method)', '${data.bodyfatUs}%'),
                                        const Divider(
                                          color: Color(0xFF006484),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        optionWidget(
                                            context, 'Body Fat Category', '${data.bodyfatCategory}'),
                                        const Divider(
                                          color: Color(0xFF006484),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        optionWidget(context, 'Body Fat Mass',
                                            '${data.bodyfatMass}kg'),
                                        const Divider(
                                          color: Color(0xFF006484),
                                        ),
                                        
                                        const SizedBox(
                                          height: 5,
                                        ),
                                         optionWidget(context, 'Lean Body Mass',
                                            '${data.leanbodymass}kg'),
                                            const Divider(
                                          color: Color(0xFF006484),
                                        ),
                                        
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        optionWidget(context, 'Body Fat (BMI method)',
                                            '${data.bodyfatmethod}%'),
                                              const Divider(
                                          color: Color(0xFF006484),
                                        ),
                                        
                                        const SizedBox(
                                          height: 5,
                                        ),
                                      ],
                                    ),
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
    ;
    ;
  }
}

class ReuseableCard extends StatelessWidget {
  ReuseableCard({this.onPress, required this.colour, required this.cardChild});
  final Color colour;
  Widget cardChild;
  final onPress;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        child: cardChild,
        margin: EdgeInsets.all(15.0),
        decoration: BoxDecoration(
          color: colour,
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }
}

class symbolGender extends StatelessWidget {
  symbolGender({required this.icon, required this.gender});
  final IconData icon;
  final String gender;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          size: 40,
          color: Colors.white,
        ),
        SizedBox(
          height: 5.0,
        ),
        Text(gender,
            style: Theme.of(context)
                .primaryTextTheme
                .subtitle1!
                .copyWith(color: Colors.white)),
      ],
    );
  }
}

// class RoundIconButton extends StatelessWidget {
//   @override
//   RoundIconButton({required this.icon, required this.onPressed});
//   IconData icon;
//   Function onPressed;
//   Widget build(BuildContext context) {
//     return RawMaterialButton(
//       child: Icon(icon),
//       onPressed: onPressed,
//       elevation: 6.0,
//       constraints: BoxConstraints.tightFor(
//         width: 52.0,
//         height: 52.0,
//       ),
//       shape: CircleBorder(),
//       fillColor: Color(0xFF4C4F5E),
//     );
//   }
// }

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
