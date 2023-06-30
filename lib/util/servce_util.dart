
import 'dart:io';

import 'package:process_run/process_run.dart';

class ServceUtil{

  static void startServce() async{
    final shell = Shell();
    try {
      // ProcessResult result = await shell
      //     .runExecutableArguments('cmd.exe',['E:\\pycharm\\creative_production_serve\\serve_system\\start.bat']);
      ProcessResult result = await shell
          .runExecutableArguments('E:\\pycharm\\creative_production_serve\\serve_system\\start.bat',[]);
      // print(result);
      if (result.exitCode == 0) {
        print('bat文件执行成功');
        print(result.stdout);
      } else {
        print('bat文件执行失败');
        print(result.stderr);
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

}