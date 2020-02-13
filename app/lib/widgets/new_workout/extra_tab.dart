import 'package:flutter/cupertino.dart';

import 'package:provider/provider.dart';

import 'package:app/models/grade.dart';
import 'package:app/styles/styles.dart' as styles;
import 'package:app/view_models/extra_tab_vm.dart';
import 'package:app/view_models/new_or_edit_workout_vm.dart';
import 'package:app/widgets/button.dart';
import 'package:app/widgets/section.dart';
import 'package:app/widgets/new_workout/text_input.dart';

class ExtraTab extends StatelessWidget {
  ExtraTab({
    Key key,
    @required this.shouldLoseFocusStream,
  }) : super(key: key);

  final Stream<bool> shouldLoseFocusStream;

  @override
  Widget build(BuildContext context) {
    final _workoutViewModel =
        Provider.of<NewOrEditWorkoutViewModel>(context, listen: true);
    final _extraTabViewModel =
        Provider.of<ExtraTabViewModel>(context, listen: false);

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
                    initialItem: Grade.sportFrench
                        .indexOf(_workoutViewModel.workout.difficulty)),
                useMagnifier: true,
                magnification: 1,
                backgroundColor: styles.Colors.bgWhite,
                onSelectedItemChanged: (int item) {
                  _extraTabViewModel.setDifficulty(Grade.sportFrench[item]);
                },
                itemExtent: 40,
                children: <Widget>[
                  ...Grade.sportFrench.map((grade) => Center(
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
                primaryColor: _workoutViewModel.primaryColor,
                initialValue: _workoutViewModel.workout.name,
                handleValueChanged: (n) {
                  _extraTabViewModel.setName(n);
                },
                shouldLoseFocusStream: shouldLoseFocusStream,
                shouldFocus: false)
          ],
        ),
        Center(
          child: Button(
            primaryColor: _workoutViewModel.primaryColor,
            width: styles.Measurements.xxl * 2,
            text: 'done',
            handleTap: () => Navigator.of(context).pop(),
            displayIcon: false,
          ),
        )
      ],
    );
  }
}
