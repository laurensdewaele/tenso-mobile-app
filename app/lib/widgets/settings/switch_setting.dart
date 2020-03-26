import 'package:flutter/cupertino.dart' hide Icon;

import 'package:app/styles/styles.dart' as styles;
import 'package:app/widgets/button.dart';
import 'package:app/widgets/divider.dart';
import 'package:app/widgets/icon.dart';
import 'package:app/widgets/icon_button.dart';
import 'package:app/widgets/dialog.dart';

class SwitchSetting extends StatelessWidget {
  SwitchSetting(
      {Key key,
      @required this.description,
      this.infoText,
      @required this.active,
      @required this.handleChanged})
      : super(key: key);

  final String description;
  final String infoText;
  final bool active;
  final void Function(bool) handleChanged;

  void _handleInfoTap(BuildContext context) {
    showAppDialog(
        context: context,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              infoText,
              style: styles.Lato.sBlack,
              textAlign: TextAlign.center,
            ),
            Divider(height: styles.Measurements.l),
            Transform.scale(
              scale: .8,
              child: Button(
                  displayBackground: false,
                  text: 'Ok',
                  handleTap: () {
                    Navigator.of(context).pop();
                  }),
            )
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Row(
          children: <Widget>[
            Text(
              description,
              style: styles.Staatliches.xsGray,
            ),
            if (infoText != null)
              IconButton(
                padding: EdgeInsets.fromLTRB(
                    styles.Measurements.m, 0, styles.Measurements.m, 0),
                handleTap: () => _handleInfoTap(context),
                icon: Icon(
                    iconData: IconData(0xf445,
                        fontFamily: 'CupertinoIcons',
                        fontPackage: 'cupertino_icons'),
                    size: styles.IconMeasurements.xl,
                    color: styles.Colors.primary),
              )
          ],
        ),
        CupertinoSwitch(
          value: active,
          onChanged: handleChanged,
          activeColor: styles.Colors.primary,
        )
      ],
    );
  }
}
