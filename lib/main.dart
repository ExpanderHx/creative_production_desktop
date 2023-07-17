import 'dart:io';

import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:creative_production_desktop/page/skin/config/skin_data.dart';
import 'package:creative_production_desktop/provider/router_provider.dart';
import 'package:creative_production_desktop/provider/skin_provider.dart';
import 'package:creative_production_desktop/util/db/isar_db_util.dart';
import 'package:creative_production_desktop/util/init_utils.dart';
import 'package:creative_production_desktop/util/preferences_util.dart';
import 'package:creative_production_desktop/util/talker_utils.dart';
import 'package:creative_production_desktop/util/theme_utils.dart';
import 'package:creative_production_desktop/utilities/language_util.dart';
import 'package:creative_production_desktop/utilities/platform_util.dart';
import 'package:desktop_webview_window/desktop_webview_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter_acrylic/window.dart';
import 'package:flutter_acrylic/window_effect.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hotkey_manager/hotkey_manager.dart';
import 'package:launch_at_startup/launch_at_startup.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';
import 'package:window_manager/window_manager.dart';

import 'desktop/home.dart';
import 'desktop/translate_desktop.dart';
import 'generated/codegen_loader.g.dart';

import 'package:flex_color_scheme/flex_color_scheme.dart';

void main(List<String> args) async{

  // 必须加上这一行。 快捷键监听
  WidgetsFlutterBinding.ensureInitialized();

  // 保存的主题类型初始化
  final savedThemeMode = await AdaptiveTheme.getThemeMode();

  // 国际化初始化
  await EasyLocalization.ensureInitialized();

  if (runWebViewTitleBarWidget(args)) {
    return;
  }


  // 窗口半透明效果
  await Window.initialize();
  await Window.setEffect(
    effect: WindowEffect.acrylic,
    color: Color(0xCCA1A1A1),
  );
  // await Window.setEffect(
  //   effect: WindowEffect.acrylic,
  //   dark: true,
  // );

  // 初始化PreferencesUtil
  PreferencesUtil();

  // 初始化数据库
  // IsarDBUtil();
  await IsarDBUtil().init();

  await InitUtils.init();



  WindowOptions windowOptions = const WindowOptions(
    size: Size(900, 600),
    center: true,
    backgroundColor: Colors.transparent,
    skipTaskbar: false,
    titleBarStyle: TitleBarStyle.hidden,
  );
  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
  });



  if (args.firstOrNull == 'multi_window') {
    print('执行了窗口：$args');
    final windowId = int.parse(args[1]);
    print('窗口ID$windowId');
    // final argument = args[2].isEmpty
    //     ? const {}
    //     : jsonDecode(args[2]) as Map<String, dynamic>;
    runApp(localization(MyApp(savedThemeMode: savedThemeMode,homeWidget: const TranslateDesktop())));
  } else {




    // 窗口管理初始化
    if (kIsLinux || kIsMacOS || kIsWindows) {
      await windowManager.ensureInitialized();
    }



    // 对于热重载，`unregisterAll()` 需要被调用。
    await hotKeyManager.unregisterAll();
    // runApp(localization(MyApp(savedThemeMode: savedThemeMode,homeWidget: const MyHomePage())));
    runApp(multiMainProvider(localization(MyApp(savedThemeMode: savedThemeMode,homeWidget: const MyHomePage()))));
  }
}

Widget multiMainProvider(Widget widget){
  return MultiProvider(
    providers: [
      ChangeNotifierProvider<RouterProvider>(create: (_) => RouterProvider()),
      ChangeNotifierProvider<SkinProvider>(create: (_) => SkinProvider()),
    ],
    builder: (BuildContext context, Widget? child){
      RouterProvider routerProvider = context.read<RouterProvider>();
      routerProvider.init();
      SkinProvider skinProvider = context.read<SkinProvider>();
      skinProvider.init();
      return widget;
    },

  );

  // child: widget,
}

Widget localization(Widget widget){
  // return widget;
  return EasyLocalization(
    supportedLocales: const [
      Locale(kLanguageEN),
      Locale(kLanguageZH),
    ],
    path: 'assets/translations',
    // assetLoader: CodegenLoader(),
    fallbackLocale: const Locale(kLanguageEN),
    child: widget,
  );
}



class MyApp extends StatelessWidget {

  final AdaptiveThemeMode? savedThemeMode;

  final Widget? homeWidget;

  const MyApp({super.key, this.savedThemeMode,this.homeWidget});



  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {





    // light = light.copyWith(scaffoldBackgroundColor:Colors.transparent);
    // dark = dark.copyWith(scaffoldBackgroundColor:Colors.transparent);

    // light = light.copyWith(highlightColor:Colors.transparent);
    // light = light.copyWith(hintColor:Colors.transparent);
    // light = light.copyWith(indicatorColor:Colors.transparent);
    // light = light.copyWith(dialogBackgroundColor:Colors.transparent);
    // light = light.copyWith(focusColor:Colors.transparent);
    // light = light.copyWith(hoverColor:Colors.transparent);
    // light = light.copyWith(disabledColor:Colors.transparent);
    // light = light.copyWith(dividerColor:Colors.transparent);

    // light = light.copyWith(secondaryHeaderColor:Colors.transparent);
    // light = light.copyWith(shadowColor:Colors.transparent);
    // light = light.copyWith(splashColor:Colors.transparent);
    // light = light.copyWith(unselectedWidgetColor:Colors.transparent);
    // light = light.copyWith(cardColor:Colors.transparent);



    // light = light.copyWith(primaryColorDark:Colors.transparent);


    // light = light.copyWith(canvasColor:Colors.transparent);
    // light = light.copyWith(primaryColorDark:Colors.transparent);
    // light = light.copyWith(primaryColorLight:Colors.transparent);
    // light = light.copyWith(scaffoldBackgroundColor:Colors.transparent);






    // dark = light.copyWith(primaryColorDark:Colors.transparent);


    // light = light.copyWith(colorScheme:light.colorScheme.copyWith(background:  Colors.transparent));
    // dark = dark.copyWith(colorScheme:dark.colorScheme.copyWith(background:  Colors.transparent));

    // light.copyWith(colorScheme:light.colorScheme.copyWith(background:  Colors.transparent));
    // light.copyWith(colorScheme:light.colorScheme.copyWith(primary:  Colors.transparent));
    // dark.copyWith(colorScheme:dark.colorScheme.copyWith(background:  Colors.transparent));
    // dark.copyWith(colorScheme:dark.colorScheme.copyWith(primary:  Colors.transparent));
    // light.copyWith(backgroundColor:Colors.transparent);
    // dark.copyWith(backgroundColor:Colors.transparent);
    // fontFamily .copyWith(primaryColor: Colors.transparent)

    return AdaptiveTheme(
      light: FlexThemeData.light(fontFamily: "Ping Fang",useMaterial3: true,scheme:FlexScheme.flutterDash),
      dark: FlexThemeData.dark(fontFamily: "Ping Fang",useMaterial3: true,scheme:FlexScheme.flutterDash),
      initial: savedThemeMode ?? AdaptiveThemeMode.system,
      debugShowFloatingThemeButton:false,
      builder: (theme, darkTheme){
        return ScreenUtilInit(
            designSize: const Size(1920, 1080),
            minTextAdapt: true,
            splitScreenMode: true,
            builder: (context , child){

              theme = ThemeUtils.defaultThemeData(theme);
              SkinProvider skinProvider = context.watch<SkinProvider>();
              theme = ThemeUtils.skinThemeDataHandle(theme,skinProvider.gobalSkinData);

              return MaterialApp(
                theme: theme,
                darkTheme: darkTheme,
                builder: BotToastInit(), //1.调用BotToastInit
                navigatorObservers: [BotToastNavigatorObserver()], //2.注册路由观察者
                localizationsDelegates: context.localizationDelegates,
                supportedLocales: context.supportedLocales,
                locale: context.locale,
                home: homeWidget,
              );
            }
        );
      },
    );
  }
}


// light: ThemeData(colorScheme: const ColorScheme.light().copyWith(brightness: Brightness.light,primary:Colors.white),fontFamily: "Ping Fang",useMaterial3:true),
// dark: ThemeData(colorScheme: const ColorScheme.dark().copyWith(brightness: Brightness.dark,primary:Colors.black),fontFamily: "Ping Fang",useMaterial3:true),


//  light: ThemeData.from(colorScheme: const ColorScheme.light().copyWith(primary:Colors.blue),useMaterial3:true),
//       dark: ThemeData.from(colorScheme: const ColorScheme.dark().copyWith(primary:Colors.blue),useMaterial3:true),


//
// MaterialApp(
// title: 'Flutter Demo',
// builder: BotToastInit(), //1.调用BotToastInit
// navigatorObservers: [BotToastNavigatorObserver()], //2.注册路由观察者
// theme: ThemeData(
// // This is the theme of your application.
// //
// // TRY THIS: Try running your application with "flutter run". You'll see
// // the application has a blue toolbar. Then, without quitting the app,
// // try changing the seedColor in the colorScheme below to Colors.green
// // and then invoke "hot reload" (save your changes or press the "hot
// // reload" button in a Flutter-supported IDE, or press "r" if you used
// // the command line to start the app).
// //
// // Notice that the counter didn't reset back to zero; the application
// // state is not lost during the reload. To reset the state, use hot
// // restart instead.
// //
// // This works for code too, not just values: Most code changes can be
// // tested with just a hot reload.
// colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
// useMaterial3: true,
// ),
// home: const MyHomePage(title: 'Flutter Demo Home Page'),
// )
















// return AdaptiveTheme(
// light: ThemeData(
// colorScheme: ColorScheme.fromSeed(seedColor: Colors.white,brightness: Brightness.light),
// primaryColor: const Color(0xff416ff4),
// canvasColor: const Color(0xff282828),
// scaffoldBackgroundColor: const Color(0xff1d1d1d),
// useMaterial3: true,
// ),
// dark: ThemeData(
// colorScheme: ColorScheme.fromSeed(seedColor: Colors.black, brightness: Brightness.dark,),
// useMaterial3: true,
// ),
// initial: AdaptiveThemeMode.dark,
// builder: (theme, darkTheme) => MaterialApp(
// title: 'Flutter Demo',
// theme: darkTheme,
// darkTheme: darkTheme,
// builder: BotToastInit(), //1.调用BotToastInit
// navigatorObservers: [BotToastNavigatorObserver()], //2.注册路由观察者
// home: const MyHomePage(title: 'Flutter Demo Home Page'),
// ),
// );
