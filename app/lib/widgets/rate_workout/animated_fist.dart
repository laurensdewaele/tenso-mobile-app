import 'package:flutter/cupertino.dart';

class AnimatedFist extends StatefulWidget {
  AnimatedFist({Key key}) : super(key: key);

  @override
  _AnimatedFistState createState() => _AnimatedFistState();
}

class _AnimatedFistState extends State<AnimatedFist>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1400));
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: Tween(begin: 0.0, end: 3.0)
          .chain(CurveTween(curve: Curves.easeOut))
          .animate(_animationController),
      child: Center(
        child: ScaleTransition(
          scale: _animationController,
          child: Image.asset(
            'assets/images/fist.png',
          ),
        ),
      ),
    );
  }
}
