

import 'dart:async';

import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../network/chat/chat_api.dart';
import '../../network/chat/chat_gpt_open_ai.dart';
import '../../util/theme_utils.dart';
import '../chat/chat_input_widget.dart';
import '../chat/chat_message.dart';
import '../chat/dialog_box_widget.dart';




class TranslatePlugPage extends StatefulWidget {
  const TranslatePlugPage({super.key});
  @override
  State<TranslatePlugPage> createState() => _TranslatePlugPageState();
}

class _TranslatePlugPageState extends State<TranslatePlugPage> {

  TextEditingController inputTextEditingController = TextEditingController();

  ChatApi? chatApi = null;

  List<ChatMessage> messageList = [];

  ScrollController? dialogBoxWidgetScrollController;

  @override
  void initState() {
    // chatApi = ChatApiGeneral();
    chatApi = ChatApiOpenAi();
    inputTextEditingController.text = "提示词";
    dialogBoxWidgetScrollController = ScrollController();
  }

  void onSendMessage(String message){
    print("message:"+message);
    if(null!=message&&message.trim().length>0){

      setState(() {
        ChatMessage messageData = ChatMessage(message,true);
        messageList.add(messageData);
        Timer(Duration(milliseconds: 100), () {
          //List滑动到底部
          if(null!=dialogBoxWidgetScrollController){
            dialogBoxWidgetScrollController?.jumpTo(dialogBoxWidgetScrollController!.position.maxScrollExtent);
          }

        });
      });
      if(null != chatApi){
        chatApi!.sendMessage(message).then((response) {
          // ResponseMessage response2 = response as ResponseMessage;
          if(null!=response&&response.statusCode==200){
            String? responseMessage = response.responseMessage;
            if(null!=responseMessage){
              setState(() {
                ChatMessage messageData = ChatMessage(responseMessage,false);
                messageList.add(messageData);
                Timer(const Duration(milliseconds: 100), () {
                  //List滑动到底部
                  if(null!=dialogBoxWidgetScrollController){
                    dialogBoxWidgetScrollController?.jumpTo(dialogBoxWidgetScrollController!.position.maxScrollExtent);
                  }
                });
              });
            }
            print(response);
          }
        });

      }
    }


  }

  @override
  Widget build(BuildContext context) {
    //设置尺寸（填写设计中设备的屏幕尺寸）如果设计基于360dp * 690dp的屏幕
    // ScreenUtil.init(context, designSize: const Size(1920, 1080));
    return Container(
      color: ThemeUtils.getThemeColor(context),
      child: Column(
        children: [
          Container(
            height: 120,
            margin: EdgeInsets.only(top: 20,bottom: 20),
            child: Container(
              decoration: BoxDecoration(
                color: ThemeUtils.getThemeColor(context),
                borderRadius: BorderRadius.all(Radius.circular(8)),
                boxShadow: [
                  BoxShadow(
                    color: ThemeUtils.getBackgroundThemeColor(context,lightColor: Color.fromARGB(25, 0,0,0),blackColor: Color.fromARGB(25, 255,255,255)), // 阴影颜色
                    blurRadius: 5.0, // 阴影模糊半径
                    spreadRadius: 2.0, // 阴影扩散半径
                    offset: Offset(0, 0), // 阴影偏移量
                  ),
                ],
              ),
              child: TextField(
                  controller: inputTextEditingController,
                  cursorColor:ThemeUtils.getFontThemeColor(context),
                  minLines:1,
                  maxLines: 3,
                  decoration:  InputDecoration(
                      border: InputBorder.none
                  )
              ),
            )
          ),
          Row(
            children: [
              Expanded(
                  flex: 1,
                  child: Container(
                    height: 200,
                    margin: EdgeInsets.only(right: 15),
                    decoration: BoxDecoration(
                      color: ThemeUtils.getThemeColor(context),
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      boxShadow: [
                        BoxShadow(
                          color: ThemeUtils.getBackgroundThemeColor(context,lightColor: Color.fromARGB(25, 0,0,0),blackColor: Color.fromARGB(25, 255,255,255)), // 阴影颜色
                          blurRadius: 5.0, // 阴影模糊半径
                          spreadRadius: 2.0, // 阴影扩散半径
                          offset: Offset(0, 0), // 阴影偏移量
                        ),
                      ],
                    ),
                    child: TextField(
                        controller: inputTextEditingController,
                        cursorColor:ThemeUtils.getFontThemeColor(context),
                        maxLines: null,
                        decoration:  InputDecoration(
                            border: InputBorder.none
                        )
                    ),
                  )
              ),
              Expanded(
                  flex: 1,
                  child: Container(
                    height: 200,
                    margin: EdgeInsets.only(left: 15),
                    decoration: BoxDecoration(
                      color: ThemeUtils.getThemeColor(context),
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      boxShadow: [
                        BoxShadow(
                          color: ThemeUtils.getBackgroundThemeColor(context,lightColor: Color.fromARGB(25, 0,0,0),blackColor: Color.fromARGB(25, 255,255,255)), // 阴影颜色
                          blurRadius: 5.0, // 阴影模糊半径
                          spreadRadius: 2.0, // 阴影扩散半径
                          offset: Offset(0, 0), // 阴影偏移量
                        ),
                      ],
                    ),
                    child: TextField(
                        controller: inputTextEditingController,
                        cursorColor:ThemeUtils.getFontThemeColor(context),
                        maxLines: null,
                        decoration:  InputDecoration(
                            border: InputBorder.none
                        )
                    ),
                  )
              ),

            ],
          )
        ],
      )  ,
    );
  }
}


