import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:tenso_app/styles/styles.dart' as styles;
import 'package:tenso_app/widgets/divider.dart';
import 'package:tenso_app/widgets/execution/indicator_tabs.dart';

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
    final int _maxTotal = [totalReps, totalSets ?? 0, totalGroups].reduce(max);

    final List<Widget> _rows = [
      _Row(
          orientation: orientation,
          title: 'rep',
          current: currentRep,
          total: totalReps,
          primaryColor: primaryColor,
          maxTotal: _maxTotal),
      if (totalSets != null && totalSets > 1)
        _Row(
            orientation: orientation,
            title: 'set',
            current: currentSet,
            total: totalSets,
            primaryColor: primaryColor,
            maxTotal: _maxTotal),
      if (totalGroups > 1)
        _Row(
            orientation: orientation,
            title: 'group',
            current: currentGroup,
            total: totalGroups,
            primaryColor: primaryColor,
            maxTotal: _maxTotal),
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
  final int maxTotal;
  final Orientation orientation;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      final double _textContainerWidth = 60;
      final double _dividerWidth = styles.Measurements.xs;
      final double _indicatorHeight = styles.Measurements.s + 3;
      final double _indicatorWidth = 25;
      final bool _containerExceedsMaxWidth =
          constraints.maxWidth - _textContainerWidth - _dividerWidth <
              maxTotal.toDouble() * _indicatorWidth;
      final bool _rowExceedsMaxWidth =
          constraints.maxWidth - _textContainerWidth - _dividerWidth <
              total.toDouble() * _indicatorWidth;

      return Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
              width: _textContainerWidth,
              child: Text(
                title,
                style: styles.Staatliches.mWhite,
                textAlign: TextAlign.end,
              )),
          Divider(
            width: styles.Measurements.xs,
          ),
          if (orientation == Orientation.portrait &&
              _containerExceedsMaxWidth == true &&
              _rowExceedsMaxWidth == true)
            Expanded(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: IndicatorTabs(
                  active: current,
                  count: total,
                  primaryColor: primaryColor,
                ),
              ),
            ),
          if (orientation == Orientation.portrait &&
              _containerExceedsMaxWidth == true &&
              _rowExceedsMaxWidth == false)
            Expanded(
              child: Container(
                height: _indicatorHeight,
                width: double.infinity,
                child: IndicatorTabs(
                  active: current,
                  count: total,
                  primaryColor: primaryColor,
                ),
              ),
            ),
          if (orientation == Orientation.portrait &&
              _containerExceedsMaxWidth == false)
            Container(
              width: maxTotal.toDouble() * _indicatorWidth,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IndicatorTabs(
                    active: current,
                    count: total,
                    primaryColor: primaryColor,
                  ),
                ],
              ),
            ),
          if (orientation == Orientation.landscape)
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                IndicatorTabs(
                  active: current,
                  count: total,
                  primaryColor: primaryColor,
                ),
              ],
            )
        ],
      );
    });
  }

  const _Row(
      {@required this.title,
      @required this.current,
      @required this.total,
      @required this.primaryColor,
      @required this.orientation,
      @required this.maxTotal});
}
