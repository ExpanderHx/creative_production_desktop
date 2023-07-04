import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:creative_production_desktop/utilities/language_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

import '../../provider/skin_provider.dart';
import '../../util/theme_utils.dart';

class ChatInputWidget extends StatefulWidget {
  Function? onSendMessage;
  bool? isLoading;
  ChatInputWidget({super.key,this.onSendMessage,this.isLoading});
  @override
  State<ChatInputWidget> createState() => _ChatInputWidgetState();
}

class _ChatInputWidgetState extends State<ChatInputWidget> {

  TextEditingController inputTextEditingController = TextEditingController();
  bool _isExpanded = false;

  void initState(){
    inputTextEditingController.addListener(_onTextChanged);
  }

  void _onTextChanged() {
    setState(() {
      _isExpanded = inputTextEditingController.text.isNotEmpty;
    });
  }

  void sendMessage(){
    String? text = inputTextEditingController?.text;
    print(text);
    _clearText();
    if(null != widget.onSendMessage){
      widget.onSendMessage!(text);
    }
  }

  void _clearText() {
    setState(() {
      inputTextEditingController.clear();
      _isExpanded = false;
    });
  }


  @override
  Widget build(BuildContext context){
    //设置尺寸（填写设计中设备的屏幕尺寸）如果设计基于360dp * 690dp的屏幕 Icon(Icons.send)
    // color: ThemeUtils.getThemeColor(context),
    SkinProvider skinProvider = context.watch<SkinProvider>();
    return Container(
      height: 100,
      padding: EdgeInsets.only(left: 100.w,right: 100.w),
      width: double.infinity,
      child: Column(
        children: [
          Container(
            height: 55,
            decoration: BoxDecoration(
              color: ThemeUtils.getThemeColor(
                  context,
                  lightColor: ThemeUtils.getGobalSkinDataThemeColor(
                    context,
                    gobalSkinData: skinProvider.gobalSkinData,
                    imageBackgroundColor: Color.fromARGB(150, 162, 161, 161),
                  )!,
              ),
              borderRadius: BorderRadius.all(Radius.circular(8)),
              boxShadow: [
                BoxShadow(
                    color: ThemeUtils.getBackgroundThemeColor(context,lightColor: Color.fromARGB(25, 0,0,0),blackColor: Color.fromARGB(25, 255,255,255)), // 阴影颜色
                    blurRadius: 5.0, // 阴影模糊半径
                    spreadRadius: 2.0, // 阴影扩散半径
                    offset: Offset(0, 0), // 阴影偏移量
                ),
              ],
            ),
            alignment: Alignment.center,
            child: RawKeyboardListener(
              autofocus: true,
              onKey: (event) {
                if (event.runtimeType == RawKeyDownEvent) {
                  if (event.physicalKey == PhysicalKeyboardKey.enter) {
                    print("-----------");
                    sendMessage();
                  }
                }
              },
              focusNode: FocusNode(),
              child: TextField(
                  controller: inputTextEditingController,
                  cursorColor:ThemeUtils.getFontThemeColor(context),
                  minLines:1,
                  maxLines:_isExpanded ? 1 : 3,
                  decoration:  InputDecoration(
                    hintText: "please_enter_a_question".tr(),
                    // contentPadding和border的设置是为了让TextField内容实现上下居中
                    contentPadding: EdgeInsets.all(10),
                    suffixIcon: IconButton(
                      onPressed: () {
                        print("-------------");
                        sendMessage();
                      },
                      icon: getSendIconWidget() ,
                    ),
                    border: InputBorder.none
                    // border: const OutlineInputBorder(
                    //   ///设置边框四个角的弧度
                    //   borderRadius: BorderRadius.all(Radius.circular(8)),
                    //   ///用来配置边框的样式
                    //   borderSide: BorderSide(
                    //     ///设置边框的颜色
                    //     color: Colors.black,
                    //     ///设置边框的粗细
                    //     width: 2.0,
                    //   ),
                    // ),
                    // focusedBorder: OutlineInputBorder(
                    //   ///设置边框四个角的弧度
                    //   borderRadius: BorderRadius.all(Radius.circular(8)),
                    //   ///用来配置边框的样式
                    //   borderSide: BorderSide(
                    //     ///设置边框的颜色
                    //     color: ThemeUtils.getFontThemeColor(context),
                    //     ///设置边框的粗细
                    //     width: 2.0,
                    //   ),
                    // ),

                    ///设置输入框可编辑时的边框样式
                    // enabledBorder: const OutlineInputBorder(
                    //   ///设置边框四个角的弧度
                    //   borderRadius: BorderRadius.all(Radius.circular(8)),
                    //   ///用来配置边框的样式
                    //   borderSide: BorderSide(
                    //     ///设置边框的颜色
                    //     color: Colors.black,
                    //     ///设置边框的粗细
                    //     width: 2.0,
                    //   ),
                    // ),
                  )
              ),
            ),
          ),
          Expanded(
              child: Container(
                margin: EdgeInsets.only(top: 15.h),
                child: Text(
                    'model_dialog_description'.tr(),
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w500
                    ),

                ),
              )
          )
        ],
      ),
    );
  }

  Widget getSendIconWidget(){
    
    // const Color.fromARGB(255, 120, 120, 120)
    
    bool isLoading = widget.isLoading ?? false;
    Widget sendIconWidget = Container();
    if(!isLoading){
      sendIconWidget = Tooltip(
        message: 'send'.tr(),
        child: const Icon(
          Icons.send,
          color: Color.fromARGB(255, 222, 222, 229),
        ),
      );
    }else{
      sendIconWidget = Tooltip(
        message: 'sending'.tr(),
        child: SizedBox(
          width: 20,
          height: 20,
          child: LoadingAnimationWidget.hexagonDots(
            color: ThemeUtils.getThemeColor(context,lightColor: Color.fromARGB(255, 50, 50, 50),blackColor: Color.fromARGB(255, 22, 222, 229)),
            size: 20,
          ),
        ),
      );
    }

    return sendIconWidget;

  }



  void dispose() {
    inputTextEditingController.removeListener(_onTextChanged);
    inputTextEditingController?.dispose();
    super.dispose();
  }




}





// GestureDetector(
// onTap: ()=>{
// print("------------------");
// },
// child: Icon(Icons.send),
// )


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