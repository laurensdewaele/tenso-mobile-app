import 'package:app/widgets/card_overview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';

import 'package:app/styles/styles.dart';
import 'package:app/widgets/screen.dart';

class OverviewScreen extends StatelessWidget {
  VoidCallback _onPressed(context) {
    return () {
      Navigator.pushNamed(context, '/workout');
    };
  }

  @override
  Widget build(BuildContext context) {
    return Screen(
        gradientStartColor: AppColors.bgGrayStart,
        gradientStopColor: AppColors.bgGrayStop,
        child: Column(
          children: <Widget>[
            Text('Kekked', textDirection: TextDirection.ltr),
            CupertinoButton(
                onPressed: _onPressed(context), child: Text('click me')),
            CardOverview()
          ],
        ));
  }
}
