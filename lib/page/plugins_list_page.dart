

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





class PluginsListPage extends StatefulWidget {
  Map<String,dynamic?>? paramMap;
  PluginsListPage({super.key,this.paramMap});
  @override
  State<PluginsListPage> createState() => _PluginsListPageState();
}

class _PluginsListPageState extends State<PluginsListPage> {

  List<PluginsBean> pluginsBeanList = [];

  @override
  void initState() {
    getPluginsDataList();

  }

  void getPluginsDataList() async{
    IsarDBUtil().init().then((value) async{
      if(null!=IsarDBUtil().isar){
        // var pluginsBeanCollection = IsarDBUtil().isar!.collection<PluginsBean>();
        List<PluginsBean> pluginsBeans = await IsarDBUtil().isar!.pluginsBeans.where().findAll();
        // var pluginsBeans = await IsarDBUtil().isar!.pluginsBeans.getAll([]);
        // var pluginsBeans = await pluginsBeanCollection.getAll([]);
        // var pluginsBeans = await pluginsBeanCollection.where().findAll();
        print(pluginsBeans);
        if(null!=pluginsBeans&&pluginsBeans.length>0){
          if(mounted){
            setState(() {
              pluginsBeanList = pluginsBeans;
            });
          }else{
            pluginsBeanList = pluginsBeans;
          }

        }

      }
    });
  }

  void editPluginsBean({PluginsBean? pluginsBean}) async{
    Map<String,dynamic> map = await showDialog(
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
            child: PiuginsFormWidget(onUpdatePluginsBeanDb:onUpdatePluginsBeanDb,pluginsBean: pluginsBean,),
          );
        }
    );
    print(map);
    map = map ?? {};
    onUpdatePluginsBeanDb(oldPluginsBean: map["oldPluginsBean"],newPluginsBean: map["newPluginsBean"]);
  }

  void onUpdatePluginsBeanDb({PluginsBean? oldPluginsBean,PluginsBean? newPluginsBean}) async{
    if(null!=oldPluginsBean){
      await ShortcutKeyUtil.unregisterByPluginsBean(oldPluginsBean);
    }
    if(null!=newPluginsBean){
      ShortcutKeyUtil.registerByPluginsBean(newPluginsBean, context.read<RouterProvider>());
    }
    getPluginsDataList();
    // Timer(const Duration(milliseconds: 100), () {
    //
    // });

  }

  deletePluginsBeanById(int id) async{
    if(id!=null){
      await IsarDBUtil().isar!.writeTxn(() async {
        await IsarDBUtil().isar!.pluginsBeans.delete(id);
      });
    }
  }


  @override
  void didChangeDependencies(){
    getPluginsDataList();
  }





  @override
  void didUpdateWidget(PluginsListPage oldWidget) {
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

    List<Widget> pluginsWidgetList = getPluginsWidgetList();

    return Container(
      width: double.infinity,
      height: double.infinity,
      margin: const EdgeInsets.only(top: 20,bottom: 20),
      color: ThemeUtils.getThemeColor(context),
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
                  child: IconButton(
                    onPressed: () {
                      print("-------------");
                      editPluginsBean();
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
          )
        ],
      ),
    );
  }

  List<Widget> getPluginsWidgetList(){
    List<Widget> pluginsWidget = [];
    if(null!=pluginsBeanList&&pluginsBeanList.length>0){
      for(var i=0;i<pluginsBeanList.length;i++){
        PluginsBean pluginsBean = pluginsBeanList[i];
        if(null!=pluginsBean){
          pluginsWidget.add(
              Container(
                height: 200,
                width: 200,
                margin:  EdgeInsets.only(left: 5,right: 5,top: 5,bottom: 5),
                decoration: BoxDecoration(
                  color: ThemeUtils.getThemeColor(context,lightColor: Color(0Xfff8f9fa),blackColor:  Color(0Xff212529)),
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  border: Border.all(
                    color: ThemeUtils.getThemeColor(context,lightColor: Color(0Xfff8f9fa),blackColor:  Color(0Xff495057)), // 边框颜色
                    style: BorderStyle.solid, // 边框样式为实线
                    width: 1.5,
                  ),
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
                            child: Text(
                                pluginsBean.title??"",
                                style: TextStyle(
                                  color: ThemeUtils.getFontThemeColor(context,lightColor: Color(0Xff343a40),blackColor: Color(0Xfff1f3f5)),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16
                                ),
                            ),
                          ),
                          Container(
                            child: Text((pluginsBean.type!=null&&pluginsBean.type==PluginsConfig.pluginsTypeTranslate?"翻译":"通用"),
                              style: TextStyle(
                                  color: ThemeUtils.getFontThemeColor(context,lightColor: Color(0Xff343a40),blackColor: Color(0Xfff1f3f5)),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(left: 5),
                            child: GestureDetector(
                              onTap: (){
                                editPluginsBean(pluginsBean:pluginsBean);
                              },
                              child: const Icon(
                                Icons.edit,
                                size: 12,
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(left: 5),
                            child: InkWell(
                              onTap: (){
                                // 删除需要二次确认
                                pluginsBeanDeleteDialog(pluginsBean);
                              },
                              child: const Icon(
                                Icons.delete,
                                size: 12,
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
                        child: Text(
                          (pluginsBean.prompt??"---"),
                          style: TextStyle(
                              color: ThemeUtils.getFontThemeColor(context,lightColor: Color(0Xff343a40),blackColor: Color(0Xfff1f3f5)),
                              fontWeight: FontWeight.w700,
                              fontSize: 12
                          ),
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


  Future<void> pluginsBeanDeleteDialog(PluginsBean pluginsBean) async {
    return showDialog<Null>(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            surfaceTintColor: ThemeUtils.getThemeColor(context),
            title: Text('你确定要删除当前插件吗?', style:  TextStyle(fontSize: 17.0)),
            actions: <Widget>[
                      ElevatedButton(
                        child:  Text('取消'),
                        onPressed: (){
                          Navigator.of(context).pop();
                        },
                      ),
                      ElevatedButton(
                        child:  Text('确定'),
                        onPressed: () async{
                          if(null!=pluginsBean){
                           await deletePluginsBeanById(pluginsBean.id);
                          }
                          onUpdatePluginsBeanDb(oldPluginsBean:pluginsBean );
                          var cancel = BotToast.showText(text:"删除成功");
                          Navigator.of(context).pop();
                        },
                      )
            ],
          );
        }
    );
  }

}


