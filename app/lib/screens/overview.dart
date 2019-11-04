import 'package:flutter/material.dart' hide Colors;

import 'package:app/styles/styles.dart';
import 'package:app/widgets/screen.dart';

class OverviewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Screen(
        gradientStartColor: Colors.bgGrayStart,
        gradientStopColor: Colors.bgGrayStop,
        child: Text('Hello'));
  }
}
