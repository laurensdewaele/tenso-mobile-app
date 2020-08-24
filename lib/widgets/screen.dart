import 'package:flutter/cupertino.dart';
import 'package:tenso_app/styles/styles.dart' as styles;

class Screen extends StatefulWidget {
  const Screen(
      {this.backgroundColor = styles.Colors.bgGray,
      @required this.child,
      this.handleBackNavigation,
      this.padding});

  final Color backgroundColor;
  final Widget child;
  final EdgeInsets padding;
  final VoidCallback handleBackNavigation;

  @override
  _ScreenState createState() => _ScreenState();
}

class _ScreenState extends State<Screen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _onHorizontalDragEnd(DragEndDetails details) {
    if (details.primaryVelocity > 0 && widget.handleBackNavigation != null) {
      widget.handleBackNavigation();
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
