


import 'dart:io';

import 'package:creative_production_desktop/util/preferences_util.dart';
import 'package:creative_production_desktop/util/service_util.dart';
import 'package:launch_at_startup/launch_at_startup.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../config/const_app.dart';

class InitUtils{

  static void init(){
    PreferencesUtil.perInit().then((value) async{
      int? isInit = PreferencesUtil().get(ConstApp.isInitKey);
      if(isInit==null){
        // 初次启动设置开机自启动
        setSelfStartUponStartup();



      }
    });
  }

  static void setSelfStartUponStartup() async{
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