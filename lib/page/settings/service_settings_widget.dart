// Create a Form widget.
import 'dart:convert';

import 'package:bot_toast/bot_toast.dart';
import 'package:creative_production_desktop/util/theme_utils.dart';
import 'package:creative_production_desktop/utilities/language_util.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:isar/isar.dart';


import '../../config/const_app.dart';
import '../../network/chat/config/chat_config.dart';

import '../../network/chat/config/chat_http.dart';
import '../../util/db/isar_db_util.dart';
import '../../util/preferences_util.dart';
import '../../util/service_util.dart';
import '../../util/stable_diffusion_ui_service_util.dart';



class ServiceSettingsWidget extends StatefulWidget {

  ServiceSettingsWidget({super.key});

  @override
  State<ServiceSettingsWidget> createState() => _ServiceSettingsWidgetState();

}

// Create a corresponding State class.
// This class holds data related to the form.
class _ServiceSettingsWidgetState extends State<ServiceSettingsWidget> {

  bool isOpenShortcutKeys = true;

  bool isSaveServiceSettings = false;

  String? servicePath;

  String? serviceBaseUrl;

  String? stableDiffusionWebUiServicePath;

  String? stableDiffusionWebUiServiceBaseUrl;


  @override
  void initState() {

    super.initState();
    initServiceSettings();
  }

  initServiceSettings() async{
    await PreferencesUtil.perInit();
    servicePath = PreferencesUtil().get(ConstApp.servicePathKey);
    servicePath ??= ServiceUtil.getServicePath();

    serviceBaseUrl = PreferencesUtil().get(ConstApp.serviceBaseUrlKey);
    serviceBaseUrl ??= ChatConfig.chatGeneralBaseUrl;

    stableDiffusionWebUiServicePath = PreferencesUtil().get(ConstApp.stableDiffusionUiServicePathKey);
    stableDiffusionWebUiServicePath ??= StableDiffusionUiServiceUtil.getServicePath();

    stableDiffusionWebUiServiceBaseUrl = PreferencesUtil().get(ConstApp.stableDiffusionUiServiceBaseUrlKey);
    stableDiffusionWebUiServiceBaseUrl ??= ConstApp.stableDiffusionWebUiServiceBaseUrl;

    if(mounted){
      setState(() {

      });
    }

  }

  void saveServiceSettings() async{
    // Validate returns true if the form is valid, or false otherwise.
    if (_formKey.currentState!.validate()) {
      setState(() {
        isSaveServiceSettings = true;
      });

      servicePath ??= ServiceUtil.getServicePath();
      PreferencesUtil().setString(ConstApp.servicePathKey, servicePath);
      serviceBaseUrl ??= ChatConfig.chatGeneralBaseUrl;
      PreferencesUtil().setString(ConstApp.serviceBaseUrlKey, serviceBaseUrl);
      stableDiffusionWebUiServicePath ??=  StableDiffusionUiServiceUtil.getServicePath();
      PreferencesUtil().setString(ConstApp.stableDiffusionUiServicePathKey, stableDiffusionWebUiServicePath);
      stableDiffusionWebUiServiceBaseUrl ??= ConstApp.stableDiffusionWebUiServiceBaseUrl;
      PreferencesUtil().setString(ConstApp.stableDiffusionUiServiceBaseUrlKey, stableDiffusionWebUiServiceBaseUrl);
      ChatHttp().init(
          baseUrl: serviceBaseUrl
      );
      setState(() {
        isSaveServiceSettings = false;
      });
      BotToast.showText(text:"edit_ok".tr());
      Navigator.pop(context);
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
                          child: Text("creative_production_desktop_service_settings".tr()),
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
                "service_directory_path".tr(),
                value: servicePath,
                onChanged: (newVale){
                  servicePath = newVale;
                  setState(() {

                  });
                }

              ),
              getInputRowWidget(
                  "service_directory_base_url".tr(),
                  value: serviceBaseUrl,
                  onChanged: (newVale){
                    serviceBaseUrl = newVale;
                    setState(() {

                    });
                  }
              ),
              getInputRowWidget(
                  "stable_diffusion_web_service_directory_path".tr(),
                  value: stableDiffusionWebUiServicePath,
                  onChanged: (newVale){
                    stableDiffusionWebUiServicePath = newVale;
                    setState(() {

                    });
                  }

              ),
              getInputRowWidget(
                  "stable_diffusion_web_service_directory_port".tr(),
                  value: stableDiffusionWebUiServiceBaseUrl,
                  onChanged: (newVale){
                    stableDiffusionWebUiServiceBaseUrl = newVale;
                    setState(() {

                    });
                  }
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: ElevatedButton(
                    onPressed: (!isSaveServiceSettings)? (){
                      saveServiceSettings();
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


  Widget getInputRowWidget(String title,{int? maxLines,ValueKey? key,
    String? value,Function? onSaved,Function? validator,
    Function? onChanged,TextEditingController? textEditingController,
    List<TextInputFormatter>? inputFormatters,TextInputType? keyboardType}) {
    print(key.toString());
    return Container(
      child: FormBuilderTextField(
        key: UniqueKey(),
        name: title + (key != null ? key.toString() : ""),
        initialValue: value,
        controller: textEditingController,
        style: const TextStyle(
            fontSize: 14
        ),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(bottom: 2, top: 10),
          labelText: title,
          labelStyle: const TextStyle(
              fontSize: 12
          ),
        ),
        inputFormatters: inputFormatters,
        keyboardType: keyboardType,
        validator: (newValue) {
          print(newValue); // Print the text value write into TextField
          if (null != validator) {
            validator(newValue);
          }
        },
        onChanged: (newValue) {
          print(newValue); // Print the text value write into TextField
          if (null != onChanged) {
            onChanged(newValue);
          }
        },
      ),
    );
  }



 


}