import 'package:flutter/cupertino.dart';

import 'package:app/widgets/card.dart';

class CardOverview extends StatefulWidget {
  const CardOverview({Key key}) : super(key: key);

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

  @override
  Widget build(BuildContext context) {
    return Card(
        child: collapsed ? _CardOverviewCollapsed() : _CardOverviewExpanded());
  }
}

class _CardOverviewCollapsed extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text('Collapsed');
  }
}

class _CardOverviewExpanded extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text('Collapsed');
  }
}
