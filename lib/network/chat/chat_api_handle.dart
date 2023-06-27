




import '../../page/model_config/bean/chat_model_config.dart';

import '../../util/model_config/model_config_util.dart';
import 'chat_api.dart';
import 'chat_api_general.dart';
import 'chat_gpt_open_ai.dart';
import 'chat_gpt_sdk/src/model/client/http_setup.dart';
import 'chat_gpt_sdk/src/openai.dart';
import 'config/chat_config.dart';
import 'config/chat_http.dart';


class ChatApiHandle extends ChatApi{



  static ChatApiGeneral chatApiGeneral = ChatApiGeneral();
  static ChatApiOpenAi chatApiOpenAi = ChatApiOpenAi();

  // static ChatApiGeneral chatApiGeneral = ChatApiGeneral();

  static final ChatApiHandle _instance = ChatApiHandle._internal();
  // 单例模式使用Http类，
  factory ChatApiHandle() => _instance;

  ChatApiHandle._internal();

  Map<dynamic,ChatApi> activeMap = {};



  Future<ChatApi?> getChatApi({activeType}) async{
    if(null!=activeType){
      if(null!=activeMap[activeType]){
        return activeMap[activeType];
      }
    }
    ChatModelConfig? globalChatModelConfig = await ModelConfigUtil.getGlobalChatModelConfig(await ModelConfigUtil.getChatModelConfigList());
    if(null!=globalChatModelConfig){
      if(globalChatModelConfig.isLocal!=null&&globalChatModelConfig.isLocal!){
        return chatApiGeneral;
      }else{
        return chatApiOpenAi;
      }
    }
  }

  Future<dynamic?> sendMessage(String message,{List<String>? historyList,activeType}) async {
    ChatApi? chatApi = await getChatApi(activeType:activeType);
    if(null!=chatApi){
     return chatApi.sendMessage(message,historyList: historyList);
    }
    return Future.value(null);
  }


  Future reloadActiveChatModel(ChatModelConfig? activeChatModelConfig,{activeType}) async{
    if(null!=activeChatModelConfig){
      if(activeChatModelConfig.isLocal!=null&&activeChatModelConfig.isLocal!){
        await reloadActiveLocalChatModel(activeChatModelConfig,activeType:activeType);
      }else{
        await reloadActiveOpenAiChatModel(activeChatModelConfig,activeType:activeType);
      }
    }
  }

  Future reloadActiveLocalChatModel(ChatModelConfig? activeChatModelConfig,{activeType}) async{
    if(null!=activeChatModelConfig){
      if(activeChatModelConfig.isLocal!=null&&activeChatModelConfig.isLocal!){
        activeChatModelConfig.baseUrl = activeChatModelConfig.baseUrl ?? ChatConfig.chatGeneralBaseUrl;
        ChatHttp activeChatHttp = ChatHttp().init(
            baseUrl: activeChatModelConfig.baseUrl
        );
        await activeChatHttp.post("reload_model",data: activeChatModelConfig);
        if(null!=activeType){
          activeMap[activeType] = chatApiGeneral;
        }
      }
    }
  }

  Future reloadActiveOpenAiChatModel(ChatModelConfig? activeChatModelConfig,{activeType}) async{
    if(null!=activeChatModelConfig){
      activeChatModelConfig.baseUrl = activeChatModelConfig.baseUrl ?? ChatConfig.chatOpenAiBaseUrl;
      if(activeChatModelConfig.isLocal==null||!activeChatModelConfig.isLocal!){
        ChatApiOpenAi _chatApiOpenAi = ChatApiOpenAi().build(
            activeChatModelConfig.token,
            baseOption: HttpSetup(
                receiveTimeout: const Duration(seconds: 120),
                baseUrl: activeChatModelConfig.baseUrl!
            ),
            enableLog: true
        );
        if(null!=activeType){
          activeMap[activeType] = _chatApiOpenAi;
        }
      }
    }
  }




}