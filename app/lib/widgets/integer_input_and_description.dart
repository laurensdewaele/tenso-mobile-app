import 'package:flutter/cupertino.dart';

import 'package:app/models/workout_ui_configuration.dart';
import 'package:app/styles/styles.dart' as styles;
import 'package:app/widgets/integer_input.dart';
import 'package:app/widgets/divider.dart';

class IntegerInputAndDescription extends StatelessWidget {
  IntegerInputAndDescription(
      {this.workoutElement,
      this.handleValueChanged,
      this.shouldLoseFocusStream,
      this.handleErrorMessage,
      this.isFirst});

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
            initialIntValue: workoutElement.initialIntValue,
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
