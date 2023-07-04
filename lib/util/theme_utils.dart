

import 'dart:ui';

import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../page/skin/config/skin_data.dart';

class ThemeUtils{

  static Color getThemeColor(BuildContext context,{Color lightColor = Colors.white,Color blackColor = Colors.black}){
    return AdaptiveTheme.maybeOf(context)?.brightness == Brightness.light ? lightColor : blackColor;
  }

  static Color? getThemeColorNotMandatory(BuildContext context,{Color? lightColor = Colors.white,Color? blackColor = Colors.black}){
    return AdaptiveTheme.maybeOf(context)?.brightness == Brightness.light ? lightColor : blackColor;
  }

  static Color getFontThemeColor(BuildContext context,{Color lightColor = Colors.black,Color blackColor = Colors.white}){
    return AdaptiveTheme.maybeOf(context)?.brightness == Brightness.light ? lightColor : blackColor;
  }

  static Color getBackgroundThemeColor(BuildContext context,{Color lightColor = Colors.black,Color blackColor = Colors.white}){
    return AdaptiveTheme.maybeOf(context)?.brightness == Brightness.light ? lightColor : blackColor;
  }

  static ThemeData defaultThemeData(ThemeData theme){
    if(theme.brightness == Brightness.light){
      theme = theme.copyWith(
        scaffoldBackgroundColor:FlexThemeData.light(fontFamily: "Ping Fang",useMaterial3: true,scheme:FlexScheme.flutterDash).scaffoldBackgroundColor,
        textTheme: FlexThemeData.light(fontFamily: "Ping Fang",useMaterial3: true,scheme:FlexScheme.flutterDash).textTheme
      );
    }else if(theme.brightness == Brightness.dark){
      theme = theme.copyWith(
        scaffoldBackgroundColor:FlexThemeData.dark(fontFamily: "Ping Fang",useMaterial3: true,scheme:FlexScheme.flutterDash).scaffoldBackgroundColor,
        textTheme: FlexThemeData.dark(fontFamily: "Ping Fang",useMaterial3: true,scheme:FlexScheme.flutterDash).textTheme
      );
    }
    return theme;
  }

  static Color? getGobalSkinDataThemeColor(BuildContext context,{Color lightColor = Colors.white,Color blackColor = Colors.black,SkinData? gobalSkinData,Color? imageBackgroundColor}){
    if(null!=gobalSkinData){
      if(null!=gobalSkinData.type&&gobalSkinData.type!=0){
        return imageBackgroundColor;
      }
    }
    return AdaptiveTheme.maybeOf(context)?.brightness == Brightness.light ? lightColor : blackColor;
  }


  static ThemeData skinThemeDataHandle(ThemeData theme,SkinData? gobalSkinData){
    if(null!=gobalSkinData){
      if(null!=gobalSkinData.type){
        if(gobalSkinData.type==1||gobalSkinData.type==2){
          theme = theme.copyWith(scaffoldBackgroundColor:Colors.transparent);
        }
      }
      if(theme.brightness == Brightness.light){
        if(null!=gobalSkinData.lightFontColor){
          theme = theme.copyWith(
              textTheme:theme.textTheme.copyWith(
                bodyLarge: TextStyle(color: Color(gobalSkinData.lightFontColor!)),
                bodyMedium: TextStyle(color: Color(gobalSkinData.lightFontColor!)),
                bodySmall: TextStyle(color: Color(gobalSkinData.lightFontColor!)),
                titleMedium: TextStyle(color: Color(gobalSkinData.lightFontColor!)),
                labelLarge: TextStyle(color: Color(gobalSkinData.lightFontColor!)),
                labelMedium: TextStyle(color: Color(gobalSkinData.lightFontColor!)),
                labelSmall: TextStyle(color: Color(gobalSkinData.lightFontColor!)),
                // bodySmall: TextStyle(color: Colors.deepOrange),
                // titleLarge: TextStyle(color: Colors.deepOrange),
                // titleMedium: TextStyle(color: Colors.deepOrange),
                // titleSmall: TextStyle(color: Colors.deepOrange),
              ),
              inputDecorationTheme: InputDecorationTheme(
                labelStyle: TextStyle(color: Color(gobalSkinData.lightFontColor!)),
              )
          );
        }
      }else if(theme.brightness == Brightness.dark){
        if(null!=gobalSkinData.darkFontColor){
          theme = theme.copyWith(
              textTheme:theme.textTheme.copyWith(
                bodyLarge: TextStyle(color: Color(gobalSkinData.darkFontColor!)),
                bodyMedium: TextStyle(color: Color(gobalSkinData.darkFontColor!)),
                bodySmall: TextStyle(color: Color(gobalSkinData.darkFontColor!)),
                titleMedium: TextStyle(color: Color(gobalSkinData.darkFontColor!)),
                labelLarge: TextStyle(color: Color(gobalSkinData.darkFontColor!)),
                labelMedium: TextStyle(color: Color(gobalSkinData.darkFontColor!)),
                labelSmall: TextStyle(color: Color(gobalSkinData.darkFontColor!)),
                // bodySmall: TextStyle(color: Colors.deepOrange),
                // titleLarge: TextStyle(color: Colors.deepOrange),
                // titleMedium: TextStyle(color: Colors.deepOrange),
                // titleSmall: TextStyle(color: Colors.deepOrange),
              ),
              inputDecorationTheme: InputDecorationTheme(
                labelStyle: TextStyle(color: Color(gobalSkinData.darkFontColor!)),
              )
          );
        }

      }
    }

    return theme;
  }


  static ThemeData lightDefaultThemeData(ThemeData theme){
    theme = theme.copyWith(
        scaffoldBackgroundColor:FlexThemeData.light(fontFamily: "Ping Fang",useMaterial3: true,scheme:FlexScheme.flutterDash).scaffoldBackgroundColor,
        // textTheme: FlexThemeData.light(fontFamily: "Ping Fang",useMaterial3: true,scheme:FlexScheme.flutterDash).textTheme
    );
    return theme;
  }

  static ThemeData darkDefaultThemeData(ThemeData theme){
    theme = theme.copyWith(
        // scaffoldBackgroundColor:FlexThemeData.dark(fontFamily: "Ping Fang",useMaterial3: true,scheme:FlexScheme.flutterDash).scaffoldBackgroundColor,
        // textTheme: FlexThemeData.dark(fontFamily: "Ping Fang",useMaterial3: true,scheme:FlexScheme.flutterDash).textTheme
    );
    return theme;
  }


}