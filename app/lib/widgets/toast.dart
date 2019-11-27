import 'dart:async';

import 'package:flutter/cupertino.dart';

import 'package:app/styles/styles.dart' as styles;

class Toast extends StatefulWidget {
  Toast({this.messageStream});

  final Stream<Widget> messageStream;

  @override
  _ToastState createState() => _ToastState();
}

class _ToastState extends State<Toast> with SingleTickerProviderStateMixin {
  StreamSubscription _subscription;

  List<Widget> messages = [];

  @override
  void initState() {
    super.initState();
    _subscription = widget.messageStream.listen((Widget message) {
      setState(() {
        messages.add(message);
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _subscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Stack(children: [
      ...messages.map((message) => _ToastUI(message: message))
    ]);
  }
}

class _ToastUI extends StatefulWidget {
  _ToastUI({this.message});

  final Widget message;

  @override
  _ToastUIState createState() => _ToastUIState();
}

class _ToastUIState extends State<_ToastUI>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  final Animatable<Offset> _offSetTween =
      Tween<Offset>(begin: Offset(0, -1), end: Offset(0.0, 0.0))
          .chain(CurveTween(curve: Curves.easeIn));

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200));
    _openClose();
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  void _openClose() {
    _animationController.forward().then((_) async {
      await Future.delayed(Duration(milliseconds: 3000));
      _animationController.reverse();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _animationController.drive(_offSetTween),
      child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: styles.Colors.bgWhite,
            borderRadius: BorderRadius.only(
                bottomLeft: styles.kAppBorderRadius,
                bottomRight: styles.kAppBorderRadius),
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              stops: [0.0005, 0.005],
              colors: [styles.Colors.bgGrayStop, styles.Colors.bgWhite],
            ),
          ),
          padding: EdgeInsets.symmetric(
              vertical: styles.Measurements.m,
              horizontal: styles.Measurements.m * 2),
          child: SafeArea(child: widget.message)),
    );
  }
}
