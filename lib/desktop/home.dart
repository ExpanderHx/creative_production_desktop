import 'dart:convert';

import 'package:creative_production_desktop/desktop/sidebar/left_sidebar.dart';
import 'package:creative_production_desktop/desktop/widget/app_preferred_size_child.dart';
import 'package:desktop_multi_window/desktop_multi_window.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:creative_production_desktop/utilities/language_util.dart';
import 'package:hotkey_manager/hotkey_manager.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:window_manager/window_manager.dart';


import '../config/shared_preferences_const.dart';
import '../page/config/model_config_page.dart';
import '../page/chat_page.dart';
import '../provider/router_provider.dart';
import '../shortcut_key/shortcut_key_util.dart';
import '../util/preferences_util.dart';
import '../util/widget/resizable_component.dart';
import '../util/widget/resizable_widget.dart';
import 'app_window_caption/app_window_caption.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  // const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  // final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  int isShowLeftSidebar = 1;

  var preferencesUtil = PreferencesUtil();


  @override
  void initState() {
    
    if(null!=preferencesUtil.get(SharedPreferencesConst.isShowLeftSidebarKey)){
      isShowLeftSidebar = preferencesUtil.get("isShowLeftSidebar");
    }
    initHotKeyManager();

  }

  void initHotKeyManager() async{
    RouterProvider routerProvider = context.read<RouterProvider>();
    // 注册全部 pluginsBean
    ShortcutKeyUtil.registerPluginsBeanAll(routerProvider);

    // 注册翻译功能
    ShortcutKeyUtil.registerTranslate(routerProvider);

  }
  
  void onSidebarLeftTap(){
    SharedPreferences.getInstance().then((prefs ) {
      prefs.setInt(SharedPreferencesConst.isShowLeftSidebarKey, (isShowLeftSidebar == 1 ? 0 : 1)).then((value){
        setState(() {
          isShowLeftSidebar = (isShowLeftSidebar == 1 ? 0 : 1);
        });
      });
    });
  }


  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kWindowCaptionHeight),
        child: AppPreferredSizeChild(
            onSidebarLeftTap:onSidebarLeftTap,
            isShowLeftSidebar:isShowLeftSidebar
        ),
      ),
      body: Container(
        child: Row(
          children: [
            Visibility(
              child: LeftSidebar(),
              visible: (isShowLeftSidebar==1),
            ),
            Expanded(
              child: Container(
                constraints: BoxConstraints(minWidth: 300),
                child: Center(
                  // Center is a layout widget. It takes a single child and positions it
                  // in the middle of the parent.
                  child: getContent(),
                ),
              ),
            ),

            ResizableComponent(
              width: 200,
              minWidth: 200,
              resizeDirection:ResizeDirection.resizeLeft,
              child:ModelConfigPage()
            )
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: _incrementCounter,
      //   tooltip: 'Increment',
      //   child: const Icon(Icons.add),
      // ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }


  Widget getContent(){
    RouterProvider routerProvider = context.watch<RouterProvider>();
    return routerProvider.selectedPage();
  }


}


// MouseRegion(  onEnter: (_) {    // 鼠标进入组件时，设置鼠标样式为 resize    SystemMouseCursors.resizeColumn.requestMouseCursor();  },  onExit: (_) {    // 鼠标离开组件时，设置鼠标样式为默认    SystemMouseCursors.basic.requestMouseCursor();  },  child: Container(    // 组件内容  ),)



// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key});
//   // const MyHomePage({super.key, required this.title});
//
//   // This widget is the home page of your application. It is stateful, meaning
//   // that it has a State object (defined below) that contains fields that affect
//   // how it looks.
//
//   // This class is the configuration for the state. It holds the values (in this
//   // case the title) provided by the parent (in this case the App widget) and
//   // used by the build method of the State. Fields in a Widget subclass are
//   // always marked "final".
//
//   // final String title;
//
//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   int _counter = 0;
//
//   void _incrementCounter() {
//     setState(() {
//       AdaptiveTheme.of(context).setDark();
//       if(_counter % 2 ==0){
//         AdaptiveTheme.of(context).setLight();
//       }
//
//       // This call to setState tells the Flutter framework that something has
//       // changed in this State, which causes it to rerun the build method below
//       // so that the display can reflect the updated values. If we changed
//       // _counter without calling setState(), then the build method would not be
//       // called again, and so nothing would appear to happen.
//       _counter++;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//
//     // This method is rerun every time setState is called, for instance as done
//     // by the _incrementCounter method above.
//     //
//     // The Flutter framework has been optimized to make rerunning build methods
//     // fast, so that you can just rebuild anything that needs updating rather
//     // than having to individually change instances of widgets.
//     return Scaffold(
//       appBar: PreferredSize(
//         preferredSize: const Size.fromHeight(kWindowCaptionHeight),
//         child: Row(
//           children: [
//             Container(
//               width: ConstApp.LeftSidebar,
//               color: Colors.black,
//             ),
//             Expanded(
//               child: WindowCaption(
//                 brightness: Theme.of(context).brightness,
//                 title: Text('app_name'.tr()),
//               ),
//             )
//
//           ],
//         ),
//       ),
//       body: Center(
//         // Center is a layout widget. It takes a single child and positions it
//         // in the middle of the parent.
//         child: Column(
//           // Column is also a layout widget. It takes a list of children and
//           // arranges them vertically. By default, it sizes itself to fit its
//           // children horizontally, and tries to be as tall as its parent.
//           //
//           // Column has various properties to control how it sizes itself and
//           // how it positions its children. Here we use mainAxisAlignment to
//           // center the children vertically; the main axis here is the vertical
//           // axis because Columns are vertical (the cross axis would be
//           // horizontal).
//           //
//           // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
//           // action in the IDE, or press "p" in the console), to see the
//           // wireframe for each widget.
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             const Text(
//               'You have pushed the button this many times:',
//             ),
//             Text(
//               '$_counter',
//               style: Theme.of(context).textTheme.headlineMedium,
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _incrementCounter,
//         tooltip: 'Increment',
//         child: const Icon(Icons.add),
//       ), // This trailing comma makes auto-formatting nicer for build methods.
//     );
//   }
// }