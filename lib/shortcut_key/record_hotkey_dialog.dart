import 'package:creative_production_desktop/util/theme_utils.dart';
import 'package:flutter/material.dart';
import 'package:hotkey_manager/hotkey_manager.dart';

class RecordHotKeyDialog extends StatefulWidget {
  const RecordHotKeyDialog({
    Key? key,
    required this.onHotKeyRecorded,
  }) : super(key: key);

  final ValueChanged<HotKey> onHotKeyRecorded;

  @override
  State<RecordHotKeyDialog> createState() => _RecordHotKeyDialogState();
}

class _RecordHotKeyDialogState extends State<RecordHotKeyDialog> {
  HotKey? _hotKey;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      surfaceTintColor: ThemeUtils.getThemeColor(context),
      // title: Text('Rewind and remember'),
      content: Container(
        child: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text('The `HotKeyRecorder` widget will record your hotkey.'),
              Container(
                width: 100,
                height: 60,
                margin: EdgeInsets.only(top: 20),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    HotKeyRecorder(
                      onHotKeyRecorded: (hotKey) {
                        _hotKey = hotKey;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Checkbox(
                    value: _hotKey?.scope == HotKeyScope.inapp,
                    onChanged: (newValue) {
                      _hotKey?.scope =
                      newValue! ? HotKeyScope.inapp : HotKeyScope.system;
                      setState(() {});
                    },
                  ),
                  Text('Set as inapp-wide hotkey. (default is system-wide)'),
                ],
              ),
            ],
          ),
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: Text('Cancel'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: Text('OK'),
          onPressed: _hotKey == null
              ? null
              : () {
                  widget.onHotKeyRecorded(_hotKey!);
                  Navigator.of(context).pop();
                },
        ),
      ],
    );
  }
}
