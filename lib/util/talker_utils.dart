
import 'package:bot_toast/bot_toast.dart';
import 'package:creative_production_desktop/utilities/language_util.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:talker_dio_logger/talker_dio_logger_interceptor.dart';
import 'package:talker_dio_logger/talker_dio_logger_settings.dart';
import 'package:talker_flutter/talker_flutter.dart';

class TalkerUtils{

  static Talker? talker ;

  static Talker? initTalker(){
    try{
      talker ??= TalkerFlutter.init();
    }catch(e){
      print(e);
    }
    return talker;
  }

  static dioAddTalkerDioLogger(Dio? dio){
    initTalker();
    if(null!=dio){
      if(null!=talker){
        dio.interceptors.add(
          TalkerDioLogger(
            talker: talker,
            settings: const TalkerDioLoggerSettings(
              printRequestHeaders: true,
              printResponseHeaders: true,
            ),
          ),
        );
      }
    }
  }

  static void toTalkerScreen(BuildContext context){
    initTalker();
    if(null!=talker){
      Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => TalkerScreen(talker: talker!),
          )
      );
    }else{
      BotToast.showText(text: "${'logging_exception'.tr()}");
    }

  }

  static void handle(e,st){

    // 处理异常和错误 示例
    // try {
    //   throw Exception('The restaurant is closed ❌');
    // } catch (e, st) {
    //   talker.handle(e, st);
    // }

    initTalker();
    if(null!=talker){
      talker!.handle(e, st);
    }else{
      print( "${'logging_exception'.tr()}");
      // BotToast.showText(text: "${'logging_exception'.tr()}");
    }

  }





}