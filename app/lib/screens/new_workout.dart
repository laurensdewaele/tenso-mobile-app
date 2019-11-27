import 'dart:async';

import 'package:flutter/cupertino.dart' hide Icon;

import 'package:app/models/workout_ui_configuration.dart';
import 'package:app/styles/styles.dart' as styles;
import 'package:app/widgets/card.dart';
import 'package:app/widgets/divider.dart';
import 'package:app/widgets/integer_input_and_description.dart';
import 'package:app/widgets/screen.dart';
import 'package:app/widgets/toast.dart';
import 'package:app/widgets/top_navigation.dart';

class NewWorkoutScreen extends StatefulWidget {
  NewWorkoutScreen({this.workoutSections});
  final List<WorkoutSection> workoutSections;

  @override
  _NewWorkoutScreenState createState() => _NewWorkoutScreenState();
}

class _NewWorkoutScreenState extends State<NewWorkoutScreen> {
  final StreamController<bool> _shouldLoseFocusStreamController =
      StreamController<bool>.broadcast();
  final StreamController<String> _errorMessageStreamController =
      StreamController<String>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _shouldLoseFocusStreamController.close();
    _errorMessageStreamController.close();
  }

  void _onScreenTap() {
    _shouldLoseFocusStreamController.sink.add(true);
  }

  void _handleErrorMessage(String message) {
    _errorMessageStreamController.sink.add(message);
  }

  // This method gets triggered a lot.
  // Because we do not keep track of which number input is active at the time.
  // When we do a validation, we validate all number fields.
  // Fine for now. Assuming this does not cause too much of a performance hit.
  // It might be when we integrate state management.
  // TODO: Keep track of performance impact
  void _handleIntValueChanged(
      int value,
      GeneralWorkoutConfigurationProperties generalWorkoutConfigurationProperty,
      HoldWorkoutConfigurationProperties holdWorkoutConfigurationProperty,
      ExtraWorkoutConfigurationProperties extraWorkoutConfigurationProperty) {}

  List<Widget> _mapWorkoutElementsToInputWidgets(
      List<WorkoutElement> workoutElements) {
    return workoutElements
        // A trick in order to get the index whilst mapping.
        .asMap()
        .map((int index, WorkoutElement workoutElement) {
          return MapEntry(index, [
            _determineInputElement(workoutElement, index == 0),
            Divider(
              height: styles.Measurements.m,
            )
          ]);
        })
        .values
        .expand((inputElementPlusDivider) => inputElementPlusDivider)
        .toList();
  }

  Widget _determineInputElement(WorkoutElement workoutElement, bool isFirst) {
    switch (workoutElement.workoutInputType) {
      case WorkoutInputTypes.number:
        return IntegerInputAndDescription(
          isFirst: isFirst,
          workoutElement: workoutElement,
          handleErrorMessage: _handleErrorMessage,
          shouldLoseFocusStream: _shouldLoseFocusStreamController.stream,
          handleValueChanged: (int value) => {
            _handleIntValueChanged(
                value,
                workoutElement.generalWorkoutConfigurationProperty,
                workoutElement.holdWorkoutConfigurationProperty,
                workoutElement.extraWorkoutConfigurationProperty)
          },
        );
        break;
      default:
        return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        GestureDetector(
          onTap: _onScreenTap,
          child: Screen(
              gradientStartColor: styles.Colors.primary,
              gradientStopColor: styles.Colors.bgRedStop,
              child: ListView(physics: ClampingScrollPhysics(), children: [
                Column(
                  children: <Widget>[
                    TopNavigation(title: 'New workout'),
                    Card(
                      padding: EdgeInsets.symmetric(
                          horizontal: styles.Measurements.m,
                          vertical: styles.Measurements.l),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          ...widget.workoutSections
                              .map((WorkoutSection workoutSection) {
                                return [
                                  Text(workoutSection.title,
                                      style: styles.Typography.title),
                                  Divider(height: styles.Measurements.l),
                                  ..._mapWorkoutElementsToInputWidgets(
                                      workoutSection.workoutElements),
                                  Divider(height: styles.Measurements.l),
                                ];
                              })
                              .expand((section) => section)
                              .toList()
                        ],
                      ),
                    )
                  ],
                )
              ])),
        ),
        Toast(messageStream: _errorMessageStreamController.stream),
      ],
    );
  }
}
