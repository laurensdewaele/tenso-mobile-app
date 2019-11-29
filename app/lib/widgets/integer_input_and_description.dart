import 'package:flutter/cupertino.dart';

import 'package:app/models/workout_ui_config.dart';
import 'package:app/styles/styles.dart' as styles;
import 'package:app/widgets/integer_input.dart';
import 'package:app/widgets/divider.dart';

class IntegerInputAndDescription extends StatelessWidget {
  IntegerInputAndDescription(
      {Key key,
      this.workoutElement,
      this.handleValueChanged,
      this.shouldLoseFocusStream,
      this.handleErrorMessage,
      this.isFirst})
      : super(key: key);

  final WorkoutElement workoutElement;
  final ValueChanged<int> handleValueChanged;
  final Stream<bool> shouldLoseFocusStream;
  final Function(Widget) handleErrorMessage;
  final bool isFirst;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        IntegerInput(
            isFirst: isFirst,
            handleValueChanged: handleValueChanged,
            handleErrorMessage: handleErrorMessage,
            initialValue: workoutElement.initialValue,
            shouldLoseFocusStream: shouldLoseFocusStream),
        Divider(
          width: styles.Measurements.s,
        ),
        Expanded(
          child: Text(workoutElement.description,
              style: styles.Typography.text, overflow: TextOverflow.clip),
        )
      ],
    );
  }
}
