import 'dart:async';

import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:creative_production_desktop/utilities/language_util.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:launch_at_startup/launch_at_startup.dart';
import 'package:provider/provider.dart';
import 'package:window_manager/window_manager.dart';

import '../../config/const_app.dart';
import '../../config/menu_config.dart';
import '../../network/chat/config/chat_config.dart';
import '../../network/chat/config/chat_http.dart';
import '../../page/model_config/model_config_form_widget.dart';
import '../../page/settings/service_settings_widget.dart';
import '../../provider/router_provider.dart';
import '../../util/preferences_util.dart';
import '../../util/service_util.dart';
import '../../util/theme_utils.dart';
import '../../util/widget/resizable_component.dart';

import '../widget/acrylic_warp.dart';


class LeftSidebar extends StatefulWidget {


  LeftSidebar({
    super.key,
  });

  @override
  _LeftSidebarState createState() => _LeftSidebarState();
}

class _LeftSidebarState extends State<LeftSidebar> {


  bool launchAtStartupIsEnabled = false;

  int service_state = 0;

  @override
  void initState() {
    getLaunchAtStartupIsEnabled();
    timerServiceState();
  }

  void getLaunchAtStartupIsEnabled() async{
    launchAtStartupIsEnabled = await launchAtStartup.isEnabled();
    if(mounted){
      setState(() {

      });
    }
  }

  void updateLaunchAtStartupEnabled() async{
    bool _launchAtStartupIsEnabled = await launchAtStartup.isEnabled();
    if(_launchAtStartupIsEnabled){
      await launchAtStartup.disable();
      launchAtStartupIsEnabled = false;
    }else{
      await launchAtStartup.enable();
      launchAtStartupIsEnabled = true;
    }
    setState(() {

    });
  }

  void updateThemeMode(){
    AdaptiveThemeMode? mode = AdaptiveTheme.maybeOf(context)?.mode;
    if(null!=mode){
      if(mode == AdaptiveThemeMode.light){
        AdaptiveTheme.of(context).setDark();
      }else if(mode == AdaptiveThemeMode.dark){
        AdaptiveTheme.of(context).setSystem();
      }else{
        AdaptiveTheme.of(context).setLight();
      }
    }
  }

  void timerServiceState(){
    Timer.periodic(Duration(seconds: 30), (Timer timer) {
      getServiceState();
    });
  }

  Future<int?> getServiceState() async{
    int _service_state = 0;
    try{
      await PreferencesUtil.perInit();
      String? serviceBaseUrl = PreferencesUtil().get(ConstApp.serviceBaseUrlKey);
      serviceBaseUrl ??= ChatConfig.chatGeneralBaseUrl;
      if(null!=serviceBaseUrl){
        ChatHttp chatHttp = ChatHttp().init(
            baseUrl: serviceBaseUrl
        );
        var responseWrap = await chatHttp.post("/service_state",showErrorToast:false);
        if(null!=responseWrap){
          if(responseWrap.statusCode == 200){
            _service_state = 1;
          }
        }
      }
    }catch(e){
      _service_state = 0;
    }
    setState(() {
      service_state = _service_state;
    });
    return _service_state;

  }

  void serviceStartHandle() async{
    int? _service_state = await getServiceState();
    if(null!=_service_state&&_service_state==1){
      BotToast.showText(text: "server_is_started".tr());
    }else{
      BotToast.showText(text: "starting_the_server".tr());
      ServiceUtil.startServce();
    }
  }


  @override
  Widget build(BuildContext context) {

    // Icon(CupertinoIcons.ellipses_bubble_fill)
    // Icon(CupertinoIcons.ellipsis_circle_fill)

    // Icon(CupertinoIcons.moon_stars)
    // Icon(CupertinoIcons.moon_stars_fill)
    // Icon(CupertinoIcons.moon_fill)

    // Icon(CupertinoIcons.sun_max)
    // Icon(CupertinoIcons.sun_max_fill)
    // Icon(CupertinoIcons.sun_min_fill)
    // Icon(CupertinoIcons.sun_min)

    // Icons.brightness_auto_outlined


    // Icon(Icons.settings)

    RouterProvider routerProvider = context.watch<RouterProvider>();

    Widget themeModeWidget = getThemeModeWidget();

    List<Widget> menuWidgetList = getMenuWidgetList();



    return Container(
      // resizeDirection:ResizeDirection.resizeRight,
      // width: 60,
      // minWidth: 60,
      // maxWidth: 150,
      padding: EdgeInsets.only(left:10,right: 10),
      child: AcrylicWarp(
        child: Container(
          height: double.infinity,
          child: Stack(
            children: [
              Container(
                width: double.infinity,
                child: Column(
                  children: [
                    ...menuWidgetList
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: 100,
                  child: Column(
                    children: [
                      themeModeWidget,
                      Container(
                        width: double.infinity,
                        child: MenuAnchor(

                          menuChildren: _meunList(),
                          builder: (BuildContext context, MenuController controller, Widget? child) {
                            return Tooltip(
                              message: 'set_up'.tr(),
                              child: IconButton(
                                onPressed: () {
                                  if (controller.isOpen) {
                                    controller.close();
                                  } else {
                                    controller.open();
                                  }
                                },
                                icon: Icon(
                                  Icons.settings,
                                  color: Color.fromARGB(255, 124, 124, 124),
                                ),
                              ),
                            );
                          },
                        )
                      ),
                      // Container(
                      //   child: Tooltip(
                      //     message: 'set_up'.tr(),
                      //     child: IconButton(
                      //       onPressed: () {
                      //         print("-------------");
                      //         // sendMessage();
                      //       },
                      //       icon: Icon(
                      //         Icons.settings,
                      //         color: Color.fromARGB(255, 124, 124, 124),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      // Container(
                      //   width: double.infinity,
                      //   child: Tooltip(
                      //     message: 'set_up'.tr(),
                      //     child: IconButton(
                      //       onPressed: () {
                      //         print("-------------");
                      //         // sendMessage();
                      //       },
                      //       icon: Center(
                      //         child: Icon(
                      //           Icons.settings,
                      //           color: Color.fromARGB(255, 124, 124, 124),
                      //         ),
                      //       ),
                      //     ),
                      //   ),
                      // )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> getMenuWidgetList({int? showType}){

    RouterProvider routerProvider = context.watch<RouterProvider>();

    showType = showType == null ? 1 : showType;
    List<Widget> menuWidgetList = [];
    Map<String,dynamic> menuMap = MenuConfig.menuMap;
    if(null!=menuMap&&menuMap.length>0){
      for(var key in menuMap.keys){
        MenuData menuData = menuMap[key];
        if(null!=menuData){
          if(menuData.showType == showType){
            menuWidgetList.add(
                Container(
                  child: Tooltip(
                    message: tr(menuData.menuKey+'_menu'),
                    child: IconButton(
                      onPressed: () {
                        // if(null!=menuData.onPressed){
                        //   menuData.onPressed!();
                        // }
                        menuData.clickMenuWrap(routerProvider);
                        print("-------------");
                      },
                      icon: Icon(
                        menuData.menuIcon,
                        color: (routerProvider.selectedMenuKey == menuData.menuKey ? Color.fromARGB(255, 111, 175, 249) : Color.fromARGB(255, 100, 100, 100)),
                      ),
                    ),
                  ),
                )

            );
          }
        }
      }
    }
    return menuWidgetList;
  }

  Widget getThemeModeWidget(){
    AdaptiveThemeMode? mode = AdaptiveTheme.maybeOf(context)?.mode;
    String modeName = "";
    if((mode == AdaptiveThemeMode.light)){
      modeName = tr('during_the_day');
    }else if((mode == AdaptiveThemeMode.dark)){
      modeName = tr('at_night');
    }else if((mode == AdaptiveThemeMode.system)){
      modeName = tr('with_the_system');
    }
    return Container(
      child: Tooltip(
        message: modeName,
        child: IconButton(
          onPressed: () {
            updateThemeMode();

          },
          icon: Icon(
            (
                null!=mode?
                (
                    (mode == AdaptiveThemeMode.light)?CupertinoIcons.sun_max:
                    (mode == AdaptiveThemeMode.dark)?CupertinoIcons.moon_stars:
                    (mode == AdaptiveThemeMode.system)?Icons.brightness_auto_outlined:
                    CupertinoIcons.moon_stars
                ):
                CupertinoIcons.sun_max
            ),
            color: const Color.fromARGB(255, 111, 175, 249),
          ),
        ),
      ),
    );
  }


  List<Widget> _meunList() {
    return <Widget>[
      MenuItemButton(
        child: Container(
          child: Text("service_settings".tr()),
        ),
        onPressed: () {
          serviceSettingsDialog();
        },
      ),
      MenuItemButton(
        child: Container(
          child: Row(
            children: [
              Container(
                margin: EdgeInsets.only(right: 15,),
                child: Text("start_the_server".tr()),
              ),
              Container(
                width: 15,
                height: 15,
                child: Tooltip(
                  message: (service_state == 1 ? "server_connection_is_normal".tr() : "server_connection_interrupted".tr()),
                  child: ClipOval(
                    child: Container(
                      color:( service_state == 1 ? Colors.green : Colors.black45),
                      child: Text(" "),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        onPressed: () {
          serviceStartHandle();
        },
      ),
      MenuItemButton(
        child: Container(
          child: Row(
            children: [
              Container(
                margin: EdgeInsets.only(right: 15,),
                child: Text("self_start_upon_startup".tr()),
              ),
              Container(
                child: CupertinoSwitch(
                  // overrides the default green color of the track
                  // color of the round icon, which moves from right to left
                  // when the switch is off
                  trackColor: Colors.black12,
                  // boolean variable value
                  value: launchAtStartupIsEnabled,
                  // changes the state of the switch
                  onChanged: (newValue){
                    updateLaunchAtStartupEnabled();
                    // if(null!=onChanged){
                    //   onChanged(newValue);
                    // }
                  },
                ),
              )
            ],
          ),
        ),
        onPressed: () {
          // windowManager.close();
        },
      ),
      MenuItemButton(
        child: Text("exit".tr()),
        onPressed: () {

          exitDialog();
          // windowManager.close();
        },
      ),

    ];
  }


  Future<void> exitDialog() async {
    return showDialog<Null>(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            surfaceTintColor: ThemeUtils.getThemeColor(context),
            title: Text(
                'is_exit'.tr(), style: TextStyle(fontSize: 17.0)),
            actions: <Widget>[
              ElevatedButton(
                child: Text('cancel'.tr()),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              ElevatedButton(
                child: Text('ok'.tr()),
                onPressed: () async {
                  windowManager.close();
                },
              )
            ],
          );
        }
    );
  }

  Future<void> serviceSettingsDialog() async {
    return showDialog<Null>(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return Dialog(
            surfaceTintColor: ThemeUtils.getThemeColor(context),
            child: ServiceSettingsWidget(),
          );
        }
    );
  }



}

