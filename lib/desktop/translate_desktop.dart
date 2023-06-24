import 'package:creative_production_desktop/desktop/sidebar/left_sidebar.dart';
import 'package:creative_production_desktop/desktop/widget/app_preferred_size_child.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:creative_production_desktop/utilities/language_util.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:window_manager/window_manager.dart';


import '../config/shared_preferences_const.dart';
import '../page/chat_page.dart';
import '../util/preferences_util.dart';
import '../util/widget/resizable_component.dart';
import '../util/widget/resizable_widget.dart';
import 'app_window_caption/app_window_caption.dart';

class TranslateDesktop extends StatefulWidget {
  const TranslateDesktop({super.key});

  @override
  State<TranslateDesktop> createState() => _TranslateDesktopState();
}

class _TranslateDesktopState extends State<TranslateDesktop> {

  int isShowLeftSidebar = 1;
  var preferencesUtil = PreferencesUtil();


  @override
  void initState() {

    if(null!=preferencesUtil.get(SharedPreferencesConst.isShowLeftSidebarKey)){
      isShowLeftSidebar = preferencesUtil.get("isShowLeftSidebar");
    }

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
            Expanded(
              child: Container(
                constraints: BoxConstraints(minWidth: 300),
                child: const Center(
                  // Center is a layout widget. It takes a single child and positions it
                  // in the middle of the parent.
                  child: ChatPage(),
                ),
              ),
            ),
          ],
        ),
      ),

    );
  }
}

