import 'package:flutter/cupertino.dart';

import 'package:app/widgets/card.dart';

class CardOverview extends StatefulWidget {
  CardOverview({Key key, this.collapsedChild, this.expandedChild})
      : super(key: key);

  final Widget collapsedChild;
  final Widget expandedChild;

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
    return collapsed ? widget.collapsedChild : widget.expandedChild;
  }
}
