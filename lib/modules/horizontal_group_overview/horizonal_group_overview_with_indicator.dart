import 'package:flutter/cupertino.dart';
import 'package:tenso_app/models/group.model.dart';
import 'package:tenso_app/modules/common/horizontal_group_overview/horizontal_group_navigation_indicator.dart';
import 'package:tenso_app/modules/common/horizontal_group_overview/horizontal_group_overview.dart';
import 'package:tenso_app/styles/styles.dart' as styles;
import 'package:tenso_app/widgets/divider.dart';

class HorizontalGroupOverviewWithIndicator extends StatefulWidget {
  HorizontalGroupOverviewWithIndicator(
      {Key key, @required this.groups, this.handleVisibleGroupIndex})
      : super(key: key);

  final List<Group> groups;
  final void Function(int index) handleVisibleGroupIndex;

  @override
  _HorizontalGroupOverviewWithIndicatorState createState() =>
      _HorizontalGroupOverviewWithIndicatorState();
}

class _HorizontalGroupOverviewWithIndicatorState
    extends State<HorizontalGroupOverviewWithIndicator> {
  int _visibleGroupIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  _setVisibleGroupIndex(int index) {
    setState(() {
      _visibleGroupIndex = index;
    });
  }

  _handleVisibleGroupIndex(int index) {
    _setVisibleGroupIndex(index);
    if (widget.handleVisibleGroupIndex != null) {
      widget.handleVisibleGroupIndex(index);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        HorizontalGroupOverview(
          groups: widget.groups,
          handleVisibleGroupIndex: _handleVisibleGroupIndex,
        ),
        if (widget.groups.length > 1) Divider(height: styles.Measurements.m),
        if (widget.groups.length > 1)
          HorizontalGroupNavigationIndicator(
            primaryColor: styles.Colors.primary,
            count: widget.groups.length,
            activeIndex: _visibleGroupIndex,
          )
      ],
    );
  }
}
