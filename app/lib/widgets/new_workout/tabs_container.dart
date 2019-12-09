import 'package:flutter/cupertino.dart';

import 'package:app/data/mock_data.dart';
import 'package:app/models/workout.dart';
import 'package:app/models/workout_config.dart';
import 'package:app/styles/styles.dart' as styles;
import 'package:app/widgets/new_workout/general_tab.dart';
import 'package:app/widgets/new_workout/tabs.dart';

class TabsContainer extends StatefulWidget {
  TabsContainer(
      {Key key,
      @required this.config,
      @required this.shouldLoseFocusStream,
      @required this.handleErrorMessage,
      @required this.latestWorkout,
      @required this.onNavigation})
      : super(key: key);

  final WorkoutConfig config;
  final Workout latestWorkout;
  final Stream<bool> shouldLoseFocusStream;
  final Function(Widget message) handleErrorMessage;
  final VoidCallback onNavigation;

  @override
  _TabsContainerState createState() => _TabsContainerState();
}

class _TabsContainerState extends State<TabsContainer> {
  int _pageCount;
  int _activePage;
  List<Widget> _pages;
  bool firstTimeConstructed = true;

  @override
  void initState() {
    super.initState();
    _pageCount = widget.latestWorkout.holdCount + 2;
    _activePage = 1;
    _buildPages(widget.latestWorkout.holdCount);
    firstTimeConstructed = false;
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _buildPages(
    int holdCount,
  ) {
    final Widget holdTab = Container(
      height: 1500,
      width: double.infinity,
      decoration: BoxDecoration(color: styles.Colors.difficultyBlue),
    );
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
          return holdTab;
        }),
        extraTab
      ];
    });
  }

  void _handleHoldCountChanged(int count) {
    _buildPages(count);
  }

  void _handleBackNavigation() {
    widget.onNavigation();
    setState(() {
      --_activePage;
    });
  }

  void _handleForwardNavigation() {
    widget.onNavigation();
    setState(() {
      ++_activePage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        _pages[_activePage - 1],
        Tabs(
            handleBackNavigation: _handleBackNavigation,
            handleForwardNavigation: _handleForwardNavigation,
            count: _pageCount,
            active: _activePage)
      ],
    );
  }
}
