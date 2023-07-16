


import 'dart:io';

import 'package:creative_production_desktop/util/preferences_util.dart';
import 'package:creative_production_desktop/util/service_util.dart';
import 'package:creative_production_desktop/util/talker_utils.dart';
import 'package:isar/isar.dart';
import 'package:launch_at_startup/launch_at_startup.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:talker_flutter/talker_flutter.dart';

import '../config/const_app.dart';
import '../network/chat/chat_gpt_open_ai.dart';
import '../network/chat/chat_gpt_sdk/src/model/client/http_setup.dart';
import '../network/chat/config/chat_config.dart';
import '../page/model_config/bean/chat_model_config.dart';
import 'db/isar_db_util.dart';

class InitUtils{

  // static final talker = TalkerFlutter.init();

  static Future<void> init() async{
    await PreferencesUtil.perInit();
    int? isInit = PreferencesUtil().get(ConstApp.isInitKey);
    if(isInit==null){
      // 初次启动设置开机自启动
      await setSelfStartUponStartup();
    }

    await initChatApiOpenAi();

    TalkerUtils.initTalker();
  }

  static Future<void> initChatApiOpenAi() async{
    List<ChatModelConfig>? chatModelConfigList = await IsarDBUtil().isar!.chatModelConfigs.where().findAll();
    if(null!=chatModelConfigList&&chatModelConfigList.length>0){
      ChatModelConfig? chatModelDefaultConfig = null;
      for(var i=0;i<chatModelConfigList.length;i++){
        if(null!=chatModelConfigList[i].configName&&chatModelConfigList[i].configName == ChatConfig.openaiKeyName){
          chatModelDefaultConfig = chatModelConfigList[i];
        }else if(null!=chatModelConfigList[i].token&&chatModelConfigList[i].token!.trim().length>0){
          chatModelDefaultConfig ??= chatModelConfigList[i];
        }
      }
      if(null!=chatModelDefaultConfig){
        ChatApiOpenAi().build(
            chatModelDefaultConfig?.token,
            baseOption: HttpSetup(
                receiveTimeout: const Duration(seconds: 120),
                baseUrl: chatModelDefaultConfig!.baseUrl??ChatConfig.chatGeneralBaseUrl
            ),
            enableLog: true,
            activeChatModelConfig: chatModelDefaultConfig
        );
      }

    }
  }

  static Future<void> setSelfStartUponStartup() async{
    // 设置开机自启动
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    launchAtStartup.setup(
      appName: packageInfo.appName,
      appPath: Platform.resolvedExecutable,
    );
    await launchAtStartup.enable();

    bool isEnabled = await launchAtStartup.isEnabled();
    print("isEnabled : ${isEnabled}");
  }

  static void initServiceProjectPath(){
    // 获取serviceProjectPath
    String? servicePath = ServiceUtil.getServicePath();
    if(null!=servicePath){
      PreferencesUtil().setString(ConstApp.servicePathKey, servicePath);
    }
  }

}