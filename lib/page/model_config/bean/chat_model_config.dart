import 'package:isar/isar.dart';
part 'chat_model_config.g.dart';

//  flutter pub run build_runner build

@collection
class ChatModelConfig{

  Id id = Isar.autoIncrement; // 你也可以用 id = null 来表示 id 是自增的

  String? configName;
  String? modelName;
  String? tokenizerName;
  String? loadDevice;
  String? token;
  int? maxToken;
  double? temperature;
  bool? isGlobal;
  bool? isLocal;
  String? baseUrl;

}