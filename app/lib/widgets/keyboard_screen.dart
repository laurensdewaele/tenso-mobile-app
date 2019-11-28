import 'package:flutter/cupertino.dart';

import 'package:app/styles/styles.dart' as styles;
import 'package:app/widgets/screen.dart';

// Notifies the parent to move the screen up with an Offset when the native keyboard overlaps.
// Only when the input field is out of sight.
// Therefore we need to know the tap position of the input field.
// We have a Listener that wraps around our input field.
// We know that once an input field is tapped, the keyboard is shown.
// The Listener forwards that tap information to our KeyBoardScreen class
// via an onTap callback that we provide via Context.
class KeyBoardScreen extends StatefulWidget {
  const KeyBoardScreen(
      {@required this.gradientStartColor,
      @required this.gradientStopColor,
      @required this.handleKeyboardOffset,
      @required this.child});

  final Color gradientStartColor;
  final Color gradientStopColor;
  final Widget child;
  final Function(Offset offset) handleKeyboardOffset;

  static KeyboardScreenCallbackProvider of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(KeyboardScreenCallbackProvider)
        as KeyboardScreenCallbackProvider);
  }

  @override
  _KeyBoardScreenState createState() => _KeyBoardScreenState();
}

class _KeyBoardScreenState extends State<KeyBoardScreen> {
  double _keyboardHeight = 0;
  double _screenHeight = 0;

  void _handlePointerDown(Offset tapPosition) {
    final double cutoffHeight = _screenHeight - _keyboardHeight;
    final double idealCutoffHeight = cutoffHeight - styles.Measurements.xxl;

    if (tapPosition.dy > idealCutoffHeight) {
      final double offset = tapPosition.dy - idealCutoffHeight;
      widget.handleKeyboardOffset(Offset(0.0, offset));
    }
  }

  void _setDeviceHeight(double sizeHeight, double viewInsetBottom) {
    if (_screenHeight != sizeHeight && sizeHeight > 0) {
      setState(() {
        _screenHeight = sizeHeight;
      });
    }

    if (_keyboardHeight != viewInsetBottom && viewInsetBottom > 0) {
      setState(() {
        _keyboardHeight = viewInsetBottom;
      });
    }
  }

  void _resetKeyboardOffset() {
    widget.handleKeyboardOffset(Offset.zero);
  }

  @override
  Widget build(BuildContext context) {
    final double viewInsetBottom = MediaQuery.of(context).viewInsets.bottom;
    final double sizeHeight = MediaQuery.of(context).size.height;
    _setDeviceHeight(sizeHeight, viewInsetBottom);
    return KeyboardScreenCallbackProvider(
      handlePointerDown: _handlePointerDown,
      resetKeyboardOffset: _resetKeyboardOffset,
      child: Screen(
          gradientStartColor: widget.gradientStartColor,
          gradientStopColor: widget.gradientStopColor,
          child: widget.child),
    );
  }
}

class KeyboardScreenCallbackProvider extends InheritedWidget {
  KeyboardScreenCallbackProvider({
    Key key,
    @required this.handlePointerDown,
    @required this.resetKeyboardOffset,
    @required Widget child,
  }) : super(key: key, child: child);

  final Function(Offset) handlePointerDown;
  final VoidCallback resetKeyboardOffset;

  @override
  bool updateShouldNotify(KeyboardScreenCallbackProvider old) => false;
}
