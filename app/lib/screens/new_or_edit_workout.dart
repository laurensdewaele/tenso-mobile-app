import 'dart:async';

import 'package:flutter/cupertino.dart' hide Icon;
import 'package:flutter/scheduler.dart';

import 'package:provider/provider.dart';

import 'package:app/styles/styles.dart' as styles;
import 'package:app/view_models/new_or_edit_workout_vm.dart';
import 'package:app/widgets/card.dart';
import 'package:app/widgets/divider.dart';
import 'package:app/widgets/keyboard_screen.dart';
import 'package:app/widgets/new_or_edit_workout/tabs_container.dart';
import 'package:app/widgets/toast.dart';
import 'package:app/widgets/top_navigation.dart';

class NewOrEditWorkoutScreen extends StatefulWidget {
  NewOrEditWorkoutScreen();

  @override
  _NewOrEditWorkoutScreenState createState() => _NewOrEditWorkoutScreenState();
}

class _NewOrEditWorkoutScreenState extends State<NewOrEditWorkoutScreen> {
  final StreamController<bool> _shouldLoseFocusStreamController =
      StreamController<bool>.broadcast();
  final ScrollController _scrollController = ScrollController();
  final StreamController<bool> _navigateForwardTabStreamController =
      StreamController<bool>();
  final StreamController<bool> _navigateBackTabStreamController =
      StreamController<bool>();

  double _keyboardOffsetHeight = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _shouldLoseFocusStreamController.close();
    _navigateForwardTabStreamController.close();
    _navigateBackTabStreamController.close();
    super.dispose();
  }

  void _onScreenTap() {
    _shouldLoseFocusStreamController.sink.add(true);
    setState(() {
      _keyboardOffsetHeight = 0;
    });
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

  void _scrollToTop() {
    _scrollController.animateTo(0,
        duration: Duration(milliseconds: 200), curve: Curves.easeInOut);
  }

  void _onHorizontalDragEnd(DragEndDetails details) {
    if (details.primaryVelocity > 0) {
      _navigateBackTabStreamController.sink.add(true);
    }

    if (details.primaryVelocity < 0) {
      _navigateForwardTabStreamController.sink.add(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        GestureDetector(
          onTap: _onScreenTap,
          child: Consumer<NewOrEditWorkoutViewModel>(
            builder: (context, _newOrEditWorkoutViewModel, child) =>
                KeyBoardScreen(
                    handleKeyboardOffset: _handleKeyboardOffset,
                    gradientStartColor: _newOrEditWorkoutViewModel.primaryColor,
                    gradientStopColor: _newOrEditWorkoutViewModel.primaryColor,
                    child: ListView(
                        controller: _scrollController,
                        physics: ClampingScrollPhysics(),
                        children: [
                          Column(
                            children: <Widget>[
                              TopNavigation(
                                  title: _newOrEditWorkoutViewModel.title),
                              Divider(height: styles.Measurements.xxl),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: styles.Measurements.xs),
                                child: GestureDetector(
                                  onHorizontalDragEnd: _onHorizontalDragEnd,
                                  child: Card(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        TabsContainer(
                                            primaryColor:
                                                _newOrEditWorkoutViewModel
                                                    .primaryColor,
                                            onNavigation: _scrollToTop,
                                            holdCount:
                                                _newOrEditWorkoutViewModel
                                                    .workout.holdCount,
                                            shouldLoseFocusStream:
                                                _shouldLoseFocusStreamController
                                                    .stream,
                                            navigateForwardTabStream:
                                                _navigateForwardTabStreamController
                                                    .stream,
                                            navigateBackTabStream:
                                                _navigateBackTabStreamController
                                                    .stream),
                                        SizedBox(
                                          height: _keyboardOffsetHeight,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Divider(height: styles.Measurements.xxl)
                            ],
                          )
                        ])),
          ),
        ),
        Toast(),
      ],
    );
  }
}
