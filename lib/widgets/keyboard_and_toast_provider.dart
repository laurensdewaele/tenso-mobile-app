import 'package:flutter/cupertino.dart' hide Icon;
import 'package:tenso_app/services/keyboard.service.dart';
import 'package:tenso_app/widgets/toast_provider.dart';

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
