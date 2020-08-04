import 'package:flutter/cupertino.dart';
import 'package:tenso_app/styles/styles.dart' as styles;

class Screen extends StatefulWidget {
  const Screen(
      {this.backgroundColor = styles.Colors.bgGray,
      @required this.child,
      this.handleBackNavigation,
      this.handleForwardNavigation,
      this.padding});

  final Color backgroundColor;
  final Widget child;
  final EdgeInsets padding;
  final VoidCallback handleBackNavigation;
  final VoidCallback handleForwardNavigation;

  @override
  _ScreenState createState() => _ScreenState();
}

class _ScreenState extends State<Screen> {
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

  void _onHorizontalDragEnd(DragEndDetails details) {
    if (details.primaryVelocity > 0 && widget.handleBackNavigation != null) {
      widget.handleBackNavigation();
    }

    if (details.primaryVelocity < 0 && widget.handleForwardNavigation != null) {
      widget.handleForwardNavigation();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragEnd: _onHorizontalDragEnd,
      child: Container(
        decoration: BoxDecoration(
          color: widget.backgroundColor,
        ),
        child: SafeArea(
            maintainBottomViewPadding: true,
            child: Container(
              decoration: BoxDecoration(
                color: widget.backgroundColor,
              ),
              padding: widget.padding,
              child: widget.child,
            )),
      ),
    );
  }
}
