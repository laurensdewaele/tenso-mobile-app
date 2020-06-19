import 'package:app/models/group.model.dart';
import 'package:app/styles/styles.dart' as styles;
import 'package:app/widgets/execution/indicator_tabs.dart';
import 'package:app/widgets/workout/horizontal_group_overview.dart';
import 'package:flutter/cupertino.dart';

class HorizontalGroupOverviewWithIndicator extends StatefulWidget {
  HorizontalGroupOverviewWithIndicator({Key key, @required this.groups})
      : super(key: key);

  final List<Group> groups;

  @override
  _HorizontalGroupOverviewWithIndicatorState createState() =>
      _HorizontalGroupOverviewWithIndicatorState();
}

class _HorizontalGroupOverviewWithIndicatorState
    extends State<HorizontalGroupOverviewWithIndicator> {
  int _visibleBoardIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  _setVisibleBoardIndex(int index) {
    setState(() {
      _visibleBoardIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        HorizontalGroupOverview(
          groups: widget.groups,
          reportVisibleBoardIndex: _setVisibleBoardIndex,
        ),
        IndicatorTabs(
          primaryColor: styles.Colors.primary,
          count: widget.groups.length,
          active: _visibleBoardIndex + 1,
        )
      ],
    );
  }
}
