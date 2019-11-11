import 'package:app/widgets/card_overview_collapsed.dart';
import 'package:app/widgets/card_overview_expanded.dart';
import 'package:flutter/cupertino.dart';

import 'package:app/data/interfaces.dart';

class CardOverview extends StatefulWidget {
  CardOverview({Key key, this.workout}) : super(key: key);

  final Workout workout;

  @override
  _CardOverviewState createState() => _CardOverviewState();
}

class _CardOverviewState extends State<CardOverview> {
  bool collapsed = true;

  void toggle() {
    setState(() {
      collapsed = !collapsed;
    });
  }

  void _handleExpand() {
    toggle();
  }

  void _handleCollapse() {
    toggle();
  }

  @override
  Widget build(BuildContext context) {
    return collapsed
        ? CardOverviewCollapsed(
            workout: widget.workout,
            handleExpand: _handleExpand,
          )
        : CardOverviewExpanded(
            workout: widget.workout, handleCollapse: _handleCollapse);
  }
}
