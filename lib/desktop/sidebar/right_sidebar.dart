import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:creative_production_desktop/utilities/language_util.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:window_manager/window_manager.dart';

import '../../config/menu_config.dart';
import '../../page/model_config/model_config_page.dart';
import '../../provider/router_provider.dart';
import '../../util/widget/resizable_component.dart';

import '../widget/acrylic_warp.dart';


class RightSidebar extends StatefulWidget {


  Widget? child;
  RightSidebar({
    super.key,
    this.child
  });

  @override
  _RightSidebarState createState() => _RightSidebarState();
}

class _RightSidebarState extends State<RightSidebar> {

  @override
  void initState() {

  }

  void updateThemeMode(){
    AdaptiveThemeMode? mode = AdaptiveTheme.maybeOf(context)?.mode;
    if(null!=mode){
      if(mode == AdaptiveThemeMode.light){
        AdaptiveTheme.of(context).setDark();
      }else if(mode == AdaptiveThemeMode.dark){
        AdaptiveTheme.of(context).setSystem();
      }else{
        AdaptiveTheme.of(context).setLight();
      }
    }
  }


  @override
  Widget build(BuildContext context) {



    RouterProvider routerProvider = context.watch<RouterProvider>();


    return Container(
        padding: const EdgeInsets.only(left:10,right: 10),
        child:widget.child
    );
    // return ResizableComponent(
    //     width: 200,
    //     minWidth: 200,
    //     maxWidth: 1100.w,
    //     resizeDirection:ResizeDirection.resizeLeft,
    //     child:widget.child
    // );
  }


}

