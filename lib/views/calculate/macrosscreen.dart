import 'package:fittrack/Provider/homepageprovider.dart';
import 'package:fittrack/constants/AppPages.dart';
import 'package:fittrack/constants/uiconstants.dart';
import 'package:fittrack/model/calculator/dailycaloryrequirements.dart';
import 'package:fittrack/model/calculator/macrosamounts.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';

class MacrosScreen extends StatefulWidget {
  @override
  _MacrosScreenState createState() => _MacrosScreenState();
}

class _MacrosScreenState extends State<MacrosScreen> {
  int height = 180;
  int age = 40;
  int wt = 100;
  Gender selectedGender = Gender.male;
  String? gender = "male";
  String activityLevel = "1";
  String goal = "maintain";
  late MacrosData data;
   late BannerAd _bannerAd;
  bool _isAdLoaded = false;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback(
      (duration) {
        Provider.of<HomePageProvider>(context, listen: false).get();
      },
    );
    Balanced bal = Balanced(carbs: 0, fat: 0, protein: 0);
    Highprotein hi = Highprotein(carbs: 0, fat: 0, protein: 0);
    Lowcarbs lo = Lowcarbs(carbs: 0, fat: 0, protein: 0);
    Lowfat lf = Lowfat(carbs: 0, fat: 0, protein: 0);
    this.data = MacrosData(
      calorie: 0,
      balanced: bal,
      highprotein: hi,
      lowcarbs: lo,
      lowfat: lf,
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
                      tag: "assets/macros.png",
                      child: Container(
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                            image: DecorationImage(
                                image: AssetImage("assets/macros.png",),
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
                        'Daily Chalory Requirement',
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
                                'Knowing your daily calorie requirements is important to achieve your final goal. You can calculate your daily calorie req. for 6 different goals.',
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
                              wt = value.round();
                            });
                          })),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                    ),
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                            child: Text.rich(TextSpan(
                                text: 'Select weekly excercise you perform',
                                style: Theme.of(context)
                                    .primaryTextTheme
                                    .subtitle1!
                                    .copyWith(
                                        fontSize: 16,
                                        color: const Color(0xFF028AB5),
                                        fontWeight: FontWeight.bold))),
                          ),
                          Container(
                            child: ReuseableCard2(
                              onPress: () {
                                setState(() {
                                  activityLevel = "1";
                                });
                              },
                              colour: (activityLevel == "1")
                                  ? kactiveboxcolor
                                  : kinactiveboxcolor,
                              text: 'BMR',
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            child: ReuseableCard2(
                              onPress: () {
                                setState(() {
                                  activityLevel = "2";
                                });
                              },
                              colour: (activityLevel == "2")
                                  ? kactiveboxcolor
                                  : kinactiveboxcolor,
                              text: 'Sedentary: little or no exercise',
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            child: ReuseableCard2(
                              onPress: () {
                                setState(() {
                                  activityLevel = "3";
                                });
                              },
                              colour: (activityLevel == "3")
                                  ? kactiveboxcolor
                                  : kinactiveboxcolor,
                              text: 'Exercise 1-3 times/week',
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            child: ReuseableCard2(
                              onPress: () {
                                setState(() {
                                  activityLevel = "4";
                                });
                              },
                              colour: (activityLevel == "4")
                                  ? kactiveboxcolor
                                  : kinactiveboxcolor,
                              text: 'Exercise 4-5 times/week',
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            child: ReuseableCard2(
                              onPress: () {
                                setState(() {
                                  activityLevel = "5";
                                });
                              },
                              colour: (activityLevel == "5")
                                  ? kactiveboxcolor
                                  : kinactiveboxcolor,
                              text:
                                  'Daily exercise or intense exercise \n3-4 times/week',
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            child: ReuseableCard2(
                              onPress: () {
                                setState(() {
                                  activityLevel = "6";
                                });
                              },
                              colour: (activityLevel == "6")
                                  ? kactiveboxcolor
                                  : kinactiveboxcolor,
                              text: 'Intense exercise 6-7 times/week',
                            ),
                          ),
                          const SizedBox(
                        height: 10,
                      ),
                          Container(
                            child: ReuseableCard2(
                              onPress: () {
                                setState(() {
                                  activityLevel = "7";
                                });
                              },
                              colour: (activityLevel == "7")
                                  ? kactiveboxcolor
                                  : kinactiveboxcolor,
                              text:
                                  'Very intense exercise daily, or physical job',
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                    ),
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                            child: Text.rich(TextSpan(
                                text: 'Select goal ',
                                style: Theme.of(context)
                                    .primaryTextTheme
                                    .subtitle1!
                                    .copyWith(
                                        fontSize: 16,
                                        color: const Color(0xFF028AB5),
                                        fontWeight: FontWeight.bold))),
                          ),
                          Container(
                            child: ReuseableCard2(
                              onPress: () {
                                setState(() {
                                  goal = "maintain";
                                });
                              },
                              colour: (goal == "maintain")
                                  ? kactiveboxcolor
                                  : kinactiveboxcolor,
                              text: 'maintain weight',
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            child: ReuseableCard2(
                              onPress: () {
                                setState(() {
                                  goal = "mildlose";
                                });
                              },
                              colour: (goal == "mildlose")
                                  ? kactiveboxcolor
                                  : kinactiveboxcolor,
                              text: 'Mild weight loss',
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            child: ReuseableCard2(
                              onPress: () {
                                setState(() {
                                  goal = "weightlose";
                                });
                              },
                              colour: (goal == "weightlose")
                                  ? kactiveboxcolor
                                  : kinactiveboxcolor,
                              text: 'Weight loss',
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            child: ReuseableCard2(
                              onPress: () {
                                setState(() {
                                  goal = "extremelose";
                                });
                              },
                              colour: (goal == "extremelose")
                                  ? kactiveboxcolor
                                  : kinactiveboxcolor,
                              text: 'Extreme weight loss',
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            child: ReuseableCard2(
                              onPress: () {
                                setState(() {
                                  goal = "mildgain";
                                });
                              },
                              colour: (goal == "mildgain")
                                  ? kactiveboxcolor
                                  : kinactiveboxcolor,
                              text: 'Mild weight gain',
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            child: ReuseableCard2(
                              onPress: () {
                                setState(() {
                                  goal = "weightgain";
                                });
                              },
                              colour: (goal == "weightgain")
                                  ? kactiveboxcolor
                                  : kinactiveboxcolor,
                              text: 'Weight gain',
                            ),
                          ),
                          const SizedBox(
                        height: 10,
                      ),
                          Container(
                            child: ReuseableCard2(
                              onPress: () {
                                setState(() {
                                  goal = "extremegain";
                                });
                              },
                              colour: (goal == "extremegain")
                                  ? kactiveboxcolor
                                  : kinactiveboxcolor,
                              text: 'Extreme weight gain',
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        data = await HomePageProvider.macrosdata(
                            age.toString(),
                            gender,
                            height.toString(),
                            wt.toString(),
                            activityLevel,
                            goal);
                      },
                      child: Text('Calculate'),
                      style: ElevatedButton.styleFrom(
                          primary: const Color(0xFF1FB5E4))),
                  const SizedBox(
                    height: 15,
                  ),
                  (data.calorie < 30)
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
                                          'The daily chalorie requirement is shown bolow as per goals',
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
                                      optionWidget(context, 'Calorie',
                                          '${data.calorie.toStringAsFixed(2)} calories'),
                                      const Divider(
                                        color: Color(0xFF006484),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                     optionWidget1(context, 'Balanced','Protien','Fat','Carbs',data.balanced.protein,data.balanced.fat,data.balanced.carbs),
                                      const Divider(
                                        color: Color(0xFF006484),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      optionWidget1(context, 'Lowfat','Protien','Fat','Carbs',data.lowfat.protein,data.lowfat.fat,data.lowfat.carbs),
                                      const Divider(
                                        color: Color(0xFF006484),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      optionWidget1(context, 'Lowcarbs','Protien','Fat','Carbs',data.lowcarbs.protein,data.lowcarbs.fat,data.lowcarbs.carbs),
                                      const Divider(
                                        color: Color(0xFF006484),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                       optionWidget1(context, 'Highprotien','Protien','Fat','Carbs',data.highprotein.protein,data.highprotein.fat,data.highprotein.carbs),
                                      const Divider(
                                        color: Color(0xFF006484),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                     
                                    ],
                                  ),
                                ),
                              ])),
                  const SizedBox(
                    height: 45,
                  )
                ],
              ),
            ),
          ],
        );
      }),
    );
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

class ReuseableCard2 extends StatelessWidget {
  ReuseableCard2({this.onPress, required this.colour, required this.text});
  final Color colour;
  final onPress;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: onPress,
          child: Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              color: colour,
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
        ),
        SizedBox(width: 10),
        Text.rich(TextSpan(
            text: '${text}',
            style: Theme.of(context).primaryTextTheme.subtitle1!.copyWith(
                fontSize: 14,
                color: Color(0xFF006484),
                fontWeight: FontWeight.normal))),
      ],
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
        const SizedBox(
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
        style: Theme.of(context).primaryTextTheme.subtitle1!.copyWith(
                    fontSize: 18,
                    color: Color(0xFF006484),
                    fontWeight: FontWeight.bold)),
  
      Spacer(),
      Flexible(
          child: Align(
              alignment: Alignment.centerRight,
              child: Text(name1,
                  style: Theme.of(context).primaryTextTheme.subtitle1))),
    ],
  );
}

Widget optionWidget1(BuildContext context, String name, String name1,
    String name2, String name3, double protien, double fat, double carbs) {
  return Column(
    children: [
      Row(
        children: [
          Center(
            child: Text('${name}',
                style: Theme.of(context).primaryTextTheme.subtitle1!.copyWith(
                    fontSize: 18,
                    color: Color(0xFF006484),
                    fontWeight: FontWeight.bold)),
          ),
        ]
      ),
          SizedBox(height: 10),
          Row(
            children: [
              Text(
                name1,
                style: Theme.of(context).primaryTextTheme.subtitle1,
              ),
              Spacer(),
              Text('${protien.toStringAsFixed(2)} calories',
                  style:
                      Theme.of(context).primaryTextTheme.subtitle1),
            ],
          ),
          SizedBox(height: 10),
          Row(
            children: [
              Text(
                name2,
                style: Theme.of(context).primaryTextTheme.subtitle1,
              ),
              Spacer(),
              Text('${fat.toStringAsFixed(2)} calories',
                  style:
                      Theme.of(context).primaryTextTheme.subtitle1),
            ],
          ),
           SizedBox(height: 10),
           Row(
            children: [
              Text(
                name3,
                style: Theme.of(context).primaryTextTheme.subtitle1,
              ),
              Spacer(),
              Text('${carbs.toStringAsFixed(2)} calories',
                  style:
                      Theme.of(context).primaryTextTheme.subtitle1),
            ],
          ),
       
        ],
      
  );
}
