


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

  Future<dynamic?> sendMessage(String message,{List<String>? historyList}) async {
    Map<String, dynamic>? data = {"question":message,"history":[]};
    ResponseWrap responseWrap = await chatHttp.post("/chat",data:data);
    if(null!=responseWrap){
      if(responseWrap.statusCode==200){
        Map<String,dynamic> data =  responseWrap.data;
        if(null!=data){
          String responseMessage = data["response"];
          return Future.value(ResponseMessage(statusCode:responseWrap.statusCode,responseMessage:responseMessage,originalResponse: responseWrap));
        }
      }
    }
    return Future.value(null);
  }


}