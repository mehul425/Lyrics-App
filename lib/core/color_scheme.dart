import 'package:flutter/material.dart';
import 'package:juna_bhajan/core/app_colors.dart';

extension CustomColorScheme on ColorScheme {
  Color get baseColor =>
      brightness == Brightness.light ? AppColor.white : AppColor.black;

  Color get baseLightColor => brightness == Brightness.light
      ? AppColor.whiteLight
      : AppColor.blackLight;

  Color get crossColor =>
      brightness == Brightness.light ? AppColor.black : AppColor.white;

  Color get crossLightColor => brightness == Brightness.light
      ? AppColor.blackLight
      : AppColor.whiteLight;

  Color get shimmerBaseColor => brightness == Brightness.light
      ? AppColor.whiteLight
      : AppColor.blackLight;

  Color get backgroundLight => brightness == Brightness.light
      ? const Color(0xFFF1F1F1)
      : const Color(0xFF434343);

  Color get shimmerHighlightColor => brightness == Brightness.light
      ? const Color(0xffececec)
      : const Color(0xff858585);

  Color get success => brightness == Brightness.light
      ? AppColor.lightSuccess
      : AppColor.darkSuccess;

  Color get iconColor => brightness == Brightness.light
      ? AppColor.blackLight
      : AppColor.whiteLight;

  Color get filterDropDown => brightness == Brightness.light
      ? AppColor.lightFilterDropDown
      : AppColor.darkFilterDropDown;

  Color get backgroundColor => brightness == Brightness.light
      ? AppColor.lightBackground
      : AppColor.darkBackground;
}
