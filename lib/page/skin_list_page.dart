

import 'dart:async';
import 'dart:io';

import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:creative_production_desktop/page/plugins/bean/plugins_bean.dart';
import 'package:creative_production_desktop/page/plugins/config/plugins_config.dart';
import 'package:creative_production_desktop/page/plugins/piugins_form_widget.dart';
import 'package:creative_production_desktop/page/skin/config/skin_data.dart';
import 'package:creative_production_desktop/page/skin/skin_form_widget.dart';
import 'package:creative_production_desktop/page/skin/util/skin_config_util.dart';
import 'package:creative_production_desktop/utilities/language_util.dart';
import 'package:desktop_webview_window/desktop_webview_window.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:isar/isar.dart';
import 'package:provider/provider.dart';

import '../config/const_app.dart';
import '../network/chat/chat_api.dart';
import '../network/chat/chat_gpt_open_ai.dart';
import '../provider/skin_provider.dart';
import '../util/db/isar_db_util.dart';
import '../util/theme_utils.dart';





class SkinListPage extends StatefulWidget {
  Map<String,dynamic?>? paramMap;
  SkinListPage({super.key,this.paramMap});
  @override
  State<SkinListPage> createState() => _SkinListPageState();
}

class _SkinListPageState extends State<SkinListPage> {

  List<SkinData> skinDataList = [];

  @override
  void initState() {
    getSkinDataList();

  }

  void getSkinDataList() async{
    IsarDBUtil().init().then((value) async{
      if(null!=IsarDBUtil().isar){
        List<SkinData>? skinDatas = await SkinConfigUtil.getSkinDataList();
        if(null!=skinDatas&&skinDatas.isNotEmpty){
          skinDataList = skinDatas;
          if(mounted){
            setState(() {

            });
          }
        }
      }
    });
  }

  void updateSkinDataGlobal({SkinData? skinData}) async{
    if(null!=skinData){
      skinData.isGlobal = true;
      await IsarDBUtil().init();
      if(null!=IsarDBUtil().isar){
        List<SkinData>? skinDatas = await SkinConfigUtil.getSkinDataList();
        if(null!=skinDatas&&skinDatas.isNotEmpty){
          for(var i=0; i<skinDatas.length;i++){
            SkinData skinDataS = skinDatas[i];
            if(null!=skinDataS){
              skinDataS.isGlobal = false;
              await IsarDBUtil().isar!.writeTxn(() async {
                await  IsarDBUtil().isar!.skinDatas.put(skinDataS);
              });
            }
          }
        }
      }
      await IsarDBUtil().isar!.writeTxn(() async {
        await  IsarDBUtil().isar!.skinDatas.put(skinData);
      });

      SkinProvider skinProvider = context.read<SkinProvider>();
      skinProvider.updateGobalSkinData(skinData: skinData);
    }
  }

  void editSkinData({SkinData? skinData}) async{
    // final webView = await WebviewWindow.create();
    // webView.addScriptToExecuteOnDocumentCreated('''
    //   window.onload = function() {
    //     console.log("Hello Flutter");
    //     if(null!=document.querySelector('#txt2img_prompt textarea')){
    //       document.querySelector('#txt2img_prompt textarea').value = "test";
    //     }
    //
    //   }
    // ''');
    // webView.launch("http://127.0.0.1:7860");
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
            child: SkinDataFormWidget(skinData: skinData,),
          );
        }
    );
    print(map);
    map = map ?? {};
   getSkinDataList();
  }

  void onUpdatePluginsBeanDb({PluginsBean? oldPluginsBean,PluginsBean? newPluginsBean}) async{
    // if(null!=oldPluginsBean){
    //   await ShortcutKeyUtil.unregisterByPluginsBean(oldPluginsBean);
    // }
    // if(null!=newPluginsBean){
    //   ShortcutKeyUtil.registerByPluginsBean(newPluginsBean, context.read<RouterProvider>());
    // }
    // getPluginsDataList();
    // Timer(const Duration(milliseconds: 100), () {
    //
    // });

  }

  deleteSkinDataById(int id) async{
    if(id!=null){
      await IsarDBUtil().isar!.writeTxn(() async {
        await IsarDBUtil().isar!.skinDatas.delete(id);
      });
    }
    getSkinDataList();
  }


  @override
  void didChangeDependencies(){
    getSkinDataList();
  }





  @override
  void didUpdateWidget(SkinListPage oldWidget) {
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

    List<Widget> skinDataWidgetList = getSkinDataWidgetList();

    //  color: ThemeUtils.getThemeColor(context),


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
                  ...skinDataWidgetList
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

                        editSkinData();
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

  List<Widget> getSkinDataWidgetList(){
    SkinProvider skinProvider = context.watch<SkinProvider>();

    List<Widget> skinDataWidgetList = [];
    if(null!=skinDataList&&skinDataList.length>0){
      for(var i=0;i<skinDataList.length;i++){
        SkinData skinData = skinDataList[i];
        if(null!=skinData){

          skinData.type = skinData.type ?? 0;

          Widget? imgWidget;
          if(skinData.type == 0){
            skinData.name = "solid_color".tr();
            imgWidget = Container(

            );
          }else if(skinData.type == 1){
            if(skinData.image !=null){
              if(skinData.image == "assets/images/background/background_1.webp"){
                skinData.name = "sea_of_stars".tr();
              }else if(skinData.image == "assets/images/background/background_2.webp"){
                skinData.name = "forest".tr();
              }else if(skinData.image == "assets/images/background/background_3.jpg"){
                skinData.name = "blue_ocean".tr();
              }
              imgWidget = Image(
                image: AssetImage(
                    skinData.image!,
                ),
                fit:BoxFit.fill
              );
            }

          }else if(skinData.type == 2){
            imgWidget = Image.file(
                File(skinData.image!),
                fit:BoxFit.fill
            );
          }



          skinDataWidgetList.add(

              GestureDetector(
                onTap: (){
                  updateSkinDataGlobal(skinData:skinData);
                },
                child: Container(
                  height: 200,
                  width: 300,
                  margin: EdgeInsets.only(left: 15,right: 15,bottom: 15,top: 15),
                  child: Card(
                    shadowColor: Colors.black,
                    elevation:5,
                    clipBehavior:Clip.antiAlias,
                    child: Stack(
                      children: [
                        Container(
                          width: double.infinity,
                          height: double.infinity,
                          child: Column(
                            children: [
                              Expanded(
                                child: Container(
                                  // padding:  EdgeInsets.only(left: 5,right: 5,top: 5,bottom: 5),
                                  width: double.infinity,
                                  height: double.infinity,
                                  child: imgWidget,
                                ),
                              )
                            ],
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            height: 35,
                            color: Color( 0x33000000),
                            padding: EdgeInsets.only(left: 5,right: 5,bottom: 5,top: 5),
                            child: Row(
                              children: [
                                Expanded(
                                  child: SelectableText(
                                    skinData.name??"",
                                    style: TextStyle(
                                      // color: ThemeUtils.getFontThemeColor(context,lightColor: Color(0Xff343a40),blackColor: Color(0Xfff1f3f5)),
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16,
                                        color: Color(0xffffffff)
                                    ),
                                  ),
                                ),

                                Container(
                                  margin: const EdgeInsets.only(left: 5),
                                  child: GestureDetector(
                                    onTap: (){
                                      updateSkinDataGlobal(skinData:skinData);
                                    },
                                    child: Tooltip(
                                      message: "open_the_skin".tr(),
                                      child:  Icon(
                                        Icons.open_in_new,
                                        size: 15,
                                        color: Color(0xffffffff),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(left: 5),
                                  child: GestureDetector(
                                    onTap: (){
                                      editSkinData(skinData:skinData);
                                    },
                                    child: Tooltip(
                                      message: "edit".tr(),
                                      child: const Icon(
                                        Icons.edit,
                                        size: 15,
                                        color: Color(0xffffffff),
                                      ),
                                    ),
                                  ),
                                ),
                                ((skinData.type!=null&&skinData.type == 2)?
                                Container(
                                  margin: const EdgeInsets.only(left: 5),
                                  child: InkWell(
                                    onTap: (){
                                      // 删除需要二次确认
                                      skinDataDeleteDialog(skinData);
                                    },
                                    child: Tooltip(
                                      message: "delete".tr(),
                                      child: const Icon(
                                        Icons.delete,
                                        size: 15,
                                        color: Color(0xffffffff),
                                      ),
                                    ),
                                  ),
                                )
                                    :
                                Container()

                                )
                              ],

                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )
          );
        }
      }
    }
    return skinDataWidgetList;
  }

  List<Widget> getSkinDataWidgetList_1(){

    SkinProvider skinProvider = context.watch<SkinProvider>();

    List<Widget> skinDataWidgetList = [];
    if(null!=skinDataList&&skinDataList.length>0){
      for(var i=0;i<skinDataList.length;i++){
        SkinData skinData = skinDataList[i];
        if(null!=skinData){

          skinData.type = skinData.type ?? 0;

          Widget? imgWidget;
          if(skinData.type == 0){
            skinData.image = "solid_color".tr();
            imgWidget = Container(

            );
          }else if(skinData.type == 1){
            if(skinData.image !=null){
              if(skinData.image == "assets/images/background/background_1.webp"){
                skinData.name = "sea_of_stars".tr();
              }else if(skinData.image == "assets/images/background/background_2.webp"){
                skinData.name = "forest".tr();
              }else if(skinData.image == "assets/images/background/background_3.jpg"){
                skinData.name = "blue_ocean".tr();
              }
              imgWidget = Image(
                image: AssetImage(skinData.image!),
              );
            }

          }else if(skinData.type == 2){
            imgWidget = Image.file(
                File(skinData.image!),
                fit:BoxFit.contain
            );
          }
          
          skinDataWidgetList.add(
              Container(
                height: 160,
                width: 200,
                margin:  EdgeInsets.only(left: 20,right: 20,top: 5,bottom: 15),
                decoration: BoxDecoration(
                    color: ThemeUtils.getThemeColor(
                      context,
                      lightColor: ThemeUtils.getGobalSkinDataThemeColor(
                        context,
                        gobalSkinData: skinProvider.gobalSkinData,
                        imageBackgroundColor: Color.fromARGB(0, 255, 255, 255),
                      )!,
                      blackColor: ThemeUtils.getGobalSkinDataThemeColor(
                        context,
                        gobalSkinData: skinProvider.gobalSkinData,
                        imageBackgroundColor: Color.fromARGB(0, 255, 255, 255),
                      )!,
                    ),
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
                              skinData.name??"",
                              style: TextStyle(
                                  // color: ThemeUtils.getFontThemeColor(context,lightColor: Color(0Xff343a40),blackColor: Color(0Xfff1f3f5)),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16
                              ),
                            ),
                          ),

                          Container(
                            margin: const EdgeInsets.only(left: 5),
                            child: GestureDetector(
                              onTap: (){
                                updateSkinDataGlobal(skinData:skinData);
                              },
                              child: Tooltip(
                                message: "open_the_skin".tr(),
                                child: const Icon(
                                  Icons.open_in_new,
                                  size: 12,
                                  color: Color.fromARGB(255, 124, 124, 124),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(left: 5),
                            child: GestureDetector(
                              onTap: (){
                                editSkinData(skinData:skinData);
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
                          ((skinData.type!=null&&skinData.type == 2)?
                              Container(
                                margin: const EdgeInsets.only(left: 5),
                                child: InkWell(
                                  onTap: (){
                                    // 删除需要二次确认
                                    skinDataDeleteDialog(skinData);
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
                              :
                              Container()

                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding:  EdgeInsets.only(left: 5,right: 5,top: 5,bottom: 5),
                        width: double.infinity,
                        height: double.infinity,
                        child: imgWidget,
                      ),
                    )
                  ],
                ),
              )
          );
        }
      }
    }
    return skinDataWidgetList;
  }


  Future<void> skinDataDeleteDialog(SkinData skinData) async {
    return showDialog<Null>(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            surfaceTintColor: ThemeUtils.getThemeColor(context),
            title: Text('delete_skin_title'.tr(), style:  TextStyle(fontSize: 17.0)),
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
                  if(null!=skinData){
                    await deleteSkinDataById(skinData.id);
                  }

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


