import 'package:flutter/cupertino.dart';

import 'package:provider/provider.dart';

import 'package:app/styles/styles.dart' as styles;
import 'package:app/view_models/extra_tab_vm.dart';
import 'package:app/view_models/workout_vm.dart';
import 'package:app/widgets/button.dart';
import 'package:app/widgets/section.dart';
import 'package:app/widgets/text_input.dart';

class ExtraTab extends StatelessWidget {
  ExtraTab({
    Key key,
    @required this.shouldLoseFocusStream,
  }) : super(key: key);

  final Stream<bool> shouldLoseFocusStream;

  void _handleButtonTap(BuildContext context) {
    final _extraTabViewModel =
        Provider.of<ExtraTabViewModel>(context, listen: false);
    _extraTabViewModel.addNewWorkoutToWorkouts();
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    // It's fine to not listen to appState to get the workout.
    // This is because we don't care if it changes or not. It's only used for the initialValues.
    final _workoutViewModel =
        Provider.of<WorkoutViewModel>(context, listen: true);
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
                    initialItem: _workoutViewModel.workout.difficulty),
                useMagnifier: true,
                magnification: 1,
                backgroundColor: styles.Colors.bgWhite,
                onSelectedItemChanged: (int index) {
                  _extraTabViewModel.setDifficulty(index + 1);
                },
                itemExtent: 40,
                children: <Widget>[
                  ...List.generate(10, (i) => i + 1).map((n) => Center(
                        child: Text(
                          n.toString(),
                          style: styles.Lato.xsGray,
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
            backgroundColor: _workoutViewModel.primaryColor,
            width: styles.Measurements.xxl * 2,
            text: _workoutViewModel.extraTabButtonText,
            handleTap: () => _handleButtonTap(context),
          ),
        )
      ],
    );
  }
}
