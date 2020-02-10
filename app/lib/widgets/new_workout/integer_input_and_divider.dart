import 'package:flutter/cupertino.dart';

import 'package:app/widgets/divider.dart';
import 'package:app/widgets/number_input_and_description.dart';
import 'package:app/styles/styles.dart' as styles;

class NumberInputAndDivider extends StatelessWidget {
  NumberInputAndDivider(
      {Key key,
      this.handleIntValueChanged,
      this.handleDoubleValueChanged,
      @required this.description,
      @required this.initialValue,
      @required this.shouldLoseFocusStream,
      @required this.isDouble,
      this.zeroValueAllowed,
      this.shouldFocus})
      : super(key: key);

  final String description;
  final double initialValue;
  final Stream<bool> shouldLoseFocusStream;
  final bool shouldFocus;
  final bool isDouble;
  final bool zeroValueAllowed;
  final ValueChanged<int> handleIntValueChanged;
  final ValueChanged<double> handleDoubleValueChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        NumberInputAndDescription(
          zeroValueAllowed: zeroValueAllowed,
          description: description,
          shouldFocus: shouldFocus,
          handleIntValueChanged: handleIntValueChanged,
          handleDoubleValueChanged: handleDoubleValueChanged,
          initialValue: initialValue,
          shouldLoseFocusStream: shouldLoseFocusStream,
          isDouble: isDouble,
        ),
        Divider(
          key: UniqueKey(),
          height: styles.Measurements.m,
        ),
      ],
    );
  }
}
