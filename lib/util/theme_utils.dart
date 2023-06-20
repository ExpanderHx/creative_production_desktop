

import 'dart:ui';

import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ThemeUtils{

  static Color getThemeColor(BuildContext context,{Color defaultLightColor = Colors.white,Color defaultBlackColor = Colors.black}){
    return AdaptiveTheme.maybeOf(context)?.brightness == Brightness.light ? defaultLightColor : defaultBlackColor;
  }

}