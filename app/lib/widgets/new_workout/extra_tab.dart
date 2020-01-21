import 'package:flutter/cupertino.dart';

import 'package:provider/provider.dart';

import 'package:app/models/grades.dart';
import 'package:app/state/workout.dart';
import 'package:app/styles/styles.dart' as styles;
import 'package:app/widgets/button.dart';
import 'package:app/widgets/section.dart';
import 'package:app/widgets/new_workout/text_input.dart';

class ExtraTab extends StatelessWidget {
  ExtraTab(
      {Key key,
      @required this.shouldLoseFocusStream,
      @required this.handleErrorMessage})
      : super(key: key);

  final Stream<bool> shouldLoseFocusStream;
  final Function(Widget message) handleErrorMessage;

  @override
  Widget build(BuildContext context) {
    final workoutModel = Provider.of<WorkoutModel>(context, listen: true);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Section(
          title: 'difficulty',
          children: <Widget>[
            Container(
              height: 150,
              child: CupertinoPicker(
                scrollController: FixedExtentScrollController(
                    initialItem:
                        Grades.sportFrench.indexOf(workoutModel.difficulty)),
                useMagnifier: true,
                magnification: 1,
                backgroundColor: styles.Colors.bgWhite,
                onSelectedItemChanged: (int item) {
                  workoutModel.setDifficulty(Grades.sportFrench[item]);
                },
                itemExtent: 40,
                children: <Widget>[
                  ...Grades.sportFrench.map((grade) => Center(
                        child: Text(
                          grade,
                          style: styles.Typography.text,
                        ),
                      ))
                ],
              ),
            )
          ],
        ),
        Section(
          title: 'name',
          children: <Widget>[
            TextInput(
                initialValue: workoutModel.name,
                handleValueChanged: (n) {
                  workoutModel.setName(n);
                },
                shouldLoseFocusStream: shouldLoseFocusStream,
                handleErrorMessage: handleErrorMessage,
                shouldFocus: false)
          ],
        ),
        Center(
          child: Button(
            width: styles.Measurements.xxl * 2,
            text: 'save',
            handleTap: () => Navigator.of(context).pop(),
            displayIcon: false,
          ),
        )
      ],
    );
  }
}
