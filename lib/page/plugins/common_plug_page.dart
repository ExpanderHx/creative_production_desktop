

import 'dart:async';

import 'package:bot_toast/bot_toast.dart';
import 'package:clipboard/clipboard.dart';
import 'package:creative_production_desktop/page/plugins/piugins_form_widget.dart';
import 'package:creative_production_desktop/utilities/language_util.dart';
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

import '../../config/const_app.dart';
import '../../config/menu_config.dart';
import '../../network/chat/chat_api.dart';
import '../../network/chat/chat_api_handle.dart';
import '../../network/chat/chat_gpt_open_ai.dart';
import '../../provider/router_provider.dart';
import '../../shortcut_key/shortcut_key_util.dart';
import '../../util/db/isar_db_util.dart';
import '../../util/theme_utils.dart';
import '../chat/bean/chat_message.dart';
import 'bean/plugins_bean.dart';




class CommonPlugPage extends StatefulWidget {
  Map<String,dynamic?>? paramMap;
  CommonPlugPage({super.key,this.paramMap});
  @override
  State<CommonPlugPage> createState() => _TranslatePlugPageState();
}

class _TranslatePlugPageState extends State<CommonPlugPage> {

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
    }
    if(mounted){
      setState(() {

      });
    }
  }

  @override
  void didChangeDependencies(){
    print("---didChangeDependencies---");

  }



  @override
  void didUpdateWidget(CommonPlugPage oldWidget) {
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
        chatApi!.sendMessage(inputTextEditingController.text + text,activeType: activeType).then((response) {
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
            targetController.text = "run_anomaly".tr();
          }
          isLoading = false;
          setState(() {

          });
        });
      }
    }
  }

  void onUpdatePluginsBeanDb({PluginsBean? oldPluginsBean,PluginsBean? newPluginsBean}) async{
    if(null!=oldPluginsBean){
      await ShortcutKeyUtil.unregisterByPluginsBean(oldPluginsBean);
    }
    if(null!=newPluginsBean){
      ShortcutKeyUtil.registerByPluginsBean(newPluginsBean, context.read<RouterProvider>());
    }


  }

  void editPluginsBean() async{
    if(null!=pluginsBeanId){
      await IsarDBUtil().init();
      List<PluginsBean> pluginsBeans =  await IsarDBUtil().isar!.pluginsBeans.where().idEqualTo(int.parse(pluginsBeanId!)).findAll();
      if(null!=pluginsBeans&&pluginsBeans.length>0){
        PluginsBean? oldPluginsBean = pluginsBeans[0];
        if(null!=oldPluginsBean){
          Map<String,dynamic>? map = await showDialog(
              context: context,
              // barrierColor: Colors.red.withAlpha(30),
              barrierDismissible: true,
              builder: (BuildContext context) {
                return Dialog(
                  backgroundColor: Colors.yellow.shade100, // 背景色
                  elevation: 4.0, // 阴影高度
                  insetAnimationDuration: Duration(milliseconds: 300), // 动画时间
                  insetAnimationCurve: Curves.decelerate, // 动画效果
                  insetPadding: const EdgeInsets.all(100), // 弹框距离屏幕边缘距离
                  clipBehavior: Clip.none, // 剪切方式
                  child: PiuginsFormWidget(pluginsBean: oldPluginsBean,),
                );
              }
          );
          print(map);
          map = map ?? {};
          onUpdatePluginsBeanDb(oldPluginsBean: map["oldPluginsBean"],newPluginsBean: map["newPluginsBean"]);
          PluginsBean? newPluginsBean = map["newPluginsBean"];
          if(null!=newPluginsBean){
            setState(() {
              inputTextEditingController.text = newPluginsBean.prompt!;
              onTranslate();
            });
          }
        }
      }

    }



  }



  @override
  Widget build(BuildContext context) {
    //设置尺寸（填写设计中设备的屏幕尺寸）如果设计基于360dp * 690dp的屏幕
    // ScreenUtil.init(context, designSize: const Size(1920, 1080));

    //  color: ThemeUtils.getThemeColor(context),

    // Icon(Icons.construction)
    // Icon(CupertinoIcons.hammer)

    return Container(
      // margin: EdgeInsets.only(left: 20,right: 20),
      padding: EdgeInsets.only(left: 20,right: 20),

      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 90,
                child: Tooltip(
                  message: inputTextEditingController.text,
                  child: TextButton(
                    onPressed: () {
                      editPluginsBean();
                    },
                    child: Text("prompt_word".tr()),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                    height: 50,
                    margin: EdgeInsets.only(top: 20,bottom: 20),
                    child: Container(
                      padding: EdgeInsets.only(left: 10,right: 10),
                      decoration: BoxDecoration(
                        color: ThemeUtils.getThemeColor(context),
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
                      child: TextField(
                          controller: originalController,
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
                              prefixIcon: IconButton(
                                onPressed: () {
                                  // onTranslate();
                                },
                                icon: Tooltip(
                                  message: originalController.text,
                                  child: const Icon(
                                    Icons.info_outline,
                                    color: Color.fromARGB(200, 100, 100, 100),
                                  ),
                                ),
                              )
                          )
                      ),
                    )
                ),
              )
            ],
          ),
          Expanded(
            flex: 1,
            child: Row(
              children: [
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
        message: 'click_run'.tr(),
        child: const Icon(
          Icons.play_arrow,
          color: Color.fromARGB(255, 100, 100, 100),
        ),
      );
    }else{
      sendIconWidget = Tooltip(
        message: 'in_operation'.tr(),
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


