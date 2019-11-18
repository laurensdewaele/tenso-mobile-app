import 'package:flutter/cupertino.dart';

import 'package:app/models/models.dart';
import 'package:app/styles/styles.dart' as styles;
import 'package:app/widgets/card.dart';
import 'package:app/widgets/workout_overview_card.dart';
import 'package:app/widgets/workout_overview_delete.dart';
import 'package:app/widgets/workout_overview_edit.dart';

class WorkoutOverviewStack extends StatefulWidget {
  WorkoutOverviewStack({Key key, this.workout}) : super(key: key);

  final Workout workout;

  @override
  _WorkoutOverviewStackState createState() => _WorkoutOverviewStackState();
}

class _WorkoutOverviewStackState extends State<WorkoutOverviewStack>
    with SingleTickerProviderStateMixin {
  static final Animatable<double> _easeInOutTween =
      CurveTween(curve: Curves.easeInOut);
  static final Animatable<Offset> _horizontalOffsetTween =
      Tween(begin: Offset(0.0, 0.0), end: Offset(0.25, 0.0));
  AnimationController _controller;
  Animation<Offset> _horizontalOffset;

  @override
  void initState() {
    super.initState();

    _controller =
        AnimationController(duration: Duration(milliseconds: 200), vsync: this);
    _horizontalOffset =
        _controller.drive(_horizontalOffsetTween.chain(_easeInOutTween));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTap() {
    print('forward!!');
    setState(() {
      _controller.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        _Actions(),
        GestureDetector(
            onTap: () {
              print('tapp');
            },
            child: SlideTransition(
                position: _horizontalOffset,
                child: WorkoutOverviewCard(workout: widget.workout)))
      ],
    );
  }
}

class _Actions extends StatelessWidget {
  _Actions({Key key, this.handleEditTap, this.handleDeleteTap})
      : super(key: key);

  final VoidCallback handleEditTap;
  final VoidCallback handleDeleteTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: styles.Measurements.workoutOverviewActionContainer,
      child: Card(
        child: Row(mainAxisSize: MainAxisSize.max, children: <Widget>[
          Expanded(child: WorkoutOverviewEditAction(), flex: 1),
          Expanded(child: SizedBox(), flex: 2),
          Expanded(child: WorkoutOverviewDeleteAction(), flex: 1)
        ]),
      ),
    );
  }
}
