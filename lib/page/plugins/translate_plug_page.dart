

import 'dart:async';

import 'package:creative_production_desktop/utilities/language_util.dart';
import 'package:flutter/material.dart';

import '../../config/const_app.dart';
import '../../network/chat/chat_api.dart';
import '../../network/chat/chat_gpt_open_ai.dart';
import '../../util/theme_utils.dart';
import '../chat/bean/chat_message.dart';




class TranslatePlugPage extends StatefulWidget {
  Map<String,dynamic?>? paramMap;
  TranslatePlugPage({super.key,this.paramMap});
  @override
  State<TranslatePlugPage> createState() => _TranslatePlugPageState();
}

class _TranslatePlugPageState extends State<TranslatePlugPage> {

  TextEditingController inputTextEditingController = TextEditingController();

  TextEditingController originalController = TextEditingController();

  TextEditingController targetController = TextEditingController();

  ChatApi? chatApi = null;

  List<ChatMessage> messageList = [];

  ScrollController? dialogBoxWidgetScrollController;

  @override
  void initState() {
    // chatApi = ChatApiGeneral();
    chatApi = ChatApiOpenAi();
    inputTextEditingController.text = "请将以下内容翻译为中文 : ";
    if(widget.paramMap!=null){
      Map<String,dynamic?> paramMap = widget.paramMap!;
      if(null!=paramMap[ConstApp.screenSelectionTextKey]){
        originalController.text = paramMap[ConstApp.screenSelectionTextKey];
      }
    }
    dialogBoxWidgetScrollController = ScrollController();
    changeOriginalText();
  }

  @override
  void didChangeDependencies(){
    print("---didChangeDependencies---");

  }



  @override
  void didUpdateWidget(TranslatePlugPage oldWidget) {
    if (widget.paramMap != oldWidget.paramMap) {
      // 参数发生变化
      // 执行你的逻辑操作
      print('参数发生了变化');
      changeOriginalText();
    }
    super.didUpdateWidget(oldWidget);
  }

  void changeOriginalText(){
    if(widget.paramMap!=null){
      Map<String,dynamic?> paramMap = widget.paramMap!;
      if(null!=paramMap[ConstApp.screenSelectionTextKey]){
        originalController.text = paramMap[ConstApp.screenSelectionTextKey];
        targetController.text = "...";
        // targetController.clear();
        translate(paramMap[ConstApp.screenSelectionTextKey]);
      }
    }
  }



  void onTranslate() {
    translate(originalController.text);
  }


  void translate(String text){
    print("message:"+text);
    if(null!=text&&text.trim().length>0){
      if(null != chatApi){
        chatApi!.sendMessage(inputTextEditingController.text + text).then((response) {
          if(null!=response&&response.statusCode==200){
            if(originalController.text == text){
              String? responseMessage = response.responseMessage;
              if(null!=responseMessage){
                targetController.text = responseMessage;
              }
              print(response);
            }
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
      margin: EdgeInsets.only(left: 20,right: 20),
      color: ThemeUtils.getThemeColor(context),
      child: Column(
        children: [
          Container(
            height: 50,
            margin: EdgeInsets.only(top: 20,bottom: 20),
            child: Container(
              padding: EdgeInsets.only(left: 10,right: 10),
              decoration: BoxDecoration(
                color: ThemeUtils.getThemeColor(context),
                borderRadius: BorderRadius.all(Radius.circular(8)),
                border: Border.all(
                  color: Color.fromARGB(255, 0,0,0), // 边框颜色
                  style: BorderStyle.solid, // 边框样式为实线
                  width: 1.5,
                ),
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
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      suffixIcon: Tooltip(
                        message:"click_translate".tr(),
                        child: IconButton(
                          onPressed: () {
                            onTranslate();
                          },
                          icon: const Icon(
                            Icons.translate,
                            // color: Color.fromARGB(255, 222, 222, 229),
                          ),
                        ),
                      ),
                  )
              ),
            )
          ),
          Expanded(
            flex: 1,
            child: Row(
              children: [
                Expanded(
                    flex: 1,
                    child: Container(
                      height: double.infinity,
                      margin: EdgeInsets.only(right: 15),
                      padding: EdgeInsets.only(left: 10,right: 10),
                      decoration: BoxDecoration(
                        color: ThemeUtils.getThemeColor(context),
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        border: Border.all(
                          color: Color.fromARGB(255, 0,0,0), // 边框颜色
                          style: BorderStyle.solid, // 边框样式为实线
                          width: 1.5,
                        ),
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
                        controller: originalController,
                        cursorColor:ThemeUtils.getFontThemeColor(context),
                        maxLines: null,
                        decoration:  InputDecoration(
                          border: InputBorder.none,
                        ),

                      ),
                    )
                ),
                Expanded(
                    flex: 1,
                    child: Container(
                      height: double.infinity,
                      margin: EdgeInsets.only(left: 15),
                      padding: EdgeInsets.only(left: 10,right: 10),
                      decoration: BoxDecoration(
                        color: ThemeUtils.getThemeColor(context),
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        border: Border.all(
                          color: Color.fromARGB(255, 0,0,0), // 边框颜色
                          style: BorderStyle.solid, // 边框样式为实线
                          width: 1.5,
                        ),
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
                          controller: targetController,
                          cursorColor:ThemeUtils.getFontThemeColor(context),
                          maxLines: null,
                          decoration:  InputDecoration(
                              border: InputBorder.none
                          )
                      ),
                    )
                ),

              ],
            ),
          ),
          Container(
            height: 120,
          )
        ],
      )  ,
    );
  }
}


