
import 'dart:ffi';

import 'package:win32/win32.dart';

import '../utilities/platform_util.dart';

final user32 = DynamicLibrary.open('user32.dll');
class WindowsUtil{


  static void bringToFront() {
    if(kIsWindows){
      bringToFrontWindows();
    }
  }

  static void bringToFrontWindows() {
    final hWnd = FindWindowEx(
      NULL,
      NULL,
      TEXT('FLUTTER_RUNNER_WIN32_WINDOW'),
      nullptr,
    );

    if (hWnd != NULL) {
      SetWindowPos(hWnd, HWND_TOPMOST, 0, 0, 0, 0, SWP_NOMOVE | SWP_NOSIZE);
      SetWindowPos(hWnd, HWND_NOTOPMOST, 0, 0, 0, 0, SWP_NOMOVE | SWP_NOSIZE);
    }
  }

}