
import 'package:bot_toast/bot_toast.dart';
import 'package:creative_production_desktop/utilities/language_util.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:screen_capturer/screen_capturer.dart';
import 'package:screen_text_extractor/screen_text_extractor.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../utilities/platform_util.dart';
import '../../utilities/utilities.dart';

class _AllowAccessListItem extends StatelessWidget {
  const _AllowAccessListItem({
    Key? key,
    required this.title,
    required this.allowed,
    this.onTappedTryAllow,
    this.onTappedGoSettings,
  }) : super(key: key);

  final String title;
  final bool allowed;
  final VoidCallback? onTappedTryAllow;
  final VoidCallback? onTappedGoSettings;

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Container(
      child: Row(
        children: [
          Text.rich(
            TextSpan(
              text: allowed ? '✅' : '❌',
              children: [
                const TextSpan(text: '  '),
                TextSpan(text: title),
                const TextSpan(text: '      '),

              ],
            ),
            style: textTheme.bodyMedium!.copyWith(
              color: Colors.white,
              fontSize: 13,
            ),
          ),
          Expanded(
            child: Container(

            ),
          ),
          Container(
            child: Row(
              children: [
                if (onTappedTryAllow != null)
                  Text.rich(
                      TextSpan(
                        text: 'page_desktop_popup.limited_banner_btn_allow'.tr(),
                        style: const TextStyle(
                          decoration: TextDecoration.underline,
                          decorationColor: Colors.white,
                        ),
                        recognizer: TapGestureRecognizer()..onTap = onTappedTryAllow,
                      )
                  ),
                if (onTappedTryAllow != null) const Text.rich(TextSpan(text: ' / ')),
                if (onTappedGoSettings != null)
                  Text.rich(
                      TextSpan(
                        text: 'page_desktop_popup.limited_banner_btn_go_settings'.tr(),
                        style: const TextStyle(
                          decoration: TextDecoration.underline,
                          decorationColor: Colors.white,
                        ),
                        recognizer: TapGestureRecognizer()..onTap = onTappedGoSettings,
                      )
                  ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class LimitedFunctionalityBanner extends StatelessWidget {
  const LimitedFunctionalityBanner({
    Key? key,
    required this.isAllowedScreenCaptureAccess,
    required this.isAllowedScreenSelectionAccess,
    required this.onTappedRecheckIsAllowedAllAccess,
  }) : super(key: key);
  final bool isAllowedScreenCaptureAccess;
  final bool isAllowedScreenSelectionAccess;
  final VoidCallback onTappedRecheckIsAllowedAllAccess;

  bool get _isAllowedAllAccess =>
      isAllowedScreenCaptureAccess && isAllowedScreenSelectionAccess;

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    if (_isAllowedAllAccess) return Container();

    return Card(
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(
          left: 0,
          right: 0,
        ),
        padding: const EdgeInsets.only(
          top: 12,
          bottom: 12,
          left: 18,
          right: 18,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text.rich(
              TextSpan(
                text: 'page_desktop_popup.limited_banner_title'.tr(),
              ),
              style: textTheme.bodyMedium!.copyWith(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 6, bottom: 6),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (kIsMacOS)
                    _AllowAccessListItem(
                      title:
                          'page_desktop_popup.limited_banner_text_screen_capture'
                              .tr(),
                      allowed: isAllowedScreenCaptureAccess,
                      onTappedTryAllow: () {
                        ScreenCapturer.instance.requestAccess();
                        BotToast.showText(
                          text:
                              'page_desktop_popup.limited_banner_msg_allow_access_tip'
                                  .tr(),
                          align: Alignment.center,
                          duration: const Duration(seconds: 5),
                        );
                      },
                      onTappedGoSettings: () {
                        ScreenCapturer.instance.requestAccess(
                          onlyOpenPrefPane: true,
                        );
                      },
                    ),
                  if (kIsMacOS)
                    _AllowAccessListItem(
                      title:
                          'page_desktop_popup.limited_banner_text_screen_selection'
                              .tr(),
                      allowed: isAllowedScreenSelectionAccess,
                      onTappedTryAllow: () {
                        screenTextExtractor.requestAccess();
                        BotToast.showText(
                          text:
                              'page_desktop_popup.limited_banner_msg_allow_access_tip'
                                  .tr(),
                          align: Alignment.center,
                          duration: const Duration(seconds: 5),
                        );
                      },
                      onTappedGoSettings: () {
                        screenTextExtractor.requestAccess(
                          onlyOpenPrefPane: true,
                        );
                      },
                    ),
                ],
              ),
            ),
            Row(
              children: [
                SizedBox(
                  width: 18,
                  height: 18,
                  child: Tooltip(
                    message: 'page_desktop_popup.limited_banner_tip_help'.tr(),
                    child: CupertinoButton(
                      padding: EdgeInsets.zero,
                      child: const Icon(
                        Icons.quiz_outlined,
                        // FluentIcons.question_circle_20_regular,
                        color: Colors.white,
                        size: 18,
                      ),
                      onPressed: () async {
                        Uri url = Uri.parse('${sharedEnv.webUrl}/docs');
                        if (await canLaunchUrl(url)) {
                          await launchUrl(url);
                        } else {
                          throw 'Could not launch $url';
                        }
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: Container(),
                ),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text:
                            'page_desktop_popup.limited_banner_btn_check_again'
                                .tr(),
                        style: const TextStyle(
                          color: Colors.white,
                          height: 1.3,
                          decoration: TextDecoration.underline,
                          decorationColor: Colors.white,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = onTappedRecheckIsAllowedAllAccess,
                      ),
                    ],
                  ),
                  style: textTheme.bodyMedium!.copyWith(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
