import 'package:flutter/cupertino.dart';

class Divider extends StatelessWidget {
  Divider({Key key, this.height, this.width}) : super(key: key);

  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: height, width: width);
  }
}
