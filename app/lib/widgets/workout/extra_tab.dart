import 'package:flutter/cupertino.dart';

import 'package:provider/provider.dart';

import 'package:app/models/label.dart';
import 'package:app/state/app_state.dart';
import 'package:app/styles/styles.dart' as styles;
import 'package:app/view_models/extra_tab_vm.dart';
import 'package:app/view_models/workout_vm.dart';
import 'package:app/widgets/button.dart';
import 'package:app/widgets/card.dart';
import 'package:app/widgets/divider.dart';
import 'package:app/widgets/section.dart';
import 'package:app/widgets/section_with_info_icon.dart';
import 'package:app/widgets/text_input.dart';
import 'package:app/widgets/workout/label_picker.dart';

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

    return Card(
      padding: EdgeInsets.only(
        left: styles.Measurements.m,
        top: 0,
        right: styles.Measurements.m,
        bottom: styles.Measurements.l,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Divider(
            height: 12,
          ),
          SectionWithInfoIcon(
            title: 'color label',
            appDialogContent: _ColorLabelInfo(),
            children: <Widget>[
              LabelPicker(
                handleLabelChanged: (Label l) {},
                initialLabel: Label.red,
              )
            ],
          ),
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
      ),
    );
  }
}

class _ColorLabelInfo extends StatelessWidget {
  _ColorLabelInfo({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
