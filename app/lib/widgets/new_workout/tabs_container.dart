import 'dart:async';

import 'package:flutter/cupertino.dart';

import 'package:app/data/mock_data.dart';
import 'package:app/models/workout.dart';
import 'package:app/models/workout_config.dart';
import 'package:app/styles/styles.dart' as styles;
import 'package:app/widgets/new_workout/general_tab.dart';
import 'package:app/widgets/new_workout/hold_tab.dart';
import 'package:app/widgets/new_workout/tabs.dart';

class TabsContainer extends StatefulWidget {
  TabsContainer(
      {Key key,
      @required this.config,
      @required this.shouldLoseFocusStream,
      @required this.handleErrorMessage,
      @required this.latestWorkout,
      @required this.onNavigation,
      this.navigateForwardTabStream,
      this.navigateBackTabStream})
      : super(key: key);

  final WorkoutConfig config;
  final Workout latestWorkout;
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
    _pageCount = widget.latestWorkout.holdCount + 2;
    _pageCountList = List.generate(_pageCount, (i) => i + 1);
    _activePage = 1;
    _buildPages(widget.latestWorkout.holdCount);
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

  void _buildPages(
    int holdCount,
  ) {
    final Widget extraTab = Container(
      height: 1500,
      width: double.infinity,
      decoration: BoxDecoration(color: styles.Colors.difficultyOrange),
    );
    setState(() {
      _pageCount = holdCount + 2;
      _pages = [
        GeneralTab(
          shouldFocusOnInput: firstTimeConstructed,
          handleErrorMessage: widget.handleErrorMessage,
          shouldLoseFocusStream: widget.shouldLoseFocusStream,
          latestWorkout: mockWorkout,
          config: widget.config.generalConfig,
          handleHoldCountChanged: _handleHoldCountChanged,
          key: ValueKey('new-workout-page-1'),
        ),
        ...List.generate(holdCount, (i) => i + 1).map((n) {
          return HoldTab(
              key: UniqueKey(),
              latestWorkout: mockWorkout,
              handleErrorMessage: widget.handleErrorMessage,
              shouldLoseFocusStream: widget.shouldLoseFocusStream,
              config: widget.config.holdConfig,
              currentGrip: n,
              totalGrips: holdCount);
        }),
        extraTab
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
