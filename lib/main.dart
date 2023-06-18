import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:creative_production_desktop/utilities/language_util.dart';
import 'package:flutter/material.dart';
import 'package:hotkey_manager/hotkey_manager.dart';
import 'package:window_manager/window_manager.dart';

import 'generated/codegen_loader.g.dart';

void main(List<String> args) async{

  // 必须加上这一行。 快捷键监听
  WidgetsFlutterBinding.ensureInitialized();

  // 窗口管理初始化
  await windowManager.ensureInitialized();

  // 国际化初始化
  await EasyLocalization.ensureInitialized();

  // 保存的主题类型初始化
  final savedThemeMode = await AdaptiveTheme.getThemeMode();

  WindowOptions windowOptions = WindowOptions(
    size: Size(800, 600),
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
    final windowId = int.parse(args[1]);
    // final argument = args[2].isEmpty
    //     ? const {}
    //     : jsonDecode(args[2]) as Map<String, dynamic>;
    // runApp(_ExampleSubWindow(
    //   windowController: WindowController.fromWindowId(windowId),
    //   args: argument,
    // ));
  } else {

    // 对于热重载，`unregisterAll()` 需要被调用。
    await hotKeyManager.unregisterAll();
    runApp(localization(MyApp(savedThemeMode: savedThemeMode)));
  }
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

  const MyApp({super.key, this.savedThemeMode});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {


    return AdaptiveTheme(
      light: ThemeData.from(colorScheme: const ColorScheme.light(),useMaterial3:true),
      dark: ThemeData.from(colorScheme: const ColorScheme.dark().copyWith(),useMaterial3:true),
      initial: savedThemeMode ?? AdaptiveThemeMode.system,
      builder: (theme, darkTheme) => MaterialApp(
        theme: theme,
        darkTheme: darkTheme,
        builder: BotToastInit(), //1.调用BotToastInit
        navigatorObservers: [BotToastNavigatorObserver()], //2.注册路由观察者
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        home: MyHomePage(),
      ),
    );
  }
}

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
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      AdaptiveTheme.of(context).setDark();
      if(_counter % 2 ==0){
        AdaptiveTheme.of(context).setLight();
      }

      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {

    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kWindowCaptionHeight),
        child: Center(
          child: WindowCaption(
            brightness: Theme.of(context).brightness,
            title: Text('app_name'.tr()),
          ),
        ),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

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
