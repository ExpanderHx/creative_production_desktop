

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

import '../config/menu_config.dart';
import '../page/chat_page.dart';
import '../page/plugins/translate_plug_page.dart';

class RouterProvider with ChangeNotifier, DiagnosticableTreeMixin{

  String selectedMenuKey = MenuConfig.chat_menu;
  Function _selectedPage = MenuConfig.pageFunctionWarp(MenuConfig.chat_menu, (menuValueKey,{Map<String,dynamic?>? map})=>ChatPage(key: menuValueKey,paramMap: map,));


  clickMenu(MenuData menuData,{Map<String,dynamic>? map}){
    if(null!=menuData){
      selectedMenuKey = menuData.menuKey;
      var pageFunctionWarp = menuData.pageFunctionWarp();
      if(null!=pageFunctionWarp){
        _selectedPage = () {
          print("map : "+jsonEncode(map));
          return pageFunctionWarp(map:map);
        };
      }
    }
    notifyListeners();
  }

  Widget selectedPage(){
    print('-----------selectedPage--------------');
    return _selectedPage();
  }



  /// Makes `Counter` readable inside the devtools by listing all of its properties
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('selectedMenuKey', selectedMenuKey));
  }



}



// Function _selectedPage = (String selectedMenuKey){return ChatPage(key: ValueKey(selectedMenuKey),);};