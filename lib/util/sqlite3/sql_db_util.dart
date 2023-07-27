// import 'package:sqflite/sqflite.dart';
//
// class SqlDbUtil {
//   // 单例公开访问点
//   factory SqlDbUtil() => _sharedInstance();
//
//   static SqlDbUtil get instance => _sharedInstance();
//
//   // 静态私有成员，没有初始化
//   static SqlDbUtil? _instance;
//
//   // 私有构造函数
//   SqlDbUtil._() {
//     // 具体初始化代码
//   }
//
//   // 静态、同步、SqlDbUtil
//   static SqlDbUtil? _sharedInstance() {
//     _instance ??= SqlDbUtil._();
//     return _instance;
//   }
//
//   /// init db
//   Future<Database?>? database;
//   // final SessionListTable sessionListTable = SessionListTable();
//   // final SessionChatTable sessionChatTable = SessionChatTable();
//
//   initDB() async {
//     try {
//       // String uid = UserManager.instance.userInfo.uid;
//       database = openDatabase(
//         // Set the path to the database.
//         // 需要升级可以直接修改数据库名称
//         join(await getDatabasesPath(), 'message_database_v1.db'),
//         // When the database is first created, create a table to store dogs.
//         onCreate: (db, version) {
//           // Run the CREATE TABLE statement on the database.
//           try {
//             Batch batch = db.batch();
//             _createTable().forEach((element) {
//               batch.execute(element);
//             });
//             batch.commit();
//           } catch (err) {
//             throw (err);
//           }
//         },
//         onUpgrade: (Database db, int oldVersion, int newVersion) {
//           try {
//             Batch batch = db.batch();
//             _createTable().forEach((element) {
//               batch.execute(element);
//             });
//             batch.commit();
//           } catch (err) {
//             throw (err);
//           }
//         },
//         // Set the version. This executes the onCreate function and provides a
//         // path to perform database upgrades and downgrades.
//         version: 1,
//       );
//       // sessionListTable.database = database;
//       // sessionChatTable.database = database;
//     } catch (err) {
//       throw (err);
//     }
//   }
//
//   /// close db
//   closeDB() async {
//     if(null!=database){
//       await database?..close();
//     }
//
//   }
//
//   /// create table
//   List<String> _createTable() {
//     return [];
//     // return [sessionListTable.createTable(), sessionChatTable.createTable()];
//   }
// }