import 'dart:async';

import 'package:flutter/cupertino.dart' hide Icon;

import 'package:app/models/workout_ui_configuration.dart';
import 'package:app/styles/styles.dart' as styles;
import 'package:app/widgets/card.dart';
import 'package:app/widgets/divider.dart';
import 'package:app/widgets/icon.dart';
import 'package:app/widgets/integer_input_and_description.dart';
import 'package:app/widgets/screen.dart';
import 'package:app/widgets/toast.dart';

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

  Widget _determineInputElement(WorkoutElement workoutElement) {
    switch (workoutElement.workoutInputType) {
      case WorkoutInputTypes.number:
        return IntegerInputAndDescription(
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
                    _TopNavigation(title: 'New workout'),
                    Card(
                      padding: EdgeInsets.symmetric(
                          horizontal: styles.Measurements.m,
                          vertical: styles.Measurements.l),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          ...widget.workoutSections
                              .map((WorkoutSection workoutSection) {
                            return Container(
                              width: double.infinity,
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    width: double.infinity,
                                    child: Text(workoutSection.title,
                                        style: styles.Typography.title),
                                  ),
                                  Divider(height: styles.Measurements.l),
                                  ...workoutSection.workoutElements
                                      .map((WorkoutElement workoutElement) {
                                        return [
                                          _determineInputElement(
                                              workoutElement),
                                          Divider(
                                            height: styles.Measurements.m,
                                          )
                                        ];
                                      })
                                      .expand((inputElementPlusDivider) =>
                                          inputElementPlusDivider)
                                      .toList(),
                                  Divider(height: styles.Measurements.l),
                                ],
                              ),
                            );
                          })
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

class _TopNavigation extends StatelessWidget {
  _TopNavigation({this.title});

  final String title;

  void _handleTap(BuildContext context) {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Stack(children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Expanded(
              child: Text(title,
                  style: styles.Typography.topNavigationTitle,
                  textAlign: TextAlign.center),
            ),
          ],
        ),
        GestureDetector(
          onTap: () => _handleTap(context),
          child: Container(
            width: styles.Measurements.xxl,
            child: Icon(
              iconData: CupertinoIcons.back,
              color: styles.Colors.white,
            ),
          ),
        ),
      ]),
      Divider(height: styles.Measurements.xxl)
    ]);
  }
}
