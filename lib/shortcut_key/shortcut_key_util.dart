

import 'dart:convert';
import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:hotkey_manager/hotkey_manager.dart';
import 'package:isar/isar.dart';
import 'package:ocr_engine_builtin/ocr_engine_builtin.dart';
import 'package:screen_capturer/screen_capturer.dart';
import 'package:screen_text_extractor/screen_text_extractor.dart';
import 'package:uni_ocr_client/uni_ocr_client.dart';

import '../config/const_app.dart';
import '../config/menu_config.dart';
import '../page/plugins/bean/plugins_bean.dart';
import '../provider/router_provider.dart';
import '../util/db/isar_db_util.dart';
import '../util/windows_util.dart';
import '../utilities/utilities.dart';

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
              map[ConstApp.promptStatementsKey] = pluginsBean.prompt;
              map[ConstApp.pluginsBeanIdKey] = pluginsBean.id.toString();

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

  static void registerOcr(RouterProvider routerProvider){
    // ⌥ + Q
    HotKey _hotKey = HotKey(
      KeyCode.keyL,
      modifiers: [KeyModifier.alt],
      // Set hotkey scope (default is HotKeyScope.system)
      scope: HotKeyScope.system, // Set as inapp-wide hotkey.
    );

    hotKeyManager.register(
      _hotKey,
      keyDownHandler: (hotKey) async{
        String? imagePath;
        if (!kIsWeb) {
          Directory userDataDirectory = await getUserDataDirectory();
          int timestamp = DateTime.now().millisecondsSinceEpoch;
          String fileName = 'Screenshot-$timestamp.png';
          imagePath = '${userDataDirectory.path}/Screenshots/$fileName';
        }
        CapturedData? _capturedData = await ScreenCapturer.instance.capture(
          imagePath: imagePath,
        );

        if (_capturedData == null) {
          BotToast.showText(
            text: 'page_desktop_popup.msg_capture_screen_area_canceled'.tr(),
            align: Alignment.center,
          );

          return;
        } else {
          try {

            String base64Image = base64Encode(_capturedData!.imageBytes!);
            await Future.delayed(const Duration(milliseconds: 10));
            RecognizeTextResponse recognizeTextResponse = await BuiltInOcrEngine(identifier: 'String identifier').recognizeText(RecognizeTextRequest(
              imagePath: _capturedData?.imagePath,
              base64Image: base64Image,
            ));

            Clipboard.setData(ClipboardData(text: recognizeTextResponse.text));

          } catch (error) {
            String errorMessage = error.toString();
            if (error is UniOcrClientError) {
              errorMessage = error.message;
            }
            BotToast.showText(
              text: errorMessage,
              align: Alignment.center,
            );
          }
        }

      },
      // Only works on macOS.
      keyUpHandler: (hotKey){
        print('onKeyUp+${hotKey.toJson()}');
      } ,
    );
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
          // if(kIsMacOS){
          //   registerOcr(routerProvider);
          // }
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
                    if(hotKey.modifiers!.length == _hotKey.modifiers!.length){
                      bool isAllEqual = true;
                      for(var i=0;i<hotKey.modifiers!.length;i++){
                        bool isEqual = false;
                        for(var z=0;z<_hotKey.modifiers!.length;z++){
                          if(hotKey.modifiers![i].keyLabel == _hotKey.modifiers![z].keyLabel){
                            isEqual = true;
                          }
                        }
                        if(!isEqual){
                          isAllEqual = false;
                        }
                      }
                      if(isAllEqual){
                        await hotKeyManager.unregister(_hotKey);
                        return;
                      }
                    }

                    // listEquals(hotKey.modifiers,_hotKey.modifiers);
                    // if(jsonEncode(hotKey.modifiers) == jsonEncode(_hotKey.modifiers)){
                    //   await hotKeyManager.unregister(_hotKey);
                    //   return;
                    // }

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