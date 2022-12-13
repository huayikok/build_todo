import 'package:flutter/material.dart';

// DIFF DEVICE SIZE STYLE.

// FONT FAMILY
const FONT_MONTSERRAT = 'Montserrat';

// FONT SIZE.
var FONT_6 = 6.0;
var FONT_7 = 7.0;
var FONT_8 = 8.0;
var FONT_9 = 9.0;
var FONT_10 = 10.0;
var FONT_11 = 11.0;
var FONT_12 = 12.0;
var FONT_13 = 13.0;
var FONT_14 = 14.0;
var FONT_15 = 15.0;
var FONT_16 = 16.0;
var FONT_17 = 17.0;
var FONT_18 = 18.0;
var FONT_19 = 19.0;
var FONT_20 = 20.0;

// FONT WEIGHT.
var FONT_NORMAL = FontWeight.normal;
var FONT_BOLD = FontWeight.bold;
var FONT_100 = FontWeight.w100;
var FONT_200 = FontWeight.w200;
var FONT_300 = FontWeight.w300;
var FONT_400 = FontWeight.w400;
var FONT_500 = FontWeight.w500;
var FONT_600 = FontWeight.w600;
var FONT_700 = FontWeight.w700;
var FONT_800 = FontWeight.w800;
var FONT_900 = FontWeight.w900;

// COLOR
const COLOR_WHITE = Colors.white;
const COLOR_SELECTIVE_YELLOW = Color.fromRGBO(255, 190, 35, 1.0); //#FFBE23
const COLOR_WHITE_SMOKE = Color.fromRGBO(242, 242, 242, 1.0); //#f2f2f2
const COLOR_BLACK = Color.fromRGBO(8, 8, 8, 1.0); //#080808
const COLOR_DOVE_GRAY = Color.fromRGBO(112, 112, 112, 1.0); //#707070
const COLOR_SPACE_SHUTTLE = Color.fromRGBO(72, 70, 68, 1.0); //#484644

const COLOR_SUCCESS_BG = Color.fromRGBO(213, 241, 222, 1.0); //#d5f1de
const COLOR_SUCCESS_BORDER = Color.fromRGBO(196, 235, 209, 1.0); //#c4ebd1
const COLOR_SUCCESS_TEXT = Color.fromRGBO(24, 96, 58, 1.0); //#18603a
const COLOR_WARN_BG = Color.fromRGBO(254, 239, 208, 1.0); //#feefd0
const COLOR_WARN_BORDER = Color.fromRGBO(253, 233, 189, 1.0); //#fde9bd
const COLOR_WARN_TEXT = Color.fromRGBO(129, 92, 21, 1.0); //#815c15
const COLOR_ERROR_BG = Color.fromRGBO(250, 221, 221, 1.0); //#fadddd
const COLOR_ERROR_BORDER = Color.fromRGBO(248, 207, 207, 1.0); //#f8cfcf
const COLOR_ERROR_TEXT = Color.fromRGBO(119, 43, 53, 1.0); //#772b35

final MaterialColor colorPelorous = MaterialColor(0xFF3BB8C3, getSwatch(COLOR_SELECTIVE_YELLOW)); //getSwatch(Color.fromRGBO(59, 184, 195, 1.0))); //#11FF00

// COLOR SHADE METHOD
Map<int, Color> getSwatch(Color color) {
  final hslColor = HSLColor.fromColor(color);
  final lightness = hslColor.lightness;

  /// if [500] is the default color, there are at LEAST five
  /// steps below [500]. (i.e. 400, 300, 200, 100, 50.) A
  /// divisor of 5 would mean [50] is a lightness of 1.0 or
  /// a color of #ffffff. A value of six would be near white
  /// but not quite.
  final lowDivisor = 6;

  /// if [500] is the default color, there are at LEAST four
  /// steps above [500]. A divisor of 4 would mean [900] is
  /// a lightness of 0.0 or color of #000000
  final highDivisor = 5;

  final lowStep = (1.0 - lightness) / lowDivisor;
  final highStep = lightness / highDivisor;

  return {
    50: (hslColor.withLightness(lightness + (lowStep * 5))).toColor(),
    100: (hslColor.withLightness(lightness + (lowStep * 4))).toColor(),
    200: (hslColor.withLightness(lightness + (lowStep * 3))).toColor(),
    300: (hslColor.withLightness(lightness + (lowStep * 2))).toColor(),
    400: (hslColor.withLightness(lightness + lowStep)).toColor(),
    500: (hslColor.withLightness(lightness)).toColor(),
    600: (hslColor.withLightness(lightness - highStep)).toColor(),
    700: (hslColor.withLightness(lightness - (highStep * 2))).toColor(),
    800: (hslColor.withLightness(lightness - (highStep * 3))).toColor(),
    900: (hslColor.withLightness(lightness - (highStep * 4))).toColor(),
  };
}

// CONTROL COLOR PALETTE & FONT
const FONT_DEFAULT = FONT_MONTSERRAT;
const COLOR_MAIN_DEFAULT = COLOR_SELECTIVE_YELLOW;
const COLOR_BG_DEFAULT = COLOR_WHITE_SMOKE;
const COLOR_BTN_DEFAULT = COLOR_SELECTIVE_YELLOW;
const COLOR_TEXT_DEFAULT = COLOR_BLACK;
const COLOR_SUBTEXT_DEFAULT = COLOR_DOVE_GRAY;

// TEXT STYLE

// DEFAULT THEME
const TEXT_THEME = TextTheme(
  headline1: TextStyle(fontSize: 96.0, fontWeight: FontWeight.w300, letterSpacing: -1.5),
  headline2: TextStyle(fontSize: 60.0, fontWeight: FontWeight.w300, letterSpacing: -1.5),
  headline3: TextStyle(fontSize: 48.0, fontWeight: FontWeight.w400, letterSpacing: 0.0),
  headline4: TextStyle(fontSize: 34.0, fontWeight: FontWeight.w400, letterSpacing: 0.25),
  headline5: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w400, letterSpacing: 0.0),
  headline6: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500, letterSpacing: 0.15),
  subtitle1: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w400, letterSpacing: 0.15),
  subtitle2: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w500, letterSpacing: 0.1),
  bodyText1: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500, letterSpacing: 0.5),
  bodyText2: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w400, letterSpacing: 0.25),
  button: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w500, letterSpacing: 1.25),
  caption: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w400, letterSpacing: 0.4),
  overline: TextStyle(fontSize: 10.0, fontWeight: FontWeight.w400, letterSpacing: 1.5),
);

var THEME_DATA = ThemeData(
  // brightness: Brightness.light,
  // primaryColor: colorPelorous,
  // accentColor: colorPelorous,
  primarySwatch: colorPelorous,
  textTheme: TEXT_THEME,
  // Define the default font family.
  fontFamily: FONT_DEFAULT,
  // This makes the visual density adapt to the platform that you run
  // the app on. For desktop platforms, the controls will be smaller and
  // closer together (more dense) than on mobile platforms.
  visualDensity: VisualDensity.adaptivePlatformDensity,
);
