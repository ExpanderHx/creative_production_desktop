import 'package:creative_production_desktop/utilities/language_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

import '../app_window_caption/app_window_caption.dart';


class AppPreferredSizeChild extends StatefulWidget {


  Function? onSidebarLeftTap;
  Function? onSidebarRightTap;
  int? isShowLeftSidebar;


  AppPreferredSizeChild({
    super.key,
    this.onSidebarLeftTap,
    this.onSidebarRightTap,
    this.isShowLeftSidebar
  });

  @override
  _AppPreferredSizeChildState createState() => _AppPreferredSizeChildState();
}

class _AppPreferredSizeChildState extends State<AppPreferredSizeChild> {

  @override
  void initState() {

  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 0,
          color: Colors.black,
        ),
        Expanded(
          child: AppWindowCaption(
              brightness: Theme.of(context).brightness,
              title: Text('app_name'.tr()),
              icons: Container(
                margin: const EdgeInsets.only(right: 15),
                child: Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(right: 15),
                      child: IconButton(
                        onPressed: () {
                          if(widget.onSidebarLeftTap!=null){
                            widget.onSidebarLeftTap!();
                          }
                          print("-------------");
                          // sendMessage();
                        },
                        icon: Icon(
                          CupertinoIcons.sidebar_left,
                          color: (widget.isShowLeftSidebar!=1?Color.fromARGB(255, 124, 124, 124):Color.fromARGB(255, 111, 175, 249)),
                        ),
                      ),
                    ),
                    Container(
                      child: IconButton(
                        onPressed: () {
                          if(widget.onSidebarRightTap!=null){
                            widget.onSidebarRightTap!();
                          }
                          print("-------------");
                          // sendMessage();
                        },
                        icon: Icon(
                          CupertinoIcons.sidebar_right,
                          color: Color.fromARGB(255, 124, 124, 124),
                        ),
                      ),
                    )
                  ],
                ),
              )
          ),
        )
      ],
    );
  }
}

