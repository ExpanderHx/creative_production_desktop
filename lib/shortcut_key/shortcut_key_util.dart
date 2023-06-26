

import 'dart:convert';

import 'package:hotkey_manager/hotkey_manager.dart';
import 'package:isar/isar.dart';
import 'package:screen_text_extractor/screen_text_extractor.dart';

import '../config/const_app.dart';
import '../config/menu_config.dart';
import '../page/plugins/bean/plugins_bean.dart';
import '../provider/router_provider.dart';
import '../util/db/isar_db_util.dart';
import '../util/windows_util.dart';

class ShortcutKeyUtil{


  static void registerTranslate(RouterProvider routerProvider){
    // ⌥ + Q
    HotKey _hotKey = HotKey(
      KeyCode.keyQ,
      modifiers: [KeyModifier.alt],
      // Set hotkey scope (default is HotKeyScope.system)
      scope: HotKeyScope.system, // Set as inapp-wide hotkey.
    );

    hotKeyManager.register(
      _hotKey,
      keyDownHandler: (hotKey) async{
        ExtractedData? extractedScreenSelectionData = await screenTextExtractor.extract(mode: ExtractMode.screenSelection,);

        Map<String,dynamic> map = {};
        String? extractedDataText = await getExtractedDataText();
        if(null!=extractedDataText){
          map[ConstApp.screenSelectionTextKey] = extractedDataText;
        }

        routerProvider.clickMenu(MenuConfig.menuMap[MenuConfig.plugins_translate_menu],map:map);
        WindowsUtil.bringToFront();
      },
      // Only works on macOS.
      keyUpHandler: (hotKey){
        print('onKeyUp+${hotKey.toJson()}');
      } ,
    );
  }

  static void registerByPluginsBean(PluginsBean pluginsBean,RouterProvider routerProvider){

    if(null!=pluginsBean){

      if(null!=pluginsBean.isOpenShortcutKeys&&pluginsBean.isOpenShortcutKeys!){
        if(null!=pluginsBean.hotKeyJsonString){
          HotKey _hotKey = HotKey.fromJson(jsonDecode(pluginsBean.hotKeyJsonString!));
          hotKeyManager.register(
            _hotKey,
            keyDownHandler: (hotKey) async{
              Map<String,dynamic> map = {};
              String? extractedDataText = await getExtractedDataText();
              if(null!=extractedDataText){
                map[ConstApp.screenSelectionTextKey] = extractedDataText;
              }
              pluginsBean.type = (pluginsBean.type ?? MenuConfig.plugins_translate_menu);
              routerProvider.clickMenu(MenuConfig.menuMap[("plugins_"+pluginsBean.type!)],map:map);
              WindowsUtil.bringToFront();
            },
            // Only works on macOS.
            keyUpHandler: (hotKey){
              print('onKeyUp+${hotKey.toJson()}');
            } ,
          );
        }
      }
    }



  }

  static void registerPluginsBeanAll(RouterProvider routerProvider){
    IsarDBUtil().init().then((value) async{
      if(null!=IsarDBUtil().isar){
        List<PluginsBean> pluginsBeans = await IsarDBUtil().isar!.pluginsBeans.where().findAll();
        if(null!=pluginsBeans&&pluginsBeans.length>0){
          hotKeyManager.unregisterAll();
          for(var i=0;i<pluginsBeans.length;i++){
            registerByPluginsBean(pluginsBeans[i],routerProvider);
          }
        }
      }
    });



  }

  static unregisterByPluginsBean(PluginsBean pluginsBean) async{
    if(null!=pluginsBean){
      if(null!=pluginsBean.isOpenShortcutKeys&&pluginsBean.isOpenShortcutKeys!){
        if(null!=pluginsBean.hotKeyJsonString){
          HotKey _hotKey = HotKey.fromJson(jsonDecode(pluginsBean.hotKeyJsonString!));
          if(null!=_hotKey){
            List<HotKey> registeredHotKeyList = hotKeyManager.registeredHotKeyList;
            if(null!=registeredHotKeyList&&registeredHotKeyList.length>0){
              for(var i=0;i<registeredHotKeyList.length;i++){
                HotKey hotKey = registeredHotKeyList[i];
                if(hotKey.keyCode==_hotKey.keyCode){
                  if(null!=hotKey.modifiers&&null!=_hotKey.modifiers){
                    if(jsonEncode(hotKey.modifiers) == jsonEncode(_hotKey.modifiers)){
                      await hotKeyManager.unregister(_hotKey);
                      return;
                    }
                  }
                }
              }
            }
          }
        }
      }
    }
  }

  static Future<String?> getExtractedDataText() async{
    ExtractedData? extractedScreenSelectionData = await screenTextExtractor.extract(mode: ExtractMode.screenSelection,);

    if(null!=extractedScreenSelectionData&&null!=extractedScreenSelectionData.text&&extractedScreenSelectionData!.text!.length>0){
      return Future.value(extractedScreenSelectionData.text);
    }else{
      ExtractedData? extractedClipboardData = await screenTextExtractor.extract(mode: ExtractMode.clipboard,);
      if(null!=extractedClipboardData&&null!=extractedClipboardData.text&&extractedClipboardData!.text!.length>0){
        return Future.value(extractedClipboardData.text);
      }
    }
  }

}