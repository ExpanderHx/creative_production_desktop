import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:async/async.dart';
import 'package:creative_production_desktop/utilities/language_util.dart';
import 'package:creative_production_desktop/utilities/platform_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


import 'package:path/path.dart' as path;
import 'package:process_run/process_run.dart';
import 'package:provider/provider.dart';

import '../../../config/const_app.dart';
import '../../../provider/skin_provider.dart';
import '../../../util/service_util.dart';
import '../../../util/theme_utils.dart';



class ChatServiceLogWidget extends StatefulWidget {

  ChatServiceLogWidget();
  @override
  State<ChatServiceLogWidget> createState() => _ChatServiceLogWidgetState();
}



class _ChatServiceLogWidgetState extends State<ChatServiceLogWidget> {


  String? serviceLogPath;

  String logTxt = "";

  StreamSubscription? logStreamSubscription;

  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    getServiceLogPath();
    // readLog();
  }

  void getServiceLogPath() async{
    String? servicePath = await ServiceUtil.getServiceOrStoragePath();
    String _serviceLogPath = path.join(servicePath! , ConstApp.serveSystemNameKey, ConstApp.serviceChatLogNameKey);
    if(null!=_serviceLogPath&&_serviceLogPath.trim().length>0){
      serviceLogPath = _serviceLogPath;
    }
    readLogTimer();
    if(mounted){
      setState(() {

      });
    }
  }

  void readLogTimer() async{
    if(null!=logStreamSubscription){
      logStreamSubscription?.cancel();
    }
    readLog();
  }

  void readLog() async{
    logTxt = "";
    if(null!=serviceLogPath&&serviceLogPath!.trim().length>0){
      var stdoutController = ShellLinesController();
      var stderrController = ShellLinesController();

      var newShell = Shell(
          stdout: stdoutController.sink,
          stderr: stderrController.sink,
          // stdoutEncoding:  utf8,
          // stderrEncoding:  utf8

      );
      final result = StreamGroup.merge([
        stdoutController.stream,
        stderrController.stream
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
      if(null!=newShell){
        // await newShell!.run("chcp 65001",);
        String executable = "tail -f -n 200 " + serviceLogPath!;
        // if(kIsWindows){
        //   executable = "chcp 65001  \n" + executable ;
        // }
        await newShell!.run(executable,);
      }



    }else{
      logTxt = "";
      if(mounted){
        setState(() {

        });
      }

    }


    // if(null!=serviceLogPath&&serviceLogPath!.trim().length>=0){
    //   var file = File(serviceLogPath!);
    //   var fileStream = file.watch();
    //
    //   //
    //   // fileStream.listen((event) {
    //   //   if (event.type == FileSystemEvent.modify) {
    //   //     print('File modified');
    //   //   // 文件发生变化，可以读取文件内容并进行相应的处理
    //   //     String fileContent = file.readAsStringSync();
    //   //     logTxt = fileContent;
    //   //     setState(() {
    //   //
    //   //     });
    //   //     // 在这里可以发送给StreamController，更新界面等操作
    //   //     }
    //   // });
    //   logTxt = "";
    //
    //   // LineSplitter Dart语言封装的换行符，此处将文本按行分割
    //   Stream logLinesStream = File(serviceLogPath!).openRead().transform(utf8.decoder).transform(const LineSplitter());
    //   logLinesStream.forEach((element) {
    //     print(element);
    //   });
    //   logStreamSubscription = logLinesStream!.listen((event) {
    //     logTxt += event + "\n";
    //
    //
    //     Timer(Duration(milliseconds: 100), () {
    //       //List滑动到底部
    //       if(null!=scrollController){
    //         scrollController?.jumpTo(scrollController!.position.maxScrollExtent);
    //         setState(() {
    //
    //         });
    //       }
    //
    //     });
    //   });
    //   logStreamSubscription!.onDone(() {
    //     print("读取完成");
    //     Timer(Duration(milliseconds: 100), () {
    //       readLogTimer();
    //     });
    //   });
    // }else{
    //   logTxt = "";
    //   setState(() {
    //
    //   });
    // }
  }

  @override
  void dispose() {
    logStreamSubscription?.cancel();
    scrollController?.dispose();
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
            margin: EdgeInsets.only(bottom: 15),
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
