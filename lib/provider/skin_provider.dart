

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

import '../config/const_app.dart';
import '../config/menu_config.dart';
import '../config/shared_preferences_const.dart';
import '../page/chat_page.dart';
import '../page/plugins/translate_plug_page.dart';
import '../page/skin/config/skin_data.dart';
import '../page/skin/util/skin_config_util.dart';
import '../util/preferences_util.dart';

class SkinProvider with ChangeNotifier, DiagnosticableTreeMixin{

  SkinData? gobalSkinData;

  init() async{
    try{
      gobalSkinData = await SkinConfigUtil.getGlobalChatModelConfig(await SkinConfigUtil.getSkinDataList());
    }catch(e){
      print(e);
    }
  }

  updateGobalSkinData({SkinData? skinData}){
    if(null!=skinData){
      gobalSkinData = skinData;

      notifyListeners();
    }
  }

  //
  // clickMenu(MenuData menuData,{Map<String,dynamic>? map}){
  //   if(null!=menuData){
  //     selectedMenuKey = menuData.menuKey;
  //     if(selectedMenuKey==MenuConfig.plugins_menu){
  //       isShowRightSidebar = 0;
  //     }
  //     if(selectedMenuKey==MenuConfig.chat_menu){
  //       if(isUpdateShowRightSidebar==-1||isUpdateShowRightSidebar==1){
  //         isShowRightSidebar = 1;
  //       }
  //     }
  //
  //
  //     Map<String,dynamic>? paramMap = map;
  //     var pageFunctionWarp = menuData.pageFunctionWarp();
  //     if(null!=pageFunctionWarp){
  //       _selectedPage = ({Map<String,dynamic>? map}) {
  //         print("map : "+jsonEncode(map));
  //         if(null!=paramMap){
  //           if(null!=map){
  //             map!.addAll(paramMap);
  //           }else{
  //             map = paramMap;
  //           }
  //         }
  //         return pageFunctionWarp(map:map);
  //       };
  //     }
  //   }
  //   notifyListeners();
  // }
  //
  // Widget selectedPage({Map<String,dynamic>? paramMap}){
  //   print('-----------selectedPage--------------');
  //   return _selectedPage(map:paramMap);
  // }
  //
  //
  //
  // /// Makes `Counter` readable inside the devtools by listing all of its properties
  // @override
  // void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  //   super.debugFillProperties(properties);
  //   properties.add(StringProperty('selectedMenuKey', selectedMenuKey));
  // }
  //
  // void updateIsShowRightSidebar(int isShowRightSidebarNew){
  //   isShowRightSidebar = isShowRightSidebarNew;
  //   isUpdateShowRightSidebar = isShowRightSidebarNew;
  //   preferencesUtil.setInt(SharedPreferencesConst.isShowRightSidebarKey, isShowRightSidebar);
  //   notifyListeners();
  // }
  //
  // void updateIsShowLeftSidebarNew(int isShowLeftSidebarNew){
  //   isShowLeftSidebar = isShowLeftSidebarNew;
  //   preferencesUtil.setInt(SharedPreferencesConst.isShowRightSidebarKey, isShowRightSidebar);
  //   notifyListeners();
  // }
  //


}
