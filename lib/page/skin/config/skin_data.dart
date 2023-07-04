import 'package:isar/isar.dart';
part 'skin_data.g.dart';

//  flutter pub run build_runner build

@collection
class SkinData {
  Id id = Isar.autoIncrement; // 你也可以用 id = null 来表示 id 是自增的

  String? name;

  String? image;

  int? type;  // 0 纯色模式  1 内置  2 上传图片皮肤

  int? lightFontColor;

  int? darkFontColor;

  bool? isGlobal;


}