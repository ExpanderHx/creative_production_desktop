

import 'package:creative_production_desktop/utilities/language_util.dart';
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';

import '../../../util/db/isar_db_util.dart';
import '../config/skin_data.dart';


class SkinConfigUtil{

  static Future<List<SkinData>?> getSkinDataList() async{
    List<SkinData>? skinDataList;
    await IsarDBUtil().init();
    if(null!=IsarDBUtil().isar){
      List<SkinData> skinDatas = await IsarDBUtil().isar!.skinDatas.where().findAll();
      if(skinDatas==null||skinDatas.length<=0){
        skinDatas = await SkinConfigUtil.initSkinDataList();
      }
      print(skinDatas);
      if(null!=skinDatas&&skinDatas.length>0){
        skinDataList = skinDatas;
      }
    }
    return skinDataList;
  }

  static Future<SkinData?> getGlobalChatModelConfig(List<SkinData>? skinDataList) async{
    SkinData? globalSkinData;
    if(null!=skinDataList&&skinDataList.length>0){
      for(var i=0;i<skinDataList.length;i++){
        if(skinDataList[i]!=null&&skinDataList[i].isGlobal!=null&&skinDataList[i].isGlobal!){
          globalSkinData = skinDataList[i];
        }
      }
    }
    return globalSkinData;
  }


  static Future<List<SkinData>> initSkinDataList() async{
    List<SkinData> skinDatas = [];

    SkinData skinDataSolidColor = getSkinData(
      name: "solid_color".tr(),
      type: 0,
      isGlobal: true
    );
    skinDatas.add(skinDataSolidColor);

    SkinData skinDataSeaStarsColor = getSkinData(
      name: "sea_of_stars".tr(),
      image: "assets/images/background/background_1.webp",
      type: 1,
      lightFontColor: Colors.black45.value,
      darkFontColor: Colors.white.value,
    );


    skinDatas.add(skinDataSeaStarsColor);

    SkinData skinDataForestColor = getSkinData(
      name: "forest".tr(),
      image: "assets/images/background/background_2.webp",
      type: 1,
      lightFontColor: Colors.black45.value,
      darkFontColor: Colors.white.value,
    );


    skinDatas.add(skinDataForestColor);

    SkinData skinDataBlueOceanColor = getSkinData(
      name: "blue_ocean".tr(),
      image: "assets/images/background/background_3.jpg",
      type: 1,
      lightFontColor: Colors.black45.value,
      darkFontColor: Colors.white.value,
    );


    skinDatas.add(skinDataBlueOceanColor);

    await IsarDBUtil().isar!.writeTxn(() async{
      if(null!=skinDatas&&skinDatas.length>0){
        for(var i=0;i<skinDatas.length;i++){
          skinDatas[i].id = i;
          await IsarDBUtil().isar!.skinDatas.put(skinDatas[i]);
        }
      }

    });

    return skinDatas;

  }

  static SkinData getSkinData({
    String? name,
    String? image,
    int? type,
    int? lightFontColor,
    int? darkFontColor,
    bool isGlobal = false
  }){
    SkinData skinData = SkinData();
    skinData.name = name;
    skinData.image = image;
    skinData.type = type;
    skinData.lightFontColor = lightFontColor;
    skinData.darkFontColor = darkFontColor;
    return skinData;
  }

}