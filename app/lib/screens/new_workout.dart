import 'package:app/widgets/slider.dart';
import 'package:flutter/cupertino.dart' hide Icon;

import 'package:app/models/workout_ui_configuration.dart';
import 'package:app/styles/styles.dart' as styles;
import 'package:app/widgets/card.dart';
import 'package:app/widgets/counter.dart';
import 'package:app/widgets/dividers.dart';
import 'package:app/widgets/icon.dart';
import 'package:app/widgets/screen.dart';
import 'package:flutter/cupertino.dart' as prefix0;

class NewWorkoutScreen extends StatelessWidget {
  NewWorkoutScreen({this.workoutSections});

  final List<WorkoutSection> workoutSections;

  void _handleIntValueChanged(
      int value,
      GeneralWorkoutConfigurationProperties generalWorkoutConfigurationProperty,
      HoldWorkoutConfigurationProperties holdWorkoutConfigurationProperty,
      ExtraWorkoutConfigurationProperties extraWorkoutConfigurationProperty) {
    print(value);
    print(generalWorkoutConfigurationProperty);
    print(holdWorkoutConfigurationProperty);
    print(extraWorkoutConfigurationProperty);
  }

  Widget _determineInputElement(WorkoutElement workoutElement) {
    switch (workoutElement.workoutInputType) {
      case WorkoutInputTypes.counter:
        return Counter(
          initialIntValue: workoutElement.initialIntValue,
          description: workoutElement.description,
          handleValueChanged: (int value) => {
            _handleIntValueChanged(
                value,
                workoutElement.generalWorkoutConfigurationProperty,
                workoutElement.holdWorkoutConfigurationProperty,
                workoutElement.extraWorkoutConfigurationProperty)
          },
        );
        break;
      case WorkoutInputTypes.slider:
        return Slider(
          minIntValue: workoutElement.minIntValue,
          maxIntValue: workoutElement.maxIntValue,
          initialIntValue: workoutElement.initialIntValue,
          description: workoutElement.description,
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
    return Screen(
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
                    ...workoutSections.map((WorkoutSection workoutSection) {
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
                                    Container(
                                        width: double.infinity,
                                        child: Row(
                                          children: <Widget>[
                                            Container(
                                              width: 40,
                                              child: CupertinoTextField(
                                                style: styles.Typography
                                                    .inputDescriptionSquare,
                                                decoration: BoxDecoration(
                                                    color:
                                                        styles.Colors.primary,
                                                    borderRadius: styles
                                                        .kAppBorderRadiusAll),
                                                keyboardType:
                                                    TextInputType.number,
                                              ),
                                            ),
                                            Text(workoutElement.description,
                                                style: styles.Typography.text)
                                          ],
                                        )),
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
        ]));
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
