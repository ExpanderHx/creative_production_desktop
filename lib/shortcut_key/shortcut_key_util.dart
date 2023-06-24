

import 'package:hotkey_manager/hotkey_manager.dart';

class ShortcutKeyUtil{


  static void registerTranslate(){
    // ⌥ + Q
    HotKey _hotKey = HotKey(
      KeyCode.keyQ,
      modifiers: [KeyModifier.alt],
      // Set hotkey scope (default is HotKeyScope.system)
      scope: HotKeyScope.inapp, // Set as inapp-wide hotkey.
    );

    hotKeyManager.register(
      _hotKey,
      keyDownHandler: (hotKey) async{

      },
      // Only works on macOS.
      keyUpHandler: (hotKey){
        print('onKeyUp+${hotKey.toJson()}');
      } ,
    );
  }

}