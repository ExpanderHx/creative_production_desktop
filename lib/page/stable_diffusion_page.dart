

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:clipboard/clipboard.dart';
import 'package:creative_production_desktop/page/model_config/bean/chat_model_config.dart';
import 'package:creative_production_desktop/page/plugins/bean/plugins_bean.dart';
import 'package:creative_production_desktop/page/plugins/config/plugins_config.dart';
import 'package:creative_production_desktop/page/plugins/piugins_form_widget.dart';
import 'package:creative_production_desktop/page/skin/config/skin_data.dart';
import 'package:creative_production_desktop/page/skin/skin_form_widget.dart';
import 'package:creative_production_desktop/page/skin/util/skin_config_util.dart';
import 'package:creative_production_desktop/utilities/language_util.dart';
import 'package:desktop_webview_window/desktop_webview_window.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:isar/isar.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

import '../config/const_app.dart';
import '../config/menu_config.dart';
import '../network/chat/chat_api.dart';
import '../network/chat/chat_api_handle.dart';
import '../network/chat/chat_gpt_open_ai.dart';
import '../network/chat/config/chat_config.dart';
import '../provider/skin_provider.dart';
import '../util/db/isar_db_util.dart';
import '../util/model_config/model_config_util.dart';
import '../util/plugins_config/plugins_config_util.dart';
import '../util/preferences_util.dart';
import '../util/stable_diffusion_ui_service_util.dart';
import '../util/theme_utils.dart';





class StableDiffusionPage extends StatefulWidget {
  Map<String,dynamic?>? paramMap;
  StableDiffusionPage({super.key,this.paramMap});
  @override
  State<StableDiffusionPage> createState() => _StableDiffusionPageState();
}

class _StableDiffusionPageState extends State<StableDiffusionPage> {

  Webview? webView;

  ChatApi? chatApi = null;

  TextEditingController promptTextEditingController = TextEditingController();

  TextEditingController originalController = TextEditingController();

  TextEditingController targetController = TextEditingController();

  String? pluginsBeanId;

  String activeType = MenuConfig.stable_diffusion_page_menu;

  bool isLoading = false;

  int? serviceState;

  Timer? serviceStateTimer;



  @override
  void initState() {
// chatApi = ChatApiGeneral();
    chatApi = ChatApiHandle();
    paramMapHandle();
    // handleOpenAiChat();
    timerServiceState();

  }

  @override
  void dispose() {
    if(null!=serviceStateTimer){
      serviceStateTimer!.cancel();
    }
    super.dispose();
  }

  void handleOpenAiChat() async{
    if(null!=chatApi){
      ChatApiHandle chatApiHandle = chatApi as ChatApiHandle;
      List<ChatModelConfig>? chatModelConfigList = await IsarDBUtil().isar!.chatModelConfigs.where().findAll();
      if(null!=chatModelConfigList&&chatModelConfigList.length>0){
        ChatModelConfig? openaiChatModelConfig = null;
        for(var i=0;i<chatModelConfigList.length;i++){
          if(null!=chatModelConfigList[i]&&null!=chatModelConfigList[i].modelName&&chatModelConfigList[i].modelName=="openai"){
            openaiChatModelConfig = chatModelConfigList[i];
          }
        }
        if(null!=openaiChatModelConfig){
          chatApiHandle!.reloadActiveOpenAiChatModel(openaiChatModelConfig);
        }
      }
    }

  }

  void paramMapHandle() async {
    if(widget.paramMap!=null){

      Map<String,dynamic?> paramMap = widget.paramMap!;
      if(null!=paramMap[ConstApp.screenSelectionTextKey]){
        originalController.text = paramMap[ConstApp.screenSelectionTextKey];
      }
      if(null!=paramMap[ConstApp.promptStatementsKey]){
        promptTextEditingController.text = paramMap[ConstApp.promptStatementsKey];
      }
      if(null!=paramMap[ConstApp.pluginsBeanIdKey]){
        pluginsBeanId = paramMap[ConstApp.pluginsBeanIdKey];
      }

      if(null!=paramMap!["activeType"]&&paramMap!["activeType"].length>0){
        activeType = paramMap!["activeType"];
      }
    }

    if(null==pluginsBeanId){
      promptTextEditingController.text = PluginsConfigUtil.stableDiffusionPrompt;

      PluginsBean? pluginsBeanStableDiffusionGlobal = await PluginsConfigUtil.getPluginsBeanStableDiffusionGlobal();
      pluginsBeanStableDiffusionGlobal ??= await PluginsConfigUtil.initPluginsBeanStableDiffusion();
      if(null!=pluginsBeanStableDiffusionGlobal){
        pluginsBeanId = pluginsBeanStableDiffusionGlobal!.id.toString();
        if(null!=pluginsBeanStableDiffusionGlobal!.prompt){
          promptTextEditingController.text = pluginsBeanStableDiffusionGlobal!.prompt!;
        }

      }
    }

    if(mounted){
      setState(() {

      });
    }
  }


  void onGenerateStableDiffusionPrompt() {
    generateStableDiffusionPrompt(originalController.text,isGenerateImg:true);
  }

  void onCopyStableDiffusionPrompt() {
    generateStableDiffusionPrompt(originalController.text,isCopy:true);
  }


  void generateStableDiffusionPrompt(String text,{bool? isGenerateImg, bool? isCopy}) async{
    isGenerateImg ??= false;
    isCopy ??= false;

    print("message:"+text);
    if(null!=text&&text.trim().length>0){
      setState(() {
        isLoading = true;
      });
      if(StableDiffusionUiServiceUtil.isStartCount == 0){
        await getStableDiffusionUiServiceState();
        if(serviceState==0){
          BotToast.showText(text: "attempt_to_start_once_stable_diffusion".tr());
          await startStableDiffusionWebUi(isStartToast: false);
          StableDiffusionUiServiceUtil.isStartCount = 1;
        }
      }

      if(isGenerateImg||isCopy){
        if(null==webView){
          openStableDiffusionWebUi();
        }
      }

      // isStartCount
      if(null != chatApi){
        print("发起请求 ------- "); // ,defaultApiType:ChatConfig.chatOpenAiType
        setState(() {
          targetController.text = "";
        });
        chatApi!.sendMessage(ModelConfigUtil.combinationPromptAndInput(prompt: promptTextEditingController.text,input: text),
            activeType: activeType).then((response) {
          print("接收内容 ------- ");
          if(null!=response&&response.statusCode==200){
            if(originalController.text == text){
              String? responseMessage = response.responseMessage;
              print("接收内容 ------- ${responseMessage}");
              if(null!=responseMessage){
                // targetController.text = responseMessage;
                targetController.text = handleAiGenerateStableSetPrompt(responseMessage);
                if(isGenerateImg!){
                  // stableSetPromptAndGenerateImg(handleAiGenerateStableSetPrompt(responseMessage));
                  stableSetPromptAndGenerateImg(targetController.text);
                }else if(isCopy!){
                  // txt2imgPromptSet(handleAiGenerateStableSetPrompt(responseMessage));
                  txt2imgPromptSet(targetController.text);
                }
              }
              print("处理完成 ： "+response.toString());
            }
          }else{
            targetController.text = "run_anomaly".tr();
          }
          isLoading = false;
          setState(() {

          });
        });
      }
    }
  }








  @override
  void didChangeDependencies(){

  }





  @override
  void didUpdateWidget(StableDiffusionPage oldWidget) {
    if (widget.paramMap != oldWidget.paramMap) {
      // 参数发生变化
      // 执行你的逻辑操作
      print('参数发生了变化');
    }
    super.didUpdateWidget(oldWidget);
  }

  Future<void> startStableDiffusionWebUi({bool? isStartToast}) async{
    await getStableDiffusionUiServiceState();
    if(null!=serviceState&&serviceState==1){
      if(StableDiffusionUiServiceUtil.shell==null){
        BotToast.showText(text: "unable_to_close_stable_diffusion".tr());
      }else{
        stopStableDiffusionDialog();
      }
      // BotToast.showText(text: "server_is_started".tr());
    }else{
      isStartToast ??= true;
      if(isStartToast){
        BotToast.showText(text: "starting_the_server".tr());
      }
      await StableDiffusionUiServiceUtil.startServce();
    }
  }

  // void openStableDiffusionWebUiAnStart({SkinData? skinData}) async{
  //   if(webView==null){
  //     openStableDiffusionWebUi();
  //   }else{
  //     BotToast.showText(text: "server_is_started".tr());
  //   }
  // }

  void openStableDiffusionWebUi({bool? isMustOpen}) async{
    isMustOpen ??= false;
    if(isMustOpen! || null == webView){
      webView = await WebviewWindow.create();
      webView!.addScriptToExecuteOnDocumentCreated('''
      
    
      function setTxt2ImgPrompt(prompt){
         console.log(prompt);
         document.querySelector('#txt2img_prompt textarea').value = prompt;
         var event = new Event('input', {
            bubbles: true,
            cancelable: true,
         });
         document.querySelector('#txt2img_prompt textarea').dispatchEvent(event);
      }
      
      function clickTxt2ImgGenerate(){
         document.getElementById('txt2img_generate').click();
      }
      
      function setTxt2ImgPromptAndClickTxt2ImgGenerate(prompt){
          setTxt2ImgPrompt(prompt);
          clickTxt2ImgGenerate()
      }
      
      
      
    ''');
      webView!.onClose.then((event){
        print("onClose");
        webView!.close();
        webView = null;
      });
      String stableDiffusionWebUiServiceBaseUrl = PreferencesUtil().get(ConstApp.stableDiffusionUiServiceBaseUrlKey);
      stableDiffusionWebUiServiceBaseUrl ??= ConstApp.stableDiffusionWebUiServiceBaseUrl;
      webView!.launch(stableDiffusionWebUiServiceBaseUrl);
    }else{
      BotToast.showText(text: "opened_stable_diffusion".tr());
    }

  }

  String handleAiGenerateStableSetPrompt(String aiGeneratePrompt){
    String prompt = "";
    try{
      if(null!=aiGeneratePrompt&&aiGeneratePrompt.trim().length>0){
        Map<String, dynamic>? promptMap = jsonDecode(aiGeneratePrompt);
        if(null!=promptMap&&null!=promptMap["prompt"]&&promptMap["prompt"]!="unknownas"){
          prompt = promptMap["prompt"];
        }
      }
    }catch(e){

    }
    if(prompt==null||prompt.trim().length<=0){
      if(null!=aiGeneratePrompt){
        RegExp rx = RegExp(r'(".*?")');
        RegExpMatch? firstMatch = rx.firstMatch(aiGeneratePrompt);
        if (firstMatch != null && null!=firstMatch.group(1)&&firstMatch.group(1)!="prompt"&&firstMatch.group(1)!="prompt:"&&firstMatch.group(1)!.length>9) {
          print(firstMatch.group(1));
          prompt = firstMatch.group(1) ?? "";
        }else if(aiGeneratePrompt.contains("Prompt:")){
          prompt = aiGeneratePrompt.replaceFirst("Prompt:", "");
        }else{
          prompt = aiGeneratePrompt;

        }
      }
    }

    return prompt;
  }

  void stableSetPromptAndGenerateImg(String prompt){
    if(null!=prompt){
      setTxt2ImgPromptAndClickTxt2ImgGenerate(prompt);
      // txt2imgPromptSet(prompt);
      // generateImage();

    }
  }

  void setTxt2ImgPromptAndClickTxt2ImgGenerate(String? prompt) async{
    prompt ??="";
    print(prompt);
    prompt = prompt .replaceAll("`", "\`");
    if(null!=webView){
      await webView!.evaluateJavaScript('''
              setTxt2ImgPromptAndClickTxt2ImgGenerate(`${prompt}`);
        '''
    );
    }
  }


  void txt2imgPromptSet(String? prompt,{bool? isCopy}) async{
    prompt ??="";
    if(null!=webView){
      await webView!.evaluateJavaScript('''
              setTxt2ImgPrompt("${prompt}");
              
        '''
      );
      // document.querySelector('#txt2img_prompt textarea').value = "${prompt}";
    }else if(isCopy!=null&&isCopy!){
      FlutterClipboard.copy(prompt).then(( value ) {
        BotToast.showText(text:"the_copy_succeeded".tr());
      });
    }
  }

  void generateImage() async{
    if(null!=webView){
      await webView!.evaluateJavaScript('''
              clickTxt2ImgGenerate();
        '''
      );
    }
  }

  void timerServiceState(){
    serviceStateTimer ??= Timer.periodic(const Duration(seconds: 5), (Timer timer) async{
        getStableDiffusionUiServiceState();
      });
  }

  Future<void> getStableDiffusionUiServiceState()async {
    int? _service_state = await StableDiffusionUiServiceUtil.getServiceState();
    if(null!=_service_state){
      serviceState = _service_state;
      if(mounted){
        setState(() {

        });
      }
    }
  }






  @override
  Widget build(BuildContext context) {
    //设置尺寸（填写设计中设备的屏幕尺寸）如果设计基于360dp * 690dp的屏幕
    // ScreenUtil.init(context, designSize: const Size(1920, 1080));




    return Container(
      width: double.infinity,
      height: double.infinity,
      margin: const EdgeInsets.only(top: 20,bottom: 20),

      child: Stack(
        children: [
          SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.only(left: 10,right: 10),
              child: Column(
                children: [
                      Container(
                        child: Card(
                          child: Container(
                            padding: const EdgeInsets.only(left: 10,right: 10),
                            child: Center(
                              child: Row(
                                children: [
                                  Container(
                                    width: 90,
                                    child: Tooltip(
                                      message: promptTextEditingController.text,
                                      child: TextButton(
                                        onPressed: () {

                                        },
                                        child: Text("prompt_word".tr()),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: TextField(
                                        controller: originalController,
                                        decoration:  InputDecoration(
                                          border: InputBorder.none,
                                        )

                                    ),
                                  ),
                                  Container(
                                    child: IconButton(
                                      onPressed: (){
                                        onGenerateStableDiffusionPrompt();
                                      },
                                      icon: getSendIconWidget(
                                          child:Tooltip(
                                            message: 'generate_prompt_words_and_generate_images'.tr(),
                                            child: const Icon(
                                              Icons.construction,
                                              color: Color.fromARGB(255, 180, 180, 180),
                                            ),
                                          )
                                      ),
                                    )
                                  ),
                                  Container(
                                    child: IconButton(
                                        onPressed: (){
                                          generateImage();
                                        },
                                        icon: getSendIconWidget(
                                            child:Tooltip(
                                              message: 'click_generate_image'.tr(),
                                              child: const Icon(
                                                CupertinoIcons.hammer_fill,
                                                color: Color.fromARGB(255, 180, 180, 180),
                                              ),
                                            )
                                        )
                                    ),
                                  ),
                                  Container(
                                    child: IconButton(
                                        onPressed: (){
                                          onCopyStableDiffusionPrompt();
                                          // String prompt = targetController.text ?? "";
                                          // txt2imgPromptSet(prompt);
                                        },
                                        icon: getSendIconWidget(
                                            child:Tooltip(
                                              message: 'generate_prompt_words_and_copy_them_to'.tr(),
                                              child: const Icon(
                                                CupertinoIcons.square_arrow_right_fill,
                                                color: Color.fromARGB(255, 180, 180, 180),
                                              ),
                                            )
                                        )
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin:  const EdgeInsets.only(top:20),
                        child: Card(
                          child: Container(
                            height: 100,
                            child: Stack(
                              children: [
                                Container(
                                  margin:  const EdgeInsets.only(left:10,right: 20),
                                  child: TextField(
                                      controller: targetController,
                                      cursorColor:ThemeUtils.getFontThemeColor(context),
                                      maxLines: null,
                                      decoration:  InputDecoration(
                                          border: InputBorder.none
                                      )
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.bottomRight,
                                  child: Container(
                                    child: Row(
                                      mainAxisAlignment:MainAxisAlignment.end,
                                      children: [
                                        // Expanded(
                                        //   child: Container(),
                                        // ),
                                        Container(
                                          child: IconButton(
                                            onPressed: () {
                                              targetController.clear();
                                            },
                                            icon: Tooltip(
                                              message: "clear_txt".tr(),
                                              child: Icon(
                                                Icons.close,
                                                color: Color.fromARGB(255, 120, 121, 131),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          child: IconButton(
                                            onPressed: () {
                                              String text = targetController.text ?? "";
                                              txt2imgPromptSet(targetController.text);
                                            },
                                            icon: Tooltip(
                                              message: "copy".tr(),
                                              child: Icon(
                                                Icons.copy,
                                                color: Color.fromARGB(255, 120, 121, 131),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          child: IconButton(
                                            onPressed: () {
                                              generateImage();
                                            },
                                            icon: Tooltip(
                                              message: "click_generate_image".tr(),
                                              child: Icon(
                                                CupertinoIcons.hammer,
                                                color: Color.fromARGB(255, 120, 121, 131),
                                              ),
                                            ),
                                          ),
                                        )

                                      ],
                                    ),
                                  ),
                                )

                              ],
                            ),
                          ),
                        ),
                      )
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Container(
              margin:  const EdgeInsets.only(right: 15,bottom: 15),
              child: Column(
                crossAxisAlignment:CrossAxisAlignment.end,
                children: [
                  Expanded(child: Container()),
                  ClipOval(
                    child: Container(
                      color: Color.fromARGB(50, 155, 155, 155),
                      child: Tooltip(
                        message: "click_open_stable_diffusion".tr(),
                        child: GestureDetector(
                          onDoubleTap: () {
                            print("双击事件 ");
                            openStableDiffusionWebUi(isMustOpen: true);
                          },
                          child: IconButton(
                            onPressed: () {
                              openStableDiffusionWebUi();
                            },
                            icon: const Icon(
                              Icons.play_arrow_outlined,
                              color: Color.fromARGB(255, 111, 175, 249),
                              size: 30,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin:  const EdgeInsets.only(top: 15),
                    child: ClipOval(
                      child: Container(
                        color: Color.fromARGB(50, 155, 155, 155),
                        child: Tooltip(
                          message: ((!(null!=serviceState&&serviceState==1))?"click_start_up_stable_diffusion".tr():"click_stop_stable_diffusion".tr()),
                          child: IconButton(
                            onPressed: () {
                              startStableDiffusionWebUi();
                            },
                            icon: Icon(
                              ((!(null!=serviceState&&serviceState==1))?Icons.radio_button_off:Icons.radio_button_on),
                              color: ((!(null!=serviceState&&serviceState==1))?Color.fromARGB(255, 111, 175, 249):Color.fromARGB( 255, 111, 249, 123)),
                              size: 30,
                            ),
                          ),
                        ),
                      ),
                    ),
                  )

                ],
              ),
            ),
          )
        ],
      ),
    );
  }


  Widget getSendIconWidget({required Tooltip child}){

    // const Color.fromARGB(255, 120, 120, 120)

    // bool isLoading = false;
    Widget sendIconWidget = Container();
    if(!isLoading){
      sendIconWidget = child;
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

  Future<void> stopStableDiffusionDialog() async {
    return showDialog<Null>(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            surfaceTintColor: ThemeUtils.getThemeColor(context),
            title: Text('stop_stable_diffusion'.tr(), style:  TextStyle(fontSize: 17.0)),
            actions: <Widget>[
              ElevatedButton(
                child:  Text('cancel'.tr()),
                onPressed: (){
                  Navigator.of(context).pop();
                },
              ),
              ElevatedButton(
                child:  Text('ok'.tr()),
                onPressed: () async{
                  try{
                    StableDiffusionUiServiceUtil.shell?.kill();
                  }catch(e){

                  }
                  BotToast.showText(text:"closed_stable_diffusion".tr());
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        }
    );
  }



}


