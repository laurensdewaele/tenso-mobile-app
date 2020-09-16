import 'package:flutter/cupertino.dart';
import 'package:tenso_app/widgets/button.dart';

class OKButton extends StatelessWidget {
  OKButton({Key key, @required this.handleTap}) : super(key: key);

  final VoidCallback handleTap;

  @override
  Widget build(BuildContext context) {
    return Button(
        small: true,
        displayBackground: false,
        text: 'Ok',
        handleTap: handleTap);
  }
}
