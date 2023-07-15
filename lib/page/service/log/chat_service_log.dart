import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:async/async.dart';
import 'package:creative_production_desktop/utilities/language_util.dart';
import 'package:creative_production_desktop/utilities/platform_util.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


import 'package:path/path.dart' as path;
import 'package:process_run/process_run.dart';
import 'package:provider/provider.dart';

import '../../../config/const_app.dart';
import '../../../provider/skin_provider.dart';
import '../../../util/preferences_util.dart';
import '../../../util/service_util.dart';
import '../../../util/stable_diffusion_ui_service_util.dart';
import '../../../util/theme_utils.dart';



class ChatServiceLogWidget extends StatefulWidget {

  ChatServiceLogWidget();
  @override
  State<ChatServiceLogWidget> createState() => _ChatServiceLogWidgetState();
}



class _ChatServiceLogWidgetState extends State<ChatServiceLogWidget> {


  String? serviceLogPath;

  String? logType = "chat";

  String logTypeChat = "chat";

  String logTypeStableDiffusion = "Stable Diffusion";

  String logTxt = "";

  Shell? logShell;

  ShellLinesController? stdoutController;

  ShellLinesController? stderrController;

  StreamSubscription? logStreamSubscription;

  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    getServiceLogPath();
    // readLog();
  }

  void getServiceLogPath() async{
    await getChatServiceLogPath();
    await readLogTimer();
    if(mounted){
      setState(() {

      });
    }
  }

  void updateLogType(String? newValue) async{
    if(null!=newValue&&newValue!=logType){
      stdoutController?.close();
      stderrController?.close();
      logStreamSubscription?.cancel();
      logShell?.kill();
      logTxt = "";
      logType = newValue;
      if(newValue==logTypeChat){
        await getChatServiceLogPath();
      }else if(newValue==logTypeStableDiffusion){
        await getStableDiffusionServiceLogPath();
      }
      readLog();
      setState(() {

      });
    }

  }

  Future<void> getChatServiceLogPath() async{
    String? servicePath = await ServiceUtil.getServiceOrStoragePath();
    String _serviceLogPath = path.join(servicePath! , ConstApp.serveSystemNameKey, ConstApp.serviceChatLogNameKey);
    if(null!=_serviceLogPath&&_serviceLogPath.trim().length>0){
      serviceLogPath = _serviceLogPath;
    }
  }

  Future<void> getStableDiffusionServiceLogPath() async{
    String? servicePath = await StableDiffusionUiServiceUtil.getServiceOrStoragePath();
    String _serviceLogPath = path.join(servicePath! , ConstApp.serviceStableDiffusionULogNameKey);
    if(null!=_serviceLogPath&&_serviceLogPath.trim().length>0){
      serviceLogPath = _serviceLogPath;
    }
  }

  Future<void> readLogTimer() async{
    if(null!=logStreamSubscription){
      logStreamSubscription?.cancel();
    }
    readLog();
  }

  void readLog() async{
    logTxt = "";
    if(null!=serviceLogPath&&serviceLogPath!.trim().length>0){
      stdoutController = ShellLinesController();
      stderrController = ShellLinesController();

      logShell = Shell(
          stdout: stdoutController!.sink,
          stderr: stderrController!.sink,
      );
      final result = StreamGroup.merge([
        stdoutController!.stream,
        stderrController!.stream
      ]);
      result.listen((data) {
        logTxt += data + "\n";
        print(data);
       if(mounted){
         setState(() {

         });
       }
        Timer(Duration(milliseconds: 100), () {
          //List滑动到底部
          if(null!=scrollController){
            scrollController?.jumpTo(scrollController!.position.maxScrollExtent);
            if(mounted){
              setState(() {

              });
            }

          }

        });
      });
      if(null!=logShell){
        // await newShell!.run("chcp 65001",);
        String executable = "tail -f -n 200 " + serviceLogPath!;
        // if(kIsWindows){
        //   executable = "chcp 65001  \n" + executable ;
        // }
        await logShell!.run(executable,);
      }



    }else{
      logTxt = "";
      if(mounted){
        setState(() {

        });
      }
    }

  }

  @override
  void dispose() {
    logStreamSubscription?.cancel();
    scrollController?.dispose();
    stdoutController?.close();
    stderrController?.close();
    logShell?.kill();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {


    SkinProvider skinProvider = context.watch<SkinProvider>();

    return Container(
      color: ThemeUtils.getGobalSkinDataThemeColor(
          context,
          lightColor: Theme.of(context).dialogBackgroundColor,
          blackColor: Theme.of(context).dialogBackgroundColor,
          gobalSkinData: skinProvider.gobalSkinData,
          imageBackgroundColor: Color.fromARGB(255, 162, 161, 161)
      ),
      child: Column(
        children: [
          Container(
            height: 50,
            // margin: EdgeInsets.only(bottom: 5),
            child: Row(
              children: [
                Expanded(
                  flex:1,
                  child: Container(
                    child: Center(
                      child: Text("日志"),
                    ),
                  ),
                ),
                Container(
                  child: IconButton(
                    icon: Icon(Icons.close),
                    onPressed: (){
                      Navigator.pop(context);
                    },
                  ),
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 15),
            padding: EdgeInsets.only(left:30,right:30),
            child: DropdownButtonHideUnderline(
              child: DropdownButton2(
                buttonStyleData: const ButtonStyleData(
                  height: 30,
                  padding: EdgeInsets.only(top: 0,bottom: 0,left: 3,right: 3),

                ),
                menuItemStyleData: const MenuItemStyleData(
                  height: 30,
                  padding: EdgeInsets.only(top: 0,bottom: 0,left: 3,right: 3),
                ),
                value: logType,
                style:TextStyle(
                  fontSize: 15,
                  color: ThemeUtils.getFontThemeColor(context),

                ),
                isExpanded:true,
                items: [
                  DropdownMenuItem(
                      value: logTypeChat,
                      child: Text(logTypeChat)
                  ),
                  DropdownMenuItem(
                      value: logTypeStableDiffusion,
                      child: Text(logTypeStableDiffusion)
                  )
                ],
                onChanged: (String? newValue) {
                  updateLogType(newValue);
                },

              ),
            ),
          ),
          Expanded(
            child: getTxtLogWidget(),
          ),

        ],
      ),
    );
  }

  Widget getTxtLogWidget(){
    Widget textContainer = Container();

    if(null!=logTxt&&logTxt!.trim().length>0){
      textContainer = Container(
        padding: EdgeInsets.only(left:30,right:30,bottom: 30),
        child: Text(
          logTxt,
        ),
      );
    }

    return Container(
      child: SingleChildScrollView(
        controller: scrollController,
        child: textContainer,
      ),
    );
  }


}
