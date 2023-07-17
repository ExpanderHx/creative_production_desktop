



import 'package:flutter/material.dart';
import 'package:tray_manager/tray_manager.dart';
import 'package:win32/win32.dart';
import 'package:window_manager/window_manager.dart';

import '../utilities/platform_util.dart';

// final user32 = DynamicLibrary.open('user32.dll');
class WindowsUtil{


  static Offset lastShownPosition = Offset.zero;

  static Future<void> _windowShow({
    bool isShowBelowTray = false,
  }) async {
    bool isAlwaysOnTop = await windowManager.isAlwaysOnTop();
    Size windowSize = await windowManager.getSize();

    if (kIsLinux) {
      await windowManager.setPosition(lastShownPosition);
    }

    if (kIsMacOS && isShowBelowTray) {
      Rect? trayIconBounds = await trayManager.getBounds();
      if (trayIconBounds != null) {
        Size trayIconSize = trayIconBounds.size;
        Offset trayIconPosition = trayIconBounds.topLeft;

        Offset newPosition = Offset(
          trayIconPosition.dx - ((windowSize.width - trayIconSize.width) / 2),
          trayIconPosition.dy,
        );

        if (!isAlwaysOnTop) {
          await windowManager.setPosition(newPosition);
        }
      }
    }

    bool isVisible = await windowManager.isVisible();
    print("isVisible : $isVisible");
    if (isVisible) {
      // if(kIsMacOS){
      //   await windowManager.close();
      //   await Future.delayed(const Duration(milliseconds: 100));
      //   await windowManager.show();
      // }
      await windowManager.focus();
    } else {
      if(kIsMacOS){
        await windowManager.close();
        await Future.delayed(const Duration(milliseconds: 100));
      }
      await windowManager.show();

    }

    // Linux 下无法激活窗口临时解决方案
    if (kIsLinux && !isAlwaysOnTop) {
      await windowManager.setAlwaysOnTop(true);
      await Future.delayed(const Duration(milliseconds: 10));
      await windowManager.setAlwaysOnTop(false);
      await Future.delayed(const Duration(milliseconds: 10));
      await windowManager.focus();
    }
  }

  static void bringToFront() {
    _windowShow();

    // windowManager.focus();
    // if(kIsWindows){
    //   bringToFrontWindows();
    // }
  }

  static void bringToFrontWindows() {
    // final hWnd = FindWindowEx(
    //   NULL,
    //   NULL,
    //   TEXT('FLUTTER_RUNNER_WIN32_WINDOW'),
    //   nullptr,
    // );
    //
    // if (hWnd != NULL) {
    //   SetWindowPos(hWnd, HWND_TOPMOST, 0, 0, 0, 0, SWP_NOMOVE | SWP_NOSIZE);
    //   SetWindowPos(hWnd, HWND_NOTOPMOST, 0, 0, 0, 0, SWP_NOMOVE | SWP_NOSIZE);
    // }
  }

}