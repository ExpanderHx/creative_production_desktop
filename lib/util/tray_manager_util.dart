

import 'dart:io';

import 'package:creative_production_desktop/utilities/language_util.dart';
import 'package:tray_manager/tray_manager.dart';
import 'package:window_manager/window_manager.dart';

class TrayManagerUtil{

  static TrayManager? _trayManager;

  static Future<void> init() async{
    _trayManager ??= TrayManager.instance;
    if(_trayManager != null){
      const String _iconPathWin = 'assets/images/system/tray_manager.ico';
      const String _iconPathOther = 'assets/images/system/tray_manager.png';

      await _trayManager!.setIcon(Platform.isWindows ? _iconPathWin : _iconPathOther);
      generateToolTip();
      settingsTrayManagerMenu();
    }


  }

  static void generateToolTip() async {
    if(_trayManager != null){
      await _trayManager!.setToolTip('app_name'.tr());
    }
  }

  static void settingsTrayManagerMenu() async {
    if(_trayManager != null){
      Menu _menu = Menu(items: [
        MenuItem(
            label: '主页',
            onClick: (menuItem) {
              // menuItem.checked = !(menuItem.checked == true);Tray.dispose();
              //           exit(0);
            },
        ),
        // MenuItem(
        //     label: 'Exit',
        //     onClick: (menuItem) {
        //       // _trayManager!.dispose();
        //       // exit(0);
        //       windowManager.close();
        //     }
        // ),
        // MenuItem(label: '数学', toolTip: '的'),
        // MenuItem.checkbox(
        //   label: '英语',
        //   checked: true,
        //   onClick: (menuItem) {
        //     menuItem.checked = !(menuItem.checked == true);
        //   },
        // ),
        // MenuItem.separator(),
        // MenuItem.submenu(
        //   key: 'science',
        //   label: '理科',
        //   submenu: Menu(items: [
        //     MenuItem(label: '物理'),
        //     MenuItem(label: '化学'),
        //     MenuItem(label: '生物'),
        //   ]),
        // ),
        // MenuItem.separator(),
        // MenuItem.submenu(
        //   key: 'arts',
        //   label: '文科',
        //   submenu: Menu(items: [
        //     MenuItem(label: '政治'),
        //     MenuItem(label: '历史'),
        //     MenuItem(label: '地理'),
        //   ]),
        // ),
      ]);
      await trayManager.setContextMenu(_menu);
    }
  }

  static addListener(TrayListener listener){
    if(_trayManager != null){
      _trayManager!.addListener(listener);
    }
  }

  static removeListener(TrayListener listener){
    if(_trayManager != null){
      _trayManager!.removeListener(listener);
    }
  }


  static popUpContextMenu() async{
    if(_trayManager != null){
      await _trayManager!.popUpContextMenu();
    }
  }

  static onTrayIconMouseDown() async{
    await windowManager.show(); // 该方法来自window_manager插件
    await windowManager.focus();
  }


}