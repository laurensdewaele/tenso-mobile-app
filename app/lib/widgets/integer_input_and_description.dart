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
      this.handleErrorMessage});

  final WorkoutElement workoutElement;
  final ValueChanged<int> handleValueChanged;
  final Stream<bool> shouldLoseFocusStream;
  final Function(String) handleErrorMessage;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        child: Row(
          children: <Widget>[
            IntegerInput(
                handleValueChanged: handleValueChanged,
                handleErrorMessage: handleErrorMessage,
                initialIntValue: workoutElement.initialIntValue,
                shouldLoseFocusStream: shouldLoseFocusStream),
            Divider(
              width: styles.Measurements.s,
            ),
            Text(workoutElement.description, style: styles.Typography.text)
          ],
        ));
  }
}
