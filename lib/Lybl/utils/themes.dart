//This files manages the themes of the app

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Color purpleColor = Color(0xff5843BE);
Color orangeColor = Color(0xffFF9376);
Color blackColor = Color(0xff000000);
Color whiteColor = Color(0xffFFFFFF);
Color greyColor = Color(0xff82868E);
Color softpurpleColor = Color(0xff9FAEFB);
double edge = 16;
final asLightTheme = _buildLightTheme();
final asDarkTheme = _buildDarkTheme();

ThemeData _buildLightTheme() {
  const Color primaryColor = Color(0xFF470223);
  const Color secondaryColor = Color(0xFF470223);
  final ColorScheme colorScheme = const ColorScheme.light().copyWith(
    primary: primaryColor,
    secondary: secondaryColor,
  );
  final ThemeData base = ThemeData(
    brightness: Brightness.light,
    accentColorBrightness: Brightness.dark,
    colorScheme: colorScheme,
    primaryColor: primaryColor,
    buttonColor: primaryColor,
    indicatorColor: Colors.white,
    toggleableActiveColor: Colors.blue,
    splashColor: Colors.white24,
    splashFactory: InkRipple.splashFactory,
    accentColor: secondaryColor,
    canvasColor: Colors.white,
    scaffoldBackgroundColor: Colors.white,
    backgroundColor: Colors.white,
    errorColor: const Color(0xFFB00020),
    buttonTheme: ButtonThemeData(
      colorScheme: colorScheme,
      textTheme: ButtonTextTheme.primary,
    ),
  );
  return base.copyWith(
    textTheme: base.textTheme,
    primaryTextTheme: base.primaryTextTheme,
    accentTextTheme: base.accentTextTheme,
  );
}

TextStyle softpurpleColorTextStyle = GoogleFonts.roboto(
  fontWeight: FontWeight.w400,
  color: softpurpleColor,
);

TextStyle blackTextStyle = GoogleFonts.roboto(
  fontWeight: FontWeight.w500,
  color: blackColor,
);

TextStyle whiteTextStyle = GoogleFonts.roboto(
  fontWeight: FontWeight.w500,
  color: whiteColor,
);

TextStyle greyTextStyle = GoogleFonts.roboto(
  fontWeight: FontWeight.w500,
  color: greyColor,
);
TextStyle regularTextStyle = GoogleFonts.roboto(
  fontWeight: FontWeight.w400,
  color: blackColor,
);
TextStyle purpleTextStyle = GoogleFonts.roboto(
  fontWeight: FontWeight.w500,
  color: purpleColor,
);
ThemeData _buildDarkTheme() {
  const Color primaryColor = Colors.grey;
  const Color secondaryColor = Colors.black;
  final ColorScheme colorScheme = const ColorScheme.dark().copyWith(
    primary: primaryColor,
    secondary: secondaryColor,
  );
  final ThemeData base = ThemeData(
    brightness: Brightness.dark,
    accentColorBrightness: Brightness.dark,
    //primaryColor: primaryColor,
    //primaryColorDark: Colors.grey,
    //primaryColorLight: secondaryColor,
    buttonColor: primaryColor,
    indicatorColor: Colors.white,
    toggleableActiveColor: const Color(0xFFfafafa),
    accentColor: secondaryColor,
    canvasColor: const Color(0xFF202124),
    scaffoldBackgroundColor: const Color(0xFF202124),
    backgroundColor: const Color(0xFF202124),
    errorColor: const Color(0xFFB00020),
    buttonTheme: ButtonThemeData(
      colorScheme: colorScheme,
      textTheme: ButtonTextTheme.primary,
    ),
  );
  return base.copyWith(
    textTheme: base.textTheme,
    primaryTextTheme: base.primaryTextTheme,
    accentTextTheme: base.accentTextTheme,
  );
}
