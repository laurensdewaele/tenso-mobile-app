import 'package:flutter/cupertino.dart';

import 'package:app/styles/styles.dart' as styles;
import 'package:app/widgets/divider.dart';
import 'package:app/widgets/number_input.dart';

class NumberInputAndDescription extends StatelessWidget {
  NumberInputAndDescription({
    Key key,
    @required this.description,
    this.initialIntValue,
    this.initialDoubleValue,
    this.shouldFocus = false,
    this.enabled = true,
    this.handleIntValueChanged,
    this.handleDoubleValueChanged,
    this.primaryColor = styles.Colors.primary,
  }) : super(key: key);

  final String description;
  final bool enabled;
  final ValueChanged<double> handleDoubleValueChanged;
  final ValueChanged<int> handleIntValueChanged;
  final Color primaryColor;
  final bool shouldFocus;
  final int initialIntValue;
  final double initialDoubleValue;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        NumberInput(
          enabled: enabled,
          primaryColor: primaryColor,
          shouldFocus: shouldFocus,
          handleIntValueChanged: handleIntValueChanged,
          handleDoubleValueChanged: handleDoubleValueChanged,
          initialIntValue: initialIntValue,
          initialDoubleValue: initialDoubleValue,
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
