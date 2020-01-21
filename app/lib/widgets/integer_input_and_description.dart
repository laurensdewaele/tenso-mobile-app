import 'package:flutter/cupertino.dart';

import 'package:app/styles/styles.dart' as styles;
import 'package:app/widgets/integer_input.dart';
import 'package:app/widgets/divider.dart';

class NumberInputAndDescription extends StatelessWidget {
  NumberInputAndDescription(
      {Key key,
      @required this.description,
      @required this.initialValue,
      @required this.handleValueChanged,
      @required this.shouldLoseFocusStream,
      @required this.handleErrorMessage,
      @required this.isDouble,
      @required this.shouldFocus})
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
    return Row(
      children: <Widget>[
        NumberInput(
            isDouble: isDouble,
            shouldFocus: shouldFocus,
            handleValueChanged: handleValueChanged,
            handleErrorMessage: handleErrorMessage,
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
