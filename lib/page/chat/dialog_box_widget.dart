import 'package:creative_production_desktop/page/chat/from_ai_row_widget.dart';
import 'package:creative_production_desktop/page/chat/to_ai_row_widget.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:markdown_widget/widget/markdown.dart';

import 'chat_message.dart';



class DialogBoxWidget extends StatefulWidget {
  List<ChatMessage>? messageList;
  ScrollController? dialogBoxWidgetScrollController;
  DialogBoxWidget({super.key,this.messageList,this.dialogBoxWidgetScrollController});
  @override
  State<DialogBoxWidget> createState() => _DialogBoxWidgetState();
}



class _DialogBoxWidgetState extends State<DialogBoxWidget> {


  @override
  Widget build(BuildContext context) {

    // return ListView.builder(
    //   itemExtent: 100,
    //   itemCount: widget.messageList!=null?widget.messageList!.length:0,
    //   itemBuilder: (context, index){
    //     Message message = widget.messageList![index];
    //     Widget rowWidget = Container();
    //     if(null!=message){
    //       if(message.isToAi){
    //         rowWidget = ToAiRowWidget(
    //           message: message.message,
    //         );
    //       }else{
    //         rowWidget = FromAiRowWidget(
    //           message: message.message,
    //         );
    //       }
    //     }
    //     return rowWidget;
    //   },
    // );

    List<Widget> widgetList = [];

    if(null!=widget.messageList){
      for(int i=0; i< widget.messageList!.length;i++){
            ChatMessage message = widget.messageList![i];
            Widget rowWidget = Container();
            if(null!=message){
              if(message.isToAi){
                rowWidget = ToAiRowWidget(
                  message: message.message,
                );
              }else{
                rowWidget = FromAiRowWidget(
                  message: message.message,
                );
              }
            }
            widgetList.add(rowWidget);
      }
    }


    return ListView(
      controller: widget.dialogBoxWidgetScrollController,
      children: widgetList,
    );
  }
}
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


// const CircleAvatar(
// radius: 60,
// backgroundImage: NetworkImage(
// 'https://pic2.zhimg.com/v2-639b49f2f6578eabddc458b84eb3c6a1.jpg'
// ),
// )



// return ListView.builder(
// padding: const EdgeInsets.all(8),
// itemCount: 1,
// itemBuilder: (BuildContext context, int index) {
// return Container(
// constraints: BoxConstraints(minHeight: 90.h,minWidth: double.infinity),
// color: Colors.black12,
// padding: EdgeInsets.only(top: 15.h,bottom: 15.h,left: 100.w,right: 100.w),
// child: Row(
// children: [
// Container(
// height: 30.h,
// child: const CircleAvatar(
// radius: 60,
// backgroundImage: NetworkImage(
// 'https://pic2.zhimg.com/v2-639b49f2f6578eabddc458b84eb3c6a1.jpg'
// ),
// ),
// ),
// Expanded(
// child: Container(
// constraints: BoxConstraints(minHeight: 90.h),
// child: MarkdownWidget(data: 'a',),
// ),
// ),
// Container(
// width: 200.w,
// child: Row(
//
// ),
// )
// ],
// ),
// );
// }
// );


//
// return Container(
// height: 500.h,
// child: Scrollbar(
//
// child: SingleChildScrollView(
// child: Stack(
// children: [
// Container(
//
// child: MarkdownWidget(data: '''
//
//                   # I'm h1
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
//                   ''',shrinkWrap:true),
// )
// ],
// ),
// )
// ),
// );


// Container(
// height: 70.h,
// child: Container(
// decoration: BoxDecoration(
// borderRadius: BorderRadius.circular(8),
// border: Border.all(color: Colors.black,width: 1.w),
// ),
// padding: EdgeInsets.only(left: 15.w,right: 15.w,top: 15.h,bottom: 15.h),
// alignment: Alignment.center,
// child: TextField(
// maxLines:null,
// decoration:  InputDecoration(
// hintText: "请输入参数值",
// // contentPadding和border的设置是为了让TextField内容实现上下居中
// contentPadding: const EdgeInsets.all(0),
// border: const OutlineInputBorder(borderSide: BorderSide.none),
// )
// ),
// ),
// )