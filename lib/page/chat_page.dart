import 'dart:async';

import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


import '../config/menu_config.dart';
import '../network/chat/chat_api.dart';
import '../network/chat/chat_api_general.dart';
import '../network/chat/chat_api_handle.dart';
import '../network/chat/chat_gpt_open_ai.dart';
import '../network/chat/config/response_message.dart';
import '../util/theme_utils.dart';
import 'chat/bean/chat_message.dart';
import 'chat/chat_input_widget.dart';
import 'chat/dialog_box_widget.dart';

class ChatPage extends StatefulWidget {
  Map<String,dynamic?>? paramMap;
  ChatPage({super.key,this.paramMap});
  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {

  ChatApi? chatApi = null;

  List<ChatMessage> messageList = [];

  ScrollController dialogBoxWidgetScrollController = ScrollController();

  String activeType = MenuConfig.chat_menu;

  bool isLoading = false;

  @override
  void initState() {
    // chatApi = ChatApiGeneral();
    // chatApi = ChatApiOpenAi();
    chatApi = ChatApiHandle();
  }

  @override
  void didUpdateWidget(ChatPage oldWidget) {
    if (widget.paramMap != oldWidget.paramMap) {
      if(widget.paramMap!=null){
        if(null!=widget.paramMap!["activeType"]&&widget.paramMap!["activeType"].length>0){
          activeType = widget.paramMap!["activeType"];
        }
      }
    }
    super.didUpdateWidget(oldWidget);
  }


  @override
  void dispose() {
    dialogBoxWidgetScrollController.dispose();
    super.dispose();
  }

  void onSendMessage(String message){
    print("message:"+message);
    if(null!=message&&message.trim().length>0){
      isLoading = true;
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
        chatApi!.sendMessage(message,activeType: activeType).then((response) {
          if(null!=response&&response.statusCode==200){
            String? responseMessage = response.responseMessage;
            if(null!=responseMessage){
              ChatMessage messageData = ChatMessage(responseMessage,false);
              messageList.add(messageData);
              Timer(const Duration(milliseconds: 100), () {
                //List滑动到底部
                if(null!=dialogBoxWidgetScrollController){
                  dialogBoxWidgetScrollController?.jumpTo(dialogBoxWidgetScrollController!.position.maxScrollExtent);
                }
              });
              if(mounted){
                setState(() {
                });
              }
            }
            print(response);
          }
          isLoading = false;
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
      child: Stack(
        children: [
          Column(
            children: [
              Expanded(
                  flex: 1,
                  child: DialogBoxWidget(messageList: messageList,dialogBoxWidgetScrollController:dialogBoxWidgetScrollController)
              ),
              Container(
                height: 120,
              )
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              // margin: EdgeInsets.only(top: 15.h),
              child: ChatInputWidget(
                  onSendMessage:onSendMessage,
                  isLoading:isLoading
              ),
            ),
          )
        ],
      )  ,
    );
  }
}



// Container(
// height: 70.h,
// child: Container(
// decoration: BoxDecoration(
// borderRadius: BorderRadius.circular(8),
// border: Border.all(color: Colors.black,width: 1.w),
// ),
// padding: EdgeInsets.only(left: 15.w,right: 15.w,top: 15.h,bottom: 15.h),
// alignment: Alignment.center,
// child: TextField(
// maxLines:null,
// decoration:  InputDecoration(
// hintText: "请输入参数值",
// // contentPadding和border的设置是为了让TextField内容实现上下居中
// contentPadding: const EdgeInsets.all(0),
// border: const OutlineInputBorder(borderSide: BorderSide.none),
// )
// ),
// ),
// )