import 'package:flutter/material.dart';
import 'package:nexplore/gen/colors.gen.dart';
import 'package:nexplore/gen/fonts.gen.dart';

class TextStyles {
  static TextStyle get title => TextStyle(
      fontSize: 16,
      fontFamily: FontFamily.merriweatherBlack,
      color: ColorName.titleColor);

  static TextStyle get seeAll => TextStyle(
      fontSize: 10,
      color: ColorName.borderColor,
      fontFamily: FontFamily.merriweather);

  static TextStyle get nowShowing => TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
      fontFamily: FontFamily.merriweather);

  static TextStyle get popular => TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
      fontFamily: FontFamily.merriweather);

  static TextStyle get movieName => TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.bold,
      fontFamily: FontFamily.merriweather);

  static TextStyle get movieTitleName => TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      fontFamily: FontFamily.merriweather);

  static TextStyle get movieRate => TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.normal,
      fontFamily: FontFamily.merriweather);

  static TextStyle get movieDate => TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.normal,
      color: ColorName.blackColor,
      fontFamily: FontFamily.merriweather);

  static TextStyle get tags => TextStyle(
      fontSize: 10,
      fontWeight: FontWeight.bold,
      fontFamily: FontFamily.merriweather);

  static TextStyle get description => TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.normal,
      color: ColorName.titleColor,
      fontFamily: FontFamily.merriweather);

  static TextStyle get commonItem => TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.normal,
      color: ColorName.grey9Color,
      fontFamily: FontFamily.merriweather);

  static TextStyle get castName => TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.normal,
      color: ColorName.titleColor,
      fontFamily: FontFamily.merriweather);
}
