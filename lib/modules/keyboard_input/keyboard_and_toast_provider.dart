import 'package:flutter/cupertino.dart' hide Icon;
import 'package:tenso_app/modules/keyboard_input/keyboard_provider.dart';
import 'package:tenso_app/modules/toast/toast_provider.dart';

class KeyboardAndToastProvider extends StatelessWidget {
  KeyboardAndToastProvider({Key key, @required this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return KeyboardProvider(child: ToastProvider(child: child));
  }
}
