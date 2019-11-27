import 'package:flutter/cupertino.dart';

class Divider extends StatelessWidget {
  Divider({this.height, this.width});

  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: height, width: width);
  }
}
