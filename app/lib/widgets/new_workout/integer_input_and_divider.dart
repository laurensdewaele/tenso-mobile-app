import 'package:flutter/cupertino.dart';

import 'package:app/widgets/divider.dart';
import 'package:app/widgets/new_workout/integer_input_and_description.dart';
import 'package:app/styles/styles.dart' as styles;

class IntegerInputAndDivider extends StatelessWidget {
  IntegerInputAndDivider(
      {Key key,
      @required this.description,
      @required this.initialValue,
      @required this.handleValueChanged,
      @required this.shouldLoseFocusStream,
      @required this.handleErrorMessage,
      this.shouldFocus})
      : super(key: key);

  final String description;
  final int initialValue;
  final ValueChanged<int> handleValueChanged;
  final Stream<bool> shouldLoseFocusStream;
  final Function(Widget) handleErrorMessage;
  final bool shouldFocus;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        IntegerInputAndDescription(
          description: description,
          shouldFocus: shouldFocus,
          handleValueChanged: handleValueChanged,
          initialValue: initialValue,
          shouldLoseFocusStream: shouldLoseFocusStream,
          handleErrorMessage: handleErrorMessage,
        ),
        Divider(
          key: UniqueKey(),
          height: styles.Measurements.m,
        ),
      ],
    );
  }
}
