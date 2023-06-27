// Create a Form widget.
import 'dart:convert';

import 'package:bot_toast/bot_toast.dart';
import 'package:creative_production_desktop/util/theme_utils.dart';
import 'package:creative_production_desktop/utilities/language_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hotkey_manager/hotkey_manager.dart';
import 'package:provider/provider.dart';

import '../../provider/router_provider.dart';
import '../../shortcut_key/record_hotkey_dialog.dart';
import '../../shortcut_key/shortcut_key_util.dart';
import '../../util/db/isar_db_util.dart';
import 'bean/plugins_bean.dart';
import 'config/plugins_config.dart';

class PiuginsFormWidget extends StatefulWidget {
  PluginsBean? pluginsBean;
  Function? onUpdatePluginsBeanDb;
  PiuginsFormWidget({super.key,this.pluginsBean,this.onUpdatePluginsBeanDb});

  @override
  State<PiuginsFormWidget> createState() => _PiuginsFormWidgetState();

}

// Create a corresponding State class.
// This class holds data related to the form.
class _PiuginsFormWidgetState extends State<PiuginsFormWidget> {

  bool isOpenShortcutKeys = true;

  bool isSavePluginsBean = false;


  late PluginsBean pluginsBean;

  PluginsBean? oldPluginsBean;

  @override
  void initState() {
    if(widget.pluginsBean!=null){
      pluginsBean = widget.pluginsBean!;
      oldPluginsBean = widget.pluginsBean!;
    }else{
      pluginsBean = PluginsBean();

    }
    isSavePluginsBean = false;
    super.initState();
  }

  void savePluginsBean() async{
    // Validate returns true if the form is valid, or false otherwise.
    if (_formKey.currentState!.validate()) {
      // If the form is valid, display a snackbar. In the real world,
      // you'd often call a server or save the information in a database.
      if(null!=IsarDBUtil().isar){
        var pluginsBeanCollection = IsarDBUtil().isar!.collection<PluginsBean>();
        isSavePluginsBean = true;
        await IsarDBUtil().isar!.writeTxn(() async {
          await  pluginsBeanCollection.put(pluginsBean);
        }).catchError((onError){
          isSavePluginsBean = false;
        });
        if(isSavePluginsBean){
          // if(widget.onUpdatePluginsBeanDb!=null){
          //   widget.onUpdatePluginsBeanDb!(oldPluginsBean:oldPluginsBean,newPluginsBean:pluginsBean);
          // }
          var cancel = BotToast.showText(text:"edit_ok".tr());
          Map<String,dynamic?> map = {"oldPluginsBean":oldPluginsBean,"newPluginsBean":pluginsBean};
          Navigator.pop(context,map);
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
    pluginsBean.isOpenShortcutKeys ??= true;

    return Container(
      color: Theme.of(context).dialogBackgroundColor,
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
                          child: Text("edit_plugin".tr()),
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
              getInputRowWidget(
                  "${tr('name_title')}  :",
                  value: pluginsBean.title,
                  onSaved: (newValue){
                    pluginsBean.title = newValue;
                  },
                  onChanged: (newValue){
                    pluginsBean.title = newValue;
                    // print(pluginsBean.prompt);
                  },
              ),
              getInputRowWidget(
                  "${tr('prompt_word')}  :",
                  maxLines: 5,
                  value: pluginsBean.prompt,
                  onChanged: (newValue){
                    pluginsBean.prompt = newValue;
                    // print(pluginsBean.prompt);
                  },
                  validator: (value){
                    if (value == null || value.isEmpty) {
                      return 'please_enter_some_text'.tr();
                    }
                    return null;
                  }
              ),
              getDropdownButtonWidget(
                value: pluginsBean.type,
                onChanged: (newValue){
                 setState(() {
                   pluginsBean.type = newValue;
                 });
                }
              ),
              getCupertinoSwitchWidget(
                  pluginsBean.isOpenShortcutKeys!,
                  "${tr('enable_shortcut_keys')} ",
                  onChanged: (newValue){
                    setState(() {
                      pluginsBean.isOpenShortcutKeys = newValue;
                      if(newValue == false){
                        pluginsBean.hotKeyJsonString = null;
                      }
                    });
                  }
              ),
              getShortcutKeysWidget(
                  isOpenShortcutKeys: pluginsBean.isOpenShortcutKeys,
                  hotKeyJsonString: pluginsBean.hotKeyJsonString,
                  onHotKeyRecorded: (hotKey){
                    print(jsonEncode(hotKey.toJson()));
                    setState(() {
                      pluginsBean.hotKeyJsonString = jsonEncode(hotKey.toJson());
                    });
                  }
              ),
              Container(
                margin:  EdgeInsets.only(bottom: 15,),
                child: Row(
                  // crossAxisAlignment:CrossAxisAlignment.end,
                  children: [
                    Container(
                      width: 80,
                      margin: const EdgeInsets.only(right: 15),
                      child: Text(
                        "${tr('model_configuration')}",
                        // style: TextStyle(fontSize: 20),
                      ),
                    ),
                    Expanded(
                        child: Container(
                          padding: EdgeInsets.only(top: 8,bottom: 8,left: 10,right: 10),
                          child: Text("${tr('in_development')}..."),
                        )
                    ),
                  ],
                ),
              ),





              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: ElevatedButton(
                    onPressed: (!isSavePluginsBean)? () {
                      savePluginsBean();
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


  Widget getInputRowWidget(String title,{int? maxLines,String? value,Function? onSaved,Function? validator,Function? onChanged,TextEditingController? textEditingController}){

    return Container(
      margin:  EdgeInsets.only(bottom: 15,),
      child: Row(
        // crossAxisAlignment:CrossAxisAlignment.end,
        children: [
          Container(
            width: 80,
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
                    color: Color.fromARGB(255, 0,0,0), // 边框颜色
                    style: BorderStyle.solid, // 边框样式为实线
                    width: 1.5,
                  ),
                ),
                child: TextFormField(
                  // controller: textEditingController,
                  initialValue:value,
                  maxLines: maxLines,
                  decoration: const InputDecoration(
                      isCollapsed:true,
                      contentPadding: EdgeInsets.all(0),
                      border: InputBorder.none
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


  Widget getDropdownButtonWidget({String? value,Function? onChanged}){
    return  Container(
      margin:  EdgeInsets.only(bottom: 15,),
      child: Row(
        // crossAxisAlignment:CrossAxisAlignment.end,
        children: [
          Container(
            width: 80,
            margin: EdgeInsets.only(right: 15),
            child: Text(
              "${'type'.tr()}  :",
              // style: TextStyle(fontSize: 20),
            ),
          ),
          Expanded(
              child: Container(
                padding: EdgeInsets.only(top: 8,bottom: 8,left: 10,right: 10),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                  border: Border.all(
                    color: Color.fromARGB(255, 0,0,0), // 边框颜色
                    style: BorderStyle.solid, // 边框样式为实线
                    width: 1.5,
                  ),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton(
                    value: value,
                    padding: const EdgeInsets.only(top: 0,bottom: 0,left: 10,right: 10),
                    isExpanded:true,
                    items: [
                      DropdownMenuItem(
                          value: PluginsConfig.pluginsTypeTranslate,
                          child: Text('translate'.tr())
                      ),
                      DropdownMenuItem(
                          value: PluginsConfig.pluginsTypeCommon,
                          child: Text('universal'.tr())
                      ),
                    ],
                    onChanged: (String? newValue) {
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


  Widget getCupertinoSwitchWidget(bool value, String title,{Function? onChanged}){
    return  Container(
      margin:  EdgeInsets.only(bottom: 15,),
      child: Row(
        // crossAxisAlignment:CrossAxisAlignment.end,
        children: [
          Container(
            width: 80,
            margin: EdgeInsets.only(right: 15),
            child: Text(
              title,
              // style: TextStyle(fontSize: 20),
            ),
          ),
          Container(
            child: CupertinoSwitch(
              // overrides the default green color of the track
              // color of the round icon, which moves from right to left
              // when the switch is off
              trackColor: Colors.black12,
              // boolean variable value
              value: value,
              // changes the state of the switch
              onChanged: (newValue){
                if(null!=onChanged){
                  onChanged(newValue);
                }
              },
            ),
          ),
          Expanded(
            child: Container(

            ),

          ),
        ],
      ),
    );
  }

  Widget getShortcutKeysWidget({bool? isOpenShortcutKeys,String? hotKeyJsonString,Function? onHotKeyRecorded}){

    // HotKeyRecorder(
    //   initalHotKey: hotKey,
    //   onHotKeyRecorded: (hotKey) {
    //     if(null!=onHotKeyRecorded){
    //       onHotKeyRecorded(hotKey);
    //     }
    //   },
    // )


    isOpenShortcutKeys = isOpenShortcutKeys ?? true;
    HotKey? hotKey;
    String shortcutKeySrc = "";
    if(null!=hotKeyJsonString){
      hotKey = HotKey.fromJson(jsonDecode(hotKeyJsonString));
      if(null!=hotKey.modifiers&&hotKey.modifiers!.length>0){
        for(var i=0;i<hotKey.modifiers!.length;i++){
          shortcutKeySrc += hotKey.modifiers![i].keyLabel + " + ";
        }
      }
      if(null!=hotKey.keyCode.toString()){
        shortcutKeySrc += hotKey.keyCode.keyLabel;
      }

    }
    return Visibility(
      visible:isOpenShortcutKeys,
      child: Container(
        margin:  const EdgeInsets.only(bottom: 15,),
        child: Row(
          // crossAxisAlignment:CrossAxisAlignment.end,
          children: [
            Container(
              width: 80,
              margin: EdgeInsets.only(right: 15),
              child: Text(
                "hot_key".tr(),
                // style: TextStyle(fontSize: 20),
              ),
            ),
            Expanded(
                child: Container(
                  height: 50,
                  padding: EdgeInsets.only(top: 8,bottom: 8,left: 10,right: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    border: Border.all(
                      color: Color.fromARGB(255, 0,0,0), // 边框颜色
                      style: BorderStyle.solid, // 边框样式为实线
                      width: 1.5,
                    ),
                  ),
                  child: Container(
                    child: Row(
                      children: [
                        Container(
                          child: TextButton(
                            style: ButtonStyle(
                            ),
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  // barrierColor:Colors.white,
                                  builder: (BuildContext context) {
                                     return RecordHotKeyDialog(
                                       onHotKeyRecorded: (HotKey value) {
                                         if(null!=onHotKeyRecorded){
                                           onHotKeyRecorded(value);
                                         }
                                       },);
                                  }
                              );
                            },
                            child: Text("click_to_set_the_shortcut_key".tr(),
                              style: TextStyle(color: ThemeUtils.getFontThemeColor(context)),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 20,),
                          child: Text("${tr('current_shortcut_key')} :  ${shortcutKeySrc}"),
                        )
                      ],
                    ),
                  ),
                )
            ),
          ],
        ),
      ),
    );
  }


}