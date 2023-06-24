// /// ./lin/utils/db_util.dart
// import 'dart:io';
// import 'package:hive/hive.dart';
// import 'package:hive_flutter/hive_flutter.dart';
// import 'package:path_provider/path_provider.dart';
//
// /// Hive 数据操作
// class DBUtil {
//   /// 实例
//   static DBUtil instance;
//
//   /// 初始化，需要在 main.dart 调用
//   /// <https://docs.hivedb.dev/>
//   static Future<void> install() async {
//     /// 初始化数据库地址
//     Directory document = await getApplicationDocumentsDirectory();
//     Hive.init(document.path);
//
//     /// 注册自定义对象（实体）
//     /// <https://docs.hivedb.dev/#/custom-objects/type_adapters>
//     /// Hive.registerAdapter(SettingsAdapter());
//   }
//
//   /// 初始化 Box
//   static Future<DBUtil> getInstance() async {
//     if (instance == null) {
//       instance = DBUtil();
//       await Hive.initFlutter();
//     }
//     return instance;
//   }
// }