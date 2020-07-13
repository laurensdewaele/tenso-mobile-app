import 'package:app/services/keyboard.service.dart';
import 'package:app/widgets/toast_provider.dart';
import 'package:flutter/cupertino.dart' hide Icon;

class KeyboardAndToastProvider extends StatelessWidget {
  KeyboardAndToastProvider({Key key, @required this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final KeyboardService _keyboardService = KeyboardService();
    final double keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
    final double deviceHeight = MediaQuery.of(context).size.height;
    _keyboardService.setDeviceHeight(deviceHeight, keyboardHeight);

    return GestureDetector(
        onTap: _keyboardService.handleScreenTap,
        child: ToastProvider(child: child));
  }
}
