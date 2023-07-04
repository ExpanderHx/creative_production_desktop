// Create a Form widget.
import 'dart:convert';
import 'dart:io';


import 'package:bot_toast/bot_toast.dart';
import 'package:creative_production_desktop/util/theme_utils.dart';
import 'package:creative_production_desktop/utilities/language_util.dart';
import 'package:desktop_drop/desktop_drop.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hotkey_manager/hotkey_manager.dart';
import 'package:provider/provider.dart';

import '../../provider/router_provider.dart';
import '../../shortcut_key/record_hotkey_dialog.dart';
import '../../shortcut_key/shortcut_key_util.dart';
import '../../util/db/isar_db_util.dart';
import '../../util/utils.dart';
import 'config/skin_data.dart';


class SkinDataFormWidget extends StatefulWidget {
  SkinData? skinData;
  Function? onUpdatePluginsBeanDb;
  SkinDataFormWidget({super.key,this.skinData,this.onUpdatePluginsBeanDb});

  @override
  State<SkinDataFormWidget> createState() => _SkinDataFormWidgetState();

}

// Create a corresponding State class.
// This class holds data related to the form.
class _SkinDataFormWidgetState extends State<SkinDataFormWidget> {

  bool isOpenShortcutKeys = true;

  bool isSaveSkinData = false;

  List<int> lightColors = [0xFF000000,0xDD000000,0x8A000000,0x73000000,0x61000000,0x42000000,0x1F000000,0xFFFFFFFF];

  List<int> darkColors = [0xFFFFFFFF,0x1F000000,0x42000000,0x61000000,0x73000000,0x8A000000,0xDD000000,0xFF000000];


  late SkinData skinData;

  SkinData? oldSkinData;

  bool _dragging = false;


  @override
  void initState() {
    if(widget.skinData!=null){
      skinData = widget.skinData!;
      skinData = widget.skinData!;
    }else{
      skinData = SkinData();
      skinData.type = 2;
    }
    isSaveSkinData = false;
    super.initState();
  }

  void saveSkinData() async{
    // Validate returns true if the form is valid, or false otherwise.
    if (_formKey.currentState!.validate()) {
      // If the form is valid, display a snackbar. In the real world,
      // you'd often call a server or save the information in a database.
      if(null!=IsarDBUtil().isar){

        isSaveSkinData = true;
        await IsarDBUtil().isar!.writeTxn(() async {
          await  IsarDBUtil().isar!.skinDatas.put(skinData);
        }).catchError((onError){
          isSaveSkinData = false;
        });
        if(isSaveSkinData){
          var cancel = BotToast.showText(text:"edit_ok".tr());
          Map<String,dynamic?> map = {"oldSkinData":oldSkinData,"skinData":skinData};
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
    // pluginsBean.isOpenShortcutKeys ??= true;

    if(null == skinData){
      return Container();
    }

    Widget uploadImgWidget = Container();
    if(skinData.type!=null&&skinData.type==2){
      uploadImgWidget = getUploadImgWidget(skinData);
    }

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
                          child: Text("edit_skin".tr()),
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
                  value: skinData.name,
                  onSaved: (newValue){
                    skinData.name = newValue;
                  },
                  onChanged: (newValue){
                    skinData.name = newValue;
                    // print(pluginsBean.prompt);
                  },
              ),
              getDropdownButtonWidget(
                title: "${tr("daytime_mode_font_color")} :",
                value: skinData.lightFontColor,
                values: lightColors,
                onChanged: (newValue){
                 setState(() {
                   skinData.lightFontColor = newValue;
                 });
                }
              ),
              getDropdownButtonWidget(
                title: "${tr("dark_mode_font_color")} :",
                  value: skinData.darkFontColor,
                  values: darkColors,
                  onChanged: (newValue){
                    setState(() {
                      skinData.darkFontColor = newValue;
                    });
                  }
              ),
              uploadImgWidget,

              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: ElevatedButton(
                    onPressed: (!isSaveSkinData)? () {
                      saveSkinData();
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

  Widget getUploadImgWidget(SkinData skinData){

    Widget imageContainer = Center(child: Text("Drop here"));
    if(null!=skinData){
      if(null!=skinData.image&&skinData.image!.length>0){
        imageContainer = Column(
          children: [
            Container(
              height: 70,
              child: Image.file(
                  File(skinData.image!),
                  height: 70,
                  fit:BoxFit.contain
              ),
            ),
            Container(
              child: Text("drop_here".tr()),
            )
          ],
        );
      }
    }


    Widget widget = Container();
    if(null!=skinData){
      if(null!=skinData.type){
        widget = Container(
          child: Row(
            children: [
              Container(
                width: 80,
                margin: EdgeInsets.only(right: 15),
                child: Text("image_upload".tr()),
              ),
              Expanded(
                child: Column(
                  children: [
                    Container(
                      child: DropTarget(
                        onDragDone: (detail) async{
                          print(detail);
                          if(null!=detail&&null!=detail.files&&detail.files.length>0){
                            var file = detail.files[0];
                            if(null!=file){
                              print(file.path);
                              if(null!=file.path){
                                String? destinationFile = await Utils.fileCopy(file.path!);
                                skinData.image = destinationFile;
                              }
                            }
                          }
                          setState(() {

                          });
                        },
                        onDragEntered: (detail) {
                          setState(() {
                            _dragging = true;
                          });
                        },
                        onDragExited: (detail) {
                          setState(() {
                            _dragging = false;
                          });
                        },
                        child: Container(
                          height: 100,
                          color: _dragging ? Colors.blue.withOpacity(0.4) : Colors.black26,
                          child: imageContainer,
                        ),
                      ),
                    ),
                    Container(
                      child: Row(
                        children: [
                          Expanded(
                            child: Center(
                              child: TextButton(
                                onPressed: () async{
                                  FilePickerResult? result = await FilePicker.platform.pickFiles(
                                      type: FileType.image
                                  );
                                  if (result != null&&null!=result.files&&result.files.length>0) {
                                    print(result);
                                    var file = result.files[0];
                                    print(file.path);
                                    if(null!=file.path){
                                      String? destinationFile = await Utils.fileCopy(file.path!);
                                      skinData.image = destinationFile;
                                    }
                                    setState(() {

                                    });
                                  } else {
                                    // User canceled the picker
                                  }
                                },
                                child: Text("click_upload".tr()),
                              ),
                            ),
                          ),
                          Container(
                            margin:  const EdgeInsets.only(left: 5),
                            child: IconButton(
                              onPressed: () {
                                setState(() {
                                  if(null!=skinData){
                                    skinData.image = null;
                                  }

                                });
                              },
                              icon: Icon(
                                Icons.delete,
                                size: 15,
                                color: Color.fromARGB(255, 124, 124, 124),
                              )
                            ),
                          )
                        ],
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
    return widget;
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
                    color: const Color.fromARGB(125, 67,67,67), // 边框颜色
                    style: BorderStyle.solid, // 边框样式为实线
                    width: 1,
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


  Widget getDropdownButtonWidget({String? title, int? value,List<int>? values, Function? onChanged}){

    title ??="";

    List<DropdownMenuItem<int>> dropdownMenuItemList = [];
    if(null!=values&&values.length>0){
      for(var i=0;i<values.length;i++){
        dropdownMenuItemList.add(
            DropdownMenuItem(
                value: values[i],
                child: Container(
                  padding: const EdgeInsets.only(top: 5,bottom: 5),
                  color: Color(values[i]),
                )
            )
        );
      }
    }



    return  Container(
      margin:  EdgeInsets.only(bottom: 15,),
      child: Row(
        // crossAxisAlignment:CrossAxisAlignment.end,
        children: [
          Container(
            width: 80,
            margin: EdgeInsets.only(right: 15),
            child: Text(title!,
              // style: TextStyle(fontSize: 20),
            ),
          ),

          Expanded(
              child: Container(
                padding: EdgeInsets.only(left: 10,right: 10),
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
                    value: value,

                    isExpanded:true,
                    items: dropdownMenuItemList,
                    onChanged: (int? newValue) {
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
                      color: Color.fromARGB(125, 67,67,67), // 边框颜色
                      style: BorderStyle.solid, // 边框样式为实线
                      width: 1,
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