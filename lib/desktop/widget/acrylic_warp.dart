
import 'package:creative_production_desktop/utilities/language_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

import '../app_window_caption/app_window_caption.dart';


class AcrylicWarp extends StatefulWidget {


  Widget? child;

  AcrylicWarp({
    super.key,
    this.child,
  });

  @override
  _AcrylicWarpState createState() => _AcrylicWarpState();
}

class _AcrylicWarpState extends State<AcrylicWarp> {

  @override
  void initState() {

  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: widget.child,
    );
  }
}

