import 'package:app/styles/styles.dart' as styles;
import 'package:app/widgets/divider.dart';
import 'package:app/widgets/execution/indicator_tabs.dart';
import 'package:flutter/cupertino.dart';

class ExecutionIndicator extends StatelessWidget {
  const ExecutionIndicator(
      {@required this.currentRep,
      @required this.totalReps,
      @required this.currentSet,
      @required this.totalSets,
      @required this.currentGroup,
      @required this.totalGroups,
      @required this.primaryColor,
      @required this.orientation});

  final Orientation orientation;
  final int totalReps;
  final int currentRep;
  final int currentSet;
  final int totalSets;
  final int currentGroup;
  final int totalGroups;
  final Color primaryColor;

  @override
  Widget build(BuildContext context) {
    final List<Widget> _rows = [
      _Row(
        title: 'rep',
        current: currentRep,
        total: totalReps,
        primaryColor: primaryColor,
      ),
      if (totalSets != null && totalSets > 1)
        _Row(
          title: 'set',
          current: currentSet,
          total: totalSets,
          primaryColor: primaryColor,
        ),
      _Row(
        title: 'group',
        current: currentGroup,
        total: totalGroups,
        primaryColor: primaryColor,
      ),
    ];

    if (orientation == Orientation.portrait) {
      return Column(
          crossAxisAlignment: CrossAxisAlignment.center, children: _rows);
    }

    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.max,
        children: _rows);
  }
}

class _Row extends StatelessWidget {
  final String title;
  final int current;
  final int total;
  final Color primaryColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
            width: 60,
            child: Text(
              title,
              style: styles.Staatliches.mWhite,
              textAlign: TextAlign.end,
            )),
        Divider(
          width: styles.Measurements.xs,
        ),
        IndicatorTabs(
          active: current,
          count: total,
          primaryColor: primaryColor,
        )
      ],
    );
  }

  const _Row({
    @required this.title,
    @required this.current,
    @required this.total,
    @required this.primaryColor,
  });
}
