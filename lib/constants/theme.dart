import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ThemeClass {
  static ThemeData buildTheme(BuildContext context) {
    ThemeData themeData = ThemeData(
      primaryColor: const Color(0xFF1FB5E4),
      visualDensity: VisualDensity.adaptivePlatformDensity,
      scaffoldBackgroundColor: const Color(0xffFAFAFA),
      appBarTheme: const AppBarTheme(
        elevation: 0.0,
        color: Color(0xFF1FB5E4),
        iconTheme: IconThemeData(color: Colors.white),
        actionsIconTheme: IconThemeData(color: Colors.grey),
      ),
      bottomAppBarTheme: const BottomAppBarTheme(
        elevation: 0.0,
        color: Color(0xFF1FB5E4),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Color(0xFF1FB5E4)),
      cupertinoOverrideTheme:
          const CupertinoThemeData(brightness: Brightness.dark),
      primaryTextTheme:
          GoogleFonts.robotoTextTheme(Theme.of(context).textTheme).copyWith(
              headline1: GoogleFonts.roboto(
                  color:  Colors.white,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.normal,fontSize:40),
              headline2: GoogleFonts.roboto(
                  color:  const Color(0xFF028AB5),
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.normal,fontSize:36),
              headline3: GoogleFonts.roboto(
                  color:  Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                  fontStyle: FontStyle.normal),
              headline4: GoogleFonts.roboto(
                  color:  Colors.white,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.normal,
                  fontSize: 27),
              headline5: GoogleFonts.roboto(
                  color:  Colors.white,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.normal,
                  fontSize: 18),
              headline6: GoogleFonts.nunitoSans(
                  color:  Colors.white,
                  fontWeight: FontWeight.normal,
                  fontStyle: FontStyle.normal,
                  fontSize: 14),
              subtitle1: GoogleFonts.nunitoSans(
                  color: const Color(0xFF028AB5),
                  fontWeight: FontWeight.normal,
                  fontStyle: FontStyle.normal,fontSize: 14),
              subtitle2: GoogleFonts.nunitoSans(
                color: const Color(0xFF028AB5),
                fontWeight: FontWeight.normal,
                fontStyle: FontStyle.normal,
                fontSize: 12,
              ),
              caption: GoogleFonts.nunitoSans(
                  color: const Color(0xffFFFFFF),
                  fontWeight: FontWeight.normal,
                  fontStyle: FontStyle.normal,
                  letterSpacing: -0.32),
              overline: GoogleFonts.nunitoSans(
                color: const Color(0xffFFFFFF),
                fontWeight: FontWeight.normal,
                fontStyle: FontStyle.normal,
              ),
              button: GoogleFonts.nunitoSans(
                  color: Colors.white,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  letterSpacing: 1.25)),
      buttonTheme: ButtonThemeData(
        buttonColor: const Color(0xFF1FB5E4),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      ),
    );
    return themeData;
  }
}
