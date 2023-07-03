

import 'dart:async';

import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:creative_production_desktop/page/plugins/bean/plugins_bean.dart';
import 'package:creative_production_desktop/page/plugins/config/plugins_config.dart';
import 'package:creative_production_desktop/page/plugins/piugins_form_widget.dart';
import 'package:creative_production_desktop/utilities/language_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:isar/isar.dart';
import 'package:provider/provider.dart';

import '../../config/const_app.dart';
import '../../network/chat/chat_api.dart';
import '../../network/chat/chat_gpt_open_ai.dart';
import '../../util/theme_utils.dart';
import '../provider/router_provider.dart';
import '../shortcut_key/shortcut_key_util.dart';
import '../util/db/isar_db_util.dart';
import 'model_config/bean/chat_model_config.dart';
import 'model_config/model_config_form_widget.dart';





class ModelConfigListPagePage extends StatefulWidget {
  Map<String,dynamic?>? paramMap;
  ModelConfigListPagePage({super.key,this.paramMap});
  @override
  State<ModelConfigListPagePage> createState() => _ModelConfigListPagePageState();
}

class _ModelConfigListPagePageState extends State<ModelConfigListPagePage> {


  List<ChatModelConfig>? chatModelConfigList = [];

  @override
  void initState() {
    geChatModelConfigList();

  }

  void geChatModelConfigList() async{
    IsarDBUtil().init().then((value) async{
      if(null!=IsarDBUtil().isar){
        chatModelConfigList = await IsarDBUtil().isar!.chatModelConfigs.where().findAll();
        if(mounted){
          setState(() {

          });
        }
      }
    });
  }

  void editChatModelConfig({ChatModelConfig? chatModelConfig}) async{
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
            insetPadding: EdgeInsets.all(50), // 弹框距离屏幕边缘距离
            clipBehavior: Clip.none, // 剪切方式
            child: ModelConfigFormWidget(chatModelConfig: chatModelConfig,),
          );
        }
    );
    print(map);
    map = map ?? {};
    onUpdateModelConfigBeanDb();
  }

  void onUpdateModelConfigBeanDb() async{
    geChatModelConfigList();
  }

  deleteonUpdateModelConfigBeanDbById(int id) async{
    if(id!=null){
      await IsarDBUtil().isar!.writeTxn(() async {
        await IsarDBUtil().isar!.chatModelConfigs.delete(id);
      });
    }
  }


  @override
  void didChangeDependencies(){
    geChatModelConfigList();
  }





  @override
  void didUpdateWidget(ModelConfigListPagePage oldWidget) {
    if (widget.paramMap != oldWidget.paramMap) {
      // 参数发生变化
      // 执行你的逻辑操作
      print('参数发生了变化');
    }
    super.didUpdateWidget(oldWidget);
  }






  @override
  Widget build(BuildContext context) {
    //设置尺寸（填写设计中设备的屏幕尺寸）如果设计基于360dp * 690dp的屏幕
    // ScreenUtil.init(context, designSize: const Size(1920, 1080));

    // color: ThemeUtils.getThemeColor(context),

    List<Widget> pluginsWidgetList = getPluginsWidgetList();

    return Container(
      width: double.infinity,
      height: double.infinity,
      margin: const EdgeInsets.only(top: 20,bottom: 20),

      child: Stack(
        children: [
          SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.only(left: 10,right: 10),
              child: Wrap(
                children: [
                  ...pluginsWidgetList
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Container(
              margin:  const EdgeInsets.only(right: 15,bottom: 15),
              child: ClipOval(
                child: Container(
                  color: Color.fromARGB(50, 155, 155, 155),
                  child: Tooltip(
                    message: "add".tr(),
                    child: IconButton(
                      onPressed: () {
                        print("-------------");
                        editChatModelConfig();
                      },
                      icon: const Icon(
                        Icons.add,
                        color: Color.fromARGB(255, 111, 175, 249),
                        size: 50,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  List<Widget> getPluginsWidgetList(){

    // color: ThemeUtils.getThemeColor(context),

    List<Widget> pluginsWidget = [];
    if(null!=chatModelConfigList&&chatModelConfigList!.length>0){
      for(var i=0;i<chatModelConfigList!.length;i++){
        ChatModelConfig chatModelConfig = chatModelConfigList![i];
        if(null!=chatModelConfig){
          pluginsWidget.add(
              Container(
                height: 260,
                width: 260,
                margin:  EdgeInsets.only(left: 20,right: 20,top: 5,bottom: 15),
                decoration: BoxDecoration(
                  color: ThemeUtils.getThemeColor(context),
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  border: Border.all(
                    color: ThemeUtils.getThemeColor(context,lightColor: Color(0Xfff8f9fa),blackColor:  Color(0Xff495057)), // 边框颜色
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
                    ]
                ),
                child: Column(
                  children: [
                    Container(
                      height: 30,
                      padding:  const EdgeInsets.only(left: 5,right: 5),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: ThemeUtils.getThemeColor(context,lightColor: Color(0Xffe9ecef),blackColor:  Color(0Xff495057)), // 边框颜色
                            style: BorderStyle.solid, // 边框样式为实线
                            width: 1.5,
                          )
                        ),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: SelectableText(
                              chatModelConfig.configName??"",
                                style: TextStyle(
                                  color: ThemeUtils.getFontThemeColor(context,lightColor: Color(0Xff343a40),blackColor: Color(0Xfff1f3f5)),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16
                                ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(left: 5),
                            child: GestureDetector(
                              onTap: (){
                                editChatModelConfig(chatModelConfig:chatModelConfig);
                              },
                              child: Tooltip(
                                message: "edit".tr(),
                                child: const Icon(
                                  Icons.edit,
                                  size: 12,
                                  color: Color.fromARGB(255, 124, 124, 124),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(left: 5),
                            child: InkWell(
                              onTap: (){
                                // 删除需要二次确认
                                chatModelConfigDeleteDialog(chatModelConfig);
                              },
                              child: Tooltip(
                                message: "delete".tr(),
                                child: const Icon(
                                  Icons.delete,
                                  size: 12,
                                  color: Color.fromARGB(255, 124, 124, 124),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding:  EdgeInsets.only(left: 5,right: 5,top: 5,bottom: 5),
                        width: double.infinity,
                        height: double.infinity,
                        child: Column(
                          children: [
                            getItemRowWidget('model_name'.tr(),chatModelConfig.modelName),
                            getItemRowWidget('tokenizer'.tr(),chatModelConfig.tokenizerName),
                            getItemRowWidget('global'.tr(),(null!=chatModelConfig.isGlobal?chatModelConfig.isGlobal!.toString():'')),
                            getItemRowWidget('local'.tr(),(null!=chatModelConfig.isLocal?chatModelConfig.isLocal!.toString():'')),
                            getItemRowWidget('max_token'.tr(),(null!=chatModelConfig.maxToken?chatModelConfig.maxToken!.toString():'')),
                            getItemRowWidget('temperature'.tr(),(null!=chatModelConfig.temperature?chatModelConfig.temperature!.toString():'')),
                            getItemRowWidget('base_url'.tr(),(null!=chatModelConfig.baseUrl?chatModelConfig.baseUrl!.toString():'')),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              )
          );
        }
      }
    }
    return pluginsWidget;
  }

  Widget getItemRowWidget(String? title,String? value ){
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 5),
      child: Row(
        children: [
          Container(
            child: SelectableText('${title} :'),
          ),
          // Expanded(
          //   flex:1,
          //   child: Container(),
          // ),
          Expanded(
            flex: 2,
            child: Container(
              child: SelectableText(
                  '${value}',
                textAlign: TextAlign.right,
              ),
            ),
          )
        ],
      ),
    );
  }


  Future<void> chatModelConfigDeleteDialog(ChatModelConfig chatModelConfig) async {
    return showDialog<Null>(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            surfaceTintColor: ThemeUtils.getThemeColor(context),
            title: Text('delete_plugins_title'.tr(), style:  TextStyle(fontSize: 17.0)),
            actions: <Widget>[
                      ElevatedButton(
                        child:  Text('cancel'.tr()),
                        onPressed: (){
                          Navigator.of(context).pop();
                        },
                      ),
                      ElevatedButton(
                        child:  Text('ok'.tr()),
                        onPressed: () async{
                          if(null!=chatModelConfig){
                           await deleteonUpdateModelConfigBeanDbById(chatModelConfig.id);
                          }
                          onUpdateModelConfigBeanDb();
                          var cancel = BotToast.showText(text:"delete_ok".tr());
                          Navigator.of(context).pop();
                        },
                      )
            ],
          );
        }
    );
  }

}


