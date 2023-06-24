

import 'dart:ui';

import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ThemeUtils{

  static Color getThemeColor(BuildContext context,{Color lightColor = Colors.white,Color blackColor = Colors.black}){
    return AdaptiveTheme.maybeOf(context)?.brightness == Brightness.light ? lightColor : blackColor;
  }

  static Color getFontThemeColor(BuildContext context,{Color lightColor = Colors.black,Color blackColor = Colors.white}){
    return AdaptiveTheme.maybeOf(context)?.brightness == Brightness.light ? lightColor : blackColor;
  }

  static Color getBackgroundThemeColor(BuildContext context,{Color lightColor = Colors.black,Color blackColor = Colors.white}){
    return AdaptiveTheme.maybeOf(context)?.brightness == Brightness.light ? lightColor : blackColor;
  }


}