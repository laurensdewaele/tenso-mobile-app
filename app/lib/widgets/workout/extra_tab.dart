import 'package:flutter/cupertino.dart';

import 'package:provider/provider.dart';

import 'package:app/state/app_state.dart';
import 'package:app/styles/styles.dart' as styles;
import 'package:app/view_models/extra_tab_vm.dart';
import 'package:app/view_models/workout_vm.dart';
import 'package:app/widgets/button.dart';
import 'package:app/widgets/section.dart';
import 'package:app/widgets/text_input.dart';

class ExtraTab extends StatelessWidget {
  ExtraTab({Key key}) : super(key: key);

  void _handleButtonTap(BuildContext context) {
    final _extraTabViewModel =
        Provider.of<ExtraTabViewModel>(context, listen: false);
    _extraTabViewModel.handleButtonTap();
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final _workoutViewModel =
        Provider.of<WorkoutViewModel>(context, listen: true);
    final _extraTabViewModel =
        Provider.of<ExtraTabViewModel>(context, listen: false);
    final _appState = Provider.of<AppState>(context, listen: false);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Section(
          title: 'name',
          children: <Widget>[
            TextInput(
                multiLine: false,
                enabled: _workoutViewModel.inputsEnabled,
                primaryColor: _workoutViewModel.primaryColor,
                initialValue: _appState.workout.name,
                handleValueChanged: (n) {
                  _extraTabViewModel.setName(n);
                })
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
