


import 'package:creative_production_desktop/network/chat/chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:creative_production_desktop/network/chat/chat_gpt_sdk/src/model/chat_complete/response/chat_choice.dart';
import 'package:creative_production_desktop/network/chat/chat_gpt_sdk/src/model/chat_complete/response/message.dart';

import 'chat_api.dart';
import 'config/response_message.dart';


class ChatApiOpenAi extends ChatApi{

  static OpenAI openAI  =  OpenAI.instance.build(
      token: "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",
      baseOption: HttpSetup(
          receiveTimeout: const Duration(seconds: 120)
      ),
      enableLog: true
  );

  static final ChatApiOpenAi _instance = ChatApiOpenAi._internal();
  // 单例模式使用Http类，
  factory ChatApiOpenAi() => _instance;

  ChatApiOpenAi._internal();

  Future<dynamic?> sendMessage(String message,{List<String>? historyList}) async{
    List<Messages> messagesList = [];

    messagesList.add(Messages(role:Role.user,content: message));

    final request = ChatCompleteText(messages: messagesList, maxToken: 2000, model: GptTurboChatModel());
    ChatCTResponse? response = await openAI.onChatCompletion(request: request);

    if(null!=response){
      String responseMessage = "";
      if(null!=response.choices&&response.choices.length>0){
        for(int i=0;i<response.choices.length;i++){
          ChatChoice chatChoice = response.choices[i];
          if(null!=chatChoice&&null!=chatChoice.message){
            if(null!=chatChoice.message!.content&&chatChoice.message!.content.length>0){
              responseMessage += chatChoice.message!.content;
            }
          }
        }
        print(responseMessage);
      }
      return Future.value(ResponseMessage(statusCode:200,responseMessage:responseMessage,originalResponse: response));
    }

    return Future.value(null);
    openAI.onChatCompletionSSE(request: request).listen((it) {
      print(it);
      // debugPrint(it.choices.last.message?.content);
    });
    return Future.value(null);
  }

  setToken(String token){
    openAI.setToken(token);
  }


}