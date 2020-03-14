import 'package:flutter/cupertino.dart';

import 'package:app/styles/styles.dart' as styles;
import 'package:app/widgets/divider.dart';
import 'package:app/widgets/number_input.dart';

class NumberInputAndDescription extends StatelessWidget {
  NumberInputAndDescription(
      {Key key,
      @required this.description,
      this.initialIntValue,
      this.initialDoubleValue,
      @required this.isDouble,
      this.shouldFocus = false,
      this.maxIntValue,
      this.enabled = true,
      this.handleIntValueChanged,
      this.handleDoubleValueChanged,
      this.primaryColor = styles.Colors.primary,
      this.zeroValueAllowed})
      : super(key: key);

  final String description;
  final bool enabled;
  final ValueChanged<double> handleDoubleValueChanged;
  final ValueChanged<int> handleIntValueChanged;
  final bool isDouble;
  final Color primaryColor;
  final bool shouldFocus;
  final bool zeroValueAllowed;
  final int maxIntValue;
  final int initialIntValue;
  final double initialDoubleValue;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        NumberInput(
          enabled: enabled,
          primaryColor: primaryColor,
          zeroValueAllowed: zeroValueAllowed,
          isDouble: isDouble,
          shouldFocus: shouldFocus,
          handleIntValueChanged: handleIntValueChanged,
          handleDoubleValueChanged: handleDoubleValueChanged,
          initialIntValue: initialIntValue,
          initialDoubleValue: initialDoubleValue,
          maxIntValue: maxIntValue,
        ),
        Divider(
          width: styles.Measurements.s,
        ),
        Expanded(
          child: Text(description,
              style: styles.Lato.xsGray, overflow: TextOverflow.clip),
        )
      ],
    );
  }
}
