

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

import '../config/const_app.dart';
import '../config/menu_config.dart';
import '../config/shared_preferences_const.dart';
import '../page/chat_page.dart';
import '../page/plugins/translate_plug_page.dart';
import '../util/preferences_util.dart';

class RouterProvider with ChangeNotifier, DiagnosticableTreeMixin{

  String selectedMenuKey = MenuConfig.chat_menu;
  Function _selectedPage = MenuConfig.pageFunctionWarp(MenuConfig.chat_menu, (menuValueKey,{Map<String,dynamic?>? map})=>ChatPage(key: menuValueKey,paramMap: map,));

  int isShowRightSidebar = 1;

  int isShowLeftSidebar = 1;

  var preferencesUtil = PreferencesUtil();


  init(){
    try{
      int? _isShowLeftSidebar = preferencesUtil.get(SharedPreferencesConst.isShowLeftSidebarKey);
      int? _isShowRightSidebar = preferencesUtil.get(SharedPreferencesConst.isShowRightSidebarKey);
      if(null!=isShowLeftSidebar){
        isShowLeftSidebar = _isShowLeftSidebar!;
      }
      if(null!=isShowRightSidebar){
        isShowRightSidebar = _isShowRightSidebar!;
      }
      // notifyListeners();
    }catch(e){
      print(e);
    }
  }


  clickMenu(MenuData menuData,{Map<String,dynamic>? map}){
    if(null!=menuData){
      selectedMenuKey = menuData.menuKey;
      Map<String,dynamic>? paramMap = map;
      var pageFunctionWarp = menuData.pageFunctionWarp();
      if(null!=pageFunctionWarp){
        _selectedPage = ({Map<String,dynamic>? map}) {
          print("map : "+jsonEncode(map));
          if(null!=paramMap){
            if(null!=map){
              map!.addAll(paramMap);
            }else{
              map = paramMap;
            }
          }
          return pageFunctionWarp(map:map);
        };
      }
    }
    notifyListeners();
  }

  Widget selectedPage({Map<String,dynamic>? paramMap}){
    print('-----------selectedPage--------------');
    return _selectedPage(map:paramMap);
  }



  /// Makes `Counter` readable inside the devtools by listing all of its properties
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('selectedMenuKey', selectedMenuKey));
  }

  void updateIsShowRightSidebar(int isShowRightSidebarNew){
    isShowRightSidebar = isShowRightSidebarNew;
    preferencesUtil.setInt(SharedPreferencesConst.isShowRightSidebarKey, isShowRightSidebar);
    notifyListeners();
  }

  void updateIsShowLeftSidebarNew(int isShowLeftSidebarNew){
    isShowLeftSidebar = isShowLeftSidebarNew;
    preferencesUtil.setInt(SharedPreferencesConst.isShowRightSidebarKey, isShowRightSidebar);
    notifyListeners();
  }



}



// Function _selectedPage = (String selectedMenuKey){return ChatPage(key: ValueKey(selectedMenuKey),);};