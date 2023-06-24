

import 'package:hotkey_manager/hotkey_manager.dart';
import 'package:screen_text_extractor/screen_text_extractor.dart';

import '../config/const_app.dart';
import '../config/menu_config.dart';
import '../provider/router_provider.dart';
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
        if(null!=extractedScreenSelectionData&&null!=extractedScreenSelectionData.text&&extractedScreenSelectionData!.text!.length>0){
          map[ConstApp.screenSelectionTextKey] = extractedScreenSelectionData.text;
        }else{
          ExtractedData? extractedClipboardData = await screenTextExtractor.extract(mode: ExtractMode.clipboard,);
          if(null!=extractedClipboardData&&null!=extractedClipboardData.text&&extractedClipboardData!.text!.length>0){
            map[ConstApp.screenSelectionTextKey] = extractedClipboardData.text;
          }
          // print(extractedClipboardData?.toJson());
        }



        routerProvider.clickMenu(MenuConfig.menuMap[MenuConfig.plus_in_menu],map:map);
        WindowsUtil.bringToFront();
      },
      // Only works on macOS.
      keyUpHandler: (hotKey){
        print('onKeyUp+${hotKey.toJson()}');
      } ,
    );
  }

}