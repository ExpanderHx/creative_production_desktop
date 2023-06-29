import 'package:flutter/material.dart';

import 'package:window_manager/src/widgets/drag_to_move_area.dart';
import 'package:window_manager/src/widgets/window_caption_button.dart';
import 'package:window_manager/src/window_listener.dart';
import 'package:window_manager/src/window_manager.dart';

import '../../utilities/platform_util.dart';

const double kAppWindowCaptionHeight = 32;

/// A widget to simulate the title bar of windows 11.
///
/// {@tool snippet}
///
/// ```dart
/// Scaffold(
///   appBar: PreferredSize(
///     child: WindowCaption(
///       brightness: Theme.of(context).brightness,
///       title: Text('window_manager_example'),
///     ),
///     preferredSize: const Size.fromHeight(kWindowCaptionHeight),
///   ),
/// )
/// ```
/// {@end-tool}
class AppWindowCaption extends StatefulWidget {
  const AppWindowCaption({
    Key? key,
    this.title,
    this.icons,
    this.backgroundColor,
    this.brightness,
  }) : super(key: key);

  final Widget? title;
  final Widget? icons;
  final Color? backgroundColor;
  final Brightness? brightness;

  @override
  State<AppWindowCaption> createState() => _AppWindowCaptionState();
}

class _AppWindowCaptionState extends State<AppWindowCaption> with WindowListener {
  @override
  void initState() {
    windowManager.addListener(this);
    super.initState();
  }

  @override
  void dispose() {
    windowManager.removeListener(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    Widget operationWidget =  getOperationWidget();

    return Container(
      decoration: BoxDecoration(
        color: widget.backgroundColor ??
            (widget.brightness == Brightness.dark
                ? const Color(0xff1C1C1C)
                : Colors.transparent),
      ),
      child: Row(
        children: [
          Container(
            width: 70,
          ),
          Expanded(
            child: DragToMoveArea(
              child: SizedBox(
                height: double.infinity,
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(left: 16),
                      child: DefaultTextStyle(
                        style: TextStyle(
                          color: widget.brightness == Brightness.light
                              ? Colors.black.withOpacity(0.8956)
                              : Colors.white,
                          fontSize: 14,
                        ),
                        child: widget.title ?? Container(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          (widget.icons != null ? widget.icons! : Container() ),
          operationWidget
        ],
      ),
    );
  }

  Widget getOperationWidget(){

    // Icon(Icons.construction)

    // Icon(CupertinoIcons.hammer)

    if(kIsMacOS){
      return Container();
    }


    return Row(
      children: [
        WindowCaptionButton.minimize(
          brightness: widget.brightness,
          onPressed: () async {
            bool isMinimized = await windowManager.isMinimized();
            if (isMinimized) {
              windowManager.restore();
            } else {
              windowManager.minimize();
            }
          },
        ),
        FutureBuilder<bool>(
          future: windowManager.isMaximized(),
          builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
            if (snapshot.data == true) {
              return WindowCaptionButton.unmaximize(
                brightness: widget.brightness,
                onPressed: () {
                  windowManager.unmaximize();
                },
              );
            }
            return WindowCaptionButton.maximize(
              brightness: widget.brightness,
              onPressed: () {
                windowManager.maximize();
              },
            );
          },
        ),

        WindowCaptionButton.close(
          brightness: widget.brightness,
          onPressed: () {
            // windowManager.close();
            windowManager.hide();
          },
        ),
      ],
    );
  }

  @override
  void onWindowMaximize() {
    setState(() {});
  }

  @override
  void onWindowUnmaximize() {
    setState(() {});
  }
}
