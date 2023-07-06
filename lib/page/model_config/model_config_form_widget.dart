// Create a Form widget.
import 'dart:convert';

import 'package:bot_toast/bot_toast.dart';
import 'package:creative_production_desktop/util/theme_utils.dart';
import 'package:creative_production_desktop/utilities/language_util.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:isar/isar.dart';
import 'package:provider/provider.dart';


import '../../config/const_app.dart';
import '../../network/chat/config/chat_config.dart';
import '../../provider/skin_provider.dart';
import '../../util/db/isar_db_util.dart';
import '../../util/preferences_util.dart';
import '../../util/service_util.dart';
import 'bean/chat_model_config.dart';
import 'package:path/path.dart' as path;


class ModelConfigFormWidget extends StatefulWidget {
  ChatModelConfig? chatModelConfig;
  Function? onUpdatePluginsBeanDb;
  ModelConfigFormWidget({super.key,this.chatModelConfig,this.onUpdatePluginsBeanDb});

  @override
  State<ModelConfigFormWidget> createState() => _ModelConfigFormWidgetState();

}

// Create a corresponding State class.
// This class holds data related to the form.
class _ModelConfigFormWidgetState extends State<ModelConfigFormWidget> {

  bool isOpenShortcutKeys = true;

  bool isSaveChatModelConfig = false;


  late ChatModelConfig? chatModelConfig;

  ChatModelConfig? oldChatModelConfig;

  @override
  void initState() {
    if(widget.chatModelConfig!=null){
      chatModelConfig = widget.chatModelConfig!;
      oldChatModelConfig = widget.chatModelConfig!;
    }else{
      setState((){
        chatModelConfig = ChatModelConfig();
        // chatModelConfig!.configName = "";
      });

    }
    isSaveChatModelConfig = false;
    super.initState();
  }

  void saveChatModelConfig() async{
    // Validate returns true if the form is valid, or false otherwise.
    if (_formKey.currentState!.validate()) {
      if(null!=chatModelConfig){
        // If the form is valid, display a snackbar. In the real world,
        // you'd often call a server or save the information in a database.
        if(null!=IsarDBUtil().isar){
          isSaveChatModelConfig = true;
          await IsarDBUtil().isar!.writeTxn(() async {
            await IsarDBUtil().isar!.collection<ChatModelConfig>().put(chatModelConfig!);
          }).catchError((onError){
            isSaveChatModelConfig = false;
          });
          if(isSaveChatModelConfig){
            if(chatModelConfig!.isGlobal!=null&&chatModelConfig!.isGlobal!){
              List<ChatModelConfig>? chatModelConfigList =  await IsarDBUtil().isar!.collection<ChatModelConfig>().where().findAll();
              if(null!=chatModelConfigList&&chatModelConfigList.length>0){
                for(var i=0;i<chatModelConfigList.length;i++){
                  ChatModelConfig? chatModelConfigS = chatModelConfigList![i];
                  if(null!=chatModelConfigS){
                    if(null!=chatModelConfigS.id&&chatModelConfigS.id!=chatModelConfig!.id){
                      if(chatModelConfigS!.isGlobal!=null&&chatModelConfigS!.isGlobal!){
                        chatModelConfigS.isGlobal = false;
                        await IsarDBUtil().isar!.writeTxn(() async {
                          await IsarDBUtil().isar!.collection<ChatModelConfig>().put(chatModelConfigS!);
                        });
                      }
                    }
                  }
                }
              }
            }
            var cancel = BotToast.showText(text:"edit_ok".tr());

            Navigator.pop(context);
          }

        }
      }

    }
  }

  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.

    if(chatModelConfig==null){
      return Container();
    }

    List<Widget> widgetList = getFormItemList();

    SkinProvider skinProvider = context.watch<SkinProvider>();

    return Container(
      color: ThemeUtils.getGobalSkinDataThemeColor(
          context,
          lightColor: Theme.of(context).dialogBackgroundColor,
          blackColor: Theme.of(context).dialogBackgroundColor,
          gobalSkinData: skinProvider.gobalSkinData,
          imageBackgroundColor: Color.fromARGB(255, 162, 161, 161)
      ),
      height: double.infinity,
      width: double.infinity,
      padding: EdgeInsets.only(top: 5,bottom: 5,left: 15,right: 15),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 50,
                margin: EdgeInsets.only(bottom: 15),
                child: Row(
                  children: [
                    Expanded(
                      flex:1,
                      child: Container(
                        child: Center(
                          child: Text("edit_model".tr()),
                        ),
                      ),
                    ),
                    Container(
                      child: IconButton(
                        icon: Icon(Icons.close),
                        onPressed: (){
                          Navigator.pop(context);
                        },
                      ),
                    )
                  ],
                ),
              ),
              ...widgetList,
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: ElevatedButton(
                    onPressed: (!isSaveChatModelConfig)? (){
                      saveChatModelConfig();
                    }:null,
                    child: Text('submit'.tr()),
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

    widgetList.add(getInputRowWidget("${tr('config_name')} : ",
        key: ValueKey("configName " + chatModelConfig!.id.toString()),
        value: chatModelConfig!.configName,
        onChanged: (newValue) {
          chatModelConfig!.configName = newValue;
        }
    ));
    widgetList.add(getInputRowWidget("${tr('model_name')} : ",
        key: ValueKey("modelName " + chatModelConfig!.id.toString()),
        value: chatModelConfig!.modelName,
        onChanged: (newValue) async{
          chatModelConfig!.modelName = newValue;
          // String? serviceSuperPath = await ServiceUtil.getServiceSuperPath();
          // if(null!=serviceSuperPath){
          //   if(null!=chatModelConfig!.modelName&&chatModelConfig!.modelName!.trim().length>0){
          //     if(null!=chatModelConfig!.isLocal&&chatModelConfig!.isLocal!){
          //       chatModelConfig!.modelPath = path.join(serviceSuperPath! , ConstApp.serveModelsNameKey,chatModelConfig!.modelName);
          //     }
          //   }else{
          //     chatModelConfig!.modelPath = "";
          //   }
          //   setState(() {
          //
          //   });
          // }
        }
    ));
    widgetList.add(getDropdownButtonWidget(title: "${tr('global')} ",
        value: chatModelConfig!.isGlobal,
        onChanged: (newValue) {
          chatModelConfig!.isGlobal = newValue;
          setState(() {

          });
        }
    ));
    widgetList.add(getDropdownButtonWidget(title: "${tr('local')} ",
        value: chatModelConfig!.isLocal,
        onChanged: (newValue) {
          chatModelConfig!.isLocal = newValue;
          setState(() {

          });
        }
    ));
    if(chatModelConfig!.isLocal!=null&&chatModelConfig!.isLocal!){
      widgetList.add(getInputRowWidget("${tr('model_local_path')} : ",
          key: ValueKey("modelPath " + chatModelConfig!.id.toString()),
          value: chatModelConfig!.modelPath,
          suffixIcon: Tooltip(
            message: "model_local_path_description".tr(),
            child: Icon(CupertinoIcons.info_circle),
          ),
          onChanged: (newValue) {
            chatModelConfig!.modelPath = newValue;
          }
      ));
      widgetList.add(getInputRowWidget("${tr('tokenizer')} : ",
          key: ValueKey("tokenizer " + chatModelConfig!.id.toString()),
          value: chatModelConfig!.tokenizerName,
          onChanged: (newValue) {
            chatModelConfig!.tokenizerName = newValue;
          }
      ));
      widgetList.add(getInputRowWidget("${tr('history_len_title')} : ",
          key: ValueKey("historyLen " + chatModelConfig!.id.toString()),
          value: chatModelConfig!.historyLen?.toString(),
          keyboardType:TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly
          ],
          onChanged: (newValue) {
            if(null!=newValue&&newValue.length>0){
              try{
                chatModelConfig!.historyLen = int.parse(newValue);
              }catch(e){
                print(e.toString());
              }
            }
          }
      ));
      widgetList.add(getInputRowWidget("${tr('device')}:",
          key: ValueKey("device " + chatModelConfig!.id.toString()),
          value: chatModelConfig!.loadDevice,
          suffixIcon: Tooltip(
            message: "device_description".tr(),
            child: Icon(CupertinoIcons.info_circle),
          ),
          onChanged: (newValue) {
            chatModelConfig!.loadDevice = newValue;
          }
      ));
      widgetList.add(getInputRowWidget("${tr('base_url')}:",
          key: ValueKey("baseUrl " + chatModelConfig!.id.toString()),
          value: chatModelConfig!.baseUrl??ChatConfig.chatGeneralBaseUrl,
          maxLines: 1,
          onChanged: (newValue) {
            chatModelConfig!.baseUrl = newValue;
          }
      ));
    }else{
      widgetList.add(getInputRowWidget("${tr('token')}:",
          key: ValueKey("token " + chatModelConfig!.id.toString()),
          obscureText: true,
          maxLines:1,
          value: chatModelConfig!.token,
          onChanged: (newValue) {
            chatModelConfig!.token = newValue;
          }
      ));
      widgetList.add(getInputRowWidget("${tr('base_url')}:",
          key: ValueKey("baseUrl " + chatModelConfig!.id.toString()),
          value: chatModelConfig!.baseUrl??ChatConfig.chatOpenAiBaseUrl,
          maxLines: 1,
          onChanged: (newValue) {
            chatModelConfig!.baseUrl = newValue;
          }
      ));
    }



    widgetList.add(getInputRowWidget("${tr('max_token')}:",
        key: ValueKey("maxToken " + chatModelConfig!.id.toString()),
        value: (null != chatModelConfig!.maxToken
            ? chatModelConfig!.maxToken.toString()
            : ""),
        keyboardType:TextInputType.number,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly
        ],
        onChanged: (newValue) {
          if(null!=newValue&&newValue.length>0){
            try{
              chatModelConfig!.maxToken =  int.parse(newValue);
            }catch(e){
              print(e.toString());
            }
          }
        }
    ));
    widgetList.add( getInputRowWidget("${tr('temperature')}:",
        key: ValueKey("temperature " + chatModelConfig!.id.toString()),
        value: (null != chatModelConfig!.temperature
            ? chatModelConfig!.temperature.toString()
            : ""),
        keyboardType:const TextInputType.numberWithOptions(decimal: true),
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}'))
        ],
        onChanged: (newValue) {
          if(null!=newValue&&newValue.length>0){
            try{
              chatModelConfig!.temperature =  double.parse(newValue);
            }catch(e){
              print(e.toString());
            }
          }
          // else{
          //   chatModelConfig!.temperature = 0.6;
          // }
        }
    ));

    return widgetList;
  }


  Widget getInputRowWidget(String title,{int? maxLines,ValueKey? key,
    String? value,Function? onSaved,Function? validator,
    Function? onChanged,TextEditingController? textEditingController,
    List<TextInputFormatter>? inputFormatters,TextInputType? keyboardType,
    Widget? suffixIcon, bool obscureText = false
  }){

    return Container(
      margin:  EdgeInsets.only(bottom: 15,),
      child: Row(
        // crossAxisAlignment:CrossAxisAlignment.end,
        children: [
          Container(
            width: 90,
            margin: EdgeInsets.only(right: 15),
            child: Text(
              title,
              // style: TextStyle(fontSize: 20),
            ),
          ),
          Expanded(
              child: Container(
                padding: EdgeInsets.only(top: 8,bottom: 8,left: 10,right: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  border: Border.all(
                    color: Color.fromARGB(125, 67,67,67), // 边框颜色
                    style: BorderStyle.solid, // 边框样式为实线
                    width: 1,
                  ),
                ),
                child: TextFormField(
                  key: key,
                  // controller: textEditingController,
                  initialValue:value,
                  obscureText: obscureText,
                  maxLines: maxLines,
                  keyboardType:keyboardType,
                  inputFormatters:inputFormatters,
                  style: const TextStyle(
                      fontSize: 10
                  ),
                  decoration: InputDecoration(
                      isCollapsed:true,
                      contentPadding: EdgeInsets.all(0),
                      border: InputBorder.none,
                      suffixIcon: suffixIcon
                  ),
                  // The validator receives the text that the user has entered.
                  validator: (value) {
                    if(null!=validator){
                      return validator(value);
                    }
                    return null;
                  },
                  onSaved: (newValue){
                    if(null!=onSaved){
                      onSaved(newValue);
                    }
                  },
                  onChanged: (newValue){
                    if(null!=onChanged){
                      onChanged(newValue);
                    }
                  },
                ),
              )
          ),
        ],
      ),
    );
  }

  Widget getDropdownButtonWidget({String? title,bool? value,Function? onChanged}){


    List<DropdownMenuItem<bool>> dropdownMenuItemList = [];

    dropdownMenuItemList.add(
        DropdownMenuItem(
            value: true,
            child: Text("yes".tr())
        )
    );

    dropdownMenuItemList.add(
        DropdownMenuItem(
            value: false,
            child: Text("no".tr())
        )
    );

    return  Container(
      margin:  EdgeInsets.only(bottom: 15,),
      child: Row(
        // crossAxisAlignment:CrossAxisAlignment.end,
        children: [
          Container(
            width: 60,
            margin: EdgeInsets.only(right: 15),
            child: Text(
              "${title}  :",
              // style: TextStyle(fontSize: 20),
            ),
          ),
          Expanded(
              child: Container(
                padding: EdgeInsets.only(top: 0,bottom: 0,left: 10,right: 10),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                  border: Border.all(
                    color: Color.fromARGB(125, 67,67,67), // 边框颜色
                    style: BorderStyle.solid, // 边框样式为实线
                    width: 1,
                  ),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton2(
                    buttonStyleData: const ButtonStyleData(
                      height: 30,
                      padding: EdgeInsets.only(top: 0,bottom: 0,left: 3,right: 3),

                    ),
                    menuItemStyleData: const MenuItemStyleData(
                      height: 30,
                      padding: EdgeInsets.only(top: 0,bottom: 0,left: 3,right: 3),
                    ),
                    value: value,
                    style:TextStyle(
                      fontSize: 10,
                      color: ThemeUtils.getFontThemeColor(context),

                    ),
                    isExpanded:true,
                    items: [
                      ...dropdownMenuItemList
                    ],
                    onChanged: (bool? newValue) {
                      if(null!=onChanged){
                        onChanged(newValue);
                      }
                    },

                  ),
                ),
              )
          ),
        ],
      ),
    );
  }


 


}