

import 'dart:async';

import 'package:bot_toast/bot_toast.dart';
import 'package:clipboard/clipboard.dart';
import 'package:creative_production_desktop/utilities/language_util.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

import '../../config/const_app.dart';
import '../../config/menu_config.dart';
import '../../network/chat/chat_api.dart';
import '../../network/chat/chat_api_handle.dart';
import '../../network/chat/chat_gpt_open_ai.dart';
import '../../provider/skin_provider.dart';
import '../../util/model_config/model_config_util.dart';
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

  String? pluginsBeanId;


  String activeType = MenuConfig.plugins_translate_menu;

  bool isLoading = false;

  @override
  void initState() {
    // chatApi = ChatApiGeneral();
    chatApi = ChatApiHandle();
    paramMapHandle();

    changeOriginalText();
  }

  @override
  void didChangeDependencies(){
    print("---didChangeDependencies---");

  }

  void paramMapHandle(){
    if(widget.paramMap!=null){
      Map<String,dynamic?> paramMap = widget.paramMap!;
      if(null!=paramMap[ConstApp.screenSelectionTextKey]){
        originalController.text = paramMap[ConstApp.screenSelectionTextKey];
      }
      if(null!=paramMap[ConstApp.promptStatementsKey]){
        inputTextEditingController.text = paramMap[ConstApp.promptStatementsKey];
      }
      if(null!=paramMap[ConstApp.pluginsBeanIdKey]){
        pluginsBeanId = paramMap[ConstApp.pluginsBeanIdKey];
      }
      if(null!=paramMap!["activeType"]&&paramMap!["activeType"].length>0){
        activeType = paramMap!["activeType"];
      }
    }else{
      inputTextEditingController.text = "请将以下内容翻译为中文 : ";
    }
    if(mounted){
      setState(() {

      });
    }
  }


  @override
  void didUpdateWidget(TranslatePlugPage oldWidget) {
    if (widget.paramMap != oldWidget.paramMap) {
      // 参数发生变化
      // 执行你的逻辑操作
      print('参数发生了变化');
      paramMapHandle();
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
      setState(() {
        isLoading = true;
      });
      if(null != chatApi){
        print("发起请求 ------- ");
        chatApi!.sendMessage(ModelConfigUtil.combinationPromptAndInput(prompt: inputTextEditingController.text,input: text),activeType: activeType).then((response) {
          print("接收内容 ------- ");
          if(null!=response&&response.statusCode==200){
            if(originalController.text == text){
              String? responseMessage = response.responseMessage;
              if(null!=responseMessage){
                targetController.text = responseMessage;
              }
              print("处理完成 ： "+response.toString());
            }
          }else{
            targetController.text = "translation_anomaly".tr();
          }
          isLoading = false;
          setState(() {

          });
        });
      }
    }
  }



  @override
  Widget build(BuildContext context) {
    //设置尺寸（填写设计中设备的屏幕尺寸）如果设计基于360dp * 690dp的屏幕
    // ScreenUtil.init(context, designSize: const Size(1920, 1080));
    // color: ThemeUtils.getThemeColor(context),

    SkinProvider skinProvider = context.watch<SkinProvider>();

    return Container(
      // margin: EdgeInsets.only(left: 20,right: 20),
      padding: EdgeInsets.only(left: 20,right: 20),

      child: Column(
        children: [
          Container(
            height: 50,
            margin: EdgeInsets.only(top: 20,bottom: 20),
            child: Container(
              padding: EdgeInsets.only(left: 10,right: 10),
              decoration: BoxDecoration(
                color: ThemeUtils.getGobalSkinDataThemeColor(
                    context,
                    gobalSkinData: skinProvider.gobalSkinData,
                    imageBackgroundColor: Color.fromARGB(25, 50,50,50)
                ),
                borderRadius: BorderRadius.all(Radius.circular(8)),
                border: Border.all(
                  color: Color.fromARGB(125, 67,67,67), // 边框颜色
                  style: BorderStyle.solid, // 边框样式为实线
                  width: 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: ThemeUtils.getGobalSkinDataBackgroundThemeColor(
                        context,lightColor: Color.fromARGB(25, 0,0,0),
                        blackColor: Color.fromARGB(25, 255,255,255),
                    )!, // 阴影颜色
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
                      suffixIcon: IconButton(
                        onPressed: () {
                          onTranslate();
                        },
                        icon: getSendIconWidget(),
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
                       color: ThemeUtils.getGobalSkinDataThemeColor(
                           context,
                           gobalSkinData: skinProvider.gobalSkinData,
                           imageBackgroundColor: Color.fromARGB(25, 50,50,50)
                       ),
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        border: Border.all(
                          color: const Color.fromARGB(125, 67,67,67), // 边框颜色
                          style: BorderStyle.solid, // 边框样式为实线
                          width: 1,
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
                      child: Column(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: originalController,
                              cursorColor:ThemeUtils.getFontThemeColor(context),
                              maxLines: null,
                              decoration:  InputDecoration(
                                border: InputBorder.none,
                              ),

                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 5),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Container(),
                                ),
                                Container(
                                  child: IconButton(
                                    onPressed: () {
                                      originalController.clear();
                                    },
                                    icon: Icon(
                                      Icons.close,
                                      color: Color.fromARGB(255, 120, 121, 131),
                                    ),
                                  ),
                                ),
                                Container(
                                  child: IconButton(
                                    onPressed: () {
                                      String text = originalController.text ?? "";
                                      FlutterClipboard.copy(text).then(( value ) {
                                        BotToast.showText(text:"the_copy_succeeded".tr());
                                      });
                                    },
                                    icon: Icon(
                                      Icons.copy,
                                      color: Color.fromARGB(255, 120, 121, 131),
                                    ),
                                  ),
                                )

                              ],
                            ),
                          )
                        ],
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
                        color: ThemeUtils.getGobalSkinDataThemeColor(
                            context,
                            gobalSkinData: skinProvider.gobalSkinData,
                            imageBackgroundColor: Color.fromARGB(25, 50,50,50)
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        border: Border.all(
                          color: Color.fromARGB(125, 67,67,67), // 边框颜色
                          style: BorderStyle.solid, // 边框样式为实线
                          width: 1,
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
                      child: Column(
                        children: [
                          Expanded(
                            child: TextField(
                                controller: targetController,
                                cursorColor:ThemeUtils.getFontThemeColor(context),
                                maxLines: null,
                                decoration:  InputDecoration(
                                    border: InputBorder.none
                                )
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 5),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Container(),
                                ),
                                Container(
                                  child: IconButton(
                                    onPressed: () {
                                      targetController.clear();
                                    },
                                    icon: Icon(
                                      Icons.close,
                                      color: Color.fromARGB(255, 120, 121, 131),
                                    ),
                                  ),
                                ),
                                Container(
                                  child: IconButton(
                                    onPressed: () {
                                      String text = targetController.text ?? "";
                                      FlutterClipboard.copy(text).then(( value ) {
                                        BotToast.showText(text:"the_copy_succeeded".tr());
                                      });
                                    },
                                    icon: Icon(
                                        Icons.copy,
                                      color: Color.fromARGB(255, 120, 121, 131),
                                    ),
                                  ),
                                )

                              ],
                            ),
                          )
                        ],
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


  Widget getSendIconWidget(){
    Widget sendIconWidget = Container();
    if(!isLoading){
      sendIconWidget = Tooltip(
        message: 'click_translate'.tr(),
        child: const Icon(
          Icons.translate,
          color: Color.fromARGB(255, 222, 222, 229),
        ),
      );
    }else{
      sendIconWidget = Tooltip(
        message: 'in_translation'.tr(),
        child: SizedBox(
          width: 20,
          height: 20,
          child: LoadingAnimationWidget.hexagonDots(
            color: const Color.fromARGB(255, 120, 120, 120),
            size: 20,
          ),
        ),
      );
    }

    return sendIconWidget;

  }

}


