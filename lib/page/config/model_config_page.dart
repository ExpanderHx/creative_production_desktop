import 'package:creative_production_desktop/page/chat/bean/chat_model_config.dart';
import 'package:creative_production_desktop/page/chat/from_ai_row_widget.dart';
import 'package:creative_production_desktop/page/chat/to_ai_row_widget.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:isar/isar.dart';

import 'package:markdown_widget/widget/markdown.dart';

import '../../network/chat/chat_gpt_sdk/src/utils/constants.dart';
import '../../network/chat/config/chat_config.dart';
import '../../util/db/isar_db_util.dart';
import '../plugins/config/plugins_config.dart';
import '../chat/bean/chat_message.dart';



class ModelConfigPage extends StatefulWidget {

  ModelConfigPage({super.key});
  @override
  State<ModelConfigPage> createState() => _ConfigPageState();
}



class _ConfigPageState extends State<ModelConfigPage> {

  ChatModelConfig? activeChatModelConfig;

  List<ChatModelConfig>? chatModelConfigList = [];

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    getGlobalChatModelConfig();
  }

  void getGlobalChatModelConfig(){
    IsarDBUtil().init().then((value) async{
      if(null!=IsarDBUtil().isar){
        List<ChatModelConfig> chatModelConfigs = await IsarDBUtil().isar!.chatModelConfigs.where().findAll();
        if(chatModelConfigs==null||chatModelConfigs.length<=0){
          chatModelConfigs = await initChatModelConfigList();
        }
        print(chatModelConfigs);
        if(null!=chatModelConfigs&&chatModelConfigs.length>0){
          for(var i=0;i<chatModelConfigs.length;i++){
            if(chatModelConfigs[i]!=null&&chatModelConfigs[i].isGlobal!=null&&chatModelConfigs[i].isGlobal!){
              activeChatModelConfig = chatModelConfigs[i];
            }
          }
          setState(() {
            chatModelConfigList = chatModelConfigs;
          });
        }

      }
    });
  }

  Future<List<ChatModelConfig>> initChatModelConfigList() async{
    List<ChatModelConfig> chatModelConfigs = [];

    ChatModelConfig chatModelConfigLocal = getChatModelConfig(
      "THUDM/chatglm2-6b",
      modelName: "THUDM/chatglm2-6b",
      tokenizerName: "THUDM/chatglm2-6b",
      isGlobal: true,
      isLocal: true,
      baseUrl: ChatConfig.chatGeneralBaseUrl,
    );
    await IsarDBUtil().isar!.writeTxn(() async{
       await IsarDBUtil().isar!.chatModelConfigs.put(chatModelConfigLocal);
    });

    chatModelConfigs.add(chatModelConfigLocal);

    ChatModelConfig chatModelConfigOpenAi = getChatModelConfig(
      "openai",
      modelName: "gpt-3.5-turbo",
      tokenizerName: "gpt-3.5-turbo",
      isGlobal: false,
      isLocal: false,
      baseUrl: ChatConfig.chatOpenAiBaseUrl,
    );
    await IsarDBUtil().isar!.writeTxn(() async{
      await IsarDBUtil().isar!.chatModelConfigs.put(chatModelConfigOpenAi);
    });

    chatModelConfigs.add(chatModelConfigOpenAi);

    return chatModelConfigs;

  }

  ChatModelConfig getChatModelConfig(String configName,{
      String? modelName,
      String? tokenizerName,
      String? load_device,
      int? maxToken,
      double? temperature,
      bool? isGlobal,
      bool? isLocal,
      String? baseUrl,
  }){
    ChatModelConfig chatModelConfig = ChatModelConfig();
    chatModelConfig.configName = configName;
    chatModelConfig.modelName = modelName;
    chatModelConfig.tokenizerName = tokenizerName;
    chatModelConfig.loadDevice = load_device;
    chatModelConfig.temperature = temperature;
    chatModelConfig.isGlobal = isGlobal;
    chatModelConfig.isLocal = isLocal;
    chatModelConfig.baseUrl = baseUrl;
    return chatModelConfig;
  }


  @override
  Widget build(BuildContext context) {


    if(null==activeChatModelConfig){
      return Container();
    }

    return Container(
      width: double.infinity,
      height: double.infinity,
      padding: EdgeInsets.only(top: 20,bottom: 20,right: 10),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              getDropdownButtonWidget(),
              getInputRowWidget("模型名称 : ",value: activeChatModelConfig!.modelName),
              getInputRowWidget("tokenizer : ",value: activeChatModelConfig!.tokenizerName),
              getInputRowWidget("device:",value:activeChatModelConfig!.loadDevice),
              getInputRowWidget("maxToken:",value:(null!=activeChatModelConfig!.maxToken?activeChatModelConfig!.maxToken.toString():"")),
              getInputRowWidget("temperature:",value:(null!=activeChatModelConfig!.temperature?activeChatModelConfig!.temperature.toString():"")),
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: ElevatedButton(
                    onPressed: (){

                    },
                    child: const Text('Submit'),
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
                    color: Color.fromARGB(125, 67,67,67), // 边框颜色
                    style: BorderStyle.solid, // 边框样式为实线
                    width: 1,
                  ),
                ),
                child: TextFormField(
                  // controller: textEditingController,
                  initialValue:value,
                  maxLines: maxLines,
                  style: TextStyle(
                    fontSize: 12
                  ),
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
    if(null==chatModelConfigList||chatModelConfigList!.length<=0){
      return Container();
    }

    List<DropdownMenuItem<String>> dropdownMenuItemList = [];
    for(var i=0;i<chatModelConfigList!.length;i++){
      ChatModelConfig chatModelConfig = chatModelConfigList![i];
      dropdownMenuItemList.add(
          DropdownMenuItem(
              value: chatModelConfig.id.toString(),
              child: Text(chatModelConfig.configName)
          )
      );
    }

    return  Container(
      margin:  EdgeInsets.only(bottom: 15,),
      child: Row(
        // crossAxisAlignment:CrossAxisAlignment.end,
        children: [
          Container(
            width: 60,
            margin: EdgeInsets.only(right: 15),
            child: Text(
              "配置  :",
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
                    // menuMaxHeight:40,
                    buttonStyleData: const ButtonStyleData(
                      height: 30,

                    ),
                    menuItemStyleData: const MenuItemStyleData(
                      height: 30,
                    ),
                    value: value,

                    isExpanded:true,
                    items: [
                      ...dropdownMenuItemList
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

}
