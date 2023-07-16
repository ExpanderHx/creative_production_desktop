

import 'package:creative_production_desktop/page/plugins/bean/plugins_bean.dart';
import 'package:creative_production_desktop/utilities/language_util.dart';
import 'package:isar/isar.dart';

import '../../config/const_app.dart';
import '../../network/chat/config/chat_config.dart';
import '../../page/model_config/bean/chat_model_config.dart';
import '../../page/plugins/config/plugins_config.dart';
import '../db/isar_db_util.dart';
import '../service_util.dart';
import 'package:path/path.dart' as path;



class PluginsConfigUtil{


  static String stableDiffusionPrompt = """
    Stable Diffusion is an AI art generation model. Below is a list of prompts that can be used to generate images with Stable Diffusion:
    <--- portait of a homer simpson archer shooting arrow at forest monster, front game card, drark, marvel comics, dark, intricate, highly detailed, smooth, artstation, digital illustration by ruan jia and mandy jurgens and artgerm and wayne barlowe and greg rutkowski and zdislav beksinski - pirate, concept art, deep focus, fantasy, intricate, highly detailed, digital painting, artstation, matte, sharp focus, illustration, art by magali villeneuve, chippy, ryan yee, rk post, clint cearley, daniel ljunggren, zoltan boros, gabor szikszai, howard lyon, steve argyle, winona nelson - ghost inside a hunted room, art by lois van baarle and loish and ross tran and rossdraws and sam yang and samdoesarts and artgerm, digital art, highly detailed, intricate, sharp focus, Trending on Artstation HQ, deviantart, unreal engine 5, 4K UHD image - red dead redemption 2, cinematic view, epic sky, detailed, concept art, low angle, high detail, warm lighting, volumetric, godrays, vivid, beautiful, trending on artstation, by jordan grimmer, huge scene, grass, art greg rutkowski - a fantasy style portrait painting of rachel lane / alison brie hybrid in the style of francois boucher oil painting unreal 5 daz. rpg portrait, extremely detailed artgerm greg rutkowski alphonse mucha greg hildebrandt tim hildebrandt - athena, greek goddess, claudia black, art by artgerm and greg rutkowski and magali villeneuve, bronze greek armor, owl crown, d & d, fantasy, intricate, portrait, highly detailed, headshot, digital painting, trending on artstation, concept art, sharp focus, illustration - closeup portrait shot of a large strong female biomechanic woman in a scenic scifi environment, intricate, elegant, highly detailed, centered, digital painting, artstation, concept art, smooth, sharp focus, warframe, illustration, thomas kinkade, tomasz alen kopera, peter mohrbacher, donato giancola, leyendecker, boris vallejo - ultra realistic illustration of steve urkle as the hulk, intricate, elegant, highly detailed, digital painting, artstation, concept art, smooth, sharp focus, illustration, art by artgerm and greg rutkowski and alphonse mucha ---> 
    I want you to write me a list of detailed prompts exactly about the idea written after IDEA. Follow the structure of the example prompts. This means a very short description of the scene, followed by modifiers divided by commas to alter the mood, style, lighting, and more. I want you to write me a list of detailed prompts exactly about the idea written after IDEA. Follow the structure of the example prompts.And just return a prompt Format your response as a JSON object with"prompt"as the keys .If the information isn't present, use "unknownas the value.
     Make your response as short as possible. You can refer to the following format --- {"prompt":"Here is the generated prompt"} ---   IDEA: {{message}}""";

  static String stableDiffusionPrompt_1 = """
    Stable Diffusion is an AI art generation model. Below is a list of prompts that can be used to generate images with Stable Diffusion: - portait of a homer simpson archer shooting arrow at forest monster, front game card, drark, marvel comics, dark, intricate, highly detailed, smooth, artstation, digital illustration by ruan jia and mandy jurgens and artgerm and wayne barlowe and greg rutkowski and zdislav beksinski - pirate, concept art, deep focus, fantasy, intricate, highly detailed, digital painting, artstation, matte, sharp focus, illustration, art by magali villeneuve, chippy, ryan yee, rk post, clint cearley, daniel ljunggren, zoltan boros, gabor szikszai, howard lyon, steve argyle, winona nelson - ghost inside a hunted room, art by lois van baarle and loish and ross tran and rossdraws and sam yang and samdoesarts and artgerm, digital art, highly detailed, intricate, sharp focus, Trending on Artstation HQ, deviantart, unreal engine 5, 4K UHD image - red dead redemption 2, cinematic view, epic sky, detailed, concept art, low angle, high detail, warm lighting, volumetric, godrays, vivid, beautiful, trending on artstation, by jordan grimmer, huge scene, grass, art greg rutkowski - a fantasy style portrait painting of rachel lane / alison brie hybrid in the style of francois boucher oil painting unreal 5 daz. rpg portrait, extremely detailed artgerm greg rutkowski alphonse mucha greg hildebrandt tim hildebrandt - athena, greek goddess, claudia black, art by artgerm and greg rutkowski and magali villeneuve, bronze greek armor, owl crown, d & d, fantasy, intricate, portrait, highly detailed, headshot, digital painting, trending on artstation, concept art, sharp focus, illustration - closeup portrait shot of a large strong female biomechanic woman in a scenic scifi environment, intricate, elegant, highly detailed, centered, digital painting, artstation, concept art, smooth, sharp focus, warframe, illustration, thomas kinkade, tomasz alen kopera, peter mohrbacher, donato giancola, leyendecker, boris vallejo - ultra realistic illustration of steve urkle as the hulk, intricate, elegant, highly detailed, digital painting, artstation, concept art, smooth, sharp focus, illustration, art by artgerm and greg rutkowski and alphonse mucha I want you to write me a list of detailed prompts exactly about the idea written after IDEA. Follow the structure of the example prompts. This means a very short description of the scene, followed by modifiers divided by commas to alter the mood, style, lighting, and more. IDEA: {{message}} --->  Please go back directly to Prompt and do not include superfluous content
  """;


  static Future<List<PluginsBean>?> getPluginsConfigList() async{
    List<PluginsBean>? chatModelConfigList;
    await IsarDBUtil().init();
    if(null!=IsarDBUtil().isar){
      List<PluginsBean> pluginsBeans = await IsarDBUtil().isar!.pluginsBeans.where().findAll();
      if(pluginsBeans==null||pluginsBeans.length<=0){
        pluginsBeans = await PluginsConfigUtil.initPluginsBeanConfigList();
      }
      print(pluginsBeans);
      if(null!=pluginsBeans&&pluginsBeans.length>0){
        chatModelConfigList = pluginsBeans;
      }

    }
    return chatModelConfigList;
  }

  // static Future<PluginsBean?> getGlobalChatModelConfig(List<ChatModelConfig>? chatModelConfigList) async{
  //   ChatModelConfig? globalChatModelConfig;
  //   if(null!=chatModelConfigList&&chatModelConfigList.length>0){
  //     for(var i=0;i<chatModelConfigList.length;i++){
  //       if(chatModelConfigList[i]!=null&&chatModelConfigList[i].isGlobal!=null&&chatModelConfigList[i].isGlobal!){
  //         globalChatModelConfig = chatModelConfigList[i];
  //       }
  //     }
  //   }
  //   return globalChatModelConfig;
  // }


  static Future<List<PluginsBean>> initPluginsBeanConfigList() async{
    List<PluginsBean> pluginsBeanConfigs = [];

    String? serviceSuperPath = await ServiceUtil.getServiceSuperPath();


    PluginsBean pluginsBeanTranslate = getPluginsBeanConfig(
      title: "translate".tr(),
      prompt: "请将以下内容翻译为中文    ",
      type: PluginsConfig.pluginsTypeTranslate,
      isOpenShortcutKeys:false
    );


    pluginsBeanConfigs.add(pluginsBeanTranslate);

    PluginsBean pluginsBeanCommon = getPluginsBeanConfig(
        title: "text_polishing".tr(),
        prompt: "请对下文本润色   ",
        type: PluginsConfig.pluginsTypeCommon,
        isOpenShortcutKeys:false
    );


    pluginsBeanConfigs.add(pluginsBeanCommon);


    PluginsBean pluginsBeanStableDiffusion = getStableDiffusionDefaultPluginsBean();

    pluginsBeanConfigs.add(pluginsBeanStableDiffusion);

    await IsarDBUtil().isar!.writeTxn(() async{
      if(null!=pluginsBeanConfigs&&pluginsBeanConfigs.length>0){
        for(int i=0;i<pluginsBeanConfigs.length;i++){
          await IsarDBUtil().isar!.pluginsBeans.put(pluginsBeanConfigs[i]);
        }
      }
    });


    return pluginsBeanConfigs;

  }

  static Future<PluginsBean?> getPluginsBeanStableDiffusionGlobal() async{

    if(null!=IsarDBUtil().isar) {
      List<PluginsBean> pluginsBeans = await IsarDBUtil().isar!.pluginsBeans
          .where().findAll();
      if(null!=pluginsBeans&&pluginsBeans.length>0){
        for(var i=0;i<pluginsBeans.length;i++){
          if(null!=pluginsBeans[i]&&null!=pluginsBeans[i].type&&pluginsBeans[i].type==PluginsConfig.pluginsTypeStableDiffusion){
            if(null!=pluginsBeans[i].isStableDiffusionGlobal&&pluginsBeans[i].isStableDiffusionGlobal!){
              return pluginsBeans[i];
            }
          }
        }
      }
    }
    return null;
  }

  static PluginsBean getStableDiffusionDefaultPluginsBean(){
    PluginsBean pluginsBeanStableDiffusion = getPluginsBeanConfig(
        title: "stable_diffusion".tr(),
        prompt: stableDiffusionPrompt,
        type: PluginsConfig.pluginsTypeStableDiffusion,
        isOpenShortcutKeys:false,
        isStableDiffusionGlobal: true
    );
    return pluginsBeanStableDiffusion;
  }


  static Future<PluginsBean?> initPluginsBeanStableDiffusion() async{
    PluginsBean pluginsBeanStableDiffusion = getStableDiffusionDefaultPluginsBean();
    await IsarDBUtil().isar!.writeTxn(() async{
      await IsarDBUtil().isar!.pluginsBeans.put(pluginsBeanStableDiffusion);
    });
    return pluginsBeanStableDiffusion;
  }

  static PluginsBean getPluginsBeanConfig({
    String? title,
    String? prompt,
    String? type,
    bool? isOpenShortcutKeys,
    String? hotKeyJsonString,
    bool? isStableDiffusionGlobal,
  }){
    PluginsBean pluginsBean = PluginsBean();
    pluginsBean.title = title;
    pluginsBean.prompt = prompt;
    pluginsBean.type = type;
    pluginsBean.isOpenShortcutKeys = isOpenShortcutKeys;
    pluginsBean.hotKeyJsonString = hotKeyJsonString;
    pluginsBean.isStableDiffusionGlobal = isStableDiffusionGlobal;

    return pluginsBean;
  }

}