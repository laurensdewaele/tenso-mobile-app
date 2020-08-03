import 'package:flutter/cupertino.dart';
import 'package:tenso_app/services/keyboard.service.dart';

class KeyboardProvider extends StatelessWidget {
  KeyboardProvider({Key key, @required this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final KeyboardService _keyboardService = KeyboardService();
    final double keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
    final double deviceHeight = MediaQuery.of(context).size.height;
    _keyboardService.setDeviceHeight(deviceHeight, keyboardHeight);

    return GestureDetector(
      onTap: _keyboardService.handleScreenTap,
      child: child,
    );
  }
}
