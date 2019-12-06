import 'package:flutter/cupertino.dart';

import 'package:app/models/workout_config.dart';
import 'package:app/widgets/new_workout/tabs.dart';

class TabsContainer extends StatefulWidget {
  TabsContainer({this.config});

  final WorkoutConfig config;

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
    // TODO: implement dispose
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
    final content = Container(
      width: double.infinity,
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
