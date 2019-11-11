import 'package:flutter/cupertino.dart';

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

  void handleCollapsedState() {
    setState(() {
      collapsed = !collapsed;
    });
  }

  @override
  Widget build(BuildContext context) {
    return collapsed ? widget.collapsedChild : widget.expandedChild;
  }
}
