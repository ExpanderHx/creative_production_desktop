

import 'package:isar/isar.dart';

part 'plug_bean.g.dart';

@collection
class PlugBean {
  Id id = Isar.autoIncrement; // 你也可以用 id = null 来表示 id 是自增的

  String? title;

  String? prompt;

}