
import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:creative_production_desktop/util/preferences_util.dart';
import 'package:creative_production_desktop/utilities/language_util.dart';
import 'package:process_run/process_run.dart';
import 'package:path/path.dart' as path;

import '../config/const_app.dart';
import '../utilities/platform_util.dart';

class ServiceUtil{

  static Shell? shell;

  static void startServce() async{

    try {
      // App的可执行文件路径
      String resolvedExecutablePath = Platform.resolvedExecutable;
      print(resolvedExecutablePath);
      String? servicePath = PreferencesUtil().get(ConstApp.servicePathKey);
      servicePath ??= await getServicePath();

      // BotToast.showText(text: "resolvedExecutablePath : ${resolvedExecutablePath}");
      if(null!=servicePath){
        // BotToast.showText(text: "servicePath : ${servicePath}");
        String serviceBatPath = path.join(servicePath! , ConstApp.serveSystemNameKey, ConstApp.startBatNameKey);
        String serviceLogPath = path.join(servicePath! , ConstApp.serveSystemNameKey, ConstApp.serviceChatLogNameKey);
        File serviceLogFile = File(serviceLogPath);
        if(serviceLogFile.existsSync()){
          serviceLogFile.delete();
        }
        if(File(serviceBatPath).existsSync()){
          var controller = ShellLinesController();
          var stderrController = ShellLinesController();
          var newShell = Shell(stdout: controller.sink,stderr: stderrController.sink);
          controller.stream.listen((event) {
            // print(event);
            if(event.toString().indexOf("service_state")==-1){
              serviceLogFile.writeAsString("$event\r\n",mode: FileMode.writeOnlyAppend,encoding: systemEncoding);
            }
          });
          stderrController.stream.listen((event) {
            // print(event);
            if(event.toString().indexOf("service_state")==-1){
              serviceLogFile.writeAsString("$event\r\n",mode: FileMode.writeOnlyAppend,encoding: systemEncoding);
            }
          });
          if(null!=newShell){
            ProcessResult result = await newShell!
                .runExecutableArguments(serviceBatPath,[]);
            // print(result);
            if (result.exitCode == 0) {
              if(null!=shell){
                shell!.kill();
              }
              shell = newShell;
              print('bat文件执行成功');
              BotToast.showText(text: "successfully_started_the_server".tr());
              print(result.stdout);
            } else {
              print('bat文件执行失败');
              BotToast.showText(text: "abnormal_startup".tr());
              print(result.stderr);
            }
          }
        }else{
          BotToast.showText(text: "service_bat_not_found".tr());
        }
      }else{
        BotToast.showText(text: "service_directory_not_found".tr());
      }
    } catch (e) {
     print(e);
    }





    // ProcessResult result = await Process.run('cmd.exe', ['/c', 'E:\pycharm\creative_production_serve\serve_system\start.bat']);
    //
    // if (result.exitCode == 0) {
    //   print('bat文件执行成功');
    //   print(result.stdout);
    // } else {
    //   print('bat文件执行失败');
    //   print(result.stderr);
    // }
  }



  static Future<String?> getServiceSuperPath() async{
    String? serviceSuperPath = PreferencesUtil().get(ConstApp.servicePathKey);
    serviceSuperPath ??= await getServicePath();
    if(null!=serviceSuperPath){
      serviceSuperPath = path.dirname(serviceSuperPath);
    }
    return serviceSuperPath;
  }

  static Future<String?> getServiceOrStoragePath() async{
    String? servicePath = PreferencesUtil().get(ConstApp.servicePathKey);
    servicePath ??= await getServicePath();
    return servicePath;
  }


  static String? getServicePath(){
    if(kIsWindows){
      return getWindowsServicePath();
    }
    return null;
  }

  static String? getWindowsServicePath(){
    String resolvedExecutablePath = Platform.resolvedExecutable;
    resolvedExecutablePath = path.dirname(resolvedExecutablePath);
    print(resolvedExecutablePath);
    File serviceProjectDirectory = File(path.join(resolvedExecutablePath , ConstApp.serviceProjectNameKey));
    if(serviceProjectDirectory.existsSync()){
      return serviceProjectDirectory.path;
    }else{
      resolvedExecutablePath = path.dirname(resolvedExecutablePath);
      File serviceProjectDirectory = File(path.join(resolvedExecutablePath , ConstApp.serviceProjectNameKey));
      if(serviceProjectDirectory.existsSync()){
        return serviceProjectDirectory.path;
      }
    }
    return null;
  }

}