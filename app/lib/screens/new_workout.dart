import 'dart:async';

import 'package:flutter/cupertino.dart' hide Icon;
import 'package:flutter/scheduler.dart';

import 'package:app/models/workout_ui_configuration.dart';
import 'package:app/styles/styles.dart' as styles;
import 'package:app/widgets/card.dart';
import 'package:app/widgets/divider.dart';
import 'package:app/widgets/integer_input_and_description.dart';
import 'package:app/widgets/keyboard_screen.dart';
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
  final StreamController<Widget> _errorMessageStreamController =
      StreamController<Widget>();
  final ScrollController _scrollController = ScrollController();

  double _keyboardOffsetHeight = 0;

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
    setState(() {
      _keyboardOffsetHeight = 0;
    });
  }

  void _handleErrorMessage(Widget message) {
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
          key: ObjectKey(workoutElement),
          isFirst: workoutElement.isFirst,
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

  void _handleKeyboardOffset(Offset offset) {
    setState(() {
      _keyboardOffsetHeight = offset.dy;
    });

    if (offset.dy == 0) return;

    final double originalScrollDifference =
        _scrollController.position.maxScrollExtent - _scrollController.offset;

    SchedulerBinding.instance.addPostFrameCallback((_) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent - originalScrollDifference,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        GestureDetector(
          onTap: _onScreenTap,
          child: KeyBoardScreen(
              handleKeyboardOffset: _handleKeyboardOffset,
              gradientStartColor: styles.Colors.primary,
              gradientStopColor: styles.Colors.bgRedStop,
              child: ListView(
                  controller: _scrollController,
                  physics: ClampingScrollPhysics(),
                  children: [
                    Column(
                      children: <Widget>[
                        TopNavigation(title: 'New workout'),
                        Card(
                          padding: EdgeInsets.symmetric(
                              horizontal: styles.Measurements.m,
                              vertical: styles.Measurements.l),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              ...widget.workoutSections
                                  .map((WorkoutSection workoutSection) {
                                    return [
                                      Text(workoutSection.title,
                                          key: ValueKey(workoutSection.title),
                                          style: styles.Typography.title),
                                      Divider(
                                          key: ValueKey(styles.Measurements.l),
                                          height: styles.Measurements.l),
                                      ...workoutSection.workoutElements
                                          .map((WorkoutElement workoutElement) {
                                            return [
                                              _determineInputElement(
                                                  workoutElement),
                                              Divider(
                                                key: ValueKey(
                                                    styles.Measurements.m),
                                                height: styles.Measurements.m,
                                              )
                                            ];
                                          })
                                          .expand((inputElementPlusDivider) =>
                                              inputElementPlusDivider)
                                          .toList(),
                                      Divider(
                                          key: ValueKey(styles.Measurements.l),
                                          height: styles.Measurements.l),
                                    ];
                                  })
                                  .expand((section) => section)
                                  .toList(),
                              SizedBox(
                                key: UniqueKey(),
                                height: _keyboardOffsetHeight,
                              )
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
