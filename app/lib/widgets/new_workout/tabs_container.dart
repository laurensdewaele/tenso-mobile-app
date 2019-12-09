import 'package:flutter/cupertino.dart';

import 'package:app/data/mock_data.dart';
import 'package:app/models/workout_config.dart';
import 'package:app/widgets/new_workout/general_tab.dart';
import 'package:app/widgets/new_workout/tabs.dart';

class TabsContainer extends StatefulWidget {
  TabsContainer(
      {Key key,
      this.config,
      this.shouldLoseFocusStream,
      this.handleErrorMessage})
      : super(key: key);

  final WorkoutConfig config;
  final Stream<bool> shouldLoseFocusStream;
  final Function(Widget message) handleErrorMessage;

  @override
  _TabsContainerState createState() => _TabsContainerState();
}

class _TabsContainerState extends State<TabsContainer> {
  int _amount = 7;
  int _active = 7;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _handleBackNavigation() {
    print('back');
  }

  void _handleForwardNavigation() {
    print('forward');
  }

  @override
  Widget build(BuildContext context) {
    final content = GeneralTab(
      handleErrorMessage: widget.handleErrorMessage,
      shouldLoseFocusStream: widget.shouldLoseFocusStream,
      latestWorkout: mockWorkout,
      config: widget.config.generalConfig,
    );

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        content,
        Tabs(
            handleBackNavigation: _handleBackNavigation,
            handleForwardNavigation: _handleForwardNavigation,
            amount: _amount,
            active: _active)
      ],
    );
  }
}
