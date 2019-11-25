import 'package:flutter/cupertino.dart';

class Divider extends StatelessWidget {
  Divider({this.height});

  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: height);
  }
}
