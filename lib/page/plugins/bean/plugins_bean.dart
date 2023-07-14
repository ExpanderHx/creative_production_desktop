import 'package:isar/isar.dart';
part 'plugins_bean.g.dart';

//  flutter pub run build_runner build

@collection
class PluginsBean {
  Id id = Isar.autoIncrement; // 你也可以用 id = null 来表示 id 是自增的

  String? title;

  String? prompt;

  String? type;

  bool? isOpenShortcutKeys;

  String? hotKeyJsonString;

  bool? isStableDiffusionGlobal;



}