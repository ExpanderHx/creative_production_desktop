
import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:creative_production_desktop/util/preferences_util.dart';
import 'package:creative_production_desktop/util/service_util.dart';
import 'package:creative_production_desktop/utilities/language_util.dart';
import 'package:dio/dio.dart';
import 'package:process_run/process_run.dart';
import 'package:path/path.dart' as path;

import '../config/const_app.dart';
import '../network/chat/config/chat_http.dart';
import '../utilities/platform_util.dart';

class StableDiffusionUiServiceUtil{

  static Shell? shell;

  static int isStartCount = 0;

  static Future<void> startServce() async{

    try {
      // App的可执行文件路径
      String resolvedExecutablePath = Platform.resolvedExecutable;
      print(resolvedExecutablePath);
      String? servicePath = PreferencesUtil().get(ConstApp.stableDiffusionUiServicePathKey);
      servicePath ??= await getServicePath();

      // BotToast.showText(text: "resolvedExecutablePath : ${resolvedExecutablePath}");
      if(null!=servicePath){
        // BotToast.showText(text: "servicePath : ${servicePath}");
        String serviceBatPath = path.join(servicePath! , ConstApp.startStableDiffusionUiBatNameKey);
        String serviceLogPath = path.join(servicePath! , ConstApp.serviceStableDiffusionULogNameKey);
        File serviceLogFile = File(serviceLogPath);
        if(serviceLogFile.existsSync()){
          serviceLogFile.delete();
        }
        if(File(serviceBatPath).existsSync()){
          var controller = ShellLinesController();
          var stderrController = ShellLinesController();
          String? pythonPath = await getDefaultPythonPath();

          Map<String, String>? environment = {"COMMANDLINE_ARGS":"--api"};
          // environment["PYTHON"] = "E:\\pycharm\\stable-diffusion-webui\\venv\\Scripts\\python.exe";
          if(null!=pythonPath){
            environment["PYTHON"] = pythonPath;
          }

          var newShell = Shell(stdout: controller.sink,stderr: stderrController.sink,environment:environment);
          controller.stream.listen((event) {
            print(event);
            serviceLogFile.writeAsString("$event\r\n",mode: FileMode.writeOnlyAppend,encoding: systemEncoding);

          });
          stderrController.stream.listen((event) {
            print(event);
            serviceLogFile.writeAsString("$event\r\n",mode: FileMode.writeOnlyAppend,encoding: systemEncoding);

          });
          if(null!=newShell){
            // newShell.run("set PYTHON=python123");
            newShell = newShell.pushd(servicePath!);
            newShell.options.environment["COMMANDLINE_ARGS"] = "--api";
            if(null!=pythonPath){
              newShell.options.environment["PYTHON"] = pythonPath;
            }
            // newShell.run(serviceBatPath);
            ProcessResult result = await newShell!
                .runExecutableArguments(serviceBatPath,[]);
            print(result);
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
  }

  static Future<String?> getDefaultPythonPath() async{
    String? serviceDiffusionUiPath = PreferencesUtil().get(ConstApp.stableDiffusionUiServicePathKey);
    serviceDiffusionUiPath ??= await getServicePath();
    if(null!=serviceDiffusionUiPath){
      File pythonFile = File(path.join(serviceDiffusionUiPath! ,ConstApp.stableDiffusionUiEnvNameKey, ConstApp.stableDiffusionUiScriptsNameKey, ConstApp.stableDiffusionUiPythonExeNameKey));
      if(pythonFile.existsSync()){
        return pythonFile.path;
      }
    }
    String? servicePath = PreferencesUtil().get(ConstApp.servicePathKey);
    servicePath ??= await ServiceUtil.getServicePath();
    if(null!=servicePath){
      String servePythonNameKey = ConstApp.servePython_3_9_WinNameKey;
      if(kIsMacOS){
        servePythonNameKey = ConstApp.servePython_3_9_MacNameKey;
      }
      File pythonFile = File(path.join(servicePath! ,ConstApp.serveSystemNameKey, ConstApp.servePythonNameKey, servePythonNameKey, ConstApp.stableDiffusionUiPythonExeNameKey));
      if(pythonFile.existsSync()){
        return pythonFile.path;
      }
    }
    return null;
  }



  static Future<String?> getServiceSuperPath() async{
    String? serviceSuperPath = PreferencesUtil().get(ConstApp.stableDiffusionUiServicePathKey);
    serviceSuperPath ??= await getServicePath();
    if(null!=serviceSuperPath){
      serviceSuperPath = path.dirname(serviceSuperPath);
    }
    return serviceSuperPath;
  }

  static Future<String?> getServiceOrStoragePath() async{
    String? servicePath = PreferencesUtil().get(ConstApp.stableDiffusionUiServicePathKey);
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
    File serviceProjectDirectory = File(path.join(resolvedExecutablePath , ConstApp.stableDiffusionUiServiceProjectNameKey));
    if(serviceProjectDirectory.existsSync()){
      return serviceProjectDirectory.path;
    }else{
      resolvedExecutablePath = path.dirname(resolvedExecutablePath);
      File serviceProjectDirectory = File(path.join(resolvedExecutablePath , ConstApp.stableDiffusionUiServiceProjectNameKey));
      if(serviceProjectDirectory.existsSync()){
        return serviceProjectDirectory.path;
      }
    }
    return null;
  }


  static Future<int?> getServiceState() async{
    int _service_state = 0;
    try{
      await PreferencesUtil.perInit();
      String? stableDiffusionUiServiceBaseUrl = PreferencesUtil().get(ConstApp.stableDiffusionUiServiceBaseUrlKey);
      stableDiffusionUiServiceBaseUrl ??= ConstApp.stableDiffusionWebUiServiceBaseUrl;
      if(null!=stableDiffusionUiServiceBaseUrl){
        Dio? stableDiffusionWebUiServiceDio = initDio(stableDiffusionUiServiceBaseUrl);
        if(null!=stableDiffusionWebUiServiceDio){
          try{
            var responseWrap = await stableDiffusionWebUiServiceDio.get("/info?serialize=true");
            if(null!=responseWrap){
              if(responseWrap.statusCode == 200){
                _service_state = 1;
              }
            }
          }catch(e){

          }
        }
      }
    }catch(e){
      _service_state = 0;
    }
    return _service_state;
  }

  static Dio? stableDiffusionWebUiServiceDio;

  static Dio? initDio(String? baseUrl){
    if(null==stableDiffusionWebUiServiceDio){
      BaseOptions options = BaseOptions();
      stableDiffusionWebUiServiceDio = Dio(options);
    }
    if(null!=baseUrl){
      if( stableDiffusionWebUiServiceDio!.options.baseUrl!=baseUrl){
        stableDiffusionWebUiServiceDio!.options = stableDiffusionWebUiServiceDio!.options.copyWith(
          baseUrl: baseUrl,
        );
      }
    }
    return stableDiffusionWebUiServiceDio;
  }

}