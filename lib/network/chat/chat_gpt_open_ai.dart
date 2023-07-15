


import 'package:bot_toast/bot_toast.dart';
import 'package:creative_production_desktop/network/chat/chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:creative_production_desktop/network/chat/chat_gpt_sdk/src/model/chat_complete/response/chat_choice.dart';
import 'package:creative_production_desktop/network/chat/chat_gpt_sdk/src/model/chat_complete/response/message.dart';

import '../../page/chat/bean/chat_message.dart';
import '../../page/model_config/bean/chat_model_config.dart';
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

  ChatModelConfig? chatModelConfig;

  ChatApiOpenAi build(String? token, {required HttpSetup baseOption, required bool enableLog,ChatModelConfig? activeChatModelConfig}) {
    openAI =  OpenAI.instance.build(
        token: token,
        baseOption: baseOption,
        enableLog: enableLog
    );
    chatModelConfig = activeChatModelConfig;
    return this;
  }

  // ChatApiOpenAi.build(String token,{HttpSetup? baseOption, bool enableLog = false}){
  //   openAI =  OpenAI.instance.build(
  //       token: token,
  //       baseOption: baseOption,
  //       enableLog: enableLog
  //   );
  // }


  Future<dynamic?> sendMessage(String message,{List<ChatMessage>? historyList,activeType,String? defaultApiType}) async{
    List<Messages> messagesList = [];
    if(null!=historyList&&historyList.length>0){
      for(var i=0;i<historyList.length-1;i++){
        if(null!=historyList[i]){
          ChatMessage historyChatMessage = historyList[i]!;
          if(null!=historyChatMessage.message){
            if(null!=historyChatMessage.isToAi&&historyChatMessage.isToAi){
              messagesList.add(Messages(role:Role.user,content: historyChatMessage.message));
            }else{
              messagesList.add(Messages(role:Role.assistant,content: historyChatMessage.message));
            }
          }
        }
      }
    }

    messagesList.add(Messages(role:Role.user,content: message));

    final request = ChatCompleteText(
        messages: messagesList,
        temperature:chatModelConfig?.temperature??0.3,
        maxToken: chatModelConfig?.maxToken??2000,
        model: GptTurboChatModel()
    );
    try{
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
    }catch(e){
      BotToast.showText(text: "发生异常，请重试 $e");
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