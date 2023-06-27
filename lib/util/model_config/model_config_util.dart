

import 'package:isar/isar.dart';

import '../../network/chat/config/chat_config.dart';
import '../../page/model_config/bean/chat_model_config.dart';
import '../db/isar_db_util.dart';

class ModelConfigUtil{

  static Future<List<ChatModelConfig>?> getChatModelConfigList() async{
    List<ChatModelConfig>? chatModelConfigList;
    await IsarDBUtil().init();
    if(null!=IsarDBUtil().isar){
      List<ChatModelConfig> chatModelConfigs = await IsarDBUtil().isar!.chatModelConfigs.where().findAll();
      if(chatModelConfigs==null||chatModelConfigs.length<=0){
        chatModelConfigs = await ModelConfigUtil.initChatModelConfigList();
      }
      print(chatModelConfigs);
      if(null!=chatModelConfigs&&chatModelConfigs.length>0){
        chatModelConfigList = chatModelConfigs;
      }

    }
    return chatModelConfigList;
  }

  static Future<ChatModelConfig?> getGlobalChatModelConfig(List<ChatModelConfig>? chatModelConfigList) async{
    ChatModelConfig? globalChatModelConfig;
    if(null!=chatModelConfigList&&chatModelConfigList.length>0){
      for(var i=0;i<chatModelConfigList.length;i++){
        if(chatModelConfigList[i]!=null&&chatModelConfigList[i].isGlobal!=null&&chatModelConfigList[i].isGlobal!){
          globalChatModelConfig = chatModelConfigList[i];
        }
      }
    }
    return globalChatModelConfig;
  }


  static Future<List<ChatModelConfig>> initChatModelConfigList() async{
    List<ChatModelConfig> chatModelConfigs = [];

    ChatModelConfig chatModelConfigLocal = getChatModelConfig(
      "THUDM/chatglm2-6b",
      modelName: "THUDM/chatglm2-6b",
      tokenizerName: "THUDM/chatglm2-6b",
      isGlobal: true,
      isLocal: true,
      baseUrl: ChatConfig.chatGeneralBaseUrl,
    );
    await IsarDBUtil().isar!.writeTxn(() async{
      await IsarDBUtil().isar!.chatModelConfigs.put(chatModelConfigLocal);
    });

    chatModelConfigs.add(chatModelConfigLocal);

    ChatModelConfig chatModelConfigOpenAi = getChatModelConfig(
      "openai",
      modelName: "gpt-3.5-turbo",
      tokenizerName: "gpt-3.5-turbo",
      isGlobal: false,
      isLocal: false,
      baseUrl: ChatConfig.chatOpenAiBaseUrl,
    );
    await IsarDBUtil().isar!.writeTxn(() async{
      await IsarDBUtil().isar!.chatModelConfigs.put(chatModelConfigOpenAi);
    });

    chatModelConfigs.add(chatModelConfigOpenAi);

    return chatModelConfigs;

  }

  static ChatModelConfig getChatModelConfig(String configName,{
    String? modelName,
    String? tokenizerName,
    String? load_device,
    int? maxToken,
    double? temperature,
    bool? isGlobal,
    bool? isLocal,
    String? baseUrl,
  }){
    ChatModelConfig chatModelConfig = ChatModelConfig();
    chatModelConfig.configName = configName;
    chatModelConfig.modelName = modelName;
    chatModelConfig.tokenizerName = tokenizerName;
    chatModelConfig.loadDevice = load_device;
    chatModelConfig.temperature = temperature;
    chatModelConfig.isGlobal = isGlobal;
    chatModelConfig.isLocal = isLocal;
    chatModelConfig.baseUrl = baseUrl;
    return chatModelConfig;
  }

}