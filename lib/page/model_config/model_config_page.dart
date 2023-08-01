import 'package:bot_toast/bot_toast.dart';
import 'package:creative_production_desktop/page/model_config/bean/chat_model_config.dart';
import 'package:creative_production_desktop/page/chat/from_ai_row_widget.dart';
import 'package:creative_production_desktop/page/chat/to_ai_row_widget.dart';
import 'package:creative_production_desktop/util/theme_utils.dart';
import 'package:creative_production_desktop/utilities/language_util.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
// import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:isar/isar.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import 'package:markdown_widget/widget/markdown.dart';

import '../../config/const_app.dart';
import '../../network/chat/chat_api_handle.dart';
import '../../network/chat/chat_gpt_sdk/src/utils/constants.dart';
import '../../network/chat/config/chat_config.dart';
import '../../network/chat/config/response_message.dart';
import '../../util/db/isar_db_util.dart';
import '../../util/model_config/model_config_util.dart';
import '../../util/preferences_util.dart';
import '../../util/service_util.dart';
import '../../util/talker_utils.dart';
import '../plugins/config/plugins_config.dart';
import '../chat/bean/chat_message.dart';
import 'package:path/path.dart' as path;



class ModelConfigPage extends StatefulWidget {
  String? activeType;
  ModelConfigPage({super.key,this.activeType});
  @override
  State<ModelConfigPage> createState() => _ModelConfigPageState();
}



class _ModelConfigPageState extends State<ModelConfigPage> {


  ChatModelConfig? activeChatModelConfig;

  List<ChatModelConfig>? chatModelConfigList = [];
  
  int isReloadModel = 0;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    getGlobalChatModelConfig();
  }

  void getGlobalChatModelConfig() async{
    chatModelConfigList = await ModelConfigUtil.getChatModelConfigList();
    activeChatModelConfig = await ModelConfigUtil.getGlobalChatModelConfig(chatModelConfigList);
    setState(() {

    });
  }

  void reloadModel() async{
    setState(() {
      isReloadModel = 1;
    });
    try{
      if(null!=activeChatModelConfig&&null!=widget.activeType){
        if(null!=activeChatModelConfig!.isLocal&&activeChatModelConfig!.isLocal!){
          activeChatModelConfig!.baseUrl = activeChatModelConfig!.baseUrl ?? ChatConfig.chatGeneralBaseUrl;
        }else{
          if(null==activeChatModelConfig!.token||activeChatModelConfig!.token!.length<=0){
            var cancel = BotToast.showText(text:"please_enter_openai_token".tr());
            return;
          }
          activeChatModelConfig!.baseUrl = activeChatModelConfig!.baseUrl ?? ChatConfig.chatOpenAiBaseUrl;
        }
        if(null==activeChatModelConfig!.maxToken||activeChatModelConfig!.maxToken!<=0){
          activeChatModelConfig!.maxToken = 1000;
        }


        if(null!=activeChatModelConfig!.temperature){
          if(activeChatModelConfig!.temperature!<=1&&activeChatModelConfig!.temperature!>0){

          }else{
            activeChatModelConfig!.temperature = 0.7;
          }
        }else{
          activeChatModelConfig!.temperature = 0.7;
        }

        ResponseMessage? responseMessage = await ChatApiHandle().reloadActiveChatModel(activeChatModelConfig,activeType: widget.activeType);
        if(null!=responseMessage){
          if(!(null!=responseMessage.errMsg&&responseMessage.errMsg!.trim().isNotEmpty)){
            BotToast.showText(text:"model_reloaded_successfully".tr());
          }else{
            BotToast.showText(text:responseMessage.errMsg!);
          }
        }else{
          BotToast.showText(text:"model_reload_exception".tr());
        }
      }
    }catch(e,st){
      TalkerUtils.handle(e, st);
    }
    setState(() {
      isReloadModel = 0;
    });
  }

  void updateActiveChatModelConfig(String newValue) async{
    if(null!=newValue){
      int id = int.parse(newValue);
      List<ChatModelConfig>? chatModelConfigSelectList = await IsarDBUtil().isar!.chatModelConfigs.where().idEqualTo(id).findAll();
      if(null!=chatModelConfigSelectList&&chatModelConfigSelectList.length>0){
        setState(() {
          activeChatModelConfig = chatModelConfigSelectList[0];
        });
      }
    }
  }




  @override
  Widget build(BuildContext context) {

    // ElevatedButton


    if(null==activeChatModelConfig){
      return Container();
    }


    List<Widget> widgetList = getFormItemList();



    return Container(
      width: double.infinity,
      height: double.infinity,
      padding: EdgeInsets.only(top: 20,bottom: 20),
      child: FormBuilder(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              ...widgetList,

              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: FilledButton(
                    onPressed: isReloadModel == 0 ?(){
                      reloadModel();
                    } : null,
                    child: Container(
                      child: Stack(
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: Container(
                              child: Center(child: Text('submit'.tr()),),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Container(
                              width: double.infinity,
                              child: (
                                  isReloadModel == 0?
                                  Container():
                                  Container(
                                    margin: EdgeInsets.only(left: 90,),
                                    child: LoadingAnimationWidget.hexagonDots(
                                      color: ThemeUtils.getThemeColor(context,lightColor: Color.fromARGB(255, 50, 50, 50),blackColor: Color.fromARGB(255, 22, 222, 229)),
                                      size: 20,
                                    ),
                                  )
                              ),
                            ),
                          )
                        ],
                      )

                      // Row(
                      //   children: [
                      //     Expanded(
                      //       child: Container(
                      //         child: Center(child: Text('submit'.tr()),),
                      //       ),
                      //     ),
                      //     (
                      //         isReloadModel == 0?
                      //         Container():
                      //         Container(
                      //           child: LoadingAnimationWidget.hexagonDots(
                      //             color: ThemeUtils.getThemeColor(context,lightColor: Color.fromARGB(255, 50, 50, 50),blackColor: Color.fromARGB(255, 22, 222, 229)),
                      //             size: 20,
                      //           ),
                      //         )
                      //     )
                      //   ],
                      // ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> getFormItemList(){
    List<Widget> widgetList = [];
    widgetList.add(getDropdownButtonWidget(
        key: ValueKey("configId " + activeChatModelConfig!.id.toString()),
        value: activeChatModelConfig?.id.toString(),
        onChanged: (newValue){
          updateActiveChatModelConfig(newValue);
        }
    ));
    widgetList.add(getInputRowWidget("${tr('model_name')} : ",
        key: ValueKey("modelName " + activeChatModelConfig!.id.toString()),
        value: activeChatModelConfig!.modelName,
        onChanged: (newValue) async{
          activeChatModelConfig!.modelName = newValue;
        }
    ));
    if(activeChatModelConfig!.isLocal!=null&&activeChatModelConfig!.isLocal!){
      widgetList.add(getInputRowWidget("${tr('model_local_path')} : ",
          key: ValueKey("modelPath " + activeChatModelConfig!.id.toString()),
          value: activeChatModelConfig!.modelPath,
          suffixIcon: Tooltip(
            message: "model_local_path_description".tr(),
            child: Icon(CupertinoIcons.info_circle),
          ),
          onChanged: (newValue) {
            activeChatModelConfig!.modelPath = newValue;
          }
      ));
      widgetList.add(getInputRowWidget("${tr('tokenizer')} : ",
          key: ValueKey("tokenizer " + activeChatModelConfig!.id.toString()),
          value: activeChatModelConfig!.tokenizerName,
          onChanged: (newValue) {
            activeChatModelConfig!.tokenizerName = newValue;
          }
      ));
      widgetList.add(getInputRowWidget("${tr('history_len_title')} : ",
          key: ValueKey("historyLen " + activeChatModelConfig!.id.toString()),
          value: activeChatModelConfig!.historyLen?.toString(),
          keyboardType:TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly
          ],
          onChanged: (newValue) {
            if(null!=newValue&&newValue.length>0){
              try{
                activeChatModelConfig!.historyLen = int.parse(newValue);
              }catch(e){
                print(e.toString());
              }
            }
          }
      ));
      widgetList.add(getInputRowWidget("${tr('device')}:",
          key: ValueKey("device " + activeChatModelConfig!.id.toString()),
          value: activeChatModelConfig!.loadDevice,
          suffixIcon: Tooltip(
            message: "device_description".tr(),
            child: Icon(CupertinoIcons.info_circle),
          ),
          onChanged: (newValue) {
            activeChatModelConfig!.loadDevice = newValue;
          }
      ));

      // List<DropdownMenuItem<String>> dropdownDeviceMenuItemList = [];
      // dropdownDeviceMenuItemList.add(
      //     const DropdownMenuItem(
      //         value: "cpu",
      //         child: Text("cpu")
      //     )
      // );
      // dropdownDeviceMenuItemList.add(
      //     const DropdownMenuItem(
      //         value: "cuda",
      //         child: Text("cuda")
      //     )
      // );
      // widgetList.add(getDropdownStringValueButtonWidget(
      //     "device",
      //     key: ValueKey("device " + activeChatModelConfig!.id.toString()),
      //     value: activeChatModelConfig!.loadDevice,
      //     dropdownMenuItemList:dropdownDeviceMenuItemList,
      //     onChanged: (newValue) {
      //       activeChatModelConfig!.loadDevice = newValue;
      //     }
      // ));



      // List<DropdownMenuItem<bool>> dropdownMenuItemList = [];
      // dropdownMenuItemList.add(
      //     DropdownMenuItem(
      //         value: true,
      //         child: Text("semispermia".tr())
      //     )
      // );
      // dropdownMenuItemList.add(
      //     DropdownMenuItem(
      //         value: false,
      //         child: Text("not_semispermatic".tr())
      //     )
      // );
      // widgetList.add(getDropdownBoolValueButtonWidget(
      //     "accuracy",
      //     key: ValueKey("accuracy " + activeChatModelConfig!.id.toString()),
      //     value: activeChatModelConfig!.isHalf,
      //     dropdownMenuItemList:dropdownMenuItemList,
      //     onChanged: (newValue) {
      //       activeChatModelConfig!.isHalf = newValue;
      //       setState(() {
      //
      //       });
      //     }
      // ));


      widgetList.add(getInputRowWidget("${tr('base_url')}:",
          key: ValueKey("baseUrl " + activeChatModelConfig!.id.toString()),
          value: activeChatModelConfig!.baseUrl??ChatConfig.chatGeneralBaseUrl,
          maxLines: 1,
          onChanged: (newValue) {
            activeChatModelConfig!.baseUrl = newValue;
          }
      ));
    }else{
      widgetList.add(getInputRowWidget("${tr('token')}:",
          key: ValueKey("token " + activeChatModelConfig!.id.toString()),
          obscureText: true,
          maxLines: 1,
          value: activeChatModelConfig!.token,
          onChanged: (newValue) {
            activeChatModelConfig!.token = newValue;
          }
      ));
      widgetList.add(getInputRowWidget("${tr('base_url')}:",
          key: ValueKey("baseUrl " + activeChatModelConfig!.id.toString()),
          value: activeChatModelConfig!.baseUrl??ChatConfig.chatOpenAiBaseUrl,
          maxLines: 1,
          onChanged: (newValue) {
            activeChatModelConfig!.baseUrl = newValue;
          }
      ));
    }



    widgetList.add(getInputRowWidget("${tr('max_token')}:",
        key: ValueKey("maxToken " + activeChatModelConfig!.id.toString()),
        value: (null != activeChatModelConfig!.maxToken
            ? activeChatModelConfig!.maxToken.toString()
            : ""),
        keyboardType:TextInputType.number,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly
        ],
        onChanged: (newValue) {
          if(null!=newValue&&newValue.length>0){
            try{
              activeChatModelConfig!.maxToken =  int.parse(newValue);
            }catch(e){
              print(e.toString());
            }
          }
        }
    ));



    // widgetList.add( getInputRowWidget("${tr('temperature')}:",
    //     key: ValueKey("temperature " + activeChatModelConfig!.id.toString()),
    //     value: (null != activeChatModelConfig!.temperature
    //         ? activeChatModelConfig!.temperature.toString()
    //         : ""),
    //     keyboardType:const TextInputType.numberWithOptions(decimal: true),
    //     inputFormatters: [
    //       FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}'))
    //     ],
    //     onChanged: (newValue) {
    //       if(null!=newValue&&newValue.length>0){
    //         activeChatModelConfig!.temperature =  double.parse(newValue);
    //       }
    //       // else{
    //       //   activeChatModelConfig!.temperature = 0.6;
    //       // }
    //     }
    // ));

    widgetList.add(getSliderWidget("${tr('temperature')}:",
        key: ValueKey("temperature " + activeChatModelConfig!.id.toString()),
        value: activeChatModelConfig!.temperature,
        keyboardType:const TextInputType.numberWithOptions(decimal: true),
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}'))
        ],
        onChanged: (newValue) {
          if(null!=newValue){
            activeChatModelConfig!.temperature = double.parse(newValue.toStringAsFixed(2));
          }
          // else{
          //   activeChatModelConfig!.temperature = 0.6;
          // }
        }
    ));


    // widgetList.add(getInputRowWidget("${tr('top_p')}:",
    //     key: ValueKey("top_p " + activeChatModelConfig!.id.toString()),
    //     value: (null != activeChatModelConfig!.topP
    //         ? activeChatModelConfig!.topP.toString()
    //         : ""),
    //     keyboardType:TextInputType.number,
    //     inputFormatters: [
    //       FilteringTextInputFormatter.digitsOnly
    //     ],
    //     onChanged: (newValue) {
    //       if(null!=newValue&&newValue.length>0){
    //         try{
    //           activeChatModelConfig!.topP =  int.parse(newValue);
    //         }catch(e){
    //           print(e.toString());
    //         }
    //       }
    //     }
    // ));



    return widgetList;
  }


  Widget getInputRowWidget(String title,{int? maxLines,ValueKey? key,
    String? value,Function? onSaved,Function? validator,
    Function? onChanged,TextEditingController? textEditingController,
    List<TextInputFormatter>? inputFormatters,TextInputType? keyboardType,
    Widget? suffixIcon, bool obscureText = false
  }){

    print(key.toString());
    return Container(
      child: FormBuilderTextField(
        key: UniqueKey(),
        name: title + (key!=null?key.toString():""),
        initialValue: value,
        obscureText: obscureText,
        maxLines: maxLines,
        controller: textEditingController,
        style: const TextStyle(
            fontSize: 14
        ),
        decoration: InputDecoration(
          contentPadding:const EdgeInsets.only(bottom: 2,top: 10),
          labelText: title,
          labelStyle: TextStyle(
              fontSize: 12,
              color: Theme.of(context).inputDecorationTheme.labelStyle?.color
          ),
          suffixIcon:suffixIcon
        ),
        inputFormatters: inputFormatters,
        keyboardType: keyboardType,
        validator: (newValue){
          print(newValue); // Print the text value write into TextField
          if(null!=validator){
            validator(newValue);
          }
        },
        onChanged: (newValue) {
          print(newValue); // Print the text value write into TextField
          if(null!=onChanged){
            onChanged(newValue);
          }
        },
      ),
    );

  }

  Widget getSliderWidget(String title,{int? maxLines,ValueKey? key,
    double? value,Function? onSaved,Function? validator,
    Function? onChanged,TextEditingController? textEditingController,
    List<TextInputFormatter>? inputFormatters,TextInputType? keyboardType}){
    value = value ?? 0.7;
    return FormBuilderSlider(
      key: key,
      name: 'title',
      onChanged: (newValue){
        if(null!=newValue){
          onChanged!(newValue);
        }
      },
      min: 0.0,
      max: 1.0,
      initialValue: value,
      // divisions: 0.1,
      // activeColor: Colors.red,
      // inactiveColor: Colors.pink[100],
      decoration: InputDecoration(
        labelText: title??"",
      ),
    );
  }



  Widget getDropdownButtonWidget({String? value,Function? onChanged,ValueKey? key}){
    if(null==chatModelConfigList||chatModelConfigList!.length<=0){
      return Container();
    }

    List<DropdownMenuItem<String>> dropdownMenuItemList = [];

    for(var i=0;i<chatModelConfigList!.length;i++){
      ChatModelConfig chatModelConfig = chatModelConfigList![i];
      dropdownMenuItemList.add(
          DropdownMenuItem(
              value: chatModelConfig.id.toString(),
              child: Text(chatModelConfig.configName!)
          )
      );

    }

    return FormBuilderDropdown<String>(
      name: 'configId',
      key: key,
      initialValue: value,
      decoration: InputDecoration(
        labelText: '${tr('configuration')}',
        hintText: 'Select ${tr('configuration')}',
      ),
      items: dropdownMenuItemList,
      onChanged: (newValue) {
        if(null!=onChanged){
          onChanged(newValue);
        }
      },
      valueTransformer: (val) => val?.toString(),
    );

  }



  Widget getDropdownStringValueButtonWidget(String name,{String? value,Function? onChanged,ValueKey? key, List<DropdownMenuItem<String>>? dropdownMenuItemList}){
    if(null==dropdownMenuItemList||dropdownMenuItemList!.length<=0){
      return Container();
    }


    return FormBuilderDropdown<String>(
      name:name,
      key: key,
      initialValue: value,
      decoration: InputDecoration(
        labelText: '${tr(name)}',
        hintText: 'Select ${tr(name)}',
      ),
      items: dropdownMenuItemList,
      onChanged: (newValue) {
        if(null!=onChanged){
          onChanged(newValue);
        }
      },
      valueTransformer: (val) => val?.toString(),
    );

  }


  Widget getDropdownBoolValueButtonWidget(String name,{bool? value,Function? onChanged,ValueKey? key, List<DropdownMenuItem<bool>>? dropdownMenuItemList}){
    if(null==dropdownMenuItemList||dropdownMenuItemList!.length<=0){
      return Container();
    }


    return FormBuilderDropdown<bool>(
      name:name,
      key: key,
      initialValue: value,
      decoration: InputDecoration(
        labelText: '${tr(name)}',
        hintText: 'Select ${tr(name)}',
      ),
      items: dropdownMenuItemList,
      onChanged: (newValue) {
        if(null!=onChanged){
          onChanged(newValue);
        }
      },
      valueTransformer: (val) => val?.toString(),
    );

  }

}
