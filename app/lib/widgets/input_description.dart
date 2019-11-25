import 'package:flutter/cupertino.dart';

import 'package:app/styles/styles.dart' as styles;

class InputDescription extends StatelessWidget {
  InputDescription({this.value, this.description});

  final int value;
  final String description;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Row(
      children: <Widget>[
        Container(
          height: styles.Measurements.xs + styles.Measurements.s,
          padding: EdgeInsets.symmetric(horizontal: styles.Measurements.xs),
          decoration: BoxDecoration(
            borderRadius: styles.kAppBorderRadiusAll,
            color: styles.Colors.primary,
          ),
          child: Center(
              child: Text(value.toString(),
                  style: styles.Typography.inputDescriptionSquare)),
        ),
        SizedBox(width: styles.Measurements.xs),
        Text(description, style: styles.Typography.text)
      ],
    );
  }
}
