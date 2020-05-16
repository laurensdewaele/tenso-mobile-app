import 'package:flutter/cupertino.dart';

class Screen extends StatefulWidget {
  const Screen(
      {@required this.gradientStartColor,
      @required this.gradientStopColor,
      @required this.child,
      this.handleBackNavigation,
      this.handleForwardNavigation,
      this.padding});

  final Color gradientStartColor;
  final Color gradientStopColor;
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
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [widget.gradientStartColor, widget.gradientStopColor]),
        ),
        child: SafeArea(
            child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [widget.gradientStartColor, widget.gradientStopColor]),
          ),
          padding: widget.padding,
          child: widget.child,
        )),
      ),
    );
  }
}
