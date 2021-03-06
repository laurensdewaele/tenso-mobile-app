import 'package:flutter/cupertino.dart';
import 'package:tenso_app/modules/common/divider.dart';
import 'package:tenso_app/modules/keyboard_input/number_input.dart';
import 'package:tenso_app/styles/styles.dart' as styles;

class NumberInputAndDescription<T> extends StatelessWidget {
  NumberInputAndDescription({
    Key key,
    @required this.description,
    this.enabled = true,
    @required this.handleValueChanged,
    @required this.initialValue,
    this.primaryColor = styles.Colors.primary,
  }) : super(key: key);

  final String description;
  final bool enabled;
  final ValueChanged<String> handleValueChanged;
  final Color primaryColor;
  final T initialValue;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        NumberInput<T>(
          enabled: enabled,
          primaryColor: primaryColor,
          handleValueChanged: handleValueChanged,
          initialValue: initialValue,
        ),
        Divider(
          width: styles.Measurements.s,
        ),
        Text(description,
            style: styles.Lato.xsGray, overflow: TextOverflow.clip)
      ],
    );
  }
}
