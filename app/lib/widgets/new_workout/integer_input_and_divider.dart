import 'package:flutter/cupertino.dart';

import 'package:app/widgets/divider.dart';
import 'package:app/widgets/integer_input_and_description.dart';
import 'package:app/styles/styles.dart' as styles;

class NumberInputAndDivider extends StatelessWidget {
  NumberInputAndDivider(
      {Key key,
      @required this.description,
      @required this.initialValue,
      @required this.handleValueChanged,
      @required this.shouldLoseFocusStream,
      @required this.handleErrorMessage,
        @required this.isDouble,
      this.shouldFocus})
      : super(key: key);

  final String description;
  final double initialValue;
  final ValueChanged<int> handleValueChanged;
  final Stream<bool> shouldLoseFocusStream;
  final Function(Widget) handleErrorMessage;
  final bool shouldFocus;
  final bool isDouble;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        NumberInputAndDescription(
          description: description,
          shouldFocus: shouldFocus,
          handleValueChanged: handleValueChanged,
          initialValue: initialValue,
          shouldLoseFocusStream: shouldLoseFocusStream,
          handleErrorMessage: handleErrorMessage,
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
