import 'dart:async';

import 'package:app/models/settings.dart';
import 'package:flutter/cupertino.dart';

import 'package:app/models/hold.dart';
import 'package:app/models/workout.dart';
import 'package:app/models/workout_config.dart';
import 'package:app/styles/styles.dart' as styles;
import 'package:app/widgets/new_workout/extra_tab.dart';
import 'package:app/widgets/new_workout/general_tab.dart';
import 'package:app/widgets/new_workout/hold_tab.dart';
import 'package:app/widgets/new_workout/tabs.dart';

class TabsContainer extends StatefulWidget {
  TabsContainer(
      {Key key,
      @required this.config,
      @required this.shouldLoseFocusStream,
      @required this.handleErrorMessage,
      @required this.workout,
      @required this.onNavigation,
      this.navigateForwardTabStream,
      this.navigateBackTabStream})
      : super(key: key);

  final WorkoutConfig config;
  final Workout workout;
  final Stream<bool> shouldLoseFocusStream;
  final Function(Widget message) handleErrorMessage;
  final VoidCallback onNavigation;
  final Stream<bool> navigateForwardTabStream;
  final Stream<bool> navigateBackTabStream;

  @override
  _TabsContainerState createState() => _TabsContainerState();
}

class _TabsContainerState extends State<TabsContainer> {
  int _pageCount;
  int _activePage;
  List<Widget> _pages;
  bool firstTimeConstructed = true;
  StreamSubscription _navigateForwardTabSub;
  StreamSubscription _navigateBackTabSub;
  List<int> _pageCountList;

  @override
  void initState() {
    super.initState();
    _pageCount = widget.workout.holdCount + 2;
    _pageCountList = List.generate(_pageCount, (i) => i + 1);
    _activePage = 1;
    _buildPages(widget.workout.holdCount);
    firstTimeConstructed = false;
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

  Hold _generateHoldFromBasicConfigAndGlobalSettings() {
    // TODO: Implement this
    return Hold();
  }

  Hold _getHold(int n) {
    final List<Hold> holds = widget.workout.holds;
    Hold hold;
    try {
      hold = holds[n];
    } on RangeError catch (_) {
      if (holds.length > 0) {
        hold = holds[holds.length - 1];
      } else {
        hold = _generateHoldFromBasicConfigAndGlobalSettings();
      }
    }
    return hold;
  }

  void _buildPages(
    int holdCount,
  ) {
    setState(() {
      _pageCount = holdCount + 2;
      _pages = [
        GeneralTab(
          shouldFocusOnInput: firstTimeConstructed,
          handleErrorMessage: widget.handleErrorMessage,
          shouldLoseFocusStream: widget.shouldLoseFocusStream,
          workout: widget.workout,
          config: widget.config.generalConfig,
          handleHoldCountChanged: _handleHoldCountChanged,
          key: ValueKey('new-workout-page-1'),
        ),
        ...List.generate(holdCount, (i) => i + 1).map((n) {
          return HoldTab(
            board: widget.workout.board,
            key: UniqueKey(),
            hold: _getHold(n),
            handleErrorMessage: widget.handleErrorMessage,
            shouldLoseFocusStream: widget.shouldLoseFocusStream,
            config: widget.config.holdConfig,
            currentHold: n,
            totalHolds: holdCount,
          );
        }),
        ExtraTab(
          handleErrorMessage: widget.handleErrorMessage,
          shouldLoseFocusStream: widget.shouldLoseFocusStream,
          name: widget.workout.name,
          difficulty: widget.workout.difficulty,
          grades: Grades.boulderFont,
          key: UniqueKey(),
          handleSave: _handleSave,
        )
      ];
    });
  }

  void _handleHoldCountChanged(int count) {
    _buildPages(count);
  }

  void _handleBackNavigation() {
    final int newPage = _activePage - 1;

    if (_pageCountList.contains(newPage)) {
      widget.onNavigation();
      setState(() {
        _activePage = newPage;
      });
    }

    if (newPage == 0) {
      Navigator.of(context).pop();
    }
  }

  void _handleForwardNavigation() {
    final int newPage = _activePage + 1;

    if (_pageCountList.contains(newPage)) {
      widget.onNavigation();
      setState(() {
        _activePage = newPage;
      });
    }
  }

  void _handleNavigation(int page) {
    setState(() {
      _activePage = page;
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
          child: _pages[_activePage - 1],
        ),
        Tabs(
            handleNavigation: _handleNavigation,
            handleBackNavigation: _handleBackNavigation,
            handleForwardNavigation: _handleForwardNavigation,
            count: _pageCount,
            active: _activePage)
      ],
    );
  }
}
