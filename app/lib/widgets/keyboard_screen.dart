import 'package:flutter/cupertino.dart';

import 'package:app/widgets/screen.dart';

class KeyBoardScreen extends StatefulWidget {
  const KeyBoardScreen(
      {@required this.gradientStartColor,
      @required this.gradientStopColor,
      @required this.child});

  final Color gradientStartColor;
  final Color gradientStopColor;
  final Widget child;

  @override
  _KeyBoardScreenState createState() => _KeyBoardScreenState();
}

class _KeyBoardScreenState extends State<KeyBoardScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  void _onTapUp(TapUpDetails details) {
    // determine height of the keyboard

    // determine the y of the click

    // if the y click > total screen height - keyboardheight - standard margin
    // => move it up

    // Calculate differce of click y and (height - keyboardheight - standard margin)
    // Calculate what offset that translates to
    // offset the screen with an animation
    // provide methods in the context in order for children to call that it must animate back

  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapUp: _onTapUp,
      child: Screen(
          gradientStartColor: widget.gradientStartColor,
          gradientStopColor: widget.gradientStopColor,
          child: widget.child),
    );
  }
}
