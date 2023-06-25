

import 'package:creative_production_desktop/page/plugins_list_page.dart';
import 'package:flutter/cupertino.dart';

import '../page/chat_page.dart';

import '../page/plugins/translate_plug_page.dart';
import '../provider/router_provider.dart';

class MenuConfig{

  static String chat_menu = "chat";
  static String plus_in_menu = "plus_in";

  static Map<String,dynamic> menuMap = {
    "chat": MenuData( "聊天",chat_menu,CupertinoIcons.ellipses_bubble_fill,showType:1,pageFunction:(menuValueKey,{Map<String,dynamic?>? map})=>ChatPage(key: menuValueKey,paramMap: map,) ),
    "plus_in": MenuData( "插件",plus_in_menu,CupertinoIcons.goforward_plus,showType:1,pageFunction:(menuValueKey,{Map<String,dynamic?>? map})=>PluginsListPage(key: menuValueKey,paramMap: map,) ),
    "plus_in_1": MenuData( "插件",plus_in_menu,CupertinoIcons.goforward_plus,showType:0,pageFunction:(menuValueKey,{Map<String,dynamic?>? map})=>TranslatePlugPage(key: menuValueKey,paramMap: map,) ),
  };


  static pageFunctionWarp(String menuKey,functionPage){
    return ({Map<String,dynamic?>? map}){return functionPage(ValueKey(menuKey),map:map);};
  }



}

class MenuData{
  String menuName;
  String menuKey;
  IconData menuIcon;
  int? showType;  // 1 显示在侧边栏上方 2 显示在侧边栏下方 0 不显示
  Function? pageFunction;
  Function? onPressed;
  dynamic? page;



  MenuData(this.menuName,this.menuKey,this.menuIcon,{this.pageFunction,this.showType,this.onPressed,this.page});

  clickMenuWrap(RouterProvider routerProvider){
    return routerProvider.clickMenu(this);
  }

  // 为统一RouterProvider中初始化_selectedPage 此函数暂不使用
  pageFunctionWarp(){
    if(null!=menuKey&&null!=pageFunction){
      return MenuConfig.pageFunctionWarp(menuKey, pageFunction);
    }
    return null;
  }

}


// "CHAT": MenuData( "聊天","CHAT",CupertinoIcons.ellipses_bubble_fill,showType:1,pageFunction: (String selectedMenuKey){return const ChatPage();} ),