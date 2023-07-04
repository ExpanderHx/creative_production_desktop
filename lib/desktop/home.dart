import 'dart:async';
import 'dart:convert';
import 'dart:io';

// import 'package:acrylic_any/acrylic_any.dart';
import 'package:creative_production_desktop/desktop/sidebar/left_sidebar.dart';
import 'package:creative_production_desktop/desktop/sidebar/right_sidebar.dart';
import 'package:creative_production_desktop/desktop/app_window_caption/app_preferred_size_child.dart';
import 'package:creative_production_desktop/util/db/isar_db_util.dart';
import 'package:desktop_multi_window/desktop_multi_window.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:creative_production_desktop/utilities/language_util.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hotkey_manager/hotkey_manager.dart';
import 'package:multi_split_view/multi_split_view.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tray_manager/tray_manager.dart';
import 'package:window_manager/window_manager.dart';


import '../config/shared_preferences_const.dart';

import '../page/chat_page.dart';
import '../page/model_config/model_config_page.dart';
import '../page/skin/config/skin_data.dart';
import '../provider/router_provider.dart';
import '../provider/skin_provider.dart';
import '../shortcut_key/shortcut_key_util.dart';
import '../util/preferences_util.dart';
import '../util/tray_manager_util.dart';
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

class _MyHomePageState extends State<MyHomePage> with TrayListener{



  var preferencesUtil = PreferencesUtil();


  @override
  void initState() {

    initHotKeyManager();
    trayManagerInit();
    super.initState();

  }

  void trayManagerInit(){
    TrayManagerUtil.init().then((value){
      TrayManagerUtil.addListener(this);
    });

  }

  @override
  void dispose() {
    // TODO: implement dispose
    IsarDBUtil().isar!.close();
    TrayManagerUtil.removeListener(this);
    super.dispose();
  }

  @override
  void onTrayIconRightMouseDown() async {
    await TrayManagerUtil.popUpContextMenu();
  }

  @override
  void onTrayMenuItemClick(MenuItem menuItem) {
    print(menuItem.label);
    TrayManagerUtil.onTrayIconMouseDown();
  }

  @override
  void onTrayIconMouseDown() {
    TrayManagerUtil.onTrayIconMouseDown();
  }

  void initHotKeyManager() async{
    RouterProvider routerProvider = context.read<RouterProvider>();
    // 注册全部 pluginsBean
    ShortcutKeyUtil.registerPluginsBeanAll(routerProvider);

    // 注册翻译功能
    ShortcutKeyUtil.registerTranslate(routerProvider);

  }
  



  @override
  Widget build(BuildContext context) {


    RouterProvider routerProvider = context.watch<RouterProvider>();

    double leftSidebarWeight = 0;
    double contentWeight = ScreenUtil().screenWidth;
    double rightSidebarWeight = 0;
    

    List<Widget> multiSplitViewChildren = [];
    if(routerProvider.isShowLeftSidebar==1){
      multiSplitViewChildren.add(LeftSidebar());
      leftSidebarWeight = 60;
    }
    multiSplitViewChildren.add(Container(child: getContent()));
    if(routerProvider.isShowRightSidebar==1){
      multiSplitViewChildren.add(RightSidebar(
          child:ModelConfigPage(
            activeType: routerProvider.selectedMenuKey,
          )
      ));
      rightSidebarWeight = 245;
    }

    List<Area> areaList = [];
    if(leftSidebarWeight>0){
      areaList.add(Area(size: leftSidebarWeight,minimalSize: 60));
    }
    areaList.add(Area(size: (contentWeight - leftSidebarWeight - rightSidebarWeight), minimalWeight: 0.3));
    if(rightSidebarWeight>0){
      areaList.add(Area(size: rightSidebarWeight,minimalSize: 200));
    }

    // NetworkImage('https://www.beihaiting.com/uploads/allimg/180114/10723-1P1140Z0092b.jpg'),
    SkinProvider skinProvider = context.watch<SkinProvider>();
    SkinData? gobalSkinData = skinProvider.gobalSkinData;
    BoxDecoration? decoration;
    if(null!=gobalSkinData){
      if(null!=gobalSkinData.type){
        if(null!=gobalSkinData.image&&!gobalSkinData.image!.isEmpty){
          if(gobalSkinData.type==1){
            decoration = BoxDecoration(
              image: DecorationImage(
                image: AssetImage(gobalSkinData.image!),
                fit: BoxFit.fill, // 完全填充
              ),
            );
          }else if(gobalSkinData.type==2){
            decoration = BoxDecoration(
              image: DecorationImage(
                image: FileImage(
                    File(gobalSkinData.image!)
                ),
                fit: BoxFit.fill, // 完全填充
              ),
            );
          }
        }

      }
    }

    return Container(
      decoration: decoration,
      child: Scaffold(
        // backgroundColor: Colors.transparent,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kWindowCaptionHeight + 20),
          child: AppPreferredSizeChild(),
        ),
        body: Container(
          child: MultiSplitViewTheme(
              data:MultiSplitViewThemeData(
                  dividerPainter: DividerPainters.grooved1(
                      color: Colors.indigo[100]!,
                      backgroundColor: Color.fromARGB(25, 0,0,0),
                      highlightedColor: Colors.indigo[900]!),
                  dividerThickness:5
              ),
              child: MultiSplitView(
                children: [
                  ...multiSplitViewChildren
                ],
                controller: MultiSplitViewController(
                    areas: areaList
                ),
                // initialAreas: [
                //   Area(size: 60,minimalSize: 60),
                //   Area(weight:0.9,minimalWeight: 0.3),
                //   Area(size: 240,minimalSize: 200),
                // ]
              )
          ),
        ),
        // floatingActionButton: FloatingActionButton(
        //   onPressed: _incrementCounter,
        //   tooltip: 'Increment',
        //   child: const Icon(Icons.add),
        // ),
        // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }


  Widget getContent(){
    RouterProvider routerProvider = context.watch<RouterProvider>();
    Map<String,dynamic>? paramMap = {};
    paramMap["activeType"] = routerProvider.selectedMenuKey;
    return routerProvider.selectedPage(paramMap:paramMap);
  }

  Widget getRightSidebarWidget(){
    RouterProvider routerProvider = context.watch<RouterProvider>();
    return Visibility(
      visible: (routerProvider.isShowRightSidebar==1),
      child: RightSidebar(
          child:ModelConfigPage(
            activeType: routerProvider.selectedMenuKey,
          )
      ),
    );
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