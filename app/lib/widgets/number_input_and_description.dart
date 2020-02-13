import 'package:flutter/cupertino.dart';

import 'package:app/styles/styles.dart' as styles;
import 'package:app/widgets/number_input.dart';
import 'package:app/widgets/divider.dart';

class NumberInputAndDescription extends StatelessWidget {
  NumberInputAndDescription(
      {Key key,
        this.primaryColor = styles.Colors.primary,
      @required this.description,
      @required this.initialValue,
      this.handleIntValueChanged,
      this.handleDoubleValueChanged,
      @required this.shouldLoseFocusStream,
      @required this.isDouble,
      @required this.shouldFocus,
      this.zeroValueAllowed})
      : super(key: key);

  final Color primaryColor;
  final String description;
  final double initialValue;
  final ValueChanged<int> handleIntValueChanged;
  final ValueChanged<double> handleDoubleValueChanged;
  final Stream<bool> shouldLoseFocusStream;
  final bool shouldFocus;
  final bool isDouble;
  final bool zeroValueAllowed;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        NumberInput(
            primaryColor: primaryColor,
            zeroValueAllowed: zeroValueAllowed,
            isDouble: isDouble,
            shouldFocus: shouldFocus,
            handleIntValueChanged: handleIntValueChanged,
            handleDoubleValueChanged: handleDoubleValueChanged,
            initialValue: initialValue,
            shouldLoseFocusStream: shouldLoseFocusStream),
        Divider(
          width: styles.Measurements.s,
        ),
        Expanded(
          child: Text(description,
              style: styles.Typography.text, overflow: TextOverflow.clip),
        )
      ],
    );
  }
}
