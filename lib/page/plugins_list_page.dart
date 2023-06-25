

import 'dart:async';

import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:creative_production_desktop/page/plugins/bean/plugins_bean.dart';
import 'package:creative_production_desktop/page/plugins/config/plugins_config.dart';
import 'package:creative_production_desktop/page/plugins/piugins_form_widget.dart';
import 'package:creative_production_desktop/utilities/language_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:isar/isar.dart';

import '../../config/const_app.dart';
import '../../network/chat/chat_api.dart';
import '../../network/chat/chat_gpt_open_ai.dart';
import '../../util/theme_utils.dart';
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
        var pluginsBeans = await IsarDBUtil().isar!.pluginsBeans.where().findAll();
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

  void onUpdatePluginsBeanDb(){
    getPluginsDataList();
    // Timer(const Duration(milliseconds: 100), () {
    //
    // });

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
                      showDialog(
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
                              child: PiuginsFormWidget(onUpdatePluginsBeanDb:onUpdatePluginsBeanDb),
                            );
                          }
                       );
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
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  border: Border.all(
                    color: Color.fromARGB(255, 0,0,0), // 边框颜色
                    style: BorderStyle.solid, // 边框样式为实线
                    width: 1.5,
                  ),
                ),
                child: Column(
                  children: [
                    Container(
                      height: 30,
                      padding:  const EdgeInsets.only(left: 5,right: 5),
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Color.fromARGB(255, 0,0,0), // 边框颜色
                            style: BorderStyle.solid, // 边框样式为实线
                            width: 1.5,
                          )
                        ),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(pluginsBean.title??""),
                          ),
                          Container(
                            child: Text((pluginsBean.type!=null&&pluginsBean.type==PluginsConfig.pluginsTypeTranslate?"翻译":"通用")),
                          ),
                          Container(
                            margin: const EdgeInsets.only(left: 5),
                            child: const Icon(
                              Icons.edit,
                              size: 12,
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(left: 5),
                            child: InkWell(
                              onTap: (){

                              },
                              child: Icon(
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
                            pluginsBean.prompt??"---"
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

}


