import 'package:app/styles/styles.dart' as styles;
import 'package:app/view_models/workout/extra_page.vm.dart';
import 'package:app/view_models/workout/workout.vm.dart';
import 'package:app/view_models/workout/workout_navigator.dart';
import 'package:app/widgets/button.dart';
import 'package:app/widgets/card.dart';
import 'package:app/widgets/divider.dart';
import 'package:app/widgets/section.dart';
import 'package:app/widgets/section_with_info_icon.dart';
import 'package:app/widgets/text_input.dart';
import 'package:app/widgets/workout/label_picker.dart';
import 'package:app/widgets/workout/navigation_indicator.dart';
import 'package:flutter/cupertino.dart';

class ExtraPage extends StatefulWidget {
  ExtraPage({Key key, this.workoutViewModel, this.workoutNavigator})
      : super(key: key);

  final WorkoutNavigator workoutNavigator;
  final WorkoutViewModel workoutViewModel;

  @override
  _ExtraPageState createState() => _ExtraPageState();
}

class _ExtraPageState extends State<ExtraPage> {
  ExtraPageViewModel _viewModel;

  void initState() {
    _viewModel = ExtraPageViewModel(
        workoutNavigator: widget.workoutNavigator,
        workoutViewModel: widget.workoutViewModel);
    super.initState();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
          Divider(height: 14),
          SectionWithInfoIcon(
            title: 'color label',
            appDialogContent: _ColorLabelInfo(),
            children: <Widget>[
              LabelPicker(
                  handleLabelChanged: _viewModel.setLabel,
                  initialLabel: _viewModel.state.label,
                  enabled: _viewModel.state.inputsEnabled)
            ],
          ),
          Section(
            title: 'name',
            children: <Widget>[
              TextInput(
                  multiLine: false,
                  enabled: _viewModel.state.inputsEnabled,
                  primaryColor: _viewModel.state.primaryColor,
                  initialValue: _viewModel.state.name,
                  handleValueChanged: _viewModel.setName)
            ],
          ),
          Center(
            child: Button(
              backgroundColor: _viewModel.state.primaryColor,
              width: styles.Measurements.xxl * 2,
              text: _viewModel.state.extraTabButtonText,
              handleTap: _viewModel.handleForwardRequest,
            ),
          ),
          Divider(
            height: styles.Measurements.xxl,
          ),
          NavigationIndicator(
            primaryColor: _viewModel.state.primaryColor,
            activeIndex: _viewModel.state.totalPages - 1,
            count: _viewModel.state.totalPages,
            handleBackNavigation: widget.workoutNavigator.handleBackRequest,
            handleForwardNavigation:
                widget.workoutNavigator.handleForwardRequest,
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
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          'By giving your workout a color label, it will become easier to distuingish between workouts on the calendar overview.',
          style: styles.Lato.xsBlack,
        ),
        Divider(height: styles.Measurements.l),
        Center(
          child: Transform.scale(
            scale: .8,
            child: Button(
                displayBackground: false,
                text: 'Ok',
                handleTap: () {
                  Navigator.of(context).pop();
                }),
          ),
        )
      ],
    );
  }
}
