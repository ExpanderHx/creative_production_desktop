import 'package:bot_toast/bot_toast.dart';
import 'package:clipboard/clipboard.dart';
import 'package:creative_production_desktop/utilities/language_util.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:markdown_widget/widget/markdown.dart';

import '../../util/theme_utils.dart';



class ToAiRowWidget extends StatefulWidget {
  String? message;
  ToAiRowWidget({super.key,this.message});
  @override
  State<ToAiRowWidget> createState() => _ToAiRowWidgetState();
}



class _ToAiRowWidgetState extends State<ToAiRowWidget> {




  @override
  Widget build(BuildContext context) {
    double containerMinHeight = 65.h;
    // color: ThemeUtils.getThemeColor(context),
    return Container(
      decoration: BoxDecoration(

        border:const Border(
            bottom:BorderSide(
              color: Color.fromARGB(25, 0,0,0), // 边框颜色
              style: BorderStyle.solid, // 边框样式为实线
              width: 1,
            )
        ),
      ),
      constraints: BoxConstraints(minHeight: containerMinHeight,minWidth: double.infinity),
      padding: EdgeInsets.only(top: 15.h,bottom: 15.h,left: 100.w,right: 100.w),
      child: Row(
        crossAxisAlignment:CrossAxisAlignment.start,
        children: [
          Container(
            height: 30,
            width: 30,
            margin: EdgeInsets.only(right: 20.w,),
            child:  ClipOval(
              child: Image.asset(
                "assets/images/chat/user-2.png",
                width: 30,
                height: 30,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Expanded(
            child: Container(
              constraints: BoxConstraints(minHeight: containerMinHeight),
              child: MarkdownWidget(
                data: (widget.message!=null?widget.message!:""),
                shrinkWrap:true,
                physics: new NeverScrollableScrollPhysics(),
              ),
            ),
          ),
          Container(
            width: 100.w,
            height: 30,
            child: Row(
              children: [
                Container(
                  child: IconButton(
                    onPressed: () {
                      if(null!=widget.message){
                        FlutterClipboard.copy(widget.message!).then(( value ) {
                          BotToast.showText(text:"the_copy_succeeded".tr());
                        });
                      }
                    },
                    icon: const Icon(
                      Icons.copy,
                      color: Color.fromARGB(255, 120, 121, 131),
                      size: 16,
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

// const Icon(
// Icons.copy,
// color: Color.fromARGB(255, 120, 121, 131),
// size: 16,
// )
//
//
// String a = '''
//
// # I'm h1
// ## I'm h2
// ### I'm h3
// #### I'm h4
// ###### I'm h5
// ###### I'm h6
//
// ```
// class MarkdownHelper {
//
//
//   Map<String, Widget> getTitleWidget(m.Node node) => title.getTitleWidget(node);
//
//   Widget getPWidget(m.Element node) => p.getPWidget(node);
//
//   Widget getPreWidget(m.Node node) => pre.getPreWidget(node);
//
// }
// ```

//
// *italic text*
//
// **strong text**
//
// `I'm code`
//
// ~~del~~
//
// ***~~italic strong and del~~***
//
// > Test for blockquote and **strong**
//
//
// - ul list
// - one
//     - aa *a* a
//     - bbbb
//         - CCCC
//
// 1. ol list
// 2. aaaa
// 3. bbbb
//     1. AAAA
//     2. BBBB
//     3. CCCC
//
//
// [I'm link](https://github.com/asjqkkkk/flutter-todos)
//
//
// - [ ] I'm *CheckBox*
//
// - [x] I'm *CheckBox* too
//
// Test for divider(hr):
//
// ---
//
// Test for Table:
//
// header 1 | header 2
// ---|---
// row 1 col 1 | row 1 col 2
// row 2 col 1 | row 2 col 2
//
// Image:
//
// ![support](assets/script_medias/1675527935336.png)
//
// Image with link:
//
// [![pub package](assets/script_medias/1675527938945.png)](https://pub.dartlang.org/packages/markdown_widget)
//
// Html Image:
//
// <img width="250" height="250" src="assets/script_medias/1675527939855.png"/>
//
// Video:
//
// <video src="http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4">
//
//
//
// ''';
