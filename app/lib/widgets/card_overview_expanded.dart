import 'package:flutter/cupertino.dart';

import 'package:app/widgets/card.dart';

class CardOverviewExpanded extends StatelessWidget {
  const CardOverviewExpanded({this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Card(child: Text('$title, expanded'));
  }
}
