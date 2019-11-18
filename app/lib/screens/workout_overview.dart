import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' hide Divider, Card;
import 'package:flutter/widgets.dart';

import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:app/models/models.dart';
import 'package:app/styles/styles.dart' as styles;
import 'package:app/widgets/button.dart';
import 'package:app/widgets/card.dart';
import 'package:app/widgets/dividers.dart';
import 'package:app/widgets/screen.dart';
import 'package:app/widgets/workout_overview_card.dart';

class WorkoutOverviewScreen extends StatefulWidget {
  WorkoutOverviewScreen({@required this.workouts});
  final List<Workout> workouts;

  @override
  _WorkoutOverviewScreenState createState() => _WorkoutOverviewScreenState();
}

class _WorkoutOverviewScreenState extends State<WorkoutOverviewScreen> {
  bool _isSlideOpen;

  void _handleAddWorkout() {
    print('Add workout!');
  }

  void _onSlideIsOpenChanged(bool isSlideOpen) {
    setState(() {
      _isSlideOpen = isSlideOpen;
    });
  }

  ValueChanged _test1(Animation<double> test) {}

  @override
  Widget build(BuildContext context) {
    final EdgeInsets padding = MediaQuery.of(context).padding;
    final double viewHeight =
        MediaQuery.of(context).size.height - padding.top - padding.bottom;

    return Screen(
        gradientStartColor: styles.Colors.bgGrayStart,
        gradientStopColor: styles.Colors.bgGrayStop,
        child: ListView.separated(
          itemCount: widget.workouts.length + 2,
          itemBuilder: (BuildContext context, int index) {
            if (index < widget.workouts.length) {
              // Need to wrap in our Card widget.
              // Otherwise the gray background will be visible on the borderRadii.
              return Card(
                  child: Slidable(
                controller: SlidableController(
                    onSlideIsOpenChanged: _onSlideIsOpenChanged),
                secondaryActions: <Widget>[_SecondaryActions()],
                actionExtentRatio: 0.25,
                actions: <Widget>[_Actions()],
                actionPane: SlidableBehindActionPane(),
                child: SlidableControllerState(
                    isSlideOpen: _isSlideOpen,
                    child: WorkoutOverviewCard(
                      key: Key('workout-$index'),
                      workout: widget.workouts[index],
                    )),
              ));
            } else if (index == widget.workouts.length) {
              return Button(
                  text: 'Add workout', handleClick: _handleAddWorkout);
            } else {
              return SizedBox(height: viewHeight / 2 - styles.Measurements.m);
            }
          },
          separatorBuilder: (BuildContext context, int index) =>
              const Divider(),
        ));
  }
}

class SlidableControllerState extends InheritedWidget {
  SlidableControllerState({Key key, this.isSlideOpen, this.child})
      : super(key: key, child: child);

  final bool isSlideOpen;
  final Widget child;

  static SlidableControllerState of(BuildContext context) {
    return context.inheritFromWidgetOfExactType(SlidableControllerState);
  }

  @override
  bool updateShouldNotify(SlidableControllerState oldWidget) =>
      oldWidget.isSlideOpen != isSlideOpen;
}

class _Actions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(overflow: Overflow.clip, children: <Widget>[
      Container(
          decoration: const BoxDecoration(
              color: styles.Colors.difficultyBlue,
              borderRadius: BorderRadius.only(
                  topLeft: styles.kAppBorderRadius,
                  bottomLeft: styles.kAppBorderRadius)),
          child: Center(
              child: Text(
            'EDIT',
            style: styles.Typography.indicatorWhite,
          ))),
      _InnerBoxShadow(position: _InnerBoxShadowRadiusPosition.left)
    ]);
  }
}

class _SecondaryActions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      overflow: Overflow.clip,
      children: <Widget>[
        Container(
            decoration: const BoxDecoration(
                color: styles.Colors.primary,
                borderRadius: BorderRadius.only(
                    topRight: styles.kAppBorderRadius,
                    bottomRight: styles.kAppBorderRadius)),
            child: Center(
                child: Text(
              'DELETE',
              style: styles.Typography.indicatorWhite,
            ))),
        _InnerBoxShadow(position: _InnerBoxShadowRadiusPosition.right),
      ],
    );
  }
}

enum _InnerBoxShadowRadiusPosition { left, right }

class _InnerBoxShadow extends StatelessWidget {
  _InnerBoxShadow({this.position})
      : _borderRadius = _determineBorderRadius(position);

  final _InnerBoxShadowRadiusPosition position;
  final BorderRadius _borderRadius;

  static BorderRadius _determineBorderRadius(
      _InnerBoxShadowRadiusPosition position) {
    if (position == _InnerBoxShadowRadiusPosition.left) {
      return BorderRadius.only(topLeft: styles.kAppBorderRadius);
    }
    return BorderRadius.only(topRight: styles.kAppBorderRadius);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 10,
      decoration: BoxDecoration(
          borderRadius: _borderRadius,
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color.fromRGBO(0, 0, 0, .2),
                Color.fromRGBO(0, 0, 0, 0),
              ])),
    );
  }
}
