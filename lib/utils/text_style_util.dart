import 'package:build_todo/configs/theme.dart';
import 'package:flutter/material.dart';

class TextStyleUtil {
  TextStyleUtil._();

  //home_title
  static TextStyle heading({Color color = null, double fontSize = null, FontWeight fontWeight = null}) {
    //return TextStyle(color: (color == null) ? COLOR_TEXT_DEFAULT : color, fontSize: 20.0, fontWeight: FontWeight.bold);
    return TextStyle(
        color: (color == null) ? COLOR_TEXT_DEFAULT : color, fontSize: (fontSize == null) ? FONT_20 : fontSize, fontWeight: (fontWeight == null) ? FONT_BOLD : fontWeight);
  }

  //home_subtitle
  static TextStyle subHeading({Color color = null, double fontSize = null, FontWeight fontWeight = null}) {
    //return TextStyle(color: (color == null) ? COLOR_TEXT_DEFAULT : color, fontSize: 16.0, fontWeight: FontWeight.w300);
    return TextStyle(
        color: (color == null) ? COLOR_TEXT_DEFAULT : color, fontSize: (fontSize == null) ? FONT_16 : fontSize, fontWeight: (fontWeight == null) ? FONT_300 : fontWeight);
  }

  //event_card_title
  static TextStyle listHeading({Color color = null, double fontSize = null, FontWeight fontWeight = null}) {
    //return TextStyle(color: (color == null) ? COLOR_TEXT_DEFAULT : color, fontSize: 15.0, fontWeight: FontWeight.bold);
    return TextStyle(
        color: (color == null) ? COLOR_TEXT_DEFAULT : color, fontSize: (fontSize == null) ? FONT_15 : fontSize, fontWeight: (fontWeight == null) ? FONT_BOLD : fontWeight);
  }

  //event_card_subtitle
  static TextStyle listSubHeading({Color color = null, double fontSize = null, FontWeight fontWeight = null}) {
    //return TextStyle(color: (color == null) ? COLOR_TEXT_DEFAULT : color, fontSize: 15.0, fontWeight: FontWeight.w300);
    return TextStyle(
        color: (color == null) ? COLOR_TEXT_DEFAULT : color, fontSize: (fontSize == null) ? FONT_15 : fontSize, fontWeight: (fontWeight == null) ? FONT_300 : fontWeight);
  }

  static TextStyle listTitle({Color color = null, double fontSize = null, FontWeight fontWeight = null}) {
    //return TextStyle(color: (color == null) ? COLOR_TEXT_DEFAULT : color, fontSize: 15.0, fontWeight: FontWeight.w500);
    return TextStyle(
        color: (color == null) ? COLOR_TEXT_DEFAULT : color, fontSize: (fontSize == null) ? FONT_15 : fontSize, fontWeight: (fontWeight == null) ? FONT_500 : fontWeight);
  }

  static TextStyle listSubTitle({Color color = null, double fontSize = null, FontWeight fontWeight = null}) {
    //return TextStyle(color: (color == null) ? COLOR_TEXT_DEFAULT : color, fontSize: 11.0, fontWeight: FontWeight.w300);
    return TextStyle(
        color: (color == null) ? COLOR_TEXT_DEFAULT : color, fontSize: (fontSize == null) ? FONT_11 : fontSize, fontWeight: (fontWeight == null) ? FONT_300 : fontWeight);
  }

  //text_default
  static TextStyle textDefault({Color color = null, double fontSize = null, FontWeight fontWeight = null, double height = null}) {
    //return TextStyle(color: (color == null) ? COLOR_TEXT_DEFAULT : color, fontSize: 13.0, fontWeight: FontWeight.w500);
    return TextStyle(
        color: (color == null) ? COLOR_TEXT_DEFAULT : color,
        fontSize: (fontSize == null) ? FONT_13 : fontSize,
        fontWeight: (fontWeight == null) ? FONT_500 : fontWeight,
        height: (height == null) ? 1.0 : height);
  }

  //link_text_default
  static TextStyle linkTextDefault({Color color = null, double fontSize = null, FontWeight fontWeight = null}) {
    return TextStyle(
      color: (color == null) ? Colors.blue : color,
      fontSize: (fontSize == null) ? FONT_13 : fontSize,
      fontWeight: (fontWeight == null) ? FONT_500 : fontWeight,
      decoration: TextDecoration.underline,
    );
  }

  //button_text_default
  static TextStyle enabledBtnText1({Color color = null, double fontSize = null, FontWeight fontWeight = null}) {
    //return TextStyle(color: (color == null) ? Colors.white : color, fontSize: 13.0, fontWeight: FontWeight.w500);
    return TextStyle(color: (color == null) ? COLOR_WHITE : color, fontSize: (fontSize == null) ? FONT_13 : fontSize, fontWeight: (fontWeight == null) ? FONT_500 : fontWeight);
  }

  static TextStyle enabledBtnText2({Color color = null, double fontSize = null, FontWeight fontWeight = null}) {
    //return TextStyle(color: (color == null) ? Colors.white : color, fontSize: 13.0, fontWeight: FontWeight.w300);
    return TextStyle(color: (color == null) ? COLOR_WHITE : color, fontSize: (fontSize == null) ? FONT_13 : fontSize, fontWeight: (fontWeight == null) ? FONT_300 : fontWeight);
  }

  static TextStyle disabledBtnText1({Color color = null, double fontSize = null, FontWeight fontWeight = null}) {
    //return TextStyle(color: (color == null) ? COLOR_SPACE_SHUTTLE : color, fontSize: 13.0, fontWeight: FontWeight.w500);
    return TextStyle(
        color: (color == null) ? COLOR_SPACE_SHUTTLE : color, fontSize: (fontSize == null) ? FONT_13 : fontSize, fontWeight: (fontWeight == null) ? FONT_500 : fontWeight);
  }

  static TextStyle disabledBtnText2({Color color = null, double fontSize = null, FontWeight fontWeight = null}) {
    //return TextStyle(color: (color == null) ? COLOR_SPACE_SHUTTLE : color, fontSize: 13.0, fontWeight: FontWeight.w300);
    return TextStyle(
        color: (color == null) ? COLOR_SPACE_SHUTTLE : color, fontSize: (fontSize == null) ? FONT_13 : fontSize, fontWeight: (fontWeight == null) ? FONT_300 : fontWeight);
  }

  static TextStyle inputLabel({Color color = null, double fontSize = null, FontWeight fontWeight = null}) {
    //return TextStyle(color: (color == null) ? COLOR_SPACE_SHUTTLE : color, fontSize: 18.0, fontWeight: FontWeight.w300);
    return TextStyle(
        color: (color == null) ? COLOR_SPACE_SHUTTLE : color, fontSize: (fontSize == null) ? FONT_18 : fontSize, fontWeight: (fontWeight == null) ? FONT_300 : fontWeight);
  }

  static TextStyle inputText({Color color = null, double fontSize = null, FontWeight fontWeight = null}) {
    //return TextStyle(color: (color == null) ? COLOR_SPACE_SHUTTLE : color, fontSize: 13.0, fontWeight: FontWeight.w300);
    return TextStyle(
        color: (color == null) ? COLOR_SPACE_SHUTTLE : color, fontSize: (fontSize == null) ? FONT_13 : fontSize, fontWeight: (fontWeight == null) ? FONT_300 : fontWeight);
  }

  static TextStyle inputHintText({Color color = null, double fontSize = null, FontWeight fontWeight = null}) {
    //return TextStyle(color: (color == null) ? COLOR_SPACE_SHUTTLE : color, fontSize: 13.0, fontWeight: FontWeight.w200);
    return TextStyle(
        color: (color == null) ? COLOR_SPACE_SHUTTLE : color, fontSize: (fontSize == null) ? FONT_13 : fontSize, fontWeight: (fontWeight == null) ? FONT_200 : fontWeight);
  }

  static TextStyle dialogTitle({Color color = null, double fontSize = null, FontWeight fontWeight = null}) {
    //return TextStyle(color: (color == null) ? COLOR_TEXT_DEFAULT : color, fontSize: 20.0, fontWeight: FontWeight.w500);
    return TextStyle(
        color: (color == null) ? COLOR_TEXT_DEFAULT : color, fontSize: (fontSize == null) ? FONT_20 : fontSize, fontWeight: (fontWeight == null) ? FONT_500 : fontWeight);
  }

  static TextStyle dialogSubTitle({Color color = null, double fontSize = null, FontWeight fontWeight = null}) {
    //return TextStyle(color: (color == null) ? COLOR_TEXT_DEFAULT : color, fontSize: 13.0, fontWeight: FontWeight.w300);
    return TextStyle(
        color: (color == null) ? COLOR_TEXT_DEFAULT : color, fontSize: (fontSize == null) ? FONT_13 : fontSize, fontWeight: (fontWeight == null) ? FONT_300 : fontWeight);
  }
}
