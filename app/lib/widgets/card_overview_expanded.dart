import 'package:flutter/cupertino.dart';

class CardOverviewExpanded extends StatelessWidget {
  const CardOverviewExpanded({this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text('$title');
  }
}
