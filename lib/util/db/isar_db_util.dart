/// ./lin/utils/isar_db_util.dart
import 'dart:io';

import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import '../../config/const_app.dart';
import '../../page/model_config/bean/chat_model_config.dart';
import '../../page/plugins/bean/plugins_bean.dart';
import 'package:path/path.dart' as path;

import '../../page/skin/config/skin_data.dart';

/// Hive 数据操作
class IsarDBUtil {
  /// 实例
  static IsarDBUtil? _instance;

  factory IsarDBUtil() => _instance ??= IsarDBUtil._initial();

  Isar? isar;


  //创建命名构造函数
  IsarDBUtil._initial() {
    //为什么在这里需要新写init方法 主要是在命名构造中不能使用async/await
    init();
  }

  /// 初始化，需要在 main.dart 调用
  /// <https://docs.hivedb.dev/>
  Future<void> init() async {
    if(isar == null){
      final dir = await getApplicationDocumentsDirectory();
      String projectIsarDbPath = path.join(dir.path , ConstApp.projectNameKey, ConstApp.projectDbNameKey,ConstApp.projectIsarDbNameKey);
      await Directory(projectIsarDbPath).create(recursive: true);
      // if(!File(projectIsarDbPath).existsSync()){
      //   File(projectIsarDbPath).createSync(recursive: true);
      // }
      isar = await Isar.open(
        [PluginsBeanSchema,ChatModelConfigSchema,SkinDataSchema],
        directory: projectIsarDbPath,
      );
    }

    // final recipes = isar?.collection<PlugBean>();
  }

}