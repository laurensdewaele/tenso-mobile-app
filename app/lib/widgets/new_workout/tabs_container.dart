import 'dart:async';

import 'package:flutter/cupertino.dart';

import 'package:app/models/grades.dart';
import 'package:app/state/workout.dart';
import 'package:app/styles/styles.dart' as styles;
import 'package:app/widgets/new_workout/extra_tab.dart';
import 'package:app/widgets/new_workout/general_tab.dart';
import 'package:app/widgets/new_workout/hold_tab.dart';
import 'package:app/widgets/new_workout/tabs.dart';

class TabsContainer extends StatefulWidget {
  TabsContainer(
      {Key key,
      @required this.holdCount,
      @required this.shouldLoseFocusStream,
      @required this.handleErrorMessage,
      @required this.workoutModel,
      @required this.onNavigation,
      this.navigateForwardTabStream,
      this.navigateBackTabStream})
      : super(key: key);

  final int holdCount;
  final WorkoutModel workoutModel;
  final Stream<bool> shouldLoseFocusStream;
  final Function(Widget message) handleErrorMessage;
  final VoidCallback onNavigation;
  final Stream<bool> navigateForwardTabStream;
  final Stream<bool> navigateBackTabStream;

  @override
  _TabsContainerState createState() => _TabsContainerState();
}

class _TabsContainerState extends State<TabsContainer> {
  int _activePageIndex;
  List<Widget> _pages;
  bool _firstTimeConstructed = true;
  StreamSubscription _navigateForwardTabSub;
  StreamSubscription _navigateBackTabSub;

  @override
  void initState() {
    super.initState();
    _activePageIndex = 0;
    _buildPages(widget.holdCount);
    _firstTimeConstructed = false;
    _navigateForwardTabSub =
        widget.navigateForwardTabStream.listen((bool shouldNavigate) {
      _handleForwardNavigation();
    });
    _navigateBackTabSub =
        widget.navigateBackTabStream.listen((bool shouldNavigate) {
      _handleBackNavigation();
    });
  }

  @override
  void dispose() {
    _navigateBackTabSub.cancel();
    _navigateForwardTabSub.cancel();
    super.dispose();
  }

  @override
  void didUpdateWidget(TabsContainer oldWidget) {
    if (oldWidget.holdCount != widget.holdCount) {
      _buildPages(widget.holdCount);
    }
    super.didUpdateWidget(oldWidget);
  }

  void _buildPages(
    int holdCount,
  ) {
    setState(() {
      _pages = [
        // TODO: Connect with store
        GeneralTab(
          shouldFocusOnInput: _firstTimeConstructed,
          handleErrorMessage: widget.handleErrorMessage,
          shouldLoseFocusStream: widget.shouldLoseFocusStream,
          key: ValueKey('new-workout-page-1'),
        ),
        ...List.generate(holdCount, (i) => i).map((n) {
          return HoldTab(
            key: UniqueKey(),
            handleErrorMessage: widget.handleErrorMessage,
            shouldLoseFocusStream: widget.shouldLoseFocusStream,
            currentHold: n,
          );
        }),
        ExtraTab(
          handleErrorMessage: widget.handleErrorMessage,
          shouldLoseFocusStream: widget.shouldLoseFocusStream,
          name: widget.workoutModel.name,
          difficulty: widget.workoutModel.difficulty,
          grades: Grades.boulderFont,
          key: UniqueKey(),
          handleSave: _handleSave,
        )
      ];
    });
  }

  void _handleBackNavigation() {
    if (_activePageIndex == 0) {
      Navigator.of(context).pop();
    } else {
      setState(() {
        --_activePageIndex;
      });
    }
  }

  void _handleForwardNavigation() {
    if (_activePageIndex <= _pages.length - 2)
      setState(() {
        ++_activePageIndex;
      });
  }

  void _handleNavigation(int index) {
    setState(() {
      _activePageIndex = index;
    });
  }

  void _handleSave() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: styles.Measurements.m,
              vertical: styles.Measurements.l),
          child: _pages[_activePageIndex],
        ),
        Tabs(
            handleNavigation: _handleNavigation,
            handleBackNavigation: _handleBackNavigation,
            handleForwardNavigation: _handleForwardNavigation,
            count: _pages.length,
            activeIndex: _activePageIndex)
      ],
    );
  }
}
