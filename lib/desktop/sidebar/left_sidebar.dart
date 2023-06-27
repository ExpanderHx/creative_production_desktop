import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:creative_production_desktop/utilities/language_util.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:window_manager/window_manager.dart';

import '../../config/menu_config.dart';
import '../../provider/router_provider.dart';
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

  @override
  void initState() {

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
                        child: Tooltip(
                          message: 'set_up'.tr(),
                          child: IconButton(
                            onPressed: () {
                              print("-------------");
                              // sendMessage();
                            },
                            icon: Icon(
                              Icons.settings,
                              color: Color.fromARGB(255, 124, 124, 124),
                            ),
                          ),
                        ),
                      ),
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
}

