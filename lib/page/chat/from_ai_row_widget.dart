import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:markdown_widget/widget/markdown.dart';

// import 'package:markdown_widget/widget/markdown.dart';

import '../../util/theme_utils.dart';



class FromAiRowWidget extends StatefulWidget {
  String? message;
  FromAiRowWidget({super.key,this.message});
  @override
  State<FromAiRowWidget> createState() => _FromAiRowWidgetState();
}



class _FromAiRowWidgetState extends State<FromAiRowWidget> {


  @override
  Widget build(BuildContext context) {
    double containerMinHeight = 65.h;

    return Container(
      decoration: BoxDecoration(
        color: ThemeUtils.getThemeColor(context,lightColor:const Color.fromARGB(255, 247,247,248),blackColor: const Color.fromARGB(1, 247,247,248)),
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
            margin: EdgeInsets.only(right: 20.w,),
            child:  ClipOval(
              child: Image.network(
                "https://www.beihaiting.com/uploads/allimg/180114/10723-1P1140Z0092b.jpg",
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
                physics: const NeverScrollableScrollPhysics(),
              ),
            ),
          ),
          Container(
            width: 100.w,
            height: 25,
            child: Row(
              children: [
                Container(
                  child: Icon(
                      Icons.copy,
                      color: Color.fromARGB(255, 120, 121, 131),
                      size: 16,
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


// MarkdownWidget(
// data: (widget.message!=null?widget.message!:""),
// shrinkWrap:true,
// physics: const NeverScrollableScrollPhysics(),
// )



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


// Theme.of(context).colorScheme.background
// ThemeData themeData = Theme.of(context).copyWith(colorScheme: Theme.of(context).colorScheme.copyWith(background: Colors.blue,onBackground:Colors.blue));
// print(themeData.colorScheme.background); canvasColor
//
// return Theme(
// // Find and extend the parent theme using `copyWith`. See the next
// // section for more info on `Theme.of`.
// data: ThemeData(
// colorScheme: ColorScheme.dark()
// ),
// child: Container(
// color: ThemeUtils.getThemeColor(context,defaultLightColor:Colors.lightBlueAccent,defaultBlackColor: Colors.lightBlueAccent),
// constraints: BoxConstraints(minHeight: 90.h,minWidth: double.infinity),
// padding: EdgeInsets.only(top: 15.h,bottom: 15.h,left: 100.w,right: 100.w),
// child: Row(
// crossAxisAlignment:CrossAxisAlignment.start,
// children: [
// Container(
//
// height: 50,
// margin: EdgeInsets.only(right: 20.w,),
// child:  ClipOval(
// child: Image.network(
// "https://pic2.zhimg.com/v2-639b49f2f6578eabddc458b84eb3c6a1.jpg",
// width: 50,
// height: 50,
// fit: BoxFit.cover,
// ),
// ),
// ),
// Expanded(
// child: Container(
// constraints: BoxConstraints(minHeight: 90.h),
// child: MarkdownWidget(
// data: 'a',
// shrinkWrap:true,
// physics: new NeverScrollableScrollPhysics(),
// ),
// ),
// ),
// Container(
// width: 100.w,
// height: 50,
// child: Row(
// children: [
// Container(
// child: Icon(Icons.copy),
// )
// ],
// ),
// )
// ],
// ),
// ),
// );


// // Theme.of(context).colorScheme.background
// ThemeData themeData = Theme.of(context).copyWith(colorScheme: Theme.of(context).colorScheme.copyWith(background: Colors.blue,onBackground:Colors.blue));
// print(themeData.colorScheme.background);
//
//
// return Theme(
// // Find and extend the parent theme using `copyWith`. See the next
// // section for more info on `Theme.of`.
// data: ThemeData(
// colorScheme: ColorScheme(
// background: Colors.blue, brightness: Brightness.light, primary: Colors.blue, onPrimary: Colors.blue,
// secondary: Colors.blue, onSecondary: Colors.blue, error: Colors.blue, onError: Colors.blue,
// onBackground: Colors.blue, surface: Colors.blue, onSurface: Colors.blue
// )
// ),