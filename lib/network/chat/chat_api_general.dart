


import 'package:bot_toast/bot_toast.dart';
import 'package:creative_production_desktop/utilities/language_util.dart';

import '../../page/chat/bean/chat_message.dart';
import '../config/response_wrap.dart';
import 'chat_api.dart';
import 'config/chat_config.dart';
import 'config/chat_http.dart';
import 'config/response_message.dart';

class ChatApiGeneral extends ChatApi{

  static ChatHttp chatHttp = ChatHttp().init(
    baseUrl: ChatConfig.chatGeneralBaseUrl
  );

  static final ChatApiGeneral _instance = ChatApiGeneral._internal();
  // 单例模式使用Http类，
  factory ChatApiGeneral() => _instance;

  ChatApiGeneral._internal();




  Future<dynamic?> sendMessage(String message,{List<ChatMessage>? historyList,activeType,String? defaultApiType}) async {
    List<List<String>> history = [];
    if(null!=historyList&&historyList.length>0){
      for(var i=0;i<historyList.length-1;i++){
        if(null!=historyList[i]){
          ChatMessage historyChatMessage = historyList[i]!;
          if(null!=historyChatMessage.message){
            List<String> _history = [];
            _history.add(historyChatMessage.message);
            if(null!=historyChatMessage.isToAi&&historyChatMessage.isToAi){
              if(historyList.length-2>i){
                if(null!=historyList[i+1].isToAi&&!historyList[i+1].isToAi){
                  _history.add(historyList[i+1].message);
                  history.add(_history);
                }
              }
            }
          }
        }
      }
    }
    Map<String, dynamic>? data = {"question":message,"history":history};
    try{
      ResponseWrap? responseWrap = await chatHttp.post("/chat",data:data);
      if(null!=responseWrap){
        if(responseWrap.statusCode==200){
          Map<String,dynamic> data =  responseWrap.data;
          if(null!=data){
            String responseMessage = data["response"];
            return Future.value(ResponseMessage(statusCode:responseWrap.statusCode,responseMessage:responseMessage,originalResponse: responseWrap));
          }
        }else{
          BotToast.showText(text: "${'an_exception_occurred_please_try_again'.tr()}");
        }
      }
    }catch(e){
      BotToast.showText(text: "${'an_exception_occurred_please_try_again'.tr()}$e");
    }
    return Future.value(null);
  }


}